Storing[](#storing "Permalink to this heading")
================================================

Once you have data [loaded](../loading/loading.html) and [indexed](../indexing/indexing.html), you will probably want to store it to avoid the time and cost of re-indexing it. By default, your indexed data is stored only in memory.

Persisting to disk[](#persisting-to-disk "Permalink to this heading")
----------------------------------------------------------------------

The simplest way to store your indexed data is to use the built-in `.persist()` method of every Index, which writes all the data to disk at the location specified. This works for any type of index.


```
index.storage\_context.persist(persist\_dir="<persist\_dir>")
```
Here is an example for Composable Graph:


```
graph.root\_index.storage\_context.persist(persist\_dir="<persist\_dir>")
```
You can then avoid re-loading and re-indexing your data by loading the persisted index like this:


```
from llama\_index import StorageContext, load\_index\_from\_storage# rebuild storage contextstorage\_context = StorageContext.from\_defaults(persist\_dir="<persist\_dir>")# load indexindex = load\_index\_from\_storage(storage\_context)
```
Tip

Important: if you had initialized your index with a custom`ServiceContext` object, you will need to pass in the sameServiceContext during `load\_index\_from\_storage`, or have it set as the [global service context](../../module_guides/supporting_modules/service_context.html).

Using Vector Stores[](#using-vector-stores "Permalink to this heading")
------------------------------------------------------------------------

As discussed in [indexing](../indexing/indexing.html), one of the most common types of Index is the VectorStoreIndex. The API calls to create the [embeddings](../indexing/indexing.html#what-is-an-embedding) in a VectorStoreIndex can be expensive in terms of time and money, so you will want to store them to avoid having to constantly re-index things.

LlamaIndex supports a [huge number of vector stores](../../module_guides/storing/vector_stores.html) which vary in architecture, complexity and cost. In this example we’ll be using Chroma, an open-source vector store.

First you will need to install chroma:


```
pip install chromadb
```
To use Chroma to store the embeddings from a VectorStoreIndex, you need to:

* initialize the Chroma client
* create a Collection to store your data in Chroma
* assign Chroma as the `vector\_store` in a `StorageContext`
* initialize your VectorStoreIndex using that StorageContext

Here’s what that looks like, with a sneak peek at actually querying the data:


```
import chromadbfrom llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import ChromaVectorStorefrom llama\_index.storage.storage\_context import StorageContext# load some documentsdocuments = SimpleDirectoryReader("./data").load\_data()# initialize client, setting path to save datadb = chromadb.PersistentClient(path="./chroma\_db")# create collectionchroma\_collection = db.get\_or\_create\_collection("quickstart")# assign chroma as the vector\_store to the contextvector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# create your indexindex = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# create a query engine and queryquery\_engine = index.as\_query\_engine()response = query\_engine.query("What is the meaning of life?")print(response)
```
If you’ve already created and stored your embeddings, you’ll want to load them directly without loading your documents or creating a new VectorStoreIndex:


```
import chromadbfrom llama\_index import VectorStoreIndexfrom llama\_index.vector\_stores import ChromaVectorStorefrom llama\_index.storage.storage\_context import StorageContext# initialize clientdb = chromadb.PersistentClient(path="./chroma\_db")# get collectionchroma\_collection = db.get\_or\_create\_collection("quickstart")# assign chroma as the vector\_store to the contextvector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# load your index from stored vectorsindex = VectorStoreIndex.from\_vector\_store(    vector\_store, storage\_context=storage\_context)# create a query enginequery\_engine = index.as\_query\_engine()response = query\_engine.query("What is llama2?")print(response)
```
Tip

We have a [more thorough example of using Chroma](../../examples/vector_stores/ChromaIndexDemo.html) if you want to go deeper on this store.

### You’re ready to query![](#you-re-ready-to-query "Permalink to this heading")

Now you have loaded data, indexed it, and stored that index, you’re ready to [query your data](../querying/querying.html).

Inserting Documents or Nodes[](#inserting-documents-or-nodes "Permalink to this heading")
------------------------------------------------------------------------------------------

If you’ve already created an index, you can add new documents to your index using the `insert` method.


```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex([])for doc in documents:    index.insert(doc)
```
See the [document management how-to](../../module_guides/indexing/document_management.html) for more details on managing documents and an example notebook.

