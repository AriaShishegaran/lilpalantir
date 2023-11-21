Vector Store[](#module-llama_index.vector_stores "Permalink to this heading")
==============================================================================

Vector stores.

*class* llama\_index.vector\_stores.AstraDBVectorStore(*\**, *collection\_name: str*, *token: str*, *api\_endpoint: str*, *embedding\_dimension: int*, *namespace: Optional[str] = None*, *ttl\_seconds: Optional[int] = None*)[](#llama_index.vector_stores.AstraDBVectorStore "Permalink to this definition")Astra DB Vector Store.

An abstraction of a Astra table withvector-similarity-search. Documents, and their embeddings, are storedin an Astra table and a vector-capable index is used for searches.The table does not need to exist beforehand: if necessary it willbe created behind the scenes.

All Astra operations are done through the astrapy library.

Parameters* **collection\_name** (*str*) – collection name to use. If not existing, it will be created.
* **token** (*str*) – The Astra DB Application Token to use.
* **api\_endpoint** (*str*) – The Astra DB JSON API endpoint for your database.
* **embedding\_dimension** (*int*) – length of the embedding vectors in use.
* **namespace** (*Optional**[**str**]*) – The namespace to use. If not provided, ‘default\_keyspace’
* **ttl\_seconds** (*Optional**[**int**]*) – expiration time for inserted entries.Default is no expiration.
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.AstraDBVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of node with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AstraDBVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AstraDBVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.AstraDBVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.AstraDBVectorStore.client "Permalink to this definition")Return the underlying Astra vector table object.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AstraDBVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AstraDBVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

*class* llama\_index.vector\_stores.AwaDBVectorStore(*table\_name: str = 'llamaindex\_awadb'*, *log\_and\_data\_dir: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.AwaDBVectorStore "Permalink to this definition")AwaDB vector store.

In this vector store, embeddings are stored within a AwaDB table.

During query time, the index uses AwaDB to query for the topk most similar nodes.

Parameters**chroma\_collection** (*chromadb.api.models.Collection.Collection*) – ChromaDB collection instance

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.AwaDBVectorStore.add "Permalink to this definition")Add nodes to AwaDB.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

ReturnsAdded node ids

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AwaDBVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AwaDBVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.AwaDBVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.AwaDBVectorStore.client "Permalink to this definition")Get AwaDB client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AwaDBVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

ReturnsNone

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AwaDBVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** – vector store query

ReturnsQuery results

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

*class* llama\_index.vector\_stores.AzureCosmosDBMongoDBVectorSearch(*mongodb\_client: Optional[Any] = None*, *db\_name: str = 'default\_db'*, *collection\_name: str = 'default\_collection'*, *index\_name: str = 'default\_vector\_search\_index'*, *id\_key: str = 'id'*, *embedding\_key: str = 'content\_vector'*, *text\_key: str = 'text'*, *metadata\_key: str = 'metadata'*, *cosmos\_search\_kwargs: Optional[Dict] = None*, *insert\_kwargs: Optional[Dict] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch "Permalink to this definition")Azure CosmosDB MongoDB vCore Vector Store.

To use, you should have both:- the `pymongo` python package installed- a connection string associated with an Azure Cosmodb MongoDB vCore Cluster

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

ReturnsA List of ids for successfully added nodes.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.client "Permalink to this definition")Return MongoDB client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.AzureCosmosDBMongoDBVectorSearch.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** – a VectorStoreQuery object.

ReturnsA VectorStoreQueryResult containing the results of the query.

*class* llama\_index.vector\_stores.BagelVectorStore(*collection: Any*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.BagelVectorStore "Permalink to this definition")Vector store for Bagel.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.BagelVectorStore.add "Permalink to this definition")Add a list of nodes with embeddings to the vector store.

Parameters* **nodes** – List of nodes with embeddings.
* **kwargs** – Additional arguments.
ReturnsList of document ids.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.BagelVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.BagelVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.BagelVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.BagelVectorStore.client "Permalink to this definition")Get the Bagel cluster.

delete(*ref\_doc\_id: str*, *\*\*kwargs: Any*) → None[](#llama_index.vector_stores.BagelVectorStore.delete "Permalink to this definition")Delete a document from the vector store.

Parameters* **ref\_doc\_id** – Reference document id.
* **kwargs** – Additional arguments.
query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.BagelVectorStore.query "Permalink to this definition")Query the vector store.

Parameters* **query** – Query to run.
* **kwargs** – Additional arguments.
ReturnsQuery result.

*class* llama\_index.vector\_stores.CassandraVectorStore(*table: str*, *embedding\_dimension: int*, *\**, *session: Optional[Any] = None*, *keyspace: Optional[str] = None*, *ttl\_seconds: Optional[int] = None*, *insertion\_batch\_size: int = 20*)[](#llama_index.vector_stores.CassandraVectorStore "Permalink to this definition")Cassandra Vector Store.

An abstraction of a Cassandra table withvector-similarity-search. Documents, and their embeddings, are storedin a Cassandra table and a vector-capable index is used for searches.The table does not need to exist beforehand: if necessary it willbe created behind the scenes.

All Cassandra operations are done through the CassIO library.

Note: in recent versions, only table and embedding\_dimension can bepassed positionally. Please revise your code if needed.This is to accommodate for a leaner usage, whereby the DB connectionis set globally through a cassio.init(…) call: then, the DB detailsare not to be specified anymore when creating a vector store, unlessdesired.

Parameters* **table** (*str*) – table name to use. If not existing, it will be created.
* **embedding\_dimension** (*int*) – length of the embedding vectors in use.
* **session** (*optional**,* *cassandra.cluster.Session*) – the Cassandra sessionto use.Can be omitted, or equivalently set to None, to use theDB connection set globally through cassio.init() beforehand.
* **keyspace** (*optional. str*) – name of the Cassandra keyspace to work inCan be omitted, or equivalently set to None, to use theDB connection set globally through cassio.init() beforehand.
* **ttl\_seconds** (*optional**,* *int*) – expiration time for inserted entries.Default is no expiration (None).
* **insertion\_batch\_size** (*optional**,* *int*) – how many vectors are insertedconcurrently, for use by bulk inserts. Defaults to 20.
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.CassandraVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of node with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.CassandraVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.CassandraVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.CassandraVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.CassandraVectorStore.client "Permalink to this definition")Return the underlying cassIO vector table object.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.CassandraVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.CassandraVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Supported query modes: ‘default’ (most similar vectors) and ‘mmr’.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – the basic query definition. Defines:mode (VectorStoreQueryMode): one of the supported modesquery\_embedding (List[float]): query embedding to search againstsimilarity\_top\_k (int): top k most similar nodesmmr\_threshold (Optional[float]): this is the 0-to-1 MMR lambda.


> If present, takes precedence over the kwargs parameter.Ignored unless for MMR queries.
> 
> 



Args for query.mode == ‘mmr’ (ignored otherwise):mmr\_threshold (Optional[float]): this is the 0-to-1 lambda for MMR.Note that in principle mmr\_threshold could come in the query

mmr\_prefetch\_factor (Optional[float]): factor applied to top\_kfor prefetch pool size. Defaults to 4.0

mmr\_prefetch\_k (Optional[int]): prefetch pool size. This cannot bepassed together with mmr\_prefetch\_factor

*class* llama\_index.vector\_stores.ChatGPTRetrievalPluginClient(*endpoint\_url: str*, *bearer\_token: Optional[str] = None*, *retries: Optional[Retry] = None*, *batch\_size: int = 100*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient "Permalink to this definition")ChatGPT Retrieval Plugin Client.

In this client, we make use of the endpoints defined by ChatGPT.

Parameters* **endpoint\_url** (*str*) – URL of the ChatGPT Retrieval Plugin.
* **bearer\_token** (*Optional**[**str**]*) – Bearer token for the ChatGPT Retrieval Plugin.
* **retries** (*Optional**[**Retry**]*) – Retry object for the ChatGPT Retrieval Plugin.
* **batch\_size** (*int*) – Batch size for the ChatGPT Retrieval Plugin.
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.add "Permalink to this definition")Add nodes to index.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: None*[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ChatGPTRetrievalPluginClient.query "Permalink to this definition")Get nodes for response.

*pydantic model* llama\_index.vector\_stores.ChromaVectorStore[](#llama_index.vector_stores.ChromaVectorStore "Permalink to this definition")Chroma vector store.

In this vector store, embeddings are stored within a ChromaDB collection.

During query time, the index uses ChromaDB to query for the topk most similar nodes.

Parameters**chroma\_collection** (*chromadb.api.models.Collection.Collection*) – ChromaDB collection instance

Show JSON schema
```
{ "title": "ChromaVectorStore", "description": "Chroma vector store.\n\nIn this vector store, embeddings are stored within a ChromaDB collection.\n\nDuring query time, the index uses ChromaDB to query for the top\nk most similar nodes.\n\nArgs:\n chroma\_collection (chromadb.api.models.Collection.Collection):\n ChromaDB collection instance", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "flat\_metadata": { "title": "Flat Metadata", "default": true, "type": "boolean" }, "host": { "title": "Host", "type": "string" }, "port": { "title": "Port", "type": "string" }, "ssl": { "title": "Ssl", "type": "boolean" }, "headers": { "title": "Headers", "type": "object", "additionalProperties": { "type": "string" } }, "persist\_dir": { "title": "Persist Dir", "type": "string" }, "collection\_kwargs": { "title": "Collection Kwargs", "type": "object" } }, "required": [ "ssl" ]}
```


Fields* `collection\_kwargs (Dict[str, Any])`
* `flat\_metadata (bool)`
* `headers (Optional[Dict[str, str]])`
* `host (Optional[str])`
* `is\_embedding\_query (bool)`
* `persist\_dir (Optional[str])`
* `port (Optional[str])`
* `ssl (bool)`
* `stores\_text (bool)`
*field* collection\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.vector_stores.ChromaVectorStore.collection_kwargs "Permalink to this definition")*field* flat\_metadata*: bool* *= True*[](#llama_index.vector_stores.ChromaVectorStore.flat_metadata "Permalink to this definition")*field* headers*: Optional[Dict[str, str]]* *= None*[](#llama_index.vector_stores.ChromaVectorStore.headers "Permalink to this definition")*field* host*: Optional[str]* *= None*[](#llama_index.vector_stores.ChromaVectorStore.host "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.ChromaVectorStore.is_embedding_query "Permalink to this definition")*field* persist\_dir*: Optional[str]* *= None*[](#llama_index.vector_stores.ChromaVectorStore.persist_dir "Permalink to this definition")*field* port*: Optional[str]* *= None*[](#llama_index.vector_stores.ChromaVectorStore.port "Permalink to this definition")*field* ssl*: bool* *[Required]*[](#llama_index.vector_stores.ChromaVectorStore.ssl "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.ChromaVectorStore.stores_text "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.ChromaVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ChromaVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ChromaVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.ChromaVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*classmethod* class\_name() → str[](#llama_index.vector_stores.ChromaVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.ChromaVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.ChromaVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ChromaVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.ChromaVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.ChromaVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.ChromaVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.ChromaVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*collection\_name: str*, *host: Optional[str] = None*, *port: Optional[str] = None*, *ssl: bool = False*, *headers: Optional[Dict[str, str]] = None*, *persist\_dir: Optional[str] = None*, *collection\_kwargs: Optional[dict] = {}*, *\*\*kwargs: Any*) → [ChromaVectorStore](#llama_index.vector_stores.ChromaVectorStore "llama_index.vector_stores.chroma.ChromaVectorStore")[](#llama_index.vector_stores.ChromaVectorStore.from_params "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.ChromaVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.ChromaVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.ChromaVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.ChromaVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.ChromaVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ChromaVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query\_embedding** (*List**[**float**]*) – query embedding
* **similarity\_top\_k** (*int*) – top k most similar nodes
*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.ChromaVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.ChromaVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.ChromaVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.ChromaVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.ChromaVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.ChromaVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.ChromaVectorStore.client "Permalink to this definition")Return client.

*class* llama\_index.vector\_stores.CognitiveSearchVectorStore(*search\_or\_index\_client: Any*, *id\_field\_key: str*, *chunk\_field\_key: str*, *embedding\_field\_key: str*, *metadata\_string\_field\_key: str*, *doc\_id\_field\_key: str*, *filterable\_metadata\_field\_keys: Optional[Union[List[str], Dict[str, str], Dict[str, Tuple[str, MetadataIndexFieldType]]]] = None*, *index\_name: Optional[str] = None*, *index\_mapping: Optional[Callable[[Dict[str, str], Dict[str, Any]], Dict[str, str]]] = None*, *index\_management: IndexManagement = IndexManagement.NO\_VALIDATION*, *embedding\_dimensionality: int = 1536*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.CognitiveSearchVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.CognitiveSearchVectorStore.add "Permalink to this definition")Add nodes to index associated with the configured search client.

Parameters**nodes** – List[BaseNode]: nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.CognitiveSearchVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.CognitiveSearchVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.CognitiveSearchVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.CognitiveSearchVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.CognitiveSearchVectorStore.delete "Permalink to this definition")Delete documents from the Cognitive Search Indexwith doc\_id\_field\_key field equal to ref\_doc\_id.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.CognitiveSearchVectorStore.query "Permalink to this definition")Query vector store.

*class* llama\_index.vector\_stores.DashVectorStore(*collection: Optional[Any] = None*)[](#llama_index.vector_stores.DashVectorStore "Permalink to this definition")Dash Vector Store.

In this vector store, embeddings and docs are stored within aDashVector collection.

During query time, the index uses DashVector to query for the topk most similar nodes.

Parameters**collection** (*Optional**[**dashvector.Collection**]*) – DashVector collection instance

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.DashVectorStore.add "Permalink to this definition")Add nodes to vector store.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DashVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DashVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.DashVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.DashVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DashVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DashVectorStore.query "Permalink to this definition")Query vector store.

*class* llama\_index.vector\_stores.DeepLakeVectorStore(*dataset\_path: str = 'llama\_index'*, *token: Optional[str] = None*, *read\_only: Optional[bool] = False*, *ingestion\_batch\_size: int = 1024*, *ingestion\_num\_workers: int = 4*, *overwrite: bool = False*, *exec\_option: Optional[str] = None*, *verbose: bool = True*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.DeepLakeVectorStore "Permalink to this definition")The DeepLake Vector Store.

In this vector store we store the text, its embedding anda few pieces of its metadata in a deeplake dataset. This implemnetationallows the use of an already existing deeplake dataset if it is one that was createdthis vector store. It also supports creating a new one if the dataset doesn’texist or if overwrite is set to True.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.DeepLakeVectorStore.add "Permalink to this definition")Add the embeddings and their nodes into DeepLake.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddingsto insert.

ReturnsList of ids inserted.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DeepLakeVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DeepLakeVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.DeepLakeVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.DeepLakeVectorStore.client "Permalink to this definition")Get client.

ReturnsDeepLake vectorstore dataset.

Return typeAny

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DeepLakeVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DeepLakeVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – VectorStoreQuery class input, it hasthe following attributes:1. query\_embedding (List[float]): query embedding2. similarity\_top\_k (int): top k most similar nodes
* **deep\_memory** (*bool*) – Whether to use deep memory for query execution.
ReturnsVectorStoreQueryResult

*class* llama\_index.vector\_stores.DocArrayHnswVectorStore(*work\_dir: str*, *dim: int = 1536*, *dist\_metric: Literal['cosine', 'ip', 'l2'] = 'cosine'*, *max\_elements: int = 1024*, *ef\_construction: int = 200*, *ef: int = 10*, *M: int = 16*, *allow\_replace\_deleted: bool = True*, *num\_threads: int = 1*)[](#llama_index.vector_stores.DocArrayHnswVectorStore "Permalink to this definition")Class representing a DocArray HNSW vector store.

This class is a lightweight Document Index implementation provided by Docarray.It stores vectors on disk in hnswlib, and stores all other data in SQLite.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.DocArrayHnswVectorStore.add "Permalink to this definition")Adds nodes to the vector store.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddings.

ReturnsList of document IDs added to the vector store.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DocArrayHnswVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DocArrayHnswVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.DocArrayHnswVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.DocArrayHnswVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DocArrayHnswVectorStore.delete "Permalink to this definition")Deletes a document from the vector store.

Parameters* **ref\_doc\_id** (*str*) – Document ID to be deleted.
* **\*\*delete\_kwargs** (*Any*) – Additional arguments to pass to the delete method.
num\_docs() → int[](#llama_index.vector_stores.DocArrayHnswVectorStore.num_docs "Permalink to this definition")Retrieves the number of documents in the index.

ReturnsThe number of documents in the index.

Return typeint

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DocArrayHnswVectorStore.query "Permalink to this definition")Queries the vector store and retrieves the results.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – Query for the vector store.

ReturnsResult of the query from vector store.

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

*class* llama\_index.vector\_stores.DocArrayInMemoryVectorStore(*index\_path: Optional[str] = None*, *metric: Literal['cosine\_sim', 'euclidian\_dist', 'sgeuclidean\_dist'] = 'cosine\_sim'*)[](#llama_index.vector_stores.DocArrayInMemoryVectorStore "Permalink to this definition")Class representing a DocArray In-Memory vector store.

This class is a document index provided by Docarray that stores documents in memory.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.DocArrayInMemoryVectorStore.add "Permalink to this definition")Adds nodes to the vector store.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddings.

ReturnsList of document IDs added to the vector store.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.DocArrayInMemoryVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.delete "Permalink to this definition")Deletes a document from the vector store.

Parameters* **ref\_doc\_id** (*str*) – Document ID to be deleted.
* **\*\*delete\_kwargs** (*Any*) – Additional arguments to pass to the delete method.
num\_docs() → int[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.num_docs "Permalink to this definition")Retrieves the number of documents in the index.

ReturnsThe number of documents in the index.

Return typeint

persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.persist "Permalink to this definition")Persists the in-memory vector store to a file.

Parameters* **persist\_path** (*str*) – The path to persist the index.
* **fs** (*fsspec.AbstractFileSystem**,* *optional*) – Filesystem to persist to.(doesn’t apply)
query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.DocArrayInMemoryVectorStore.query "Permalink to this definition")Queries the vector store and retrieves the results.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – Query for the vector store.

ReturnsResult of the query from vector store.

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

*class* llama\_index.vector\_stores.ElasticsearchStore(*index\_name: str*, *es\_client: Optional[Any] = None*, *es\_url: Optional[str] = None*, *es\_cloud\_id: Optional[str] = None*, *es\_api\_key: Optional[str] = None*, *es\_user: Optional[str] = None*, *es\_password: Optional[str] = None*, *text\_field: str = 'content'*, *vector\_field: str = 'embedding'*, *batch\_size: int = 200*, *distance\_strategy: Optional[Literal['COSINE', 'DOT\_PRODUCT', 'EUCLIDEAN\_DISTANCE']] = 'COSINE'*)[](#llama_index.vector_stores.ElasticsearchStore "Permalink to this definition")Elasticsearch vector store.

Parameters* **index\_name** – Name of the Elasticsearch index.
* **es\_client** – Optional. Pre-existing AsyncElasticsearch client.
* **es\_url** – Optional. Elasticsearch URL.
* **es\_cloud\_id** – Optional. Elasticsearch cloud ID.
* **es\_api\_key** – Optional. Elasticsearch API key.
* **es\_user** – Optional. Elasticsearch username.
* **es\_password** – Optional. Elasticsearch password.
* **text\_field** – Optional. Name of the Elasticsearch field that stores the text.
* **vector\_field** – Optional. Name of the Elasticsearch field that stores theembedding.
* **batch\_size** – Optional. Batch size for bulk indexing. Defaults to 200.
* **distance\_strategy** – Optional. Distance strategy to use for similarity search.Defaults to “COSINE”.
Raises* **ConnectionError** – If AsyncElasticsearch client cannot connect to Elasticsearch.
* **ValueError** – If neither es\_client nor es\_url nor es\_cloud\_id is provided.
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\**, *create\_index\_if\_not\_exists: bool = True*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.ElasticsearchStore.add "Permalink to this definition")Add nodes to Elasticsearch index.

Parameters* **nodes** – List of nodes with embeddings.
* **create\_index\_if\_not\_exists** – Optional. Whether to createthe Elasticsearch index if itdoesn’t already exist.Defaults to True.
ReturnsList of node IDs that were added to the index.

Raises* **ImportError** – If elasticsearch[‘async’] python package is not installed.
* **BulkIndexError** – If AsyncElasticsearch async\_bulk indexing fails.
*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ElasticsearchStore.adelete "Permalink to this definition")Async delete node from Elasticsearch index.

