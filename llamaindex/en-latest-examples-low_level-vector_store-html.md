[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/low_level/vector_store.ipynb)

Building a (Very Simple) Vector Store from Scratch[](#building-a-very-simple-vector-store-from-scratch "Permalink to this heading")
====================================================================================================================================

In this tutorial, we show you how to build a simple in-memory vector store that can store documents along with metadata. It will also expose a query interface that can support a variety of queries:

* semantic search (with embedding similarity)
* metadata filtering

**NOTE**: Obviously this is not supposed to be a replacement for any actual vector store (e.g. Pinecone, Weaviate, Chroma, Qdrant, Milvus, or others within our wide range of vector store integrations). This is more to teach some key retrieval concepts, like top-k embedding search + metadata filtering.

We won’t be covering advanced query/retrieval concepts such as approximate nearest neighbors, sparse/hybrid search, or any of the system concepts that would be required for building an actual database.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We load in some documents, and parse them into Node objects - chunks that are ready to be inserted into a vector store.

### Load in Documents[](#load-in-documents "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()documents = loader.load(file\_path="./data/llama2.pdf")
```
### Parse into Nodes[](#parse-into-nodes "Permalink to this heading")


```
from llama\_index.node\_parser import SimpleNodeParsernode\_parser = SimpleNodeParser.from\_defaults(chunk\_size=256)nodes = node\_parser.get\_nodes\_from\_documents(documents)
```
### Generate Embeddings for each Node[](#generate-embeddings-for-each-node "Permalink to this heading")


```
from llama\_index.embeddings import OpenAIEmbeddingembed\_model = OpenAIEmbedding()for node in nodes:    node\_embedding = embed\_model.get\_text\_embedding(        node.get\_content(metadata\_mode="all")    )    node.embedding = node\_embedding
```
Build a Simple In-Memory Vector Store[](#build-a-simple-in-memory-vector-store "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

Now we’ll build our in-memory vector store. We’ll store Nodes within a simple Python dictionary. We’ll start off implementing embedding search, and add metadata filters.

### 1. Defining the Interface[](#defining-the-interface "Permalink to this heading")

We’ll first define the interface for building a vector store. It contains the following items:

* `get`
* `add`
* `delete`
* `query`
* `persist` (which we will not implement)


```
from llama\_index.vector\_stores.types import (    VectorStore,    VectorStoreQuery,    VectorStoreQueryResult,)from typing import List, Any, Optional, Dictfrom llama\_index.schema import TextNode, BaseNodeimport osclass BaseVectorStore(VectorStore): """Simple custom Vector Store. Stores documents in a simple in-memory dict. """    stores\_text: bool = True    def get(self, text\_id: str) -> List[float]: """Get embedding."""        pass    def add(        self,        nodes: List[BaseNode],    ) -> List[str]: """Add nodes to index."""        pass    def delete(self, ref\_doc\_id: str, \*\*delete\_kwargs: Any) -> None: """ Delete nodes using with ref\_doc\_id. Args: ref\_doc\_id (str): The doc\_id of the document to delete. """        pass    def query(        self,        query: VectorStoreQuery,        \*\*kwargs: Any,    ) -> VectorStoreQueryResult: """Get nodes for response."""        pass    def persist(self, persist\_path, fs=None) -> None: """Persist the SimpleVectorStore to a directory. NOTE: we are not implementing this for now. """        pass
```
At a high-level, we subclass our base `VectorStore` abstraction. There’s no inherent reason to do this if you’re just building a vector store from scratch. We do it because it makes it easy to plug into our downstream abstractions later.

Let’s look at some of the classes defined here.

* `BaseNode` is simply the parent class of our core Node modules. Each Node represents a text chunk + associated metadata.
* We also use some lower-level constructs, for instance our `VectorStoreQuery` and `VectorStoreQueryResult`. These are just lightweight dataclass containers to represent queries and results. We look at the dataclass fields below.


```
from dataclasses import fields{f.name: f.type for f in fields(VectorStoreQuery)}
```

```
{'query_embedding': typing.Optional[typing.List[float]], 'similarity_top_k': int, 'doc_ids': typing.Optional[typing.List[str]], 'node_ids': typing.Optional[typing.List[str]], 'query_str': typing.Optional[str], 'output_fields': typing.Optional[typing.List[str]], 'embedding_field': typing.Optional[str], 'mode': <enum 'VectorStoreQueryMode'>, 'alpha': typing.Optional[float], 'filters': typing.Optional[llama_index.vector_stores.types.MetadataFilters], 'mmr_threshold': typing.Optional[float], 'sparse_top_k': typing.Optional[int]}
```

```
{f.name: f.type for f in fields(VectorStoreQueryResult)}
```

```
{'nodes': typing.Optional[typing.Sequence[llama_index.schema.BaseNode]], 'similarities': typing.Optional[typing.List[float]], 'ids': typing.Optional[typing.List[str]]}
```
### 2. Defining `add`, `get`, and `delete`[](#defining-add-get-and-delete "Permalink to this heading")

We add some basic capabilities to add, get, and delete from a vector store.

The implementation is very simple (everything is just stored in a python dictionary).


```
class VectorStore2(BaseVectorStore): """VectorStore2 (add/get/delete implemented)."""    stores\_text: bool = True    def \_\_init\_\_(self) -> None: """Init params."""        self.node\_dict: Dict[str, BaseNode] = {}    def get(self, text\_id: str) -> List[float]: """Get embedding."""        return self.node\_dict[text\_id]    def add(        self,        nodes: List[BaseNode],    ) -> List[str]: """Add nodes to index."""        for node in nodes:            self.node\_dict[node.node\_id] = node    def delete(self, node\_id: str, \*\*delete\_kwargs: Any) -> None: """ Delete nodes using with node\_id. Args: node\_id: str """        del self.node\_dict[node\_id]
```
We run some basic tests just to show it works well.


```
test\_node = TextNode(id\_="id1", text="hello world")test\_node2 = TextNode(id\_="id2", text="foo bar")test\_nodes = [test\_node, test\_node2]
```

```
vector\_store = VectorStore2()
```

```
vector\_store.add(test\_nodes)
```

```
node = vector\_store.get("id1")print(str(node))
```

```
Node ID: id1Text: hello world
```
### 3.a Defining `query` (semantic search)[](#a-defining-query-semantic-search "Permalink to this heading")

We implement a basic version of top-k semantic search. This simply iterates through all document embeddings, and compute cosine-similarity with the query embedding. The top-k documents by cosine similarity are returned.

Cosine similarity: $\dfrac{\vec{d}\vec{q}}{|\vec{d}||\vec{q}|}$ for every document, query embedding pair $\vec{d}$, $\vec{p}$.

**NOTE**: The top-k value is contained in the `VectorStoreQuery` container.

**NOTE**: Similar to the above, we define another subclass just so we don’t have to reimplement the above functions (not because this is actually good code practice).


```
from typing import Tupleimport numpy as npdef get\_top\_k\_embeddings(    query\_embedding: List[float],    doc\_embeddings: List[List[float]],    doc\_ids: List[str],    similarity\_top\_k: int = 5,) -> Tuple[List[float], List]: """Get top nodes by similarity to the query."""    # dimensions: D    qembed\_np = np.array(query\_embedding)    # dimensions: N x D    dembed\_np = np.array(doc\_embeddings)    # dimensions: N    dproduct\_arr = np.dot(dembed\_np, qembed\_np)    # dimensions: N    norm\_arr = np.linalg.norm(qembed\_np) \* np.linalg.norm(        dembed\_np, axis=1, keepdims=False    )    # dimensions: N    cos\_sim\_arr = dproduct\_arr / norm\_arr    # now we have the N cosine similarities for each document    # sort by top k cosine similarity, and return ids    tups = [(cos\_sim\_arr[i], doc\_ids[i]) for i in range(len(doc\_ids))]    sorted\_tups = sorted(tups, key=lambda t: t[0], reverse=True)    sorted\_tups = sorted\_tups[:similarity\_top\_k]    result\_similarities = [s for s, \_ in sorted\_tups]    result\_ids = [n for \_, n in sorted\_tups]    return result\_similarities, result\_ids
```

```
class VectorStore3A(VectorStore2): """Implements semantic/dense search."""    def query(        self,        query: VectorStoreQuery,        \*\*kwargs: Any,    ) -> VectorStoreQueryResult: """Get nodes for response."""        query\_embedding = cast(List[float], query.query\_embedding)        doc\_embeddings = [n.embedding for n in self.node\_dict.values()]        doc\_ids = [n.node\_id for n in self.node\_dict.values()]        similarities, node\_ids = get\_top\_k\_embeddings(            query\_embedding,            embeddings,            doc\_ids,            similarity\_top\_k=query.similarity\_top\_k,        )        result\_nodes = [self.node\_dict[node\_id] for node\_id in node\_ids]        return VectorStoreQueryResult(            nodes=result\_nodes, similarities=similarities, ids=node\_ids        )
```
### 3.b. Supporting Metadata Filtering[](#b-supporting-metadata-filtering "Permalink to this heading")

The next extension is adding metadata filter support. This means that we will first filter the candidate set with documents that pass the metadata filters, and then perform semantic querying.

For simplicity we use metadata filters for exact matching with an AND condition.


```
from llama\_index.vector\_stores import MetadataFiltersfrom llama\_index.schema import BaseNodefrom typing import castdef filter\_nodes(nodes: List[BaseNode], filters: MetadataFilters):    filtered\_nodes = []    for node in nodes:        matches = True        for f in filters.filters:            if f.key not in node.metadata:                matches = False                continue            if f.value != node.metadata[f.key]:                matches = False                continue        if matches:            filtered\_nodes.append(node)    return filtered\_nodes
```
We add `filter\_nodes` as a first-pass over the nodes before running semantic search.


```
def dense\_search(query: VectorStoreQuery, nodes: List[BaseNode]): """Dense search."""    query\_embedding = cast(List[float], query.query\_embedding)    doc\_embeddings = [n.embedding for n in nodes]    doc\_ids = [n.node\_id for n in nodes]    return get\_top\_k\_embeddings(        query\_embedding,        doc\_embeddings,        doc\_ids,        similarity\_top\_k=query.similarity\_top\_k,    )class VectorStore3B(VectorStore2): """Implements Metadata Filtering."""    def query(        self,        query: VectorStoreQuery,        \*\*kwargs: Any,    ) -> VectorStoreQueryResult: """Get nodes for response."""        # 1. First filter by metadata        nodes = self.node\_dict.values()        if query.filters is not None:            nodes = filter\_nodes(nodes, query.filters)        if len(nodes) == 0:            result\_nodes = []            similarities = []            node\_ids = []        else:            # 2. Then perform semantic search            similarities, node\_ids = dense\_search(query, nodes)            result\_nodes = [self.node\_dict[node\_id] for node\_id in node\_ids]        return VectorStoreQueryResult(            nodes=result\_nodes, similarities=similarities, ids=node\_ids        )
```
### 4. Load Data into our Vector Store[](#load-data-into-our-vector-store "Permalink to this heading")

Let’s load our text chunks into the vector store, and run it on different types of queries: dense search, w/ metadata filters, and more.


```
vector\_store = VectorStore3B()# load data into the vector storesvector\_store.add(nodes)
```
Define an example question and embed it.


```
query\_str = "Can you tell me about the key concepts for safety finetuning"query\_embedding = embed\_model.get\_query\_embedding(query\_str)
```
#### Query the vector store with dense search.[](#query-the-vector-store-with-dense-search "Permalink to this heading")


```
query\_obj = VectorStoreQuery(    query\_embedding=query\_embedding, similarity\_top\_k=2)query\_result = vector\_store.query(query\_obj)for similarity, node in zip(query\_result.similarities, query\_result.nodes):    print(        "\n----------------\n"        f"[Node ID {node.node\_id}] Similarity: {similarity}\n\n"        f"{node.get\_content(metadata\_mode='all')}"        "\n----------------\n\n"    )
```

```
----------------[Node ID 3f74fdf4-0e2e-473e-9b07-10c51eb62794] Similarity: 0.835677131511819total_pages: 77file_path: ./data/llama2.pdfsource: 23Specifically, we use the following techniques in safety fine-tuning:1. Supervised Safety Fine-Tuning: We initialize by gathering adversarial prompts and safe demonstra-tions that are then included in the general supervised fine-tuning process (Section 3.1). This teachesthe model to align with our safety guidelines even before RLHF, and thus lays the foundation forhigh-quality human preference data annotation.2. Safety RLHF: Subsequently, we integrate safety in the general RLHF pipeline described in Sec-tion 3.2.2. This includes training a safety-specific reward model and gathering more challengingadversarial prompts for rejection sampling style fine-tuning and PPO optimization.3. Safety Context Distillation: Finally, we refine our RLHF pipeline with context distillation (Askellet al., 2021b).--------------------------------[Node ID 5ad5efb3-8442-4e8a-b35a-cc3a10551dc9] Similarity: 0.827877930608312total_pages: 77file_path: ./data/llama2.pdfsource: 23Benchmarks give a summary view of model capabilities and behaviors that allow us to understand generalpatterns in the model, but they do not provide a fully comprehensive view of the impact the model may haveon people or real-world outcomes; that would require study of end-to-end product deployments. Furthertesting and mitigation should be done to understand bias and other social issues for the specific contextin which a system may be deployed. For this, it may be necessary to test beyond the groups available inthe BOLD dataset (race, religion, and gender). As LLMs are integrated and deployed, we look forward tocontinuing research that will amplify their potential for positive impact on these important social issues.4.2Safety Fine-TuningIn this section, we describe our approach to safety fine-tuning, including safety categories, annotationguidelines, and the techniques we use to mitigate safety risks. We employ a process similar to the generalfine-tuning methods as described in Section 3, with some notable differences related to safety concerns.----------------
```
#### Query the vector store with dense search + Metadata Filters[](#query-the-vector-store-with-dense-search-metadata-filters "Permalink to this heading")


```
# filters = MetadataFilters(# filters=[# ExactMatchFilter(key="page", value=3)# ]# )filters = MetadataFilters.from\_dict({"source": "24"})query\_obj = VectorStoreQuery(    query\_embedding=query\_embedding, similarity\_top\_k=2, filters=filters)query\_result = vector\_store.query(query\_obj)for similarity, node in zip(query\_result.similarities, query\_result.nodes):    print(        "\n----------------\n"        f"[Node ID {node.node\_id}] Similarity: {similarity}\n\n"        f"{node.get\_content(metadata\_mode='all')}"        "\n----------------\n\n"    )
```

```
----------------[Node ID efe54bc0-4f9f-49ad-9dd5-900395a092fa] Similarity: 0.8190195580569283total_pages: 77file_path: ./data/llama2.pdfsource: 244.2.2Safety Supervised Fine-TuningIn accordance with the established guidelines from Section 4.2.1, we gather prompts and demonstrationsof safe model responses from trained annotators, and use the data for supervised fine-tuning in the samemanner as described in Section 3.1. An example can be found in Table 5.The annotators are instructed to initially come up with prompts that they think could potentially inducethe model to exhibit unsafe behavior, i.e., perform red teaming, as defined by the guidelines. Subsequently,annotators are tasked with crafting a safe and helpful response that the model should produce.4.2.3Safety RLHFWe observe early in the development of Llama 2-Chat that it is able to generalize from the safe demonstrationsin supervised fine-tuning. The model quickly learns to write detailed safe responses, address safety concerns,explain why the topic might be sensitive, and provide additional helpful information.--------------------------------[Node ID 619c884b-cdbc-44b2-aec0-2692b44740ee] Similarity: 0.8010811332867503total_pages: 77file_path: ./data/llama2.pdfsource: 24In particular, whenthe model outputs safe responses, they are often more detailed than what the average annotator writes.Therefore, after gathering only a few thousand supervised demonstrations, we switched entirely to RLHF toteach the model how to write more nuanced responses. Comprehensive tuning with RLHF has the addedbenefit that it may make the model more robust to jailbreak attempts (Bai et al., 2022a).We conduct RLHF by first collecting human preference data for safety similar to Section 3.2.2: annotatorswrite a prompt that they believe can elicit unsafe behavior, and then compare multiple model responses tothe prompts, selecting the response that is safest according to a set of guidelines. We then use the humanpreference data to train a safety reward model (see Section 3.2.2), and also reuse the adversarial prompts tosample from the model during the RLHF stage.Better Long-Tail Safety Robustness without Hurting HelpfulnessSafety is inherently a long-tail problem,where the challenge comes from a small number of very specific cases.----------------
```
Build a RAG System with the Vector Store[](#build-a-rag-system-with-the-vector-store "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

Now that we’ve built the RAG system, it’s time to plug it into our downstream system!


```
from llama\_index import VectorStoreIndex
```

```
index = VectorStoreIndex.from\_vector\_store(vector\_store)
```

```
query\_engine = index.as\_query\_engine()
```

```
query\_str = "Can you tell me about the key concepts for safety finetuning"
```

```
response = query\_engine.query(query\_str)
```

```
print(str(response))
```

```
The key concepts for safety fine-tuning include supervised safety fine-tuning, safety RLHF (Reinforcement Learning from Human Feedback), and safety context distillation. Supervised safety fine-tuning involves gathering adversarial prompts and safe demonstrations to align the model with safety guidelines before RLHF. Safety RLHF integrates safety into the RLHF pipeline by training a safety-specific reward model and gathering more challenging adversarial prompts for fine-tuning and optimization. Finally, safety context distillation is used to refine the RLHF pipeline. These techniques aim to mitigate safety risks and ensure that the model aligns with safety guidelines.
```
Conclusion[](#conclusion "Permalink to this heading")
------------------------------------------------------

That’s it! We’ve built a simple in-memory vector store that supports very simple inserts, gets, deletes, and supports dense search and metadata filtering. This can then be plugged into the rest of LlamaIndex abstractions.

It doesn’t support sparse search yet and is obviously not meant to be used in any sort of actual app. But this should expose some of what’s going on under the hood!

