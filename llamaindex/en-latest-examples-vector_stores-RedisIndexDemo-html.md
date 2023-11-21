[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/RedisIndexDemo.ipynb)

Redis Vector Store[](#redis-vector-store "Permalink to this heading")
======================================================================

In this notebook we are going to show a quick demo of using the RedisVectorStore.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport sysimport loggingimport textwrapimport warningswarnings.filterwarnings("ignore")# stop huggingface warningsos.environ["TOKENIZERS\_PARALLELISM"] = "false"# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import VectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import RedisVectorStorefrom IPython.display import Markdown, display
```
Start Redis[](#start-redis "Permalink to this heading")
--------------------------------------------------------

The easiest way to start Redis as a vector database is using the [redis-stack](https://hub.docker.com/r/redis/redis-stack) docker image.

To follow every step of this tutorial, launch the image as follows:


```
docker run --name redis-vecdb -d -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
```
This will also launch the RedisInsight UI on port 8001 which you can view at http://localhost:8001.

Setup OpenAI[](#setup-openai "Permalink to this heading")
----------------------------------------------------------

Lets first begin by adding the openai api key. This will allow us to access openai for embeddings and to use chatgpt.


```
import osos.environ["OPENAI\_API\_KEY"] = "sk-<your key here>"
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Read in a dataset[](#read-in-a-dataset "Permalink to this heading")
--------------------------------------------------------------------

Here we will use a set of Paul Graham essays to provide the text to turn into embeddings, store in a `RedisVectorStore` and query to find context for our LLM QnA loop.


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()print(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,)
```

```
Document ID: faa23c94-ac9e-4763-92ba-e0f87bf38195 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e
```
You can process your files individually using [SimpleDirectoryReader](../data_connectors/simple_directory_reader.html):


```
loader = SimpleDirectoryReader("./data/paul\_graham")documents = loader.load\_data()for file in loader.input\_files:    print(file)    # Here is where you would do any preprocessing
```
Initialize the Redis Vector Store[](#initialize-the-redis-vector-store "Permalink to this heading")
----------------------------------------------------------------------------------------------------

Now we have our documents read in, we can initialize the Redis Vector Store. This will allow us to store our vectors in Redis and create an index.

Below you can see the docstring for `RedisVectorStore`.


```
print(RedisVectorStore.\_\_init\_\_.\_\_doc\_\_)
```

```
Initialize RedisVectorStore.        For index arguments that can be passed to RediSearch, see        https://redis.io/docs/stack/search/reference/vectors/        The index arguments will depend on the index type chosen. There        are two available index types            - FLAT: a flat index that uses brute force search            - HNSW: a hierarchical navigable small world graph index        Args:            index_name (str): Name of the index.            index_prefix (str): Prefix for the index. Defaults to "llama_index".                The actual prefix used by Redis will be                "{index_prefix}{prefix_ending}".            prefix_ending (str): Prefix ending for the index. Be careful when                changing this: https://github.com/jerryjliu/llama_index/pull/6665.                Defaults to "/vector".            index_args (Dict[str, Any]): Arguments for the index. Defaults to None.            metadata_fields (List[str]): List of metadata fields to store in the index                (only supports TAG fields).            redis_url (str): URL for the redis instance.                Defaults to "redis://localhost:6379".            overwrite (bool): Whether to overwrite the index if it already exists.                Defaults to False.            kwargs (Any): Additional arguments to pass to the redis client.        Raises:            ValueError: If redis-py is not installed            ValueError: If RediSearch is not installed        Examples:            >>> from llama_index.vector_stores.redis import RedisVectorStore            >>> # Create a RedisVectorStore            >>> vector_store = RedisVectorStore(            >>>     index_name="my_index",            >>>     index_prefix="llama_index",            >>>     index_args={"algorithm": "HNSW", "m": 16, "ef_construction": 200,                "distance_metric": "cosine"},            >>>     redis_url="redis://localhost:6379/",            >>>     overwrite=True)        
```

```
from llama\_index.storage.storage\_context import StorageContextvector\_store = RedisVectorStore(    index\_name="pg\_essays",    index\_prefix="llama",    redis\_url="redis://localhost:6379",  # Default    overwrite=True,)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
With logging on, it prints out the following:


```
INFO:llama_index.vector_stores.redis:Creating index pg_essaysCreating index pg_essaysINFO:llama_index.vector_stores.redis:Added 15 documents to index pg_essaysAdded 15 documents to index pg_essaysINFO:llama_index.vector_stores.redis:Saving index to disk in background
```
Now you can browse these index in redis-cli and read/write it as Redis hash. It looks like this:


```
$ redis-cli127.0.0.1:6379> keys * 1) "llama/vector\_0f125320-f5cf-40c2-8462-aefc7dbff490" 2) "llama/vector\_bd667698-4311-4a67-bb8b-0397b03ec794"127.0.0.1:6379> HGETALL "llama/vector\_bd667698-4311-4a67-bb8b-0397b03ec794"...
```
Handle duplicated index[](#handle-duplicated-index "Permalink to this heading")
--------------------------------------------------------------------------------

Regardless of whether overwrite=True is used in RedisVectorStore(), the process of generating the index and storing data in Redis still takes time. Currently, it is necessary to implement your own logic to manage duplicate indexes. One possible approach is to set a flag in Redis to indicate the readiness of the index. If the flag is set, you can bypass the index generation step and directly load the index from Redis.


```
import redisr = redis.Redis()index\_name = "pg\_essays"r.set(f"added:{index\_name}", "true")# Later in codeif r.get(f"added:{index\_name}"):    # Skip to deploy your index, restore it. Please see "Restore index from Redis" section below. 
```
Query the data[](#query-the-data "Permalink to this heading")
==============================================================

Now that we have our document stored in the index, we can ask questions against the index. The index will use the data stored in itself as the knowledge base for ChatGPT. The default setting for as\_query\_engine() utilizes OpenAI embeddings and ChatGPT as the language model. Therefore, an OpenAI key is required unless you opt for a customized or local language model.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author learn?")print(textwrap.fill(str(response), 100))
```

```
 The author learned that it is possible to publish essays online, and that working on things thatare not prestigious can be a sign that one is on the right track. They also learned that impuremotives can lead ambitious people astray, and that it is possible to make connections with peoplethrough cleverly planned events. Finally, the author learned that they could find love through achance meeting at a party.
```

```
response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```

```
 A hard moment for the author was when he realized that he had been working on things that weren'tprestigious. He had been drawn to these types of work despite their lack of prestige, and he wasworried that his ambition was leading him astray. He was also concerned that people would give him a"glassy eye" when he explained what he was writing.
```
Saving and Loading[](#saving-and-loading "Permalink to this heading")
----------------------------------------------------------------------

Redis allows the user to perform backups in the background or synchronously. With Llamaindex, the `RedisVectorStore.persist()` function can be used to trigger such a backup.


```
!docker exec -it redis-vecdb ls /data
```

```
redis  redisinsight
```

```
# RedisVectorStore's persist method doesn't use the persist\_path argumentvector\_store.persist(persist\_path="")
```

```
!docker exec -it redis-vecdb ls /data
```

```
dump.rdb  redis  redisinsight
```
Restore index from Redis[](#restore-index-from-redis "Permalink to this heading")
----------------------------------------------------------------------------------


```
vector\_store = RedisVectorStore(    index\_name="pg\_essays",    index\_prefix="llama",    redis\_url="redis://localhost:6379",    overwrite=True,)index = VectorStoreIndex.from\_vector\_store(vector\_store=vector\_store)
```
Now you can reuse your index as discussed above.


```
pgQuery = index.as\_query\_engine()pgQuery.query("What is the meaning of life?")# orpgRetriever = index.as\_retriever()pgRetriever.retrieve("What is the meaning of life?")
```
Learn more about [query\_engine](../../module_guides/deploying/query_engine/root.html) and [retrievers](../../module_guides/querying/retriever/root.html).

Deleting documents or index completely[](#deleting-documents-or-index-completely "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

Sometimes it may be useful to delete documents or the entire index. This can be done using the `delete` and `delete\_index` methods.


```
document\_id = documents[0].doc\_iddocument\_id
```

```
'faa23c94-ac9e-4763-92ba-e0f87bf38195'
```

```
redis\_client = vector\_store.clientprint("Number of documents", len(redis\_client.keys()))
```

```
Number of documents 20
```

```
vector\_store.delete(document\_id)
```

```
print("Number of documents", len(redis\_client.keys()))
```

```
Number of documents 10
```

```
# now lets delete the index entirely (happens in the background, may take a second)# this will delete all the documents and the indexvector\_store.delete\_index()
```

```
print("Number of documents", len(redis\_client.keys()))
```

```
Number of documents 0
```
Working with Metadata[](#working-with-metadata "Permalink to this heading")
============================================================================

RedisVectorStore supports adding metadata and then using it in your queries (for example, to limit the scope of documents retrieved). However, there are a couple of important caveats:

1. Currently, only [Tag fields](https://redis.io/docs/stack/search/reference/tags/) are supported, and only with exact match.
2. You must declare the metadata when creating the index (usually when initializing RedisVectorStore). If you do not do this, your queries will come back empty. There is no way to modify an existing index after it had already been created (this is a Redis limitation).

Here’s how to work with Metadata:

When **creating** the index[](#when-creating-the-index "Permalink to this heading")
------------------------------------------------------------------------------------

Make sure to declare the metadata when you **first** create the index:


```
vector\_store = RedisVectorStore(    index\_name="pg\_essays\_with\_metadata",    index\_prefix="llama",    redis\_url="redis://localhost:6379",    overwrite=True,    metadata\_fields=["user\_id", "favorite\_color"],)
```
Note: the field names `text`, `doc\_id`, `id` and the name of your vector field (`vector` by default) should **not** be used as metadata field names, as they are are reserved.

When adding a document[](#when-adding-a-document "Permalink to this heading")
------------------------------------------------------------------------------

Add your metadata under the `metadata` key. You can add metadata to documents you load in just by looping over them:


```
# load your documents normally, then add your metadatadocuments = SimpleDirectoryReader("../data/paul\_graham").load\_data()for document in documents:    document.metadata = {"user\_id": "12345", "favorite\_color": "blue"}storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# load documentsprint(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,    "Metadata:",    documents[0].metadata,)
```

```
Document ID: 6a5aa8dd-2771-454b-befc-bcfc311d2008 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e Metadata: {'user_id': '12345', 'favorite_color': 'blue'}
```
When querying the index[](#when-querying-the-index "Permalink to this heading")
--------------------------------------------------------------------------------

To filter by your metadata fields, include one or more of your metadata keys, like so:


```
from llama\_index.vector\_stores.types import MetadataFilters, ExactMatchFilterquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3,    filters=MetadataFilters(        filters=[            ExactMatchFilter(key="user\_id", value="12345"),            ExactMatchFilter(key="favorite\_color", value="blue"),        ]    ),)response = query\_engine.query("What did the author learn?")print(textwrap.fill(str(response), 100))
```

```
 The author learned that it was possible to publish anything online, and that working on things thatweren't prestigious could lead to discovering something real. They also learned that impure motiveswere a big danger for the ambitious, and that it was possible for programs not to terminate.Finally, they learned that computers were expensive in those days, and that they could writeprograms on the IBM 1401.
```
Troubleshooting[](#troubleshooting "Permalink to this heading")
----------------------------------------------------------------

In case you run into issues retrieving your documents from the index, you might get a message similar to this.


```
No docs found on index 'pg_essays' with prefix 'llama' and filters '(@user_id:{12345} & @favorite_color:{blue})'.* Did you originally create the index with a different prefix?* Did you index your metadata fields when you created the index?
```
If you get this error, there a couple of gotchas to be aware of when working with Redis:

### Prefix issues[](#prefix-issues "Permalink to this heading")

If you first create your index with a specific `prefix` but later change that prefix in your code, your query will come back empty. Redis saves the prefix your originally created your index with and expects it to be consistent.

To see what prefix your index was created with, you can run `FT.INFO <name of your index>` in the Redis CLI and look under `index\_definition` => `prefixes`.

### Empty queries when using metadata[](#empty-queries-when-using-metadata "Permalink to this heading")

If you add metadata to the index *after* it has already been created and then try to query over that metadata, your queries will come back empty.

Redis indexes fields upon index creation only (similar to how it indexes the prefixes, above).

If you have an existing index and want to make sure it’s dropped, you can run `FT.DROPINDEX <name of your index>` in the Redis CLI. Note that this will *not* drop your actual data.

