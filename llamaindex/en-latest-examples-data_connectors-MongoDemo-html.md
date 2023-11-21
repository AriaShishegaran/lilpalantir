[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/MongoDemo.ipynb)

MongoDB Reader[](#mongodb-reader "Permalink to this heading")
==============================================================

Demonstrates our MongoDB data connector


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import SummaryIndex, SimpleMongoReaderfrom IPython.display import Markdown, displayimport os
```

```
host = "<host>"port = "<port>"db\_name = "<db\_name>"collection\_name = "<collection\_name>"# query\_dict is passed into db.collection.find()query\_dict = {}field\_names = ["text"]reader = SimpleMongoReader(host, port)documents = reader.load\_data(    db\_name, collection\_name, field\_names, query\_dict=query\_dict)
```

```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
