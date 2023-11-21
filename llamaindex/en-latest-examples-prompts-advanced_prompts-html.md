[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/prompts/advanced_prompts.ipynb)

Advanced Prompt Techniques (Variable Mappings, Functions)[](#advanced-prompt-techniques-variable-mappings-functions "Permalink to this heading")
=================================================================================================================================================

In this notebook we show some advanced prompt techniques. These features allow you to define more custom/expressive prompts, re-use existing ones, and also express certain operations in fewer lines of code.

We show the following features:

1. Partial formatting
2. Prompt template variable mappings
3. Prompt function mappings


```
from llama\_index.prompts import PromptTemplatefrom llama\_index.llms import OpenAI
```
1. Partial Formatting[](#partial-formatting "Permalink to this heading")
-------------------------------------------------------------------------

Partial formatting (`partial\_format`) allows you to partially format a prompt, filling in some variables while leaving others to be filled in later.

This is a nice convenience function so you don’t have to maintain all the required prompt variables all the way down to `format`, you can partially format as they come in.

This will create a copy of the prompt template.


```
qa\_prompt\_tmpl\_str = """\Context information is below.---------------------{context\_str}---------------------Given the context information and not prior knowledge, answer the query.Please write the answer in the style of {tone\_name}Query: {query\_str}Answer: \"""prompt\_tmpl = PromptTemplate(qa\_prompt\_tmpl\_str)
```

```
partial\_prompt\_tmpl = prompt\_tmpl.partial\_format(tone\_name="Shakespeare")
```

```
partial\_prompt\_tmpl.kwargs
```

```
{'tone_name': 'Shakespeare'}
```

```
fmt\_prompt = partial\_prompt\_tmpl.format(    context\_str="In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters",    query\_str="How many params does llama 2 have",)print(fmt\_prompt)
```

```
Context information is below.---------------------In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters---------------------Given the context information and not prior knowledge, answer the query.Please write the answer in the style of ShakespeareQuery: How many params does llama 2 haveAnswer: 
```
2. Prompt Template Variable Mappings[](#prompt-template-variable-mappings "Permalink to this heading")
-------------------------------------------------------------------------------------------------------

Template var mappings allow you to specify a mapping from the “expected” prompt keys (e.g. `context\_str` and `query\_str` for response synthesis), with the keys actually in your template.

This allows you re-use your existing string templates without having to annoyingly change out the template variables.


```
# NOTE: here notice we use `my\_context` and `my\_query` as template variablesqa\_prompt\_tmpl\_str = """\Context information is below.---------------------{my\_context}---------------------Given the context information and not prior knowledge, answer the query.Query: {my\_query}Answer: \"""template\_var\_mappings = {"context\_str": "my\_context", "query\_str": "my\_query"}prompt\_tmpl = PromptTemplate(    qa\_prompt\_tmpl\_str, template\_var\_mappings=template\_var\_mappings)
```

```
fmt\_prompt = partial\_prompt\_tmpl.format(    context\_str="In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters",    query\_str="How many params does llama 2 have",)print(fmt\_prompt)
```

```
Context information is below.---------------------In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters---------------------Given the context information and not prior knowledge, answer the query.Please write the answer in the style of ShakespeareQuery: How many params does llama 2 haveAnswer: 
```
### 3. Prompt Function Mappings[](#prompt-function-mappings "Permalink to this heading")

You can also pass in functions as template variables instead of fixed values.

This allows you to dynamically inject certain values, dependent on other values, during query-time.

Here are some basic examples. We show more advanced examples (e.g. few-shot examples) in our Prompt Engineering for RAG guide.


```
qa\_prompt\_tmpl\_str = """\Context information is below.---------------------{context\_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query\_str}Answer: \"""def format\_context\_fn(\*\*kwargs):    # format context with bullet points    context\_list = kwargs["context\_str"].split("\n\n")    fmtted\_context = "\n\n".join([f"- {c}" for c in context\_list])    return fmtted\_contextprompt\_tmpl = PromptTemplate(    qa\_prompt\_tmpl\_str, function\_mappings={"context\_str": format\_context\_fn})
```

```
context\_str = """\In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters.Our fine-tuned LLMs, called Llama 2-Chat, are optimized for dialogue use cases.Our models outperform open-source chat models on most benchmarks we tested, and based on our human evaluations for helpfulness and safety, may be a suitable substitute for closed-source models."""fmt\_prompt = prompt\_tmpl.format(    context\_str=context\_str, query\_str="How many params does llama 2 have")print(fmt\_prompt)
```

```
Context information is below.---------------------- In this work, we develop and release Llama 2, a collection of pretrained and fine-tuned large language models (LLMs) ranging in scale from 7 billion to 70 billion parameters.- Our fine-tuned LLMs, called Llama 2-Chat, are optimized for dialogue use cases.- Our models outperform open-source chat models on most benchmarks we tested, and based on our human evaluations for helpfulness and safety, may be a suitable substitute for closed-source models.---------------------Given the context information and not prior knowledge, answer the query.Query: How many params does llama 2 haveAnswer: 
```
