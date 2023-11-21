[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/data_connectors/MakeDemo.ipynb)

Make Reader[](#make-reader "Permalink to this heading")
========================================================

We show how LlamaIndex can fit with your Make.com workflow by sending the GPT Index response to a scenario webhook.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.readers import MakeWrapper
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(documents=documents)
```

```
# set Logging to DEBUG for more detailed outputs# query indexquery\_str = "What did the author do growing up?"query\_engine = index.as\_query\_engine()response = query\_engine.query(query\_str)
```

```
# Send response to Make.com webhookwrapper = MakeWrapper()wrapper.pass\_response\_to\_webhook(    "<webhook\_url>,    response,    query\_str)
```
