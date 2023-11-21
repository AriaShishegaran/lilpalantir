[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/LanceDBIndexDemo.ipynb)

LanceDB Vector Store[](#lancedb-vector-store "Permalink to this heading")
==========================================================================

In this notebook we are going to show how to use [LanceDB](https://www.lancedb.com) to perform vector searches in LlamaIndex

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sys# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import SimpleDirectoryReader, Document, StorageContextfrom llama\_index.indices.vector\_store import VectorStoreIndexfrom llama\_index.vector\_stores import LanceDBVectorStoreimport textwrap
```
Setup OpenAI[](#setup-openai "Permalink to this heading")
----------------------------------------------------------

The first step is to configure the openai key. It will be used to created embeddings for the documents loaded into the index


```
import openaiopenai.api\_key = ""
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Loading documents[](#loading-documents "Permalink to this heading")
--------------------------------------------------------------------

Load the documents stored in the `data/paul\_graham/` using the SimpleDirectoryReader


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print("Document ID:", documents[0].doc\_id, "Document Hash:", documents[0].hash)
```

```
Document ID: 855fe1d1-1c1a-4fbe-82ba-6bea663a5920 Document Hash: 4c702b4df575421e1d1af4b1fd50511b226e0c9863dbfffeccb8b689b8448f35
```
Create the index[](#create-the-index "Permalink to this heading")
------------------------------------------------------------------

Here we create an index backed by LanceDB using the documents loaded previously. LanceDBVectorStore takes a few arguments.

* uri (str, required): Location where LanceDB will store its files.
* table\_name (str, optional): The table name where the embeddings will be stored. Defaults to “vectors”.
* nprobes (int, optional): The number of probes used. A higher number makes search more accurate but also slower. Defaults to 20.
* refine\_factor: (int, optional): Refine the results by reading extra elements and re-ranking them in memory. Defaults to None
* More details can be found at the [LanceDB docs](https://lancedb.github.io/lancedb/ann_indexes)


```
vector\_store = LanceDBVectorStore(uri="/tmp/lancedb")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query the index[](#query-the-index "Permalink to this heading")
----------------------------------------------------------------

We can now ask questions using our index.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("How much did Viaweb charge per month?")
```

```
print(textwrap.fill(str(response), 100))
```

```
Viaweb charged $100 per month for a small store and $300 per month for a big one.
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(textwrap.fill(str(response), 100))
```

```
The author worked on writing and programming outside of school before college. They wrote shortstories and tried writing programs on the IBM 1401 computer. They also mentioned getting amicrocomputer, a TRS-80, and started programming on it.
```
Appending data[](#appending-data "Permalink to this heading")
--------------------------------------------------------------

You can also add data to an existing index


```
del indexindex = VectorStoreIndex.from\_documents(    [Document(text="The sky is purple in Portland, Maine")],    uri="/tmp/new\_dataset",)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Where is the sky purple?")print(textwrap.fill(str(response), 100))
```

```
The sky is purple in Portland, Maine.
```

```
index = VectorStoreIndex.from\_documents(documents, uri="/tmp/new\_dataset")
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What companies did the author start?")print(textwrap.fill(str(response), 100))
```

```
The author started two companies: Viaweb and Y Combinator.
```
