[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/response_synthesizers/refine.ipynb)

Refine[](#refine "Permalink to this heading")
==============================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------


```
from llama\_index import SimpleDirectoryReader
```

```
reader = SimpleDirectoryReader(    input\_files=["./data/paul\_graham/paul\_graham\_essay.txt"])
```

```
docs = reader.load\_data()
```

```
text = docs[0].text
```
Summarize[](#summarize "Permalink to this heading")
----------------------------------------------------


```
from llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")
```

```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(llm=llm)
```

```
from llama\_index.response\_synthesizers import Refinesummarizer = Refine(service\_context=service\_context, verbose=True)
```

```
response = summarizer.get\_response("who is Paul Graham?", [text])
```

```
> Refine context: making fakes for a local antique dealer. She'd ...> Refine context: look legit, and the key to looking legit is hig...> Refine context: me 8 years to realize it. Even then it took me ...> Refine context: was one thing rarer than Rtm offering advice, i...
```

```
print(response)
```

```
Paul Graham is an individual who has played a crucial role in shaping the internet infrastructure and has also pursued a career as a writer. At one point, he received advice from a friend that urged him not to let Y Combinator be his final noteworthy achievement. This advice prompted him to reflect on his future with Y Combinator and ultimately led him to pass on the responsibility to others. He approached Jessica and Sam Altman to assume leadership positions in Y Combinator, aiming to secure its continued success.
```
