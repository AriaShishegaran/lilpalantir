[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/DiscordDemo.ipynb)

Discord Reader[](#discord-reader "Permalink to this heading")
==============================================================

Demonstrates our Discord data connector

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
# This is due to the fact that we use asyncio.loop\_until\_complete in# the DiscordReader. Since the Jupyter kernel itself runs on# an event loop, we need to add some help with nesting!pip install nest_asyncioimport nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index import SummaryIndex, DiscordReaderfrom IPython.display import Markdown, displayimport os
```

```
discord\_token = os.getenv("DISCORD\_TOKEN")channel\_ids = [1057178784895348746]  # Replace with your channel\_iddocuments = DiscordReader(discord\_token=discord\_token).load\_data(    channel\_ids=channel\_ids)
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
