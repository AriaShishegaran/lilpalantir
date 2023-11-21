[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/retrievers/bm25_retriever.ipynb)

BM25 Retriever[](#bm25-retriever "Permalink to this heading")
==============================================================

In this guide, we define a bm25 retriever that search documents using bm25 method.

This notebook is very similar to the RouterQueryEngine notebook.

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
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().handlers = []logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    SimpleDirectoryReader,    ServiceContext,    StorageContext,    VectorStoreIndex,)from llama\_index.retrievers import BM25Retrieverfrom llama\_index.indices.vector\_store.retrievers.retriever import (    VectorIndexRetriever,)from llama\_index.llms import OpenAI
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
# initialize service context (set chunk size)llm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(chunk\_size=1024, llm=llm)nodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)
```

```
# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)
```

```
index = VectorStoreIndex(    nodes=nodes,    storage\_context=storage\_context,    service\_context=service\_context,)
```
BM25 Retriever[](#id1 "Permalink to this heading")
---------------------------------------------------

We will search document with bm25 retriever.


```
# !pip install rank\_bm25
```

```
# We can pass in the index, doctore, or list of nodes to create the retrieverretriever = BM25Retriever.from\_defaults(nodes=nodes, similarity\_top\_k=2)
```

```
from llama\_index.response.notebook\_utils import display\_source\_node# will retrieve context from specific companiesnodes = retriever.retrieve("What happened at Viaweb and Interleaf?")for node in nodes:    display\_source\_node(node)
```
**Node ID:** d95537b4-b398-4b47-94ff-da86f05a27f7  
**Similarity:** 5.171801938898801  
**Text:** I wanted to go back to RISD, but I was now broke and RISD was very expensive, so I decided to get…  


**Node ID:** 6f84e2a5-1ab1-4389-8799-b7713e085931  
**Similarity:** 4.838241203957084  
**Text:** All you had to do was teach SHRDLU more words.

There weren’t any classes in AI at Cornell then, …  



```
nodes = retriever.retrieve("What did Paul Graham do after RISD?")for node in nodes:    display\_source\_node(node)
```
**Node ID:** a4fd0b29-4138-4741-9e27-9f65d6968eb4  
**Similarity:** 8.090884087344435  
**Text:** Not so much because it was badly written as because the problem is so convoluted. When you’re wor…  


**Node ID:** d95537b4-b398-4b47-94ff-da86f05a27f7  
**Similarity:** 5.830874349482576  
**Text:** I wanted to go back to RISD, but I was now broke and RISD was very expensive, so I decided to get…  


Router Retriever with bm25 method[](#router-retriever-with-bm25-method "Permalink to this heading")
----------------------------------------------------------------------------------------------------

Now we will combine bm25 retriever with vector index retriever.


```
from llama\_index.tools import RetrieverToolvector\_retriever = VectorIndexRetriever(index)bm25\_retriever = BM25Retriever.from\_defaults(nodes=nodes, similarity\_top\_k=2)retriever\_tools = [    RetrieverTool.from\_defaults(        retriever=vector\_retriever,        description="Useful in most cases",    ),    RetrieverTool.from\_defaults(        retriever=bm25\_retriever,        description="Useful if searching about specific information",    ),]
```

```
from llama\_index.retrievers import RouterRetrieverretriever = RouterRetriever.from\_defaults(    retriever\_tools=retriever\_tools,    service\_context=service\_context,    select\_multi=True,)
```

```
# will retrieve all context from the author's lifenodes = retriever.retrieve(    "Can you give me all the context regarding the author's life?")for node in nodes:    display\_source\_node(node)
```

```
Selecting retriever 0: The author's life context is a broad topic, which may require a comprehensive approach that is useful in most cases..
```
**Node ID:** fcd399c1-3544-4df3-80a9-0a7d3fd41f1f  
**Similarity:** 0.7942753162501964  
**Text:** [10]

Wow, I thought, there’s an audience. If I write something and put it on the web, anyone can…  


**Node ID:** b203e140-d549-4284-99f4-b1b5bcd996ea  
**Similarity:** 0.7788031317604815  
**Text:** Now all I had to do was learn Italian.

Only stranieri (foreigners) had to take this entrance exa…  


Advanced - Hybrid Retriever + Re-Ranking[](#advanced-hybrid-retriever-re-ranking "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

Here we extend the base retriever class and create a custom retriever that always uses the vector retriever and BM25 retreiver.

Then, nodes can be re-ranked and filtered. This lets us keep intermediate top-k values large and letting the re-ranking filter out un-needed nodes.

To best demonstrate this, we will use a larger set of source documents – Chapter 3 from the 2022 IPCC Climate Report.

### Setup data[](#setup-data "Permalink to this heading")


```
!curl https://www.ipcc.ch/report/ar6/wg2/downloads/report/IPCC_AR6_WGII_Chapter03.pdf --output IPCC_AR6_WGII_Chapter03.pdf
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current                                 Dload  Upload   Total   Spent    Left  Speed100 20.7M  100 20.7M    0     0   361k      0  0:00:58  0:00:58 --:--:--  422k
```

```
# !pip install pypdf
```

```
from llama\_index import (    VectorStoreIndex,    ServiceContext,    StorageContext,    SimpleDirectoryReader,)from llama\_index.llms import OpenAI# load documentsdocuments = SimpleDirectoryReader(    input\_files=["IPCC\_AR6\_WGII\_Chapter03.pdf"]).load\_data()# initialize service context (set chunk size)# -- here, we set a smaller chunk size, to allow for more effective re-rankingllm = OpenAI(model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(chunk\_size=256, llm=llm)nodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)
```

```
index = VectorStoreIndex(    nodes, storage\_context=storage\_context, service\_context=service\_context)
```

```
from llama\_index.retrievers import BM25Retriever# retireve the top 10 most similar nodes using embeddingsvector\_retriever = index.as\_retriever(similarity\_top\_k=10)# retireve the top 10 most similar nodes using bm25bm25\_retriever = BM25Retriever.from\_defaults(nodes=nodes, similarity\_top\_k=10)
```
### Custom Retriever Implementation[](#custom-retriever-implementation "Permalink to this heading")


```
from llama\_index.retrievers import BaseRetrieverclass HybridRetriever(BaseRetriever):    def \_\_init\_\_(self, vector\_retriever, bm25\_retriever):        self.vector\_retriever = vector\_retriever        self.bm25\_retriever = bm25\_retriever    def \_retrieve(self, query, \*\*kwargs):        bm25\_nodes = self.bm25\_retriever.retrieve(query, \*\*kwargs)        vector\_nodes = self.vector\_retriever.retrieve(query, \*\*kwargs)        # combine the two lists of nodes        all\_nodes = []        node\_ids = set()        for n in bm25\_nodes + vector\_nodes:            if n.node.node\_id not in node\_ids:                all\_nodes.append(n)                node\_ids.add(n.node.node\_id)        return all\_nodes
```

```
index.as\_retriever(similarity\_top\_k=5)hybrid\_retriever = HybridRetriever(vector\_retriever, bm25\_retriever)
```
### Re-Ranker Setup[](#re-ranker-setup "Permalink to this heading")


```
# !pip install sentence\_transformers
```

```
from llama\_index.indices.postprocessor import SentenceTransformerRerankreranker = SentenceTransformerRerank(top\_n=4, model="BAAI/bge-reranker-base")
```

```
Downloading (…)lve/main/config.json: 100%|██████████| 799/799 [00:00<00:00, 3.86MB/s]Downloading pytorch_model.bin: 100%|██████████| 1.11G/1.11G [00:32<00:00, 34.4MB/s]Downloading (…)okenizer_config.json: 100%|██████████| 443/443 [00:00<00:00, 2.19MB/s]Downloading (…)tencepiece.bpe.model: 100%|██████████| 5.07M/5.07M [00:00<00:00, 14.1MB/s]Downloading (…)cial_tokens_map.json: 100%|██████████| 279/279 [00:00<00:00, 1.48MB/s]
```

```
Use pytorch device: cpu
```
### Retrieve[](#retrieve "Permalink to this heading")


```
from llama\_index import QueryBundlenodes = hybrid\_retriever.retrieve(    "What is the impact of climate change on the ocean?")reranked\_nodes = reranker.postprocess\_nodes(    nodes,    query\_bundle=QueryBundle(        "What is the impact of climate change on the ocean?"    ),)print("Initial retrieval: ", len(nodes), " nodes")print("Re-ranked retrieval: ", len(reranked\_nodes), " nodes")
```

```
Batches: 100%|██████████| 1/1 [00:05<00:00,  5.61s/it]
```

```
Initial retrieval:  19  nodesRe-ranked retrieval:  4  nodes
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor node in reranked\_nodes:    display\_source\_node(node)
```
**Node ID:** 74b12b7b-f4b9-490a-9342-b640211468dd  
**Similarity:** 0.998129665851593  
**Text:** 3469Oceans and Coastal Ecosystems and Their Services Chapter 3Frequently Asked QuestionsFAQ 3…  


**Node ID:** 2b35824c-2e96-47b7-8dfb-da25c4eefb7d  
**Similarity:** 0.996731162071228  
**Text:** {Box 3.2, 3.2.2.1, 3.4.2.5, 3.4.2.10, 3.4.3.3, Cross-ChapterBox PALEO in Chapter 1}Climate imp…  


**Node ID:** 01ef2a9e-0dd0-4bce-ab60-e6a3f6456f7b  
**Similarity:** 0.9954373240470886  
**Text:** These ecosystems are also influenced by non-climate drivers, especially fisheries, oil and gas ex…  


**Node ID:** 8a23b728-0352-4b01-a5c0-42765669855d  
**Similarity:** 0.9872682690620422  
**Text:** Additionally, climate-change-driven oxygen loss (Section  3.2.3.2; Luna et  al., 2012;Belley et…  


### Full Query Engine[](#full-query-engine "Permalink to this heading")


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(    retriever=hybrid\_retriever,    node\_postprocessors=[reranker],    service\_context=service\_context,)response = query\_engine.query(    "What is the impact of climate change on the ocean?")
```

```
Batches: 100%|██████████| 1/1 [00:05<00:00,  5.74s/it]
```

```
from llama\_index.response.notebook\_utils import display\_responsedisplay\_response(response)
```
**`Final Response:`** Climate change has significant impacts on the ocean. It is degrading ocean health and altering stocks of marine resources. This, combined with over-harvesting, is threatening the sustenance provided to Indigenous Peoples, the livelihoods of artisanal fisheries, and marine-based industries such as tourism, shipping, and transportation. Climate change can also influence human activities and employment by altering resource availability, spreading pathogens, flooding shorelines, and degrading ocean ecosystems. Additionally, increases in intensity, reoccurrence, and duration of marine heatwaves due to climate change can lead to species extirpation, habitat collapse, and surpassing ecological tipping points. Some habitat-forming coastal ecosystems, including coral reefs, kelp forests, and seagrass meadows, are at high risk of irreversible phase shifts due to marine heatwaves. Non-climate drivers such as fisheries, oil and gas extraction, cable laying, and mineral resource exploration also influence ocean ecosystems.

