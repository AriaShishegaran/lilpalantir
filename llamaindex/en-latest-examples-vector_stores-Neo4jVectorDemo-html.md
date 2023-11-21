[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/Neo4jVectorDemo.ipynb)

Neo4j vector store[](#neo4j-vector-store "Permalink to this heading")
======================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY\_HERE"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Initiate Neo4j vector wrapper[](#initiate-neo4j-vector-wrapper "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
from llama\_index.vector\_stores import Neo4jVectorStoreusername = "neo4j"password = "pleaseletmein"url = "bolt://localhost:7687"embed\_dim = 1536neo4j\_vector = Neo4jVectorStore(username, password, url, embed\_dim)
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom IPython.display import Markdown, display
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
from llama\_index.storage.storage\_context import StorageContextstorage\_context = StorageContext.from\_defaults(vector\_store=neo4j\_vector)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What happened at interleaf?")display(Markdown(f"<b>{response}</b>"))
```
**At Interleaf, there was a group called Release Engineering that seemed to be as big as the group that actually wrote the software. The software at Interleaf had to be updated on the server, and there was a lot of work involved in maintaining and releasing new versions.**

Load existing vector index[](#load-existing-vector-index "Permalink to this heading")
--------------------------------------------------------------------------------------

In order to connect to an existing vector index, you need to define the `index\_name` and `text\_node\_property` parameters:

* index\_name: name of the existing vector index (default is `vector`)
* text\_node\_property: name of the property that containt the text value (default is `text`)


```
index\_name = "existing\_index"text\_node\_property = "text"existing\_vector = Neo4jVectorStore(    username,    password,    url,    embed\_dim,    index\_name=index\_name,    text\_node\_property=text\_node\_property,)loaded\_index = VectorStoreIndex.from\_vector\_store(existing\_vector)
```
Metadata filtering[](#metadata-filtering "Permalink to this heading")
----------------------------------------------------------------------

At the moment, the metadata filtering is not supported.

