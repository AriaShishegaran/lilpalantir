KV Storage[](#module-llama_index.storage.kvstore "Permalink to this heading")
==============================================================================

*class* llama\_index.storage.kvstore.FirestoreKVStore(*project: Optional[str] = None*, *database: str = '(default)'*)[](#llama_index.storage.kvstore.FirestoreKVStore "Permalink to this definition")Firestore Key-Value store.

Parameters* **project** (*str*) – The project which the client acts on behalf of.
* **database** (*str*) – The database name that the client targets.
delete(*key: str*, *collection: str = 'data'*) → bool[](#llama_index.storage.kvstore.FirestoreKVStore.delete "Permalink to this definition")Delete a value from the Firestore.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get(*key: str*, *collection: str = 'data'*) → Optional[dict][](#llama_index.storage.kvstore.FirestoreKVStore.get "Permalink to this definition")Get a key-value pair from the Firestore.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get\_all(*collection: str = 'data'*) → Dict[str, dict][](#llama_index.storage.kvstore.FirestoreKVStore.get_all "Permalink to this definition")Get all values from the Firestore collection.

Parameters**collection** (*str*) – collection name

put(*key: str*, *val: dict*, *collection: str = 'data'*) → None[](#llama_index.storage.kvstore.FirestoreKVStore.put "Permalink to this definition")Put a key-value pair into the Firestore collection.

Parameters* **key** (*str*) – key
* **val** (*dict*) – value
* **collection** (*str*) – collection name
*class* llama\_index.storage.kvstore.MongoDBKVStore(*mongo\_client: Any*, *uri: Optional[str] = None*, *host: Optional[str] = None*, *port: Optional[int] = None*, *db\_name: Optional[str] = None*)[](#llama_index.storage.kvstore.MongoDBKVStore "Permalink to this definition")MongoDB Key-Value store.

Parameters* **mongo\_client** (*Any*) – MongoDB client
* **uri** (*Optional**[**str**]*) – MongoDB URI
* **host** (*Optional**[**str**]*) – MongoDB host
* **port** (*Optional**[**int**]*) – MongoDB port
* **db\_name** (*Optional**[**str**]*) – MongoDB database name
delete(*key: str*, *collection: str = 'data'*) → bool[](#llama_index.storage.kvstore.MongoDBKVStore.delete "Permalink to this definition")Delete a value from the store.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
*classmethod* from\_host\_and\_port(*host: str*, *port: int*, *db\_name: Optional[str] = None*) → [MongoDBKVStore](#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.mongodb_kvstore.MongoDBKVStore")[](#llama_index.storage.kvstore.MongoDBKVStore.from_host_and_port "Permalink to this definition")Load a MongoDBKVStore from a MongoDB host and port.

Parameters* **host** (*str*) – MongoDB host
* **port** (*int*) – MongoDB port
* **db\_name** (*Optional**[**str**]*) – MongoDB database name
*classmethod* from\_uri(*uri: str*, *db\_name: Optional[str] = None*) → [MongoDBKVStore](#llama_index.storage.kvstore.MongoDBKVStore "llama_index.storage.kvstore.mongodb_kvstore.MongoDBKVStore")[](#llama_index.storage.kvstore.MongoDBKVStore.from_uri "Permalink to this definition")Load a MongoDBKVStore from a MongoDB URI.

Parameters* **uri** (*str*) – MongoDB URI
* **db\_name** (*Optional**[**str**]*) – MongoDB database name
get(*key: str*, *collection: str = 'data'*) → Optional[dict][](#llama_index.storage.kvstore.MongoDBKVStore.get "Permalink to this definition")Get a value from the store.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get\_all(*collection: str = 'data'*) → Dict[str, dict][](#llama_index.storage.kvstore.MongoDBKVStore.get_all "Permalink to this definition")Get all values from the store.

Parameters**collection** (*str*) – collection name

put(*key: str*, *val: dict*, *collection: str = 'data'*) → None[](#llama_index.storage.kvstore.MongoDBKVStore.put "Permalink to this definition")Put a key-value pair into the store.

Parameters* **key** (*str*) – key
* **val** (*dict*) – value
* **collection** (*str*) – collection name
*class* llama\_index.storage.kvstore.RedisKVStore(*redis\_uri: Optional[str] = 'redis://127.0.0.1:6379'*, *\*\*kwargs: Any*)[](#llama_index.storage.kvstore.RedisKVStore "Permalink to this definition")Redis KV Store.

Parameters* **redis\_client** (*Any*) – Redis client
* **redis\_url** (*Optional**[**str**]*) – Redis server URI
Raises**ValueError** – If redis-py is not installed

Examples


```
>>> from llama\_index.storage.kvstore.redis\_kvstore import RedisKVStore>>> # Create a RedisKVStore>>> redis\_kv\_store = RedisKVStore(>>>     redis\_url="redis://127.0.0.1:6379")
```
delete(*key: str*, *collection: str = 'data'*) → bool[](#llama_index.storage.kvstore.RedisKVStore.delete "Permalink to this definition")Delete a value from the store.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
*classmethod* from\_host\_and\_port(*host: str*, *port: int*) → [RedisKVStore](#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.redis_kvstore.RedisKVStore")[](#llama_index.storage.kvstore.RedisKVStore.from_host_and_port "Permalink to this definition")Load a RedisKVStore from a Redis host and port.

Parameters* **host** (*str*) – Redis host
* **port** (*int*) – Redis port
*classmethod* from\_redis\_client(*redis\_client: Any*) → [RedisKVStore](#llama_index.storage.kvstore.RedisKVStore "llama_index.storage.kvstore.redis_kvstore.RedisKVStore")[](#llama_index.storage.kvstore.RedisKVStore.from_redis_client "Permalink to this definition")Load a RedisKVStore from a Redis Client.

Parameters**redis\_client** (*Redis*) – Redis client

get(*key: str*, *collection: str = 'data'*) → Optional[dict][](#llama_index.storage.kvstore.RedisKVStore.get "Permalink to this definition")Get a value from the store.

Parameters* **key** (*str*) – key
* **collection** (*str*) – collection name
get\_all(*collection: str = 'data'*) → Dict[str, dict][](#llama_index.storage.kvstore.RedisKVStore.get_all "Permalink to this definition")Get all values from the store.

put(*key: str*, *val: dict*, *collection: str = 'data'*) → None[](#llama_index.storage.kvstore.RedisKVStore.put "Permalink to this definition")Put a key-value pair into the store.

Parameters* **key** (*str*) – key
* **val** (*dict*) – value
* **collection** (*str*) – collection name
*class* llama\_index.storage.kvstore.SimpleKVStore(*data: Optional[Dict[str, Dict[str, dict]]] = None*)[](#llama_index.storage.kvstore.SimpleKVStore "Permalink to this definition")Simple in-memory Key-Value store.

Parameters**data** (*Optional**[**DATA\_TYPE**]*) – data to initialize the store with

delete(*key: str*, *collection: str = 'data'*) → bool[](#llama_index.storage.kvstore.SimpleKVStore.delete "Permalink to this definition")Delete a value from the store.

*classmethod* from\_dict(*save\_dict: dict*) → [SimpleKVStore](#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.simple_kvstore.SimpleKVStore")[](#llama_index.storage.kvstore.SimpleKVStore.from_dict "Permalink to this definition")Load a SimpleKVStore from dict.

*classmethod* from\_persist\_path(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleKVStore](#llama_index.storage.kvstore.SimpleKVStore "llama_index.storage.kvstore.simple_kvstore.SimpleKVStore")[](#llama_index.storage.kvstore.SimpleKVStore.from_persist_path "Permalink to this definition")Load a SimpleKVStore from a persist path and filesystem.

get(*key: str*, *collection: str = 'data'*) → Optional[dict][](#llama_index.storage.kvstore.SimpleKVStore.get "Permalink to this definition")Get a value from the store.

get\_all(*collection: str = 'data'*) → Dict[str, dict][](#llama_index.storage.kvstore.SimpleKVStore.get_all "Permalink to this definition")Get all values from the store.

persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.kvstore.SimpleKVStore.persist "Permalink to this definition")Persist the store.

put(*key: str*, *val: dict*, *collection: str = 'data'*) → None[](#llama_index.storage.kvstore.SimpleKVStore.put "Permalink to this definition")Put a key-value pair into the store.

to\_dict() → dict[](#llama_index.storage.kvstore.SimpleKVStore.to_dict "Permalink to this definition")Save the store as dict.

