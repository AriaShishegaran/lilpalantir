Storing[](#storing "Permalink to this heading")
================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

LlamaIndex provides a high-level interface for ingesting, indexing, and querying your external data.

Under the hood, LlamaIndex also supports swappable **storage components** that allows you to customize:

* **Document stores**: where ingested documents (i.e., `Node` objects) are stored,
* **Index stores**: where index metadata are stored,
* **Vector stores**: where embedding vectors are stored.
* **Graph stores**: where knowledge graphs are stored (i.e. for `KnowledgeGraphIndex`).

The Document/Index stores rely on a common Key-Value store abstraction, which is also detailed below.

LlamaIndex supports persisting data to any storage backend supported by [fsspec](https://filesystem-spec.readthedocs.io/en/latest/index.html).We have confirmed support for the following storage backends:

* Local filesystem
* AWS S3
* Cloudflare R2

![](../../_images/storage.png)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Many vector stores (except FAISS) will store both the data as well as the index (embeddings). This means that you will not need to use a separate document store or index store. This *also* means that you will not need to explicitly persist this data - this happens automatically. Usage would look something like the following to build a new index / reload an existing one.


```
## build a new indexfrom llama\_index import VectorStoreIndex, StorageContextfrom llama\_index.vector\_stores import DeepLakeVectorStore# construct vector store and customize storage contextvector\_store = DeepLakeVectorStore(dataset\_path="<dataset\_path>")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# Load documents and build indexindex = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)## reload an existing oneindex = VectorStoreIndex.from\_vector\_store(vector\_store=vector\_store)
```
See our [Vector Store Module Guide](vector_stores.html) below for more details.

Note that in general to use storage abstractions, you need to define a `StorageContext` object:


```
from llama\_index.storage.docstore import SimpleDocumentStorefrom llama\_index.storage.index\_store import SimpleIndexStorefrom llama\_index.vector\_stores import SimpleVectorStorefrom llama\_index.storage import StorageContext# create storage context using default storesstorage\_context = StorageContext.from\_defaults(    docstore=SimpleDocumentStore(),    vector\_store=SimpleVectorStore(),    index\_store=SimpleIndexStore(),)
```
More details on customization/persistence can be found in the guides below.

* [Customizing Storage](customization.html)
* [Persisting & Loading Data](save_load.html)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

We offer in-depth guides on the different storage components.

* [Vector Stores](vector_stores.html)
* [Document Stores](docstores.html)
* [Index Stores](index_stores.html)
* [Key-Value Stores](kv_stores.html)
* [Using Graph Stores](../../community/integrations/graph_stores.html)
