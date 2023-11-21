[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/ChromaDemo.ipynb)

Chroma Reader[](#chroma-reader "Permalink to this heading")
============================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index.readers.chroma import ChromaReader
```

```
# The chroma reader loads data from a persisted Chroma collection.# This requires a collection name and a persist directory.reader = ChromaReader(    collection\_name="chroma\_collection",    persist\_directory="examples/data\_connectors/chroma\_collection",)
```

```
# the query\_vector is an embedding representation of your query.# Example query vector:# query\_vector=[0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]query\_vector = [n1, n2, n3, ...]
```

```
# NOTE: Required args are collection\_name, query\_vector.# See the Python client: https://github.com/chroma-core/chroma# for more details.documents = reader.load\_data(    collection\_name="demo", query\_vector=query\_vector, limit=5)
```
Create index[](#create-index "Permalink to this heading")
----------------------------------------------------------


```
from llama\_index.indices import SummaryIndexindex = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
