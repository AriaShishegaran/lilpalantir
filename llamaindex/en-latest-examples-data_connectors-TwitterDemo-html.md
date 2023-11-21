[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/TwitterDemo.ipynb)

Twitter Reader[](#twitter-reader "Permalink to this heading")
==============================================================


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import VectorStoreIndex, TwitterTweetReaderfrom IPython.display import Markdown, displayimport os
```

```
# create an app in https://developer.twitter.com/en/appsBEARER\_TOKEN = "<bearer\_token>"
```

```
# create reader, specify twitter handlesreader = TwitterTweetReader(BEARER\_TOKEN)documents = reader.load\_data(["@twitter\_handle1"])
```

```
index = VectorStoreIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
