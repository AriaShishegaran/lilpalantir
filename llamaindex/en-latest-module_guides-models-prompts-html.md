Prompts[](#prompts "Permalink to this heading")
================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Prompting is the fundamental input that gives LLMs their expressive power. LlamaIndex uses prompts to build the index, do insertion,perform traversal during querying, and to synthesize the final answer.

LlamaIndex uses a set of [default prompt templates](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/default_prompts.py) that work well out of the box.

In addition, there are some prompts written and used specifically for chat models like `gpt-3.5-turbo` [here](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/chat_prompts.py).

Users may also provide their own prompt templates to further customize the behavior of the framework. The best method for customizing is copying the default prompt from the link above, and using that as the base for any modifications.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Using prompts is simple.


```
from llama\_index.prompts import PromptTemplatetemplate = (    "We have provided context information below. \n"    "---------------------\n"    "{context\_str}"    "\n---------------------\n"    "Given this information, please answer the question: {query\_str}\n")qa\_template = PromptTemplate(template)# you can create text prompt (for completion API)prompt = qa\_template.format(context\_str=..., query\_str=...)# or easily convert to message prompts (for chat API)messages = qa\_template.format\_messages(context\_str=..., query\_str=...)
```
See our Usage Pattern Guide for more details.

* [Usage Pattern](prompts/usage_pattern.html)
	+ [Defining a custom prompt](prompts/usage_pattern.html#defining-a-custom-prompt)
	+ [Getting and Setting Custom Prompts](prompts/usage_pattern.html#getting-and-setting-custom-prompts)
	+ [[Advanced] Advanced Prompt Capabilities](prompts/usage_pattern.html#advanced-advanced-prompt-capabilities)
Example Guides[](#example-guides "Permalink to this heading")
--------------------------------------------------------------

Simple Customization Examples

* [Completion prompts](../../examples/customization/prompts/completion_prompts.html)
* [Chat prompts](../../examples/customization/prompts/chat_prompts.html)
Prompt Engineering Guides

* [Accessing/Customizing Prompts within Higher-Level Modules](../../examples/prompts/prompt_mixin.html)
* [Advanced Prompt Techniques (Variable Mappings, Functions)](../../examples/prompts/advanced_prompts.html)
* [Prompt Engineering for RAG](../../examples/prompts/prompts_rag.html)
Experimental

* [“Optimization by Prompting” for RAG](../../examples/prompts/prompt_optimization.html)
* [EmotionPrompt in RAG](../../examples/prompts/emotion_prompt.html)
