[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/RouterQueryEngine.ipynb)

Router Query Engine[](#router-query-engine "Permalink to this heading")
========================================================================

In this tutorial, we define a custom router query engine that selects one out of several candidate query engines to execute a query.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().handlers = []logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SummaryIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,)
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

We first show how to convert a Document into a set of Nodes, and insert into a DocumentStore.


```
# load documentsdocuments = SimpleDirectoryReader("../data/paul\_graham").load\_data()
```

```
# initialize service context (set chunk size)service\_context = ServiceContext.from\_defaults(chunk\_size=1024)nodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)
```

```
# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)
```
Define Summary Index and Vector Index over Same Data[](#define-summary-index-and-vector-index-over-same-data "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------


```
summary\_index = SummaryIndex(nodes, storage\_context=storage\_context)vector\_index = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Define Query Engines and Set Metadata[](#define-query-engines-and-set-metadata "Permalink to this heading")
------------------------------------------------------------------------------------------------------------


```
list\_query\_engine = summary\_index.as\_query\_engine(    response\_mode="tree\_summarize",    use\_async=True,)vector\_query\_engine = vector\_index.as\_query\_engine()
```

```
from llama\_index.tools.query\_engine import QueryEngineToollist\_tool = QueryEngineTool.from\_defaults(    query\_engine=list\_query\_engine,    description=(        "Useful for summarization questions related to Paul Graham eassy on"        " What I Worked On."    ),)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description=(        "Useful for retrieving specific context from Paul Graham essay on What"        " I Worked On."    ),)
```
Define Router Query Engine[](#define-router-query-engine "Permalink to this heading")
--------------------------------------------------------------------------------------

There are several selectors available, each with some distinct attributes.

The LLM selectors use the LLM to output a JSON that is parsed, and the corresponding indexes are queried.

The Pydantic selectors (currently only supported by `gpt-4-0613` and `gpt-3.5-turbo-0613` (the default)) use the OpenAI Function Call API to produce pydantic selection objects, rather than parsing raw JSON.

For each type of selector, there is also the option to select 1 index to route to, or multiple.

### PydanticSingleSelector[](#pydanticsingleselector "Permalink to this heading")

Use the OpenAI Function API to generate/parse pydantic objects under the hood for the router selector.


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.llm\_selectors import (    LLMSingleSelector,    LLMMultiSelector,)from llama\_index.selectors.pydantic\_selectors import (    PydanticMultiSelector,    PydanticSingleSelector,)query\_engine = RouterQueryEngine(    selector=PydanticSingleSelector.from\_defaults(),    query\_engine\_tools=[        list\_tool,        vector\_tool,    ],)
```

```
response = query\_engine.query("What is the summary of the document?")print(str(response))
```

```
response = query\_engine.query("What did Paul Graham do after RICS?")print(str(response))
```
### LLMSingleSelector[](#llmsingleselector "Permalink to this heading")

Use OpenAI (or any other LLM) to parse generated JSON under the hood to select a sub-index for routing.


```
query\_engine = RouterQueryEngine(    selector=LLMSingleSelector.from\_defaults(),    query\_engine\_tools=[        list\_tool,        vector\_tool,    ],)
```

```
response = query\_engine.query("What is the summary of the document?")print(str(response))
```

```
response = query\_engine.query("What did Paul Graham do after RICS?")print(str(response))
```

```
# [optional] look at selected resultsprint(str(response.metadata["selector\_result"]))
```
### PydanticMultiSelector[](#pydanticmultiselector "Permalink to this heading")

In case you are expecting queries to be routed to multiple indexes, you should use a multi selector. The multi selector sends to query to multiple sub-indexes, and then aggregates all responses using a summary index to form a complete answer.


```
from llama\_index import SimpleKeywordTableIndexkeyword\_index = SimpleKeywordTableIndex(nodes, storage\_context=storage\_context)keyword\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description=(        "Useful for retrieving specific context using keywords from Paul"        " Graham essay on What I Worked On."    ),)
```

```
query\_engine = RouterQueryEngine(    selector=PydanticMultiSelector.from\_defaults(),    query\_engine\_tools=[        list\_tool,        vector\_tool,        keyword\_tool,    ],)
```

```
# This query could use either a keyword or vector query engine, so it will combine responses from bothresponse = query\_engine.query(    "What were noteable events and people from the authors time at Interleaf"    " and YC?")print(str(response))
```

```
# [optional] look at selected resultsprint(str(response.metadata["selector\_result"]))
```
