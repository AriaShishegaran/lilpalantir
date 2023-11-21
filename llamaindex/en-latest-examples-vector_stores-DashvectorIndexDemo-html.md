[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/DashvectorIndexDemo.ipynb)

DashVector Vector Store[](#dashvector-vector-store "Permalink to this heading")
================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysimport oslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Creating a DashVector Collection[](#creating-a-dashvector-collection "Permalink to this heading")
--------------------------------------------------------------------------------------------------


```
import dashvector
```

```
api\_key = os.environ["DASHVECTOR\_API\_KEY"]client = dashvector.Client(api\_key=api\_key)
```

```
# dimensions are for text-embedding-ada-002client.create("llama-demo", dimension=1536)
```

```
{"code": 0, "message": "", "requests_id": "82b969d2-2568-4e18-b0dc-aa159b503c84"}
```

```
dashvector\_collection = client.get("quickstart")
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the DashVectorStore and VectorStoreIndex[](#load-documents-build-the-dashvectorstore-and-vectorstoreindex "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import DashVectorStorefrom IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
# initialize without metadata filterfrom llama\_index.storage.storage\_context import StorageContextvector\_store = DashVectorStore(dashvector\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming outside of school. They wrote short stories and tried writing programs on the IBM 1401 computer. They also built a microcomputer and started programming on it, writing simple games and a word processor.**

