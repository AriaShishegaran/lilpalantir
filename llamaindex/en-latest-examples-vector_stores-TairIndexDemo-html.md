[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/TairIndexDemo.ipynb)

Tair Vector Store[](#tair-vector-store "Permalink to this heading")
====================================================================

In this notebook we are going to show a quick demo of using the TairVectorStore.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport sysimport loggingimport textwrapimport warningswarnings.filterwarnings("ignore")# stop huggingface warningsos.environ["TOKENIZERS\_PARALLELISM"] = "false"# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import GPTVectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import TairVectorStorefrom IPython.display import Markdown, display
```
Setup OpenAI[](#setup-openai "Permalink to this heading")
----------------------------------------------------------

Lets first begin by adding the openai api key. This will allow us to access openai for embeddings and to use chatgpt.


```
import osos.environ["OPENAI\_API\_KEY"] = "sk-<your key here>"
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Read in a dataset[](#read-in-a-dataset "Permalink to this heading")
--------------------------------------------------------------------


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()print(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,)
```
Build index from documents[](#build-index-from-documents "Permalink to this heading")
--------------------------------------------------------------------------------------

Let’s build a vector index with `GPTVectorStoreIndex`, using `TairVectorStore` as its backend. Replace `tair\_url` with the actual url of your Tair instance.


```
from llama\_index.storage.storage\_context import StorageContexttair\_url = "redis://{username}:{password}@r-bp\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*.redis.rds.aliyuncs.com:{port}"vector\_store = TairVectorStore(    tair\_url=tair\_url, index\_name="pg\_essays", overwrite=True)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = GPTVectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query the data[](#query-the-data "Permalink to this heading")
--------------------------------------------------------------

Now we can use the index as knowledge base and ask questions to it.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author learn?")print(textwrap.fill(str(response), 100))
```

```
response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```
Deleting documents[](#deleting-documents "Permalink to this heading")
----------------------------------------------------------------------

To delete a document from the index, use `delete` method.


```
document\_id = documents[0].doc\_iddocument\_id
```

```
info = vector\_store.client.tvs\_get\_index("pg\_essays")print("Number of documents", int(info["data\_count"]))
```

```
vector\_store.delete(document\_id)
```

```
info = vector\_store.client.tvs\_get\_index("pg\_essays")print("Number of documents", int(info["data\_count"]))
```
Deleting index[](#deleting-index "Permalink to this heading")
--------------------------------------------------------------

Delete the entire index using `delete\_index` method.


```
vector\_store.delete\_index()
```

```
print("Check index existence:", vector\_store.client.\_index\_exists())
```
