Multi-modal[](#multi-modal "Permalink to this heading")
========================================================

LlamaIndex offers capabilities to not only build language-based applications, but also **multi-modal** applications - combining language and images.

Types of Multi-modal Use Cases[](#types-of-multi-modal-use-cases "Permalink to this heading")
----------------------------------------------------------------------------------------------

This space is actively being explored right now, but there are some fascinating use cases popping up.

### Multi-Modal RAG[](#multi-modal-rag "Permalink to this heading")

All the core RAG concepts: indexing, retrieval, and synthesis, can be extended into the image setting.

* The input could be text or image.
* The stored knowledge base can consist of text or images.
* The inputs to response generation can be text or image.
* The final response can be text or image.

Check out our guides below:

* [Advanced Multi-Modal Retrieval using GPT4V and Multi-Modal Index/Retriever](../examples/multi_modal/gpt4v_multi_modal_retrieval.html)
* [Multi-modal retrieval with CLIP](../examples/multi_modal/multi_modal_retrieval.html)
### Retrieval-Augmented Image Captioning[](#retrieval-augmented-image-captioning "Permalink to this heading")

Oftentimes understanding an image requires looking up information from a knowledge base. A flow here is retrieval-augmented image captioning - first caption the image with a multi-modal model, then refine the caption by retrieving from a text corpus.

Check out our guides below:

* [Retrieval-Augmented Image Captioning](../examples/multi_modal/llava_multi_modal_tesla_10q.html)
