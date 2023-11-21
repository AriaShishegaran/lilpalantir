Index Store[](#module-llama_index.storage.index_store "Permalink to this heading")
===================================================================================

*class* llama\_index.storage.index\_store.FirestoreKVStore(*project: Optional[str] = None*, *database: str = '(default)'*)[](#llama_index.storage.index_store.FirestoreKVStore "Permalink to this definition")Firestore Key-Value store.

Parameters* **project** (*str*) – The project which the client acts on behalf of.
* **database** (*str*) – The database name that the client targets.
delete(*key: str*, *collection: str = 'data'*) → bool[](#llama_index.storage.index_store.FirestoreKVStore.delete "Permalink to this definition")Delete a value from the Firestore.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get(*key: str*, *collection: str = 'data'*) → Optional[dict][](#llama_index.storage.index_store.FirestoreKVStore.get "Permalink to this definition")Get a key-value pair from the Firestore.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get\_all(*collection: str = 'data'*) → Dict[str, dict][](#llama_index.storage.index_store.FirestoreKVStore.get_all "Permalink to this definition")Get all values from the Firestore collection.

Parameters**collection** (*str*) – collection name

put(*key: str*, *val: dict*, *collection: str = 'data'*) → None[](#llama_index.storage.index_store.FirestoreKVStore.put "Permalink to this definition")Put a key-value pair into the Firestore collection.

Parameters* **key** (*str*) – key
* **val** (*dict*) – value
* **collection** (*str*) – collection name
*class* llama\_index.storage.index\_store.KVIndexStore(*kvstore: BaseKVStore*, *namespace: Optional[str] = None*)[](#llama_index.storage.index_store.KVIndexStore "Permalink to this definition")Key-Value Index store.

Parameters* **kvstore** (*BaseKVStore*) – key-value store
* **namespace** (*str*) – namespace for the index store
add\_index\_struct(*index\_struct: IndexStruct*) → None[](#llama_index.storage.index_store.KVIndexStore.add_index_struct "Permalink to this definition")Add an index struct.

Parameters**index\_struct** (*IndexStruct*) – index struct

delete\_index\_struct(*key: str*) → None[](#llama_index.storage.index_store.KVIndexStore.delete_index_struct "Permalink to this definition")Delete an index struct.

Parameters**key** (*str*) – index struct key

get\_index\_struct(*struct\_id: Optional[str] = None*) → Optional[IndexStruct][](#llama_index.storage.index_store.KVIndexStore.get_index_struct "Permalink to this definition")Get an index struct.

Parameters**struct\_id** (*Optional**[**str**]*) – index struct id

index\_structs() → List[IndexStruct][](#llama_index.storage.index_store.KVIndexStore.index_structs "Permalink to this definition")Get all index structs.

Returnsindex structs

Return typeList[IndexStruct]

persist(*persist\_path: str = './storage/index\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.index_store.KVIndexStore.persist "Permalink to this definition")Persist the index store to disk.

*class* llama\_index.storage.index\_store.MongoIndexStore(*mongo\_kvstore: [MongoDBKVStore](kv_store.html#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.mongodb_kvstore.MongoDBKVStore")*, *namespace: Optional[str] = None*)[](#llama_index.storage.index_store.MongoIndexStore "Permalink to this definition")Mongo Index store.

Parameters* **mongo\_kvstore** ([*MongoDBKVStore*](kv_store.html#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.MongoDBKVStore")) – MongoDB key-value store
* **namespace** (*str*) – namespace for the index store
add\_index\_struct(*index\_struct: IndexStruct*) → None[](#llama_index.storage.index_store.MongoIndexStore.add_index_struct "Permalink to this definition")Add an index struct.

Parameters**index\_struct** (*IndexStruct*) – index struct

delete\_index\_struct(*key: str*) → None[](#llama_index.storage.index_store.MongoIndexStore.delete_index_struct "Permalink to this definition")Delete an index struct.

Parameters**key** (*str*) – index struct key

*classmethod* from\_host\_and\_port(*host: str*, *port: int*, *db\_name: Optional[str] = None*, *namespace: Optional[str] = None*) → [MongoIndexStore](#llama_index.storage.index_store.MongoIndexStore "llama_index.storage.index_store.mongo_index_store.MongoIndexStore")[](#llama_index.storage.index_store.MongoIndexStore.from_host_and_port "Permalink to this definition")Load a MongoIndexStore from a MongoDB host and port.

*classmethod* from\_uri(*uri: str*, *db\_name: Optional[str] = None*, *namespace: Optional[str] = None*) → [MongoIndexStore](#llama_index.storage.index_store.MongoIndexStore "llama_index.storage.index_store.mongo_index_store.MongoIndexStore")[](#llama_index.storage.index_store.MongoIndexStore.from_uri "Permalink to this definition")Load a MongoIndexStore from a MongoDB URI.

get\_index\_struct(*struct\_id: Optional[str] = None*) → Optional[IndexStruct][](#llama_index.storage.index_store.MongoIndexStore.get_index_struct "Permalink to this definition")Get an index struct.

Parameters**struct\_id** (*Optional**[**str**]*) – index struct id

index\_structs() → List[IndexStruct][](#llama_index.storage.index_store.MongoIndexStore.index_structs "Permalink to this definition")Get all index structs.

Returnsindex structs

Return typeList[IndexStruct]

persist(*persist\_path: str = './storage/index\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.index_store.MongoIndexStore.persist "Permalink to this definition")Persist the index store to disk.

*class* llama\_index.storage.index\_store.RedisIndexStore(*redis\_kvstore: [RedisKVStore](kv_store.html#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.redis_kvstore.RedisKVStore")*, *namespace: Optional[str] = None*)[](#llama_index.storage.index_store.RedisIndexStore "Permalink to this definition")Redis Index store.

Parameters* **redis\_kvstore** ([*RedisKVStore*](kv_store.html#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.RedisKVStore")) – Redis key-value store
* **namespace** (*str*) – namespace for the index store
add\_index\_struct(*index\_struct: IndexStruct*) → None[](#llama_index.storage.index_store.RedisIndexStore.add_index_struct "Permalink to this definition")Add an index struct.

Parameters**index\_struct** (*IndexStruct*) – index struct

delete\_index\_struct(*key: str*) → None[](#llama_index.storage.index_store.RedisIndexStore.delete_index_struct "Permalink to this definition")Delete an index struct.

Parameters**key** (*str*) – index struct key

*classmethod* from\_host\_and\_port(*host: str*, *port: int*, *namespace: Optional[str] = None*) → [RedisIndexStore](#llama_index.storage.index_store.RedisIndexStore "llama_index.storage.index_store.redis_index_store.RedisIndexStore")[](#llama_index.storage.index_store.RedisIndexStore.from_host_and_port "Permalink to this definition")Load a RedisIndexStore from a Redis host and port.

*classmethod* from\_redis\_client(*redis\_client: Any*, *namespace: Optional[str] = None*) → [RedisIndexStore](#llama_index.storage.index_store.RedisIndexStore "llama_index.storage.index_store.redis_index_store.RedisIndexStore")[](#llama_index.storage.index_store.RedisIndexStore.from_redis_client "Permalink to this definition")Load a RedisIndexStore from a Redis Client.

get\_index\_struct(*struct\_id: Optional[str] = None*) → Optional[IndexStruct][](#llama_index.storage.index_store.RedisIndexStore.get_index_struct "Permalink to this definition")Get an index struct.

Parameters**struct\_id** (*Optional**[**str**]*) – index struct id

index\_structs() → List[IndexStruct][](#llama_index.storage.index_store.RedisIndexStore.index_structs "Permalink to this definition")Get all index structs.

Returnsindex structs

Return typeList[IndexStruct]

persist(*persist\_path: str = './storage/index\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.index_store.RedisIndexStore.persist "Permalink to this definition")Persist the index store to disk.

*class* llama\_index.storage.index\_store.SimpleIndexStore(*simple\_kvstore: Optional[[SimpleKVStore](kv_store.html#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.simple_kvstore.SimpleKVStore")] = None*)[](#llama_index.storage.index_store.SimpleIndexStore "Permalink to this definition")Simple in-memory Index store.

Parameters**simple\_kvstore** ([*SimpleKVStore*](kv_store.html#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.SimpleKVStore")) – simple key-value store

add\_index\_struct(*index\_struct: IndexStruct*) → None[](#llama_index.storage.index_store.SimpleIndexStore.add_index_struct "Permalink to this definition")Add an index struct.

Parameters**index\_struct** (*IndexStruct*) – index struct

delete\_index\_struct(*key: str*) → None[](#llama_index.storage.index_store.SimpleIndexStore.delete_index_struct "Permalink to this definition")Delete an index struct.

Parameters**key** (*str*) – index struct key

*classmethod* from\_persist\_dir(*persist\_dir: str = './storage'*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleIndexStore](#llama_index.storage.index_store.SimpleIndexStore "llama_index.storage.index_store.simple_index_store.SimpleIndexStore")[](#llama_index.storage.index_store.SimpleIndexStore.from_persist_dir "Permalink to this definition")Create a SimpleIndexStore from a persist directory.

*classmethod* from\_persist\_path(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleIndexStore](#llama_index.storage.index_store.SimpleIndexStore "llama_index.storage.index_store.simple_index_store.SimpleIndexStore")[](#llama_index.storage.index_store.SimpleIndexStore.from_persist_path "Permalink to this definition")Create a SimpleIndexStore from a persist path.

get\_index\_struct(*struct\_id: Optional[str] = None*) → Optional[IndexStruct][](#llama_index.storage.index_store.SimpleIndexStore.get_index_struct "Permalink to this definition")Get an index struct.

Parameters**struct\_id** (*Optional**[**str**]*) – index struct id

index\_structs() → List[IndexStruct][](#llama_index.storage.index_store.SimpleIndexStore.index_structs "Permalink to this definition")Get all index structs.

Returnsindex structs

Return typeList[IndexStruct]

persist(*persist\_path: str = './storage/index\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.index_store.SimpleIndexStore.persist "Permalink to this definition")Persist the store.

