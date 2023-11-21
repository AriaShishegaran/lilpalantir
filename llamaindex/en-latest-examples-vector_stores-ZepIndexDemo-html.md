[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/ZepIndexDemo.ipynb)

Zep Vector Store[](#zep-vector-store "Permalink to this heading")
==================================================================

A long-term memory store for LLM applications[](#a-long-term-memory-store-for-llm-applications "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

This notebook demonstrates how to use the Zep Vector Store with LlamaIndex.

About Zep[](#about-zep "Permalink to this heading")
----------------------------------------------------

Zep makes it easy for developers to add relevant documents, chat history memory & rich user data to their LLM app’s prompts.

Note[](#note "Permalink to this heading")
------------------------------------------

Zep can automatically embed your documents. The LlamaIndex implementation of the Zep Vector Store utilizes LlamaIndex’s embedders to do so.

Getting Started[](#getting-started "Permalink to this heading")
----------------------------------------------------------------

**Quick Start Guide:** https://docs.getzep.com/deployment/quickstart/**GitHub:** https://github.com/getzep/zep

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# !pip install zep-python
```

```
import loggingimport sysfrom uuid import uuid4logging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))import osimport openaifrom dotenv import load\_dotenvload\_dotenv()# os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores.zep import ZepVectorStore
```

```
INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("../data/paul\_graham/").load\_data()
```
Create a Zep Vector Store and Index[](#create-a-zep-vector-store-and-index "Permalink to this heading")
========================================================================================================

You can use an existing Zep Collection, or create a new one.


```
from llama\_index.storage.storage\_context import StorageContextzep\_api\_url = "http://localhost:8000"collection\_name = f"graham{uuid4().hex}"vector\_store = ZepVectorStore(    api\_url=zep\_api\_url,    collection\_name=collection\_name,    embedding\_dimensions=1536,)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```

```
INFO:httpx:HTTP Request: GET http://localhost:8000/healthz "HTTP/1.1 200 OK"HTTP Request: GET http://localhost:8000/healthz "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: GET http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 404 Not Found"HTTP Request: GET http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 404 Not Found"INFO:llama_index.vector_stores.zep:Collection grahamfbf0c456a2ad46c2887a707ccc7bb5df does not exist, will try creating one with dimensions=1536Collection grahamfbf0c456a2ad46c2887a707ccc7bb5df does not exist, will try creating one with dimensions=1536INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: GET http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 200 OK"HTTP Request: GET http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df/document "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df/document "HTTP/1.1 200 OK"
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(str(response))
```

```
INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df/search?limit=2 "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/grahamfbf0c456a2ad46c2887a707ccc7bb5df/search?limit=2 "HTTP/1.1 200 OK"The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer and started programming more extensively, writing simple games, a program to predict rocket heights, and a word processor. They initially planned to study philosophy in college but switched to AI. They also started publishing essays online and realized the potential of the web as a medium for publishing.
```
Querying with Metadata filters[](#querying-with-metadata-filters "Permalink to this heading")
==============================================================================================


```
from llama\_index.schema import TextNodenodes = [    TextNode(        text="The Shawshank Redemption",        metadata={            "author": "Stephen King",            "theme": "Friendship",        },    ),    TextNode(        text="The Godfather",        metadata={            "director": "Francis Ford Coppola",            "theme": "Mafia",        },    ),    TextNode(        text="Inception",        metadata={            "director": "Christopher Nolan",        },    ),]
```

```
collection\_name = f"movies{uuid4().hex}"vector\_store = ZepVectorStore(    api\_url=zep\_api\_url,    collection\_name=collection\_name,    embedding\_dimensions=1536,)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
INFO:httpx:HTTP Request: GET http://localhost:8000/healthz "HTTP/1.1 200 OK"HTTP Request: GET http://localhost:8000/healthz "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: GET http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 404 Not Found"HTTP Request: GET http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 404 Not Found"INFO:llama_index.vector_stores.zep:Collection movies40ffd4f8a68c4822ae1680bb752c07e1 does not exist, will try creating one with dimensions=1536Collection movies40ffd4f8a68c4822ae1680bb752c07e1 does not exist, will try creating one with dimensions=1536INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: GET http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 200 OK"HTTP Request: GET http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1 "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1/document "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1/document "HTTP/1.1 200 OK"
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])
```

```
retriever = index.as\_retriever(filters=filters)result = retriever.retrieve("What is inception about?")for r in result:    print("\n", r.node)    print("Score:", r.score)
```

```
INFO:httpx:HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1/search?limit=2 "HTTP/1.1 200 OK"HTTP Request: POST http://localhost:8000/api/v1/collection/movies40ffd4f8a68c4822ae1680bb752c07e1/search?limit=2 "HTTP/1.1 200 OK" Node ID: 2b5ad50a-8ec0-40fa-b401-6e6b7ac3d304Text: The GodfatherScore: 0.8841066656525941
```
