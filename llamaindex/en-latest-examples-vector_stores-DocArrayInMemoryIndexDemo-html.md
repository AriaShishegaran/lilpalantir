[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/DocArrayInMemoryIndexDemo.ipynb)

DocArray InMemory Vector Store[](#docarray-inmemory-vector-store "Permalink to this heading")
==============================================================================================

[DocArrayInMemoryVectorStore](https://docs.docarray.org/user_guide/storing/index_in_memory/) is a document index provided by [Docarray](https://github.com/docarray/docarray) that stores documents in memory. It is a great starting point for small datasets, where you may not want to launch a database server.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport sysimport loggingimport textwrapimport warningswarnings.filterwarnings("ignore")# stop huggingface warningsos.environ["TOKENIZERS\_PARALLELISM"] = "false"# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import GPTVectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import DocArrayInMemoryVectorStorefrom IPython.display import Markdown, display
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
Document ID: 1c21062a-50a3-4133-a0b1-75f837a953e5 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e
```
Initialization and indexing[](#initialization-and-indexing "Permalink to this heading")
----------------------------------------------------------------------------------------


```
from llama\_index.storage.storage\_context import StorageContextvector\_store = DocArrayInMemoryVectorStore()storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = GPTVectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
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
 A hard moment for the author was when he realized that the AI programs of the time were a hoax andthat there was an unbridgeable gap between what they could do and actually understanding naturallanguage. He had invested a lot of time and energy into learning about AI and was disappointed tofind out that it was not going to get him the results he had hoped for.
```
Querying with filters[](#querying-with-filters "Permalink to this heading")
----------------------------------------------------------------------------


```
from llama\_index.schema import TextNodenodes = [    TextNode(        text="The Shawshank Redemption",        metadata={            "author": "Stephen King",            "theme": "Friendship",        },    ),    TextNode(        text="The Godfather",        metadata={            "director": "Francis Ford Coppola",            "theme": "Mafia",        },    ),    TextNode(        text="Inception",        metadata={            "director": "Christopher Nolan",        },    ),]
```

```
from llama\_index.storage.storage\_context import StorageContextvector\_store = DocArrayInMemoryVectorStore()storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = GPTVectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])retriever = index.as\_retriever(filters=filters)retriever.retrieve("What is inception about?")
```

```
[NodeWithScore(node=Node(text='director: Francis Ford Coppola\ntheme: Mafia\n\nThe Godfather', doc_id='41c99963-b200-4ce6-a9c4-d06ffeabdbc5', embedding=None, doc_hash='b770e43e6a94854a22dc01421d3d9ef6a94931c2b8dbbadf4fdb6eb6fbe41010', extra_info=None, node_info=None, relationships={<DocumentRelationship.SOURCE: '1'>: 'None'}), score=0.7681788983417586)]
```
