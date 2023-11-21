Key-Value Stores[](#key-value-stores "Permalink to this heading")
==================================================================

Key-Value stores are the underlying storage abstractions that power our [Document Stores](docstores.html) and [Index Stores](index_stores.html).

We provide the following key-value stores:

* **Simple Key-Value Store**: An in-memory KV store. The user can choose to call `persist` on this kv store to persist data to disk.
* **MongoDB Key-Value Store**: A MongoDB KV store.

See the [API Reference](../../api_reference/storage/kv_store.html) for more details.

Note: At the moment, these storage abstractions are not externally facing.

