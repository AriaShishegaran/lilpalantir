[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/llm_rails.ipynb)

LLMRails Embeddings[](#llmrails-embeddings "Permalink to this heading")
========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# importsfrom llama\_index.embeddings.llm\_rails import LLMRailsEmbedding
```

```
# get credentials and create embeddingsimport osapi\_key = os.environ.get("API\_KEY", "your-api-key")model\_id = os.environ.get("MODEL\_ID", "your-model-id")embed\_model = LLMRailsEmbedding(model\_id=model\_id, api\_key=api\_key)embeddings = embed\_model.get\_text\_embedding(    "It is raining cats and dogs here!")
```
