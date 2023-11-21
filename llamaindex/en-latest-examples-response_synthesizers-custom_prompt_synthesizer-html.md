[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/response_synthesizers/custom_prompt_synthesizer.ipynb)

Pydantic Tree Summarize[](#pydantic-tree-summarize "Permalink to this heading")
================================================================================

In this notebook, we demonstrate how to use tree summarize with structured outputs. Specifically, tree summarize is used to output pydantic objects.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
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
Define Custom Prompt[](#define-custom-prompt "Permalink to this heading")
--------------------------------------------------------------------------


```
from llama\_index import PromptTemplate
```

```
# NOTE: we add an extra tone\_name variable hereqa\_prompt\_tmpl = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query.\n"    "Please also write the answer in the style of {tone\_name}.\n"    "Query: {query\_str}\n"    "Answer: ")qa\_prompt = PromptTemplate(qa\_prompt\_tmpl)refine\_prompt\_tmpl = (    "The original query is as follows: {query\_str}\n"    "We have provided an existing answer: {existing\_answer}\n"    "We have the opportunity to refine the existing answer "    "(only if needed) with some more context below.\n"    "------------\n"    "{context\_msg}\n"    "------------\n"    "Given the new context, refine the original answer to better "    "answer the query. "    "Please also write the answer in the style of {tone\_name}.\n"    "If the context isn't useful, return the original answer.\n"    "Refined Answer: ")refine\_prompt = PromptTemplate(refine\_prompt\_tmpl)
```
Try out Response Synthesis with Custom Prompt[](#try-out-response-synthesis-with-custom-prompt "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

We try out a few different response synthesis strategies with the custom prompt.


```
from llama\_index.response\_synthesizers import TreeSummarize, Refinefrom llama\_index.types import BaseModelfrom typing import List
```

```
summarizer = TreeSummarize(verbose=True, summary\_template=qa\_prompt)
```

```
response = summarizer.get\_response(    "who is Paul Graham?", [text], tone\_name="a Shakespeare play")
```

```
5 text chunks after repacking1 text chunks after repacking
```

```
print(str(response))
```

```
Paul Graham, a noble and esteemed gentleman, is a man of many talents and accomplishments. He hath traversed the realms of art, entrepreneurship, and writing, leaving a lasting impact on each. With his brush, he hath brought life to canvases, capturing the essence of what he saw. In the realm of technology, he hath revolutionized the way we do business, founding Viaweb and bringing the power of the web to entrepreneurs and artists alike. His wisdom and guidance hath shaped the future of technology and entrepreneurship through his co-founding of Y Combinator. But above all, Paul Graham is a visionary, a trailblazer, and a true Renaissance man, whose intellectual curiosity and quest for lasting creation hath inspired generations to come.
```

```
summarizer = Refine(    verbose=True, text\_qa\_template=qa\_prompt, refine\_template=refine\_prompt)
```

```
response = summarizer.get\_response(    "who is Paul Graham?", [text], tone\_name="a haiku")
```

```
> Refine context: made a living from a combination of modelling a...> Refine context: to have studied art, because the main goal of a...> Refine context: I had been intimately involved with building th...> Refine context: I didn't understand what he meant, but graduall...
```

```
print(str(response))
```

```
Paul Graham, a web pioneer,Co-founded Y Combinator,But stepped down to ensure,Long-term success and more.
```

```
# try with pydantic modelclass Biography(BaseModel): """Data model for a biography."""    name: str    best\_known\_for: List[str]    extra\_info: str
```

```
summarizer = TreeSummarize(    verbose=True, summary\_template=qa\_prompt, output\_cls=Biography)
```

```
response = summarizer.get\_response(    "who is Paul Graham?", [text], tone\_name="a business memo")
```

```
5 text chunks after repacking1 text chunks after repacking
```

```
print(str(response))
```

```
name='Paul Graham' best_known_for=['Co-founder of Y Combinator', 'Writer', 'Investor'] extra_info="Paul Graham is a renowned entrepreneur, writer, and investor. He is best known as the co-founder of Y Combinator, a highly successful startup accelerator. Graham has played a significant role in shaping the startup ecosystem and has been instrumental in the success of numerous startups. He is also a prolific writer, known for his insightful essays on a wide range of topics, including technology, startups, and entrepreneurship. Graham's writings have been widely read and have had a profound impact on the tech community. In addition to his work with Y Combinator and his writing, Graham is also an active investor, providing seed funding and mentorship to early-stage startups. His contributions to the startup world have earned him a reputation as one of the most influential figures in the industry."
```
