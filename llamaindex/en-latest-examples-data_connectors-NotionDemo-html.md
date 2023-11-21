[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/NotionDemo.ipynb)

Notion Reader[](#notion-reader "Permalink to this heading")
============================================================

Demonstrates our Notion data connector


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import SummaryIndex, NotionPageReaderfrom IPython.display import Markdown, displayimport os
```

```
integration\_token = os.getenv("NOTION\_INTEGRATION\_TOKEN")page\_ids = ["<page\_id>"]documents = NotionPageReader(integration\_token=integration\_token).load\_data(    page\_ids=page\_ids)
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
You can also pass the id of a database to index all the pages in that database:


```
database\_id = "<database-id>"# https://developers.notion.com/docs/working-with-databases for how to find your database iddocuments = NotionPageReader(integration\_token=integration\_token).load\_data(    database\_id=database\_id)print(documents)
```

```
# set Logging to DEBUG for more detailed outputsindex = SummaryIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")display(Markdown(f"<b>{response}</b>"))
```
