[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/CassandraIndexDemo.ipynb)

Cassandra Vector Store[](#cassandra-vector-store "Permalink to this heading")
==============================================================================

[Apache Cassandra®](https://cassandra.apache.org) is a NoSQL, row-oriented, highly scalable and highly available database. Starting with version 5.0, the database ships with [vector search](https://cassandra.apache.org/doc/trunk/cassandra/vector-search/overview.html) capabilities.

DataStax [Astra DB through CQL](https://docs.datastax.com/en/astra-serverless/docs/vector-search/quickstart.html) is a managed serverless database built on Cassandra, offering the same interface and strengths.

**This notebook shows the basic usage of the Cassandra Vector Store in LlamaIndex.**

To run the full code you need either a running Cassandra cluster equipped with VectorSearch capabilities or a DataStax Astra DB instance.

Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
!pip install --quiet "astrapy>=0.5.8"
```

```
import osfrom getpass import getpassfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    Document,    StorageContext,)from llama\_index.vector\_stores import CassandraVectorStore
```
The next step is to initialize CassIO with a global DB connection: this is the only step that is done slightly differently for a Cassandra cluster and Astra DB:

### Initialization (Cassandra cluster)[](#initialization-cassandra-cluster "Permalink to this heading")

In this case, you first need to create a `cassandra.cluster.Session` object,as described in the [Cassandra driver documentation](https://docs.datastax.com/en/developer/python-driver/latest/api/cassandra/cluster/#module-cassandra.cluster).The details vary (e.g. with network settings and authentication), but this might be something like:


```
from cassandra.cluster import Clustercluster = Cluster(["127.0.0.1"])session = cluster.connect()
```

```
import cassioCASSANDRA\_KEYSPACE = input("CASSANDRA\_KEYSPACE = ")cassio.init(session=session, keyspace=CASSANDRA\_KEYSPACE)
```
### Initialization (Astra DB through CQL)[](#initialization-astra-db-through-cql "Permalink to this heading")

In this case you initialize CassIO with the following connection parameters:

* the Database ID, e.g. 01234567-89ab-cdef-0123-456789abcdef
* the Token, e.g. AstraCS:6gBhNmsk135…. (it must be a “Database Administrator” token)
* Optionally a Keyspace name (if omitted, the default one for the database will be used)


```
ASTRA\_DB\_ID = input("ASTRA\_DB\_ID = ")ASTRA\_DB\_TOKEN = getpass("ASTRA\_DB\_TOKEN = ")desired\_keyspace = input("ASTRA\_DB\_KEYSPACE (optional, can be left empty) = ")if desired\_keyspace:    ASTRA\_DB\_KEYSPACE = desired\_keyspaceelse:    ASTRA\_DB\_KEYSPACE = None
```

```
import cassiocassio.init(    database\_id=ASTRA\_DB\_ID,    token=ASTRA\_DB\_TOKEN,    keyspace=ASTRA\_DB\_KEYSPACE,)
```
### OpenAI key[](#openai-key "Permalink to this heading")

In order to use embeddings by OpenAI you need to supply an OpenAI API Key:


```
os.environ["OPENAI\_API\_KEY"] = getpass("OpenAI API Key:")
```
### Download data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
--2023-11-10 01:44:05--  https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/paul_graham/paul_graham_essay.txtResolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.110.133, 185.199.111.133, ...Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 75042 (73K) [text/plain]Saving to: ‘data/paul_graham/paul_graham_essay.txt’data/paul_graham/pa 100%[===================>]  73.28K  --.-KB/s    in 0.01s   2023-11-10 01:44:06 (4.80 MB/s) - ‘data/paul_graham/paul_graham_essay.txt’ saved [75042/75042]
```
Creating and populating the Vector Store[](#creating-and-populating-the-vector-store "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

You will now load some essays by Paul Graham from a local file and store them into the Cassandra Vector Store.


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print(f"Total documents: {len(documents)}")print(f"First document, id: {documents[0].doc\_id}")print(f"First document, hash: {documents[0].hash}")print(    "First document, text"    f" ({len(documents[0].text)} characters):\n{'='\*20}\n{documents[0].text[:360]} ...")
```

```
Total documents: 1First document, id: 12bc6987-366a-49eb-8de0-7b52340e4958First document, hash: abe31930a1775c78df5a5b1ece7108f78fedbf5fe4a9cf58d7a21808fccaef34First document, text (75014 characters):====================What I Worked OnFebruary 2021Before college the two main things I worked on, outside of school, were writing and programming. I didn't write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined ma ...
```
### Initialize the Cassandra Vector Store[](#initialize-the-cassandra-vector-store "Permalink to this heading")

Creation of the vector store entails creation of the underlying database table if it does not exist yet:


```
cassandra\_store = CassandraVectorStore(    table="cass\_v\_table", embedding\_dimension=1536)
```
Now wrap this store into an `index` LlamaIndex abstraction for later querying:


```
storage\_context = StorageContext.from\_defaults(vector\_store=cassandra\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Note that the above `from\_documents` call does several things at once: it splits the input documents into chunks of manageable size (“nodes”), computes embedding vectors for each node, and stores them all in the Cassandra Vector Store.

Querying the store[](#querying-the-store "Permalink to this heading")
----------------------------------------------------------------------

### Basic querying[](#basic-querying "Permalink to this heading")


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Why did the author choose to work on AI?")print(response.response)
```

```
The author chose to work on AI because they were inspired by a novel called The Moon is a Harsh Mistress, which featured an intelligent computer, and a PBS documentary that showed Terry Winograd using SHRDLU. These experiences sparked the author's interest in AI and motivated them to pursue it as a field of study and work.
```
### MMR-based queries[](#mmr-based-queries "Permalink to this heading")

The MMR (maximal marginal relevance) method is designed to fetch text chunks from the store that are at the same time relevant to the query but as different as possible from each other, with the goal of providing a broader context to the building of the final answer:


```
query\_engine = index.as\_query\_engine(vector\_store\_query\_mode="mmr")response = query\_engine.query("Why did the author choose to work on AI?")print(response.response)
```

```
The author chose to work on AI because they believed that teaching SHRDLU more words would eventually lead to the development of intelligent programs. They were fascinated by the potential of AI and saw it as an opportunity to expand their understanding of programming and push the limits of what could be achieved.
```
Connecting to an existing store[](#connecting-to-an-existing-store "Permalink to this heading")
------------------------------------------------------------------------------------------------

Since this store is backed by Cassandra, it is persistent by definition. So, if you want to connect to a store that was created and populated previously, here is how:


```
new\_store\_instance = CassandraVectorStore(    table="cass\_v\_table", embedding\_dimension=1536)# Create index (from preexisting stored vectors)new\_index\_instance = VectorStoreIndex.from\_vector\_store(    vector\_store=new\_store\_instance)# now you can do querying, etc:query\_engine = new\_index\_instance.as\_query\_engine(similarity\_top\_k=5)response = query\_engine.query(    "What did the author study prior to working on AI?")
```

```
print(response.response)
```

```
The author studied philosophy prior to working on AI.
```
Removing documents from the index[](#removing-documents-from-the-index "Permalink to this heading")
----------------------------------------------------------------------------------------------------

First get an explicit list of pieces of a document, or “nodes”, from a `Retriever` spawned from the index:


```
retriever = new\_index\_instance.as\_retriever(    vector\_store\_query\_mode="mmr",    similarity\_top\_k=3,    vector\_store\_kwargs={"mmr\_prefetch\_factor": 4},)nodes\_with\_scores = retriever.retrieve(    "What did the author study prior to working on AI?")
```

```
print(f"Found {len(nodes\_with\_scores)} nodes.")for idx, node\_with\_score in enumerate(nodes\_with\_scores):    print(f" [{idx}] score = {node\_with\_score.score}")    print(f" id = {node\_with\_score.node.node\_id}")    print(f" text = {node\_with\_score.node.text[:90]} ...")
```

```
Found 3 nodes.    [0] score = 0.4251742327832831        id    = 7e628668-58fa-4548-9c92-8c31d315dce0        text  = What I Worked OnFebruary 2021Before college the two main things I worked on, outside o ...    [1] score = -0.020323897262800816        id    = aa279d09-717f-4d68-9151-594c5bfef7ce        text  = This was now only weeks away. My nice landlady let me leave my stuff in her attic. I had s ...    [2] score = 0.011198131320563909        id    = 50b9170d-6618-4e8b-aaf8-36632e2801a6        text  = It seemed only a matter of time before we'd have Mike, and when I saw Winograd using SHRDL ...
```
But wait! When using the vector store, you should consider the **document** as the sensible unit to delete, and not any individual node belonging to it. Well, in this case, you just inserted a single text file, so all nodes will have the same `ref\_doc\_id`:


```
print("Nodes' ref\_doc\_id:")print("\n".join([nws.node.ref\_doc\_id for nws in nodes\_with\_scores]))
```

```
Nodes' ref_doc_id:12bc6987-366a-49eb-8de0-7b52340e495812bc6987-366a-49eb-8de0-7b52340e495812bc6987-366a-49eb-8de0-7b52340e4958
```
Now let’s say you need to remove the text file you uploaded:


```
new\_store\_instance.delete(nodes\_with\_scores[0].node.ref\_doc\_id)
```
Repeat the very same query and check the results now. You should see *no results* being found:


```
nodes\_with\_scores = retriever.retrieve(    "What did the author study prior to working on AI?")print(f"Found {len(nodes\_with\_scores)} nodes.")
```

```
Found 0 nodes.
```
Metadata filtering[](#metadata-filtering "Permalink to this heading")
----------------------------------------------------------------------

The Cassandra vector store support metadata filtering in the form of exact-match `key=value` pairs at query time. The following cells, which work on a brand new Cassandra table, demonstrate this feature.

In this demo, for the sake of brevity, a single source document is loaded (the `../data/paul\_graham/paul\_graham\_essay.txt` text file). Nevertheless, you will attach some custom metadata to the document to illustrate how you can can restrict queries with conditions on the metadata attached to the documents.


```
md\_storage\_context = StorageContext.from\_defaults(    vector\_store=CassandraVectorStore(        table="cass\_v\_table\_md", embedding\_dimension=1536    ))def my\_file\_metadata(file\_name: str): """Depending on the input file name, associate a different metadata."""    if "essay" in file\_name:        source\_type = "essay"    elif "dinosaur" in file\_name:        # this (unfortunately) will not happen in this demo        source\_type = "dinos"    else:        source\_type = "other"    return {"source\_type": source\_type}# Load documents and build indexmd\_documents = SimpleDirectoryReader(    "./data/paul\_graham", file\_metadata=my\_file\_metadata).load\_data()md\_index = VectorStoreIndex.from\_documents(    md\_documents, storage\_context=md\_storage\_context)
```
That’s it: you can now add filtering to your query engine:


```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFilters
```

```
md\_query\_engine = md\_index.as\_query\_engine(    filters=MetadataFilters(        filters=[ExactMatchFilter(key="source\_type", value="essay")]    ))md\_response = md\_query\_engine.query(    "did the author appreciate Lisp and painting?")print(md\_response.response)
```

```
Yes, the author appreciated Lisp and painting. They mentioned spending a significant amount of time working on Lisp and even building a new dialect of Lisp called Arc. Additionally, the author mentioned spending most of 2014 painting and experimenting with different techniques.
```
To test that the filtering is at play, try to change it to use only `"dinos"` documents… there will be no answer this time :)

