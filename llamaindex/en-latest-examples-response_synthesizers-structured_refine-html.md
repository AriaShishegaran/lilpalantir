[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/response_synthesizers/structured_refine.ipynb)

Refine with Structured Answer Filtering[](#refine-with-structured-answer-filtering "Permalink to this heading")
================================================================================================================

When using our Refine response synthesizer for response synthesis, it’s crucial to filter out non-answers. An issue often encountered is the propagation of a single unhelpful response like “I don’t have the answer”, which can persist throughout the synthesis process and lead to a final answer of the same nature. This can occur even when there are actual answers present in other, more relevant sections.

These unhelpful responses can be filtered out by setting `structured\_answer\_filtering` to `True`. It is set to `False` by default since this currently only works best if you are using an OpenAI model that supports function calling.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------


```
texts = [    "The president in the year 2040 is John Cena.",    "The president in the year 2050 is Florence Pugh.",    'The president in the year 2060 is Dwayne "The Rock" Johnson.',]
```
Summarize[](#summarize "Permalink to this heading")
----------------------------------------------------


```
from llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo-0613")
```

```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(llm=llm)
```

```
from llama\_index.response\_synthesizers import get\_response\_synthesizersummarizer = get\_response\_synthesizer(    response\_mode="refine", service\_context=service\_context, verbose=True)
```

```
response = summarizer.get\_response("who is president in the year 2050?", texts)
```

```
> Refine context: The president in the year 2050 is Florence Pugh...> Refine context: The president in the year 2060 is Dwayne "The R...
```
### Failed Result[](#failed-result "Permalink to this heading")

As you can see, we weren’t able to get the correct answer from the input `texts` strings since the initial “I don’t know” answer propogated through till the end of the response synthesis.


```
print(response)
```

```
I'm sorry, but I don't have access to information about the future.
```
Now we’ll try again with `structured\_answer\_filtering=True`


```
from llama\_index.response\_synthesizers import get\_response\_synthesizersummarizer = get\_response\_synthesizer(    response\_mode="refine",    service\_context=service\_context,    verbose=True,    structured\_answer\_filtering=True,)
```

```
response = summarizer.get\_response("who is president in the year 2050?", texts)
```

```
Function call: StructuredRefineResponse with args: {  "answer": "There is not enough context information to determine who is the president in the year 2050.",  "query_satisfied": false}> Refine context: The president in the year 2050 is Florence Pugh...Function call: StructuredRefineResponse with args: {  "answer": "Florence Pugh",  "query_satisfied": true}> Refine context: The president in the year 2060 is Dwayne "The R...Function call: StructuredRefineResponse with args: {  "answer": "Florence Pugh",  "query_satisfied": false}
```
### Successful Result[](#successful-result "Permalink to this heading")

As you can see, we were able to determine the correct answer from the given context by filtering the `texts` strings for the ones that actually contained the answer to our question.


```
print(response)
```

```
Florence Pugh
```
Non Function-calling LLMs[](#non-function-calling-llms "Permalink to this heading")
------------------------------------------------------------------------------------

You may want to make use of this filtering functionality with an LLM that doesn’t offer a function calling API.

In that case, the `Refine` module will automatically switch to using a structured output `Program` that doesn’t rely on an external function calling API.


```
# we'll stick with OpenAI but use an older model that does not support function callingdavinci\_llm = OpenAI(model="text-davinci-003")
```

```
from llama\_index import ServiceContextfrom llama\_index.response\_synthesizers import get\_response\_synthesizerdavinci\_service\_context = ServiceContext.from\_defaults(llm=davinci\_llm)summarizer = get\_response\_synthesizer(    response\_mode="refine",    service\_context=davinci\_service\_context,    verbose=True,    structured\_answer\_filtering=True,)
```

```
response = summarizer.get\_response("who is president in the year 2050?", texts)print(response)
```

```
> Refine context: The president in the year 2050 is Florence Pugh...> Refine context: The president in the year 2060 is Dwayne "The R...Florence Pugh is the president in the year 2050 and Dwayne "The Rock" Johnson is the president in the year 2060.
```
### `CompactAndRefine`[](#compactandrefine "Permalink to this heading")

Since `CompactAndRefine` is built on top of `Refine`, this response mode also supports structured answer filtering.


```
from llama\_index.response\_synthesizers import get\_response\_synthesizersummarizer = get\_response\_synthesizer(    response\_mode="compact",    service\_context=service\_context,    verbose=True,    structured\_answer\_filtering=True,)
```

```
response = summarizer.get\_response("who is president in the year 2050?", texts)print(response)
```

```
Function call: StructuredRefineResponse with args: {  "answer": "Florence Pugh",  "query_satisfied": true}Florence Pugh
```
