[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/low_level/retrieval.ipynb)

Building Retrieval from Scratch[](#building-retrieval-from-scratch "Permalink to this heading")
================================================================================================

In this tutorial, we show you how to build a standard retriever against a vector database, that will fetch nodes via top-k similarity.

We use Pinecone as the vector database. We load in nodes using our high-level ingestion abstractions (to see how to build this from scratch, see our previous tutorial!).

We will show how to do the following:

1. How to generate a query embedding
2. How to query the vector database using different search modes (dense, sparse, hybrid)
3. How to parse results into a set of Nodes
4. How to put this in a custom retriever

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We build an empty Pinecone Index, and define the necessary LlamaIndex wrappers/abstractions so that we can start loading data into Pinecone.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
### Build Pinecone Index[](#build-pinecone-index "Permalink to this heading")


```
import pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp")
```

```
# dimensions are for text-embedding-ada-002pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")
```

```
pinecone\_index = pinecone.Index("quickstart")
```

```
# [Optional] drop contents in indexpinecone\_index.delete(deleteAll=True)
```
### Create PineconeVectorStore[](#create-pineconevectorstore "Permalink to this heading")

Simple wrapper abstraction to use in LlamaIndex. Wrap in StorageContext so we can easily load in Nodes.


```
from llama\_index.vector\_stores import PineconeVectorStore
```

```
vector\_store = PineconeVectorStore(pinecone\_index=pinecone\_index)
```
### Load Documents[](#load-documents "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()documents = loader.load(file\_path="./data/llama2.pdf")
```
### Load into Vector Store[](#load-into-vector-store "Permalink to this heading")

Load in documents into the PineconeVectorStore.

**NOTE**: We use high-level ingestion abstractions here, with `VectorStoreIndex.from\_documents.` We’ll refrain from using `VectorStoreIndex` for the rest of this tutorial.


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.storage import StorageContext
```

```
service\_context = ServiceContext.from\_defaults(chunk\_size=1024)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context, storage\_context=storage\_context)
```
Define Vector Retriever[](#define-vector-retriever "Permalink to this heading")
--------------------------------------------------------------------------------

Now we’re ready to define our retriever against this vector store to retrieve a set of nodes.

We’ll show the processes step by step and then wrap it into a function.


```
query\_str = "Can you tell me about the key concepts for safety finetuning"
```
### 1. Generate a Query Embedding[](#generate-a-query-embedding "Permalink to this heading")


```
from llama\_index.embeddings import OpenAIEmbeddingembed\_model = OpenAIEmbedding()
```

```
query\_embedding = embed\_model.get\_query\_embedding(query\_str)
```
### 2. Query the Vector Database[](#query-the-vector-database "Permalink to this heading")

We show how to query the vector database with different modes: default, sparse, and hybrid.

We first construct a `VectorStoreQuery` and then query the vector db.


```
# construct vector store queryfrom llama\_index.vector\_stores import VectorStoreQueryquery\_mode = "default"# query\_mode = "sparse"# query\_mode = "hybrid"vector\_store\_query = VectorStoreQuery(    query\_embedding=query\_embedding, similarity\_top\_k=2, mode=query\_mode)
```

```
# returns a VectorStoreQueryResultquery\_result = vector\_store.query(vector\_store\_query)query\_result
```
### 3. Parse Result into a set of Nodes[](#parse-result-into-a-set-of-nodes "Permalink to this heading")

The `VectorStoreQueryResult` returns the set of nodes and similarities. We construct a `NodeWithScore` object with this.


```
from llama\_index.schema import NodeWithScorefrom typing import Optionalnodes\_with\_scores = []for index, node in enumerate(query\_result.nodes):    score: Optional[float] = None    if query\_result.similarities is not None:        score = query\_result.similarities[index]    nodes\_with\_scores.append(NodeWithScore(node=node, score=score))
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor node in nodes\_with\_scores:    display\_source\_node(node, source\_length=1000)
```
### 4. Put this into a Retriever[](#put-this-into-a-retriever "Permalink to this heading")

Let’s put this into a Retriever subclass that can plug into the rest of LlamaIndex workflows!


```
from llama\_index import QueryBundlefrom llama\_index.retrievers import BaseRetrieverfrom typing import Any, Listclass PineconeRetriever(BaseRetriever): """Retriever over a pinecone vector store."""    def \_\_init\_\_(        self,        vector\_store: PineconeVectorStore,        embed\_model: Any,        query\_mode: str = "default",        similarity\_top\_k: int = 2,    ) -> None: """Init params."""        self.\_vector\_store = vector\_store        self.\_embed\_model = embed\_model        self.\_query\_mode = query\_mode        self.\_similarity\_top\_k = similarity\_top\_k    def \_retrieve(self, query\_bundle: QueryBundle) -> List[NodeWithScore]: """Retrieve."""        query\_embedding = embed\_model.get\_query\_embedding(query\_str)        vector\_store\_query = VectorStoreQuery(            query\_embedding=query\_embedding,            similarity\_top\_k=self.\_similarity\_top\_k,            mode=self.\_query\_mode,        )        query\_result = vector\_store.query(vector\_store\_query)        nodes\_with\_scores = []        for index, node in enumerate(query\_result.nodes):            score: Optional[float] = None            if query\_result.similarities is not None:                score = query\_result.similarities[index]            nodes\_with\_scores.append(NodeWithScore(node=node, score=score))        return nodes\_with\_scores
```

```
retriever = PineconeRetriever(    vector\_store, embed\_model, query\_mode="default", similarity\_top\_k=2)
```

```
retrieved\_nodes = retriever.retrieve(query\_str)for node in retrieved\_nodes:    display\_source\_node(node, source\_length=1000)
```
Plug this into our RetrieverQueryEngine to synthesize a response[](#plug-this-into-our-retrieverqueryengine-to-synthesize-a-response "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------------------

**NOTE**: We’ll cover more on how to build response synthesis from scratch in future tutorials!


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(retriever)
```

```
response = query\_engine.query(query\_str)
```

```
print(str(response))
```

```
The key concepts for safety fine-tuning include supervised safety fine-tuning, safety RLHF (Reinforcement Learning from Human Feedback), and safety context distillation. Supervised safety fine-tuning involves gathering adversarial prompts and safe demonstrations to train the model to align with safety guidelines. Safety RLHF integrates safety into the RLHF pipeline by training a safety-specific reward model and gathering challenging adversarial prompts for fine-tuning. Safety context distillation refines the RLHF pipeline by generating safer model responses using a safety preprompt and fine-tuning the model on these responses without the preprompt. These concepts are used to mitigate safety risks and improve the safety of the model's responses.
```
