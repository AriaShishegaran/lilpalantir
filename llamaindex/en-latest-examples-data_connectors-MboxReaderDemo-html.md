[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/data_connectors/MboxReaderDemo.ipynb)

Mbox Reader[](#mbox-reader "Permalink to this heading")
========================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%env OPENAI_API_KEY=sk-************
```

```
from llama\_index import MboxReader, VectorStoreIndex
```

```
documents = MboxReader().load\_data(    "mbox\_data\_dir", max\_count=1000)  # Returns list of documents
```

```
index = VectorStoreIndex.from\_documents(    documents)  # Initialize index with documents
```

```
query\_engine = index.as\_query\_engine()res = query\_engine.query("When did i have that call with the London office?")
```

```
> [query] Total LLM token usage: 100 tokens> [query] Total embedding token usage: 10 tokens
```

```
res.response
```

```
> There is a call scheduled with the London office at 12am GMT on the 10th of February.
```
