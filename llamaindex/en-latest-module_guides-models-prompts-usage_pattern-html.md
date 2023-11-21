Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Defining a custom prompt[](#defining-a-custom-prompt "Permalink to this heading")
----------------------------------------------------------------------------------

Defining a custom prompt is as simple as creating a format string


```
from llama\_index.prompts import PromptTemplatetemplate = (    "We have provided context information below. \n"    "---------------------\n"    "{context\_str}"    "\n---------------------\n"    "Given this information, please answer the question: {query\_str}\n")qa\_template = PromptTemplate(template)# you can create text prompt (for completion API)prompt = qa\_template.format(context\_str=..., query\_str=...)# or easily convert to message prompts (for chat API)messages = qa\_template.format\_messages(context\_str=..., query\_str=...)
```

> Note: you may see references to legacy prompt subclasses such as `QuestionAnswerPrompt`, `RefinePrompt`. These have been deprecated (and now are type aliases of `PromptTemplate`). Now you can directly specify `PromptTemplate(template)` to construct custom prompts. But you still have to make sure the template string contains the expected parameters (e.g. `{context\_str}` and `{query\_str}`) when replacing a default question answer prompt.
> 
> 

You can also define a template from chat messages


```
from llama\_index.prompts import ChatPromptTemplate, ChatMessage, MessageRolemessage\_templates = [    ChatMessage(content="You are an expert system.", role=MessageRole.SYSTEM),    ChatMessage(        content="Generate a short story about {topic}",        role=MessageRole.USER,    ),]chat\_template = ChatPromptTemplate(message\_templates=message\_templates)# you can create message prompts (for chat API)messages = chat\_template.format\_messages(topic=...)# or easily convert to text prompt (for completion API)prompt = chat\_template.format(topic=...)
```
Getting and Setting Custom Prompts[](#getting-and-setting-custom-prompts "Permalink to this heading")
------------------------------------------------------------------------------------------------------

Since LlamaIndex is a multi-step pipeline, it’s important to identify the operation that you want to modify and pass in the custom prompt at the right place.

For instance, prompts are used in response synthesizer, retrievers, index construction, etc; some of these modules are nested in other modules (synthesizer is nested in query engine).

See [this guide](../../../examples/prompts/prompt_mixin.html) for full details on accessing/customizing prompts.

### Commonly Used Prompts[](#commonly-used-prompts "Permalink to this heading")

The most commonly used prompts will be the `text\_qa\_template` and the `refine\_template`.

* `text\_qa\_template` - used to get an initial answer to a query using retrieved nodes
* `refine\_template` - used when the retrieved text does not fit into a single LLM call with `response\_mode="compact"` (the default), or when more than one node is retrieved using `response\_mode="refine"`. The answer from the first query is inserted as an `existing\_answer`, and the LLM must update or repeat the existing answer based on the new context.
### Accessing Prompts[](#accessing-prompts "Permalink to this heading")

You can call `get\_prompts` on many modules in LlamaIndex to get a flat list of prompts used within the module and nested submodules.

For instance, take a look at the following snippet.


```
query\_engine = index.as\_query\_engine(response\_mode="compact")prompts\_dict = query\_engine.get\_prompts()print(list(prompts\_dict.keys()))
```
You might get back the following keys:


```
['response\_synthesizer:text\_qa\_template', 'response\_synthesizer:refine\_template']
```
Note that prompts are prefixed by their sub-modules as “namespaces”.

### Updating Prompts[](#updating-prompts "Permalink to this heading")

You can customize prompts on any module that implements `get\_prompts` with the `update\_prompts` function. Just pass in argument values with the keys equal to the keys you see in the prompt dictionaryobtained through `get\_prompts`.

e.g. regarding the example above, we might do the following


```
# shakespeare!qa\_prompt\_tmpl\_str = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query in the style of a Shakespeare play.\n"    "Query: {query\_str}\n"    "Answer: ")qa\_prompt\_tmpl = PromptTemplate(qa\_prompt\_tmpl\_str)query\_engine.update\_prompts(    {"response\_synthesizer:text\_qa\_template": qa\_prompt\_tmpl})
```
### Modify prompts used in query engine[](#modify-prompts-used-in-query-engine "Permalink to this heading")

For query engines, you can also pass in custom prompts directly during query-time (i.e. for executing a query against an index and synthesizing the final response).

There are also two equivalent ways to override the prompts:

1. via the high-level API


```
query\_engine = index.as\_query\_engine(    text\_qa\_template=custom\_qa\_prompt, refine\_template=custom\_refine\_prompt)
```
2. via the low-level composition API


```
retriever = index.as\_retriever()synth = get\_response\_synthesizer(    text\_qa\_template=custom\_qa\_prompt, refine\_template=custom\_refine\_prompt)query\_engine = RetrieverQueryEngine(retriever, response\_synthesizer)
```
The two approaches above are equivalent, where 1 is essentially syntactic sugar for 2 and hides away the underlying complexity. You might want to use 1 to quickly modify some common parameters, and use 2 to have more granular control.

For more details on which classes use which prompts, please visit[Query class references](../../../api_reference/query.html).

Check out the [reference documentation](../../../api_reference/prompts.html) for a full set of all prompts.

### Modify prompts used in index construction[](#modify-prompts-used-in-index-construction "Permalink to this heading")

Some indices use different types of prompts during construction(**NOTE**: the most common ones, `VectorStoreIndex` and `SummaryIndex`, don’t use any).

For instance, `TreeIndex` uses a summary prompt to hierarchicallysummarize the nodes, and `KeywordTableIndex` uses a keyword extract prompt to extract keywords.

There are two equivalent ways to override the prompts:

1. via the default nodes constructor


```
index = TreeIndex(nodes, summary\_template=custom\_prompt)
```
2. via the documents constructor.


```
index = TreeIndex.from\_documents(docs, summary\_template=custom\_prompt)
```
For more details on which index uses which prompts, please visit[Index class references](../../../api_reference/indices.html).

[Advanced] Advanced Prompt Capabilities[](#advanced-advanced-prompt-capabilities "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

In this section we show some advanced prompt capabilities in LlamaIndex.

Related Guides:

* [Advanced Prompts](../../../examples/prompts/advanced_prompts.html)
* [Prompt Engineering for RAG](../../../examples/prompts/prompts_rag.html)

### Partial Formatting[](#partial-formatting "Permalink to this heading")

Partially format a prompt, filling in some variables while leaving others to be filled in later.


```
from llama\_index.prompts import PromptTemplateprompt\_tmpl\_str = "{foo} {bar}"prompt\_tmpl = PromptTemplate(prompt\_tmpl\_str)partial\_prompt\_tmpl = prompt\_tmpl.partial\_format(foo="abc")fmt\_str = partial\_prompt\_tmpl.format(bar="def")
```
### Template Variable Mappings[](#template-variable-mappings "Permalink to this heading")

LlamaIndex prompt abstractions generally expect certain keys. E.g. our `text\_qa\_prompt` expects `context\_str` for context and `query\_str` for the user query.

But if you’re trying to adapt a string template for use with LlamaIndex, it can be annoying to change out the template variables.

Instead, define `template\_var\_mappings`:


```
template\_var\_mappings = {"context\_str": "my\_context", "query\_str": "my\_query"}prompt\_tmpl = PromptTemplate(    qa\_prompt\_tmpl\_str, template\_var\_mappings=template\_var\_mappings)
```
### Function Mappings[](#function-mappings "Permalink to this heading")

Pass in functions as template variables instead of fixed values.

This is quite advanced and powerful; allows you to do dynamic few-shot prompting, etc.

Here’s an example of reformatting the `context\_str`.


```
def format\_context\_fn(\*\*kwargs):    # format context with bullet points    context\_list = kwargs["context\_str"].split("\n\n")    fmtted\_context = "\n\n".join([f"- {c}" for c in context\_list])    return fmtted\_contextprompt\_tmpl = PromptTemplate(    qa\_prompt\_tmpl\_str, function\_mappings={"context\_str": format\_context\_fn})prompt\_tmpl.format(context\_str="context", query\_str="query")
```
