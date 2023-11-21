[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/FaissDemo.ipynb)

Faiss Reader[](#faiss-reader "Permalink to this heading")
==========================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index.readers.faiss import FaissReader
```

```
# Build the Faiss index.# A guide for how to get started with Faiss is here: https://github.com/facebookresearch/faiss/wiki/Getting-started# We provide some example code below.import faiss# # Example Code# d = 8# docs = np.array([# [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],# [0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2],# [0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3],# [0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4],# [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]# ])# # id\_to\_text\_map is used for query retrieval# id\_to\_text\_map = {# 0: "aaaaaaaaa bbbbbbb cccccc",# 1: "foooooo barrrrrr",# 2: "tmp tmptmp tmp",# 3: "hello world hello world",# 4: "cat dog cat dog"# }# # build the index# index = faiss.IndexFlatL2(d)# index.add(docs)id\_to\_text\_map = {    "id1": "text blob 1",    "id2": "text blob 2",}index = ...
```

```
reader = FaissReader(index)
```

```
# To load data from the Faiss index, you must specify:# k: top nearest neighbors# query: a 2D embedding representation of your queries (rows are queries)k = 4query1 = np.array([...])query2 = np.array([...])query = np.array([query1, query2])documents = reader.load\_data(query=query, id\_to\_text\_map=id\_to\_text\_map, k=k)
```
Create index[](#create-index "Permalink to this heading")
----------------------------------------------------------


```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
