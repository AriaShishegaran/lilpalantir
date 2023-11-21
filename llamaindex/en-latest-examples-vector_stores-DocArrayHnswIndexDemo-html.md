[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/DocArrayHnswIndexDemo.ipynb)

DocArray Hnsw Vector Store[](#docarray-hnsw-vector-store "Permalink to this heading")
======================================================================================

[DocArrayHnswVectorStore](https://docs.docarray.org/user_guide/storing/index_hnswlib/) is a lightweight Document Index implementation provided by [DocArray](https://github.com/docarray/docarray) that runs fully locally and is best suited for small- to medium-sized datasets. It stores vectors on disk in hnswlib, and stores all other data in SQLite.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport sysimport loggingimport textwrapimport warningswarnings.filterwarnings("ignore")# stop h|uggingface warningsos.environ["TOKENIZERS\_PARALLELISM"] = "false"# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import GPTVectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import DocArrayHnswVectorStorefrom IPython.display import Markdown, display
```

```
import osos.environ["OPENAI\_API\_KEY"] = "<your openai key>"
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,)
```

```
Document ID: 07d9ca27-ded0-46fa-9165-7e621216fd47 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e
```
Initialization and indexing[](#initialization-and-indexing "Permalink to this heading")
----------------------------------------------------------------------------------------


```
from llama\_index.storage.storage\_context import StorageContextvector\_store = DocArrayHnswVectorStore(work\_dir="hnsw\_index")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = GPTVectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Querying[](#querying "Permalink to this heading")
--------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(textwrap.fill(str(response), 100))
```

```
Token indices sequence length is longer than the specified maximum sequence length for this model (1830 > 1024). Running this sequence through the model will result in indexing errors
```

```
 Growing up, the author wrote short stories, programmed on an IBM 1401, and nagged his father to buyhim a TRS-80 microcomputer. He wrote simple games, a program to predict how high his model rocketswould fly, and a word processor. He also studied philosophy in college, but switched to AI afterbecoming bored with it. He then took art classes at Harvard and applied to art schools, eventuallyattending RISD.
```

```
response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```

```
 A hard moment for the author was when he realized that the AI programs of the time were a hoax andthat there was an unbridgeable gap between what they could do and actually understanding naturallanguage.
```
Querying with filters[](#querying-with-filters "Permalink to this heading")
----------------------------------------------------------------------------


```
from llama\_index.schema import TextNodenodes = [    TextNode(        text="The Shawshank Redemption",        metadata={            "author": "Stephen King",            "theme": "Friendship",        },    ),    TextNode(        text="The Godfather",        metadata={            "director": "Francis Ford Coppola",            "theme": "Mafia",        },    ),    TextNode(        text="Inception",        metadata={            "director": "Christopher Nolan",        },    ),]
```

```
from llama\_index.storage.storage\_context import StorageContextvector\_store = DocArrayHnswVectorStore(work\_dir="hnsw\_filters")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = GPTVectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])retriever = index.as\_retriever(filters=filters)retriever.retrieve("What is inception about?")
```

```
[NodeWithScore(node=Node(text='director: Francis Ford Coppola\ntheme: Mafia\n\nThe Godfather', doc_id='d96456bf-ef6e-4c1b-bdb8-e90a37d881f3', embedding=None, doc_hash='b770e43e6a94854a22dc01421d3d9ef6a94931c2b8dbbadf4fdb6eb6fbe41010', extra_info=None, node_info=None, relationships={<DocumentRelationship.SOURCE: '1'>: 'None'}), score=0.4634347)]
```

```
# remove created indicesimport os, shutilhnsw\_dirs = ["hnsw\_filters", "hnsw\_index"]for dir in hnsw\_dirs:    if os.path.exists(dir):        shutil.rmtree(dir)
```
