[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/WebPageDemo.ipynb)

Web Page Reader[](#web-page-reader "Permalink to this heading")
================================================================

Demonstrates our web page reader.


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Using SimpleWebPageReader[](#using-simplewebpagereader "Permalink to this heading")
------------------------------------------------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import SummaryIndex, SimpleWebPageReaderfrom IPython.display import Markdown, displayimport os
```

```
# NOTE: the html\_to\_text=True option requires html2text to be installed
```

```
documents = SimpleWebPageReader(html\_to\_text=True).load\_data(    ["http://paulgraham.com/worked.html"])
```

```
documents[0]
```

```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
Using TrafilaturaWebReader[](#using-trafilaturawebreader "Permalink to this heading")
--------------------------------------------------------------------------------------


```
from llama\_index import TrafilaturaWebReader
```

```
documents = TrafilaturaWebReader().load\_data(    ["http://paulgraham.com/worked.html"])
```

```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
Using RssReader[](#using-rssreader "Permalink to this heading")
----------------------------------------------------------------


```
from llama\_index import SummaryIndex, RssReaderdocuments = RssReader().load\_data(    ["https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"])index = SummaryIndex.from\_documents(documents)# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What happened in the news today?")
```
