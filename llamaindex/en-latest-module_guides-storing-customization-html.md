Customizing Storage[](#customizing-storage "Permalink to this heading")
========================================================================

By default, LlamaIndex hides away the complexities and let you query your data in under 5 lines of code:


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("Summarize the documents.")
```
Under the hood, LlamaIndex also supports a swappable **storage layer** that allows you to customize where ingested documents (i.e., `Node` objects), embedding vectors, and index metadata are stored.

![](../../_images/storage.png)

Low-Level API[](#low-level-api "Permalink to this heading")
------------------------------------------------------------

To do this, instead of the high-level API,


```
index = VectorStoreIndex.from\_documents(documents)
```
we use a lower-level API that gives more granular control:


```
from llama\_index.storage.docstore import SimpleDocumentStorefrom llama\_index.storage.index\_store import SimpleIndexStorefrom llama\_index.vector\_stores import SimpleVectorStorefrom llama\_index.node\_parser import SimpleNodeParser# create parser and parse document into nodesparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)# create storage context using default storesstorage\_context = StorageContext.from\_defaults(    docstore=SimpleDocumentStore(),    vector\_store=SimpleVectorStore(),    index\_store=SimpleIndexStore(),)# create (or load) docstore and add nodesstorage\_context.docstore.add\_documents(nodes)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)# save indexindex.storage\_context.persist(persist\_dir="<persist\_dir>")# can also set index\_id to save multiple indexes to the same folderindex.set\_index\_id("<index\_id>")index.storage\_context.persist(persist\_dir="<persist\_dir>")# to load index later, make sure you setup the storage context# this will loaded the persisted stores from persist\_dirstorage\_context = StorageContext.from\_defaults(persist\_dir="<persist\_dir>")# then load the index objectfrom llama\_index import load\_index\_from\_storageloaded\_index = load\_index\_from\_storage(storage\_context)# if loading an index from a persist\_dir containing multiple indexesloaded\_index = load\_index\_from\_storage(storage\_context, index\_id="<index\_id>")# if loading multiple indexes from a persist dirloaded\_indicies = load\_index\_from\_storage(    storage\_context, index\_ids=["<index\_id>", ...])
```
You can customize the underlying storage with a one-line change to instantiate different document stores, index stores, and vector stores.See [Document Stores](docstores.html), [Vector Stores](vector_stores.html), [Index Stores](index_stores.html) guides for more details.

For saving and loading a graph/composable index, see the [full guide](../indexing/composability.html).

Vector Store Integrations and Storage[](#vector-store-integrations-and-storage "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

Most of our vector store integrations store the entire index (vectors + text) in the vector store itself. This comes with the major benefit of not having to explicitly persist the index as shown above, since the vector store is already hosted and persisting the data in our index.

The vector stores that support this practice are:

* CognitiveSearchVectorStore
* ChatGPTRetrievalPluginClient
* CassandraVectorStore
* ChromaVectorStore
* EpsillaVectorStore
* DocArrayHnswVectorStore
* DocArrayInMemoryVectorStore
* LanceDBVectorStore
* MetalVectorStore
* MilvusVectorStore
* MyScaleVectorStore
* OpensearchVectorStore
* PineconeVectorStore
* QdrantVectorStore
* RedisVectorStore
* WeaviateVectorStore

A small example using Pinecone is below:


```
import pineconefrom llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import PineconeVectorStore# Creating a Pinecone indexapi\_key = "api\_key"pinecone.init(api\_key=api\_key, environment="us-west1-gcp")pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")index = pinecone.Index("quickstart")# construct vector storevector\_store = PineconeVectorStore(pinecone\_index=index)# create storage contextstorage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# load documentsdocuments = SimpleDirectoryReader("./data").load\_data()# create index, which will insert documents/vectors to pineconeindex = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
If you have an existing vector store with data already loaded in,you can connect to it and directly create a `VectorStoreIndex` as follows:


```
index = pinecone.Index("quickstart")vector\_store = PineconeVectorStore(pinecone\_index=index)loaded\_index = VectorStoreIndex.from\_vector\_store(vector\_store=vector\_store)
```
