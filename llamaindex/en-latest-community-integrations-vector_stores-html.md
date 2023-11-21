Using Vector Stores[](#using-vector-stores "Permalink to this heading")
========================================================================

LlamaIndex offers multiple integration points with vector stores / vector databases:

1. LlamaIndex can use a vector store itself as an index. Like any other index, this index can store documents and be used to answer queries.
2. LlamaIndex can load data from vector stores, similar to any other data connector. This data can then be used within LlamaIndex data structures.

Using a Vector Store as an Index[](#using-a-vector-store-as-an-index "Permalink to this heading")
--------------------------------------------------------------------------------------------------

LlamaIndex also supports different vector storesas the storage backend for `VectorStoreIndex`.

* Apache Cassandra® and Astra DB through CQL (`CassandraVectorStore`). [Installation](https://cassandra.apache.org/doc/stable/cassandra/getting_started/installing.html) [Quickstart](https://docs.datastax.com/en/astra-serverless/docs/vector-search/overview.html)
* Astra DB (`AstraDBVectorStore`). [Quickstart](https://docs.datastax.com/en/astra/home/astra.html).
* Azure Cognitive Search (`CognitiveSearchVectorStore`). [Quickstart](https://learn.microsoft.com/en-us/azure/search/search-get-started-vector)
* Chroma (`ChromaVectorStore`) [Installation](https://docs.trychroma.com/getting-started)
* DashVector (`DashVectorStore`). [Installation](https://help.aliyun.com/document_detail/2510230.html).
* DeepLake (`DeepLakeVectorStore`) [Installation](https://docs.deeplake.ai/en/latest/Installation.html)
* DocArray (`DocArrayHnswVectorStore`, `DocArrayInMemoryVectorStore`). [Installation/Python Client](https://github.com/docarray/docarray#installation).
* Elasticsearch (`ElasticsearchStore`) [Installation](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
* Epsilla (`EpsillaVectorStore`) [Installation/Quickstart](https://epsilla-inc.gitbook.io/epsilladb/quick-start)
* Faiss (`FaissVectorStore`). [Installation](https://github.com/facebookresearch/faiss/blob/main/INSTALL.md).
* Lantern (`LanternVectorStore`). [Quickstart](https://docs.lantern.dev/get-started/overview).
* Milvus (`MilvusVectorStore`). [Installation](https://milvus.io/docs)
* MongoDB Atlas (`MongoDBAtlasVectorSearch`). [Installation/Quickstart](https://www.mongodb.com/atlas/database).
* MyScale (`MyScaleVectorStore`). [Quickstart](https://docs.myscale.com/en/quickstart/). [Installation/Python Client](https://docs.myscale.com/en/python-client/).
* Neo4j (`Neo4jVectorIndex`). [Installation](https://neo4j.com/docs/operations-manual/current/installation/).
* Pinecone (`PineconeVectorStore`). [Installation/Quickstart](https://docs.pinecone.io/docs/quickstart).
* Qdrant (`QdrantVectorStore`) [Installation](https://qdrant.tech/documentation/install/) [Python Client](https://qdrant.tech/documentation/install/#python-client)
* Redis (`RedisVectorStore`). [Installation](https://redis.io/docs/getting-started/installation/).
* Supabase (`SupabaseVectorStore`). [Quickstart](https://supabase.github.io/vecs/api/).
* TimeScale (`TimescaleVectorStore`). [Installation](https://github.com/timescale/python-vector).
* Weaviate (`WeaviateVectorStore`). [Installation](https://weaviate.io/developers/weaviate/installation). [Python Client](https://weaviate.io/developers/weaviate/client-libraries/python).
* Zep (`ZepVectorStore`). [Installation](https://docs.getzep.com/deployment/quickstart/). [Python Client](https://docs.getzep.com/sdk/).
* Zilliz (`MilvusVectorStore`). [Quickstart](https://zilliz.com/doc/quick_start)

A detailed API reference is [found here](../../api_reference/indices/vector_store.html).

Similar to any other index within LlamaIndex (tree, keyword table, list), `VectorStoreIndex` can be constructed upon any collectionof documents. We use the vector store within the index to store embeddings for the input text chunks.

Once constructed, the index can be used for querying.

**Default Vector Store Index Construction/Querying**

By default, `VectorStoreIndex` uses a in-memory `SimpleVectorStore`that’s initialized as part of the default storage context.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader# Load documents and build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectorStoreIndex.from\_documents(documents)# Query indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```
**Custom Vector Store Index Construction/Querying**

We can query over a custom vector store as follows:


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, StorageContextfrom llama\_index.vector\_stores import DeepLakeVectorStore# construct vector store and customize storage contextstorage\_context = StorageContext.from\_defaults(    vector\_store=DeepLakeVectorStore(dataset\_path="<dataset\_path>"))# Load documents and build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# Query indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```
Below we show more examples of how to construct various vector stores we support.

**Apache Cassandra®**


```
from llama\_index.vector\_stores import CassandraVectorStoreimport cassio# To use an Astra DB cloud instance through CQL:cassio.init(database\_id="1234abcd-...", token="AstraCS:...")# For a Cassandra cluster:from cassandra.cluster import Clustercluster = Cluster(["127.0.0.1"])cassio.init(session=cluster.connect(), keyspace="my\_keyspace")# After the above `cassio.init(...)`, create a vector store:vector\_store = CassandraVectorStore(    table="cass\_v\_table", embedding\_dimension=1536)
```
**Astra DB**


```
from llama\_index.vector\_stores import AstraDBVectorStoreastra\_db\_store = AstraDBVectorStore(    token="AstraCS:xY3b...",  # Your Astra DB token    api\_endpoint="https://012...abc-us-east1.apps.astra.datastax.com",  # Your Astra DB API endpoint    collection\_name="astra\_v\_table",  # Table name of your choice    embedding\_dimension=1536,  # Embedding dimension of the embeddings model used)
```
**Azure Cognitive Search**


```
from azure.search.documents import SearchClientfrom llama\_index.vector\_stores import ChromaVectorStorefrom azure.core.credentials import AzureKeyCredentialservice\_endpoint = f"https://{search\_service\_name}.search.windows.net"index\_name = "quickstart"cognitive\_search\_credential = AzureKeyCredential("<API key>")search\_client = SearchClient(    endpoint=service\_endpoint,    index\_name=index\_name,    credential=cognitive\_search\_credential,)# construct vector storevector\_store = CognitiveSearchVectorStore(    search\_client,    id\_field\_key="id",    chunk\_field\_key="content",    embedding\_field\_key="embedding",    metadata\_field\_key="li\_jsonMetadata",    doc\_id\_field\_key="li\_doc\_id",)
```
**Chroma**


```
import chromadbfrom llama\_index.vector\_stores import ChromaVectorStore# Creating a Chroma client# EphemeralClient operates purely in-memory, PersistentClient will also save to diskchroma\_client = chromadb.EphemeralClient()chroma\_collection = chroma\_client.create\_collection("quickstart")# construct vector storevector\_store = ChromaVectorStore(    chroma\_collection=chroma\_collection,)
```
**DashVector**


```
import dashvectorfrom llama\_index.vector\_stores import DashVectorStore# init dashvector clientclient = dashvector.Client(api\_key="your-dashvector-api-key")# creating a DashVector collectionclient.create("quickstart", dimension=1536)collection = client.get("quickstart")# construct vector storevector\_store = DashVectorStore(collection)
```
**DeepLake**


```
import osimport getpathfrom llama\_index.vector\_stores import DeepLakeVectorStoreos.environ["OPENAI\_API\_KEY"] = getpath.getpath("OPENAI\_API\_KEY: ")os.environ["ACTIVELOOP\_TOKEN"] = getpath.getpath("ACTIVELOOP\_TOKEN: ")dataset\_path = "hub://adilkhan/paul\_graham\_essay"# construct vector storevector\_store = DeepLakeVectorStore(dataset\_path=dataset\_path, overwrite=True)
```
**DocArray**


```
from llama\_index.vector\_stores import (    DocArrayHnswVectorStore,    DocArrayInMemoryVectorStore,)# construct vector storevector\_store = DocArrayHnswVectorStore(work\_dir="hnsw\_index")# alternatively, construct the in-memory vector storevector\_store = DocArrayInMemoryVectorStore()
```
**Elasticsearch**

First, you can start Elasticsearch either locally or on [Elastic cloud](https://cloud.elastic.co/registration?utm_source=llama-index&amp;utm_content=documentation).

To start Elasticsearch locally with docker, run the following command:


```
docker run -p 9200:9200 \ -e "discovery.type=single-node" \ -e "xpack.security.enabled=false" \ -e "xpack.security.http.ssl.enabled=false" \ -e "xpack.license.self\_generated.type=trial" \ docker.elastic.co/elasticsearch/elasticsearch:8.9.0
```
Then connect and use Elasticsearch as a vector database with LlamaIndex


```
from llama\_index.vector\_stores import ElasticsearchStorevector\_store = ElasticsearchStore(    index\_name="llm-project",    es\_url="http://localhost:9200",    # Cloud connection options:    # es\_cloud\_id="<cloud\_id>",    # es\_user="elastic",    # es\_password="<password>",)
```
This can be used with the `VectorStoreIndex` to provide a query interface for retrieval, querying, deleting, persisting the index, and more.

**Epsilla**


```
from pyepsilla import vectordbfrom llama\_index.vector\_stores import EpsillaVectorStore# Creating an Epsilla clientepsilla\_client = vectordb.Client()# Construct vector storevector\_store = EpsillaVectorStore(client=epsilla\_client)
```
**Note**: `EpsillaVectorStore` depends on the `pyepsilla` library and a running Epsilla vector database.Use `pip/pip3 install pyepsilla` if not installed yet.A running Epsilla vector database could be found through docker image.For complete instructions, see the following documentation:https://epsilla-inc.gitbook.io/epsilladb/quick-start

**Faiss**


```
import faissfrom llama\_index.vector\_stores import FaissVectorStore# create faiss indexd = 1536faiss\_index = faiss.IndexFlatL2(d)# construct vector storevector\_store = FaissVectorStore(faiss\_index)...# NOTE: since faiss index is in-memory, we need to explicitly call# vector\_store.persist() or storage\_context.persist() to save it to disk.# persist() takes in optional arg persist\_path. If none give, will use default paths.storage\_context.persist()
```
**Milvus**

* Milvus Index offers the ability to store both Documents and their embeddings.


```
import pymilvusfrom llama\_index.vector\_stores import MilvusVectorStore# construct vector storevector\_store = MilvusVectorStore(    uri="https://localhost:19530", overwrite="True")
```
**Note**: `MilvusVectorStore` depends on the `pymilvus` library.Use `pip install pymilvus` if not already installed.If you get stuck at building wheel for `grpcio`, check if you are using python 3.11(there’s a known issue: https://github.com/milvus-io/pymilvus/issues/1308)and try downgrading.

**MongoDBAtlas**


```
# Provide URI to constructor, or use environment variableimport pymongofrom llama\_index.vector\_stores.mongodb import MongoDBAtlasVectorSearchfrom llama\_index.indices.vector\_store.base import VectorStoreIndexfrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.readers.file.base import SimpleDirectoryReader# mongo\_uri = os.environ["MONGO\_URI"]mongo\_uri = (    "mongodb+srv://<username>:<password>@<host>?retryWrites=true&w=majority")mongodb\_client = pymongo.MongoClient(mongo\_uri)# construct storestore = MongoDBAtlasVectorSearch(mongodb\_client)storage\_context = StorageContext.from\_defaults(vector\_store=store)uber\_docs = SimpleDirectoryReader(    input\_files=["../data/10k/uber\_2021.pdf"]).load\_data()# construct indexindex = VectorStoreIndex.from\_documents(    uber\_docs, storage\_context=storage\_context)
```
**MyScale**


```
import clickhouse\_connectfrom llama\_index.vector\_stores import MyScaleVectorStore# Creating a MyScale clientclient = clickhouse\_connect.get\_client(    host="YOUR\_CLUSTER\_HOST",    port=8443,    username="YOUR\_USERNAME",    password="YOUR\_CLUSTER\_PASSWORD",)# construct vector storevector\_store = MyScaleVectorStore(myscale\_client=client)
```
**Neo4j**

* Neo4j stores texts, metadata, and embeddings and can be customized to return graph data in the form of metadata.


```
from llama\_index.vector\_stores import Neo4jVectorStore# construct vector storeneo4j\_vector = Neo4jVectorStore(    username="neo4j",    password="pleaseletmein",    url="bolt://localhost:7687",    embed\_dim=1536,)
```
**Pinecone**


```
import pineconefrom llama\_index.vector\_stores import PineconeVectorStore# Creating a Pinecone indexapi\_key = "api\_key"pinecone.init(api\_key=api\_key, environment="us-west1-gcp")pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")index = pinecone.Index("quickstart")# can define filters specific to this vector index (so you can# reuse pinecone indexes)metadata\_filters = {"title": "paul\_graham\_essay"}# construct vector storevector\_store = PineconeVectorStore(    pinecone\_index=index, metadata\_filters=metadata\_filters)
```
**Qdrant**


```
import qdrant\_clientfrom llama\_index.vector\_stores import QdrantVectorStore# Creating a Qdrant vector storeclient = qdrant\_client.QdrantClient(    host="<qdrant-host>", api\_key="<qdrant-api-key>", https=True)collection\_name = "paul\_graham"# construct vector storevector\_store = QdrantVectorStore(    client=client,    collection\_name=collection\_name,)
```
**Redis**

First, start Redis-Stack (or get url from Redis provider)


```
docker run --name redis-vecdb -d -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
```
Then connect and use Redis as a vector database with LlamaIndex


```
from llama\_index.vector\_stores import RedisVectorStorevector\_store = RedisVectorStore(    index\_name="llm-project",    redis\_url="redis://localhost:6379",    overwrite=True,)
```
This can be used with the `VectorStoreIndex` to provide a query interface for retrieval, querying, deleting, persisting the index, and more.

**SingleStore**


```
from llama\_index.vector\_stores import SingleStoreVectorStoreimport os# can set the singlestore db url in env# or pass it in as an argument to the SingleStoreVectorStore constructoros.environ["SINGLESTOREDB\_URL"] = "PLACEHOLDER URL"vector\_store = SingleStoreVectorStore(    table\_name="embeddings",    content\_field="content",    metadata\_field="metadata",    vector\_field="vector",    timeout=30,)
```
**Timescale**


```
from llama\_index.vector\_stores import TimescaleVectorStorevector\_store = TimescaleVectorStore.from\_params(    service\_url="YOUR TIMESCALE SERVICE URL",    table\_name="paul\_graham\_essay",)
```
**Weaviate**


```
import weaviatefrom llama\_index.vector\_stores import WeaviateVectorStore# creating a Weaviate clientresource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)client = weaviate.Client(    "https://<cluster-id>.semi.network/",    auth\_client\_secret=resource\_owner\_config,)# construct vector storevector\_store = WeaviateVectorStore(weaviate\_client=client)
```
**Zep**

Zep stores texts, metadata, and embeddings. All are returned in search results.


```
from llama\_index.vector\_stores.zep import ZepVectorStorevector\_store = ZepVectorStore(    api\_url="<api\_url>",    api\_key="<api\_key>",    collection\_name="<unique\_collection\_name>",  # Can either be an existing collection or a new one    embedding\_dimensions=1536,  # Optional, required if creating a new collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# Query index using both a text query and metadata filtersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])retriever = index.as\_retriever(filters=filters)result = retriever.retrieve("What is inception about?")
```
**Zilliz**

* Zilliz Cloud (hosted version of Milvus) uses the Milvus Index with some extra arguments.


```
import pymilvusfrom llama\_index.vector\_stores import MilvusVectorStore# construct vector storevector\_store = MilvusVectorStore(    uri="foo.vectordb.zillizcloud.com",    token="your\_token\_here",    overwrite="True",)
```
[Example notebooks can be found here](https://github.com/jerryjliu/llama_index/tree/main/docs/examples/vector_stores).

Loading Data from Vector Stores using Data Connector[](#loading-data-from-vector-stores-using-data-connector "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------

LlamaIndex supports loading data from a huge number of sources. See [Data Connectors](../../module_guides/loading/connector/modules.html) for more details and API documentation.

Chroma stores both documents and vectors. This is an example of how to use Chroma:


```
from llama\_index.readers.chroma import ChromaReaderfrom llama\_index.indices import SummaryIndex# The chroma reader loads data from a persisted Chroma collection.# This requires a collection name and a persist directory.reader = ChromaReader(    collection\_name="chroma\_collection",    persist\_directory="examples/data\_connectors/chroma\_collection",)query\_vector = [n1, n2, n3, ...]documents = reader.load\_data(    collection\_name="demo", query\_vector=query\_vector, limit=5)index = SummaryIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")display(Markdown(f"<b>{response}</b>"))
```
Qdrant also stores both documents and vectors. This is an example of how to use Qdrant:


```
from llama\_index.readers.qdrant import QdrantReaderreader = QdrantReader(host="localhost")# the query\_vector is an embedding representation of your query\_vector# Example query\_vector# query\_vector = [0.3, 0.3, 0.3, 0.3, ...]query\_vector = [n1, n2, n3, ...]# NOTE: Required args are collection\_name, query\_vector.# See the Python client: https;//github.com/qdrant/qdrant\_client# for more detailsdocuments = reader.load\_data(    collection\_name="demo", query\_vector=query\_vector, limit=5)
```
NOTE: Since Weaviate can store a hybrid of document and vector objects, the user may either choose to explicitly specify `class\_name` and `properties` in order to query documents, or they may choose to specify a raw GraphQL query. See below for usage.


```
# option 1: specify class\_name and properties# 1) load data using class\_name and propertiesdocuments = reader.load\_data(    class\_name="<class\_name>",    properties=["property1", "property2", "..."],    separate\_documents=True,)# 2) example GraphQL queryquery = """{ Get { <class\_name> { <property1> <property2> } }}"""documents = reader.load\_data(graphql\_query=query, separate\_documents=True)
```
NOTE: Both Pinecone and Faiss data loaders assume that the respective data sources only store vectors; text content is stored elsewhere. Therefore, both data loaders require that the user specifies an `id\_to\_text\_map` in the load\_data call.

For instance, this is an example usage of the Pinecone data loader `PineconeReader`:


```
from llama\_index.readers.pinecone import PineconeReaderreader = PineconeReader(api\_key=api\_key, environment="us-west1-gcp")id\_to\_text\_map = {    "id1": "text blob 1",    "id2": "text blob 2",}query\_vector = [n1, n2, n3, ...]documents = reader.load\_data(    index\_name="quickstart",    id\_to\_text\_map=id\_to\_text\_map,    top\_k=3,    vector=query\_vector,    separate\_documents=True,)
```
[Example notebooks can be found here](https://github.com/jerryjliu/llama_index/tree/main/docs/examples/data_connectors).

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
