Embeddings[](#embeddings "Permalink to this heading")
======================================================

FAQ[](#faq "Permalink to this heading")
----------------------------------------

1. [How to use a custom/local embedding model?](#how-to-use-a-custom-local-embedding-model)
2. [How to use a local hugging face embedding model?](#how-to-use-a-local-hugging-face-embedding-model)
3. [How to use embedding model to generate embeddings for text?](#how-to-use-embedding-model-to-generate-embeddings-for-text)
4. [How to use Huggingface Text-Embedding Inference with LlamaIndex?](#how-to-use-huggingface-text-embedding-inference-with-llamaindex)


---

1. How to use a custom/local embedding model?[](#how-to-use-a-custom-local-embedding-model "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------

To create your customized embedding class you can follow [Custom Embeddings](../../examples/embeddings/custom_embeddings.html) guide.



---

2. How to use a local hugging face embedding model?[](#how-to-use-a-local-hugging-face-embedding-model "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------

To use a local HuggingFace embedding model you can follow [Local Embeddings with HuggingFace](../../examples/embeddings/huggingface.html) guide.



---

3. How to use embedding model to generate embeddings for text?[](#how-to-use-embedding-model-to-generate-embeddings-for-text "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------------

You can generate embeddings for texts with the following piece of code.


```
text\_embedding = embed\_model.get\_text\_embedding("YOUR\_TEXT")
```


---

4. How to use Huggingface Text-Embedding Inference with LlamaIndex?[](#how-to-use-huggingface-text-embedding-inference-with-llamaindex "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

To use HuggingFace Text-Embedding Inference you can follow [Text-Embedding-Inference](../../examples/embeddings/text_embedding_inference.html) tutorial.

