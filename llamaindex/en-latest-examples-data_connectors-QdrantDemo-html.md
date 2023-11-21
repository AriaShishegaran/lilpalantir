[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/QdrantDemo.ipynb)

Qdrant Reader[](#qdrant-reader "Permalink to this heading")
============================================================


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.readers.qdrant import QdrantReader
```

```
reader = QdrantReader(host="localhost")
```

```
# the query\_vector is an embedding representation of your query\_vector# Example query vector:# query\_vector=[0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]query\_vector = [n1, n2, n3, ...]
```

```
# NOTE: Required args are collection\_name, query\_vector.# See the Python client: https://github.com/qdrant/qdrant\_client# for more details.documents = reader.load\_data(    collection\_name="demo", query\_vector=query\_vector, limit=5)
```
Create index[](#create-index "Permalink to this heading")
----------------------------------------------------------


```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
