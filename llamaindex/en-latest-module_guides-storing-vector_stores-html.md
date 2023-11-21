Vector Stores[](#vector-stores "Permalink to this heading")
============================================================

Vector stores contain embedding vectors of ingested document chunks(and sometimes the document chunks as well).

Simple Vector Store[](#simple-vector-store "Permalink to this heading")
------------------------------------------------------------------------

By default, LlamaIndex uses a simple in-memory vector store that’s great for quick experimentation.They can be persisted to (and loaded from) disk by calling `vector\_store.persist()` (and `SimpleVectorStore.from\_persist\_path(...)` respectively).

Vector Store Options & Feature Support[](#vector-store-options-feature-support "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

LlamaIndex supports over 20 different vector store options.We are actively adding more integrations and improving feature coverage for each.



| Vector Store | Type | Metadata Filtering | Hybrid Search | Delete | Store Documents | Async |
| --- | --- | --- | --- | --- | --- | --- |
| Apache Cassandra® | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Astra DB | cloud | ✓ |  | ✓ | ✓ |  |
| Azure Cognitive Search | cloud |  | ✓ | ✓ | ✓ |  |
| Azure CosmosDB MongoDB | cloud |  |  | ✓ | ✓ |  |
| ChatGPT Retrieval Plugin | aggregator |  |  | ✓ | ✓ |  |
| Chroma | self-hosted | ✓ |  | ✓ | ✓ |  |
| DashVector | cloud | ✓ |  | ✓ | ✓ |  |
| Deeplake | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| DocArray | aggregator | ✓ |  | ✓ | ✓ |  |
| DynamoDB | cloud |  |  | ✓ |  |  |
| Elasticsearch | self-hosted / cloud | ✓ | ✓ | ✓ | ✓ | ✓ |
| FAISS | in-memory |  |  |  |  |  |
| LanceDB | cloud | ✓ |  | ✓ | ✓ |  |
| Lantern | self-hosted / cloud | ✓ | ✓ | ✓ | ✓ | ✓ |
| Metal | cloud | ✓ |  | ✓ | ✓ |  |
| MongoDB Atlas | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| MyScale | cloud | ✓ | ✓ | ✓ | ✓ |  |
| Milvus / Zilliz | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Neo4jVector | self-hosted / cloud |  |  | ✓ | ✓ |  |
| OpenSearch | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Pinecone | cloud | ✓ | ✓ | ✓ | ✓ |  |
| Postgres | self-hosted / cloud | ✓ | ✓ | ✓ | ✓ | ✓ |
| Qdrant | self-hosted / cloud | ✓ |  | ✓ | ✓ | ✓ |
| Redis | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Simple | in-memory | ✓ |  | ✓ |  |  |
| SingleStore | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Supabase | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Tair | cloud | ✓ |  | ✓ | ✓ |  |
| TencentVectorDB | cloud | ✓ | ✓ | ✓ | ✓ |  |
| Timescale |  | ✓ |  | ✓ | ✓ | ✓ |
| Typesense | self-hosted / cloud | ✓ |  | ✓ | ✓ |  |
| Weaviate | self-hosted / cloud | ✓ | ✓ | ✓ | ✓ |  |

For more details, see [Vector Store Integrations](../../community/integrations/vector_stores.html).

Examples

* [Astra DB](../../examples/vector_stores/AstraDBIndexDemo.html)
* [Simple Vector Store - Async Index Creation](../../examples/vector_stores/AsyncIndexCreationDemo.html)
* [Azure CosmosDB MongoDB Vector Store](../../examples/vector_stores/AzureCosmosDBMongoDBvCoreDemo.html)
* [Cassandra Vector Store](../../examples/vector_stores/CassandraIndexDemo.html)
* [Chroma](../../examples/vector_stores/ChromaIndexDemo.html)
* [Azure Cognitive Search](../../examples/vector_stores/CognitiveSearchIndexDemo.html)
* [Basic Example](../../examples/vector_stores/CognitiveSearchIndexDemo.html#basic-example)
* [Create Index (if it does not exist)](../../examples/vector_stores/CognitiveSearchIndexDemo.html#create-index-if-it-does-not-exist)
* [Use Existing Index](../../examples/vector_stores/CognitiveSearchIndexDemo.html#use-existing-index)
* [Adding a document to existing index](../../examples/vector_stores/CognitiveSearchIndexDemo.html#adding-a-document-to-existing-index)
* [Filtering](../../examples/vector_stores/CognitiveSearchIndexDemo.html#filtering)
* [DashVector Vector Store](../../examples/vector_stores/DashvectorIndexDemo.html)
* [DeepLake Vector Store](../../examples/vector_stores/DeepLakeIndexDemo.html)
* [DocArray Hnsw Vector Store](../../examples/vector_stores/DocArrayHnswIndexDemo.html)
* [DocArray InMemory Vector Store](../../examples/vector_stores/DocArrayInMemoryIndexDemo.html)
* [Epsilla Vector Store](../../examples/vector_stores/EpsillaIndexDemo.html)
* [LanceDB Vector Store](../../examples/vector_stores/LanceDBIndexDemo.html)
* [Metal Vector Store](../../examples/vector_stores/MetalIndexDemo.html)
* [Milvus Vector Store](../../examples/vector_stores/MilvusIndexDemo.html)
* [MyScale Vector Store](../../examples/vector_stores/MyScaleIndexDemo.html)
* [Elasticsearch Vector Store](../../examples/vector_stores/ElasticsearchIndexDemo.html)
* [Faiss Vector Store](../../examples/vector_stores/FaissIndexDemo.html)
* [MongoDB Atlas](../../examples/vector_stores/MongoDBAtlasVectorSearch.html)
* [Neo4j vector store](../../examples/vector_stores/Neo4jVectorDemo.html)
* [Opensearch Vector Store](../../examples/vector_stores/OpensearchDemo.html)
* [Pinecone Vector Store](../../examples/vector_stores/PineconeIndexDemo.html)
* [Pinecone Vector Store - Hybrid Search](../../examples/vector_stores/PineconeIndexDemo-Hybrid.html)
* [Redis Vector Store](../../examples/vector_stores/RedisIndexDemo.html)
* [Query the data](../../examples/vector_stores/RedisIndexDemo.html#query-the-data)
* [Working with Metadata](../../examples/vector_stores/RedisIndexDemo.html#working-with-metadata)
* [Qdrant Vector Store](../../examples/vector_stores/QdrantIndexDemo.html)
* [Rockset Vector Store](../../examples/vector_stores/RocksetIndexDemo.html)
* [Simple Vector Store](../../examples/vector_stores/SimpleIndexDemo.html)
* [Supabase Vector Store](../../examples/vector_stores/SupabaseVectorIndexDemo.html)
* [Tair Vector Store](../../examples/vector_stores/TairIndexDemo.html)
* [Tencent Cloud VectorDB](../../examples/vector_stores/TencentVectorDBIndexDemo.html)
* [Timescale Vector Store (PostgreSQL)](../../examples/vector_stores/Timescalevector.html)
* [Weaviate Vector Store](../../examples/vector_stores/WeaviateIndexDemo.html)
* [Weaviate Vector Store - Hybrid Search](../../examples/vector_stores/WeaviateIndexDemo-Hybrid.html)
* [Zep Vector Store](../../examples/vector_stores/ZepIndexDemo.html)
* [Create a Zep Vector Store and Index](../../examples/vector_stores/ZepIndexDemo.html#create-a-zep-vector-store-and-index)
* [Querying with Metadata filters](../../examples/vector_stores/ZepIndexDemo.html#querying-with-metadata-filters)
