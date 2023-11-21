[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/MilvusIndexDemo.ipynb)

Milvus Vector Store[](#milvus-vector-store "Permalink to this heading")
========================================================================

In this notebook we are going to show a quick demo of using the MilvusVectorStore.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sys# Uncomment to see debug logs# logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import VectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import MilvusVectorStorefrom IPython.display import Markdown, displayimport textwrap
```
Setup OpenAI[](#setup-openai "Permalink to this heading")
----------------------------------------------------------

Lets first begin by adding the openai api key. This will allow us to access openai for embeddings and to use chatgpt.


```
import openaiopenai.api\_key = "sk-"
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Generate our data[](#generate-our-data "Permalink to this heading")
--------------------------------------------------------------------

With our LLM set, lets start using the Milvus Index. As a first example, lets generate a document from the file found in the `data/paul\_graham/` folder. In this folder there is a single essay from Paul Graham titled `What I Worked On`. To generate the documents we will use the SimpleDirectoryReader.


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print("Document ID:", documents[0].doc\_id)
```

```
Document ID: d33f0397-b51a-4455-9b0f-88a101254d95
```
Create an index across the data[](#create-an-index-across-the-data "Permalink to this heading")
------------------------------------------------------------------------------------------------

Now that we have a document, we can can create an index and insert the document. For the index we will use a GPTMilvusIndex. GPTMilvusIndex takes in a few arguments:

* collection\_name (str, optional): The name of the collection where data will be stored. Defaults to “llamalection”.
* index\_params (dict, optional): The index parameters for Milvus, if none are provided an HNSW index will be used. Defaults to None.
* search\_params (dict, optional): The search parameters for a Milvus query. If none are provided, default params will be generated. Defaults to None.
* dim (int, optional): The dimension of the embeddings. If it is not provided, collection creation will be done on first insert. Defaults to None.
* host (str, optional): The host address of Milvus. Defaults to “localhost”.
* port (int, optional): The port of Milvus. Defaults to 19530.
* user (str, optional): The username for RBAC. Defaults to “”.
* password (str, optional): The password for RBAC. Defaults to “”.
* use\_secure (bool, optional): Use https. Defaults to False.
* overwrite (bool, optional): Whether to overwrite existing collection with same name. Defaults to False.


```
# Create an index over the documntsfrom llama\_index.storage.storage\_context import StorageContextvector\_store = MilvusVectorStore(dim=1536, overwrite=True)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query the data[](#query-the-data "Permalink to this heading")
--------------------------------------------------------------

Now that we have our document stored in the index, we can ask questions against the index. The index will use the data stored in itself as the knowledge base for chatgpt.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author learn?")print(textwrap.fill(str(response), 100))
```

```
The author learned several things during their time at Interleaf. They learned that it's better fortechnology companies to be run by product people than sales people, that code edited by too manypeople leads to bugs, that cheap office space is not worth it if it's depressing, that plannedmeetings are inferior to corridor conversations, that big bureaucratic customers can be a dangeroussource of money, and that there's not much overlap between conventional office hours and the optimaltime for hacking. However, the most important thing the author learned is that the low end eats thehigh end, meaning that it's advantageous to be the "entry level" option because if you're not,someone else will be and will surpass you.
```

```
response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```

```
The author experienced a difficult moment when their mother had a stroke and was put in a nursinghome. The stroke destroyed her balance, and the author and their sister were determined to help herget out of the nursing home and back to her house.
```
This next test shows that overwriting removes the previous data.


```
vector\_store = MilvusVectorStore(dim=1536, overwrite=True)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    [Document(text="The number that is being searched for is ten.")],    storage\_context,)query\_engine = index.as\_query\_engine()res = query\_engine.query("Who is the author?")print("Res:", res)
```

```
Res: I'm sorry, but based on the given context information, there is no information provided about the author.
```
The next test shows adding additional data to an already existing index.


```
del index, vector\_store, storage\_context, query\_enginevector\_store = MilvusVectorStore(overwrite=False)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)query\_engine = index.as\_query\_engine()res = query\_engine.query("What is the number?")print("Res:", res)
```

```
Res: The number is ten.
```

```
res = query\_engine.query("Who is the author?")print("Res:", res)
```

```
Res: The author of the given context is Paul Graham.
```
