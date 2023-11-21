[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/response_synthesizers/pydantic_tree_summarize.ipynb)

Pydantic Tree Summarize[](#pydantic-tree-summarize "Permalink to this heading")
================================================================================

In this notebook, we demonstrate how to use tree summarize with structured outputs. Specifically, tree summarize is used to output pydantic objects.


```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Download Data[](#download-data "Permalink to this heading")
============================================================


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
from llama\_index.response\_synthesizers import TreeSummarizefrom llama\_index.types import BaseModelfrom typing import List
```
### Create pydantic model to structure response[](#create-pydantic-model-to-structure-response "Permalink to this heading")


```
class Biography(BaseModel): """Data model for a biography."""    name: str    best\_known\_for: List[str]    extra\_info: str
```

```
summarizer = TreeSummarize(verbose=True, output\_cls=Biography)
```

```
response = summarizer.get\_response("who is Paul Graham?", [text])
```

```
5 text chunks after repacking1 text chunks after repacking
```
### Inspect the response[](#inspect-the-response "Permalink to this heading")

Here, we see the response is in an instance of our `Biography` class.


```
print(response)
```

```
name='Paul Graham' best_known_for=['Writing', 'Programming', 'Art', 'Co-founding Viaweb', 'Co-founding Y Combinator', 'Essayist'] extra_info="Paul Graham is a multi-talented individual who has made significant contributions in various fields. He is known for his work in writing, programming, art, co-founding Viaweb, co-founding Y Combinator, and his essays on startups and programming. He started his career by writing short stories and programming on the IBM 1401 computer. He later became interested in artificial intelligence and Lisp programming. He wrote a book called 'On Lisp' and focused on Lisp hacking. Eventually, he decided to pursue art and attended art school. He is known for his paintings, particularly still life paintings. Graham is also a programmer, entrepreneur, and venture capitalist. He co-founded Viaweb, an early e-commerce platform, and Y Combinator, a startup accelerator. He has written influential essays on startups and programming. Additionally, he has made contributions to the field of computer programming and entrepreneurship."
```

```
print(response.name)
```

```
Paul Graham
```

```
print(response.best\_known\_for)
```

```
['Writing', 'Programming', 'Art', 'Co-founding Viaweb', 'Co-founding Y Combinator', 'Essayist']
```

```
print(response.extra\_info)
```

```
Paul Graham is a multi-talented individual who has made significant contributions in various fields. He is known for his work in writing, programming, art, co-founding Viaweb, co-founding Y Combinator, and his essays on startups and programming. He started his career by writing short stories and programming on the IBM 1401 computer. He later became interested in artificial intelligence and Lisp programming. He wrote a book called 'On Lisp' and focused on Lisp hacking. Eventually, he decided to pursue art and attended art school. He is known for his paintings, particularly still life paintings. Graham is also a programmer, entrepreneur, and venture capitalist. He co-founded Viaweb, an early e-commerce platform, and Y Combinator, a startup accelerator. He has written influential essays on startups and programming. Additionally, he has made contributions to the field of computer programming and entrepreneurship.
```
