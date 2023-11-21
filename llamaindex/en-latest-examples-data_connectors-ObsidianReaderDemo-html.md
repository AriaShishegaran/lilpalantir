[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/data_connectors/ObsidianReaderDemo.ipynb)

Obsidian Reader[](#obsidian-reader "Permalink to this heading")
================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%env OPENAI_API_KEY=sk-************
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import ObsidianReader, VectorStoreIndex
```

```
documents = ObsidianReader(    "/Users/hursh/vault").load\_data()  # Returns list of documents
```

```
index = VectorStoreIndex.from\_documents(    documents)  # Initialize index with documents
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()res = query\_engine.query("What is the meaning of life?")
```

```
> [query] Total LLM token usage: 920 tokens> [query] Total embedding token usage: 7 tokens
```

```
res.response
```

```
'\nThe meaning of life is subjective and can vary from person to person. It is ultimately up to each individual to decide what they believe is the purpose and value of life. Some may find meaning in their faith, while others may find it in their relationships, work, or hobbies. Ultimately, it is up to each individual to decide what brings them joy and fulfillment and to pursue that path.'
```
