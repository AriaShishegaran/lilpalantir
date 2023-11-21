A Guide to Extracting Terms and Definitions[](#a-guide-to-extracting-terms-and-definitions "Permalink to this heading")
========================================================================================================================

Llama Index has many use cases (semantic search, summarization, etc.) that are well documented. However, this doesn’t mean we can’t apply Llama Index to very specific use cases!

In this tutorial, we will go through the design process of using Llama Index to extract terms and definitions from text, while allowing users to query those terms later. Using [Streamlit](https://streamlit.io/), we can provide an easy way to build frontend for running and testing all of this, and quickly iterate with our design.

This tutorial assumes you have Python3.9+ and the following packages installed:

* llama-index
* streamlit

At the base level, our objective is to take text from a document, extract terms and definitions, and then provide a way for users to query that knowledge base of terms and definitions. The tutorial will go over features from both Llama Index and Streamlit, and hopefully provide some interesting solutions for common problems that come up.

The final version of this tutorial can be found [here](https://github.com/logan-markewich/llama_index_starter_pack) and a live hosted demo is available on [Huggingface Spaces](https://huggingface.co/spaces/llamaindex/llama_index_term_definition_demo).

Uploading Text[](#uploading-text "Permalink to this heading")
--------------------------------------------------------------

Step one is giving users a way to upload documents. Let’s write some code using Streamlit to provide the interface for this! Use the following code and launch the app with `streamlit run app.py`.


```
import streamlit as stst.title("🦙 Llama Index Term Extractor 🦙")document\_text = st.text\_area("Or enter raw text")if st.button("Extract Terms and Definitions") and document\_text:    with st.spinner("Extracting..."):        extracted\_terms = document\_text  # this is a placeholder!    st.write(extracted\_terms)
```
Super simple right! But you’ll notice that the app doesn’t do anything useful yet. To use llama\_index, we also need to setup our OpenAI LLM. There are a bunch of possible settings for the LLM, so we can let the user figure out what’s best. We should also let the user set the prompt that will extract the terms (which will also help us debug what works best).

LLM Settings[](#llm-settings "Permalink to this heading")
----------------------------------------------------------

This next step introduces some tabs to our app, to separate it into different panes that provide different features. Let’s create a tab for LLM settings and for uploading text:


```
import osimport streamlit as stDEFAULT\_TERM\_STR = (    "Make a list of terms and definitions that are defined in the context, "    "with one pair on each line. "    "If a term is missing it's definition, use your best judgment. "    "Write each line as as follows:\nTerm: <term> Definition: <definition>")st.title("🦙 Llama Index Term Extractor 🦙")setup\_tab, upload\_tab = st.tabs(["Setup", "Upload/Extract Terms"])with setup\_tab:    st.subheader("LLM Setup")    api\_key = st.text\_input("Enter your OpenAI API key here", type="password")    llm\_name = st.selectbox(        "Which LLM?", ["text-davinci-003", "gpt-3.5-turbo", "gpt-4"]    )    model\_temperature = st.slider(        "LLM Temperature", min\_value=0.0, max\_value=1.0, step=0.1    )    term\_extract\_str = st.text\_area(        "The query to extract terms and definitions with.",        value=DEFAULT\_TERM\_STR,    )with upload\_tab:    st.subheader("Extract and Query Definitions")    document\_text = st.text\_area("Or enter raw text")    if st.button("Extract Terms and Definitions") and document\_text:        with st.spinner("Extracting..."):            extracted\_terms = document\_text  # this is a placeholder!        st.write(extracted\_terms)
```
Now our app has two tabs, which really helps with the organization. You’ll also noticed I added a default prompt to extract terms – you can change this later once you try extracting some terms, it’s just the prompt I arrived at after experimenting a bit.

Speaking of extracting terms, it’s time to add some functions to do just that!

Extracting and Storing Terms[](#extracting-and-storing-terms "Permalink to this heading")
------------------------------------------------------------------------------------------

Now that we are able to define LLM settings and upload text, we can try using Llama Index to extract the terms from text for us!

We can add the following functions to both initialize our LLM, as well as use it to extract terms from the input text.


```
from llama\_index import (    Document,    SummaryIndex,    LLMPredictor,    ServiceContext,    load\_index\_from\_storage,)from llama\_index.llms import OpenAIdef get\_llm(llm\_name, model\_temperature, api\_key, max\_tokens=256):    os.environ["OPENAI\_API\_KEY"] = api\_key    return OpenAI(        temperature=model\_temperature, model=llm\_name, max\_tokens=max\_tokens    )def extract\_terms(    documents, term\_extract\_str, llm\_name, model\_temperature, api\_key):    llm = get\_llm(llm\_name, model\_temperature, api\_key, max\_tokens=1024)    service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=1024)    temp\_index = SummaryIndex.from\_documents(        documents, service\_context=service\_context    )    query\_engine = temp\_index.as\_query\_engine(response\_mode="tree\_summarize")    terms\_definitions = str(query\_engine.query(term\_extract\_str))    terms\_definitions = [        x        for x in terms\_definitions.split("\n")        if x and "Term:" in x and "Definition:" in x    ]    # parse the text into a dict    terms\_to\_definition = {        x.split("Definition:")[0]        .split("Term:")[-1]        .strip(): x.split("Definition:")[-1]        .strip()        for x in terms\_definitions    }    return terms\_to\_definition
```
Now, using the new functions, we can finally extract our terms!


```
...with upload\_tab:    st.subheader("Extract and Query Definitions")    document\_text = st.text\_area("Or enter raw text")    if st.button("Extract Terms and Definitions") and document\_text:        with st.spinner("Extracting..."):            extracted\_terms = extract\_terms(                [Document(text=document\_text)],                term\_extract\_str,                llm\_name,                model\_temperature,                api\_key,            )        st.write(extracted\_terms)
```
There’s a lot going on now, let’s take a moment to go over what is happening.

`get\_llm()` is instantiating the LLM based on the user configuration from the setup tab. Based on the model name, we need to use the appropriate class (`OpenAI` vs. `ChatOpenAI`).

`extract\_terms()` is where all the good stuff happens. First, we call `get\_llm()` with `max\_tokens=1024`, since we don’t want to limit the model too much when it is extracting our terms and definitions (the default is 256 if not set). Then, we define our `ServiceContext` object, aligning `num\_output` with our `max\_tokens` value, as well as setting the chunk size to be no larger than the output. When documents are indexed by Llama Index, they are broken into chunks (also called nodes) if they are large, and `chunk\_size` sets the size for these chunks.

Next, we create a temporary summary index and pass in our service context. A summary index will read every single piece of text in our index, which is perfect for extracting terms. Finally, we use our pre-defined query text to extract terms, using `response\_mode="tree\_summarize`. This response mode will generate a tree of summaries from the bottom up, where each parent summarizes its children. Finally, the top of the tree is returned, which will contain all our extracted terms and definitions.

Lastly, we do some minor post processing. We assume the model followed instructions and put a term/definition pair on each line. If a line is missing the `Term:` or `Definition:` labels, we skip it. Then, we convert this to a dictionary for easy storage!

Saving Extracted Terms[](#saving-extracted-terms "Permalink to this heading")
------------------------------------------------------------------------------

Now that we can extract terms, we need to put them somewhere so that we can query for them later. A `VectorStoreIndex` should be a perfect choice for now! But in addition, our app should also keep track of which terms are inserted into the index so that we can inspect them later. Using `st.session\_state`, we can store the current list of terms in a session dict, unique to each user!

First things first though, let’s add a feature to initialize a global vector index and another function to insert the extracted terms.


```
...if "all\_terms" not in st.session\_state:    st.session\_state["all\_terms"] = DEFAULT\_TERMS...def insert\_terms(terms\_to\_definition):    for term, definition in terms\_to\_definition.items():        doc = Document(text=f"Term: {term}\nDefinition: {definition}")        st.session\_state["llama\_index"].insert(doc)@st.cache\_resourcedef initialize\_index(llm\_name, model\_temperature, api\_key): """Create the VectorStoreIndex object."""    llm = get\_llm(llm\_name, model\_temperature, api\_key)    service\_context = ServiceContext.from\_defaults(llm=llm)    index = VectorStoreIndex([], service\_context=service\_context)    return index...with upload\_tab:    st.subheader("Extract and Query Definitions")    if st.button("Initialize Index and Reset Terms"):        st.session\_state["llama\_index"] = initialize\_index(            llm\_name, model\_temperature, api\_key        )        st.session\_state["all\_terms"] = {}    if "llama\_index" in st.session\_state:        st.markdown(            "Either upload an image/screenshot of a document, or enter the text manually."        )        document\_text = st.text\_area("Or enter raw text")        if st.button("Extract Terms and Definitions") and (            uploaded\_file or document\_text        ):            st.session\_state["terms"] = {}            terms\_docs = {}            with st.spinner("Extracting..."):                terms\_docs.update(                    extract\_terms(                        [Document(text=document\_text)],                        term\_extract\_str,                        llm\_name,                        model\_temperature,                        api\_key,                    )                )            st.session\_state["terms"].update(terms\_docs)        if "terms" in st.session\_state and st.session\_state["terms"]:            st.markdown("Extracted terms")            st.json(st.session\_state["terms"])            if st.button("Insert terms?"):                with st.spinner("Inserting terms"):                    insert\_terms(st.session\_state["terms"])                st.session\_state["all\_terms"].update(st.session\_state["terms"])                st.session\_state["terms"] = {}                st.experimental\_rerun()
```
Now you are really starting to leverage the power of streamlit! Let’s start with the code under the upload tab. We added a button to initialize the vector index, and we store it in the global streamlit state dictionary, as well as resetting the currently extracted terms. Then, after extracting terms from the input text, we store it the extracted terms in the global state again and give the user a chance to review them before inserting. If the insert button is pressed, then we call our insert terms function, update our global tracking of inserted terms, and remove the most recently extracted terms from the session state.

Querying for Extracted Terms/Definitions[](#querying-for-extracted-terms-definitions "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

With the terms and definitions extracted and saved, how can we use them? And how will the user even remember what’s previously been saved?? We can simply add some more tabs to the app to handle these features.


```
...setup\_tab, terms\_tab, upload\_tab, query\_tab = st.tabs(    ["Setup", "All Terms", "Upload/Extract Terms", "Query Terms"])...with terms\_tab:    with terms\_tab:        st.subheader("Current Extracted Terms and Definitions")        st.json(st.session\_state["all\_terms"])...with query\_tab:    st.subheader("Query for Terms/Definitions!")    st.markdown(        (            "The LLM will attempt to answer your query, and augment it's answers using the terms/definitions you've inserted. "            "If a term is not in the index, it will answer using it's internal knowledge."        )    )    if st.button("Initialize Index and Reset Terms", key="init\_index\_2"):        st.session\_state["llama\_index"] = initialize\_index(            llm\_name, model\_temperature, api\_key        )        st.session\_state["all\_terms"] = {}    if "llama\_index" in st.session\_state:        query\_text = st.text\_input("Ask about a term or definition:")        if query\_text:            query\_text = (                query\_text                + "\nIf you can't find the answer, answer the query with the best of your knowledge."            )            with st.spinner("Generating answer..."):                response = st.session\_state["llama\_index"].query(                    query\_text, similarity\_top\_k=5, response\_mode="compact"                )            st.markdown(str(response))
```
While this is mostly basic, some important things to note:

* Our initialize button has the same text as our other button. Streamlit will complain about this, so we provide a unique key instead.
* Some additional text has been added to the query! This is to try and compensate for times when the index does not have the answer.
* In our index query, we’ve specified two options:


	+ `similarity\_top\_k=5` means the index will fetch the top 5 closest matching terms/definitions to the query.
	+ `response\_mode="compact"` means as much text as possible from the 5 matching terms/definitions will be used in each LLM call. Without this, the index would make at least 5 calls to the LLM, which can slow things down for the user.
Dry Run Test[](#dry-run-test "Permalink to this heading")
----------------------------------------------------------

Well, actually I hope you’ve been testing as we went. But now, let’s try one complete test.

1. Refresh the app
2. Enter your LLM settings
3. Head over to the query tab
4. Ask the following: `What is a bunnyhug?`
5. The app should give some nonsense response. If you didn’t know, a bunnyhug is another word for a hoodie, used by people from the Canadian Prairies!
6. Let’s add this definition to the app. Open the upload tab and enter the following text: `A bunnyhug is a common term used to describe a hoodie. This term is used by people from the Canadian Prairies.`
7. Click the extract button. After a few moments, the app should display the correctly extracted term/definition. Click the insert term button to save it!
8. If we open the terms tab, the term and definition we just extracted should be displayed
9. Go back to the query tab and try asking what a bunnyhug is. Now, the answer should be correct!
Improvement #1 - Create a Starting Index[](#improvement-1-create-a-starting-index "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------

With our base app working, it might feel like a lot of work to build up a useful index. What if we gave the user some kind of starting point to show off the app’s query capabilities? We can do just that! First, let’s make a small change to our app so that we save the index to disk after every upload:


```
def insert\_terms(terms\_to\_definition):    for term, definition in terms\_to\_definition.items():        doc = Document(text=f"Term: {term}\nDefinition: {definition}")        st.session\_state["llama\_index"].insert(doc)    # TEMPORARY - save to disk    st.session\_state["llama\_index"].storage\_context.persist()
```
Now, we need some document to extract from! The repository for this project used the wikipedia page on New York City, and you can find the text [here](https://github.com/jerryjliu/llama_index/blob/main/examples/test_wiki/data/nyc_text.txt).

If you paste the text into the upload tab and run it (it may take some time), we can insert the extracted terms. Make sure to also copy the text for the extracted terms into a notepad or similar before inserting into the index! We will need them in a second.

After inserting, remove the line of code we used to save the index to disk. With a starting index now saved, we can modify our `initialize\_index` function to look like this:


```
@st.cache\_resourcedef initialize\_index(llm\_name, model\_temperature, api\_key): """Load the Index object."""    llm = get\_llm(llm\_name, model\_temperature, api\_key)    service\_context = ServiceContext.from\_defaults(llm=llm)    index = load\_index\_from\_storage(service\_context=service\_context)    return index
```
Did you remember to save that giant list of extracted terms in a notepad? Now when our app initializes, we want to pass in the default terms that are in the index to our global terms state:


```
...if "all\_terms" not in st.session\_state:    st.session\_state["all\_terms"] = DEFAULT\_TERMS...
```
Repeat the above anywhere where we were previously resetting the `all\_terms` values.

Improvement #2 - (Refining) Better Prompts[](#improvement-2-refining-better-prompts "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------

If you play around with the app a bit now, you might notice that it stopped following our prompt! Remember, we added to our `query\_str` variable that if the term/definition could not be found, answer to the best of its knowledge. But now if you try asking about random terms (like bunnyhug!), it may or may not follow those instructions.

This is due to the concept of “refining” answers in Llama Index. Since we are querying across the top 5 matching results, sometimes all the results do not fit in a single prompt! OpenAI models typically have a max input size of 4097 tokens. So, Llama Index accounts for this by breaking up the matching results into chunks that will fit into the prompt. After Llama Index gets an initial answer from the first API call, it sends the next chunk to the API, along with the previous answer, and asks the model to refine that answer.

So, the refine process seems to be messing with our results! Rather than appending extra instructions to the `query\_str`, remove that, and Llama Index will let us provide our own custom prompts! Let’s create those now, using the [default prompts](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/default_prompts.py) and [chat specific prompts](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/chat_prompts.py) as a guide. Using a new file `constants.py`, let’s create some new query templates:


```
from llama\_index.prompts import (    PromptTemplate,    SelectorPromptTemplate,    ChatPromptTemplate,)from llama\_index.prompts.utils import is\_chat\_modelfrom llama\_index.llms.base import ChatMessage, MessageRole# Text QA templatesDEFAULT\_TEXT\_QA\_PROMPT\_TMPL = (    "Context information is below. \n"    "---------------------\n"    "{context\_str}"    "\n---------------------\n"    "Given the context information answer the following question "    "(if you don't know the answer, use the best of your knowledge): {query\_str}\n")TEXT\_QA\_TEMPLATE = PromptTemplate(DEFAULT\_TEXT\_QA\_PROMPT\_TMPL)# Refine templatesDEFAULT\_REFINE\_PROMPT\_TMPL = (    "The original question is as follows: {query\_str}\n"    "We have provided an existing answer: {existing\_answer}\n"    "We have the opportunity to refine the existing answer "    "(only if needed) with some more context below.\n"    "------------\n"    "{context\_msg}\n"    "------------\n"    "Given the new context and using the best of your knowledge, improve the existing answer. "    "If you can't improve the existing answer, just repeat it again.")DEFAULT\_REFINE\_PROMPT = PromptTemplate(DEFAULT\_REFINE\_PROMPT\_TMPL)CHAT\_REFINE\_PROMPT\_TMPL\_MSGS = [    ChatMessage(content="{query\_str}", role=MessageRole.USER),    ChatMessage(content="{existing\_answer}", role=MessageRole.ASSISTANT),    ChatMessage(        content="We have the opportunity to refine the above answer "        "(only if needed) with some more context below.\n"        "------------\n"        "{context\_msg}\n"        "------------\n"        "Given the new context and using the best of your knowledge, improve the existing answer. "        "If you can't improve the existing answer, just repeat it again.",        role=MessageRole.USER,    ),]CHAT\_REFINE\_PROMPT = ChatPromptTemplate(CHAT\_REFINE\_PROMPT\_TMPL\_MSGS)# refine prompt selectorREFINE\_TEMPLATE = SelectorPromptTemplate(    default\_template=DEFAULT\_REFINE\_PROMPT,    conditionals=[(is\_chat\_model, CHAT\_REFINE\_PROMPT)],)
```
That seems like a lot of code, but it’s not too bad! If you looked at the default prompts, you might have noticed that there are default prompts, and prompts specific to chat models. Continuing that trend, we do the same for our custom prompts. Then, using a prompt selector, we can combine both prompts into a single object. If the LLM being used is a chat model (ChatGPT, GPT-4), then the chat prompts are used. Otherwise, use the normal prompt templates.

Another thing to note is that we only defined one QA template. In a chat model, this will be converted to a single “human” message.

So, now we can import these prompts into our app and use them during the query.


```
from constants import REFINE\_TEMPLATE, TEXT\_QA\_TEMPLATE...if "llama\_index" in st.session\_state:    query\_text = st.text\_input("Ask about a term or definition:")    if query\_text:        query\_text = query\_text  # Notice we removed the old instructions        with st.spinner("Generating answer..."):            response = st.session\_state["llama\_index"].query(                query\_text,                similarity\_top\_k=5,                response\_mode="compact",                text\_qa\_template=TEXT\_QA\_TEMPLATE,                refine\_template=REFINE\_TEMPLATE,            )        st.markdown(str(response))...
```
If you experiment a bit more with queries, hopefully you notice that the responses follow our instructions a little better now!

Improvement #3 - Image Support[](#improvement-3-image-support "Permalink to this heading")
-------------------------------------------------------------------------------------------

Llama index also supports images! Using Llama Index, we can upload images of documents (papers, letters, etc.), and Llama Index handles extracting the text. We can leverage this to also allow users to upload images of their documents and extract terms and definitions from them.

If you get an import error about PIL, install it using `pip install Pillow` first.


```
from PIL import Imagefrom llama\_index.readers.file.base import DEFAULT\_FILE\_EXTRACTOR, ImageParser@st.cache\_resourcedef get\_file\_extractor():    image\_parser = ImageParser(keep\_image=True, parse\_text=True)    file\_extractor = DEFAULT\_FILE\_EXTRACTOR    file\_extractor.update(        {            ".jpg": image\_parser,            ".png": image\_parser,            ".jpeg": image\_parser,        }    )    return file\_extractorfile\_extractor = get\_file\_extractor()...with upload\_tab:    st.subheader("Extract and Query Definitions")    if st.button("Initialize Index and Reset Terms", key="init\_index\_1"):        st.session\_state["llama\_index"] = initialize\_index(            llm\_name, model\_temperature, api\_key        )        st.session\_state["all\_terms"] = DEFAULT\_TERMS    if "llama\_index" in st.session\_state:        st.markdown(            "Either upload an image/screenshot of a document, or enter the text manually."        )        uploaded\_file = st.file\_uploader(            "Upload an image/screenshot of a document:",            type=["png", "jpg", "jpeg"],        )        document\_text = st.text\_area("Or enter raw text")        if st.button("Extract Terms and Definitions") and (            uploaded\_file or document\_text        ):            st.session\_state["terms"] = {}            terms\_docs = {}            with st.spinner("Extracting (images may be slow)..."):                if document\_text:                    terms\_docs.update(                        extract\_terms(                            [Document(text=document\_text)],                            term\_extract\_str,                            llm\_name,                            model\_temperature,                            api\_key,                        )                    )                if uploaded\_file:                    Image.open(uploaded\_file).convert("RGB").save("temp.png")                    img\_reader = SimpleDirectoryReader(                        input\_files=["temp.png"], file\_extractor=file\_extractor                    )                    img\_docs = img\_reader.load\_data()                    os.remove("temp.png")                    terms\_docs.update(                        extract\_terms(                            img\_docs,                            term\_extract\_str,                            llm\_name,                            model\_temperature,                            api\_key,                        )                    )            st.session\_state["terms"].update(terms\_docs)        if "terms" in st.session\_state and st.session\_state["terms"]:            st.markdown("Extracted terms")            st.json(st.session\_state["terms"])            if st.button("Insert terms?"):                with st.spinner("Inserting terms"):                    insert\_terms(st.session\_state["terms"])                st.session\_state["all\_terms"].update(st.session\_state["terms"])                st.session\_state["terms"] = {}                st.experimental\_rerun()
```
Here, we added the option to upload a file using Streamlit. Then the image is opened and saved to disk (this seems hacky but it keeps things simple). Then we pass the image path to the reader, extract the documents/text, and remove our temp image file.

Now that we have the documents, we can call `extract\_terms()` the same as before.

Conclusion/TLDR[](#conclusion-tldr "Permalink to this heading")
----------------------------------------------------------------

In this tutorial, we covered a ton of information, while solving some common issues and problems along the way:

* Using different indexes for different use cases (List vs. Vector index)
* Storing global state values with Streamlit’s `session\_state` concept
* Customizing internal prompts with Llama Index
* Reading text from images with Llama Index

The final version of this tutorial can be found [here](https://github.com/logan-markewich/llama_index_starter_pack) and a live hosted demo is available on [Huggingface Spaces](https://huggingface.co/spaces/llamaindex/llama_index_term_definition_demo).

