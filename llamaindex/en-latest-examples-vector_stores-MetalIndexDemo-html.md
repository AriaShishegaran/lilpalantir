[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/MetalIndexDemo.ipynb)

Metal Vector Store[](#metal-vector-store "Permalink to this heading")
======================================================================

Creating a Metal Vector Store[](#creating-a-metal-vector-store "Permalink to this heading")
--------------------------------------------------------------------------------------------

1. Register an account for [Metal](https://app.getmetal.io/)
2. Generate an API key in [Metal’s Settings](https://app.getmetal.io/settings/organization). Save the `api\_key` + `client\_id`
3. Generate an Index in [Metal’s Dashboard](https://app.getmetal.io/). Save the `index\_id`
Load data into your Index[](#load-data-into-your-index "Permalink to this heading")
------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import MetalVectorStorefrom IPython.display import Markdown, display
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
# initialize Metal Vector Storefrom llama\_index.storage.storage\_context import StorageContextapi\_key = "api key"client\_id = "client id"index\_id = "index id"vector\_store = MetalVectorStore(    api\_key=api\_key,    client\_id=client\_id,    index\_id=index\_id,)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
