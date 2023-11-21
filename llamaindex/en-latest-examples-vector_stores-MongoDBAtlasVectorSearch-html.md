[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/MongoDBAtlasVectorSearch.ipynb)

MongoDB Atlas[](#mongodb-atlas "Permalink to this heading")
============================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Provide URI to constructor, or use environment variableimport pymongofrom llama\_index.vector\_stores.mongodb import MongoDBAtlasVectorSearchfrom llama\_index.indices.vector\_store.base import VectorStoreIndexfrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.readers.file.base import SimpleDirectoryReader
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/10k/uber_2021.pdf' -O 'data/10k/uber_2021.pdf'
```

```
# mongo\_uri = os.environ["MONGO\_URI"]mongo\_uri = (    "mongodb+srv://<username>:<password>@<host>?retryWrites=true&w=majority")mongodb\_client = pymongo.MongoClient(mongo\_uri)store = MongoDBAtlasVectorSearch(mongodb\_client)storage\_context = StorageContext.from\_defaults(vector\_store=store)uber\_docs = SimpleDirectoryReader(    input\_files=["./data/10k/uber\_2021.pdf"]).load\_data()index = VectorStoreIndex.from\_documents(    uber\_docs, storage\_context=storage\_context)
```

```
response = index.as\_query\_engine().query("What was Uber's revenue?")display(Markdown(f"<b>{response}</b>"))
```
**Uber's revenue for 2021 was $17,455 million.**
```
from llama\_index.response.schema import Response# Initial sizeprint(store.\_collection.count\_documents({}))# Get a ref\_doc\_idtyped\_response = (    response if isinstance(response, Response) else response.get\_response())ref\_doc\_id = typed\_response.source\_nodes[0].node.ref\_doc\_idprint(store.\_collection.count\_documents({"metadata.ref\_doc\_id": ref\_doc\_id}))# Test store deleteif ref\_doc\_id:    store.delete(ref\_doc\_id)    print(store.\_collection.count\_documents({}))
```

```
445414453
```
Note: For MongoDB Atlas, you have to additionally create an Atlas Search Index.

[Mongo DB Docs | How to Index Vector Embeddings for Vector Search](https://www.mongodb.com/docs/atlas/atlas-search/field-types/knn-vector/)

