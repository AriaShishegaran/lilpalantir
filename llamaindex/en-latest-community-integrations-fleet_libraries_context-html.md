Fleet Context Embeddings - Building a Hybrid Search Engine for the Llamaindex Library[](#fleet-context-embeddings-building-a-hybrid-search-engine-for-the-llamaindex-library "Permalink to this heading")
==========================================================================================================================================================================================================

In this guide, we will be using Fleet Context to download the embeddings for LlamaIndex’s documentation and build a hybrid dense/sparse vector retrieval engine on top of it.

  
  


Pre-requisites[](#pre-requisites "Permalink to this heading")
--------------------------------------------------------------


```
!pip install llama-index!pip install --upgrade fleet-context
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..." # add your API key here!openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
  
  


Download Embeddings from Fleet Context[](#download-embeddings-from-fleet-context "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

We will be using Fleet Context to download the embeddings for theentirety of LlamaIndex’s documentation (~12k chunks, ~100mb ofcontent). You can download for any of the top 1220 libraries byspecifying the library name as a parameter. You can view the full listof supported libraries [here](https://fleet.so/context) at the bottom ofthe page.

We do this because Fleet has built a embeddings pipeline that preservesa lot of important information that will make the retrieval andgeneration better including position on page (for re-ranking), chunktype (class/function/attribute/etc), the parent section, and more. Youcan read more about this on their [Githubpage](https://github.com/fleet-ai/context/tree/main).


```
from context import download\_embeddingsdf = download\_embeddings("llamaindex")
```
**Output**:


```
 100%|██████████| 83.7M/83.7M [00:03<00:00, 27.4MiB/s] id \ 0 e268e2a1-9193-4e7b-bb9b-7a4cb88fc735 1 e495514b-1378-4696-aaf9-44af948de1a1 2 e804f616-7db0-4455-9a06-49dd275f3139 3 eb85c854-78f1-4116-ae08-53b2a2a9fa41 4 edfc116e-cf58-4118-bad4-c4bc0ca1495e
```

```
# Show some examples of the metadatadf["metadata"][0]display(Markdown(f"{df['metadata'][8000]['text']}"))
```
**Output**:


```
classmethod from_dict(data: Dict[str, Any], kwargs: Any) → Self classmethod from_json(data_str: str, kwargs: Any) → Self classmethod from_orm(obj: Any) → Model json(, include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None, exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None, by_alias: bool = False, skip_defaults: Optional[bool] = None, exclude_unset: bool = False, exclude_defaults: bool = False, exclude_none: bool = False, encoder: Optional[Callable[[Any], Any]] = None, models_as_dict: bool = True*, dumps_kwargs: Any) → unicode Generate a JSON representation of the model, include and exclude arguments as per dict().
```
  
  


Create Pinecone Index for Hybrid Search in LlamaIndex[](#create-pinecone-index-for-hybrid-search-in-llamaindex "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------

We’re going to create a Pinecone index and upsert our vectors there sothat we can do hybrid retrieval with both sparse vectors and densevectors. Make sure you have a [Pinecone account](https://pinecone.io)before you proceed.


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().handlers = []logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
import pineconeapi\_key = "..."  # Add your Pinecone API key herepinecone.init(    api\_key=api\_key, environment="us-east-1-aws")  # Add your db region here
```

```
# Fleet Context uses the text-embedding-ada-002 model from OpenAI with 1536 dimensions.# NOTE: Pinecone requires dotproduct similarity for hybrid searchpinecone.create\_index(    "quickstart-fleet-context",    dimension=1536,    metric="dotproduct",    pod\_type="p1",)pinecone.describe\_index(    "quickstart-fleet-context")  # Make sure you create an index in pinecone
```
  

```
from llama\_index.vector\_stores import PineconeVectorStorepinecone\_index = pinecone.Index("quickstart-fleet-context")vector\_store = PineconeVectorStore(pinecone\_index, add\_sparse\_vector=True)
```
  
  


Batch upsert vectors into Pinecone[](#batch-upsert-vectors-into-pinecone "Permalink to this heading")
------------------------------------------------------------------------------------------------------

Pinecone recommends upserting 100 vectors at a time. We’re going to do that after we modify the format of the data a bit.


```
import randomimport itertoolsdef chunks(iterable, batch\_size=100): """A helper function to break an iterable into chunks of size batch\_size."""    it = iter(iterable)    chunk = tuple(itertools.islice(it, batch\_size))    while chunk:        yield chunk        chunk = tuple(itertools.islice(it, batch\_size))# generator that generates many (id, vector, metadata, sparse\_values) pairsdata\_generator = map(    lambda row: {        "id": row[1]["id"],        "values": row[1]["values"],        "metadata": row[1]["metadata"],        "sparse\_values": row[1]["sparse\_values"],    },    df.iterrows(),)# Upsert data with 1000 vectors per upsert requestfor ids\_vectors\_chunk in chunks(data\_generator, batch\_size=100):    print(f"Upserting {len(ids\_vectors\_chunk)} vectors...")    pinecone\_index.upsert(vectors=ids\_vectors\_chunk)
```
  
  


Build Pinecone Vector Store in LlamaIndex[](#build-pinecone-vector-store-in-llamaindex "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------

Finally, we’re going to build the Pinecone vector store via LlamaIndexand query it to get results.


```
from llama\_index import VectorStoreIndexfrom IPython.display import Markdown, display
```

```
index = VectorStoreIndex.from\_vector\_store(vector\_store=vector\_store)
```
  
  


Query Your Index![](#query-your-index "Permalink to this heading")
-------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine(    vector\_store\_query\_mode="hybrid", similarity\_top\_k=8)response = query\_engine.query("How do I use llama\_index SimpleDirectoryReader")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Output**:


```
<b>To use the SimpleDirectoryReader in llama_index, you need to import it from the llama_index library. Once imported, you can create an instance of the SimpleDirectoryReader class by providing the directory path as an argument. Then, you can use the `load_data()` method on the SimpleDirectoryReader instance to load the documents from the specified directory.</b>
```
