[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/text_embedding_inference.ipynb)

Text Embedding Inference[](#text-embedding-inference "Permalink to this heading")
==================================================================================

This notebook demonstrates how to configure `TextEmbeddingInference` embeddings.

The first step is to deploy the embeddings server. For detailed instructions, see the [official repository for Text Embeddings Inference](https://github.com/huggingface/text-embeddings-inference).

Once deployed, the code below will connect to and submit embeddings for inference.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.embeddings import TextEmbeddingsInferenceembed\_model = TextEmbeddingsInference(    model\_name="BAAI/bge-large-en-v1.5",  # required for formatting inference text,    timeout=60,  # timeout in seconds    embed\_batch\_size=10,  # batch size for embedding)
```

```
embeddings = embed\_model.get\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```

```
1024[0.010597229, 0.05895996, 0.022445679, -0.012046814, -0.03164673]
```

```
embeddings = await embed\_model.aget\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```

```
1024[0.010597229, 0.05895996, 0.022445679, -0.012046814, -0.03164673]
```
