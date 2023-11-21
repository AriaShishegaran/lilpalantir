Large Language Models[](#large-language-models "Permalink to this heading")
============================================================================

FAQ[](#faq "Permalink to this heading")
----------------------------------------

1. [How to use a custom/local embedding model?](#how-to-define-a-custom-llm)
2. [How to use a local hugging face embedding model?](#how-to-use-a-different-openai-model)
3. [How can I customize my prompt](#how-can-i-customize-my-prompt)
4. [Is it required to fine-tune my model?](#is-it-required-to-fine-tune-my-model)
5. [I want to the LLM answer in Chinese/Italian/French but only answers in English, how to proceed?](#i-want-to-the-llm-answer-in-chinese-italian-french-but-only-answers-in-english-how-to-proceed)
6. [Is LlamaIndex GPU accelerated?](#is-llamaindex-gpu-accelerated)


---

1. How to define a custom LLM?[](#how-to-define-a-custom-llm "Permalink to this heading")
------------------------------------------------------------------------------------------

You can access [Usage Custom](../../module_guides/models/llms/usage_custom.html#example-using-a-custom-llm-model-advanced) to define a custom LLM.



---

2. How to use a different OpenAI model?[](#how-to-use-a-different-openai-model "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

To use a different OpenAI model you can access [Configure Model](../../examples/llm/openai.html) to set your own custom model.



---

3. How can I customize my prompt?[](#how-can-i-customize-my-prompt "Permalink to this heading")
------------------------------------------------------------------------------------------------

You can access [Prompts](../../module_guides/models/prompts.html) to learn how to customize your prompts.



---

4. Is it required to fine-tune my model?[](#is-it-required-to-fine-tune-my-model "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

No. there’s isolated modules which might provide better results, but isn’t required, you can use llamaindex without needing to fine-tune the model.



---

5. I want to the LLM answer in Chinese/Italian/French but only answers in English, how to proceed?[](#i-want-to-the-llm-answer-in-chinese-italian-french-but-only-answers-in-english-how-to-proceed "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

To the LLM answer in another language more accurate you can update the prompts to enforce more the output language.


```
response = query\_engine.query("Rest of your query... \nRespond in Italian")
```
Alternatively:


```
from llama\_index import LLMPredictor, ServiceContextfrom llama\_index.llms import OpenAIllm\_predictor = LLMPredictor(system\_prompt="Always respond in Italian.")service\_context = ServiceContext.from\_defaults(llm\_predictor=llm\_predictor)query\_engine = load\_index\_from\_storage(    storage\_context, service\_context=service\_context).as\_query\_engine()
```


---

6. Is LlamaIndex GPU accelerated?[](#is-llamaindex-gpu-accelerated "Permalink to this heading")
------------------------------------------------------------------------------------------------

Yes, you can run a language model (LLM) on a GPU when running it locally. You can find an example of setting up LLMs with GPU support in the [llama2 setup](../../examples/vector_stores/SimpleIndexDemoLlama-Local.html) documentation.



---

