[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/RetrieverRouterQueryEngine.ipynb)

Retriever Router Query Engine[](#retriever-router-query-engine "Permalink to this heading")
============================================================================================

In this tutorial, we define a router query engine based on a retriever. The retriever will select a set of nodes, and we will in turn select the right QueryEngine.

We use our new `ToolRetrieverRouterQueryEngine` class for this!

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
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SummaryIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

We first show how to convert a Document into a set of Nodes, and insert into a DocumentStore.


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
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

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 17038 tokens> [build_index_from_nodes] Total embedding token usage: 17038 tokens
```
Define Query Engine and Tool for these Indices[](#define-query-engine-and-tool-for-these-indices "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------

We define a Query Engine for each Index. We then wrap these with our `QueryEngineTool`.


```
from llama\_index.tools.query\_engine import QueryEngineToollist\_query\_engine = summary\_index.as\_query\_engine(    response\_mode="tree\_summarize", use\_async=True)vector\_query\_engine = vector\_index.as\_query\_engine(    response\_mode="tree\_summarize", use\_async=True)list\_tool = QueryEngineTool.from\_defaults(    query\_engine=list\_query\_engine,    description="Useful for questions asking for a biography of the author.",)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description=(        "Useful for retrieving specific snippets from the author's life, like"        " his time in college, his time in YC, or more."    ),)
```
Define Retrieval-Augmented Router Query Engine[](#define-retrieval-augmented-router-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------

We define a router query engine that’s augmented with a retrieval mechanism, to help deal with the case when the set of choices is too large.

To do this, we first define an `ObjectIndex` over the set of query engine tools. The `ObjectIndex` is defined an underlying index data structure (e.g. a vector index, keyword index), and can serialize QueryEngineTool objects to/from our indices.

We then use our `ToolRetrieverRouterQueryEngine` class, and pass in an `ObjectRetriever` over `QueryEngineTool` objects.The `ObjectRetriever` corresponds to our `ObjectIndex`.

This retriever can then dyamically retrieve the relevant query engines during query-time. This allows us to pass in an arbitrary number of query engine tools without worrying about prompt limitations.


```
from llama\_index import VectorStoreIndexfrom llama\_index.objects import ObjectIndex, SimpleToolNodeMappingtool\_mapping = SimpleToolNodeMapping.from\_objects([list\_tool, vector\_tool])obj\_index = ObjectIndex.from\_objects(    [list\_tool, vector\_tool],    tool\_mapping,    VectorStoreIndex,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 59 tokens> [build_index_from_nodes] Total embedding token usage: 59 tokens
```

```
from llama\_index.query\_engine import ToolRetrieverRouterQueryEnginequery\_engine = ToolRetrieverRouterQueryEngine(obj\_index.as\_retriever())
```

```
response = query\_engine.query("What is a biography of the author's life?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 10 tokens> [retrieve] Total embedding token usage: 10 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 0 tokens> [retrieve] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2111 tokens> [get_response] Total LLM token usage: 2111 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 0 tokens> [retrieve] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2148 tokens> [get_response] Total LLM token usage: 2148 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.query_engine.router_query_engine:Combining responses from multiple query engines.Combining responses from multiple query engines.INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1063 tokens> [get_response] Total LLM token usage: 1063 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))
```

```
The author is a creative person who has had a varied and interesting life. They grew up in the US and went to college, but then decided to take a break and pursue their passion for art. They applied to two art schools, RISD in the US and the Accademia di Belli Arti in Florence, and were accepted to both. They chose to go to Florence, where they took the entrance exam and passed. They then spent a year living in Florence, studying art at the Accademia and painting still lives in their bedroom. After their year in Florence, the author returned to the US and completed their BFA program at RISD. They then went on to pursue a PhD in computer science at MIT, where they wrote a dissertation on the evolution of computers. During their time at MIT, they also did consulting work and wrote essays on topics they had been thinking about. After completing their PhD, the author started a software company, Viaweb, which was eventually acquired by Yahoo. They then went on to write essays and articles about their experiences in the tech industry. They also wrote an essay about how to choose what to work on, which was based on their own experience. The author then moved back to Florence, where they found a rent-stabilized apartment and continued to pursue their interest in art. They wrote about their experiences in the art world, and experienced the reactions of readers to their essays. The author is now a successful writer and continues to write essays and articles about topics they are passionate about. In summary, the author's life has been a journey of exploration and creativity. They have experienced a wide range of different things in their life, from art school to computer science to the tech industry, and have used their experiences to inform their writing. They have pursued their passion for art, and have used their knowledge and experience to create meaningful work.
```

```
response
```

```
"\nThe author is a creative person who has had a varied and interesting life. They grew up in the US and went to college, but then decided to take a break and pursue their passion for art. They applied to two art schools, RISD in the US and the Accademia di Belli Arti in Florence, and were accepted to both. They chose to go to Florence, where they took the entrance exam and passed. They then spent a year living in Florence, studying art at the Accademia and painting still lives in their bedroom. After their year in Florence, the author returned to the US and completed their BFA program at RISD. They then went on to pursue a PhD in computer science at MIT, where they wrote a dissertation on the evolution of computers. During their time at MIT, they also did consulting work and wrote essays on topics they had been thinking about. After completing their PhD, the author started a software company, Viaweb, which was eventually acquired by Yahoo. They then went on to write essays and articles about their experiences in the tech industry. They also wrote an essay about how to choose what to work on, which was based on their own experience. The author then moved back to Florence, where they found a rent-stabilized apartment and continued to pursue their interest in art. They wrote about their experiences in the art world, and experienced the reactions of readers to their essays. The author is now a successful writer and continues to write essays and articles about topics they are passionate about. \n\nIn summary, the author's life has been a journey of exploration and creativity. They have experienced a wide range of different things in their life, from art school to computer science to the tech industry, and have used their experiences to inform their writing. They have pursued their passion for art, and have used their knowledge and experience to create meaningful work."
```

```
response = query\_engine.query(    "What did Paul Graham do during his time in college?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 0 tokens> [retrieve] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1947 tokens> [get_response] Total LLM token usage: 1947 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 0 tokens> [retrieve] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1947 tokens> [get_response] Total LLM token usage: 1947 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.query_engine.router_query_engine:Combining responses from multiple query engines.Combining responses from multiple query engines.INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 316 tokens> [get_response] Total LLM token usage: 316 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))
```

```
Paul Graham studied philosophy in college, but he did not pursue AI. He continued to work on programming outside of school, writing simple games, a program to predict how high his model rockets would fly, and a word processor. He eventually convinced his father to buy him a TRS-80 computer, which he used to further his programming skills.
```
