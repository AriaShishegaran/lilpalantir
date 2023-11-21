[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/SupabaseVectorIndexDemo.ipynb)

Supabase Vector Store[](#supabase-vector-store "Permalink to this heading")
============================================================================

In this notebook we are going to show how to use [Vecs](https://supabase.github.io/vecs/) to perform vector searches in LlamaIndex.  
See [this guide](https://supabase.github.io/vecs/hosting/) for instructions on hosting a database on Supabase

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sys# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import SimpleDirectoryReader, Document, StorageContextfrom llama\_index.indices.vector\_store import VectorStoreIndexfrom llama\_index.vector\_stores import SupabaseVectorStoreimport textwrap
```
Setup OpenAI[](#setup-openai "Permalink to this heading")
----------------------------------------------------------

The first step is to configure the OpenAI key. It will be used to created embeddings for the documents loaded into the index


```
import osos.environ["OPENAI\_API\_KEY"] = "[your\_openai\_api\_key]"
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Loading documents[](#loading-documents "Permalink to this heading")
--------------------------------------------------------------------

Load the documents stored in the `./data/paul\_graham/` using the SimpleDirectoryReader


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,)
```

```
Document ID: fb056993-ee9e-4463-80b4-32cf9509d1d8 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e
```
Create an index backed by Supabase’s vector store.[](#create-an-index-backed-by-supabase-s-vector-store "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------

This will work with all Postgres providers that support pgvector.If the collection does not exist, we will attempt to create a new collection


> Note: you need to pass in the embedding dimension if not using OpenAI’s text-embedding-ada-002, e.g. `vector\_store = SupabaseVectorStore(..., dimension=...)`
> 
> 


```
vector\_store = SupabaseVectorStore(    postgres\_connection\_string=(        "postgresql://<user>:<password>@<host>:<port>/<db\_name>"    ),    collection\_name="base\_demo",)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query the index[](#query-the-index "Permalink to this heading")
----------------------------------------------------------------

We can now ask questions using our index.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Who is the author?")
```

```
/Users/suo/miniconda3/envs/llama/lib/python3.9/site-packages/vecs/collection.py:182: UserWarning: Query does not have a covering index for cosine_distance. See Collection.create_index  warnings.warn(
```

```
print(textwrap.fill(str(response), 100))
```

```
 The author of this text is Paul Graham.
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(textwrap.fill(str(response), 100))
```

```
 The author grew up writing essays, learning Italian, exploring Florence, painting people, workingwith computers, attending RISD, living in a rent-stabilized apartment, building an online storebuilder, editing Lisp expressions, publishing essays online, writing essays, painting still life,working on spam filters, cooking for groups, and buying a building in Cambridge.
```
Using metadata filters[](#using-metadata-filters "Permalink to this heading")
------------------------------------------------------------------------------


```
from llama\_index.schema import TextNodenodes = [    TextNode(        "The Shawshank Redemption",        metadata={            "author": "Stephen King",            "theme": "Friendship",        },    ),    TextNode(        "The Godfather",        metadata={            "director": "Francis Ford Coppola",            "theme": "Mafia",        },    ),    TextNode(        "Inception",        metadata={            "director": "Christopher Nolan",        },    ),]
```

```
vector\_store = SupabaseVectorStore(    postgres\_connection\_string=(        "postgresql://<user>:<password>@<host>:<port>/<db\_name>"    ),    collection\_name="metadata\_filters\_demo",)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Define metadata filters


```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="theme", value="Mafia")])
```
Retrieve from vector store with filters


```
retriever = index.as\_retriever(filters=filters)retriever.retrieve("What is inception about?")
```

```
[NodeWithScore(node=Node(text='The Godfather', doc_id='f837ed85-aacb-4552-b88a-7c114a5be15d', embedding=None, doc_hash='f8ee912e238a39fe2e620fb232fa27ade1e7f7c819b6d5b9cb26f3dddc75b6c0', extra_info={'theme': 'Mafia', 'director': 'Francis Ford Coppola'}, node_info={'_node_type': '1'}, relationships={}), score=0.20671339734643313)]
```
