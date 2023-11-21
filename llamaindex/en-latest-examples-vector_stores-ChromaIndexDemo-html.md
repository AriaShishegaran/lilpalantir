[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/ChromaIndexDemo.ipynb)

Chroma[](#chroma "Permalink to this heading")
==============================================


> [Chroma](https://docs.trychroma.com/getting-started) is a AI-native open-source vector database focused on developer productivity and happiness. Chroma is licensed under Apache 2.0.
> 
> 

[![Discord](https://img.shields.io/discord/1073293645303795742)](https://discord.gg/MMeYNTmh3x)   [![License](https://img.shields.io/static/v1?label=license&message=Apache 2.0&color=white)](https://github.com/chroma-core/chroma/blob/master/LICENSE)   ![Integration Tests](https://github.com/chroma-core/chroma/actions/workflows/chroma-integration-test.yml/badge.svg?branch=main)* [Website](https://www.trychroma.com/)
* [Documentation](https://docs.trychroma.com/)
* [Twitter](https://twitter.com/trychroma)
* [Discord](https://discord.gg/MMeYNTmh3x)

Chroma is fully-typed, fully-tested and fully-documented.

Install Chroma with:


```
pip install chromadb
```
Chroma runs in various modes. See below for examples of each integrated with LangChain.

* `in-memory` - in a python script or jupyter notebook
* `in-memory with persistance` - in a script or notebook and save/load to disk
* `in a docker container` - as a server running your local machine or in the cloud

Like any other database, you can:

* `.add`
* `.get`
* `.update`
* `.upsert`
* `.delete`
* `.peek`
* and `.query` runs the similarity search.

View full docs at [docs](https://docs.trychroma.com/reference/Collection).

Basic Example[](#basic-example "Permalink to this heading")
------------------------------------------------------------

In this basic example, we take the a Paul Graham essay, split it into chunks, embed it using an open-source embedding model, load it into Chroma, and then query it.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
### Creating a Chroma Index[](#creating-a-chroma-index "Permalink to this heading")


```
# !pip install llama-index chromadb --quiet# !pip install chromadb# !pip install sentence-transformers# !pip install pydantic==1.10.11
```

```
# importfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.vector\_stores import ChromaVectorStorefrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.embeddings import HuggingFaceEmbeddingfrom IPython.display import Markdown, displayimport chromadb
```

```
# set up OpenAIimport osimport getpassos.environ["OPENAI\_API\_KEY"] = getpass.getpass("OpenAI API Key:")import openaiopenai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# create client and a new collectionchroma\_client = chromadb.EphemeralClient()chroma\_collection = chroma\_client.create\_collection("quickstart")# define embedding functionembed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-base-en-v1.5")# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()# set up ChromaVectorStore and load in datavector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, service\_context=service\_context)# Query Dataquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")display(Markdown(f"<b>{response}</b>"))
```

```
/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/bitsandbytes/cextension.py:34: UserWarning: The installed version of bitsandbytes was compiled without GPU support. 8-bit optimizers, 8-bit multiplication, and GPU quantization are unavailable.  warn("The installed version of bitsandbytes was compiled without GPU support. "
```

```
'NoneType' object has no attribute 'cadam32bit_grad_fp32'
```
**The author worked on writing and programming growing up. They wrote short stories and tried writing programs on an IBM 1401 computer. Later, they got a microcomputer and started programming more extensively.**

Basic Example (including saving to disk)[](#basic-example-including-saving-to-disk "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------

Extending the previous example, if you want to save to disk, simply initialize the Chroma client and pass the directory where you want the data to be saved to.

`Caution`: Chroma makes a best-effort to automatically save data to disk, however multiple in-memory clients can stomp each other’s work. As a best practice, only have one client per path running at any given time.


```
# save to diskdb = chromadb.PersistentClient(path="./chroma\_db")chroma\_collection = db.get\_or\_create\_collection("quickstart")vector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, service\_context=service\_context)# load from diskdb2 = chromadb.PersistentClient(path="./chroma\_db")chroma\_collection = db2.get\_or\_create\_collection("quickstart")vector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)index = VectorStoreIndex.from\_vector\_store(    vector\_store,    service\_context=service\_context,)# Query Data from the persisted indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming growing up. They wrote short stories and tried writing programs on an IBM 1401 computer. Later, they got a microcomputer and started programming games and a word processor.**

Basic Example (using the Docker Container)[](#basic-example-using-the-docker-container "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------

You can also run the Chroma Server in a Docker container separately, create a Client to connect to it, and then pass that to LlamaIndex.

Here is how to clone, build, and run the Docker Image:


```
git clone git@github.com:chroma-core/chroma.gitdocker-compose up -d --build
```

```
# create the chroma client and add our dataimport chromadbremote\_db = chromadb.HttpClient()chroma\_collection = remote\_db.get\_or\_create\_collection("quickstart")vector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, service\_context=service\_context)
```

```
# Query Data from the Chroma Docker indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")display(Markdown(f"<b>{response}</b>"))
```
**Growing up, the author wrote short stories, programmed on an IBM 1401, and wrote programs on a TRS-80 microcomputer. He also took painting classes at Harvard and worked as a de facto studio assistant for a painter. He also tried to start a company to put art galleries online, and wrote software to build online stores.**Update and Delete[](#update-and-delete "Permalink to this heading")
--------------------------------------------------------------------

While building toward a real application, you want to go beyond adding data, and also update and delete data.

Chroma has users provide `ids` to simplify the bookkeeping here. `ids` can be the name of the file, or a combined has like `filename\_paragraphNumber`, etc.

Here is a basic example showing how to do various operations:


```
doc\_to\_update = chroma\_collection.get(limit=1)doc\_to\_update["metadatas"][0] = {    \*\*doc\_to\_update["metadatas"][0],    \*\*{"author": "Paul Graham"},}chroma\_collection.update(    ids=[doc\_to\_update["ids"][0]], metadatas=[doc\_to\_update["metadatas"][0]])updated\_doc = chroma\_collection.get(limit=1)print(updated\_doc["metadatas"][0])# delete the last documentprint("count before", chroma\_collection.count())chroma\_collection.delete(ids=[doc\_to\_update["ids"][0]])print("count after", chroma\_collection.count())
```

```
{'_node_content': '{"id_": "be08c8bc-f43e-4a71-ba64-e525921a8319", "embedding": null, "metadata": {}, "excluded_embed_metadata_keys": [], "excluded_llm_metadata_keys": [], "relationships": {"1": {"node_id": "2cbecdbb-0840-48b2-8151-00119da0995b", "node_type": null, "metadata": {}, "hash": "4c702b4df575421e1d1af4b1fd50511b226e0c9863dbfffeccb8b689b8448f35"}, "3": {"node_id": "6a75604a-fa76-4193-8f52-c72a7b18b154", "node_type": null, "metadata": {}, "hash": "d6c408ee1fbca650fb669214e6f32ffe363b658201d31c204e85a72edb71772f"}}, "hash": "b4d0b960aa09e693f9dc0d50ef46a3d0bf5a8fb3ac9f3e4bcf438e326d17e0d8", "text": "", "start_char_idx": 0, "end_char_idx": 4050, "text_template": "{metadata_str}\\n\\n{content}", "metadata_template": "{key}: {value}", "metadata_seperator": "\\n"}', 'author': 'Paul Graham', 'doc_id': '2cbecdbb-0840-48b2-8151-00119da0995b', 'document_id': '2cbecdbb-0840-48b2-8151-00119da0995b', 'ref_doc_id': '2cbecdbb-0840-48b2-8151-00119da0995b'}count before 20count after 19
```
