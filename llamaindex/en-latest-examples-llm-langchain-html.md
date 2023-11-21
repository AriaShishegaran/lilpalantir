[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/langchain.ipynb)

LangChain LLM[](#langchain-llm "Permalink to this heading")
============================================================


```
from langchain.llms import OpenAI
```

```
from llama\_index.llms import LangChainLLM
```

```
llm = LangChainLLM(llm=OpenAI())
```

```
response\_gen = llm.stream\_complete("Hi this is")
```

```
for delta in response\_gen:    print(delta.delta, end="")
```

```
 a testHello! Welcome to the test. What would you like to learn about?
```
