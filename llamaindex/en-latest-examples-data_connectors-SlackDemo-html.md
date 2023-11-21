[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/SlackDemo.ipynb)

Slack Reader[](#slack-reader "Permalink to this heading")
==========================================================

Demonstrates our Slack data connector

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import SummaryIndex, SlackReaderfrom IPython.display import Markdown, displayimport os
```

```
slack\_token = os.getenv("SLACK\_BOT\_TOKEN")channel\_ids = ["<channel\_id>"]documents = SlackReader(slack\_token=slack\_token).load\_data(    channel\_ids=channel\_ids)
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
