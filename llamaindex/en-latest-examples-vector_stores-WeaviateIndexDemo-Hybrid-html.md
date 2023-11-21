[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/WeaviateIndexDemo-Hybrid.ipynb)

Weaviate Vector Store - Hybrid Search[](#weaviate-vector-store-hybrid-search "Permalink to this heading")
==========================================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Creating a Weaviate Client[](#creating-a-weaviate-client "Permalink to this heading")
--------------------------------------------------------------------------------------


```
import weaviate
```

```
resource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)
```

```
# Connect to cloud instance# client = weaviate.Client("https://<cluster-id>.semi.network/", auth\_client\_secret=resource\_owner\_config)# Connect to local instanceclient = weaviate.Client("http://localhost:8080")
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import WeaviateVectorStorefrom llama\_index.response.notebook\_utils import display\_response
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents[](#load-documents "Permalink to this heading")
--------------------------------------------------------------


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
Build the VectorStoreIndex with WeaviateVectorStore[](#build-the-vectorstoreindex-with-weaviatevectorstore "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index.storage.storage\_context import StorageContextvector\_store = WeaviateVectorStore(weaviate\_client=client)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# NOTE: you may also choose to define a index\_name manually.# index\_name = "test\_prefix"# vector\_store = WeaviateVectorStore(weaviate\_client=client, index\_name=index\_name)
```
Query Index with Default Vector Search[](#query-index-with-default-vector-search "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(similarity\_top\_k=2)response = query\_engine.query("What did the author do growing up?")
```

```
display\_response(response)
```
Query Index with Hybrid Search[](#query-index-with-hybrid-search "Permalink to this heading")
----------------------------------------------------------------------------------------------

Use hybrid search with bm25 and vector.  
`alpha` parameter determines weighting (alpha = 0 -> bm25, alpha=1 -> vector search).

### By default, `alpha=0.75` is used (very similar to vector search)[](#by-default-alpha-0-75-is-used-very-similar-to-vector-search "Permalink to this heading")


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(    vector\_store\_query\_mode="hybrid", similarity\_top\_k=2)response = query\_engine.query(    "What did the author do growing up?",)
```

```
display\_response(response)
```
### Set `alpha=0.` to favor bm25[](#set-alpha-0-to-favor-bm25 "Permalink to this heading")


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(    vector\_store\_query\_mode="hybrid", similarity\_top\_k=2, alpha=0.0)response = query\_engine.query(    "What did the author do growing up?",)
```

```
display\_response(response)
```
