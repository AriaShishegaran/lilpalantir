Document Store[](#module-llama_index.storage.docstore "Permalink to this heading")
===================================================================================

*class* llama\_index.storage.docstore.BaseDocumentStore[](#llama_index.storage.docstore.BaseDocumentStore "Permalink to this definition")*abstract* delete\_document(*doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.BaseDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

*abstract* delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.BaseDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*abstract* get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.BaseDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.BaseDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.BaseDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.BaseDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
*abstract* get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.BaseDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.BaseDocumentStore.persist "Permalink to this definition")Persist the docstore to a file.

llama\_index.storage.docstore.DocumentStore[](#llama_index.storage.docstore.DocumentStore "Permalink to this definition")alias of [`SimpleDocumentStore`](#llama_index.storage.docstore.SimpleDocumentStore "llama_index.storage.docstore.simple_docstore.SimpleDocumentStore")

*class* llama\_index.storage.docstore.FirestoreDocumentStore(*firestore\_kvstore: [FirestoreKVStore](kv_store.html#llama_index.storage.kvstore.FirestoreKVStore "llama_index.storage.kvstore.firestore_kvstore.FirestoreKVStore")*, *namespace: Optional[str] = None*)[](#llama_index.storage.docstore.FirestoreDocumentStore "Permalink to this definition")Firestore Document (Node) store.

A Firestore store for Document and Node objects.

Parameters* **firestore\_kvstore** ([*FirestoreKVStore*](index_store.html#llama_index.storage.index_store.FirestoreKVStore "llama_index.storage.index_store.FirestoreKVStore")) – Firestore key-value store
* **namespace** (*str*) – namespace for the docstore
add\_documents(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *allow\_update: bool = True*) → None[](#llama_index.storage.docstore.FirestoreDocumentStore.add_documents "Permalink to this definition")Add a document to the store.

Parameters* **docs** (*List**[**BaseDocument**]*) – documents
* **allow\_update** (*bool*) – allow update of docstore from document
delete\_document(*doc\_id: str*, *raise\_error: bool = True*, *remove\_ref\_doc\_node: bool = True*) → None[](#llama_index.storage.docstore.FirestoreDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.FirestoreDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*property* docs*: Dict[str, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*[](#llama_index.storage.docstore.FirestoreDocumentStore.docs "Permalink to this definition")Get all documents.

Returnsdocuments

Return typeDict[str, BaseDocument]

document\_exists(*doc\_id: str*) → bool[](#llama_index.storage.docstore.FirestoreDocumentStore.document_exists "Permalink to this definition")Check if document exists.

*classmethod* from\_database(*project: str*, *database: str*, *namespace: Optional[str] = None*) → [FirestoreDocumentStore](#llama_index.storage.docstore.FirestoreDocumentStore "llama_index.storage.docstore.firestore_docstore.FirestoreDocumentStore")[](#llama_index.storage.docstore.FirestoreDocumentStore.from_database "Permalink to this definition")Parameters* **project** (*str*) – The project which the client acts on behalf of.
* **database** (*str*) – The database name that the client targets.
* **namespace** (*str*) – namespace for the docstore.
get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.FirestoreDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_document(*doc\_id: str*, *raise\_error: bool = True*) → Optional[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.FirestoreDocumentStore.get_document "Permalink to this definition")Get a document from the store.

Parameters* **doc\_id** (*str*) – document id
* **raise\_error** (*bool*) – raise error if doc\_id not found
get\_document\_hash(*doc\_id: str*) → Optional[str][](#llama_index.storage.docstore.FirestoreDocumentStore.get_document_hash "Permalink to this definition")Get the stored hash for a document, if it exists.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.FirestoreDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.FirestoreDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.FirestoreDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.FirestoreDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.FirestoreDocumentStore.persist "Permalink to this definition")Persist the docstore to a file.

ref\_doc\_exists(*ref\_doc\_id: str*) → bool[](#llama_index.storage.docstore.FirestoreDocumentStore.ref_doc_exists "Permalink to this definition")Check if a ref\_doc\_id has been ingested.

set\_document\_hash(*doc\_id: str*, *doc\_hash: str*) → None[](#llama_index.storage.docstore.FirestoreDocumentStore.set_document_hash "Permalink to this definition")Set the hash for a given doc\_id.

*class* llama\_index.storage.docstore.KVDocumentStore(*kvstore: BaseKVStore*, *namespace: Optional[str] = None*)[](#llama_index.storage.docstore.KVDocumentStore "Permalink to this definition")Document (Node) store.

NOTE: at the moment, this store is primarily used to store Node objects.Each node will be assigned an ID.

The same docstore can be reused across index structures. Thisallows you to reuse the same storage for multiple index structures;otherwise, each index would create a docstore under the hood.

This will use the same docstore for multiple index structures.

Parameters* **kvstore** (*BaseKVStore*) – key-value store
* **namespace** (*str*) – namespace for the docstore
add\_documents(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *allow\_update: bool = True*) → None[](#llama_index.storage.docstore.KVDocumentStore.add_documents "Permalink to this definition")Add a document to the store.

Parameters* **docs** (*List**[**BaseDocument**]*) – documents
* **allow\_update** (*bool*) – allow update of docstore from document
delete\_document(*doc\_id: str*, *raise\_error: bool = True*, *remove\_ref\_doc\_node: bool = True*) → None[](#llama_index.storage.docstore.KVDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.KVDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*property* docs*: Dict[str, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*[](#llama_index.storage.docstore.KVDocumentStore.docs "Permalink to this definition")Get all documents.

Returnsdocuments

Return typeDict[str, BaseDocument]

document\_exists(*doc\_id: str*) → bool[](#llama_index.storage.docstore.KVDocumentStore.document_exists "Permalink to this definition")Check if document exists.

get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.KVDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_document(*doc\_id: str*, *raise\_error: bool = True*) → Optional[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.KVDocumentStore.get_document "Permalink to this definition")Get a document from the store.

Parameters* **doc\_id** (*str*) – document id
* **raise\_error** (*bool*) – raise error if doc\_id not found
get\_document\_hash(*doc\_id: str*) → Optional[str][](#llama_index.storage.docstore.KVDocumentStore.get_document_hash "Permalink to this definition")Get the stored hash for a document, if it exists.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.KVDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.KVDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.KVDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.KVDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.KVDocumentStore.persist "Permalink to this definition")Persist the docstore to a file.

ref\_doc\_exists(*ref\_doc\_id: str*) → bool[](#llama_index.storage.docstore.KVDocumentStore.ref_doc_exists "Permalink to this definition")Check if a ref\_doc\_id has been ingested.

set\_document\_hash(*doc\_id: str*, *doc\_hash: str*) → None[](#llama_index.storage.docstore.KVDocumentStore.set_document_hash "Permalink to this definition")Set the hash for a given doc\_id.

*class* llama\_index.storage.docstore.MongoDocumentStore(*mongo\_kvstore: [MongoDBKVStore](kv_store.html#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.mongodb_kvstore.MongoDBKVStore")*, *namespace: Optional[str] = None*)[](#llama_index.storage.docstore.MongoDocumentStore "Permalink to this definition")Mongo Document (Node) store.

A MongoDB store for Document and Node objects.

Parameters* **mongo\_kvstore** ([*MongoDBKVStore*](kv_store.html#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.MongoDBKVStore")) – MongoDB key-value store
* **namespace** (*str*) – namespace for the docstore
add\_documents(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *allow\_update: bool = True*) → None[](#llama_index.storage.docstore.MongoDocumentStore.add_documents "Permalink to this definition")Add a document to the store.

Parameters* **docs** (*List**[**BaseDocument**]*) – documents
* **allow\_update** (*bool*) – allow update of docstore from document
delete\_document(*doc\_id: str*, *raise\_error: bool = True*, *remove\_ref\_doc\_node: bool = True*) → None[](#llama_index.storage.docstore.MongoDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.MongoDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*property* docs*: Dict[str, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*[](#llama_index.storage.docstore.MongoDocumentStore.docs "Permalink to this definition")Get all documents.

Returnsdocuments

Return typeDict[str, BaseDocument]

document\_exists(*doc\_id: str*) → bool[](#llama_index.storage.docstore.MongoDocumentStore.document_exists "Permalink to this definition")Check if document exists.

*classmethod* from\_host\_and\_port(*host: str*, *port: int*, *db\_name: Optional[str] = None*, *namespace: Optional[str] = None*) → [MongoDocumentStore](#llama_index.storage.docstore.MongoDocumentStore "llama_index.storage.docstore.mongo_docstore.MongoDocumentStore")[](#llama_index.storage.docstore.MongoDocumentStore.from_host_and_port "Permalink to this definition")Load a MongoDocumentStore from a MongoDB host and port.

*classmethod* from\_uri(*uri: str*, *db\_name: Optional[str] = None*, *namespace: Optional[str] = None*) → [MongoDocumentStore](#llama_index.storage.docstore.MongoDocumentStore "llama_index.storage.docstore.mongo_docstore.MongoDocumentStore")[](#llama_index.storage.docstore.MongoDocumentStore.from_uri "Permalink to this definition")Load a MongoDocumentStore from a MongoDB URI.

get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.MongoDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_document(*doc\_id: str*, *raise\_error: bool = True*) → Optional[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.MongoDocumentStore.get_document "Permalink to this definition")Get a document from the store.

Parameters* **doc\_id** (*str*) – document id
* **raise\_error** (*bool*) – raise error if doc\_id not found
get\_document\_hash(*doc\_id: str*) → Optional[str][](#llama_index.storage.docstore.MongoDocumentStore.get_document_hash "Permalink to this definition")Get the stored hash for a document, if it exists.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.MongoDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.MongoDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.MongoDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.MongoDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.MongoDocumentStore.persist "Permalink to this definition")Persist the docstore to a file.

ref\_doc\_exists(*ref\_doc\_id: str*) → bool[](#llama_index.storage.docstore.MongoDocumentStore.ref_doc_exists "Permalink to this definition")Check if a ref\_doc\_id has been ingested.

set\_document\_hash(*doc\_id: str*, *doc\_hash: str*) → None[](#llama_index.storage.docstore.MongoDocumentStore.set_document_hash "Permalink to this definition")Set the hash for a given doc\_id.

*class* llama\_index.storage.docstore.RedisDocumentStore(*redis\_kvstore: [RedisKVStore](kv_store.html#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.redis_kvstore.RedisKVStore")*, *namespace: Optional[str] = None*)[](#llama_index.storage.docstore.RedisDocumentStore "Permalink to this definition")Redis Document (Node) store.

A Redis store for Document and Node objects.

Parameters* **redis\_kvstore** ([*RedisKVStore*](kv_store.html#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.RedisKVStore")) – Redis key-value store
* **namespace** (*str*) – namespace for the docstore
add\_documents(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *allow\_update: bool = True*) → None[](#llama_index.storage.docstore.RedisDocumentStore.add_documents "Permalink to this definition")Add a document to the store.

Parameters* **docs** (*List**[**BaseDocument**]*) – documents
* **allow\_update** (*bool*) – allow update of docstore from document
delete\_document(*doc\_id: str*, *raise\_error: bool = True*, *remove\_ref\_doc\_node: bool = True*) → None[](#llama_index.storage.docstore.RedisDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.RedisDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*property* docs*: Dict[str, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*[](#llama_index.storage.docstore.RedisDocumentStore.docs "Permalink to this definition")Get all documents.

Returnsdocuments

Return typeDict[str, BaseDocument]

document\_exists(*doc\_id: str*) → bool[](#llama_index.storage.docstore.RedisDocumentStore.document_exists "Permalink to this definition")Check if document exists.

*classmethod* from\_host\_and\_port(*host: str*, *port: int*, *namespace: Optional[str] = None*) → [RedisDocumentStore](#llama_index.storage.docstore.RedisDocumentStore "llama_index.storage.docstore.redis_docstore.RedisDocumentStore")[](#llama_index.storage.docstore.RedisDocumentStore.from_host_and_port "Permalink to this definition")Load a RedisDocumentStore from a Redis host and port.

*classmethod* from\_redis\_client(*redis\_client: Any*, *namespace: Optional[str] = None*) → [RedisDocumentStore](#llama_index.storage.docstore.RedisDocumentStore "llama_index.storage.docstore.redis_docstore.RedisDocumentStore")[](#llama_index.storage.docstore.RedisDocumentStore.from_redis_client "Permalink to this definition")Load a RedisDocumentStore from a Redis Client.

get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.RedisDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_document(*doc\_id: str*, *raise\_error: bool = True*) → Optional[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.RedisDocumentStore.get_document "Permalink to this definition")Get a document from the store.

Parameters* **doc\_id** (*str*) – document id
* **raise\_error** (*bool*) – raise error if doc\_id not found
get\_document\_hash(*doc\_id: str*) → Optional[str][](#llama_index.storage.docstore.RedisDocumentStore.get_document_hash "Permalink to this definition")Get the stored hash for a document, if it exists.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.RedisDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.RedisDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.RedisDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.RedisDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.RedisDocumentStore.persist "Permalink to this definition")Persist the docstore to a file.

ref\_doc\_exists(*ref\_doc\_id: str*) → bool[](#llama_index.storage.docstore.RedisDocumentStore.ref_doc_exists "Permalink to this definition")Check if a ref\_doc\_id has been ingested.

set\_document\_hash(*doc\_id: str*, *doc\_hash: str*) → None[](#llama_index.storage.docstore.RedisDocumentStore.set_document_hash "Permalink to this definition")Set the hash for a given doc\_id.

*class* llama\_index.storage.docstore.SimpleDocumentStore(*simple\_kvstore: Optional[[SimpleKVStore](kv_store.html#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.simple_kvstore.SimpleKVStore")] = None*, *namespace: Optional[str] = None*)[](#llama_index.storage.docstore.SimpleDocumentStore "Permalink to this definition")Simple Document (Node) store.

An in-memory store for Document and Node objects.

Parameters* **simple\_kvstore** ([*SimpleKVStore*](kv_store.html#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.SimpleKVStore")) – simple key-value store
* **namespace** (*str*) – namespace for the docstore
add\_documents(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *allow\_update: bool = True*) → None[](#llama_index.storage.docstore.SimpleDocumentStore.add_documents "Permalink to this definition")Add a document to the store.

Parameters* **docs** (*List**[**BaseDocument**]*) – documents
* **allow\_update** (*bool*) – allow update of docstore from document
delete\_document(*doc\_id: str*, *raise\_error: bool = True*, *remove\_ref\_doc\_node: bool = True*) → None[](#llama_index.storage.docstore.SimpleDocumentStore.delete_document "Permalink to this definition")Delete a document from the store.

delete\_ref\_doc(*ref\_doc\_id: str*, *raise\_error: bool = True*) → None[](#llama_index.storage.docstore.SimpleDocumentStore.delete_ref_doc "Permalink to this definition")Delete a ref\_doc and all it’s associated nodes.

*property* docs*: Dict[str, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*[](#llama_index.storage.docstore.SimpleDocumentStore.docs "Permalink to this definition")Get all documents.

Returnsdocuments

Return typeDict[str, BaseDocument]

document\_exists(*doc\_id: str*) → bool[](#llama_index.storage.docstore.SimpleDocumentStore.document_exists "Permalink to this definition")Check if document exists.

*classmethod* from\_persist\_dir(*persist\_dir: str = './storage'*, *namespace: Optional[str] = None*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleDocumentStore](#llama_index.storage.docstore.SimpleDocumentStore "llama_index.storage.docstore.simple_docstore.SimpleDocumentStore")[](#llama_index.storage.docstore.SimpleDocumentStore.from_persist_dir "Permalink to this definition")Create a SimpleDocumentStore from a persist directory.

Parameters* **persist\_dir** (*str*) – directory to persist the store
* **namespace** (*Optional**[**str**]*) – namespace for the docstore
* **fs** (*Optional**[**fsspec.AbstractFileSystem**]*) – filesystem to use
*classmethod* from\_persist\_path(*persist\_path: str*, *namespace: Optional[str] = None*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleDocumentStore](#llama_index.storage.docstore.SimpleDocumentStore "llama_index.storage.docstore.simple_docstore.SimpleDocumentStore")[](#llama_index.storage.docstore.SimpleDocumentStore.from_persist_path "Permalink to this definition")Create a SimpleDocumentStore from a persist path.

Parameters* **persist\_path** (*str*) – Path to persist the store
* **namespace** (*Optional**[**str**]*) – namespace for the docstore
* **fs** (*Optional**[**fsspec.AbstractFileSystem**]*) – filesystem to use
get\_all\_ref\_doc\_info() → Optional[Dict[str, RefDocInfo]][](#llama_index.storage.docstore.SimpleDocumentStore.get_all_ref_doc_info "Permalink to this definition")Get a mapping of ref\_doc\_id -> RefDocInfo for all ingested documents.

get\_document(*doc\_id: str*, *raise\_error: bool = True*) → Optional[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.SimpleDocumentStore.get_document "Permalink to this definition")Get a document from the store.

Parameters* **doc\_id** (*str*) – document id
* **raise\_error** (*bool*) – raise error if doc\_id not found
get\_document\_hash(*doc\_id: str*) → Optional[str][](#llama_index.storage.docstore.SimpleDocumentStore.get_document_hash "Permalink to this definition")Get the stored hash for a document, if it exists.

get\_node(*node\_id: str*, *raise\_error: bool = True*) → [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")[](#llama_index.storage.docstore.SimpleDocumentStore.get_node "Permalink to this definition")Get node from docstore.

Parameters* **node\_id** (*str*) – node id
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_node\_dict(*node\_id\_dict: Dict[int, str]*) → Dict[int, [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.SimpleDocumentStore.get_node_dict "Permalink to this definition")Get node dict from docstore given a mapping of index to node ids.

Parameters**node\_id\_dict** (*Dict**[**int**,* *str**]*) – mapping of index to node ids

get\_nodes(*node\_ids: List[str]*, *raise\_error: bool = True*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.storage.docstore.SimpleDocumentStore.get_nodes "Permalink to this definition")Get nodes from docstore.

Parameters* **node\_ids** (*List**[**str**]*) – node ids
* **raise\_error** (*bool*) – raise error if node\_id not found
get\_ref\_doc\_info(*ref\_doc\_id: str*) → Optional[RefDocInfo][](#llama_index.storage.docstore.SimpleDocumentStore.get_ref_doc_info "Permalink to this definition")Get the RefDocInfo for a given ref\_doc\_id.

persist(*persist\_path: str = './storage/docstore.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.docstore.SimpleDocumentStore.persist "Permalink to this definition")Persist the store.

ref\_doc\_exists(*ref\_doc\_id: str*) → bool[](#llama_index.storage.docstore.SimpleDocumentStore.ref_doc_exists "Permalink to this definition")Check if a ref\_doc\_id has been ingested.

set\_document\_hash(*doc\_id: str*, *doc\_hash: str*) → None[](#llama_index.storage.docstore.SimpleDocumentStore.set_document_hash "Permalink to this definition")Set the hash for a given doc\_id.

