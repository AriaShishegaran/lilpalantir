[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/FaissIndexDemo.ipynb)

Faiss Vector Store[](#faiss-vector-store "Permalink to this heading")
======================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Creating a Faiss Index[](#creating-a-faiss-index "Permalink to this heading")
------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
import faiss# dimensions of text-ada-embedding-002d = 1536faiss\_index = faiss.IndexFlatL2(d)
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
from llama\_index import (    SimpleDirectoryReader,    load\_index\_from\_storage,    VectorStoreIndex,    StorageContext,)from llama\_index.vector\_stores.faiss import FaissVectorStorefrom IPython.display import Markdown, display
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
vector\_store = FaissVectorStore(faiss\_index=faiss\_index)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```

```
# save index to diskindex.storage\_context.persist()
```

```
# load index from diskvector\_store = FaissVectorStore.from\_persist\_dir("./storage")storage\_context = StorageContext.from\_defaults(    vector\_store=vector\_store, persist\_dir="./storage")index = load\_index\_from\_storage(storage\_context=storage\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query(    "What did the author do after his time at Y Combinator?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
