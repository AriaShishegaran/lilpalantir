[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/customization/prompts/chat_prompts.ipynb)

Chat Prompts Customization[](#chat-prompts-customization "Permalink to this heading")
======================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Prompt Setup[](#prompt-setup "Permalink to this heading")
----------------------------------------------------------

Below, we take the default prompts and customize them to always answer, even if the context is not helpful.


```
from llama\_index.llms import ChatMessage, MessageRolefrom llama\_index.prompts import ChatPromptTemplate# Text QA Promptchat\_text\_qa\_msgs = [    ChatMessage(        role=MessageRole.SYSTEM,        content=(            "Always answer the question, even if the context isn't helpful."        ),    ),    ChatMessage(        role=MessageRole.USER,        content=(            "Context information is below.\n"            "---------------------\n"            "{context\_str}\n"            "---------------------\n"            "Given the context information and not prior knowledge, "            "answer the question: {query\_str}\n"        ),    ),]text\_qa\_template = ChatPromptTemplate(chat\_text\_qa\_msgs)# Refine Promptchat\_refine\_msgs = [    ChatMessage(        role=MessageRole.SYSTEM,        content=(            "Always answer the question, even if the context isn't helpful."        ),    ),    ChatMessage(        role=MessageRole.USER,        content=(            "We have the opportunity to refine the original answer "            "(only if needed) with some more context below.\n"            "------------\n"            "{context\_msg}\n"            "------------\n"            "Given the new context, refine the original answer to better "            "answer the question: {query\_str}. "            "If the context isn't useful, output the original answer again.\n"            "Original Answer: {existing\_answer}"        ),    ),]refine\_template = ChatPromptTemplate(chat\_refine\_msgs)
```
Using the Prompts[](#using-the-prompts "Permalink to this heading")
--------------------------------------------------------------------

Now, we use the prompts in an index query!


```
import openaiimport osos.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import OpenAIdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()# Create an index using a chat model, so that we can use the chat prompts!service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.1))index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
### Before Adding Templates[](#before-adding-templates "Permalink to this heading")


```
print(index.as\_query\_engine().query("Who is Joe Biden?"))
```

```
I'm sorry, but the given context does not provide any information about Joe Biden.
```
### After Adding Templates[](#after-adding-templates "Permalink to this heading")


```
print(    index.as\_query\_engine(        text\_qa\_template=text\_qa\_template, refine\_template=refine\_template    ).query("Who is Joe Biden?"))
```

```
Joe Biden is the 46th President of the United States.
```
