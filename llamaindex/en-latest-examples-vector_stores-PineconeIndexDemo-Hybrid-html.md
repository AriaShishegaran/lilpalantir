[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/PineconeIndexDemo-Hybrid.ipynb)

Pinecone Vector Store - Hybrid Search[](#pinecone-vector-store-hybrid-search "Permalink to this heading")
==========================================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Creating a Pinecone Index[](#creating-a-pinecone-index "Permalink to this heading")
------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
import pinecone
```

```
api\_key = ""pinecone.init(api\_key=api\_key, environment="us-west1-gcp")
```

```
pinecone.describe\_index("quickstart")
```

```
# dimensions are for text-embedding-ada-002# NOTE: needs dotproduct for hybrid searchpinecone.create\_index(    "quickstart", dimension=1536, metric="dotproduct", pod\_type="p1")
```

```
pinecone\_index = pinecone.Index("quickstart")
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the PineconeVectorStore[](#load-documents-build-the-pineconevectorstore "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import PineconeVectorStorefrom IPython.display import Markdown, display
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
# set add\_sparse\_vector=True to compute sparse vectors during upsertfrom llama\_index.storage.storage\_context import StorageContextvector\_store = PineconeVectorStore(    pinecone\_index=pinecone\_index,    add\_sparse\_vector=True,)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(vector\_store\_query\_mode="hybrid")response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
