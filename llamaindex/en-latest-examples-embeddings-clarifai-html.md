[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/clarifai.ipynb)

Embeddings with Clarifai[](#embeddings-with-clarifai "Permalink to this heading")
==================================================================================

LlamaIndex has support for Clarifai embeddings models.

You must have a Clarifai account and a Personal Access Token (PAT) key.[Check here](https://clarifai.com/settings/security) to get or create a PAT.

Set CLARIFAI\_PAT as an environment variable.


```
!export CLARIFAI_PAT=YOUR_KEY
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Models can be referenced either by the full URL or by the model\_name, user ID, and app ID combination.


```
from llama\_index.embeddings import ClarifaiEmbeddingembed\_model = ClarifaiEmbedding(    model\_url="https://clarifai.com/clarifai/main/models/BAAI-bge-base-en")# Alternativelyembed\_model = ClarifaiEmbedding(    model\_name="BAAI-bge-base-en", user\_id="clarifai", app\_id="main")
```

```
embeddings = embed\_model.get\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```
