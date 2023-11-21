[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/WeaviateIndexDemo.ipynb)

Weaviate Vector Store[](#weaviate-vector-store "Permalink to this heading")
============================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Creating a Weaviate Client[](#creating-a-weaviate-client "Permalink to this heading")
--------------------------------------------------------------------------------------


```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY\_HERE"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
import weaviate
```

```
# cloudresource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)client = weaviate.Client(    "https://llama-test-ezjahb4m.weaviate.network",    auth\_client\_secret=resource\_owner\_config,)# local# client = weaviate.Client("http://localhost:8080")
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import WeaviateVectorStorefrom IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
from llama\_index.storage.storage\_context import StorageContext# If you want to load the index later, be sure to give it a name!vector\_store = WeaviateVectorStore(    weaviate\_client=client, index\_name="LlamaIndex")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)# NOTE: you may also choose to define a index\_name manually.# index\_name = "test\_prefix"# vector\_store = WeaviateVectorStore(weaviate\_client=client, index\_name=index\_name)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Growing up, the author wrote short stories, experimented with programming on an IBM 1401, nagged his father to buy a TRS-80 computer, wrote simple games, a program to predict how high his model rockets would fly, and a word processor. He also studied philosophy in college, switched to AI, and worked on building the infrastructure of the web. He wrote essays and published them online, had dinners for a group of friends every Thursday night, painted, and bought a building in Cambridge.**Loading the index[](#loading-the-index "Permalink to this heading")
--------------------------------------------------------------------

Here, we use the same index name as when we created the initial index. This stops it from being auto-generated and allows us to easily connect back to it.


```
resource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)client = weaviate.Client(    "https://llama-test-ezjahb4m.weaviate.network",    auth\_client\_secret=resource\_owner\_config,)# local# client = weaviate.Client("http://localhost:8080")
```

```
vector\_store = WeaviateVectorStore(    weaviate\_client=client, index\_name="LlamaIndex")loaded\_index = VectorStoreIndex.from\_vector\_store(vector\_store)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = loaded\_index.as\_query\_engine()response = query\_engine.query("What happened at interleaf?")display(Markdown(f"<b>{response}</b>"))
```
**At Interleaf, a group of people worked on projects for customers. One of the employees told the narrator about a new thing called HTML, which was a derivative of SGML. The narrator left Interleaf to go back to RISD and did freelance work for the group that did projects for customers. Later, the narrator and a college friend started a new company called Viaweb, which was a web app that allowed users to build stores through the browser. They got seed funding and recruited two programmers to help them build the software. They opened for business in January 1996 with 6 stores.**Metadata Filtering[](#metadata-filtering "Permalink to this heading")
----------------------------------------------------------------------

Let’s insert a dummy document, and try to filter so that only that document is returned.


```
from llama\_index import Documentdoc = Document.example()print(doc.metadata)print("-----")print(doc.text[:100])
```

```
{'filename': 'README.md', 'category': 'codebase'}-----ContextLLMs are a phenomenonal piece of technology for knowledge generation and reasoning. They a
```

```
loaded\_index.insert(doc)
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="filename", value="README.md")])query\_engine = loaded\_index.as\_query\_engine(filters=filters)response = query\_engine.query("What is the name of the file?")display(Markdown(f"<b>{response}</b>"))
```
**The name of the file is README.md.**