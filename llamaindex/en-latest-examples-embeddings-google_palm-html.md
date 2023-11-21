[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/google_palm.ipynb)

Google PaLM Embeddings[](#google-palm-embeddings "Permalink to this heading")
==============================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# importsfrom llama\_index.embeddings import GooglePaLMEmbedding
```

```
# get API key and create embeddingsmodel\_name = "models/embedding-gecko-001"api\_key = "YOUR API KEY"embed\_model = GooglePaLMEmbedding(model\_name=model\_name, api\_key=api\_key)embeddings = embed\_model.get\_query\_embedding("Google PaLM Embeddings.")
```

```
print(f"Dimension of embeddings: {len(embeddings)}")
```

```
Dimension of embeddings: 768
```

```
embeddings[:5]
```

```
[0.028517298, -0.0028859433, -0.035110522, 0.021982985, -0.0039763353]
```
