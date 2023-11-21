[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/TencentVectorDBIndexDemo.ipynb)

Tencent Cloud VectorDB[](#tencent-cloud-vectordb "Permalink to this heading")
==============================================================================


> [Tencent Cloud VectorDB](https://cloud.tencent.com/document/product/1709) is a fully managed, self-developed, enterprise-level distributed database service designed for storing, retrieving, and analyzing multi-dimensional vector data. The database supports multiple index types and similarity calculation methods. A single index can support a vector scale of up to 1 billion and can support millions of QPS and millisecond-level query latency. Tencent Cloud Vector Database can not only provide an external knowledge base for large models to improve the accuracy of large model responses but can also be widely used in AI fields such as recommendation systems, NLP services, computer vision, and intelligent customer service.
> 
> 

**This notebook shows the basic usage of TencentVectorDB as a Vector Store in LlamaIndex.**

To run, you should have a [Database instance.](https://cloud.tencent.com/document/product/1709/95101)

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
!pip install tcvectordb
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    StorageContext,)from llama\_index.vector\_stores import TencentVectorDBfrom llama\_index.vector\_stores.tencentvectordb import (    CollectionParams,    FilterField,)import tcvectordbtcvectordb.debug.DebugEnable = False
```
### Please provide OpenAI access key[](#please-provide-openai-access-key "Permalink to this heading")

In order use embeddings by OpenAI you need to supply an OpenAI API Key:


```
import openaiOPENAI\_API\_KEY = getpass.getpass("OpenAI API Key:")openai.api\_key = OPENAI\_API\_KEY
```

```
OpenAI API Key: ········
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Creating and populating the Vector Store[](#creating-and-populating-the-vector-store "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

You will now load some essays by Paul Graham from a local file and store them into the Tencent Cloud VectorDB.


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()print(f"Total documents: {len(documents)}")print(f"First document, id: {documents[0].doc\_id}")print(f"First document, hash: {documents[0].hash}")print(    f"First document, text ({len(documents[0].text)} characters):\n{'='\*20}\n{documents[0].text[:360]} ...")
```

```
Total documents: 1First document, id: 5b7489b6-0cca-4088-8f30-6de32d540fdfFirst document, hash: 4c702b4df575421e1d1af4b1fd50511b226e0c9863dbfffeccb8b689b8448f35First document, text (75019 characters):====================		What I Worked OnFebruary 2021Before college the two main things I worked on, outside of school, were writing and programming. I didn't write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined  ...
```
### Initialize the Tencent Cloud VectorDB[](#initialize-the-tencent-cloud-vectordb "Permalink to this heading")

Creation of the vector store entails creation of the underlying database collection if it does not exist yet:


```
vector\_store = TencentVectorDB(    url="http://10.0.X.X",    key="eC4bLRy2va\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*",    collection\_params=CollectionParams(dimension=1536, drop\_exists=True),)
```
Now wrap this store into an `index` LlamaIndex abstraction for later querying:


```
storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Note that the above `from\_documents` call does several things at once: it splits the input documents into chunks of manageable size (“nodes”), computes embedding vectors for each node, and stores them all in the Tencent Cloud VectorDB.

Querying the store[](#querying-the-store "Permalink to this heading")
----------------------------------------------------------------------

### Basic querying[](#basic-querying "Permalink to this heading")


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Why did the author choose to work on AI?")print(response)
```

```
The author chose to work on AI because of his fascination with the novel The Moon is a Harsh Mistress, which featured an intelligent computer called Mike, and a PBS documentary that showed Terry Winograd using SHRDLU. He was also drawn to the idea that AI could be used to explore the ultimate truths that other fields could not.
```
### MMR-based queries[](#mmr-based-queries "Permalink to this heading")

The MMR (maximal marginal relevance) method is designed to fetch text chunks from the store that are at the same time relevant to the query but as different as possible from each other, with the goal of providing a broader context to the building of the final answer:


```
query\_engine = index.as\_query\_engine(vector\_store\_query\_mode="mmr")response = query\_engine.query("Why did the author choose to work on AI?")print(response)
```

```
The author chose to work on AI because he was impressed and envious of his friend who had built a computer kit and was able to type programs into it. He was also inspired by a novel by Heinlein called The Moon is a Harsh Mistress, which featured an intelligent computer called Mike, and a PBS documentary that showed Terry Winograd using SHRDLU. He was also disappointed with philosophy courses in college, which he found to be boring, and he wanted to work on something that seemed more powerful.
```
Connecting to an existing store[](#connecting-to-an-existing-store "Permalink to this heading")
------------------------------------------------------------------------------------------------

Since this store is backed by Tencent Cloud VectorDB, it is persistent by definition. So, if you want to connect to a store that was created and populated previously, here is how:


```
new\_vector\_store = TencentVectorDB(    url="http://10.0.X.X",    key="eC4bLRy2va\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*",    collection\_params=CollectionParams(dimension=1536, drop\_exists=False),)# Create index (from preexisting stored vectors)new\_index\_instance = VectorStoreIndex.from\_vector\_store(    vector\_store=new\_vector\_store)# now you can do querying, etc:query\_engine = index.as\_query\_engine(similarity\_top\_k=5)response = query\_engine.query(    "What did the author study prior to working on AI?")
```

```
print(response)
```

```
The author studied philosophy and painting, worked on spam filters, and wrote essays prior to working on AI.
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
Found 3 nodes.    [0] score = 0.42589144520149874        id    = 05f53f06-9905-461a-bc6d-fa4817e5a776        text  = What I Worked OnFebruary 2021Before college the two main things I worked on, outside o ...    [1] score = -0.0012061281453193962        id    = 2f9f843e-6495-4646-a03d-4b844ff7c1ab        text  = been explored. But all I wanted was to get out of grad school, and my rapidly written diss ...    [2] score = 0.025454533089838027        id    = 28ad32da-25f9-4aaa-8487-88390ec13348        text  = showed Terry Winograd using SHRDLU. I haven't tried rereading The Moon is a Harsh Mistress ...
```
But wait! When using the vector store, you should consider the **document** as the sensible unit to delete, and not any individual node belonging to it. Well, in this case, you just inserted a single text file, so all nodes will have the same `ref\_doc\_id`:


```
print("Nodes' ref\_doc\_id:")print("\n".join([nws.node.ref\_doc\_id for nws in nodes\_with\_scores]))
```

```
Nodes' ref_doc_id:5b7489b6-0cca-4088-8f30-6de32d540fdf5b7489b6-0cca-4088-8f30-6de32d540fdf5b7489b6-0cca-4088-8f30-6de32d540fdf
```
Now let’s say you need to remove the text file you uploaded:


```
new\_vector\_store.delete(nodes\_with\_scores[0].node.ref\_doc\_id)
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

The Tencent Cloud VectorDB vector store support metadata filtering in the form of exact-match `key=value` pairs at query time. The following cells, which work on a brand new collection, demonstrate this feature.

In this demo, for the sake of brevity, a single source document is loaded (the `../data/paul\_graham/paul\_graham\_essay.txt` text file). Nevertheless, you will attach some custom metadata to the document to illustrate how you can can restrict queries with conditions on the metadata attached to the documents.


```
filter\_fields = [    FilterField(name="source\_type"),]md\_storage\_context = StorageContext.from\_defaults(    vector\_store=TencentVectorDB(        url="http://10.0.X.X",        key="eC4bLRy2va\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*",        collection\_params=CollectionParams(            dimension=1536, drop\_exists=True, filter\_fields=filter\_fields        ),    ))def my\_file\_metadata(file\_name: str): """Depending on the input file name, associate a different metadata."""    if "essay" in file\_name:        source\_type = "essay"    elif "dinosaur" in file\_name:        # this (unfortunately) will not happen in this demo        source\_type = "dinos"    else:        source\_type = "other"    return {"source\_type": source\_type}# Load documents and build indexmd\_documents = SimpleDirectoryReader(    "../data/paul\_graham", file\_metadata=my\_file\_metadata).load\_data()md\_index = VectorStoreIndex.from\_documents(    md\_documents, storage\_context=md\_storage\_context)
```
That’s it: you can now add filtering to your query engine:


```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFilters
```

```
md\_query\_engine = md\_index.as\_query\_engine(    filters=MetadataFilters(        filters=[ExactMatchFilter(key="source\_type", value="essay")]    ))md\_response = md\_query\_engine.query(    "How long it took the author to write his thesis?")print(md\_response.response)
```

```
It took the author five weeks to write his thesis.
```
To test that the filtering is at play, try to change it to use only `"dinos"` documents… there will be no answer this time :)

