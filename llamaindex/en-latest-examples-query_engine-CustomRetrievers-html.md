[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/CustomRetrievers.ipynb)

Retriever Query Engine with Custom Retrievers - Simple Hybrid Search[](#retriever-query-engine-with-custom-retrievers-simple-hybrid-search "Permalink to this heading")
========================================================================================================================================================================

In this tutorial, we show you how to define a very simple version of hybrid search!

Combine keyword lookup retrieval with vector retrieval using “AND” and “OR” conditions.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleKeywordTableIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,)from IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


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
# initialize service context (set chunk size)service\_context = ServiceContext.from\_defaults(chunk\_size=1024)node\_parser = service\_context.node\_parsernodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)
```
Define Vector Index and Keyword Table Index over Same Data[](#define-vector-index-and-keyword-table-index-over-same-data "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------

We build a vector index and keyword index over the same DocumentStore


```
vector\_index = VectorStoreIndex(nodes, storage\_context=storage\_context)keyword\_index = SimpleKeywordTableIndex(nodes, storage\_context=storage\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 17050 tokens> [build_index_from_nodes] Total embedding token usage: 17050 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens
```
Define Custom Retriever[](#define-custom-retriever "Permalink to this heading")
--------------------------------------------------------------------------------

We now define a custom retriever class that can implement basic hybrid search with both keyword lookup and semantic search.

* setting “AND” means we take the intersection of the two retrieved sets
* setting “OR” means we take the union


```
# import QueryBundlefrom llama\_index import QueryBundle# import NodeWithScorefrom llama\_index.schema import NodeWithScore# Retrieversfrom llama\_index.retrievers import (    BaseRetriever,    VectorIndexRetriever,    KeywordTableSimpleRetriever,)from typing import List
```

```
class CustomRetriever(BaseRetriever): """Custom retriever that performs both semantic search and hybrid search."""    def \_\_init\_\_(        self,        vector\_retriever: VectorIndexRetriever,        keyword\_retriever: KeywordTableSimpleRetriever,        mode: str = "AND",    ) -> None: """Init params."""        self.\_vector\_retriever = vector\_retriever        self.\_keyword\_retriever = keyword\_retriever        if mode not in ("AND", "OR"):            raise ValueError("Invalid mode.")        self.\_mode = mode    def \_retrieve(self, query\_bundle: QueryBundle) -> List[NodeWithScore]: """Retrieve nodes given query."""        vector\_nodes = self.\_vector\_retriever.retrieve(query\_bundle)        keyword\_nodes = self.\_keyword\_retriever.retrieve(query\_bundle)        vector\_ids = {n.node.node\_id for n in vector\_nodes}        keyword\_ids = {n.node.node\_id for n in keyword\_nodes}        combined\_dict = {n.node.node\_id: n for n in vector\_nodes}        combined\_dict.update({n.node.node\_id: n for n in keyword\_nodes})        if self.\_mode == "AND":            retrieve\_ids = vector\_ids.intersection(keyword\_ids)        else:            retrieve\_ids = vector\_ids.union(keyword\_ids)        retrieve\_nodes = [combined\_dict[rid] for rid in retrieve\_ids]        return retrieve\_nodes
```
Plugin Retriever into Query Engine[](#plugin-retriever-into-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------------------------

Plugin retriever into a query engine, and run some queries


```
from llama\_index import get\_response\_synthesizerfrom llama\_index.query\_engine import RetrieverQueryEngine# define custom retrievervector\_retriever = VectorIndexRetriever(index=vector\_index, similarity\_top\_k=2)keyword\_retriever = KeywordTableSimpleRetriever(index=keyword\_index)custom\_retriever = CustomRetriever(vector\_retriever, keyword\_retriever)# define response synthesizerresponse\_synthesizer = get\_response\_synthesizer()# assemble query enginecustom\_query\_engine = RetrieverQueryEngine(    retriever=custom\_retriever,    response\_synthesizer=response\_synthesizer,)# vector query enginevector\_query\_engine = RetrieverQueryEngine(    retriever=vector\_retriever,    response\_synthesizer=response\_synthesizer,)# keyword query enginekeyword\_query\_engine = RetrieverQueryEngine(    retriever=keyword\_retriever,    response\_synthesizer=response\_synthesizer,)
```

```
response = custom\_query\_engine.query(    "What did the author do during his time at YC?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 12 tokens> [retrieve] Total embedding token usage: 12 tokensINFO:llama_index.indices.keyword_table.retrievers:> Starting query: What did the author do during his time at YC?> Starting query: What did the author do during his time at YC?INFO:llama_index.indices.keyword_table.retrievers:query keywords: ['time', 'yc', 'author']query keywords: ['time', 'yc', 'author']INFO:llama_index.indices.keyword_table.retrievers:> Extracted keywords: ['time', 'yc']> Extracted keywords: ['time', 'yc']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1919 tokens> [get_response] Total LLM token usage: 1919 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(response)
```

```
The author worked on YC, wrote essays, worked on a new version of Arc, wrote Hacker News in Arc, wrote YC's internal software in Arc, and dealt with disputes between cofounders, figuring out when people were lying to them, and fighting with people who maltreated the startups.
```

```
# hybrid search can allow us to not retrieve nodes that are irrelevant# Yale is never mentioned in the essayresponse = custom\_query\_engine.query(    "What did the author do during his time at Yale?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokensINFO:llama_index.indices.keyword_table.retrievers:> Starting query: What did the author do during his time at Yale?> Starting query: What did the author do during his time at Yale?INFO:llama_index.indices.keyword_table.retrievers:query keywords: ['yale', 'time', 'author']query keywords: ['yale', 'time', 'author']INFO:llama_index.indices.keyword_table.retrievers:> Extracted keywords: ['time']> Extracted keywords: ['time']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 0 tokens> [get_response] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))len(response.source\_nodes)
```

```
None
```

```
0
```

```
# in contrast, vector search will return an answerresponse = vector\_query\_engine.query(    "What did the author do during his time at Yale?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1871 tokens> [get_response] Total LLM token usage: 1871 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))len(response.source\_nodes)
```

```
The author did not attend Yale. The context information provided is about the author's work before and after college.
```

```
2
```
