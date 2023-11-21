[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/multi_modal/ChromaMultiModalDemo.ipynb)

Chroma Multi-Modal Demo with LlamaIndex[](#chroma-multi-modal-demo-with-llamaindex "Permalink to this heading")
================================================================================================================


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
!pip install llama-index chromadb --quiet!pip install chromadb==0.4.17!pip install sentence-transformers!pip install pydantic==1.10.11!pip install open-clip-torch
```

```
# importfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.vector\_stores import ChromaVectorStorefrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.embeddings import HuggingFaceEmbeddingfrom IPython.display import Markdown, displayimport chromadb
```

```
# set up OpenAIimport osimport openaiOPENAI\_API\_KEY = ""openai.api\_key = OPENAI\_API\_KEYos.environ["OPENAI\_API\_KEY"] = OPENAI\_API\_KEY
```
Download Images and Texts from Wikipedia[](#download-images-and-texts-from-wikipedia "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------


```
import requestsdef get\_wikipedia\_images(title):    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "imageinfo",            "iiprop": "url|dimensions|mime",            "generator": "images",            "gimlimit": "50",        },    ).json()    image\_urls = []    for page in response["query"]["pages"].values():        if page["imageinfo"][0]["url"].endswith(".jpg") or page["imageinfo"][            0        ]["url"].endswith(".png"):            image\_urls.append(page["imageinfo"][0]["url"])    return image\_urls
```

```
from pathlib import Pathimport urllib.requestimage\_uuid = 0MAX\_IMAGES\_PER\_WIKI = 20wiki\_titles = {    "Tesla Model X",    "Pablo Picasso",    "Rivian",    "The Lord of the Rings",    "The Matrix",    "The Simpsons",}data\_path = Path("mixed\_wiki")if not data\_path.exists():    Path.mkdir(data\_path)for title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)    images\_per\_wiki = 0    try:        # page\_py = wikipedia.page(title)        list\_img\_urls = get\_wikipedia\_images(title)        # print(list\_img\_urls)        for url in list\_img\_urls:            if url.endswith(".jpg") or url.endswith(".png"):                image\_uuid += 1                # image\_file\_name = title + "\_" + url.split("/")[-1]                urllib.request.urlretrieve(                    url, data\_path / f"{image\_uuid}.jpg"                )                images\_per\_wiki += 1                # Limit the number of images downloaded per wiki page to 15                if images\_per\_wiki > MAX\_IMAGES\_PER\_WIKI:                    break    except:        print(str(Exception("No images found for Wikipedia page: ")) + title)        continue
```
Set the embedding model[](#set-the-embedding-model "Permalink to this heading")
--------------------------------------------------------------------------------


```
from chromadb.utils.embedding\_functions import OpenCLIPEmbeddingFunction# set defalut text and image embedding functionsembedding\_function = OpenCLIPEmbeddingFunction()
```

```
/Users/haotianzhang/llama_index/venv/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Build Chroma Multi-Modal Index with LlamaIndex[](#build-chroma-multi-modal-index-with-llamaindex "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index.indices.multi\_modal.base import MultiModalVectorStoreIndexfrom llama\_index.vector\_stores import QdrantVectorStorefrom llama\_index import SimpleDirectoryReader, StorageContextfrom chromadb.utils.data\_loaders import ImageLoaderimage\_loader = ImageLoader()# create client and a new collectionchroma\_client = chromadb.EphemeralClient()chroma\_collection = chroma\_client.create\_collection(    "multimodal\_collection",    embedding\_function=embedding\_function,    data\_loader=image\_loader,)# load documentsdocuments = SimpleDirectoryReader("./mixed\_wiki/").load\_data()# set up ChromaVectorStore and load in datavector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents,    storage\_context=storage\_context,)
```
Retrieve results from Mutli-Modal Index[](#retrieve-results-from-mutli-modal-index "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------


```
retriever = index.as\_retriever(similarity\_top\_k=50)retrieval\_results = retriever.retrieve("Picasso famous paintings")
```

```
# print(retrieval\_results)from llama\_index.schema import ImageNodefrom llama\_index.response.notebook\_utils import (    display\_source\_node,    display\_image\_uris,)image\_results = []MAX\_RES = 5cnt = 0for r in retrieval\_results:    if isinstance(r.node, ImageNode):        image\_results.append(r.node.metadata["file\_path"])    else:        if cnt < MAX\_RES:            display\_source\_node(r)        cnt += 1display\_image\_uris(image\_results, [3, 3], top\_k=2)
```
**Node ID:** 13adcbba-fe8b-4d51-9139-fb1c55ffc6be  
**Similarity:** 0.774399292477267  
**Text:** == Artistic legacy ==Picasso’s influence was and remains immense and widely acknowledged by his …  


**Node ID:** 4100593e-6b6a-4b5f-8384-98d1c2468204  
**Similarity:** 0.7695965506408678  
**Text:** === Later works to final years: 1949–1973 ===Picasso was one of 250 sculptors who exhibited in t…  


**Node ID:** aeed9d43-f9c5-42a9-a7b9-1a3c005e3745  
**Similarity:** 0.7693110304140338  
**Text:** Pablo Ruiz Picasso (25 October 1881 – 8 April 1973) was a Spanish painter, sculptor, printmaker, …  


**Node ID:** 5a6613b6-b599-4e40-92f2-231e10ed54f6  
**Similarity:** 0.7656537748231977  
**Text:** === The Basel vote ===In the 1940s, a Swiss insurance company based in Basel had bought two pain…  


**Node ID:** cc17454c-030d-4f86-a12e-342d0582f4d3  
**Similarity:** 0.7639671751819532  
**Text:** == Style and technique ==

Picasso was exceptionally prolific throughout his long lifetime. At hi…  


![../../_images/b5eae20d0e1743fc5036ba4ee86a3fece9dd0c024212802667dc1d232b288736.png](../../_images/b5eae20d0e1743fc5036ba4ee86a3fece9dd0c024212802667dc1d232b288736.png)