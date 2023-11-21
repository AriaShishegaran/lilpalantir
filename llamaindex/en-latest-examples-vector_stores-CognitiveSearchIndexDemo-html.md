[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/CognitiveSearchIndexDemo.ipynb)

Azure Cognitive Search[](#azure-cognitive-search "Permalink to this heading")
==============================================================================

Basic Example[](#basic-example "Permalink to this heading")
============================================================

In this basic example, we take a Paul Graham essay, split it into chunks, embed it using an OpenAI embedding model, load it into an Azure Cognitive Search index, and then query it.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysfrom IPython.display import Markdown, display# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))# logger = logging.getLogger(\_\_name\_\_)
```

```
#!{sys.executable} -m pip install llama-index#!{sys.executable} -m pip install azure-search-documents==11.4.0b8#!{sys.executable} -m pip install azure-identity
```

```
# set up OpenAIimport osimport getpassos.environ["OPENAI\_API\_KEY"] = getpass.getpass("OpenAI API Key:")import openaiopenai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
# set up Azure Cognitive Searchfrom azure.search.documents.indexes import SearchIndexClientfrom azure.search.documents import SearchClientfrom azure.core.credentials import AzureKeyCredentialsearch\_service\_name = getpass.getpass("Azure Cognitive Search Service Name")key = getpass.getpass("Azure Cognitive Search Key")cognitive\_search\_credential = AzureKeyCredential(key)service\_endpoint = f"https://{search\_service\_name}.search.windows.net"# Index name to useindex\_name = "quickstart"# Use index client to demonstrate creating an indexindex\_client = SearchIndexClient(    endpoint=service\_endpoint,    credential=cognitive\_search\_credential,)# Use search client to demonstration using existing indexsearch\_client = SearchClient(    endpoint=service\_endpoint,    index\_name=index\_name,    credential=cognitive\_search\_credential,)
```
Create Index (if it does not exist)[](#create-index-if-it-does-not-exist "Permalink to this heading")
======================================================================================================

Demonstrates creating a vector index named quickstart01 if one doesn’t exist. The index has the following fields:

* id (Edm.String)
* content (Edm.String)
* embedding (Edm.SingleCollection)
* li\_jsonMetadata (Edm.String)
* li\_doc\_id (Edm.String)
* author (Edm.String)
* theme (Edm.String)
* director (Edm.String)


```
from azure.search.documents import SearchClientfrom llama\_index.vector\_stores import CognitiveSearchVectorStorefrom llama\_index.vector\_stores.cogsearch import (    IndexManagement,    MetadataIndexFieldType,    CognitiveSearchVectorStore,)# Example of a complex mapping, metadata field 'theme' is mapped to a differently name index field 'topic' with its type explicitly setmetadata\_fields = {    "author": "author",    "theme": ("topic", MetadataIndexFieldType.STRING),    "director": "director",}# A simplified metadata specification is available if all metadata and index fields are similarly named# metadata\_fields = {"author", "theme", "director"}vector\_store = CognitiveSearchVectorStore(    search\_or\_index\_client=index\_client,    index\_name=index\_name,    filterable\_metadata\_field\_keys=metadata\_fields,    index\_management=IndexManagement.CREATE\_IF\_NOT\_EXISTS,    id\_field\_key="id",    chunk\_field\_key="content",    embedding\_field\_key="embedding",    metadata\_string\_field\_key="li\_jsonMetadata",    doc\_id\_field\_key="li\_doc\_id",)
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# define embedding functionfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    SimpleDirectoryReader,    StorageContext,    ServiceContext,    VectorStoreIndex,)embed\_model = OpenAIEmbedding()# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, service\_context=service\_context)
```

```
# Query Dataquery\_engine = index.as\_query\_engine(similarity\_top\_k=3)response = query\_engine.query("What did the author do growing up?")display(Markdown(f"<b>{response}</b>"))
```
**The author wrote short stories and programmed on an IBM 1401 computer during their time in school. They later got their own microcomputer, a TRS-80, and started programming games and a word processor.**


```
response = query\_engine.query(    "What did the author learn?",)display(Markdown(f"<b>{response}</b>"))
```
**The author learned several things during their time at Interleaf. They learned that it’s better for technology companies to be run by product people than sales people, that code edited by too many people leads to bugs, that cheap office space is not worth it if it’s depressing, that planned meetings are inferior to corridor conversations, that big bureaucratic customers can be a dangerous source of money, and that there’s not much overlap between conventional office hours and the optimal time for hacking. However, the most important thing the author learned is that the low end eats the high end, meaning that it’s better to be the “entry level” option because if you’re not, someone else will be and will surpass you.**

Use Existing Index[](#use-existing-index "Permalink to this heading")
======================================================================


```
from llama\_index.vector\_stores import CognitiveSearchVectorStorefrom llama\_index.vector\_stores.cogsearch import (    IndexManagement,    MetadataIndexFieldType,    CognitiveSearchVectorStore,)index\_name = "quickstart"metadata\_fields = {    "author": "author",    "theme": ("topic", MetadataIndexFieldType.STRING),    "director": "director",}vector\_store = CognitiveSearchVectorStore(    search\_or\_index\_client=search\_client,    filterable\_metadata\_field\_keys=metadata\_fields,    index\_management=IndexManagement.NO\_VALIDATION,    id\_field\_key="id",    chunk\_field\_key="content",    embedding\_field\_key="embedding",    metadata\_string\_field\_key="li\_jsonMetadata",    doc\_id\_field\_key="li\_doc\_id",)
```

```
# define embedding functionfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    SimpleDirectoryReader,    StorageContext,    ServiceContext,    VectorStoreIndex,)embed\_model = OpenAIEmbedding()storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    [], storage\_context=storage\_context, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What was a hard moment for the author?")display(Markdown(f"<b>{response}</b>"))
```
**The author experienced a difficult moment when their mother had a stroke and was put in a nursing home. The stroke destroyed her balance, and the author and their sister were determined to help her get out of the nursing home and back to her house.**


```
response = query\_engine.query("Who is the author?")display(Markdown(f"<b>{response}</b>"))
```
**The author of the given context is Paul Graham.**


```
import timequery\_engine = index.as\_query\_engine(streaming=True)response = query\_engine.query("What happened at interleaf?")start\_time = time.time()token\_count = 0for token in response.response\_gen:    print(token, end="")    token\_count += 1time\_elapsed = time.time() - start\_timetokens\_per\_second = token\_count / time\_elapsedprint(f"\n\nStreamed output at {tokens\_per\_second} tokens/s")
```

```
At Interleaf, there was a group called Release Engineering that seemed to be as big as the group that actually wrote the software. The software at Interleaf had to be updated on the server, and there was a lot of emphasis on high production values to make the online store builders look legitimate.Streamed output at 20.953424485215063 tokens/s
```
Adding a document to existing index[](#adding-a-document-to-existing-index "Permalink to this heading")
========================================================================================================


```
response = query\_engine.query("What colour is the sky?")display(Markdown(f"<b>{response}</b>"))
```
**The color of the sky can vary depending on various factors such as time of day, weather conditions, and location. It can range from shades of blue during the day to hues of orange, pink, and purple during sunrise or sunset.**


```
from llama\_index import Documentindex.insert\_nodes([Document(text="The sky is indigo today")])
```

```
response = query\_engine.query("What colour is the sky?")display(Markdown(f"<b>{response}</b>"))
```
**The colour of the sky is indigo.**

Filtering[](#filtering "Permalink to this heading")
====================================================


```
from llama\_index.schema import TextNodenodes = [    TextNode(        text="The Shawshank Redemption",        metadata={            "author": "Stephen King",            "theme": "Friendship",        },    ),    TextNode(        text="The Godfather",        metadata={            "director": "Francis Ford Coppola",            "theme": "Mafia",        },    ),    TextNode(        text="Inception",        metadata={            "director": "Christopher Nolan",        },    ),]
```

```
index.insert\_nodes(nodes)
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])retriever = index.as\_retriever(filters=filters)retriever.retrieve("What is inception about?")
```

```
[NodeWithScore(node=TextNode(id_='5a97da0c-8f04-4c63-b90b-8c474d8c273d', embedding=None, metadata={'director': 'Francis Ford Coppola', 'theme': 'Mafia'}, excluded_embed_metadata_keys=[], excluded_llm_metadata_keys=[], relationships={}, hash='81cf4b9e847ba42e83fc401e31af8e17d629f0d5cf9c0c320ec7ac69dd0257e1', text='The Godfather', start_char_idx=None, end_char_idx=None, text_template='{metadata_str}\n\n{content}', metadata_template='{key}: {value}', metadata_seperator='\n'), score=0.81316805)]
```
