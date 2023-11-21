Index Stores[](#index-stores "Permalink to this heading")
==========================================================

Index stores contains lightweight index metadata (i.e. additional state information created when building an index).

See the [API Reference](../../api_reference/storage/index_store.html) for more details.

Simple Index Store[](#simple-index-store "Permalink to this heading")
----------------------------------------------------------------------

By default, LlamaIndex uses a simple index store backed by an in-memory key-value store.They can be persisted to (and loaded from) disk by calling `index\_store.persist()` (and `SimpleIndexStore.from\_persist\_path(...)` respectively).

MongoDB Index Store[](#mongodb-index-store "Permalink to this heading")
------------------------------------------------------------------------

Similarly to document stores, we can also use `MongoDB` as the storage backend of the index store.


```
from llama\_index.storage.index\_store import MongoIndexStorefrom llama\_index import VectorStoreIndex# create (or load) index storeindex\_store = MongoIndexStore.from\_uri(uri="<mongodb+srv://...>")# create storage contextstorage\_context = StorageContext.from\_defaults(index\_store=index\_store)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)# or alternatively, load indexfrom llama\_index import load\_index\_from\_storageindex = load\_index\_from\_storage(storage\_context)
```
Under the hood, `MongoIndexStore` connects to a fixed MongoDB database and initializes new collections (or loads existing collections) for your index metadata.


> Note: You can configure the `db\_name` and `namespace` when instantiating `MongoIndexStore`, otherwise they default to `db\_name="db\_docstore"` and `namespace="docstore"`.
> 
> 

Note that it’s not necessary to call `storage\_context.persist()` (or `index\_store.persist()`) when using an `MongoIndexStore`since data is persisted by default.

You can easily reconnect to your MongoDB collection and reload the index by re-initializing a `MongoIndexStore` with an existing `db\_name` and `collection\_name`.

A more complete example can be found [here](../../examples/docstore/MongoDocstoreDemo.html)

Redis Index Store[](#redis-index-store "Permalink to this heading")
--------------------------------------------------------------------

We support Redis as an alternative document store backend that persists data as `Node` objects are ingested.


```
from llama\_index.storage.index\_store import RedisIndexStorefrom llama\_index import VectorStoreIndex# create (or load) docstore and add nodesindex\_store = RedisIndexStore.from\_host\_and\_port(    host="127.0.0.1", port="6379", namespace="llama\_index")# create storage contextstorage\_context = StorageContext.from\_defaults(index\_store=index\_store)# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)# or alternatively, load indexfrom llama\_index import load\_index\_from\_storageindex = load\_index\_from\_storage(storage\_context)
```
Under the hood, `RedisIndexStore` connects to a redis database and adds your nodes to a namespace stored under `{namespace}/index`.


> Note: You can configure the `namespace` when instantiating `RedisIndexStore`, otherwise it defaults `namespace="index\_store"`.
> 
> 

You can easily reconnect to your Redis client and reload the index by re-initializing a `RedisIndexStore` with an existing `host`, `port`, and `namespace`.

A more complete example can be found [here](../../examples/docstore/RedisDocstoreIndexStoreDemo.html)