Parameters* **ref\_doc\_id** – ID of the node to delete.
* **delete\_kwargs** – Optional. Additional arguments topass to AsyncElasticsearch delete\_by\_query.
Raises**Exception** – If AsyncElasticsearch delete\_by\_query fails.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *custom\_query: Optional[Callable[[Dict, Optional[[VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")]], Dict]] = None*, *es\_filter: Optional[List[Dict]] = None*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ElasticsearchStore.aquery "Permalink to this definition")Asynchronous query index for top k most similar nodes.

Parameters* **query\_embedding** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query embedding
* **custom\_query** – Optional. custom query function that takes in the es querybody and returns a modified query body.This can be used to add additional queryparameters to the AsyncElasticsearch query.
* **es\_filter** – Optional. AsyncElasticsearch filter to apply to thequery. If filter is provided in the query,this filter will be ignored.
ReturnsResult of the query.

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

Raises**Exception** – If AsyncElasticsearch query fails.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\**, *create\_index\_if\_not\_exists: bool = True*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.ElasticsearchStore.async_add "Permalink to this definition")Asynchronous method to add nodes to Elasticsearch index.

Parameters* **nodes** – List of nodes with embeddings.
* **create\_index\_if\_not\_exists** – Optional. Whether to createthe AsyncElasticsearch index if itdoesn’t already exist.Defaults to True.
ReturnsList of node IDs that were added to the index.

Raises* **ImportError** – If elasticsearch python package is not installed.
* **BulkIndexError** – If AsyncElasticsearch async\_bulk indexing fails.
*property* client*: Any*[](#llama_index.vector_stores.ElasticsearchStore.client "Permalink to this definition")Get async elasticsearch client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.ElasticsearchStore.delete "Permalink to this definition")Delete node from Elasticsearch index.

Parameters* **ref\_doc\_id** – ID of the node to delete.
* **delete\_kwargs** – Optional. Additional arguments topass to Elasticsearch delete\_by\_query.
Raises**Exception** – If Elasticsearch delete\_by\_query fails.

*static* get\_user\_agent() → str[](#llama_index.vector_stores.ElasticsearchStore.get_user_agent "Permalink to this definition")Get user agent for elasticsearch client.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *custom\_query: Optional[Callable[[Dict, Optional[[VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")]], Dict]] = None*, *es\_filter: Optional[List[Dict]] = None*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.ElasticsearchStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query\_embedding** (*List**[**float**]*) – query embedding
* **custom\_query** – Optional. custom query function that takes in the es querybody and returns a modified query body.This can be used to add additional queryparameters to the Elasticsearch query.
* **es\_filter** – Optional. Elasticsearch filter to apply to thequery. If filter is provided in the query,this filter will be ignored.
ReturnsResult of the query.

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

Raises**Exception** – If Elasticsearch query fails.

*class* llama\_index.vector\_stores.EpsillaVectorStore(*client: Any*, *collection\_name: str = 'llama\_collection'*, *db\_path: Optional[str] = './storage'*, *db\_name: Optional[str] = 'llama\_db'*, *dimension: Optional[int] = None*, *overwrite: bool = False*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.EpsillaVectorStore "Permalink to this definition")The Epsilla Vector Store.

In this vector store we store the text, its embedding anda few pieces of its metadata in a Epsilla collection. This implemnetationallows the use of an already existing collection.It also supports creating a new one if the collection does notexist or if overwrite is set to True.

As a prerequisite, you need to install `pyepsilla` packageand have a running Epsilla vector database (for example, through our docker image)See the following documentation for how to run an Epsilla vector database:<https://epsilla-inc.gitbook.io/epsilladb/quick-start>

Parameters* **client** (*Any*) – Epsilla client to connect to.
* **collection\_name** (*Optional**[**str**]*) – Which collection to use.Defaults to “llama\_collection”.
* **db\_path** (*Optional**[**str**]*) – The path where the database will be persisted.Defaults to “/tmp/langchain-epsilla”.
* **db\_name** (*Optional**[**str**]*) – Give a name to the loaded database.Defaults to “langchain\_store”.
* **dimension** (*Optional**[**int**]*) – The dimension of the embeddings. If not provided,collection creation will be done on first insert. Defaults to None.
* **overwrite** (*Optional**[**bool**]*) – Whether to overwrite existing collection with samename. Defaults to False.
ReturnsVectorstore that supports add, delete, and query.

Return type[EpsillaVectorStore](#llama_index.vector_stores.EpsillaVectorStore "llama_index.vector_stores.EpsillaVectorStore")

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.EpsillaVectorStore.add "Permalink to this definition")Add nodes to Epsilla vector store.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

ReturnsList of ids inserted.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.EpsillaVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.EpsillaVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.EpsillaVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

client() → Any[](#llama_index.vector_stores.EpsillaVectorStore.client "Permalink to this definition")Return the Epsilla client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.EpsillaVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.EpsillaVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query.

ReturnsVector store query result.

*class* llama\_index.vector\_stores.FaissVectorStore(*faiss\_index: Any*)[](#llama_index.vector_stores.FaissVectorStore "Permalink to this definition")Faiss Vector Store.

Embeddings are stored within a Faiss index.

During query time, the index uses Faiss to query for the topk embeddings, and returns the corresponding indices.

Parameters**faiss\_index** (*faiss.Index*) – Faiss index instance

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.FaissVectorStore.add "Permalink to this definition")Add nodes to index.

NOTE: in the Faiss vector store, we do not store text in Faiss.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.FaissVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.FaissVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.FaissVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.FaissVectorStore.client "Permalink to this definition")Return the faiss index.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.FaissVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

persist(*persist\_path: str = './storage/vector\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.FaissVectorStore.persist "Permalink to this definition")Save to file.

This method saves the vector store to disk.

Parameters**persist\_path** (*str*) – The save\_path of the file.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.FaissVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query\_embedding** (*List**[**float**]*) – query embedding
* **similarity\_top\_k** (*int*) – top k most similar nodes
*class* llama\_index.vector\_stores.LanceDBVectorStore(*uri: str*, *table\_name: str = 'vectors'*, *nprobes: int = 20*, *refine\_factor: Optional[int] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.LanceDBVectorStore "Permalink to this definition")The LanceDB Vector Store.

Stores text and embeddings in LanceDB. The vector store will open an existingLanceDB dataset or create the dataset if it does not exist.

Parameters* **uri** (*str**,* *required*) – Location where LanceDB will store its files.
* **table\_name** (*str**,* *optional*) – The table name where the embeddings will be stored.Defaults to “vectors”.
* **nprobes** (*int**,* *optional*) – The number of probes used.A higher number makes search more accurate but also slower.Defaults to 20.
* **refine\_factor** – (int, optional): Refine the results by reading extra elementsand re-ranking them in memory.Defaults to None
Raises**ImportError** – Unable to import lancedb.

ReturnsVectorStore that supports creating LanceDB datasets andquerying it.



Return type[LanceDBVectorStore](#llama_index.vector_stores.LanceDBVectorStore "llama_index.vector_stores.LanceDBVectorStore")

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.LanceDBVectorStore.add "Permalink to this definition")Add nodes with embedding to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.LanceDBVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.LanceDBVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.LanceDBVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: None*[](#llama_index.vector_stores.LanceDBVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.LanceDBVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.LanceDBVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

*pydantic model* llama\_index.vector\_stores.LanternVectorStore[](#llama_index.vector_stores.LanternVectorStore "Permalink to this definition")Show JSON schema
```
{ "title": "LanternVectorStore", "description": "Abstract vector store protocol.", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "connection\_string": { "title": "Connection String", "type": "string" }, "async\_connection\_string": { "title": "Async Connection String", "type": "string" }, "table\_name": { "title": "Table Name", "type": "string" }, "schema\_name": { "title": "Schema Name", "type": "string" }, "embed\_dim": { "title": "Embed Dim", "type": "integer" }, "hybrid\_search": { "title": "Hybrid Search", "type": "boolean" }, "text\_search\_config": { "title": "Text Search Config", "type": "string" }, "cache\_ok": { "title": "Cache Ok", "type": "boolean" }, "perform\_setup": { "title": "Perform Setup", "type": "boolean" }, "debug": { "title": "Debug", "type": "boolean" }, "flat\_metadata": { "title": "Flat Metadata", "default": false, "type": "boolean" } }, "required": [ "connection\_string", "async\_connection\_string", "table\_name", "schema\_name", "embed\_dim", "hybrid\_search", "text\_search\_config", "cache\_ok", "perform\_setup", "debug" ]}
```


Fields* `async\_connection\_string (str)`
* `cache\_ok (bool)`
* `connection\_string (str)`
* `debug (bool)`
* `embed\_dim (int)`
* `hybrid\_search (bool)`
* `is\_embedding\_query (bool)`
* `perform\_setup (bool)`
* `schema\_name (str)`
* `stores\_text (bool)`
* `table\_name (str)`
* `text\_search\_config (str)`
*field* async\_connection\_string*: str* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.async_connection_string "Permalink to this definition")*field* cache\_ok*: bool* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.cache_ok "Permalink to this definition")*field* connection\_string*: str* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.connection_string "Permalink to this definition")*field* debug*: bool* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.debug "Permalink to this definition")*field* embed\_dim*: int* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.embed_dim "Permalink to this definition")*field* hybrid\_search*: bool* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.hybrid_search "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.LanternVectorStore.is_embedding_query "Permalink to this definition")*field* perform\_setup*: bool* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.perform_setup "Permalink to this definition")*field* schema\_name*: str* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.schema_name "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.LanternVectorStore.stores_text "Permalink to this definition")*field* table\_name*: str* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.table_name "Permalink to this definition")*field* text\_search\_config*: str* *[Required]*[](#llama_index.vector_stores.LanternVectorStore.text_search_config "Permalink to this definition")*class* Select(*\*entities: \_ColumnsClauseArgument[Any]*)[](#llama_index.vector_stores.LanternVectorStore.Select "Permalink to this definition")Represents a `SELECT` statement.

The `\_sql.Select` object is normally constructed using the`\_sql.select()` function. See that function for details.

See also

`\_sql.select()`

tutorial\_selecting\_data - in the 2.0 tutorial

add\_columns(*\*entities: \_ColumnsClauseArgument[Any]*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.LanternVectorStore.Select.add_columns "Permalink to this definition")Return a new `\_expression.select()` construct withthe given entities appended to its columns clause.

E.g.:


```
my\_select = my\_select.add\_columns(table.c.new\_column)
```
The original expressions in the columns clause remain in place.To replace the original expressions with new ones, see the method`\_expression.Select.with\_only\_columns()`.

Parameters**\*entities** – column, table, or other entity expressions to beadded to the columns clause

See also

`\_expression.Select.with\_only\_columns()` - replaces existingexpressions rather than appending.

orm\_queryguide\_select\_multiple\_entities - ORM-centricexample

add\_cte(*\*ctes: CTE*, *nest\_here: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.add_cte "Permalink to this definition")Add one or more `\_sql.CTE` constructs to this statement.

This method will associate the given `\_sql.CTE` constructs withthe parent statement such that they will each be unconditionallyrendered in the WITH clause of the final statement, even if notreferenced elsewhere within the statement or any sub-selects.

The optional [:paramref:`.HasCTE.add\_cte.nest\_here`](#id1) parameter when setto True will have the effect that each given `\_sql.CTE` willrender in a WITH clause rendered directly along with this statement,rather than being moved to the top of the ultimate rendered statement,even if this statement is rendered as a subquery within a largerstatement.

This method has two general uses. One is to embed CTE statements thatserve some purpose without being referenced explicitly, such as the usecase of embedding a DML statement such as an INSERT or UPDATE as a CTEinline with a primary statement that may draw from its resultsindirectly. The other is to provide control over the exact placementof a particular series of CTE constructs that should remain rendereddirectly in terms of a particular statement that may be nested in alarger statement.

E.g.:


```
from sqlalchemy import table, column, selectt = table('t', column('c1'), column('c2'))ins = t.insert().values({"c1": "x", "c2": "y"}).cte()stmt = select(t).add\_cte(ins)
```
Would render:


```
WITH anon\_1 AS(INSERT INTO t (c1, c2) VALUES (:param\_1, :param\_2))SELECT t.c1, t.c2FROM t
```
Above, the “anon\_1” CTE is not referenced in the SELECTstatement, however still accomplishes the task of running an INSERTstatement.

Similarly in a DML-related context, using the PostgreSQL`\_postgresql.Insert` construct to generate an “upsert”:


```
from sqlalchemy import table, columnfrom sqlalchemy.dialects.postgresql import insertt = table("t", column("c1"), column("c2"))delete\_statement\_cte = (    t.delete().where(t.c.c1 < 1).cte("deletions"))insert\_stmt = insert(t).values({"c1": 1, "c2": 2})update\_statement = insert\_stmt.on\_conflict\_do\_update(    index\_elements=[t.c.c1],    set\_={        "c1": insert\_stmt.excluded.c1,        "c2": insert\_stmt.excluded.c2,    },).add\_cte(delete\_statement\_cte)print(update\_statement)
```
The above statement renders as:


```
WITH deletions AS(DELETE FROM t WHERE t.c1 < %(c1\_1)s)INSERT INTO t (c1, c2) VALUES (%(c1)s, %(c2)s)ON CONFLICT (c1) DO UPDATE SET c1 = excluded.c1, c2 = excluded.c2
```
New in version 1.4.21.

Parameters* **\*ctes** – zero or more `CTE` constructs.

Changed in version 2.0: Multiple CTE instances are accepted
* **nest\_here** – if True, the given CTE or CTEs will be renderedas though they specified the [:paramref:`.HasCTE.cte.nesting`](#id3) flagto `True` when they were added to this `HasCTE`.Assuming the given CTEs are not referenced in an outer-enclosingstatement as well, the CTEs given should render at the level ofthis statement when this flag is given.

New in version 2.0.

See also

[:paramref:`.HasCTE.cte.nesting`](#id5)
alias(*name: Optional[str] = None*, *flat: bool = False*) → Subquery[](#llama_index.vector_stores.LanternVectorStore.Select.alias "Permalink to this definition")Return a named subquery against this`\_expression.SelectBase`.

For a `\_expression.SelectBase` (as opposed to a`\_expression.FromClause`),this returns a `Subquery` object which behaves mostly thesame as the `\_expression.Alias` object that is used with a`\_expression.FromClause`.

Changed in version 1.4: The `\_expression.SelectBase.alias()`method is nowa synonym for the `\_expression.SelectBase.subquery()` method.

as\_scalar() → ScalarSelect[Any][](#llama_index.vector_stores.LanternVectorStore.Select.as_scalar "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.as\_scalar()` method is deprecated and will be removed in a future release. Please refer to `\_expression.SelectBase.scalar\_subquery()`.

*property* c*: ReadOnlyColumnCollection[str, KeyedColumnElement[Any]]*[](#llama_index.vector_stores.LanternVectorStore.Select.c "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.c` and `\_expression.SelectBase.columns` attributes are deprecated and will be removed in a future release; these attributes implicitly create a subquery that should be explicit. Please call `\_expression.SelectBase.subquery()` first in order to create a subquery, which then contains this attribute. To access the columns that this SELECT object SELECTs from, use the `\_expression.SelectBase.selected\_columns` attribute.

column(*column: \_ColumnsClauseArgument[Any]*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.LanternVectorStore.Select.column "Permalink to this definition")Return a new `\_expression.select()` construct withthe given column expression added to its columns clause.

Deprecated since version 1.4: The `\_expression.Select.column()` method is deprecated and will be removed in a future release. Please use `\_expression.Select.add\_columns()`

E.g.:


```
my\_select = my\_select.column(table.c.new\_column)
```
See the documentation for`\_expression.Select.with\_only\_columns()`for guidelines on adding /replacing the columns of a`\_expression.Select` object.

*property* column\_descriptions*: Any*[](#llama_index.vector_stores.LanternVectorStore.Select.column_descriptions "Permalink to this definition")Return a plugin-enabled ‘column descriptions’ structurereferring to the columns which are SELECTed by this statement.

This attribute is generally useful when using the ORM, as anextended structure which includes information about mappedentities is returned. The section queryguide\_inspectioncontains more background.

For a Core-only statement, the structure returned by this accessoris derived from the same objects that are returned by the[`Select.selected\_columns`](#llama_index.vector_stores.LanternVectorStore.Select.selected_columns "llama_index.vector_stores.LanternVectorStore.Select.selected_columns") accessor, formatted as a list ofdictionaries which contain the keys `name`, `type` and `expr`,which indicate the column expressions to be selected:


```
>>> stmt = select(user\_table)>>> stmt.column\_descriptions[ { 'name': 'id', 'type': Integer(), 'expr': Column('id', Integer(), ...)}, { 'name': 'name', 'type': String(length=30), 'expr': Column('name', String(length=30), ...)}]
```
Changed in version 1.4.33: The [`Select.column\_descriptions`](#llama_index.vector_stores.LanternVectorStore.Select.column_descriptions "llama_index.vector_stores.LanternVectorStore.Select.column_descriptions")attribute returns a structure for a Core-only set of entities,not just ORM-only entities.

See also

`UpdateBase.entity\_description` - entity information foran `insert()`, `update()`, or `delete()`

queryguide\_inspection - ORM background

*property* columns\_clause\_froms*: List[FromClause]*[](#llama_index.vector_stores.LanternVectorStore.Select.columns_clause_froms "Permalink to this definition")Return the set of `\_expression.FromClause` objects impliedby the columns clause of this SELECT statement.

New in version 1.4.23.

See also

`\_sql.Select.froms` - “final” FROM list taking the fullstatement into account

`\_sql.Select.with\_only\_columns()` - makes use of thiscollection to set up a new FROM list

compare(*other: ClauseElement*, *\*\*kw: Any*) → bool[](#llama_index.vector_stores.LanternVectorStore.Select.compare "Permalink to this definition")Compare this `\_expression.ClauseElement` tothe given `\_expression.ClauseElement`.

Subclasses should override the default behavior, which is astraight identity comparison.

\*\*kw are arguments consumed by subclass `compare()` methods andmay be used to modify the criteria for comparison(see `\_expression.ColumnElement`).

compile(*bind: Optional[Union[Engine, Connection]] = None*, *dialect: Optional[Dialect] = None*, *\*\*kw: Any*) → Compiled[](#llama_index.vector_stores.LanternVectorStore.Select.compile "Permalink to this definition")Compile this SQL expression.

The return value is a `Compiled` object.Calling `str()` or `unicode()` on the returned value will yield astring representation of the result. The`Compiled` object also can return adictionary of bind parameter names and valuesusing the `params` accessor.

Parameters* **bind** – An `Connection` or `Engine` whichcan provide a `Dialect` in order to generate a`Compiled` object. If the `bind` and`dialect` parameters are both omitted, a default SQL compileris used.
* **column\_keys** – Used for INSERT and UPDATE statements, a list ofcolumn names which should be present in the VALUES clause of thecompiled statement. If `None`, all columns from the target tableobject are rendered.
* **dialect** – A `Dialect` instance which can generatea `Compiled` object. This argument takes precedence overthe `bind` argument.
* **compile\_kwargs** – optional dictionary of additional parametersthat will be passed through to the compiler within all “visit”methods. This allows any custom flag to be passed through toa custom compilation construct, for example. It is also usedfor the case of passing the `literal\_binds` flag through:


```
from sqlalchemy.sql import table, column, selectt = table('t', column('x'))s = select(t).where(t.c.x == 5)print(s.compile(compile\_kwargs={"literal\_binds": True}))
```
See also

faq\_sql\_expression\_string

correlate(*\*fromclauses: Union[Literal[None, False], \_FromClauseArgument]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.correlate "Permalink to this definition")Return a new `\_expression.Select`which will correlate the given FROMclauses to that of an enclosing `\_expression.Select`.

Calling this method turns off the `\_expression.Select` object’sdefault behavior of “auto-correlation”. Normally, FROM elementswhich appear in a `\_expression.Select`that encloses this one viaits WHERE clause, ORDER BY, HAVING orcolumns clause will be omitted from this`\_expression.Select`object’s FROM clause.Setting an explicit correlation collection using the`\_expression.Select.correlate()`method provides a fixed list of FROM objectsthat can potentially take place in this process.

When `\_expression.Select.correlate()`is used to apply specific FROM clausesfor correlation, the FROM elements become candidates forcorrelation regardless of how deeply nested this`\_expression.Select`object is, relative to an enclosing `\_expression.Select`which refers tothe same FROM object. This is in contrast to the behavior of“auto-correlation” which only correlates to an immediate enclosing`\_expression.Select`.Multi-level correlation ensures that the linkbetween enclosed and enclosing `\_expression.Select`is always viaat least one WHERE/ORDER BY/HAVING/columns clause in order forcorrelation to take place.

If `None` is passed, the `\_expression.Select`object will correlatenone of its FROM entries, and all will render unconditionallyin the local FROM clause.

Parameters**\*fromclauses** – one or more `FromClause` or otherFROM-compatible construct such as an ORM mapped entity to become partof the correlate collection; alternatively pass a single value`None` to remove all existing correlations.

See also

`\_expression.Select.correlate\_except()`

tutorial\_scalar\_subquery

correlate\_except(*\*fromclauses: Union[Literal[None, False], \_FromClauseArgument]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.correlate_except "Permalink to this definition")Return a new `\_expression.Select`which will omit the given FROMclauses from the auto-correlation process.

Calling `\_expression.Select.correlate\_except()` turns off the`\_expression.Select` object’s default behavior of“auto-correlation” for the given FROM elements. An elementspecified here will unconditionally appear in the FROM list, whileall other FROM elements remain subject to normal auto-correlationbehaviors.

If `None` is passed, or no arguments are passed,the `\_expression.Select` object will correlate all of itsFROM entries.

Parameters**\*fromclauses** – a list of one or more`\_expression.FromClause`constructs, or other compatible constructs (i.e. ORM-mappedclasses) to become part of the correlate-exception collection.

See also

`\_expression.Select.correlate()`

tutorial\_scalar\_subquery

corresponding\_column(*column: KeyedColumnElement[Any]*, *require\_embedded: bool = False*) → Optional[KeyedColumnElement[Any]][](#llama_index.vector_stores.LanternVectorStore.Select.corresponding_column "Permalink to this definition")Given a `\_expression.ColumnElement`, return the exported`\_expression.ColumnElement` object from the`\_expression.Selectable.exported\_columns`collection of this `\_expression.Selectable`which corresponds to thatoriginal `\_expression.ColumnElement` via a common ancestorcolumn.

Parameters* **column** – the target `\_expression.ColumnElement`to be matched.
* **require\_embedded** – only return corresponding columns forthe given `\_expression.ColumnElement`, if the given`\_expression.ColumnElement`is actually present within a sub-elementof this `\_expression.Selectable`.Normally the column will match ifit merely shares a common ancestor with one of the exportedcolumns of this `\_expression.Selectable`.
See also

`\_expression.Selectable.exported\_columns` - the`\_expression.ColumnCollection`that is used for the operation.

`\_expression.ColumnCollection.corresponding\_column()`- implementationmethod.

cte(*name: Optional[str] = None*, *recursive: bool = False*, *nesting: bool = False*) → CTE[](#llama_index.vector_stores.LanternVectorStore.Select.cte "Permalink to this definition")Return a new `\_expression.CTE`,or Common Table Expression instance.

Common table expressions are a SQL standard whereby SELECTstatements can draw upon secondary statements specified alongwith the primary statement, using a clause called “WITH”.Special semantics regarding UNION can also be employed toallow “recursive” queries, where a SELECT statement can drawupon the set of rows that have previously been selected.

CTEs can also be applied to DML constructs UPDATE, INSERTand DELETE on some databases, both as a source of CTE rowswhen combined with RETURNING, as well as a consumer ofCTE rows.

SQLAlchemy detects `\_expression.CTE` objects, which are treatedsimilarly to `\_expression.Alias` objects, as special elementsto be delivered to the FROM clause of the statement as wellas to a WITH clause at the top of the statement.

For special prefixes such as PostgreSQL “MATERIALIZED” and“NOT MATERIALIZED”, the `\_expression.CTE.prefix\_with()`method may beused to establish these.

Changed in version 1.3.13: Added support for prefixes.In particular - MATERIALIZED and NOT MATERIALIZED.

Parameters* **name** – name given to the common table expression. Like`\_expression.FromClause.alias()`, the name can be left as`None` in which case an anonymous symbol will be used at querycompile time.
* **recursive** – if `True`, will render `WITH RECURSIVE`.A recursive common table expression is intended to be used inconjunction with UNION ALL in order to derive rowsfrom those already selected.
* **nesting** – if `True`, will render the CTE locally to thestatement in which it is referenced. For more complex scenarios,the `HasCTE.add\_cte()` method using the[:paramref:`.HasCTE.add\_cte.nest\_here`](#id7)parameter may also be used to more carefullycontrol the exact placement of a particular CTE.

New in version 1.4.24.

See also

`HasCTE.add\_cte()`
The following examples include two from PostgreSQL’s documentation at<https://www.postgresql.org/docs/current/static/queries-with.html>,as well as additional examples.

Example 1, non recursive:


```
from sqlalchemy import (Table, Column, String, Integer,                        MetaData, select, func)metadata = MetaData()orders = Table('orders', metadata,    Column('region', String),    Column('amount', Integer),    Column('product', String),    Column('quantity', Integer))regional\_sales = select(                    orders.c.region,                    func.sum(orders.c.amount).label('total\_sales')                ).group\_by(orders.c.region).cte("regional\_sales")top\_regions = select(regional\_sales.c.region).\        where(            regional\_sales.c.total\_sales >            select(                func.sum(regional\_sales.c.total\_sales) / 10            )        ).cte("top\_regions")statement = select(            orders.c.region,            orders.c.product,            func.sum(orders.c.quantity).label("product\_units"),            func.sum(orders.c.amount).label("product\_sales")    ).where(orders.c.region.in\_(        select(top\_regions.c.region)    )).group\_by(orders.c.region, orders.c.product)result = conn.execute(statement).fetchall()
```
Example 2, WITH RECURSIVE:


```
from sqlalchemy import (Table, Column, String, Integer,                        MetaData, select, func)metadata = MetaData()parts = Table('parts', metadata,    Column('part', String),    Column('sub\_part', String),    Column('quantity', Integer),)included\_parts = select(\    parts.c.sub\_part, parts.c.part, parts.c.quantity\    ).\    where(parts.c.part=='our part').\    cte(recursive=True)incl\_alias = included\_parts.alias()parts\_alias = parts.alias()included\_parts = included\_parts.union\_all(    select(        parts\_alias.c.sub\_part,        parts\_alias.c.part,        parts\_alias.c.quantity    ).\    where(parts\_alias.c.part==incl\_alias.c.sub\_part))statement = select(            included\_parts.c.sub\_part,            func.sum(included\_parts.c.quantity).              label('total\_quantity')        ).\        group\_by(included\_parts.c.sub\_part)result = conn.execute(statement).fetchall()
```
Example 3, an upsert using UPDATE and INSERT with CTEs:


```
from datetime import datefrom sqlalchemy import (MetaData, Table, Column, Integer,                        Date, select, literal, and\_, exists)metadata = MetaData()visitors = Table('visitors', metadata,    Column('product\_id', Integer, primary\_key=True),    Column('date', Date, primary\_key=True),    Column('count', Integer),)# add 5 visitors for the product\_id == 1product\_id = 1day = date.today()count = 5update\_cte = (    visitors.update()    .where(and\_(visitors.c.product\_id == product\_id,                visitors.c.date == day))    .values(count=visitors.c.count + count)    .returning(literal(1))    .cte('update\_cte'))upsert = visitors.insert().from\_select(    [visitors.c.product\_id, visitors.c.date, visitors.c.count],    select(literal(product\_id), literal(day), literal(count))        .where(~exists(update\_cte.select())))connection.execute(upsert)
```
Example 4, Nesting CTE (SQLAlchemy 1.4.24 and above):


```
value\_a = select(    literal("root").label("n")).cte("value\_a")# A nested CTE with the same name as the root onevalue\_a\_nested = select(    literal("nesting").label("n")).cte("value\_a", nesting=True)# Nesting CTEs takes ascendency locally# over the CTEs at a higher levelvalue\_b = select(value\_a\_nested.c.n).cte("value\_b")value\_ab = select(value\_a.c.n.label("a"), value\_b.c.n.label("b"))
```
The above query will render the second CTE nested inside the first,shown with inline parameters below as:


```
WITH    value\_a AS        (SELECT 'root' AS n),    value\_b AS        (WITH value\_a AS            (SELECT 'nesting' AS n)        SELECT value\_a.n AS n FROM value\_a)SELECT value\_a.n AS a, value\_b.n AS bFROM value\_a, value\_b
```
The same CTE can be set up using the `HasCTE.add\_cte()` methodas follows (SQLAlchemy 2.0 and above):


```
value\_a = select(    literal("root").label("n")).cte("value\_a")# A nested CTE with the same name as the root onevalue\_a\_nested = select(    literal("nesting").label("n")).cte("value\_a")# Nesting CTEs takes ascendency locally# over the CTEs at a higher levelvalue\_b = (    select(value\_a\_nested.c.n).    add\_cte(value\_a\_nested, nest\_here=True).    cte("value\_b"))value\_ab = select(value\_a.c.n.label("a"), value\_b.c.n.label("b"))
```
Example 5, Non-Linear CTE (SQLAlchemy 1.4.28 and above):


```
edge = Table(    "edge",    metadata,    Column("id", Integer, primary\_key=True),    Column("left", Integer),    Column("right", Integer),)root\_node = select(literal(1).label("node")).cte(    "nodes", recursive=True)left\_edge = select(edge.c.left).join(    root\_node, edge.c.right == root\_node.c.node)right\_edge = select(edge.c.right).join(    root\_node, edge.c.left == root\_node.c.node)subgraph\_cte = root\_node.union(left\_edge, right\_edge)subgraph = select(subgraph\_cte)
```
The above query will render 2 UNIONs inside the recursive CTE:


```
WITH RECURSIVE nodes(node) AS (        SELECT 1 AS node    UNION        SELECT edge."left" AS "left"        FROM edge JOIN nodes ON edge."right" = nodes.node    UNION        SELECT edge."right" AS "right"        FROM edge JOIN nodes ON edge."left" = nodes.node)SELECT nodes.node FROM nodes
```
See also

`\_orm.Query.cte()` - ORM version of`\_expression.HasCTE.cte()`.

distinct(*\*expr: \_ColumnExpressionArgument[Any]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.distinct "Permalink to this definition")Return a new `\_expression.select()` construct whichwill apply DISTINCT to its columns clause.

Parameters**\*expr** – optional column expressions. When present,the PostgreSQL dialect will render a `DISTINCT ON (<expressions>>)`construct.

Deprecated since version 1.4: Using \*expr in other dialects is deprecatedand will raise `\_exc.CompileError` in a future version.



except\_(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.except_ "Permalink to this definition")Return a SQL `EXCEPT` of this select() construct againstthe given selectable provided as positional arguments.

Parameters**\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.



except\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.except_all "Permalink to this definition")Return a SQL `EXCEPT ALL` of this select() construct againstthe given selectables provided as positional arguments.

Parameters**\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.



execution\_options(*\*\*kw: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.execution_options "Permalink to this definition")Set non-SQL options for the statement which take effect duringexecution.

Execution options can be set at many scopes, including per-statement,per-connection, or per execution, using methods such as`\_engine.Connection.execution\_options()` and parameters whichaccept a dictionary of options such as[:paramref:`\_engine.Connection.execute.execution\_options`](#id9) and[:paramref:`\_orm.Session.execute.execution\_options`](#id11).

The primary characteristic of an execution option, as opposed toother kinds of options such as ORM loader options, is that**execution options never affect the compiled SQL of a query, onlythings that affect how the SQL statement itself is invoked or howresults are fetched**. That is, execution options are not part ofwhat’s accommodated by SQL compilation nor are they considered part ofthe cached state of a statement.

The `\_sql.Executable.execution\_options()` method isgenerative, asis the case for the method as applied to the `\_engine.Engine`and `\_orm.Query` objects, which means when the method is called,a copy of the object is returned, which applies the given parameters tothat new copy, but leaves the original unchanged:


```
statement = select(table.c.x, table.c.y)new\_statement = statement.execution\_options(my\_option=True)
```
An exception to this behavior is the `\_engine.Connection`object, where the `\_engine.Connection.execution\_options()` methodis explicitly **not** generative.

The kinds of options that may be passed to`\_sql.Executable.execution\_options()` and other related methods andparameter dictionaries include parameters that are explicitly consumedby SQLAlchemy Core or ORM, as well as arbitrary keyword arguments notdefined by SQLAlchemy, which means the methods and/or parameterdictionaries may be used for user-defined parameters that interact withcustom code, which may access the parameters using methods such as`\_sql.Executable.get\_execution\_options()` and`\_engine.Connection.get\_execution\_options()`, or within selectedevent hooks using a dedicated `execution\_options` event parametersuch as[:paramref:`\_events.ConnectionEvents.before\_execute.execution\_options`](#id13)or `\_orm.ORMExecuteState.execution\_options`, e.g.:


```
from sqlalchemy import event@event.listens\_for(some\_engine, "before\_execute")def \_process\_opt(conn, statement, multiparams, params, execution\_options):    "run a SQL function before invoking a statement"    if execution\_options.get("do\_special\_thing", False):        conn.exec\_driver\_sql("run\_special\_function()")
```
Within the scope of options that are explicitly recognized bySQLAlchemy, most apply to specific classes of objects and not others.The most common execution options include:

* [:paramref:`\_engine.Connection.execution\_options.isolation\_level`](#id15) -sets the isolation level for a connection or a class of connectionsvia an `\_engine.Engine`. This option is accepted onlyby `\_engine.Connection` or `\_engine.Engine`.
* [:paramref:`\_engine.Connection.execution\_options.stream\_results`](#id17) -indicates results should be fetched using a server side cursor;this option is accepted by `\_engine.Connection`, by the[:paramref:`\_engine.Connection.execute.execution\_options`](#id19) parameteron `\_engine.Connection.execute()`, and additionally by`\_sql.Executable.execution\_options()` on a SQL statement object,as well as by ORM constructs like `\_orm.Session.execute()`.
* [:paramref:`\_engine.Connection.execution\_options.compiled\_cache`](#id21) -indicates a dictionary that will serve as theSQL compilation cachefor a `\_engine.Connection` or `\_engine.Engine`, aswell as for ORM methods like `\_orm.Session.execute()`.Can be passed as `None` to disable caching for statements.This option is not accepted by`\_sql.Executable.execution\_options()` as it is inadvisable tocarry along a compilation cache within a statement object.
* [:paramref:`\_engine.Connection.execution\_options.schema\_translate\_map`](#id23)- a mapping of schema names used by theSchema Translate Map feature, acceptedby `\_engine.Connection`, `\_engine.Engine`,`\_sql.Executable`, as well as by ORM constructslike `\_orm.Session.execute()`.

See also

`\_engine.Connection.execution\_options()`

[:paramref:`\_engine.Connection.execute.execution\_options`](#id25)

[:paramref:`\_orm.Session.execute.execution\_options`](#id27)

orm\_queryguide\_execution\_options - documentation on allORM-specific execution options

exists() → Exists[](#llama_index.vector_stores.LanternVectorStore.Select.exists "Permalink to this definition")Return an `\_sql.Exists` representation of this selectable,which can be used as a column expression.

The returned object is an instance of `\_sql.Exists`.

See also

`\_sql.exists()`

tutorial\_exists - in the 2.0 style tutorial.

New in version 1.4.

*property* exported\_columns*: ReadOnlyColumnCollection[str, ColumnElement[Any]]*[](#llama_index.vector_stores.LanternVectorStore.Select.exported_columns "Permalink to this definition")A `\_expression.ColumnCollection`that represents the “exported”columns of this `\_expression.Selectable`, not including`\_sql.TextClause` constructs.

The “exported” columns for a `\_expression.SelectBase`object are synonymouswith the `\_expression.SelectBase.selected\_columns` collection.

New in version 1.4.

See also

`\_expression.Select.exported\_columns`

`\_expression.Selectable.exported\_columns`

`\_expression.FromClause.exported\_columns`

fetch(*count: \_LimitOffsetType*, *with\_ties: bool = False*, *percent: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.fetch "Permalink to this definition")Return a new selectable with the given FETCH FIRST criterionapplied.

This is a numeric value which usually renders as`FETCH {FIRST | NEXT} [ count ] {ROW | ROWS} {ONLY | WITH TIES}`expression in the resulting select. This functionality isis currently implemented for Oracle, PostgreSQL, MSSQL.

Use `\_sql.GenerativeSelect.offset()` to specify the offset.

Note

The `\_sql.GenerativeSelect.fetch()` method will replaceany clause applied with `\_sql.GenerativeSelect.limit()`.

New in version 1.4.

Parameters* **count** – an integer COUNT parameter, or a SQL expressionthat provides an integer result. When `percent=True` this willrepresent the percentage of rows to return, not the absolute value.Pass `None` to reset it.
* **with\_ties** – When `True`, the WITH TIES option is usedto return any additional rows that tie for the last place in theresult set according to the `ORDER BY` clause. The`ORDER BY` may be mandatory in this case. Defaults to `False`
* **percent** – When `True`, `count` represents the percentageof the total number of selected rows to return. Defaults to `False`
See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.offset()`

filter(*\*criteria: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.filter "Permalink to this definition")A synonym for the `\_sql.Select.where()` method.

filter\_by(*\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.filter_by "Permalink to this definition")apply the given filtering criterion as a WHERE clauseto this select.

from\_statement(*statement: ReturnsRowsRole*) → ExecutableReturnsRows[](#llama_index.vector_stores.LanternVectorStore.Select.from_statement "Permalink to this definition")Apply the columns which this [`Select`](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select") would selectonto another statement.

This operation is plugin-specific and will raise a notsupported exception if this `\_sql.Select` does not select fromplugin-enabled entities.

The statement is typically either a `\_expression.text()` or`\_expression.select()` construct, and should return the set ofcolumns appropriate to the entities represented by this[`Select`](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select").

See also

orm\_queryguide\_selecting\_text - usage examples in theORM Querying Guide

*property* froms*: Sequence[FromClause]*[](#llama_index.vector_stores.LanternVectorStore.Select.froms "Permalink to this definition")Return the displayed list of `\_expression.FromClause`elements.

Deprecated since version 1.4.23: The `\_expression.Select.froms` attribute is moved to the `\_expression.Select.get\_final\_froms()` method.

get\_children(*\*\*kw: Any*) → Iterable[ClauseElement][](#llama_index.vector_stores.LanternVectorStore.Select.get_children "Permalink to this definition")Return immediate child `visitors.HasTraverseInternals`elements of this `visitors.HasTraverseInternals`.

This is used for visit traversal.

\*\*kw may contain flags that change the collection that isreturned, for example to return a subset of items in order tocut down on larger traversals, or to return child items from adifferent context (such as schema-level collections instead ofclause-level).

get\_execution\_options() → \_ExecuteOptions[](#llama_index.vector_stores.LanternVectorStore.Select.get_execution_options "Permalink to this definition")Get the non-SQL options which will take effect during execution.

New in version 1.3.

See also

`Executable.execution\_options()`

get\_final\_froms() → Sequence[FromClause][](#llama_index.vector_stores.LanternVectorStore.Select.get_final_froms "Permalink to this definition")Compute the final displayed list of `\_expression.FromClause`elements.

This method will run through the full computation required todetermine what FROM elements will be displayed in the resultingSELECT statement, including shadowing individual tables withJOIN objects, as well as full computation for ORM use cases includingeager loading clauses.

For ORM use, this accessor returns the **post compilation**list of FROM objects; this collection will include elements such aseagerly loaded tables and joins. The objects will **not** beORM enabled and not work as a replacement for the`\_sql.Select.select\_froms()` collection; additionally, themethod is not well performing for an ORM enabled statement as itwill incur the full ORM construction process.

To retrieve the FROM list that’s implied by the “columns” collectionpassed to the `\_sql.Select` originally, use the`\_sql.Select.columns\_clause\_froms` accessor.

To select from an alternative set of columns while maintaining theFROM list, use the `\_sql.Select.with\_only\_columns()` method andpass the[:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id29)parameter.

New in version 1.4.23: - the `\_sql.Select.get\_final\_froms()`method replaces the previous `\_sql.Select.froms` accessor,which is deprecated.

See also

`\_sql.Select.columns\_clause\_froms`

get\_label\_style() → SelectLabelStyle[](#llama_index.vector_stores.LanternVectorStore.Select.get_label_style "Permalink to this definition")Retrieve the current label style.

New in version 1.4.

group\_by(*\_GenerativeSelect\_\_first: Union[Literal[None, \_NoArg.NO\_ARG], \_ColumnExpressionOrStrLabelArgument[Any]] = \_NoArg.NO\_ARG*, *\*clauses: \_ColumnExpressionOrStrLabelArgument[Any]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.group_by "Permalink to this definition")Return a new selectable with the given list of GROUP BYcriterion applied.

All existing GROUP BY settings can be suppressed by passing `None`.

e.g.:


```
stmt = select(table.c.name, func.max(table.c.stat)).\group\_by(table.c.name)
```
Parameters**\*clauses** – a series of `\_expression.ColumnElement`constructswhich will be used to generate an GROUP BY clause.

See also

tutorial\_group\_by\_w\_aggregates - in theunified\_tutorial

tutorial\_order\_by\_label - in the unified\_tutorial

having(*\*having: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.having "Permalink to this definition")Return a new `\_expression.select()` construct withthe given expression added toits HAVING clause, joined to the existing clause via AND, if any.

inherit\_cache*: Optional[bool]* *= None*[](#llama_index.vector_stores.LanternVectorStore.Select.inherit_cache "Permalink to this definition")Indicate if this `HasCacheKey` instance should make use of thecache key generation scheme used by its immediate superclass.

The attribute defaults to `None`, which indicates that a construct hasnot yet taken into account whether or not its appropriate for it toparticipate in caching; this is functionally equivalent to setting thevalue to `False`, except that a warning is also emitted.

This flag can be set to `True` on a particular class, if the SQL thatcorresponds to the object does not change based on attributes whichare local to this class, and not its superclass.

See also

compilerext\_caching - General guideslines for setting the`HasCacheKey.inherit\_cache` attribute for third-party or userdefined SQL constructs.

*property* inner\_columns*: \_SelectIterable*[](#llama_index.vector_stores.LanternVectorStore.Select.inner_columns "Permalink to this definition")An iterator of all `\_expression.ColumnElement`expressions which wouldbe rendered into the columns clause of the resulting SELECT statement.

This method is legacy as of 1.4 and is superseded by the`\_expression.Select.exported\_columns` collection.

intersect(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.intersect "Permalink to this definition")Return a SQL `INTERSECT` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
intersect\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.intersect_all "Permalink to this definition")Return a SQL `INTERSECT ALL` of this select() constructagainst the given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
is\_derived\_from(*fromclause: Optional[FromClause]*) → bool[](#llama_index.vector_stores.LanternVectorStore.Select.is_derived_from "Permalink to this definition")Return `True` if this `ReturnsRows` is‘derived’ from the given `FromClause`.

An example would be an Alias of a Table is derived from that Table.

join(*target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *isouter: bool = False*, *full: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.join "Permalink to this definition")Create a SQL JOIN against this `\_expression.Select`object’s criterionand apply generatively, returning the newly resulting`\_expression.Select`.

E.g.:


```
stmt = select(user\_table).join(address\_table, user\_table.c.id == address\_table.c.user\_id)
```
The above statement generates SQL similar to:


```
SELECT user.id, user.name FROM user JOIN address ON user.id = address.user\_id
```
Changed in version 1.4: `\_expression.Select.join()` now createsa `\_sql.Join` object between a `\_sql.FromClause`source that is within the FROM clause of the existing SELECT,and a given target `\_sql.FromClause`, and then addsthis `\_sql.Join` to the FROM clause of the newly generatedSELECT statement. This is completely reworked from the behaviorin 1.3, which would instead create a subquery of the entire`\_expression.Select` and then join that subquery to thetarget.

This is a **backwards incompatible change** as the previous behaviorwas mostly useless, producing an unnamed subquery rejected bymost databases in any case. The new behavior is modeled afterthat of the very successful `\_orm.Query.join()` method in theORM, in order to support the functionality of `\_orm.Query`being available by using a `\_sql.Select` object with an`\_orm.Session`.

See the notes for this change at change\_select\_join.

Parameters* **target** – target table to join towards
* **onclause** – ON clause of the join. If omitted, an ON clauseis generated automatically based on the `\_schema.ForeignKey`linkages between the two tables, if one can be unambiguouslydetermined, otherwise an error is raised.
* **isouter** – if True, generate LEFT OUTER join. Same as`\_expression.Select.outerjoin()`.
* **full** – if True, generate FULL OUTER join.
See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join\_from()`

`\_expression.Select.outerjoin()`

join\_from(*from\_: \_FromClauseArgument*, *target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *isouter: bool = False*, *full: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.join_from "Permalink to this definition")Create a SQL JOIN against this `\_expression.Select`object’s criterionand apply generatively, returning the newly resulting`\_expression.Select`.

E.g.:


```
stmt = select(user\_table, address\_table).join\_from(    user\_table, address\_table, user\_table.c.id == address\_table.c.user\_id)
```
The above statement generates SQL similar to:


```
SELECT user.id, user.name, address.id, address.email, address.user\_idFROM user JOIN address ON user.id = address.user\_id
```
New in version 1.4.

Parameters* **from\_** – the left side of the join, will be rendered in theFROM clause and is roughly equivalent to using the[`Select.select\_from()`](#llama_index.vector_stores.LanternVectorStore.Select.select_from "llama_index.vector_stores.LanternVectorStore.Select.select_from") method.
* **target** – target table to join towards
* **onclause** – ON clause of the join.
* **isouter** – if True, generate LEFT OUTER join. Same as`\_expression.Select.outerjoin()`.
* **full** – if True, generate FULL OUTER join.
See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join()`

label(*name: Optional[str]*) → Label[Any][](#llama_index.vector_stores.LanternVectorStore.Select.label "Permalink to this definition")Return a ‘scalar’ representation of this selectable, embedded as asubquery with a label.

See also

`\_expression.SelectBase.scalar\_subquery()`.

lateral(*name: Optional[str] = None*) → LateralFromClause[](#llama_index.vector_stores.LanternVectorStore.Select.lateral "Permalink to this definition")Return a LATERAL alias of this `\_expression.Selectable`.

The return value is the `\_expression.Lateral` construct alsoprovided by the top-level `\_expression.lateral()` function.

See also

tutorial\_lateral\_correlation - overview of usage.

limit(*limit: \_LimitOffsetType*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.limit "Permalink to this definition")Return a new selectable with the given LIMIT criterionapplied.

This is a numerical value which usually renders as a `LIMIT`expression in the resulting select. Backends that don’tsupport `LIMIT` will attempt to provide similarfunctionality.

Note

The `\_sql.GenerativeSelect.limit()` method will replaceany clause applied with `\_sql.GenerativeSelect.fetch()`.

Parameters**limit** – an integer LIMIT parameter, or a SQL expressionthat provides an integer result. Pass `None` to reset it.

See also

`\_sql.GenerativeSelect.fetch()`

`\_sql.GenerativeSelect.offset()`

offset(*offset: \_LimitOffsetType*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.offset "Permalink to this definition")Return a new selectable with the given OFFSET criterionapplied.

This is a numeric value which usually renders as an `OFFSET`expression in the resulting select. Backends that don’tsupport `OFFSET` will attempt to provide similarfunctionality.

Parameters**offset** – an integer OFFSET parameter, or a SQL expressionthat provides an integer result. Pass `None` to reset it.

See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.fetch()`

options(*\*options: ExecutableOption*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.options "Permalink to this definition")Apply options to this statement.

In the general sense, options are any kind of Python objectthat can be interpreted by the SQL compiler for the statement.These options can be consumed by specific dialects or specific kindsof compilers.

The most commonly known kind of option are the ORM level optionsthat apply “eager load” and other loading behaviors to an ORMquery. However, options can theoretically be used for many otherpurposes.

For background on specific kinds of options for specific kinds ofstatements, refer to the documentation for those option objects.

Changed in version 1.4: - added `Executable.options()` toCore statement objects towards the goal of allowing unifiedCore / ORM querying capabilities.

See also

loading\_columns - refers to options specific to the usageof ORM queries

relationship\_loader\_options - refers to options specificto the usage of ORM queries

order\_by(*\_GenerativeSelect\_\_first: Union[Literal[None, \_NoArg.NO\_ARG], \_ColumnExpressionOrStrLabelArgument[Any]] = \_NoArg.NO\_ARG*, *\*clauses: \_ColumnExpressionOrStrLabelArgument[Any]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.order_by "Permalink to this definition")Return a new selectable with the given list of ORDER BYcriteria applied.

e.g.:


```
stmt = select(table).order\_by(table.c.id, table.c.name)
```
Calling this method multiple times is equivalent to calling it oncewith all the clauses concatenated. All existing ORDER BY criteria maybe cancelled by passing `None` by itself. New ORDER BY criteria maythen be added by invoking `\_orm.Query.order\_by()` again, e.g.:


```
# will erase all ORDER BY and ORDER BY new\_col alonestmt = stmt.order\_by(None).order\_by(new\_col)
```
Parameters**\*clauses** – a series of `\_expression.ColumnElement`constructswhich will be used to generate an ORDER BY clause.

See also

tutorial\_order\_by - in the unified\_tutorial

tutorial\_order\_by\_label - in the unified\_tutorial

outerjoin(*target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *full: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.outerjoin "Permalink to this definition")Create a left outer join.

Parameters are the same as that of `\_expression.Select.join()`.

Changed in version 1.4: `\_expression.Select.outerjoin()` nowcreates a `\_sql.Join` object between a`\_sql.FromClause` source that is within the FROM clause ofthe existing SELECT, and a given target `\_sql.FromClause`,and then adds this `\_sql.Join` to the FROM clause of thenewly generated SELECT statement. This is completely reworkedfrom the behavior in 1.3, which would instead create a subquery ofthe entire`\_expression.Select` and then join that subquery to thetarget.

This is a **backwards incompatible change** as the previous behaviorwas mostly useless, producing an unnamed subquery rejected bymost databases in any case. The new behavior is modeled afterthat of the very successful `\_orm.Query.join()` method in theORM, in order to support the functionality of `\_orm.Query`being available by using a `\_sql.Select` object with an`\_orm.Session`.

See the notes for this change at change\_select\_join.

See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join()`

outerjoin\_from(*from\_: \_FromClauseArgument*, *target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *full: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.outerjoin_from "Permalink to this definition")Create a SQL LEFT OUTER JOIN against this`\_expression.Select` object’s criterion and apply generatively,returning the newly resulting `\_expression.Select`.

Usage is the same as that of `\_selectable.Select.join\_from()`.

params(*\_ClauseElement\_\_optionaldict: Optional[Mapping[str, Any]] = None*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.params "Permalink to this definition")Return a copy with `\_expression.bindparam()` elementsreplaced.

Returns a copy of this ClauseElement with`\_expression.bindparam()`elements replaced with values taken from the given dictionary:


```
>>> clause = column('x') + bindparam('foo')>>> print(clause.compile().params){'foo':None}>>> print(clause.params({'foo':7}).compile().params){'foo':7}
```
prefix\_with(*\*prefixes: \_TextCoercedExpressionArgument[Any]*, *dialect: str = '\*'*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.prefix_with "Permalink to this definition")Add one or more expressions following the statement keyword, i.e.SELECT, INSERT, UPDATE, or DELETE. Generative.

This is used to support backend-specific prefix keywords such as thoseprovided by MySQL.

E.g.:


```
stmt = table.insert().prefix\_with("LOW\_PRIORITY", dialect="mysql")# MySQL 5.7 optimizer hintsstmt = select(table).prefix\_with(    "/\*+ BKA(t1) \*/", dialect="mysql")
```
Multiple prefixes can be specified by multiple callsto `\_expression.HasPrefixes.prefix\_with()`.

Parameters* **\*prefixes** – textual or `\_expression.ClauseElement`construct whichwill be rendered following the INSERT, UPDATE, or DELETEkeyword.
* **dialect** – optional string dialect name which willlimit rendering of this prefix to only that dialect.
reduce\_columns(*only\_synonyms: bool = True*) → [Select](#llama_index.vector_stores.PGVectorStore.Select "sqlalchemy.sql.selectable.Select")[](#llama_index.vector_stores.LanternVectorStore.Select.reduce_columns "Permalink to this definition")Return a new `\_expression.select()` construct with redundantlynamed, equivalently-valued columns removed from the columns clause.

“Redundant” here means two columns where one refers to theother either based on foreign key, or via a simple equalitycomparison in the WHERE clause of the statement. The primary purposeof this method is to automatically construct a select statementwith all uniquely-named columns, without the need to usetable-qualified labels as`\_expression.Select.set\_label\_style()`does.

When columns are omitted based on foreign key, the referred-tocolumn is the one that’s kept. When columns are omitted based onWHERE equivalence, the first column in the columns clause is theone that’s kept.

Parameters**only\_synonyms** – when True, limit the removal of columnsto those which have the same name as the equivalent. Otherwise,all columns that are equivalent to another are removed.

replace\_selectable(*old: FromClause*, *alias: Alias*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.replace_selectable "Permalink to this definition")Replace all occurrences of `\_expression.FromClause`‘old’ with the given `\_expression.Alias`object, returning a copy of this `\_expression.FromClause`.

Deprecated since version 1.4: The `Selectable.replace\_selectable()` method is deprecated, and will be removed in a future release. Similar functionality is available via the sqlalchemy.sql.visitors module.

scalar\_subquery() → ScalarSelect[Any][](#llama_index.vector_stores.LanternVectorStore.Select.scalar_subquery "Permalink to this definition")Return a ‘scalar’ representation of this selectable, which can beused as a column expression.

The returned object is an instance of `\_sql.ScalarSelect`.

Typically, a select statement which has only one column in its columnsclause is eligible to be used as a scalar expression. The scalarsubquery can then be used in the WHERE clause or columns clause ofan enclosing SELECT.

Note that the scalar subquery differentiates from the FROM-levelsubquery that can be produced using the`\_expression.SelectBase.subquery()`method.

See also

tutorial\_scalar\_subquery - in the 2.0 tutorial

select(*\*arg: Any*, *\*\*kw: Any*) → [Select](#llama_index.vector_stores.PGVectorStore.Select "sqlalchemy.sql.selectable.Select")[](#llama_index.vector_stores.LanternVectorStore.Select.select "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.select()` method is deprecated and will be removed in a future release; this method implicitly creates a subquery that should be explicit. Please call `\_expression.SelectBase.subquery()` first in order to create a subquery, which then can be selected.

select\_from(*\*froms: \_FromClauseArgument*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.select_from "Permalink to this definition")Return a new `\_expression.select()` construct with thegiven FROM expression(s)merged into its list of FROM objects.

E.g.:


```
table1 = table('t1', column('a'))table2 = table('t2', column('b'))s = select(table1.c.a).\    select\_from(        table1.join(table2, table1.c.a==table2.c.b)    )
```
The “from” list is a unique set on the identity of each element,so adding an already present `\_schema.Table`or other selectablewill have no effect. Passing a `\_expression.Join` that refersto an already present `\_schema.Table`or other selectable will havethe effect of concealing the presence of that selectable asan individual element in the rendered FROM list, insteadrendering it into a JOIN clause.

While the typical purpose of `\_expression.Select.select\_from()`is toreplace the default, derived FROM clause with a join, it canalso be called with individual table elements, multiple timesif desired, in the case that the FROM clause cannot be fullyderived from the columns clause:


```
select(func.count('\*')).select\_from(table1)
```
selected\_columns[](#llama_index.vector_stores.LanternVectorStore.Select.selected_columns "Permalink to this definition")A `\_expression.ColumnCollection`representing the columns thatthis SELECT statement or similar construct returns in its result set,not including `\_sql.TextClause` constructs.

This collection differs from the `\_expression.FromClause.columns`collection of a `\_expression.FromClause` in that the columnswithin this collection cannot be directly nested inside another SELECTstatement; a subquery must be applied first which provides for thenecessary parenthesization required by SQL.

For a `\_expression.select()` construct, the collection here isexactly what would be rendered inside the “SELECT” statement, and the`\_expression.ColumnElement` objects are directly present as theywere given, e.g.:


```
col1 = column('q', Integer)col2 = column('p', Integer)stmt = select(col1, col2)
```
Above, `stmt.selected\_columns` would be a collection that containsthe `col1` and `col2` objects directly. For a statement that isagainst a `\_schema.Table` or other`\_expression.FromClause`, the collection will use the`\_expression.ColumnElement` objects that are in the`\_expression.FromClause.c` collection of the from element.

A use case for the `\_sql.Select.selected\_columns` collection isto allow the existing columns to be referenced when adding additionalcriteria, e.g.:


```
def filter\_on\_id(my\_select, id):    return my\_select.where(my\_select.selected\_columns['id'] == id)stmt = select(MyModel)# adds "WHERE id=:param" to the statementstmt = filter\_on\_id(stmt, 42)
```
Note

The `\_sql.Select.selected\_columns` collection does notinclude expressions established in the columns clause using the`\_sql.text()` construct; these are silently omitted from thecollection. To use plain textual column expressions inside of a`\_sql.Select` construct, use the `\_sql.literal\_column()`construct.

New in version 1.4.

self\_group(*against: Optional[OperatorType] = None*) → Union[SelectStatementGrouping, Self][](#llama_index.vector_stores.LanternVectorStore.Select.self_group "Permalink to this definition")Apply a ‘grouping’ to this `\_expression.ClauseElement`.

This method is overridden by subclasses to return a “grouping”construct, i.e. parenthesis. In particular it’s used by “binary”expressions to provide a grouping around themselves when placed into alarger expression, as well as by `\_expression.select()`constructs when placed into the FROM clause of another`\_expression.select()`. (Note that subqueries should benormally created using the `\_expression.Select.alias()` method,as manyplatforms require nested SELECT statements to be named).

As expressions are composed together, the application of[`self\_group()`](#llama_index.vector_stores.LanternVectorStore.Select.self_group "llama_index.vector_stores.LanternVectorStore.Select.self_group") is automatic - end-user code should neverneed to use this method directly. Note that SQLAlchemy’sclause constructs take operator precedence into account -so parenthesis might not be needed, for example, inan expression like `x OR (y AND z)` - AND takes precedenceover OR.

The base [`self\_group()`](#llama_index.vector_stores.LanternVectorStore.Select.self_group "llama_index.vector_stores.LanternVectorStore.Select.self_group") method of`\_expression.ClauseElement`just returns self.

set\_label\_style(*style: SelectLabelStyle*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.set_label_style "Permalink to this definition")Return a new selectable with the specified label style.

There are three “label styles” available,`\_sql.SelectLabelStyle.LABEL\_STYLE\_DISAMBIGUATE\_ONLY`,`\_sql.SelectLabelStyle.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`, and`\_sql.SelectLabelStyle.LABEL\_STYLE\_NONE`. The default style is`\_sql.SelectLabelStyle.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`.

In modern SQLAlchemy, there is not generally a need to change thelabeling style, as per-expression labels are more effectively used bymaking use of the `\_sql.ColumnElement.label()` method. In pastversions, `\_sql.LABEL\_STYLE\_TABLENAME\_PLUS\_COL` was used todisambiguate same-named columns from different tables, aliases, orsubqueries; the newer `\_sql.LABEL\_STYLE\_DISAMBIGUATE\_ONLY` nowapplies labels only to names that conflict with an existing name sothat the impact of this labeling is minimal.

The rationale for disambiguation is mostly so that all columnexpressions are available from a given `\_sql.FromClause.c`collection when a subquery is created.

New in version 1.4: - the`\_sql.GenerativeSelect.set\_label\_style()` method replaces theprevious combination of `.apply\_labels()`, `.with\_labels()` and`use\_labels=True` methods and/or parameters.

See also

`\_sql.LABEL\_STYLE\_DISAMBIGUATE\_ONLY`

`\_sql.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`

`\_sql.LABEL\_STYLE\_NONE`

`\_sql.LABEL\_STYLE\_DEFAULT`

slice(*start: int*, *stop: int*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.slice "Permalink to this definition")Apply LIMIT / OFFSET to this statement based on a slice.

The start and stop indices behave like the argument to Python’sbuilt-in `range()` function. This method provides analternative to using `LIMIT`/`OFFSET` to get a slice of thequery.

For example,


```
stmt = select(User).order\_by(User).id.slice(1, 3)
```
renders as


```
SELECT users.id AS users\_id, users.name AS users\_nameFROM users ORDER BY users.idLIMIT ? OFFSET ?(2, 1)
```
Note

The `\_sql.GenerativeSelect.slice()` method will replaceany clause applied with `\_sql.GenerativeSelect.fetch()`.

New in version 1.4: Added the `\_sql.GenerativeSelect.slice()`method generalized from the ORM.

See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.offset()`

`\_sql.GenerativeSelect.fetch()`

subquery(*name: Optional[str] = None*) → Subquery[](#llama_index.vector_stores.LanternVectorStore.Select.subquery "Permalink to this definition")Return a subquery of this `\_expression.SelectBase`.

A subquery is from a SQL perspective a parenthesized, namedconstruct that can be placed in the FROM clause of anotherSELECT statement.

Given a SELECT statement such as:


```
stmt = select(table.c.id, table.c.name)
```
The above statement might look like:


```
SELECT table.id, table.name FROM table
```
The subquery form by itself renders the same way, however whenembedded into the FROM clause of another SELECT statement, it becomesa named sub-element:


```
subq = stmt.subquery()new\_stmt = select(subq)
```
The above renders as:


```
SELECT anon\_1.id, anon\_1.nameFROM (SELECT table.id, table.name FROM table) AS anon\_1
```
Historically, `\_expression.SelectBase.subquery()`is equivalent to callingthe `\_expression.FromClause.alias()`method on a FROM object; however,as a `\_expression.SelectBase`object is not directly FROM object,the `\_expression.SelectBase.subquery()`method provides clearer semantics.

New in version 1.4.

suffix\_with(*\*suffixes: \_TextCoercedExpressionArgument[Any]*, *dialect: str = '\*'*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.suffix_with "Permalink to this definition")Add one or more expressions following the statement as a whole.

This is used to support backend-specific suffix keywords oncertain constructs.

E.g.:


```
stmt = select(col1, col2).cte().suffix\_with(    "cycle empno set y\_cycle to 1 default 0", dialect="oracle")
```
Multiple suffixes can be specified by multiple callsto `\_expression.HasSuffixes.suffix\_with()`.

Parameters* **\*suffixes** – textual or `\_expression.ClauseElement`construct whichwill be rendered following the target clause.
* **dialect** – Optional string dialect name which willlimit rendering of this suffix to only that dialect.
union(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.union "Permalink to this definition")Return a SQL `UNION` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
union\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.LanternVectorStore.Select.union_all "Permalink to this definition")Return a SQL `UNION ALL` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
unique\_params(*\_ClauseElement\_\_optionaldict: Optional[Dict[str, Any]] = None*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.unique_params "Permalink to this definition")Return a copy with `\_expression.bindparam()` elementsreplaced.

Same functionality as `\_expression.ClauseElement.params()`,except adds unique=Trueto affected bind parameters so that multiple statements can beused.

where(*\*whereclause: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.where "Permalink to this definition")Return a new `\_expression.select()` construct withthe given expression added toits WHERE clause, joined to the existing clause via AND, if any.

*property* whereclause*: Optional[ColumnElement[Any]]*[](#llama_index.vector_stores.LanternVectorStore.Select.whereclause "Permalink to this definition")Return the completed WHERE clause for this`\_expression.Select` statement.

This assembles the current collection of WHERE criteriainto a single `\_expression.BooleanClauseList` construct.

New in version 1.4.

with\_for\_update(*\**, *nowait: bool = False*, *read: bool = False*, *of: Optional[\_ForUpdateOfArgument] = None*, *skip\_locked: bool = False*, *key\_share: bool = False*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.with_for_update "Permalink to this definition")Specify a `FOR UPDATE` clause for this`\_expression.GenerativeSelect`.

E.g.:


```
stmt = select(table).with\_for\_update(nowait=True)
```
On a database like PostgreSQL or Oracle, the above would render astatement like:


```
SELECT table.a, table.b FROM table FOR UPDATE NOWAIT
```
on other backends, the `nowait` option is ignored and insteadwould produce:


```
SELECT table.a, table.b FROM table FOR UPDATE
```
When called with no arguments, the statement will render withthe suffix `FOR UPDATE`. Additional arguments can then beprovided which allow for common database-specificvariants.

Parameters* **nowait** – boolean; will render `FOR UPDATE NOWAIT` on Oracleand PostgreSQL dialects.
* **read** – boolean; will render `LOCK IN SHARE MODE` on MySQL,`FOR SHARE` on PostgreSQL. On PostgreSQL, when combined with`nowait`, will render `FOR SHARE NOWAIT`.
* **of** – SQL expression or list of SQL expression elements,(typically `\_schema.Column` objects or a compatible expression,for some backends may also be a table expression) which will renderinto a `FOR UPDATE OF` clause; supported by PostgreSQL, Oracle, someMySQL versions and possibly others. May render as a table or as acolumn depending on backend.
* **skip\_locked** – boolean, will render `FOR UPDATE SKIP LOCKED`on Oracle and PostgreSQL dialects or `FOR SHARE SKIP LOCKED` if`read=True` is also specified.
* **key\_share** – boolean, will render `FOR NO KEY UPDATE`,or if combined with `read=True` will render `FOR KEY SHARE`,on the PostgreSQL dialect.
with\_hint(*selectable: \_FromClauseArgument*, *text: str*, *dialect\_name: str = '\*'*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.with_hint "Permalink to this definition")Add an indexing or other executional context hint for the givenselectable to this `\_expression.Select` or other selectableobject.

The text of the hint is rendered in the appropriatelocation for the database backend in use, relativeto the given `\_schema.Table` or `\_expression.Alias`passed as the`selectable` argument. The dialect implementationtypically uses Python string substitution syntaxwith the token `%(name)s` to render the name ofthe table or alias. E.g. when using Oracle, thefollowing:


```
select(mytable).\    with\_hint(mytable, "index(%(name)s ix\_mytable)")
```
Would render SQL as:


```
select /\*+ index(mytable ix\_mytable) \*/ ... from mytable
```
The `dialect\_name` option will limit the rendering of a particularhint to a particular backend. Such as, to add hints for both Oracleand Sybase simultaneously:


```
select(mytable).\    with\_hint(mytable, "index(%(name)s ix\_mytable)", 'oracle').\    with\_hint(mytable, "WITH INDEX ix\_mytable", 'mssql')
```
See also

`\_expression.Select.with\_statement\_hint()`

with\_only\_columns(*\*entities: \_ColumnsClauseArgument[Any]*, *maintain\_column\_froms: bool = False*, *\*\*\_Select\_\_kw: Any*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.LanternVectorStore.Select.with_only_columns "Permalink to this definition")Return a new `\_expression.select()` construct with its columnsclause replaced with the given entities.

By default, this method is exactly equivalent to as if the original`\_expression.select()` had been called with the given entities.E.g. a statement:


```
s = select(table1.c.a, table1.c.b)s = s.with\_only\_columns(table1.c.b)
```
should be exactly equivalent to:


```
s = select(table1.c.b)
```
In this mode of operation, `\_sql.Select.with\_only\_columns()`will also dynamically alter the FROM clause of thestatement if it is not explicitly stated.To maintain the existing set of FROMs including those implied by thecurrent columns clause, add the[:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id31)parameter:


```
s = select(table1.c.a, table2.c.b)s = s.with\_only\_columns(table1.c.a, maintain\_column\_froms=True)
```
The above parameter performs a transfer of the effective FROMsin the columns collection to the `\_sql.Select.select\_from()`method, as though the following were invoked:


```
s = select(table1.c.a, table2.c.b)s = s.select\_from(table1, table2).with\_only\_columns(table1.c.a)
```
The [:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id33)parameter makes use of the `\_sql.Select.columns\_clause\_froms`collection and performs an operation equivalent to the following:


```
s = select(table1.c.a, table2.c.b)s = s.select\_from(\*s.columns\_clause\_froms).with\_only\_columns(table1.c.a)
```
Parameters* **\*entities** – column expressions to be used.
* **maintain\_column\_froms** – boolean parameter that will ensure theFROM list implied from the current columns clause will be transferredto the `\_sql.Select.select\_from()` method first.

New in version 1.4.23.
with\_statement\_hint(*text: str*, *dialect\_name: str = '\*'*) → Self[](#llama_index.vector_stores.LanternVectorStore.Select.with_statement_hint "Permalink to this definition")Add a statement hint to this `\_expression.Select` orother selectable object.

This method is similar to `\_expression.Select.with\_hint()`except thatit does not require an individual table, and instead applies to thestatement as a whole.

Hints here are specific to the backend database and may includedirectives such as isolation levels, file directives, fetch directives,etc.

See also

`\_expression.Select.with\_hint()`

`\_expression.Select.prefix\_with()` - generic SELECT prefixingwhich also can suit some database-specific HINT syntaxes such asMySQL optimizer hints

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.LanternVectorStore.add "Permalink to this definition")Add nodes to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.LanternVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.LanternVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.LanternVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*classmethod* class\_name() → str[](#llama_index.vector_stores.LanternVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*async* close() → None[](#llama_index.vector_stores.LanternVectorStore.close "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.LanternVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.LanternVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.LanternVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.LanternVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.LanternVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.LanternVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*host: Optional[str] = None*, *port: Optional[str] = None*, *database: Optional[str] = None*, *user: Optional[str] = None*, *password: Optional[str] = None*, *table\_name: str = 'llamaindex'*, *schema\_name: str = 'public'*, *connection\_string: Optional[str] = None*, *async\_connection\_string: Optional[str] = None*, *hybrid\_search: bool = False*, *text\_search\_config: str = 'english'*, *embed\_dim: int = 1536*, *m: int = 16*, *ef\_construction: int = 128*, *ef: int = 64*, *cache\_ok: bool = False*, *perform\_setup: bool = True*, *debug: bool = False*) → [LanternVectorStore](#llama_index.vector_stores.LanternVectorStore "llama_index.vector_stores.lantern.LanternVectorStore")[](#llama_index.vector_stores.LanternVectorStore.from_params "Permalink to this definition")Return connection string from database parameters.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.LanternVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.LanternVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.LanternVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.LanternVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.LanternVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.LanternVectorStore.query "Permalink to this definition")Query vector store.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.LanternVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.LanternVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.LanternVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.LanternVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.LanternVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.LanternVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.LanternVectorStore.client "Permalink to this definition")Get client.

*pydantic model* llama\_index.vector\_stores.MetadataFilters[](#llama_index.vector_stores.MetadataFilters "Permalink to this definition")Metadata filters for vector stores.

Currently only supports exact match filters.TODO: support more advanced expressions.

Show JSON schema
```
{ "title": "MetadataFilters", "description": "Metadata filters for vector stores.\n\nCurrently only supports exact match filters.\nTODO: support more advanced expressions.", "type": "object", "properties": { "filters": { "title": "Filters", "type": "array", "items": { "$ref": "#/definitions/ExactMatchFilter" } } }, "required": [ "filters" ], "definitions": { "ExactMatchFilter": { "title": "ExactMatchFilter", "description": "Exact match metadata filter for vector stores.\n\nValue uses Strict\* types, as int, float and str are compatible types and were all\nconverted to string before.\n\nSee: https://docs.pydantic.dev/latest/usage/types/#strict-types", "type": "object", "properties": { "key": { "title": "Key", "type": "string" }, "value": { "title": "Value", "anyOf": [ { "type": "integer" }, { "type": "number" }, { "type": "string" } ] } }, "required": [ "key", "value" ] } }}
```


Fields* [`filters (List[llama\_index.vector\_stores.types.ExactMatchFilter])`](../query/retrievers/vector_store.html#llama_index.vector_stores.types.MetadataFilters.filters "llama_index.vector_stores.types.MetadataFilters.filters")
*field* filters*: List[[ExactMatchFilter](../query/retrievers/vector_store.html#llama_index.vector_stores.types.ExactMatchFilter "llama_index.vector_stores.types.ExactMatchFilter")]* *[Required]*[](#llama_index.vector_stores.MetadataFilters.filters "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.MetadataFilters.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.MetadataFilters.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.MetadataFilters.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*filter\_dict: Dict*) → [MetadataFilters](../query/retrievers/vector_store.html#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")[](#llama_index.vector_stores.MetadataFilters.from_dict "Permalink to this definition")Create MetadataFilters from json.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.MetadataFilters.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.MetadataFilters.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.MetadataFilters.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.MetadataFilters.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.MetadataFilters.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.MetadataFilters.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.MetadataFilters.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.MetadataFilters.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.MetadataFilters.validate "Permalink to this definition")*class* llama\_index.vector\_stores.MetalVectorStore(*api\_key: str*, *client\_id: str*, *index\_id: str*)[](#llama_index.vector_stores.MetalVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.MetalVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MetalVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MetalVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.MetalVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.MetalVectorStore.client "Permalink to this definition")Return Metal client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MetalVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MetalVectorStore.query "Permalink to this definition")Query vector store.

*class* llama\_index.vector\_stores.MilvusVectorStore(*uri: str = 'http://localhost:19530'*, *token: str = ''*, *collection\_name: str = 'llamalection'*, *dim: Optional[int] = None*, *embedding\_field: str = 'embedding'*, *doc\_id\_field: str = 'doc\_id'*, *similarity\_metric: str = 'IP'*, *consistency\_level: str = 'Strong'*, *overwrite: bool = False*, *text\_key: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.MilvusVectorStore "Permalink to this definition")The Milvus Vector Store.

In this vector store we store the text, its embedding anda its metadata in a Milvus collection. This implementationallows the use of an already existing collection.It also supports creating a new one if the collection doesn’texist or if overwrite is set to True.

Parameters* **uri** (*str**,* *optional*) – The URI to connect to, comes in the form of“<http://address:port>”.
* **token** (*str**,* *optional*) – The token for log in. Empty if not using rbac, ifusing rbac it will most likely be “username:password”.
* **collection\_name** (*str**,* *optional*) – The name of the collection where data will bestored. Defaults to “llamalection”.
* **dim** (*int**,* *optional*) – The dimension of the embedding vectors for the collection.Required if creating a new collection.
* **embedding\_field** (*str**,* *optional*) – The name of the embedding field for thecollection, defaults to DEFAULT\_EMBEDDING\_KEY.
* **doc\_id\_field** (*str**,* *optional*) – The name of the doc\_id field for the collection,defaults to DEFAULT\_DOC\_ID\_KEY.
* **similarity\_metric** (*str**,* *optional*) – The similarity metric to use,currently supports IP and L2.
* **consistency\_level** (*str**,* *optional*) – Which consistency level to use for a newlycreated collection. Defaults to “Session”.
* **overwrite** (*bool**,* *optional*) – Whether to overwrite existing collection with samename. Defaults to False.
* **text\_key** (*str**,* *optional*) – What key text is stored in in the passed collection.Used when bringing your own collection. Defaults to None.
Raises* **ImportError** – Unable to import pymilvus.
* **MilvusException** – Error communicating with Milvus, more can be found in logging under Debug.
ReturnsVectorstore that supports add, delete, and query.

Return typeMilvusVectorstore

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.MilvusVectorStore.add "Permalink to this definition")Add the embeddings and their nodes into Milvus.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddingsto insert.

Raises**MilvusException** – Failed to insert data.

ReturnsList of ids inserted.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MilvusVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MilvusVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.MilvusVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.MilvusVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MilvusVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

Raises**MilvusException** – Failed to delete the doc.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MilvusVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query\_embedding** (*List**[**float**]*) – query embedding
* **similarity\_top\_k** (*int*) – top k most similar nodes
* **doc\_ids** (*Optional**[**List**[**str**]**]*) – list of doc\_ids to filter by
* **node\_ids** (*Optional**[**List**[**str**]**]*) – list of node\_ids to filter by
* **output\_fields** (*Optional**[**List**[**str**]**]*) – list of fields to return
* **embedding\_field** (*Optional**[**str**]*) – name of embedding field
*class* llama\_index.vector\_stores.MyScaleVectorStore(*myscale\_client: Optional[Any] = None*, *table: str = 'llama\_index'*, *database: str = 'default'*, *index\_type: str = 'MSTG'*, *metric: str = 'cosine'*, *batch\_size: int = 32*, *index\_params: Optional[dict] = None*, *search\_params: Optional[dict] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.MyScaleVectorStore "Permalink to this definition")MyScale Vector Store.

In this vector store, embeddings and docs are stored within an existingMyScale cluster.

During query time, the index uses MyScale to query for the topk most similar nodes.

Parameters* **myscale\_client** (*httpclient*) – clickhouse-connect httpclient ofan existing MyScale cluster.
* **table** (*str**,* *optional*) – The name of the MyScale tablewhere data will be stored. Defaults to “llama\_index”.
* **database** (*str**,* *optional*) – The name of the MyScale databasewhere data will be stored. Defaults to “default”.
* **index\_type** (*str**,* *optional*) – The type of the MyScale vector index.Defaults to “IVFFLAT”.
* **metric** (*str**,* *optional*) – The metric type of the MyScale vector index.Defaults to “cosine”.
* **batch\_size** (*int**,* *optional*) – the size of documents to insert. Defaults to 32.
* **index\_params** (*dict**,* *optional*) – The index parameters for MyScale.Defaults to None.
* **search\_params** (*dict**,* *optional*) – The search parameters for a MyScale query.Defaults to None.
* **service\_context** ([*ServiceContext*](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*,* *optional*) – Vector store service context.Defaults to None
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.MyScaleVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MyScaleVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MyScaleVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.MyScaleVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.MyScaleVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.MyScaleVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

drop() → None[](#llama_index.vector_stores.MyScaleVectorStore.drop "Permalink to this definition")Drop MyScale Index and table.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.MyScaleVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query

*class* llama\_index.vector\_stores.Neo4jVectorStore(*username: str*, *password: str*, *url: str*, *embedding\_dimension: int*, *database: str = 'neo4j'*, *index\_name: str = 'vector'*, *node\_label: str = 'Chunk'*, *embedding\_node\_property: str = 'embedding'*, *text\_node\_property: str = 'text'*, *distance\_strategy: str = 'cosine'*, *retrieval\_query: str = ''*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.Neo4jVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.Neo4jVectorStore.add "Permalink to this definition")Add nodes with embedding to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.Neo4jVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.Neo4jVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.Neo4jVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.Neo4jVectorStore.client "Permalink to this definition")Get client.

create\_new\_index() → None[](#llama_index.vector_stores.Neo4jVectorStore.create_new_index "Permalink to this definition")This method constructs a Cypher query and executes itto create a new vector index in Neo4j.

database\_query(*query: str*, *params: Optional[dict] = None*) → List[Dict[str, Any]][](#llama_index.vector_stores.Neo4jVectorStore.database_query "Permalink to this definition")This method sends a Cypher query to the connected Neo4j databaseand returns the results as a list of dictionaries.

Parameters* **query** (*str*) – The Cypher query to execute.
* **params** (*dict**,* *optional*) – Dictionary of query parameters. Defaults to {}.
ReturnsList of dictionaries containing the query results.

Return typeList[Dict[str, Any]]

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.Neo4jVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.Neo4jVectorStore.query "Permalink to this definition")Query vector store.

retrieve\_existing\_index() → bool[](#llama_index.vector_stores.Neo4jVectorStore.retrieve_existing_index "Permalink to this definition")Check if the vector index exists in the Neo4j databaseand returns its embedding dimension.

This method queries the Neo4j database for existing indexesand attempts to retrieve the dimension of the vector indexwith the specified name. If the index exists, its dimension is returned.If the index doesn’t exist, None is returned.

ReturnsThe embedding dimension of the existing index if found.

Return typeint or None

*class* llama\_index.vector\_stores.OpensearchVectorClient(*endpoint: str*, *index: str*, *dim: int*, *embedding\_field: str = 'embedding'*, *text\_field: str = 'content'*, *method: Optional[dict] = None*, *max\_chunk\_bytes: int = 1048576*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.OpensearchVectorClient "Permalink to this definition")Object encapsulating an Opensearch index that has vector search enabled.

If the index does not yet exist, it is created during init.Therefore, the underlying index is assumed to either:1) not exist yet or 2) be created due to previous usage of this class.

Parameters* **endpoint** (*str*) – URL (http/https) of elasticsearch endpoint
* **index** (*str*) – Name of the elasticsearch index
* **dim** (*int*) – Dimension of the vector
* **embedding\_field** (*str*) – Name of the field in the index to storeembedding array in.
* **text\_field** (*str*) – Name of the field to grab text from
* **method** (*Optional**[**dict**]*) – Opensearch “method” JSON obj for configuringthe KNN index.This includes engine, metric, and other config params. Defaults to:{“name”: “hnsw”, “space\_type”: “l2”, “engine”: “faiss”,“parameters”: {“ef\_construction”: 256, “m”: 48}}
* **\*\*kwargs** – Optional arguments passed to the OpenSearch client from opensearch-py.
delete\_doc\_id(*doc\_id: str*) → None[](#llama_index.vector_stores.OpensearchVectorClient.delete_doc_id "Permalink to this definition")Delete a document.

Parameters**doc\_id** (*str*) – document id

index\_results(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.OpensearchVectorClient.index_results "Permalink to this definition")Store results in the index.

knn(*query\_embedding: List[float]*, *k: int*, *filters: Optional[[MetadataFilters](../query/retrievers/vector_store.html#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")] = None*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.OpensearchVectorClient.knn "Permalink to this definition")Do knn search.

If there are no filters do approx-knn search.If there are (pre)-filters, do an exhaustive exact knn search using ‘painless


> scripting’.
> 
> 

Note that approximate knn search does not support pre-filtering.

Parameters* **query\_embedding** – Vector embedding to query.
* **k** – Maximum number of results.
* **filters** – Optional filters to apply before the search.Supports filter-context queries documented at<https://opensearch.org/docs/latest/query-dsl/query-filter-context/>
ReturnsUp to k docs closest to query\_embedding

*class* llama\_index.vector\_stores.OpensearchVectorStore(*client: [OpensearchVectorClient](#llama_index.vector_stores.OpensearchVectorClient "llama_index.vector_stores.opensearch.OpensearchVectorClient")*)[](#llama_index.vector_stores.OpensearchVectorStore "Permalink to this definition")Elasticsearch/Opensearch vector store.

Parameters**client** ([*OpensearchVectorClient*](#llama_index.vector_stores.OpensearchVectorClient "llama_index.vector_stores.OpensearchVectorClient")) – Vector index client to usefor data insertion/querying.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.OpensearchVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.OpensearchVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.OpensearchVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.OpensearchVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.OpensearchVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.OpensearchVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.OpensearchVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query\_embedding** (*List**[**float**]*) – query embedding

*pydantic model* llama\_index.vector\_stores.PGVectorStore[](#llama_index.vector_stores.PGVectorStore "Permalink to this definition")Show JSON schema
```
{ "title": "PGVectorStore", "description": "Abstract vector store protocol.", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "connection\_string": { "title": "Connection String", "type": "string" }, "async\_connection\_string": { "title": "Async Connection String", "type": "string" }, "table\_name": { "title": "Table Name", "type": "string" }, "schema\_name": { "title": "Schema Name", "type": "string" }, "embed\_dim": { "title": "Embed Dim", "type": "integer" }, "hybrid\_search": { "title": "Hybrid Search", "type": "boolean" }, "text\_search\_config": { "title": "Text Search Config", "type": "string" }, "cache\_ok": { "title": "Cache Ok", "type": "boolean" }, "perform\_setup": { "title": "Perform Setup", "type": "boolean" }, "debug": { "title": "Debug", "type": "boolean" }, "flat\_metadata": { "title": "Flat Metadata", "default": false, "type": "boolean" } }, "required": [ "connection\_string", "async\_connection\_string", "table\_name", "schema\_name", "embed\_dim", "hybrid\_search", "text\_search\_config", "cache\_ok", "perform\_setup", "debug" ]}
```


Fields* `async\_connection\_string (str)`
* `cache\_ok (bool)`
* `connection\_string (str)`
* `debug (bool)`
* `embed\_dim (int)`
* `hybrid\_search (bool)`
* `is\_embedding\_query (bool)`
* `perform\_setup (bool)`
* `schema\_name (str)`
* `stores\_text (bool)`
* `table\_name (str)`
* `text\_search\_config (str)`
*field* async\_connection\_string*: str* *[Required]*[](#llama_index.vector_stores.PGVectorStore.async_connection_string "Permalink to this definition")*field* cache\_ok*: bool* *[Required]*[](#llama_index.vector_stores.PGVectorStore.cache_ok "Permalink to this definition")*field* connection\_string*: str* *[Required]*[](#llama_index.vector_stores.PGVectorStore.connection_string "Permalink to this definition")*field* debug*: bool* *[Required]*[](#llama_index.vector_stores.PGVectorStore.debug "Permalink to this definition")*field* embed\_dim*: int* *[Required]*[](#llama_index.vector_stores.PGVectorStore.embed_dim "Permalink to this definition")*field* hybrid\_search*: bool* *[Required]*[](#llama_index.vector_stores.PGVectorStore.hybrid_search "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.PGVectorStore.is_embedding_query "Permalink to this definition")*field* perform\_setup*: bool* *[Required]*[](#llama_index.vector_stores.PGVectorStore.perform_setup "Permalink to this definition")*field* schema\_name*: str* *[Required]*[](#llama_index.vector_stores.PGVectorStore.schema_name "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.PGVectorStore.stores_text "Permalink to this definition")*field* table\_name*: str* *[Required]*[](#llama_index.vector_stores.PGVectorStore.table_name "Permalink to this definition")*field* text\_search\_config*: str* *[Required]*[](#llama_index.vector_stores.PGVectorStore.text_search_config "Permalink to this definition")*class* Select(*\*entities: \_ColumnsClauseArgument[Any]*)[](#llama_index.vector_stores.PGVectorStore.Select "Permalink to this definition")Represents a `SELECT` statement.

The `\_sql.Select` object is normally constructed using the`\_sql.select()` function. See that function for details.

See also

`\_sql.select()`

tutorial\_selecting\_data - in the 2.0 tutorial

add\_columns(*\*entities: \_ColumnsClauseArgument[Any]*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.PGVectorStore.Select.add_columns "Permalink to this definition")Return a new `\_expression.select()` construct withthe given entities appended to its columns clause.

E.g.:


```
my\_select = my\_select.add\_columns(table.c.new\_column)
```
The original expressions in the columns clause remain in place.To replace the original expressions with new ones, see the method`\_expression.Select.with\_only\_columns()`.

Parameters**\*entities** – column, table, or other entity expressions to beadded to the columns clause

See also

`\_expression.Select.with\_only\_columns()` - replaces existingexpressions rather than appending.

orm\_queryguide\_select\_multiple\_entities - ORM-centricexample

add\_cte(*\*ctes: CTE*, *nest\_here: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.add_cte "Permalink to this definition")Add one or more `\_sql.CTE` constructs to this statement.

This method will associate the given `\_sql.CTE` constructs withthe parent statement such that they will each be unconditionallyrendered in the WITH clause of the final statement, even if notreferenced elsewhere within the statement or any sub-selects.

The optional [:paramref:`.HasCTE.add\_cte.nest\_here`](#id35) parameter when setto True will have the effect that each given `\_sql.CTE` willrender in a WITH clause rendered directly along with this statement,rather than being moved to the top of the ultimate rendered statement,even if this statement is rendered as a subquery within a largerstatement.

This method has two general uses. One is to embed CTE statements thatserve some purpose without being referenced explicitly, such as the usecase of embedding a DML statement such as an INSERT or UPDATE as a CTEinline with a primary statement that may draw from its resultsindirectly. The other is to provide control over the exact placementof a particular series of CTE constructs that should remain rendereddirectly in terms of a particular statement that may be nested in alarger statement.

E.g.:


```
from sqlalchemy import table, column, selectt = table('t', column('c1'), column('c2'))ins = t.insert().values({"c1": "x", "c2": "y"}).cte()stmt = select(t).add\_cte(ins)
```
Would render:


```
WITH anon\_1 AS(INSERT INTO t (c1, c2) VALUES (:param\_1, :param\_2))SELECT t.c1, t.c2FROM t
```
Above, the “anon\_1” CTE is not referenced in the SELECTstatement, however still accomplishes the task of running an INSERTstatement.

Similarly in a DML-related context, using the PostgreSQL`\_postgresql.Insert` construct to generate an “upsert”:


```
from sqlalchemy import table, columnfrom sqlalchemy.dialects.postgresql import insertt = table("t", column("c1"), column("c2"))delete\_statement\_cte = (    t.delete().where(t.c.c1 < 1).cte("deletions"))insert\_stmt = insert(t).values({"c1": 1, "c2": 2})update\_statement = insert\_stmt.on\_conflict\_do\_update(    index\_elements=[t.c.c1],    set\_={        "c1": insert\_stmt.excluded.c1,        "c2": insert\_stmt.excluded.c2,    },).add\_cte(delete\_statement\_cte)print(update\_statement)
```
The above statement renders as:


```
WITH deletions AS(DELETE FROM t WHERE t.c1 < %(c1\_1)s)INSERT INTO t (c1, c2) VALUES (%(c1)s, %(c2)s)ON CONFLICT (c1) DO UPDATE SET c1 = excluded.c1, c2 = excluded.c2
```
New in version 1.4.21.

Parameters* **\*ctes** – zero or more `CTE` constructs.

Changed in version 2.0: Multiple CTE instances are accepted
* **nest\_here** – if True, the given CTE or CTEs will be renderedas though they specified the [:paramref:`.HasCTE.cte.nesting`](#id37) flagto `True` when they were added to this `HasCTE`.Assuming the given CTEs are not referenced in an outer-enclosingstatement as well, the CTEs given should render at the level ofthis statement when this flag is given.

New in version 2.0.

See also

[:paramref:`.HasCTE.cte.nesting`](#id39)
alias(*name: Optional[str] = None*, *flat: bool = False*) → Subquery[](#llama_index.vector_stores.PGVectorStore.Select.alias "Permalink to this definition")Return a named subquery against this`\_expression.SelectBase`.

For a `\_expression.SelectBase` (as opposed to a`\_expression.FromClause`),this returns a `Subquery` object which behaves mostly thesame as the `\_expression.Alias` object that is used with a`\_expression.FromClause`.

Changed in version 1.4: The `\_expression.SelectBase.alias()`method is nowa synonym for the `\_expression.SelectBase.subquery()` method.

as\_scalar() → ScalarSelect[Any][](#llama_index.vector_stores.PGVectorStore.Select.as_scalar "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.as\_scalar()` method is deprecated and will be removed in a future release. Please refer to `\_expression.SelectBase.scalar\_subquery()`.

*property* c*: ReadOnlyColumnCollection[str, KeyedColumnElement[Any]]*[](#llama_index.vector_stores.PGVectorStore.Select.c "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.c` and `\_expression.SelectBase.columns` attributes are deprecated and will be removed in a future release; these attributes implicitly create a subquery that should be explicit. Please call `\_expression.SelectBase.subquery()` first in order to create a subquery, which then contains this attribute. To access the columns that this SELECT object SELECTs from, use the `\_expression.SelectBase.selected\_columns` attribute.

column(*column: \_ColumnsClauseArgument[Any]*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.PGVectorStore.Select.column "Permalink to this definition")Return a new `\_expression.select()` construct withthe given column expression added to its columns clause.

Deprecated since version 1.4: The `\_expression.Select.column()` method is deprecated and will be removed in a future release. Please use `\_expression.Select.add\_columns()`

E.g.:


```
my\_select = my\_select.column(table.c.new\_column)
```
See the documentation for`\_expression.Select.with\_only\_columns()`for guidelines on adding /replacing the columns of a`\_expression.Select` object.

*property* column\_descriptions*: Any*[](#llama_index.vector_stores.PGVectorStore.Select.column_descriptions "Permalink to this definition")Return a plugin-enabled ‘column descriptions’ structurereferring to the columns which are SELECTed by this statement.

This attribute is generally useful when using the ORM, as anextended structure which includes information about mappedentities is returned. The section queryguide\_inspectioncontains more background.

For a Core-only statement, the structure returned by this accessoris derived from the same objects that are returned by the[`Select.selected\_columns`](#llama_index.vector_stores.LanternVectorStore.Select.selected_columns "llama_index.vector_stores.LanternVectorStore.Select.selected_columns") accessor, formatted as a list ofdictionaries which contain the keys `name`, `type` and `expr`,which indicate the column expressions to be selected:


```
>>> stmt = select(user\_table)>>> stmt.column\_descriptions[ { 'name': 'id', 'type': Integer(), 'expr': Column('id', Integer(), ...)}, { 'name': 'name', 'type': String(length=30), 'expr': Column('name', String(length=30), ...)}]
```
Changed in version 1.4.33: The [`Select.column\_descriptions`](#llama_index.vector_stores.LanternVectorStore.Select.column_descriptions "llama_index.vector_stores.LanternVectorStore.Select.column_descriptions")attribute returns a structure for a Core-only set of entities,not just ORM-only entities.

See also

`UpdateBase.entity\_description` - entity information foran `insert()`, `update()`, or `delete()`

queryguide\_inspection - ORM background

*property* columns\_clause\_froms*: List[FromClause]*[](#llama_index.vector_stores.PGVectorStore.Select.columns_clause_froms "Permalink to this definition")Return the set of `\_expression.FromClause` objects impliedby the columns clause of this SELECT statement.

New in version 1.4.23.

See also

`\_sql.Select.froms` - “final” FROM list taking the fullstatement into account

`\_sql.Select.with\_only\_columns()` - makes use of thiscollection to set up a new FROM list

compare(*other: ClauseElement*, *\*\*kw: Any*) → bool[](#llama_index.vector_stores.PGVectorStore.Select.compare "Permalink to this definition")Compare this `\_expression.ClauseElement` tothe given `\_expression.ClauseElement`.

Subclasses should override the default behavior, which is astraight identity comparison.

\*\*kw are arguments consumed by subclass `compare()` methods andmay be used to modify the criteria for comparison(see `\_expression.ColumnElement`).

compile(*bind: Optional[Union[Engine, Connection]] = None*, *dialect: Optional[Dialect] = None*, *\*\*kw: Any*) → Compiled[](#llama_index.vector_stores.PGVectorStore.Select.compile "Permalink to this definition")Compile this SQL expression.

The return value is a `Compiled` object.Calling `str()` or `unicode()` on the returned value will yield astring representation of the result. The`Compiled` object also can return adictionary of bind parameter names and valuesusing the `params` accessor.

Parameters* **bind** – An `Connection` or `Engine` whichcan provide a `Dialect` in order to generate a`Compiled` object. If the `bind` and`dialect` parameters are both omitted, a default SQL compileris used.
* **column\_keys** – Used for INSERT and UPDATE statements, a list ofcolumn names which should be present in the VALUES clause of thecompiled statement. If `None`, all columns from the target tableobject are rendered.
* **dialect** – A `Dialect` instance which can generatea `Compiled` object. This argument takes precedence overthe `bind` argument.
* **compile\_kwargs** – optional dictionary of additional parametersthat will be passed through to the compiler within all “visit”methods. This allows any custom flag to be passed through toa custom compilation construct, for example. It is also usedfor the case of passing the `literal\_binds` flag through:


```
from sqlalchemy.sql import table, column, selectt = table('t', column('x'))s = select(t).where(t.c.x == 5)print(s.compile(compile\_kwargs={"literal\_binds": True}))
```
See also

faq\_sql\_expression\_string

correlate(*\*fromclauses: Union[Literal[None, False], \_FromClauseArgument]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.correlate "Permalink to this definition")Return a new `\_expression.Select`which will correlate the given FROMclauses to that of an enclosing `\_expression.Select`.

Calling this method turns off the `\_expression.Select` object’sdefault behavior of “auto-correlation”. Normally, FROM elementswhich appear in a `\_expression.Select`that encloses this one viaits WHERE clause, ORDER BY, HAVING orcolumns clause will be omitted from this`\_expression.Select`object’s FROM clause.Setting an explicit correlation collection using the`\_expression.Select.correlate()`method provides a fixed list of FROM objectsthat can potentially take place in this process.

When `\_expression.Select.correlate()`is used to apply specific FROM clausesfor correlation, the FROM elements become candidates forcorrelation regardless of how deeply nested this`\_expression.Select`object is, relative to an enclosing `\_expression.Select`which refers tothe same FROM object. This is in contrast to the behavior of“auto-correlation” which only correlates to an immediate enclosing`\_expression.Select`.Multi-level correlation ensures that the linkbetween enclosed and enclosing `\_expression.Select`is always viaat least one WHERE/ORDER BY/HAVING/columns clause in order forcorrelation to take place.

If `None` is passed, the `\_expression.Select`object will correlatenone of its FROM entries, and all will render unconditionallyin the local FROM clause.

Parameters**\*fromclauses** – one or more `FromClause` or otherFROM-compatible construct such as an ORM mapped entity to become partof the correlate collection; alternatively pass a single value`None` to remove all existing correlations.

See also

`\_expression.Select.correlate\_except()`

tutorial\_scalar\_subquery

correlate\_except(*\*fromclauses: Union[Literal[None, False], \_FromClauseArgument]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.correlate_except "Permalink to this definition")Return a new `\_expression.Select`which will omit the given FROMclauses from the auto-correlation process.

Calling `\_expression.Select.correlate\_except()` turns off the`\_expression.Select` object’s default behavior of“auto-correlation” for the given FROM elements. An elementspecified here will unconditionally appear in the FROM list, whileall other FROM elements remain subject to normal auto-correlationbehaviors.

If `None` is passed, or no arguments are passed,the `\_expression.Select` object will correlate all of itsFROM entries.

Parameters**\*fromclauses** – a list of one or more`\_expression.FromClause`constructs, or other compatible constructs (i.e. ORM-mappedclasses) to become part of the correlate-exception collection.

See also

`\_expression.Select.correlate()`

tutorial\_scalar\_subquery

corresponding\_column(*column: KeyedColumnElement[Any]*, *require\_embedded: bool = False*) → Optional[KeyedColumnElement[Any]][](#llama_index.vector_stores.PGVectorStore.Select.corresponding_column "Permalink to this definition")Given a `\_expression.ColumnElement`, return the exported`\_expression.ColumnElement` object from the`\_expression.Selectable.exported\_columns`collection of this `\_expression.Selectable`which corresponds to thatoriginal `\_expression.ColumnElement` via a common ancestorcolumn.

Parameters* **column** – the target `\_expression.ColumnElement`to be matched.
* **require\_embedded** – only return corresponding columns forthe given `\_expression.ColumnElement`, if the given`\_expression.ColumnElement`is actually present within a sub-elementof this `\_expression.Selectable`.Normally the column will match ifit merely shares a common ancestor with one of the exportedcolumns of this `\_expression.Selectable`.
See also

`\_expression.Selectable.exported\_columns` - the`\_expression.ColumnCollection`that is used for the operation.

`\_expression.ColumnCollection.corresponding\_column()`- implementationmethod.

cte(*name: Optional[str] = None*, *recursive: bool = False*, *nesting: bool = False*) → CTE[](#llama_index.vector_stores.PGVectorStore.Select.cte "Permalink to this definition")Return a new `\_expression.CTE`,or Common Table Expression instance.

Common table expressions are a SQL standard whereby SELECTstatements can draw upon secondary statements specified alongwith the primary statement, using a clause called “WITH”.Special semantics regarding UNION can also be employed toallow “recursive” queries, where a SELECT statement can drawupon the set of rows that have previously been selected.

CTEs can also be applied to DML constructs UPDATE, INSERTand DELETE on some databases, both as a source of CTE rowswhen combined with RETURNING, as well as a consumer ofCTE rows.

SQLAlchemy detects `\_expression.CTE` objects, which are treatedsimilarly to `\_expression.Alias` objects, as special elementsto be delivered to the FROM clause of the statement as wellas to a WITH clause at the top of the statement.

For special prefixes such as PostgreSQL “MATERIALIZED” and“NOT MATERIALIZED”, the `\_expression.CTE.prefix\_with()`method may beused to establish these.

Changed in version 1.3.13: Added support for prefixes.In particular - MATERIALIZED and NOT MATERIALIZED.

Parameters* **name** – name given to the common table expression. Like`\_expression.FromClause.alias()`, the name can be left as`None` in which case an anonymous symbol will be used at querycompile time.
* **recursive** – if `True`, will render `WITH RECURSIVE`.A recursive common table expression is intended to be used inconjunction with UNION ALL in order to derive rowsfrom those already selected.
* **nesting** – if `True`, will render the CTE locally to thestatement in which it is referenced. For more complex scenarios,the `HasCTE.add\_cte()` method using the[:paramref:`.HasCTE.add\_cte.nest\_here`](#id41)parameter may also be used to more carefullycontrol the exact placement of a particular CTE.

New in version 1.4.24.

See also

`HasCTE.add\_cte()`
The following examples include two from PostgreSQL’s documentation at<https://www.postgresql.org/docs/current/static/queries-with.html>,as well as additional examples.

Example 1, non recursive:


```
from sqlalchemy import (Table, Column, String, Integer,                        MetaData, select, func)metadata = MetaData()orders = Table('orders', metadata,    Column('region', String),    Column('amount', Integer),    Column('product', String),    Column('quantity', Integer))regional\_sales = select(                    orders.c.region,                    func.sum(orders.c.amount).label('total\_sales')                ).group\_by(orders.c.region).cte("regional\_sales")top\_regions = select(regional\_sales.c.region).\        where(            regional\_sales.c.total\_sales >            select(                func.sum(regional\_sales.c.total\_sales) / 10            )        ).cte("top\_regions")statement = select(            orders.c.region,            orders.c.product,            func.sum(orders.c.quantity).label("product\_units"),            func.sum(orders.c.amount).label("product\_sales")    ).where(orders.c.region.in\_(        select(top\_regions.c.region)    )).group\_by(orders.c.region, orders.c.product)result = conn.execute(statement).fetchall()
```
Example 2, WITH RECURSIVE:


```
from sqlalchemy import (Table, Column, String, Integer,                        MetaData, select, func)metadata = MetaData()parts = Table('parts', metadata,    Column('part', String),    Column('sub\_part', String),    Column('quantity', Integer),)included\_parts = select(\    parts.c.sub\_part, parts.c.part, parts.c.quantity\    ).\    where(parts.c.part=='our part').\    cte(recursive=True)incl\_alias = included\_parts.alias()parts\_alias = parts.alias()included\_parts = included\_parts.union\_all(    select(        parts\_alias.c.sub\_part,        parts\_alias.c.part,        parts\_alias.c.quantity    ).\    where(parts\_alias.c.part==incl\_alias.c.sub\_part))statement = select(            included\_parts.c.sub\_part,            func.sum(included\_parts.c.quantity).              label('total\_quantity')        ).\        group\_by(included\_parts.c.sub\_part)result = conn.execute(statement).fetchall()
```
Example 3, an upsert using UPDATE and INSERT with CTEs:


```
from datetime import datefrom sqlalchemy import (MetaData, Table, Column, Integer,                        Date, select, literal, and\_, exists)metadata = MetaData()visitors = Table('visitors', metadata,    Column('product\_id', Integer, primary\_key=True),    Column('date', Date, primary\_key=True),    Column('count', Integer),)# add 5 visitors for the product\_id == 1product\_id = 1day = date.today()count = 5update\_cte = (    visitors.update()    .where(and\_(visitors.c.product\_id == product\_id,                visitors.c.date == day))    .values(count=visitors.c.count + count)    .returning(literal(1))    .cte('update\_cte'))upsert = visitors.insert().from\_select(    [visitors.c.product\_id, visitors.c.date, visitors.c.count],    select(literal(product\_id), literal(day), literal(count))        .where(~exists(update\_cte.select())))connection.execute(upsert)
```
Example 4, Nesting CTE (SQLAlchemy 1.4.24 and above):


```
value\_a = select(    literal("root").label("n")).cte("value\_a")# A nested CTE with the same name as the root onevalue\_a\_nested = select(    literal("nesting").label("n")).cte("value\_a", nesting=True)# Nesting CTEs takes ascendency locally# over the CTEs at a higher levelvalue\_b = select(value\_a\_nested.c.n).cte("value\_b")value\_ab = select(value\_a.c.n.label("a"), value\_b.c.n.label("b"))
```
The above query will render the second CTE nested inside the first,shown with inline parameters below as:


```
WITH    value\_a AS        (SELECT 'root' AS n),    value\_b AS        (WITH value\_a AS            (SELECT 'nesting' AS n)        SELECT value\_a.n AS n FROM value\_a)SELECT value\_a.n AS a, value\_b.n AS bFROM value\_a, value\_b
```
The same CTE can be set up using the `HasCTE.add\_cte()` methodas follows (SQLAlchemy 2.0 and above):


```
value\_a = select(    literal("root").label("n")).cte("value\_a")# A nested CTE with the same name as the root onevalue\_a\_nested = select(    literal("nesting").label("n")).cte("value\_a")# Nesting CTEs takes ascendency locally# over the CTEs at a higher levelvalue\_b = (    select(value\_a\_nested.c.n).    add\_cte(value\_a\_nested, nest\_here=True).    cte("value\_b"))value\_ab = select(value\_a.c.n.label("a"), value\_b.c.n.label("b"))
```
Example 5, Non-Linear CTE (SQLAlchemy 1.4.28 and above):


```
edge = Table(    "edge",    metadata,    Column("id", Integer, primary\_key=True),    Column("left", Integer),    Column("right", Integer),)root\_node = select(literal(1).label("node")).cte(    "nodes", recursive=True)left\_edge = select(edge.c.left).join(    root\_node, edge.c.right == root\_node.c.node)right\_edge = select(edge.c.right).join(    root\_node, edge.c.left == root\_node.c.node)subgraph\_cte = root\_node.union(left\_edge, right\_edge)subgraph = select(subgraph\_cte)
```
The above query will render 2 UNIONs inside the recursive CTE:


```
WITH RECURSIVE nodes(node) AS (        SELECT 1 AS node    UNION        SELECT edge."left" AS "left"        FROM edge JOIN nodes ON edge."right" = nodes.node    UNION        SELECT edge."right" AS "right"        FROM edge JOIN nodes ON edge."left" = nodes.node)SELECT nodes.node FROM nodes
```
See also

`\_orm.Query.cte()` - ORM version of`\_expression.HasCTE.cte()`.

distinct(*\*expr: \_ColumnExpressionArgument[Any]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.distinct "Permalink to this definition")Return a new `\_expression.select()` construct whichwill apply DISTINCT to its columns clause.

Parameters**\*expr** – optional column expressions. When present,the PostgreSQL dialect will render a `DISTINCT ON (<expressions>>)`construct.

Deprecated since version 1.4: Using \*expr in other dialects is deprecatedand will raise `\_exc.CompileError` in a future version.



except\_(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.except_ "Permalink to this definition")Return a SQL `EXCEPT` of this select() construct againstthe given selectable provided as positional arguments.

Parameters**\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.



except\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.except_all "Permalink to this definition")Return a SQL `EXCEPT ALL` of this select() construct againstthe given selectables provided as positional arguments.

Parameters**\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.



execution\_options(*\*\*kw: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.execution_options "Permalink to this definition")Set non-SQL options for the statement which take effect duringexecution.

Execution options can be set at many scopes, including per-statement,per-connection, or per execution, using methods such as`\_engine.Connection.execution\_options()` and parameters whichaccept a dictionary of options such as[:paramref:`\_engine.Connection.execute.execution\_options`](#id43) and[:paramref:`\_orm.Session.execute.execution\_options`](#id45).

The primary characteristic of an execution option, as opposed toother kinds of options such as ORM loader options, is that**execution options never affect the compiled SQL of a query, onlythings that affect how the SQL statement itself is invoked or howresults are fetched**. That is, execution options are not part ofwhat’s accommodated by SQL compilation nor are they considered part ofthe cached state of a statement.

The `\_sql.Executable.execution\_options()` method isgenerative, asis the case for the method as applied to the `\_engine.Engine`and `\_orm.Query` objects, which means when the method is called,a copy of the object is returned, which applies the given parameters tothat new copy, but leaves the original unchanged:


```
statement = select(table.c.x, table.c.y)new\_statement = statement.execution\_options(my\_option=True)
```
An exception to this behavior is the `\_engine.Connection`object, where the `\_engine.Connection.execution\_options()` methodis explicitly **not** generative.

The kinds of options that may be passed to`\_sql.Executable.execution\_options()` and other related methods andparameter dictionaries include parameters that are explicitly consumedby SQLAlchemy Core or ORM, as well as arbitrary keyword arguments notdefined by SQLAlchemy, which means the methods and/or parameterdictionaries may be used for user-defined parameters that interact withcustom code, which may access the parameters using methods such as`\_sql.Executable.get\_execution\_options()` and`\_engine.Connection.get\_execution\_options()`, or within selectedevent hooks using a dedicated `execution\_options` event parametersuch as[:paramref:`\_events.ConnectionEvents.before\_execute.execution\_options`](#id47)or `\_orm.ORMExecuteState.execution\_options`, e.g.:


```
from sqlalchemy import event@event.listens\_for(some\_engine, "before\_execute")def \_process\_opt(conn, statement, multiparams, params, execution\_options):    "run a SQL function before invoking a statement"    if execution\_options.get("do\_special\_thing", False):        conn.exec\_driver\_sql("run\_special\_function()")
```
Within the scope of options that are explicitly recognized bySQLAlchemy, most apply to specific classes of objects and not others.The most common execution options include:

* [:paramref:`\_engine.Connection.execution\_options.isolation\_level`](#id49) -sets the isolation level for a connection or a class of connectionsvia an `\_engine.Engine`. This option is accepted onlyby `\_engine.Connection` or `\_engine.Engine`.
* [:paramref:`\_engine.Connection.execution\_options.stream\_results`](#id51) -indicates results should be fetched using a server side cursor;this option is accepted by `\_engine.Connection`, by the[:paramref:`\_engine.Connection.execute.execution\_options`](#id53) parameteron `\_engine.Connection.execute()`, and additionally by`\_sql.Executable.execution\_options()` on a SQL statement object,as well as by ORM constructs like `\_orm.Session.execute()`.
* [:paramref:`\_engine.Connection.execution\_options.compiled\_cache`](#id55) -indicates a dictionary that will serve as theSQL compilation cachefor a `\_engine.Connection` or `\_engine.Engine`, aswell as for ORM methods like `\_orm.Session.execute()`.Can be passed as `None` to disable caching for statements.This option is not accepted by`\_sql.Executable.execution\_options()` as it is inadvisable tocarry along a compilation cache within a statement object.
* [:paramref:`\_engine.Connection.execution\_options.schema\_translate\_map`](#id57)- a mapping of schema names used by theSchema Translate Map feature, acceptedby `\_engine.Connection`, `\_engine.Engine`,`\_sql.Executable`, as well as by ORM constructslike `\_orm.Session.execute()`.

See also

`\_engine.Connection.execution\_options()`

[:paramref:`\_engine.Connection.execute.execution\_options`](#id59)

[:paramref:`\_orm.Session.execute.execution\_options`](#id61)

orm\_queryguide\_execution\_options - documentation on allORM-specific execution options

exists() → Exists[](#llama_index.vector_stores.PGVectorStore.Select.exists "Permalink to this definition")Return an `\_sql.Exists` representation of this selectable,which can be used as a column expression.

The returned object is an instance of `\_sql.Exists`.

See also

`\_sql.exists()`

tutorial\_exists - in the 2.0 style tutorial.

New in version 1.4.

*property* exported\_columns*: ReadOnlyColumnCollection[str, ColumnElement[Any]]*[](#llama_index.vector_stores.PGVectorStore.Select.exported_columns "Permalink to this definition")A `\_expression.ColumnCollection`that represents the “exported”columns of this `\_expression.Selectable`, not including`\_sql.TextClause` constructs.

The “exported” columns for a `\_expression.SelectBase`object are synonymouswith the `\_expression.SelectBase.selected\_columns` collection.

New in version 1.4.

See also

`\_expression.Select.exported\_columns`

`\_expression.Selectable.exported\_columns`

`\_expression.FromClause.exported\_columns`

fetch(*count: \_LimitOffsetType*, *with\_ties: bool = False*, *percent: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.fetch "Permalink to this definition")Return a new selectable with the given FETCH FIRST criterionapplied.

This is a numeric value which usually renders as`FETCH {FIRST | NEXT} [ count ] {ROW | ROWS} {ONLY | WITH TIES}`expression in the resulting select. This functionality isis currently implemented for Oracle, PostgreSQL, MSSQL.

Use `\_sql.GenerativeSelect.offset()` to specify the offset.

Note

The `\_sql.GenerativeSelect.fetch()` method will replaceany clause applied with `\_sql.GenerativeSelect.limit()`.

New in version 1.4.

Parameters* **count** – an integer COUNT parameter, or a SQL expressionthat provides an integer result. When `percent=True` this willrepresent the percentage of rows to return, not the absolute value.Pass `None` to reset it.
* **with\_ties** – When `True`, the WITH TIES option is usedto return any additional rows that tie for the last place in theresult set according to the `ORDER BY` clause. The`ORDER BY` may be mandatory in this case. Defaults to `False`
* **percent** – When `True`, `count` represents the percentageof the total number of selected rows to return. Defaults to `False`
See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.offset()`

filter(*\*criteria: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.filter "Permalink to this definition")A synonym for the `\_sql.Select.where()` method.

filter\_by(*\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.filter_by "Permalink to this definition")apply the given filtering criterion as a WHERE clauseto this select.

from\_statement(*statement: ReturnsRowsRole*) → ExecutableReturnsRows[](#llama_index.vector_stores.PGVectorStore.Select.from_statement "Permalink to this definition")Apply the columns which this [`Select`](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select") would selectonto another statement.

This operation is plugin-specific and will raise a notsupported exception if this `\_sql.Select` does not select fromplugin-enabled entities.

The statement is typically either a `\_expression.text()` or`\_expression.select()` construct, and should return the set ofcolumns appropriate to the entities represented by this[`Select`](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select").

See also

orm\_queryguide\_selecting\_text - usage examples in theORM Querying Guide

*property* froms*: Sequence[FromClause]*[](#llama_index.vector_stores.PGVectorStore.Select.froms "Permalink to this definition")Return the displayed list of `\_expression.FromClause`elements.

Deprecated since version 1.4.23: The `\_expression.Select.froms` attribute is moved to the `\_expression.Select.get\_final\_froms()` method.

get\_children(*\*\*kw: Any*) → Iterable[ClauseElement][](#llama_index.vector_stores.PGVectorStore.Select.get_children "Permalink to this definition")Return immediate child `visitors.HasTraverseInternals`elements of this `visitors.HasTraverseInternals`.

This is used for visit traversal.

\*\*kw may contain flags that change the collection that isreturned, for example to return a subset of items in order tocut down on larger traversals, or to return child items from adifferent context (such as schema-level collections instead ofclause-level).

get\_execution\_options() → \_ExecuteOptions[](#llama_index.vector_stores.PGVectorStore.Select.get_execution_options "Permalink to this definition")Get the non-SQL options which will take effect during execution.

New in version 1.3.

See also

`Executable.execution\_options()`

get\_final\_froms() → Sequence[FromClause][](#llama_index.vector_stores.PGVectorStore.Select.get_final_froms "Permalink to this definition")Compute the final displayed list of `\_expression.FromClause`elements.

This method will run through the full computation required todetermine what FROM elements will be displayed in the resultingSELECT statement, including shadowing individual tables withJOIN objects, as well as full computation for ORM use cases includingeager loading clauses.

For ORM use, this accessor returns the **post compilation**list of FROM objects; this collection will include elements such aseagerly loaded tables and joins. The objects will **not** beORM enabled and not work as a replacement for the`\_sql.Select.select\_froms()` collection; additionally, themethod is not well performing for an ORM enabled statement as itwill incur the full ORM construction process.

To retrieve the FROM list that’s implied by the “columns” collectionpassed to the `\_sql.Select` originally, use the`\_sql.Select.columns\_clause\_froms` accessor.

To select from an alternative set of columns while maintaining theFROM list, use the `\_sql.Select.with\_only\_columns()` method andpass the[:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id63)parameter.

New in version 1.4.23: - the `\_sql.Select.get\_final\_froms()`method replaces the previous `\_sql.Select.froms` accessor,which is deprecated.

See also

`\_sql.Select.columns\_clause\_froms`

get\_label\_style() → SelectLabelStyle[](#llama_index.vector_stores.PGVectorStore.Select.get_label_style "Permalink to this definition")Retrieve the current label style.

New in version 1.4.

group\_by(*\_GenerativeSelect\_\_first: Union[Literal[None, \_NoArg.NO\_ARG], \_ColumnExpressionOrStrLabelArgument[Any]] = \_NoArg.NO\_ARG*, *\*clauses: \_ColumnExpressionOrStrLabelArgument[Any]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.group_by "Permalink to this definition")Return a new selectable with the given list of GROUP BYcriterion applied.

All existing GROUP BY settings can be suppressed by passing `None`.

e.g.:


```
stmt = select(table.c.name, func.max(table.c.stat)).\group\_by(table.c.name)
```
Parameters**\*clauses** – a series of `\_expression.ColumnElement`constructswhich will be used to generate an GROUP BY clause.

See also

tutorial\_group\_by\_w\_aggregates - in theunified\_tutorial

tutorial\_order\_by\_label - in the unified\_tutorial

having(*\*having: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.having "Permalink to this definition")Return a new `\_expression.select()` construct withthe given expression added toits HAVING clause, joined to the existing clause via AND, if any.

inherit\_cache*: Optional[bool]* *= None*[](#llama_index.vector_stores.PGVectorStore.Select.inherit_cache "Permalink to this definition")Indicate if this `HasCacheKey` instance should make use of thecache key generation scheme used by its immediate superclass.

The attribute defaults to `None`, which indicates that a construct hasnot yet taken into account whether or not its appropriate for it toparticipate in caching; this is functionally equivalent to setting thevalue to `False`, except that a warning is also emitted.

This flag can be set to `True` on a particular class, if the SQL thatcorresponds to the object does not change based on attributes whichare local to this class, and not its superclass.

See also

compilerext\_caching - General guideslines for setting the`HasCacheKey.inherit\_cache` attribute for third-party or userdefined SQL constructs.

*property* inner\_columns*: \_SelectIterable*[](#llama_index.vector_stores.PGVectorStore.Select.inner_columns "Permalink to this definition")An iterator of all `\_expression.ColumnElement`expressions which wouldbe rendered into the columns clause of the resulting SELECT statement.

This method is legacy as of 1.4 and is superseded by the`\_expression.Select.exported\_columns` collection.

intersect(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.intersect "Permalink to this definition")Return a SQL `INTERSECT` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
intersect\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.intersect_all "Permalink to this definition")Return a SQL `INTERSECT ALL` of this select() constructagainst the given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
is\_derived\_from(*fromclause: Optional[FromClause]*) → bool[](#llama_index.vector_stores.PGVectorStore.Select.is_derived_from "Permalink to this definition")Return `True` if this `ReturnsRows` is‘derived’ from the given `FromClause`.

An example would be an Alias of a Table is derived from that Table.

join(*target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *isouter: bool = False*, *full: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.join "Permalink to this definition")Create a SQL JOIN against this `\_expression.Select`object’s criterionand apply generatively, returning the newly resulting`\_expression.Select`.

E.g.:


```
stmt = select(user\_table).join(address\_table, user\_table.c.id == address\_table.c.user\_id)
```
The above statement generates SQL similar to:


```
SELECT user.id, user.name FROM user JOIN address ON user.id = address.user\_id
```
Changed in version 1.4: `\_expression.Select.join()` now createsa `\_sql.Join` object between a `\_sql.FromClause`source that is within the FROM clause of the existing SELECT,and a given target `\_sql.FromClause`, and then addsthis `\_sql.Join` to the FROM clause of the newly generatedSELECT statement. This is completely reworked from the behaviorin 1.3, which would instead create a subquery of the entire`\_expression.Select` and then join that subquery to thetarget.

This is a **backwards incompatible change** as the previous behaviorwas mostly useless, producing an unnamed subquery rejected bymost databases in any case. The new behavior is modeled afterthat of the very successful `\_orm.Query.join()` method in theORM, in order to support the functionality of `\_orm.Query`being available by using a `\_sql.Select` object with an`\_orm.Session`.

See the notes for this change at change\_select\_join.

Parameters* **target** – target table to join towards
* **onclause** – ON clause of the join. If omitted, an ON clauseis generated automatically based on the `\_schema.ForeignKey`linkages between the two tables, if one can be unambiguouslydetermined, otherwise an error is raised.
* **isouter** – if True, generate LEFT OUTER join. Same as`\_expression.Select.outerjoin()`.
* **full** – if True, generate FULL OUTER join.
See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join\_from()`

`\_expression.Select.outerjoin()`

join\_from(*from\_: \_FromClauseArgument*, *target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *isouter: bool = False*, *full: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.join_from "Permalink to this definition")Create a SQL JOIN against this `\_expression.Select`object’s criterionand apply generatively, returning the newly resulting`\_expression.Select`.

E.g.:


```
stmt = select(user\_table, address\_table).join\_from(    user\_table, address\_table, user\_table.c.id == address\_table.c.user\_id)
```
The above statement generates SQL similar to:


```
SELECT user.id, user.name, address.id, address.email, address.user\_idFROM user JOIN address ON user.id = address.user\_id
```
New in version 1.4.

Parameters* **from\_** – the left side of the join, will be rendered in theFROM clause and is roughly equivalent to using the[`Select.select\_from()`](#llama_index.vector_stores.LanternVectorStore.Select.select_from "llama_index.vector_stores.LanternVectorStore.Select.select_from") method.
* **target** – target table to join towards
* **onclause** – ON clause of the join.
* **isouter** – if True, generate LEFT OUTER join. Same as`\_expression.Select.outerjoin()`.
* **full** – if True, generate FULL OUTER join.
See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join()`

label(*name: Optional[str]*) → Label[Any][](#llama_index.vector_stores.PGVectorStore.Select.label "Permalink to this definition")Return a ‘scalar’ representation of this selectable, embedded as asubquery with a label.

See also

`\_expression.SelectBase.scalar\_subquery()`.

lateral(*name: Optional[str] = None*) → LateralFromClause[](#llama_index.vector_stores.PGVectorStore.Select.lateral "Permalink to this definition")Return a LATERAL alias of this `\_expression.Selectable`.

The return value is the `\_expression.Lateral` construct alsoprovided by the top-level `\_expression.lateral()` function.

See also

tutorial\_lateral\_correlation - overview of usage.

limit(*limit: \_LimitOffsetType*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.limit "Permalink to this definition")Return a new selectable with the given LIMIT criterionapplied.

This is a numerical value which usually renders as a `LIMIT`expression in the resulting select. Backends that don’tsupport `LIMIT` will attempt to provide similarfunctionality.

Note

The `\_sql.GenerativeSelect.limit()` method will replaceany clause applied with `\_sql.GenerativeSelect.fetch()`.

Parameters**limit** – an integer LIMIT parameter, or a SQL expressionthat provides an integer result. Pass `None` to reset it.

See also

`\_sql.GenerativeSelect.fetch()`

`\_sql.GenerativeSelect.offset()`

offset(*offset: \_LimitOffsetType*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.offset "Permalink to this definition")Return a new selectable with the given OFFSET criterionapplied.

This is a numeric value which usually renders as an `OFFSET`expression in the resulting select. Backends that don’tsupport `OFFSET` will attempt to provide similarfunctionality.

Parameters**offset** – an integer OFFSET parameter, or a SQL expressionthat provides an integer result. Pass `None` to reset it.

See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.fetch()`

options(*\*options: ExecutableOption*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.options "Permalink to this definition")Apply options to this statement.

In the general sense, options are any kind of Python objectthat can be interpreted by the SQL compiler for the statement.These options can be consumed by specific dialects or specific kindsof compilers.

The most commonly known kind of option are the ORM level optionsthat apply “eager load” and other loading behaviors to an ORMquery. However, options can theoretically be used for many otherpurposes.

For background on specific kinds of options for specific kinds ofstatements, refer to the documentation for those option objects.

Changed in version 1.4: - added `Executable.options()` toCore statement objects towards the goal of allowing unifiedCore / ORM querying capabilities.

See also

loading\_columns - refers to options specific to the usageof ORM queries

relationship\_loader\_options - refers to options specificto the usage of ORM queries

order\_by(*\_GenerativeSelect\_\_first: Union[Literal[None, \_NoArg.NO\_ARG], \_ColumnExpressionOrStrLabelArgument[Any]] = \_NoArg.NO\_ARG*, *\*clauses: \_ColumnExpressionOrStrLabelArgument[Any]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.order_by "Permalink to this definition")Return a new selectable with the given list of ORDER BYcriteria applied.

e.g.:


```
stmt = select(table).order\_by(table.c.id, table.c.name)
```
Calling this method multiple times is equivalent to calling it oncewith all the clauses concatenated. All existing ORDER BY criteria maybe cancelled by passing `None` by itself. New ORDER BY criteria maythen be added by invoking `\_orm.Query.order\_by()` again, e.g.:


```
# will erase all ORDER BY and ORDER BY new\_col alonestmt = stmt.order\_by(None).order\_by(new\_col)
```
Parameters**\*clauses** – a series of `\_expression.ColumnElement`constructswhich will be used to generate an ORDER BY clause.

See also

tutorial\_order\_by - in the unified\_tutorial

tutorial\_order\_by\_label - in the unified\_tutorial

outerjoin(*target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *full: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.outerjoin "Permalink to this definition")Create a left outer join.

Parameters are the same as that of `\_expression.Select.join()`.

Changed in version 1.4: `\_expression.Select.outerjoin()` nowcreates a `\_sql.Join` object between a`\_sql.FromClause` source that is within the FROM clause ofthe existing SELECT, and a given target `\_sql.FromClause`,and then adds this `\_sql.Join` to the FROM clause of thenewly generated SELECT statement. This is completely reworkedfrom the behavior in 1.3, which would instead create a subquery ofthe entire`\_expression.Select` and then join that subquery to thetarget.

This is a **backwards incompatible change** as the previous behaviorwas mostly useless, producing an unnamed subquery rejected bymost databases in any case. The new behavior is modeled afterthat of the very successful `\_orm.Query.join()` method in theORM, in order to support the functionality of `\_orm.Query`being available by using a `\_sql.Select` object with an`\_orm.Session`.

See the notes for this change at change\_select\_join.

See also

tutorial\_select\_join - in the /tutorial/index

orm\_queryguide\_joins - in the queryguide\_toplevel

`\_expression.Select.join()`

outerjoin\_from(*from\_: \_FromClauseArgument*, *target: \_JoinTargetArgument*, *onclause: Optional[\_OnClauseArgument] = None*, *\**, *full: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.outerjoin_from "Permalink to this definition")Create a SQL LEFT OUTER JOIN against this`\_expression.Select` object’s criterion and apply generatively,returning the newly resulting `\_expression.Select`.

Usage is the same as that of `\_selectable.Select.join\_from()`.

params(*\_ClauseElement\_\_optionaldict: Optional[Mapping[str, Any]] = None*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.params "Permalink to this definition")Return a copy with `\_expression.bindparam()` elementsreplaced.

Returns a copy of this ClauseElement with`\_expression.bindparam()`elements replaced with values taken from the given dictionary:


```
>>> clause = column('x') + bindparam('foo')>>> print(clause.compile().params){'foo':None}>>> print(clause.params({'foo':7}).compile().params){'foo':7}
```
prefix\_with(*\*prefixes: \_TextCoercedExpressionArgument[Any]*, *dialect: str = '\*'*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.prefix_with "Permalink to this definition")Add one or more expressions following the statement keyword, i.e.SELECT, INSERT, UPDATE, or DELETE. Generative.

This is used to support backend-specific prefix keywords such as thoseprovided by MySQL.

E.g.:


```
stmt = table.insert().prefix\_with("LOW\_PRIORITY", dialect="mysql")# MySQL 5.7 optimizer hintsstmt = select(table).prefix\_with(    "/\*+ BKA(t1) \*/", dialect="mysql")
```
Multiple prefixes can be specified by multiple callsto `\_expression.HasPrefixes.prefix\_with()`.

Parameters* **\*prefixes** – textual or `\_expression.ClauseElement`construct whichwill be rendered following the INSERT, UPDATE, or DELETEkeyword.
* **dialect** – optional string dialect name which willlimit rendering of this prefix to only that dialect.
reduce\_columns(*only\_synonyms: bool = True*) → [Select](#llama_index.vector_stores.PGVectorStore.Select "sqlalchemy.sql.selectable.Select")[](#llama_index.vector_stores.PGVectorStore.Select.reduce_columns "Permalink to this definition")Return a new `\_expression.select()` construct with redundantlynamed, equivalently-valued columns removed from the columns clause.

“Redundant” here means two columns where one refers to theother either based on foreign key, or via a simple equalitycomparison in the WHERE clause of the statement. The primary purposeof this method is to automatically construct a select statementwith all uniquely-named columns, without the need to usetable-qualified labels as`\_expression.Select.set\_label\_style()`does.

When columns are omitted based on foreign key, the referred-tocolumn is the one that’s kept. When columns are omitted based onWHERE equivalence, the first column in the columns clause is theone that’s kept.

Parameters**only\_synonyms** – when True, limit the removal of columnsto those which have the same name as the equivalent. Otherwise,all columns that are equivalent to another are removed.

replace\_selectable(*old: FromClause*, *alias: Alias*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.replace_selectable "Permalink to this definition")Replace all occurrences of `\_expression.FromClause`‘old’ with the given `\_expression.Alias`object, returning a copy of this `\_expression.FromClause`.

Deprecated since version 1.4: The `Selectable.replace\_selectable()` method is deprecated, and will be removed in a future release. Similar functionality is available via the sqlalchemy.sql.visitors module.

scalar\_subquery() → ScalarSelect[Any][](#llama_index.vector_stores.PGVectorStore.Select.scalar_subquery "Permalink to this definition")Return a ‘scalar’ representation of this selectable, which can beused as a column expression.

The returned object is an instance of `\_sql.ScalarSelect`.

Typically, a select statement which has only one column in its columnsclause is eligible to be used as a scalar expression. The scalarsubquery can then be used in the WHERE clause or columns clause ofan enclosing SELECT.

Note that the scalar subquery differentiates from the FROM-levelsubquery that can be produced using the`\_expression.SelectBase.subquery()`method.

See also

tutorial\_scalar\_subquery - in the 2.0 tutorial

select(*\*arg: Any*, *\*\*kw: Any*) → [Select](#llama_index.vector_stores.PGVectorStore.Select "sqlalchemy.sql.selectable.Select")[](#llama_index.vector_stores.PGVectorStore.Select.select "Permalink to this definition")Deprecated since version 1.4: The `\_expression.SelectBase.select()` method is deprecated and will be removed in a future release; this method implicitly creates a subquery that should be explicit. Please call `\_expression.SelectBase.subquery()` first in order to create a subquery, which then can be selected.

select\_from(*\*froms: \_FromClauseArgument*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.select_from "Permalink to this definition")Return a new `\_expression.select()` construct with thegiven FROM expression(s)merged into its list of FROM objects.

E.g.:


```
table1 = table('t1', column('a'))table2 = table('t2', column('b'))s = select(table1.c.a).\    select\_from(        table1.join(table2, table1.c.a==table2.c.b)    )
```
The “from” list is a unique set on the identity of each element,so adding an already present `\_schema.Table`or other selectablewill have no effect. Passing a `\_expression.Join` that refersto an already present `\_schema.Table`or other selectable will havethe effect of concealing the presence of that selectable asan individual element in the rendered FROM list, insteadrendering it into a JOIN clause.

While the typical purpose of `\_expression.Select.select\_from()`is toreplace the default, derived FROM clause with a join, it canalso be called with individual table elements, multiple timesif desired, in the case that the FROM clause cannot be fullyderived from the columns clause:


```
select(func.count('\*')).select\_from(table1)
```
selected\_columns[](#llama_index.vector_stores.PGVectorStore.Select.selected_columns "Permalink to this definition")A `\_expression.ColumnCollection`representing the columns thatthis SELECT statement or similar construct returns in its result set,not including `\_sql.TextClause` constructs.

This collection differs from the `\_expression.FromClause.columns`collection of a `\_expression.FromClause` in that the columnswithin this collection cannot be directly nested inside another SELECTstatement; a subquery must be applied first which provides for thenecessary parenthesization required by SQL.

For a `\_expression.select()` construct, the collection here isexactly what would be rendered inside the “SELECT” statement, and the`\_expression.ColumnElement` objects are directly present as theywere given, e.g.:


```
col1 = column('q', Integer)col2 = column('p', Integer)stmt = select(col1, col2)
```
Above, `stmt.selected\_columns` would be a collection that containsthe `col1` and `col2` objects directly. For a statement that isagainst a `\_schema.Table` or other`\_expression.FromClause`, the collection will use the`\_expression.ColumnElement` objects that are in the`\_expression.FromClause.c` collection of the from element.

A use case for the `\_sql.Select.selected\_columns` collection isto allow the existing columns to be referenced when adding additionalcriteria, e.g.:


```
def filter\_on\_id(my\_select, id):    return my\_select.where(my\_select.selected\_columns['id'] == id)stmt = select(MyModel)# adds "WHERE id=:param" to the statementstmt = filter\_on\_id(stmt, 42)
```
Note

The `\_sql.Select.selected\_columns` collection does notinclude expressions established in the columns clause using the`\_sql.text()` construct; these are silently omitted from thecollection. To use plain textual column expressions inside of a`\_sql.Select` construct, use the `\_sql.literal\_column()`construct.

New in version 1.4.

self\_group(*against: Optional[OperatorType] = None*) → Union[SelectStatementGrouping, Self][](#llama_index.vector_stores.PGVectorStore.Select.self_group "Permalink to this definition")Apply a ‘grouping’ to this `\_expression.ClauseElement`.

This method is overridden by subclasses to return a “grouping”construct, i.e. parenthesis. In particular it’s used by “binary”expressions to provide a grouping around themselves when placed into alarger expression, as well as by `\_expression.select()`constructs when placed into the FROM clause of another`\_expression.select()`. (Note that subqueries should benormally created using the `\_expression.Select.alias()` method,as manyplatforms require nested SELECT statements to be named).

As expressions are composed together, the application of[`self\_group()`](#llama_index.vector_stores.PGVectorStore.Select.self_group "llama_index.vector_stores.PGVectorStore.Select.self_group") is automatic - end-user code should neverneed to use this method directly. Note that SQLAlchemy’sclause constructs take operator precedence into account -so parenthesis might not be needed, for example, inan expression like `x OR (y AND z)` - AND takes precedenceover OR.

The base [`self\_group()`](#llama_index.vector_stores.PGVectorStore.Select.self_group "llama_index.vector_stores.PGVectorStore.Select.self_group") method of`\_expression.ClauseElement`just returns self.

set\_label\_style(*style: SelectLabelStyle*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.set_label_style "Permalink to this definition")Return a new selectable with the specified label style.

There are three “label styles” available,`\_sql.SelectLabelStyle.LABEL\_STYLE\_DISAMBIGUATE\_ONLY`,`\_sql.SelectLabelStyle.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`, and`\_sql.SelectLabelStyle.LABEL\_STYLE\_NONE`. The default style is`\_sql.SelectLabelStyle.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`.

In modern SQLAlchemy, there is not generally a need to change thelabeling style, as per-expression labels are more effectively used bymaking use of the `\_sql.ColumnElement.label()` method. In pastversions, `\_sql.LABEL\_STYLE\_TABLENAME\_PLUS\_COL` was used todisambiguate same-named columns from different tables, aliases, orsubqueries; the newer `\_sql.LABEL\_STYLE\_DISAMBIGUATE\_ONLY` nowapplies labels only to names that conflict with an existing name sothat the impact of this labeling is minimal.

The rationale for disambiguation is mostly so that all columnexpressions are available from a given `\_sql.FromClause.c`collection when a subquery is created.

New in version 1.4: - the`\_sql.GenerativeSelect.set\_label\_style()` method replaces theprevious combination of `.apply\_labels()`, `.with\_labels()` and`use\_labels=True` methods and/or parameters.

See also

`\_sql.LABEL\_STYLE\_DISAMBIGUATE\_ONLY`

`\_sql.LABEL\_STYLE\_TABLENAME\_PLUS\_COL`

`\_sql.LABEL\_STYLE\_NONE`

`\_sql.LABEL\_STYLE\_DEFAULT`

slice(*start: int*, *stop: int*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.slice "Permalink to this definition")Apply LIMIT / OFFSET to this statement based on a slice.

The start and stop indices behave like the argument to Python’sbuilt-in `range()` function. This method provides analternative to using `LIMIT`/`OFFSET` to get a slice of thequery.

For example,


```
stmt = select(User).order\_by(User).id.slice(1, 3)
```
renders as


```
SELECT users.id AS users\_id, users.name AS users\_nameFROM users ORDER BY users.idLIMIT ? OFFSET ?(2, 1)
```
Note

The `\_sql.GenerativeSelect.slice()` method will replaceany clause applied with `\_sql.GenerativeSelect.fetch()`.

New in version 1.4: Added the `\_sql.GenerativeSelect.slice()`method generalized from the ORM.

See also

`\_sql.GenerativeSelect.limit()`

`\_sql.GenerativeSelect.offset()`

`\_sql.GenerativeSelect.fetch()`

subquery(*name: Optional[str] = None*) → Subquery[](#llama_index.vector_stores.PGVectorStore.Select.subquery "Permalink to this definition")Return a subquery of this `\_expression.SelectBase`.

A subquery is from a SQL perspective a parenthesized, namedconstruct that can be placed in the FROM clause of anotherSELECT statement.

Given a SELECT statement such as:


```
stmt = select(table.c.id, table.c.name)
```
The above statement might look like:


```
SELECT table.id, table.name FROM table
```
The subquery form by itself renders the same way, however whenembedded into the FROM clause of another SELECT statement, it becomesa named sub-element:


```
subq = stmt.subquery()new\_stmt = select(subq)
```
The above renders as:


```
SELECT anon\_1.id, anon\_1.nameFROM (SELECT table.id, table.name FROM table) AS anon\_1
```
Historically, `\_expression.SelectBase.subquery()`is equivalent to callingthe `\_expression.FromClause.alias()`method on a FROM object; however,as a `\_expression.SelectBase`object is not directly FROM object,the `\_expression.SelectBase.subquery()`method provides clearer semantics.

New in version 1.4.

suffix\_with(*\*suffixes: \_TextCoercedExpressionArgument[Any]*, *dialect: str = '\*'*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.suffix_with "Permalink to this definition")Add one or more expressions following the statement as a whole.

This is used to support backend-specific suffix keywords oncertain constructs.

E.g.:


```
stmt = select(col1, col2).cte().suffix\_with(    "cycle empno set y\_cycle to 1 default 0", dialect="oracle")
```
Multiple suffixes can be specified by multiple callsto `\_expression.HasSuffixes.suffix\_with()`.

Parameters* **\*suffixes** – textual or `\_expression.ClauseElement`construct whichwill be rendered following the target clause.
* **dialect** – Optional string dialect name which willlimit rendering of this suffix to only that dialect.
union(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.union "Permalink to this definition")Return a SQL `UNION` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
union\_all(*\*other: \_SelectStatementForCompoundArgument*) → CompoundSelect[](#llama_index.vector_stores.PGVectorStore.Select.union_all "Permalink to this definition")Return a SQL `UNION ALL` of this select() construct againstthe given selectables provided as positional arguments.

Parameters* **\*other** – one or more elements with which to create aUNION.

Changed in version 1.4.28: multiple elements are now accepted.
* **\*\*kwargs** – keyword arguments are forwarded to the constructorfor the newly created `\_sql.CompoundSelect` object.
unique\_params(*\_ClauseElement\_\_optionaldict: Optional[Dict[str, Any]] = None*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.unique_params "Permalink to this definition")Return a copy with `\_expression.bindparam()` elementsreplaced.

Same functionality as `\_expression.ClauseElement.params()`,except adds unique=Trueto affected bind parameters so that multiple statements can beused.

where(*\*whereclause: \_ColumnExpressionArgument[bool]*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.where "Permalink to this definition")Return a new `\_expression.select()` construct withthe given expression added toits WHERE clause, joined to the existing clause via AND, if any.

*property* whereclause*: Optional[ColumnElement[Any]]*[](#llama_index.vector_stores.PGVectorStore.Select.whereclause "Permalink to this definition")Return the completed WHERE clause for this`\_expression.Select` statement.

This assembles the current collection of WHERE criteriainto a single `\_expression.BooleanClauseList` construct.

New in version 1.4.

with\_for\_update(*\**, *nowait: bool = False*, *read: bool = False*, *of: Optional[\_ForUpdateOfArgument] = None*, *skip\_locked: bool = False*, *key\_share: bool = False*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.with_for_update "Permalink to this definition")Specify a `FOR UPDATE` clause for this`\_expression.GenerativeSelect`.

E.g.:


```
stmt = select(table).with\_for\_update(nowait=True)
```
On a database like PostgreSQL or Oracle, the above would render astatement like:


```
SELECT table.a, table.b FROM table FOR UPDATE NOWAIT
```
on other backends, the `nowait` option is ignored and insteadwould produce:


```
SELECT table.a, table.b FROM table FOR UPDATE
```
When called with no arguments, the statement will render withthe suffix `FOR UPDATE`. Additional arguments can then beprovided which allow for common database-specificvariants.

Parameters* **nowait** – boolean; will render `FOR UPDATE NOWAIT` on Oracleand PostgreSQL dialects.
* **read** – boolean; will render `LOCK IN SHARE MODE` on MySQL,`FOR SHARE` on PostgreSQL. On PostgreSQL, when combined with`nowait`, will render `FOR SHARE NOWAIT`.
* **of** – SQL expression or list of SQL expression elements,(typically `\_schema.Column` objects or a compatible expression,for some backends may also be a table expression) which will renderinto a `FOR UPDATE OF` clause; supported by PostgreSQL, Oracle, someMySQL versions and possibly others. May render as a table or as acolumn depending on backend.
* **skip\_locked** – boolean, will render `FOR UPDATE SKIP LOCKED`on Oracle and PostgreSQL dialects or `FOR SHARE SKIP LOCKED` if`read=True` is also specified.
* **key\_share** – boolean, will render `FOR NO KEY UPDATE`,or if combined with `read=True` will render `FOR KEY SHARE`,on the PostgreSQL dialect.
with\_hint(*selectable: \_FromClauseArgument*, *text: str*, *dialect\_name: str = '\*'*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.with_hint "Permalink to this definition")Add an indexing or other executional context hint for the givenselectable to this `\_expression.Select` or other selectableobject.

The text of the hint is rendered in the appropriatelocation for the database backend in use, relativeto the given `\_schema.Table` or `\_expression.Alias`passed as the`selectable` argument. The dialect implementationtypically uses Python string substitution syntaxwith the token `%(name)s` to render the name ofthe table or alias. E.g. when using Oracle, thefollowing:


```
select(mytable).\    with\_hint(mytable, "index(%(name)s ix\_mytable)")
```
Would render SQL as:


```
select /\*+ index(mytable ix\_mytable) \*/ ... from mytable
```
The `dialect\_name` option will limit the rendering of a particularhint to a particular backend. Such as, to add hints for both Oracleand Sybase simultaneously:


```
select(mytable).\    with\_hint(mytable, "index(%(name)s ix\_mytable)", 'oracle').\    with\_hint(mytable, "WITH INDEX ix\_mytable", 'mssql')
```
See also

`\_expression.Select.with\_statement\_hint()`

with\_only\_columns(*\*entities: \_ColumnsClauseArgument[Any]*, *maintain\_column\_froms: bool = False*, *\*\*\_Select\_\_kw: Any*) → [Select](#llama_index.vector_stores.LanternVectorStore.Select "llama_index.vector_stores.LanternVectorStore.Select")[Any][](#llama_index.vector_stores.PGVectorStore.Select.with_only_columns "Permalink to this definition")Return a new `\_expression.select()` construct with its columnsclause replaced with the given entities.

By default, this method is exactly equivalent to as if the original`\_expression.select()` had been called with the given entities.E.g. a statement:


```
s = select(table1.c.a, table1.c.b)s = s.with\_only\_columns(table1.c.b)
```
should be exactly equivalent to:


```
s = select(table1.c.b)
```
In this mode of operation, `\_sql.Select.with\_only\_columns()`will also dynamically alter the FROM clause of thestatement if it is not explicitly stated.To maintain the existing set of FROMs including those implied by thecurrent columns clause, add the[:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id65)parameter:


```
s = select(table1.c.a, table2.c.b)s = s.with\_only\_columns(table1.c.a, maintain\_column\_froms=True)
```
The above parameter performs a transfer of the effective FROMsin the columns collection to the `\_sql.Select.select\_from()`method, as though the following were invoked:


```
s = select(table1.c.a, table2.c.b)s = s.select\_from(table1, table2).with\_only\_columns(table1.c.a)
```
The [:paramref:`\_sql.Select.with\_only\_columns.maintain\_column\_froms`](#id67)parameter makes use of the `\_sql.Select.columns\_clause\_froms`collection and performs an operation equivalent to the following:


```
s = select(table1.c.a, table2.c.b)s = s.select\_from(\*s.columns\_clause\_froms).with\_only\_columns(table1.c.a)
```
Parameters* **\*entities** – column expressions to be used.
* **maintain\_column\_froms** – boolean parameter that will ensure theFROM list implied from the current columns clause will be transferredto the `\_sql.Select.select\_from()` method first.

New in version 1.4.23.
with\_statement\_hint(*text: str*, *dialect\_name: str = '\*'*) → Self[](#llama_index.vector_stores.PGVectorStore.Select.with_statement_hint "Permalink to this definition")Add a statement hint to this `\_expression.Select` orother selectable object.

This method is similar to `\_expression.Select.with\_hint()`except thatit does not require an individual table, and instead applies to thestatement as a whole.

Hints here are specific to the backend database and may includedirectives such as isolation levels, file directives, fetch directives,etc.

See also

`\_expression.Select.with\_hint()`

`\_expression.Select.prefix\_with()` - generic SELECT prefixingwhich also can suit some database-specific HINT syntaxes such asMySQL optimizer hints

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.PGVectorStore.add "Permalink to this definition")Add nodes to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.PGVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.PGVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.PGVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*classmethod* class\_name() → str[](#llama_index.vector_stores.PGVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*async* close() → None[](#llama_index.vector_stores.PGVectorStore.close "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.PGVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.PGVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.PGVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.PGVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PGVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.PGVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*host: Optional[str] = None*, *port: Optional[str] = None*, *database: Optional[str] = None*, *user: Optional[str] = None*, *password: Optional[str] = None*, *table\_name: str = 'llamaindex'*, *schema\_name: str = 'public'*, *connection\_string: Optional[str] = None*, *async\_connection\_string: Optional[str] = None*, *hybrid\_search: bool = False*, *text\_search\_config: str = 'english'*, *embed\_dim: int = 1536*, *cache\_ok: bool = False*, *perform\_setup: bool = True*, *debug: bool = False*) → [PGVectorStore](#llama_index.vector_stores.PGVectorStore "llama_index.vector_stores.postgres.PGVectorStore")[](#llama_index.vector_stores.PGVectorStore.from_params "Permalink to this definition")Return connection string from database parameters.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.PGVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.PGVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.PGVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.PGVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.PGVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.PGVectorStore.query "Permalink to this definition")Query vector store.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.PGVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.PGVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.PGVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.PGVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.PGVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.PGVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.PGVectorStore.client "Permalink to this definition")Get client.

*pydantic model* llama\_index.vector\_stores.PineconeVectorStore[](#llama_index.vector_stores.PineconeVectorStore "Permalink to this definition")Pinecone Vector Store.

In this vector store, embeddings and docs are stored within aPinecone index.

During query time, the index uses Pinecone to query for the topk most similar nodes.

Parameters* **pinecone\_index** (*Optional**[**pinecone.Index**]*) – Pinecone index instance
* **insert\_kwargs** (*Optional**[**Dict**]*) – insert kwargs during upsert call.
* **add\_sparse\_vector** (*bool*) – whether to add sparse vector to index.
* **tokenizer** (*Optional**[**Callable**]*) – tokenizer to use to generate sparse
Show JSON schema
```
{ "title": "PineconeVectorStore", "description": "Pinecone Vector Store.\n\nIn this vector store, embeddings and docs are stored within a\nPinecone index.\n\nDuring query time, the index uses Pinecone to query for the top\nk most similar nodes.\n\nArgs:\n pinecone\_index (Optional[pinecone.Index]): Pinecone index instance\n insert\_kwargs (Optional[Dict]): insert kwargs during `upsert` call.\n add\_sparse\_vector (bool): whether to add sparse vector to index.\n tokenizer (Optional[Callable]): tokenizer to use to generate sparse", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "flat\_metadata": { "title": "Flat Metadata", "default": false, "type": "boolean" }, "api\_key": { "title": "Api Key", "type": "string" }, "index\_name": { "title": "Index Name", "type": "string" }, "environment": { "title": "Environment", "type": "string" }, "namespace": { "title": "Namespace", "type": "string" }, "insert\_kwargs": { "title": "Insert Kwargs", "type": "object" }, "add\_sparse\_vector": { "title": "Add Sparse Vector", "type": "boolean" }, "text\_key": { "title": "Text Key", "type": "string" }, "batch\_size": { "title": "Batch Size", "type": "integer" }, "remove\_text\_from\_metadata": { "title": "Remove Text From Metadata", "type": "boolean" } }, "required": [ "add\_sparse\_vector", "text\_key", "batch\_size", "remove\_text\_from\_metadata" ]}
```


Fields* `add\_sparse\_vector (bool)`
* `api\_key (Optional[str])`
* `batch\_size (int)`
* `environment (Optional[str])`
* `flat\_metadata (bool)`
* `index\_name (Optional[str])`
* `insert\_kwargs (Optional[Dict])`
* `is\_embedding\_query (bool)`
* `namespace (Optional[str])`
* `remove\_text\_from\_metadata (bool)`
* `stores\_text (bool)`
* `text\_key (str)`
*field* add\_sparse\_vector*: bool* *[Required]*[](#llama_index.vector_stores.PineconeVectorStore.add_sparse_vector "Permalink to this definition")*field* api\_key*: Optional[str]* *= None*[](#llama_index.vector_stores.PineconeVectorStore.api_key "Permalink to this definition")*field* batch\_size*: int* *[Required]*[](#llama_index.vector_stores.PineconeVectorStore.batch_size "Permalink to this definition")*field* environment*: Optional[str]* *= None*[](#llama_index.vector_stores.PineconeVectorStore.environment "Permalink to this definition")*field* flat\_metadata*: bool* *= False*[](#llama_index.vector_stores.PineconeVectorStore.flat_metadata "Permalink to this definition")*field* index\_name*: Optional[str]* *= None*[](#llama_index.vector_stores.PineconeVectorStore.index_name "Permalink to this definition")*field* insert\_kwargs*: Optional[Dict]* *= None*[](#llama_index.vector_stores.PineconeVectorStore.insert_kwargs "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.PineconeVectorStore.is_embedding_query "Permalink to this definition")*field* namespace*: Optional[str]* *= None*[](#llama_index.vector_stores.PineconeVectorStore.namespace "Permalink to this definition")*field* remove\_text\_from\_metadata*: bool* *[Required]*[](#llama_index.vector_stores.PineconeVectorStore.remove_text_from_metadata "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.PineconeVectorStore.stores_text "Permalink to this definition")*field* text\_key*: str* *[Required]*[](#llama_index.vector_stores.PineconeVectorStore.text_key "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.PineconeVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.PineconeVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.PineconeVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.PineconeVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*classmethod* class\_name() → str[](#llama_index.vector_stores.PineconeVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.PineconeVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.PineconeVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.PineconeVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.PineconeVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PineconeVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.PineconeVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.PineconeVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*api\_key: Optional[str] = None*, *index\_name: Optional[str] = None*, *environment: Optional[str] = None*, *namespace: Optional[str] = None*, *insert\_kwargs: Optional[Dict] = None*, *add\_sparse\_vector: bool = False*, *tokenizer: Optional[Callable] = None*, *text\_key: str = 'text'*, *batch\_size: int = 100*, *remove\_text\_from\_metadata: bool = False*, *\*\*kwargs: Any*) → [PineconeVectorStore](#llama_index.vector_stores.PineconeVectorStore "llama_index.vector_stores.pinecone.PineconeVectorStore")[](#llama_index.vector_stores.PineconeVectorStore.from_params "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.PineconeVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.PineconeVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.PineconeVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.PineconeVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.PineconeVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.PineconeVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query\_embedding** (*List**[**float**]*) – query embedding
* **similarity\_top\_k** (*int*) – top k most similar nodes
*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.PineconeVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.PineconeVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.PineconeVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.PineconeVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.PineconeVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.PineconeVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.PineconeVectorStore.client "Permalink to this definition")Return Pinecone client.

*pydantic model* llama\_index.vector\_stores.QdrantVectorStore[](#llama_index.vector_stores.QdrantVectorStore "Permalink to this definition")Qdrant Vector Store.

In this vector store, embeddings and docs are stored within aQdrant collection.

During query time, the index uses Qdrant to query for the topk most similar nodes.

Parameters* **collection\_name** – (str): name of the Qdrant collection
* **client** (*Optional**[**Any**]*) – QdrantClient instance from qdrant-client package
Show JSON schema
```
{ "title": "QdrantVectorStore", "description": "Qdrant Vector Store.\n\nIn this vector store, embeddings and docs are stored within a\nQdrant collection.\n\nDuring query time, the index uses Qdrant to query for the top\nk most similar nodes.\n\nArgs:\n collection\_name: (str): name of the Qdrant collection\n client (Optional[Any]): QdrantClient instance from `qdrant-client` package", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "flat\_metadata": { "title": "Flat Metadata", "default": false, "type": "boolean" }, "collection\_name": { "title": "Collection Name", "type": "string" }, "url": { "title": "Url", "type": "string" }, "api\_key": { "title": "Api Key", "type": "string" }, "batch\_size": { "title": "Batch Size", "type": "integer" }, "prefer\_grpc": { "title": "Prefer Grpc", "type": "boolean" }, "client\_kwargs": { "title": "Client Kwargs", "type": "object" } }, "required": [ "collection\_name", "batch\_size", "prefer\_grpc" ]}
```


Fields* `api\_key (Optional[str])`
* `batch\_size (int)`
* `client\_kwargs (dict)`
* `collection\_name (str)`
* `flat\_metadata (bool)`
* `is\_embedding\_query (bool)`
* `prefer\_grpc (bool)`
* `stores\_text (bool)`
* `url (Optional[str])`
*field* api\_key*: Optional[str]* *= None*[](#llama_index.vector_stores.QdrantVectorStore.api_key "Permalink to this definition")*field* batch\_size*: int* *[Required]*[](#llama_index.vector_stores.QdrantVectorStore.batch_size "Permalink to this definition")*field* client\_kwargs*: dict* *[Optional]*[](#llama_index.vector_stores.QdrantVectorStore.client_kwargs "Permalink to this definition")*field* collection\_name*: str* *[Required]*[](#llama_index.vector_stores.QdrantVectorStore.collection_name "Permalink to this definition")*field* flat\_metadata*: bool* *= False*[](#llama_index.vector_stores.QdrantVectorStore.flat_metadata "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.QdrantVectorStore.is_embedding_query "Permalink to this definition")*field* prefer\_grpc*: bool* *[Required]*[](#llama_index.vector_stores.QdrantVectorStore.prefer_grpc "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.QdrantVectorStore.stores_text "Permalink to this definition")*field* url*: Optional[str]* *= None*[](#llama_index.vector_stores.QdrantVectorStore.url "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.QdrantVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.QdrantVectorStore.adelete "Permalink to this definition")Asynchronous method to delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.QdrantVectorStore.aquery "Permalink to this definition")Asynchronous method to query index for top k most similar nodes.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.QdrantVectorStore.async_add "Permalink to this definition")Asynchronous method to add nodes to Qdrant index.

Parameters**nodes** – List[BaseNode]: List of nodes with embeddings.

ReturnsList of node IDs that were added to the index.

Raises**ValueError** – If trying to using async methods without setting prefer\_grpc to True.

*classmethod* class\_name() → str[](#llama_index.vector_stores.QdrantVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.QdrantVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.QdrantVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.QdrantVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.QdrantVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.QdrantVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.QdrantVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.QdrantVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*collection\_name: str*, *url: Optional[str] = None*, *api\_key: Optional[str] = None*, *client\_kwargs: Optional[dict] = None*, *batch\_size: int = 100*, *prefer\_grpc: bool = False*, *\*\*kwargs: Any*) → [QdrantVectorStore](#llama_index.vector_stores.QdrantVectorStore "llama_index.vector_stores.qdrant.QdrantVectorStore")[](#llama_index.vector_stores.QdrantVectorStore.from_params "Permalink to this definition")Create a connection to a remote Qdrant vector store from a config.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.QdrantVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.QdrantVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.QdrantVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.QdrantVectorStore.parse_raw "Permalink to this definition")parse\_to\_query\_result(*response: List[Any]*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.QdrantVectorStore.parse_to_query_result "Permalink to this definition")Convert vector store response to VectorStoreQueryResult.

Parameters**response** – List[Any]: List of results returned from the vector store.

persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.QdrantVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.QdrantVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.QdrantVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.QdrantVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.QdrantVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.QdrantVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.QdrantVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.QdrantVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.QdrantVectorStore.client "Permalink to this definition")Return the Qdrant client.

*class* llama\_index.vector\_stores.RedisVectorStore(*index\_name: str*, *index\_prefix: str = 'llama\_index'*, *prefix\_ending: str = '/vector'*, *index\_args: Optional[Dict[str, Any]] = None*, *metadata\_fields: Optional[List[str]] = None*, *redis\_url: str = 'redis://localhost:6379'*, *overwrite: bool = False*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.RedisVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.RedisVectorStore.add "Permalink to this definition")Add nodes to the index.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddings

ReturnsList of ids of the documents added to the index.

Return typeList[str]

Raises**ValueError** – If the index already exists and overwrite is False.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.RedisVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.RedisVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.RedisVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: RedisType*[](#llama_index.vector_stores.RedisVectorStore.client "Permalink to this definition")Return the redis client instance.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.RedisVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

delete\_index() → None[](#llama_index.vector_stores.RedisVectorStore.delete_index "Permalink to this definition")Delete the index and all documents.

persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*, *in\_background: bool = True*) → None[](#llama_index.vector_stores.RedisVectorStore.persist "Permalink to this definition")Persist the vector store to disk.

Parameters* **persist\_path** (*str*) – Path to persist the vector store to. (doesn’t apply)
* **in\_background** (*bool**,* *optional*) – Persist in background. Defaults to True.
* **fs** (*fsspec.AbstractFileSystem**,* *optional*) – Filesystem to persist to.(doesn’t apply)
Raises**redis.exceptions.RedisError** – If there is an error persisting the index to disk.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.RedisVectorStore.query "Permalink to this definition")Query the index.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query object

Returnsquery result

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

Raises* **ValueError** – If query.query\_embedding is None.
* **redis.exceptions.RedisError** – If there is an error querying the index.
* **redis.exceptions.TimeoutError** – If there is a timeout querying the index.
* **ValueError** – If no documents are found when querying the index.
*class* llama\_index.vector\_stores.RocksetVectorStore(*collection: str*, *client: Any | None = None*, *text\_key: str = 'text'*, *embedding\_col: str = 'embedding'*, *metadata\_col: str = 'metadata'*, *workspace: str = 'commons'*, *api\_server: str | None = None*, *api\_key: str | None = None*, *distance\_func: [DistanceFunc](#llama_index.vector_stores.RocksetVectorStore.DistanceFunc "llama_index.vector_stores.RocksetVectorStore.DistanceFunc") = DistanceFunc.COSINE\_SIM*)[](#llama_index.vector_stores.RocksetVectorStore "Permalink to this definition")*class* DistanceFunc(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.vector_stores.RocksetVectorStore.DistanceFunc "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.RocksetVectorStore.add "Permalink to this definition")Stores vectors in the collection.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddings

ReturnsStored node IDs (List[str])

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.RocksetVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.RocksetVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.RocksetVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.RocksetVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.RocksetVectorStore.delete "Permalink to this definition")Deletes nodes stored in the collection by their ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The ref\_doc\_id of the documentwhose nodes are to be deleted

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.RocksetVectorStore.query "Permalink to this definition")Gets nodes relevant to a query.

Parameters* **query** ([*llama\_index.vector\_stores.types.VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")) – The query
* **similarity\_col** (*Optional**[**str**]*) – The column to select the cosinesimilarity as (default: “\_similarity”)
Returnsquery results (llama\_index.vector\_stores.types.VectorStoreQueryResult)

*classmethod* with\_new\_collection(*dimensions: int | None = None*, *\*\*rockset\_vector\_store\_args: Any*) → [RocksetVectorStore](#llama_index.vector_stores.RocksetVectorStore "llama_index.vector_stores.rocksetdb.RocksetVectorStore")[](#llama_index.vector_stores.RocksetVectorStore.with_new_collection "Permalink to this definition")Creates a new collection and returns its RocksetVectorStore.

Parameters* **dimensions** (*Optional**[**int**]*) – The length of the vectors to enforcein the collection’s ingest transformation. By default, thecollection will do no vector enforcement.
* **collection** (*str*) – The name of the collection to be created
* **client** (*Optional**[**Any**]*) – Rockset client object
* **workspace** (*str*) – The workspace containing the collection to becreated (default: “commons”)
* **text\_key** (*str*) – The key to the text of nodes(default: llama\_index.vector\_stores.utils.DEFAULT\_TEXT\_KEY)
* **embedding\_col** (*str*) – The DB column containing embeddings(default: llama\_index.vector\_stores.utils.DEFAULT\_EMBEDDING\_KEY))
* **metadata\_col** (*str*) – The DB column containing node metadata(default: “metadata”)
* **api\_server** (*Optional**[**str**]*) – The Rockset API server to use
* **api\_key** (*Optional**[**str**]*) – The Rockset API key to use
* **distance\_func** ([*RocksetVectorStore.DistanceFunc*](#llama_index.vector_stores.RocksetVectorStore.DistanceFunc "llama_index.vector_stores.RocksetVectorStore.DistanceFunc")) – The metric to measurevector relationship(default: RocksetVectorStore.DistanceFunc.COSINE\_SIM)
*class* llama\_index.vector\_stores.SimpleVectorStore(*data: Optional[SimpleVectorStoreData] = None*, *fs: Optional[AbstractFileSystem] = None*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.SimpleVectorStore "Permalink to this definition")Simple Vector Store.

In this vector store, embeddings are stored within a simple, in-memory dictionary.

Parameters**simple\_vector\_store\_data\_dict** (*Optional**[**dict**]*) – data dictcontaining the embeddings and doc\_ids. See SimpleVectorStoreDatafor more details.

add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.SimpleVectorStore.add "Permalink to this definition")Add nodes to index.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SimpleVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SimpleVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.SimpleVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: None*[](#llama_index.vector_stores.SimpleVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SimpleVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

*classmethod* from\_namespaced\_persist\_dir(*persist\_dir: str = './storage'*, *fs: Optional[AbstractFileSystem] = None*) → Dict[str, VectorStore][](#llama_index.vector_stores.SimpleVectorStore.from_namespaced_persist_dir "Permalink to this definition")Load from namespaced persist dir.

*classmethod* from\_persist\_dir(*persist\_dir: str = './storage'*, *namespace: Optional[str] = None*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleVectorStore](#llama_index.vector_stores.SimpleVectorStore "llama_index.vector_stores.simple.SimpleVectorStore")[](#llama_index.vector_stores.SimpleVectorStore.from_persist_dir "Permalink to this definition")Load from persist dir.

*classmethod* from\_persist\_path(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → [SimpleVectorStore](#llama_index.vector_stores.SimpleVectorStore "llama_index.vector_stores.simple.SimpleVectorStore")[](#llama_index.vector_stores.SimpleVectorStore.from_persist_path "Permalink to this definition")Create a SimpleKVStore from a persist directory.

get(*text\_id: str*) → List[float][](#llama_index.vector_stores.SimpleVectorStore.get "Permalink to this definition")Get embedding.

persist(*persist\_path: str = './storage/vector\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.SimpleVectorStore.persist "Permalink to this definition")Persist the SimpleVectorStore to a directory.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SimpleVectorStore.query "Permalink to this definition")Get nodes for response.

*class* llama\_index.vector\_stores.SingleStoreVectorStore(*table\_name: str = 'embeddings'*, *content\_field: str = 'content'*, *metadata\_field: str = 'metadata'*, *vector\_field: str = 'vector'*, *pool\_size: int = 5*, *max\_overflow: int = 10*, *timeout: float = 30*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.SingleStoreVectorStore "Permalink to this definition")SingleStore vector store.

This vector store stores embeddings within a SingleStore database table.

During query time, the index uses SingleStore to query for the topk most similar nodes.

Parameters* **table\_name** (*str**,* *optional*) – Specifies the name of the table in use.Defaults to “embeddings”.
* **content\_field** (*str**,* *optional*) – Specifies the field to store the content.Defaults to “content”.
* **metadata\_field** (*str**,* *optional*) – Specifies the field to store metadata.Defaults to “metadata”.
* **vector\_field** (*str**,* *optional*) – Specifies the field to store the vector.Defaults to “vector”.
* **pool** (*Following arguments pertain to the connection*) –
* **pool\_size** (*int**,* *optional*) – Determines the number of active connections inthe pool. Defaults to 5.
* **max\_overflow** (*int**,* *optional*) – Determines the maximum number of connectionsallowed beyond the pool\_size. Defaults to 10.
* **timeout** (*float**,* *optional*) – Specifies the maximum wait time in seconds forestablishing a connection. Defaults to 30.
* **connection** (*Following arguments pertain to the*) –
* **host** (*str**,* *optional*) – Specifies the hostname, IP address, or URL for thedatabase connection. The default scheme is “mysql”.
* **user** (*str**,* *optional*) – Database username.
* **password** (*str**,* *optional*) – Database password.
* **port** (*int**,* *optional*) – Database port. Defaults to 3306 for non-HTTPconnections, 80 for HTTP connections, and 443 for HTTPS connections.
* **database** (*str**,* *optional*) – Database name.
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.SingleStoreVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SingleStoreVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SingleStoreVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.SingleStoreVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.SingleStoreVectorStore.client "Permalink to this definition")Return SingleStoreDB client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SingleStoreVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *filter: Optional[dict] = None*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SingleStoreVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – Contains query\_embedding and similarity\_top\_k attributes.
* **filter** (*Optional**[**dict**]*) – A dictionary of metadata fields and values to filter by. Defaults to None.
ReturnsContains nodes, similarities, and ids attributes.

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

*class* llama\_index.vector\_stores.SupabaseVectorStore(*postgres\_connection\_string: str*, *collection\_name: str*, *dimension: int = 1536*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.SupabaseVectorStore "Permalink to this definition")Supbabase Vector.

In this vector store, embeddings are stored in Postgres table using pgvector.

During query time, the index uses pgvector/Supabase to query for the topk most similar nodes.

Parameters* **postgres\_connection\_string** (*str*) – postgres connection string
* **collection\_name** (*str*) – name of the collection to store the embeddings in
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.SupabaseVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SupabaseVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SupabaseVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.SupabaseVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: None*[](#llama_index.vector_stores.SupabaseVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.SupabaseVectorStore.delete "Permalink to this definition")Delete doc.

:param : param ref\_doc\_id (str): document id

get\_by\_id(*doc\_id: str*, *\*\*kwargs: Any*) → list[](#llama_index.vector_stores.SupabaseVectorStore.get_by_id "Permalink to this definition")Get row ids by doc id.

Parameters**doc\_id** (*str*) – document id

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.SupabaseVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters**query** (*List**[**float**]*) – query embedding

*class* llama\_index.vector\_stores.TairVectorStore(*tair\_url: str*, *index\_name: str*, *index\_type: str = 'HNSW'*, *index\_args: Optional[Dict[str, Any]] = None*, *overwrite: bool = False*, *\*\*kwargs: Any*)[](#llama_index.vector_stores.TairVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.TairVectorStore.add "Permalink to this definition")Add nodes to the index.

Parameters**nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – List of nodes with embeddings

ReturnsList of ids of the documents added to the index.

Return typeList[str]

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TairVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TairVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.TairVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Tair*[](#llama_index.vector_stores.TairVectorStore.client "Permalink to this definition")Return the Tair client instance.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TairVectorStore.delete "Permalink to this definition")Delete a document.

Parameters**doc\_id** (*str*) – document id

delete\_index() → None[](#llama_index.vector_stores.TairVectorStore.delete_index "Permalink to this definition")Delete the index and all documents.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TairVectorStore.query "Permalink to this definition")Query the index.

Parameters**query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – query object

Returnsquery result

Return type[VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.VectorStoreQueryResult")

Raises**ValueError** – If query.query\_embedding is None.

*class* llama\_index.vector\_stores.TencentVectorDB(*url: str*, *key: str*, *username: str = 'root'*, *database\_name: str = 'llama\_default\_database'*, *read\_consistency: str = 'eventualConsistency'*, *collection\_params: ~llama\_index.vector\_stores.tencentvectordb.CollectionParams = <llama\_index.vector\_stores.tencentvectordb.CollectionParams object>*, *batch\_size: int = 512*, *\*\*kwargs: ~typing.Any*)[](#llama_index.vector_stores.TencentVectorDB "Permalink to this definition")Tencent Vector Store.

In this vector store, embeddings and docs are stored within a Collection.If the Collection does not exist, it will be automatically created.

In order to use this you need to have a database instance.See the following documentation for details:<https://cloud.tencent.com/document/product/1709/94951>

Parameters* **url** (*Optional**[**str**]*) – url of Tencent vector database
* **username** (*Optional**[**str**]*) – The username for Tencent vector database. Default value is “root”
* **key** (*Optional**[**str**]*) – The Api-Key for Tencent vector database
* **collection\_params** (*Optional**[**CollectionParams**]*) – The collection parameters for vector database
add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.TencentVectorDB.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TencentVectorDB.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TencentVectorDB.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*kwargs: Any*) → List[str][](#llama_index.vector_stores.TencentVectorDB.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.TencentVectorDB.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TencentVectorDB.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id or ids.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TencentVectorDB.query "Permalink to this definition")Query index for top k most similar nodes.

Parameters* **query** ([*VectorStoreQuery*](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.VectorStoreQuery")) – containsquery\_embedding (List[float]): query embeddingsimilarity\_top\_k (int): top k most similar nodesdoc\_ids (Optional[List[str]]): filter by doc\_idfilters (Optional[MetadataFilters]): filter result
* **kwargs.filter** (*Optional**[**str**|**Filter**]*) –
* **kwargs** (*if kwargs in*) – using filter: age > 20 and author in (…) and …
* **query.filters** (*elif*) – using filter: ” and “.join([f’{f.key} = “{f.value}”’ for f in query.filters.filters])
* **query.doc\_ids** (*elif*) – using filter: doc\_id in (query.doc\_ids)
*class* llama\_index.vector\_stores.TimescaleVectorStore(*service\_url: str*, *table\_name: str*, *num\_dimensions: int = 1536*, *time\_partition\_interval: Optional[timedelta] = None*)[](#llama_index.vector_stores.TimescaleVectorStore "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.TimescaleVectorStore.add "Permalink to this definition")Add nodes with embedding to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TimescaleVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TimescaleVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.TimescaleVectorStore.async_add "Permalink to this definition")Asynchronously add nodes with embedding to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*property* client*: Any*[](#llama_index.vector_stores.TimescaleVectorStore.client "Permalink to this definition")Get client.

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.TimescaleVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.TimescaleVectorStore.query "Permalink to this definition")Query vector store.

*class* llama\_index.vector\_stores.VectorStoreQuery(*query\_embedding: Optional[List[float]] = None*, *similarity\_top\_k: int = 1*, *doc\_ids: Optional[List[str]] = None*, *node\_ids: Optional[List[str]] = None*, *query\_str: Optional[str] = None*, *output\_fields: Optional[List[str]] = None*, *embedding\_field: Optional[str] = None*, *mode: [VectorStoreQueryMode](../query/retrievers/vector_store.html#llama_index.vector_stores.types.VectorStoreQueryMode "llama_index.vector_stores.types.VectorStoreQueryMode") = VectorStoreQueryMode.DEFAULT*, *alpha: Optional[float] = None*, *filters: Optional[[MetadataFilters](../query/retrievers/vector_store.html#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")] = None*, *mmr\_threshold: Optional[float] = None*, *sparse\_top\_k: Optional[int] = None*)[](#llama_index.vector_stores.VectorStoreQuery "Permalink to this definition")Vector store query.

*class* llama\_index.vector\_stores.VectorStoreQueryResult(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *similarities: Optional[List[float]] = None*, *ids: Optional[List[str]] = None*)[](#llama_index.vector_stores.VectorStoreQueryResult "Permalink to this definition")Vector store query result.

*pydantic model* llama\_index.vector\_stores.WeaviateVectorStore[](#llama_index.vector_stores.WeaviateVectorStore "Permalink to this definition")Weaviate vector store.

In this vector store, embeddings and docs are stored within aWeaviate collection.

During query time, the index uses Weaviate to query for the topk most similar nodes.

Parameters* **weaviate\_client** (*weaviate.Client*) – WeaviateClientinstance from weaviate-client package
* **index\_name** (*Optional**[**str**]*) – name for Weaviate classes
Show JSON schema
```
{ "title": "WeaviateVectorStore", "description": "Weaviate vector store.\n\nIn this vector store, embeddings and docs are stored within a\nWeaviate collection.\n\nDuring query time, the index uses Weaviate to query for the top\nk most similar nodes.\n\nArgs:\n weaviate\_client (weaviate.Client): WeaviateClient\n instance from `weaviate-client` package\n index\_name (Optional[str]): name for Weaviate classes", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "default": true, "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" }, "index\_name": { "title": "Index Name", "type": "string" }, "url": { "title": "Url", "type": "string" }, "text\_key": { "title": "Text Key", "type": "string" }, "auth\_config": { "title": "Auth Config", "type": "object" }, "client\_kwargs": { "title": "Client Kwargs", "type": "object" } }, "required": [ "index\_name", "text\_key" ]}
```


Fields* `auth\_config (Dict[str, Any])`
* `client\_kwargs (Dict[str, Any])`
* `index\_name (str)`
* `is\_embedding\_query (bool)`
* `stores\_text (bool)`
* `text\_key (str)`
* `url (Optional[str])`
*field* auth\_config*: Dict[str, Any]* *[Optional]*[](#llama_index.vector_stores.WeaviateVectorStore.auth_config "Permalink to this definition")*field* client\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.vector_stores.WeaviateVectorStore.client_kwargs "Permalink to this definition")*field* index\_name*: str* *[Required]*[](#llama_index.vector_stores.WeaviateVectorStore.index_name "Permalink to this definition")*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.WeaviateVectorStore.is_embedding_query "Permalink to this definition")*field* stores\_text*: bool* *= True*[](#llama_index.vector_stores.WeaviateVectorStore.stores_text "Permalink to this definition")*field* text\_key*: str* *[Required]*[](#llama_index.vector_stores.WeaviateVectorStore.text_key "Permalink to this definition")*field* url*: Optional[str]* *= None*[](#llama_index.vector_stores.WeaviateVectorStore.url "Permalink to this definition")add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*add\_kwargs: Any*) → List[str][](#llama_index.vector_stores.WeaviateVectorStore.add "Permalink to this definition")Add nodes to index.

Parameters**nodes** – List[BaseNode]: list of nodes with embeddings

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.WeaviateVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.WeaviateVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.WeaviateVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*classmethod* class\_name() → str[](#llama_index.vector_stores.WeaviateVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.WeaviateVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

Parameters**ref\_doc\_id** (*str*) – The doc\_id of the document to delete.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.WeaviateVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.WeaviateVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.WeaviateVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.from_orm "Permalink to this definition")*classmethod* from\_params(*url: str*, *auth\_config: Any*, *index\_name: Optional[str] = None*, *text\_key: str = 'text'*, *client\_kwargs: Optional[Dict[str, Any]] = None*, *\*\*kwargs: Any*) → [WeaviateVectorStore](#llama_index.vector_stores.WeaviateVectorStore "llama_index.vector_stores.weaviate.WeaviateVectorStore")[](#llama_index.vector_stores.WeaviateVectorStore.from_params "Permalink to this definition")Create WeaviateVectorStore from config.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.WeaviateVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.WeaviateVectorStore.persist "Permalink to this definition")query(*query: [VectorStoreQuery](#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.WeaviateVectorStore.query "Permalink to this definition")Query index for top k most similar nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.WeaviateVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.WeaviateVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.WeaviateVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.WeaviateVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.WeaviateVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.WeaviateVectorStore.validate "Permalink to this definition")*property* client*: Any*[](#llama_index.vector_stores.WeaviateVectorStore.client "Permalink to this definition")Get client.

