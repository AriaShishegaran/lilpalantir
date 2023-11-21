[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/MyScaleIndexDemo.ipynb)

MyScale Vector Store[](#myscale-vector-store "Permalink to this heading")
==========================================================================

In this notebook we are going to show a quick demo of using the MyScaleVectorStore.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Creating a MyScale Client[](#creating-a-myscale-client "Permalink to this heading")
------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from os import environimport clickhouse\_connectenviron["OPENAI\_API\_KEY"] = "sk-\*"# initialize clientclient = clickhouse\_connect.get\_client(    host="YOUR\_CLUSTER\_HOST",    port=8443,    username="YOUR\_USERNAME",    password="YOUR\_CLUSTER\_PASSWORD",)
```
Load documents, build and store the VectorStoreIndex with MyScaleVectorStore[](#load-documents-build-and-store-the-vectorstoreindex-with-myscalevectorstore "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Here we will use a set of Paul Graham essays to provide the text to turn into embeddings, store in a `MyScaleVectorStore` and query to find context for our LLM QnA loop.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import MyScaleVectorStorefrom IPython.display import Markdown, display
```

```
# load documentsdocuments = SimpleDirectoryReader("../data/paul\_graham").load\_data()print("Document ID:", documents[0].doc\_id)print("Number of Documents: ", len(documents))
```

```
Document ID: a5f2737c-ed18-4e5d-ab9a-75955edb816dNumber of Documents:  1
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
You can process your files individually using [SimpleDirectoryReader](../data_connectors/simple_directory_reader.html):


```
loader = SimpleDirectoryReader("./data/paul\_graham/")documents = loader.load\_data()for file in loader.input\_files:    print(file)    # Here is where you would do any preprocessing
```

```
../data/paul_graham/paul_graham_essay.txt
```

```
# initialize with metadata filter and store indexesfrom llama\_index.storage.storage\_context import StorageContextfor document in documents:    document.metadata = {"user\_id": "123", "favorite\_color": "blue"}vector\_store = MyScaleVectorStore(myscale\_client=client)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------

Now MyScale vector store supports filter search and hybrid search

You can learn more about [query\_engine](../../module_guides/deploying/query_engine/root.html) and [retriever](../../module_guides/querying/retriever/root.html).


```
import textwrapfrom llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFilters# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(    filters=MetadataFilters(        filters=[            ExactMatchFilter(key="user\_id", value="123"),        ]    ),    similarity\_top\_k=2,    vector\_store\_query\_mode="hybrid",)response = query\_engine.query("What did the author learn?")print(textwrap.fill(str(response), 100))
```
Clear All Indexes[](#clear-all-indexes "Permalink to this heading")
--------------------------------------------------------------------


```
for document in documents:    index.delete\_ref\_doc(document.doc\_id)
```
