[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/QdrantIndexDemo.ipynb)

Qdrant Vector Store[](#qdrant-vector-store "Permalink to this heading")
========================================================================

Creating a Qdrant client[](#creating-a-qdrant-client "Permalink to this heading")
----------------------------------------------------------------------------------


```
import loggingimport sysimport osimport qdrant\_clientfrom IPython.display import Markdown, displayfrom llama\_index import (    VectorStoreIndex,    ServiceContext,    SimpleDirectoryReader,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.vector\_stores.qdrant import QdrantVectorStore
```
If running this for the first, time, install using this command:


```
!pip install -U qdrant_client
```

```
os.environ["OPENAI\_API\_KEY"] = "YOUR OPENAI API KEY"
```

```
logging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load the documents[](#load-the-documents "Permalink to this heading")
----------------------------------------------------------------------


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
Build the VectorStoreIndex[](#build-the-vectorstoreindex "Permalink to this heading")
--------------------------------------------------------------------------------------


```
client = qdrant\_client.QdrantClient(    # you can use :memory: mode for fast and light-weight experiments,    # it does not require to have Qdrant deployed anywhere    # but requires qdrant-client >= 1.1.1    location=":memory:"    # otherwise set Qdrant instance address with:    # uri="http://<host>:<port>"    # set API KEY for Qdrant Cloud    # api\_key="<qdrant-api-key>",)
```

```
service\_context = ServiceContext.from\_defaults()vector\_store = QdrantVectorStore(client=client, collection\_name="paul\_graham")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, service\_context=service\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on the IBM 1401 computer. They also mentioned getting a microcomputer, specifically a TRS-80, and started programming on it.**


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query(    "What did the author do after his time at Viaweb?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**After his time at Viaweb, the author decided to pursue his passion for painting. He left Yahoo, where he had been working after Viaweb was acquired, and immediately started painting. However, he struggled with energy and ambition, and eventually returned to New York to resume his old life as a painter.**

Build the VectorStoreIndex asynchronously[](#build-the-vectorstoreindex-asynchronously "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------


```
# To connect to the same event-loop,# allows async events to run on notebookimport nest\_asyncionest\_asyncio.apply()
```

```
client = qdrant\_client.QdrantClient(    # location=":memory:"    # Async upsertion does not work    # on 'memory' location and requires    # Qdrant to be deployed somewhere.    url="http://localhost:6334",    prefer\_grpc=True,    # set API KEY for Qdrant Cloud    # api\_key="<qdrant-api-key>",)
```

```
service\_context = ServiceContext.from\_defaults()vector\_store = QdrantVectorStore(    client=client, collection\_name="paul\_graham", prefer\_grpc=True)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents,    storage\_context=storage\_context,    service\_context=service\_context,    use\_async=True,)
```
Async Query Index[](#async-query-index "Permalink to this heading")
--------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine(use\_async=True)response = await query\_engine.aquery("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming outside of school. They wrote short stories and tried writing programs on the IBM 1401 computer. They also built a microcomputer and started programming on it, writing simple games and a word processor.**


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(use\_async=True)response = await query\_engine.aquery(    "What did the author do after his time at Viaweb?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**After his time at Viaweb, the author started working on a new idea. He decided to move to Cambridge and start a new company. However, he faced difficulties in finding a partner to work on the idea with him. Eventually, he recruited a team and began building a new dialect of Lisp called Arc. He also gave a talk at a Lisp conference and posted a file of the talk online, which gained a significant audience.**

