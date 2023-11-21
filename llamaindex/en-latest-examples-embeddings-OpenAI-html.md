[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/embeddings/OpenAI.ipynb)

OpenAI Embeddings[](#openai-embeddings "Permalink to this heading")
====================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import ServiceContext, set\_global\_service\_contextembed\_model = OpenAIEmbedding(embed\_batch\_size=10)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)# optionally set a global service contextset\_global\_service\_context(service\_context)
```
