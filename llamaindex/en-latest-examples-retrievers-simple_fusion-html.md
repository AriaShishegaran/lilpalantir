Simple Fusion Retriever[](#simple-fusion-retriever "Permalink to this heading")
================================================================================

In this example, we walk through how you can combine retireval results from multiple queries and multiple indexes.

The retrieved nodes will be returned as the top-k across all queries and indexes, as well as handling de-duplication of any nodes.


```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

For this notebook, we will use two very similar pages of our documentation, each stored in a separaete index.


```
from llama\_index import SimpleDirectoryReaderdocuments\_1 = SimpleDirectoryReader(    input\_files=["../../community/integrations/vector\_stores.md"]).load\_data()documents\_2 = SimpleDirectoryReader(    input\_files=["../../core\_modules/data\_modules/storage/vector\_stores.md"]).load\_data()
```

```
from llama\_index import VectorStoreIndexindex\_1 = VectorStoreIndex.from\_documents(documents\_1)index\_2 = VectorStoreIndex.from\_documents(documents\_2)
```
Fuse the Indexes![](#fuse-the-indexes "Permalink to this heading")
-------------------------------------------------------------------

In this step, we fuse our indexes into a single retriever. This retriever will also generate augment our query by generating extra queries related to the original question, and aggregate the results.

This setup will query 4 times, once with your original query, and generate 3 more queries.

By default, it uses the following prompt to generate extra queries:


```
QUERY\_GEN\_PROMPT = (    "You are a helpful assistant that generates multiple search queries based on a "    "single input query. Generate {num\_queries} search queries, one on each line, "    "related to the following input query:\n"    "Query: {query}\n"    "Queries:\n")
```

```
from llama\_index.retrievers import QueryFusionRetrieverretriever = QueryFusionRetriever(    [index\_1.as\_retriever(), index\_2.as\_retriever()],    similarity\_top\_k=2,    num\_queries=4,  # set this to 1 to disable query generation    use\_async=True,    verbose=True,    # query\_gen\_prompt="...", # we could override the query generation prompt here)
```

```
# apply nested async to run in a notebookimport nest\_asyncionest\_asyncio.apply()
```

```
nodes\_with\_scores = retriever.retrieve("How do I setup a chroma vector store?")
```

```
Generated queries:1. What are the steps to set up a chroma vector store?2. Best practices for setting up a chroma vector store3. Troubleshooting common issues when setting up a chroma vector store
```

```
for node in nodes\_with\_scores:    print(f"Score: {node.score:.2f} - {node.text[:100]}...")
```

```
Score: 0.81 - construct vector storeneo4j_vector = Neo4jVectorStore(    username="neo4j",    password="pleasele...Score: 0.80 - construct vector storevector_store = ChromaVectorStore(    chroma_collection=chroma_collection,)...
```
Use in a Query Engine![](#use-in-a-query-engine "Permalink to this heading")
-----------------------------------------------------------------------------

Now, we can plug our retriever into a query engine to synthesize natural language responses.


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(retriever)
```

```
response = query\_engine.query(    "How do I setup a chroma vector store? Can you give an example?")
```

```
Generated queries:1. How to set up a chroma vector store?2. Step-by-step guide for creating a chroma vector store.3. Examples of chroma vector store setups and configurations.
```

```
from llama\_index.response.notebook\_utils import display\_responsedisplay\_response(response)
```
**`Final Response:`** To set up a Chroma Vector Store, you can use the `ChromaVectorStore` class from the `llama\_index.vector\_stores` module. Here is an example of how to set it up:


```
from llama\_index.vector\_stores import ChromaVectorStore# Assuming you have a chroma\_collection variablevector\_store = ChromaVectorStore(    chroma\_collection=chroma\_collection,)
```
This code creates an instance of the `ChromaVectorStore` class, passing in the `chroma\_collection` as a parameter.

