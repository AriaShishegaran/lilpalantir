[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/response_synthesizers/tree_summarize.ipynb)

Tree Summarize[](#tree-summarize "Permalink to this heading")
==============================================================

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
from llama\_index.response\_synthesizers import TreeSummarize
```

```
summarizer = TreeSummarize(verbose=True)
```

```
response = await summarizer.aget\_response("who is Paul Graham?", [text])
```

```
6 text chunks after repacking1 text chunks after repacking
```

```
print(response)
```

```
Paul Graham is a computer scientist, writer, artist, entrepreneur, investor, and essayist. He is best known for his work in artificial intelligence, Lisp programming, and writing the book On Lisp, as well as for co-founding the startup accelerator Y Combinator and for his essays on technology, business, and start-ups. He is also the creator of the programming language Arc and the Lisp dialect Bel.
```
