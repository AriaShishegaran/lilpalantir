[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/AzureCosmosDBMongoDBvCoreDemo.ipynb)

Azure CosmosDB MongoDB Vector Store[](#azure-cosmosdb-mongodb-vector-store "Permalink to this heading")
========================================================================================================

In this notebook we are going to show how to use Azure Cosmosdb Mongodb vCore to perform vector searches in LlamaIndex. We will create the embedding using Azure Open AI.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport jsonimport openaifrom llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContext
```
Setup Azure OpenAI[](#setup-azure-openai "Permalink to this heading")
----------------------------------------------------------------------

The first step is to configure the models. They will be used to create embeddings for the documents loaded into the db and for llm completions.


```
import os# Set up the AzureOpenAI instancellm = AzureOpenAI(    model\_name=os.getenv("OPENAI\_MODEL\_COMPLETION"),    deployment\_name=os.getenv("OPENAI\_MODEL\_COMPLETION"),    api\_base=os.getenv("OPENAI\_API\_BASE"),    api\_key=os.getenv("OPENAI\_API\_KEY"),    api\_type=os.getenv("OPENAI\_API\_TYPE"),    api\_version=os.getenv("OPENAI\_API\_VERSION"),    temperature=0,)# Set up the OpenAIEmbedding instanceembed\_model = OpenAIEmbedding(    model=os.getenv("OPENAI\_MODEL\_EMBEDDING"),    deployment\_name=os.getenv("OPENAI\_DEPLOYMENT\_EMBEDDING"),    api\_base=os.getenv("OPENAI\_API\_BASE"),    api\_key=os.getenv("OPENAI\_API\_KEY"),    api\_type=os.getenv("OPENAI\_API\_TYPE"),    api\_version=os.getenv("OPENAI\_API\_VERSION"),)
```

```
from llama\_index import set\_global\_service\_contextservice\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)set\_global\_service\_context(service\_context)
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Loading documents[](#loading-documents "Permalink to this heading")
--------------------------------------------------------------------

Load the documents stored in the `data/paul\_graham/` using the SimpleDirectoryReader


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print("Document ID:", documents[0].doc\_id)
```

```
Document ID: c432ff1c-61ea-4c91-bd89-62be29078e79
```
Create the index[](#create-the-index "Permalink to this heading")
------------------------------------------------------------------

Here we establish the connection to an Azure Cosmosdb mongodb vCore cluster and create an vector search index.


```
import pymongofrom llama\_index.vector\_stores.azurecosmosmongo import (    AzureCosmosDBMongoDBVectorSearch,)from llama\_index.indices.vector\_store.base import VectorStoreIndexfrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.readers.file.base import SimpleDirectoryReaderconnection\_string = os.environ.get("AZURE\_COSMOSDB\_MONGODB\_URI")mongodb\_client = pymongo.MongoClient(connection\_string)store = AzureCosmosDBMongoDBVectorSearch(    mongodb\_client=mongodb\_client,    db\_name="demo\_vectordb",    collection\_name="paul\_graham\_essay",)storage\_context = StorageContext.from\_defaults(vector\_store=store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query the index[](#query-the-index "Permalink to this heading")
----------------------------------------------------------------

We can now ask questions using our index.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author love working on?")
```

```
import textwrapprint(textwrap.fill(str(response), 100))
```

```
The author loved working on multiple projects that were not their thesis while in grad school,including Lisp hacking and writing On Lisp. They eventually wrote a dissertation on applications ofcontinuations in just 5 weeks to graduate. Afterward, they applied to art schools and were acceptedinto the BFA program at RISD.
```

```
response = query\_engine.query("What did he/she do in summer of 2016?")
```

```
print(textwrap.fill(str(response), 100))
```

```
The person moved to England with their family in the summer of 2016.
```
