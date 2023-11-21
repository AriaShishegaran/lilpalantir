Document Stores[](#document-stores "Permalink to this heading")
================================================================

Document stores contain ingested document chunks, which we call `Node` objects.

See the [API Reference](../../api_reference/storage/docstore.html) for more details.

Simple Document Store[](#simple-document-store "Permalink to this heading")
----------------------------------------------------------------------------

By default, the `SimpleDocumentStore` stores `Node` objects in-memory.They can be persisted to (and loaded from) disk by calling `docstore.persist()` (and `SimpleDocumentStore.from\_persist\_path(...)` respectively).

A more complete example can be found [here](../../examples/docstore/DocstoreDemo.html)

MongoDB Document Store[](#mongodb-document-store "Permalink to this heading")
------------------------------------------------------------------------------

We support MongoDB as an alternative document store backend that persists data as `Node` objects are ingested.


```
from llama\_index.storage.docstore import MongoDocumentStorefrom llama\_index.node\_parser import SimpleNodeParser# create parser and parse document into nodesparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)# create (or load) docstore and add nodesdocstore = MongoDocumentStore.from\_uri(uri="<mongodb+srv://...>")docstore.add\_documents(nodes)# create storage contextstorage\_context = StorageContext.from\_defaults(docstore=docstore)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Under the hood, `MongoDocumentStore` connects to a fixed MongoDB database and initializes new collections (or loads existing collections) for your nodes.


> Note: You can configure the `db\_name` and `namespace` when instantiating `MongoDocumentStore`, otherwise they default to `db\_name="db\_docstore"` and `namespace="docstore"`.
> 
> 

Note that it’s not necessary to call `storage\_context.persist()` (or `docstore.persist()`) when using an `MongoDocumentStore`since data is persisted by default.

You can easily reconnect to your MongoDB collection and reload the index by re-initializing a `MongoDocumentStore` with an existing `db\_name` and `collection\_name`.

A more complete example can be found [here](../../examples/docstore/MongoDocstoreDemo.html)

Redis Document Store[](#redis-document-store "Permalink to this heading")
--------------------------------------------------------------------------

We support Redis as an alternative document store backend that persists data as `Node` objects are ingested.


```
from llama\_index.storage.docstore import RedisDocumentStorefrom llama\_index.node\_parser import SimpleNodeParser# create parser and parse document into nodesparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)# create (or load) docstore and add nodesdocstore = RedisDocumentStore.from\_host\_and\_port(    host="127.0.0.1", port="6379", namespace="llama\_index")docstore.add\_documents(nodes)# create storage contextstorage\_context = StorageContext.from\_defaults(docstore=docstore)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Under the hood, `RedisDocumentStore` connects to a redis database and adds your nodes to a namespace stored under `{namespace}/docs`.


> Note: You can configure the `namespace` when instantiating `RedisDocumentStore`, otherwise it defaults `namespace="docstore"`.
> 
> 

You can easily reconnect to your Redis client and reload the index by re-initializing a `RedisDocumentStore` with an existing `host`, `port`, and `namespace`.

A more complete example can be found [here](../../examples/docstore/RedisDocstoreIndexStoreDemo.html)

Firestore Document Store[](#firestore-document-store "Permalink to this heading")
----------------------------------------------------------------------------------

We support Firestore as an alternative document store backend that persists data as `Node` objects are ingested.


```
from llama\_index.storage.docstore import FirestoreDocumentStorefrom llama\_index.node\_parser import SimpleNodeParser# create parser and parse document into nodesparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)# create (or load) docstore and add nodesdocstore = FirestoreDocumentStore.from\_dataabse(    project="project-id",    database="(default)",)docstore.add\_documents(nodes)# create storage contextstorage\_context = StorageContext.from\_defaults(docstore=docstore)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Under the hood, `FirestoreDocumentStore` connects to a firestore database in Google Cloud and adds your nodes to a namespace stored under `{namespace}/docs`.


> Note: You can configure the `namespace` when instantiating `FirestoreDocumentStore`, otherwise it defaults `namespace="docstore"`.
> 
> 

You can easily reconnect to your Firestore database and reload the index by re-initializing a `FirestoreDocumentStore` with an existing `project`, `database`, and `namespace`.

A more complete example can be found [here](../../examples/docstore/FirestoreDemo.html)

