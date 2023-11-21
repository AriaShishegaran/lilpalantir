[Beta] Multi-modal models[](#beta-multi-modal-models "Permalink to this heading")
==================================================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Large language models (LLMs) are text-in, text-out. Large Multi-modal Models (LMMs) generalize this beyond the text modalities. For instance, models such as GPT-4V allow you to jointly input both images and text, and output text.

We’ve included a base `MultiModalLLM` abstraction to allow for text+image models. **NOTE**: This naming is subject to change!

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

The following code snippet shows how you can get started using LMMs e.g. with GPT-4V.


```
from llama\_index.multi\_modal\_llms import OpenAIMultiModalfrom llama\_index.multi\_modal\_llms.generic\_utils import (    load\_image\_urls,)from llama\_index import SimpleDirectoryReader# load image documents from urlsimage\_documents = load\_image\_urls(image\_urls)# load image documents from local directoryimage\_documents = SimpleDirectoryReader(local\_directory).load\_data()# non-streamingopenai\_mm\_llm = OpenAIMultiModal(    model="gpt-4-vision-preview", api\_key=OPENAI\_API\_TOKEN, max\_new\_tokens=300)response = openai\_mm\_llm.complete(    prompt="what is in the image?", image\_documents=image\_documents)
```
Modules[](#modules "Permalink to this heading")
------------------------------------------------

We support integrations with GPT-4V, LLaVA, and more.

* [Multi-Modal LLM using OpenAI GPT-4V model for image reasoning](../../examples/multi_modal/openai_multi_modal.html)
* [Multi-Modal LLM using Replicate LlaVa and Fuyu 8B model for image reasoning](../../examples/multi_modal/replicate_multi_modal.html)
* [Multi-Modal Retrieval using GPT text embedding and CLIP image embedding for Wikipedia Articles](../../examples/multi_modal/multi_modal_retrieval.html)
* [Retrieval-Augmented Image Captioning](../../examples/multi_modal/llava_multi_modal_tesla_10q.html)
