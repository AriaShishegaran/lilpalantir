[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/embeddings/Langchain.ipynb)

Langchain Embeddings[](#langchain-embeddings "Permalink to this heading")
==========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from langchain.embeddings import HuggingFaceEmbeddingsfrom llama\_index import ServiceContext, set\_global\_service\_contextembed\_model = HuggingFaceEmbeddings(    model\_name="sentence-transformers/all-mpnet-base-v2")service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)# optionally set a global service contextset\_global\_service\_context(service\_context)
```
