[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/AstraDBIndexDemo.ipynb)

Astra DB[](#astra-db "Permalink to this heading")
==================================================


> [DataStax Astra DB](https://docs.datastax.com/en/astra/home/astra.html) is a serverless vector-capable database built on Apache Cassandra and accessed through an easy-to-use JSON API.
> 
> 

To run this notebook you need a DataStax Astra DB instance running in the cloud (you can get one for free at [datastax.com](https://astra.datastax.com)).

You should ensure you have `llama-index` and `astrapy` installed:


```
!pip install llama-index!pip install "astrapy>=0.5.8"
```
Please provide database connection parameters and secrets:[](#please-provide-database-connection-parameters-and-secrets "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------


```
import osimport getpassapi\_endpoint = input(    "\nPlease enter your Database Endpoint URL (e.g. 'https://4bc...datastax.com'):")token = getpass.getpass(    "\nPlease enter your 'Database Administrator' Token (e.g. 'AstraCS:...'):")os.environ["OPENAI\_API\_KEY"] = getpass.getpass(    "\nPlease enter your OpenAI API Key (e.g. 'sk-...'):")
```
Import needed package dependencies:[](#import-needed-package-dependencies "Permalink to this heading")
-------------------------------------------------------------------------------------------------------


```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    StorageContext,)from llama\_index.vector\_stores import AstraDBVectorStore
```
Load some example data:[](#load-some-example-data "Permalink to this heading")
-------------------------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Read the data:[](#read-the-data "Permalink to this heading")
-------------------------------------------------------------


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print(f"Total documents: {len(documents)}")print(f"First document, id: {documents[0].doc\_id}")print(f"First document, hash: {documents[0].hash}")print(    "First document, text"    f" ({len(documents[0].text)} characters):\n{'='\*20}\n{documents[0].text[:360]} ...")
```
Create the Astra DB Vector Store object:[](#create-the-astra-db-vector-store-object "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------


```
astra\_db\_store = AstraDBVectorStore(    token=token,    api\_endpoint=api\_endpoint,    collection\_name="astra\_v\_table",    embedding\_dimension=1536,)
```
Build the Index from the Documents:[](#build-the-index-from-the-documents "Permalink to this heading")
-------------------------------------------------------------------------------------------------------


```
storage\_context = StorageContext.from\_defaults(vector\_store=astra\_db\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
Query using the index:[](#query-using-the-index "Permalink to this heading")
-----------------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Why did the author choose to work on AI?")print(response.response)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query(    "Why did the author choose to work on AI? Answer in a single short sentence.")print(response.response)
```
