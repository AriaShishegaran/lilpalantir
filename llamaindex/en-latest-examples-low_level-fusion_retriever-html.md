[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/low_level/fusion_retriever.ipynb)

Building an Advanced Fusion Retriever from Scratch[](#building-an-advanced-fusion-retriever-from-scratch "Permalink to this heading")
======================================================================================================================================

In this tutorial, we show you how to build an advanced retriever from scratch.

Specifically, we show you how to build our `QueryFusionRetriever` from scratch.

This is heavily inspired from the RAG-fusion repo here: https://github.com/Raudaschl/rag-fusion.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We load documents and build a simple vector index.


```
!pip install rank-bm25 pymupdf
```

```
import nest\_asyncionest\_asyncio.apply()
```
### Load Documents[](#load-documents "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderloader = PyMuPDFReader()documents = loader.load(file\_path="./data/llama2.pdf")
```
### Load into Vector Store[](#load-into-vector-store "Permalink to this heading")


```
from llama\_index import VectorStoreIndex, ServiceContextservice\_context = ServiceContext.from\_defaults(chunk\_size=1024)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
### Define LLMs[](#define-llms "Permalink to this heading")


```
from llama\_index.llms import OpenAI
```

```
llm = OpenAI(model="gpt-3.5-turbo")
```
Define Advanced Retriever[](#define-advanced-retriever "Permalink to this heading")
------------------------------------------------------------------------------------

We define an advanced retriever that performs the following steps:

1. Query generation/rewriting: generate multiple queries given the original user query
2. Perform retrieval for each query over an ensemble of retrievers.
3. Reranking/fusion: fuse results from all queries, and apply a reranking step to “fuse” the top relevant results!

Then in the next section we’ll plug this into our response synthesis module.

### Step 1: Query Generation/Rewriting[](#step-1-query-generation-rewriting "Permalink to this heading")

The first step is to generate queries from the original query to better match the query intent, and increase precision/recall of the retrieved results. For instance, we might be able to rewrite the query into smaller queries.

We can do this by prompting ChatGPT.


```
from llama\_index import PromptTemplate
```

```
query\_str = "How do the models developed in this work compare to open-source chat models based on the benchmarks tested?"
```

```
query\_gen\_prompt\_str = (    "You are a helpful assistant that generates multiple search queries based on a "    "single input query. Generate {num\_queries} search queries, one on each line, "    "related to the following input query:\n"    "Query: {query}\n"    "Queries:\n")query\_gen\_prompt = PromptTemplate(query\_gen\_prompt\_str)
```

```
def generate\_queries(llm, query\_str: str, num\_queries: int = 4):    fmt\_prompt = query\_gen\_prompt.format(        num\_queries=num\_queries - 1, query=query\_str    )    response = llm.complete(fmt\_prompt)    queries = response.text.split("\n")    return queries
```

```
queries = generate\_queries(llm, query\_str, num\_queries=4)
```

```
print(queries)
```

```
['1. What are the benchmarks used to evaluate open-source chat models?', '2. Can you provide a comparison between the models developed in this work and existing open-source chat models?', '3. Are there any notable differences in performance between the models developed in this work and open-source chat models based on the benchmarks tested?']
```
### Step 2: Perform Vector Search for Each Query[](#step-2-perform-vector-search-for-each-query "Permalink to this heading")

Now we run retrieval for each query. This means that we fetch the top-k most relevant results from each vector store.

**NOTE**: We can also have multiple retrievers. Then the total number of queries we run is N*M, where N is number of retrievers and M is number of generated queries. Hence there will also be N*M retrieved lists.

Here we’ll use the retriever provided from our vector store. If you want to see how to build this from scratch please see [our tutorial on this](https://docs.llamaindex.ai/en/latest/examples/low_level/retrieval.html#put-this-into-a-retriever).


```
from tqdm.asyncio import tqdmasync def run\_queries(queries, retrievers): """Run queries against retrievers."""    tasks = []    for query in queries:        for i, retriever in enumerate(retrievers):            tasks.append(retriever.aretrieve(query))    task\_results = await tqdm.gather(\*tasks)    results\_dict = {}    for i, (query, query\_result) in enumerate(zip(queries, task\_results)):        results\_dict[(query, i)] = query\_result    return results\_dict
```

```
# get retrieversfrom llama\_index.retrievers import BM25Retriever## vector retrievervector\_retriever = index.as\_retriever(similarity\_top\_k=2)## bm25 retrieverbm25\_retriever = BM25Retriever.from\_defaults(    docstore=index.docstore, similarity\_top\_k=2)
```

```
results\_dict = await run\_queries(queries, [vector\_retriever, bm25\_retriever])
```

```
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 6/6 [00:00<00:00, 22.59it/s]
```
### Step 3: Perform Fusion[](#step-3-perform-fusion "Permalink to this heading")

The next step here is to perform fusion: combining the results from several retrievers into one and re-ranking.

Note that a given node might be retrieved multiple times from different retrievers, so there needs to be a way to de-dup and rerank the node given the multiple retrievals.

We’ll show you how to perform “reciprocal rank fusion”: for each node, add up its reciprocal rank in every list where it’s retrieved.

Then reorder nodes by highest score to least.

Full paper here: https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf


```
def fuse\_results(results\_dict, similarity\_top\_k: int = 2): """Fuse results."""    k = 60.0  # `k` is a parameter used to control the impact of outlier rankings.    fused\_scores = {}    text\_to\_node = {}    # compute reciprocal rank scores    for nodes\_with\_scores in results\_dict.values():        for rank, node\_with\_score in enumerate(            sorted(                nodes\_with\_scores, key=lambda x: x.score or 0.0, reverse=True            )        ):            text = node\_with\_score.node.get\_content()            text\_to\_node[text] = node\_with\_score            if text not in fused\_scores:                fused\_scores[text] = 0.0            fused\_scores[text] += 1.0 / (rank + k)    # sort results    reranked\_results = dict(        sorted(fused\_scores.items(), key=lambda x: x[1], reverse=True)    )    # adjust node scores    reranked\_nodes: List[NodeWithScore] = []    for text, score in reranked\_results.items():        reranked\_nodes.append(text\_to\_node[text])        reranked\_nodes[-1].score = score    return reranked\_nodes[:similarity\_top\_k]
```

```
final\_results = fuse\_results(results\_dict)
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor n in final\_results:    display\_source\_node(n, source\_length=500)
```
**Node ID:** d92e53b7-1f27-4129-8d5d-dd06638b1f2d  
**Similarity:** 0.04972677595628415  
**Text:** Figure 12: Human evaluation results for Llama 2-Chat models compared to open- and closed-source modelsacross ~4,000 helpfulness prompts with three raters per prompt.The largest Llama 2-Chat model is competitive with ChatGPT. Llama 2-Chat 70B model has a win rate of36% and a tie rate of 31.5% relative to ChatGPT. Llama 2-Chat 70B model outperforms PaLM-bison chatmodel by a large percentage on our prompt set. More results and analysis is available in Section A.3.7.Inter-Rater Reliability (…  


**Node ID:** 20d32df8-e16e-45fb-957a-e08175e188e8  
**Similarity:** 0.016666666666666666  
**Text:** Figure 1: Helpfulness human evaluation results for Llama2-Chat compared to other open-source and closed-sourcemodels. Human raters compared model generations on ~4kprompts consisting of both single and multi-turn prompts.The 95% confidence intervals for this evaluation are between1% and 2%. More details in Section 3.4.2. While reviewingthese results, it is important to note that human evaluationscan be noisy due to limitations of the prompt set, subjectivityof the review guidelines, s…  


**Analysis**: The above code has a few straightforward components.

1. Go through each node in each retrieved list, and add it’s reciprocal rank to the node’s ID. The node’s ID is the hash of it’s text for dedup purposes.
2. Sort results by highest-score to lowest.
3. Adjust node scores.
Plug into RetrieverQueryEngine[](#plug-into-retrieverqueryengine "Permalink to this heading")
----------------------------------------------------------------------------------------------

Now we’re ready to define this as a custom retriever, and plug it into our `RetrieverQueryEngine` (which does retrieval and synthesis).


```
from llama\_index import QueryBundlefrom llama\_index.retrievers import BaseRetrieverfrom typing import Any, Listfrom llama\_index.schema import NodeWithScoreclass FusionRetriever(BaseRetriever): """Ensemble retriever with fusion."""    def \_\_init\_\_(        self,        llm,        retrievers: List[BaseRetriever],        similarity\_top\_k: int = 2,    ) -> None: """Init params."""        self.\_retrievers = retrievers        self.\_similarity\_top\_k = similarity\_top\_k    def \_retrieve(self, query\_bundle: QueryBundle) -> List[NodeWithScore]: """Retrieve."""        queries = generate\_queries(llm, query\_str, num\_queries=4)        results = run\_queries(queries, [vector\_retriever, bm25\_retriever])        final\_results = fuse\_results(            results\_dict, similarity\_top\_k=self.\_similarity\_top\_k        )        return final\_results
```

```
from llama\_index.query\_engine import RetrieverQueryEnginefusion\_retriever = FusionRetriever(    llm, [vector\_retriever, bm25\_retriever], similarity\_top\_k=2)query\_engine = RetrieverQueryEngine(fusion\_retriever)
```

```
response = query\_engine.query(query\_str)
```

```
/Users/jerryliu/Programming/gpt_index/llama_index/indices/base_retriever.py:22: RuntimeWarning: coroutine 'run_queries' was never awaited  return self._retrieve(str_or_query_bundle)RuntimeWarning: Enable tracemalloc to get the object allocation traceback
```

```
print(str(response))
```

```
The models developed in this work, specifically the Llama 2-Chat models, are competitive with open-source chat models based on the benchmarks tested. The largest Llama 2-Chat model has a win rate of 36% and a tie rate of 31.5% relative to ChatGPT, which indicates that it performs well in comparison. Additionally, the Llama 2-Chat 70B model outperforms the PaLM-bison chat model by a large percentage on the prompt set used for evaluation. While it is important to note the limitations of the benchmarks and the subjective nature of human evaluations, the results suggest that the Llama 2-Chat models are on par with or even outperform open-source chat models in certain aspects.
```
