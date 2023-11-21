Routers[](#routers "Permalink to this heading")
================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Routers are modules that take in a user query and a set of “choices” (defined by metadata), and returns one or more selected choices.

They can be used on their own (as “selector modules”), or used as a query engine or retriever (e.g. on top of other query engines/retrievers).

They are simple but powerful modules that use LLMs for decision making capabilities. They can be used for the following use cases and more:

* Selecting the right data source among a diverse range of data sources
* Deciding whether to do summarization (e.g. using summary index query engine) or semantic search (e.g. using vector index query engine)
* Deciding whether to “try” out a bunch of choices at once and combine the results (using multi-routing capabilities).

The core router modules exist in the following forms:

* LLM selectors put the choices as a text dump into a prompt and use LLM text completion endpoint to make decisions
* Pydantic selectors pass choices as Pydantic schemas into a function calling endpoint, and return Pydantic objects
Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

A simple example of using our router module as part of a query engine is given below.


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.pydantic\_selectors import PydanticSingleSelectorfrom llama\_index.tools.query\_engine import QueryEngineToollist\_tool = QueryEngineTool.from\_defaults(    query\_engine=list\_query\_engine,    description="Useful for summarization questions related to the data source",)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description="Useful for retrieving specific context related to the data source",)query\_engine = RouterQueryEngine(    selector=PydanticSingleSelector.from\_defaults(),    query\_engine\_tools=[        list\_tool,        vector\_tool,    ],)query\_engine.query("<query>")
```
Usage Pattern[](#id1 "Permalink to this heading")
--------------------------------------------------

Defining a “selector” is at the core of defining a router.

You can easily use our routers as a query engine or a retriever. In these cases, the router will be responsiblefor “selecting” query engine(s) or retriever(s) to route the user query to.

We also highlight our `ToolRetrieverRouterQueryEngine` for retrieval-augmented routing - this is the casewhere the set of choices themselves may be very big and may need to be indexed. **NOTE**: this is a beta feature.

We also highlight using our router as a standalone module.

Defining a selector[](#defining-a-selector "Permalink to this heading")
------------------------------------------------------------------------

Some examples are given below with LLM and Pydantic based single/multi selectors:


```
from llama\_index.selectors.llm\_selectors import (    LLMSingleSelector,    LLMMultiSelector,)from llama\_index.selectors.pydantic\_selectors import (    PydanticMultiSelector,    PydanticSingleSelector,)# pydantic selectors feed in pydantic objects to a function calling API# single selector (pydantic)selector = PydanticSingleSelector.from\_defaults()# multi selector (pydantic)selector = PydanticMultiSelector.from\_defaults()# LLM selectors use text completion endpoints# single selector (LLM)selector = LLMSingleSelector.from\_defaults()# multi selector (LLM)selector = LLMMultiSelector.from\_defaults()
```
Using as a Query Engine[](#using-as-a-query-engine "Permalink to this heading")
--------------------------------------------------------------------------------

A `RouterQueryEngine` is composed on top of other query engines as tools.


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.pydantic\_selectors import (    PydanticSingleSelector,    Pydantic,)from llama\_index.tools.query\_engine import QueryEngineToolfrom llama\_index import (    VectorStoreIndex,    SummaryIndex,)# define query engines...# initialize toolslist\_tool = QueryEngineTool.from\_defaults(    query\_engine=list\_query\_engine,    description="Useful for summarization questions related to the data source",)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description="Useful for retrieving specific context related to the data source",)# initialize router query engine (single selection, pydantic)query\_engine = RouterQueryEngine(    selector=PydanticSingleSelector.from\_defaults(),    query\_engine\_tools=[        list\_tool,        vector\_tool,    ],)query\_engine.query("<query>")
```
Using as a Retriever[](#using-as-a-retriever "Permalink to this heading")
--------------------------------------------------------------------------

Similarly, a `RouterRetriever` is composed on top of other retrievers as tools. An example is given below:


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.pydantic\_selectors import PydanticSingleSelectorfrom llama\_index.tools import RetrieverTool# define indices...# define retrieversvector\_retriever = vector\_index.as\_retriever()keyword\_retriever = keyword\_index.as\_retriever()# initialize toolsvector\_tool = RetrieverTool.from\_defaults(    retriever=vector\_retriever,    description="Useful for retrieving specific context from Paul Graham essay on What I Worked On.",)keyword\_tool = RetrieverTool.from\_defaults(    retriever=keyword\_retriever,    description="Useful for retrieving specific context from Paul Graham essay on What I Worked On (using entities mentioned in query)",)# define retrieverretriever = RouterRetriever(    selector=PydanticSingleSelector.from\_defaults(llm=llm),    retriever\_tools=[        list\_tool,        vector\_tool,    ],)
```
Using selector as a standalone module[](#using-selector-as-a-standalone-module "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

You can use the selectors as standalone modules. Define choices as either a list of `ToolMetadata` or as a list of strings.


```
from llama\_index.tools import ToolMetadatafrom llama\_index.selectors.llm\_selectors import LLMSingleSelector# choices as a list of tool metadatachoices = [    ToolMetadata(description="description for choice 1", name="choice\_1"),    ToolMetadata(description="description for choice 2", name="choice\_2"),]# choices as a list of stringschoices = [    "choice 1 - description for choice 1",    "choice 2: description for choice 2",]selector = LLMSingleSelector.from\_defaults()selector\_result = selector.select(    choices, query="What's revenue growth for IBM in 2007?")print(selector\_result.selections)
```
* [Router Query Engine](../../../examples/query_engine/RouterQueryEngine.html)
* [Retriever Router Query Engine](../../../examples/query_engine/RetrieverRouterQueryEngine.html)
* [SQL Router Query Engine](../../../examples/query_engine/SQLRouterQueryEngine.html)
* [Router Retriever](../../../examples/retrievers/router_retriever.html)
