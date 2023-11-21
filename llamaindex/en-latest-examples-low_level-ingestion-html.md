[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/low_level/ingestion.ipynb)

Building Data Ingestion from Scratch[](#building-data-ingestion-from-scratch "Permalink to this heading")
==========================================================================================================

In this tutorial, we show you how to build a data ingestion pipeline into a vector database.

We use Pinecone as the vector database.

We will show how to do the following:

1. How to load in documents.
2. How to use a text splitter to split documents.
3. How to **manually** construct nodes from each text chunk.
4. [Optional] Add metadata to each Node.
5. How to generate embeddings for each text chunk.
6. How to insert into a vector database.
Pinecone[](#pinecone "Permalink to this heading")
==================================================

You will need a [pinecone.io](https://www.pinecone.io/) api key for this tutorial. You can [sign up for free](https://app.pinecone.io/?sessionType=signup) to get a Starter account.

If you create a Starter account, you can name your application anything you like.

Once you have an account, navigate to ‘API Keys’ in the Pinecone console. You can use the default key or create a new one for this tutorial.

Save your api key and its environment (`gcp\_starter` for free accounts). You will need them below.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
OpenAI[](#openai "Permalink to this heading")
==============================================

You will need an [OpenAI](https://openai.com/) api key for this tutorial. Login to your [platform.openai.com](https://platform.openai.com/) account, click on your profile picture in the upper right corner, and choose ‘API Keys’ from the menu. Create an API key for this tutorial and save it. You will need it below.

Environment[](#environment "Permalink to this heading")
--------------------------------------------------------

First we add our dependencies.


```
!pip -q install python-dotenv pinecone-client llama-index pymupdf
```
### Set Environment Variables[](#set-environment-variables "Permalink to this heading")

We create a file for our environment variables. Do not commit this file or share it!

Note: Google Colabs will let you create but not open a .env


```
dotenv\_path = (    "env"  # Google Colabs will not let you open a .env, but you can set)with open(dotenv\_path, "w") as f:    f.write('PINECONE\_API\_KEY="<your api key>"\n')    f.write('PINECONE\_ENVIRONMENT="gcp-starter"\n')    f.write('OPENAI\_API\_KEY="<your api key>"\n')
```
Set your OpenAI api key, and Pinecone api key and environment in the file we created.


```
import osfrom dotenv import load\_dotenv
```

```
load\_dotenv(dotenv\_path=dotenv\_path)
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

We build an empty Pinecone Index, and define the necessary LlamaIndex wrappers/abstractions so that we can start loading data into Pinecone.

Note: Do not save your API keys in the code or add pinecone\_env to your repo!


```
import pinecone
```

```
api\_key = os.environ["PINECONE\_API\_KEY"]environment = os.environ["PINECONE\_ENVIRONMENT"]pinecone.init(api\_key=api\_key, environment=environment)
```

```
index\_name = "llamaindex-rag-fs"
```

```
# [Optional] Delete the index before re-running the tutorial.# pinecone.delete\_index(index\_name)
```

```
# dimensions are for text-embedding-ada-002pinecone.create\_index(    index\_name, dimension=1536, metric="euclidean", pod\_type="p1")
```

```
pinecone\_index = pinecone.Index(index\_name)
```

```
# [Optional] drop contents in index - will not work on free accountspinecone\_index.delete(deleteAll=True)
```
### Create PineconeVectorStore[](#create-pineconevectorstore "Permalink to this heading")

Simple wrapper abstraction to use in LlamaIndex. Wrap in StorageContext so we can easily load in Nodes.


```
from llama\_index.vector\_stores import PineconeVectorStore
```

```
vector\_store = PineconeVectorStore(pinecone\_index=pinecone\_index)
```
Build an Ingestion Pipeline from Scratch[](#build-an-ingestion-pipeline-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

We show how to build an ingestion pipeline as mentioned in the introduction.

Note that steps (2) and (3) can be handled via our `NodeParser` abstractions, which handle splitting and node creation.

For the purposes of this tutorial, we show you how to create these objects manually.

### 1. Load Data[](#load-data "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
--2023-10-13 01:45:14--  https://arxiv.org/pdf/2307.09288.pdfResolving arxiv.org (arxiv.org)... 128.84.21.199Connecting to arxiv.org (arxiv.org)|128.84.21.199|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 13661300 (13M) [application/pdf]Saving to: ‘data/llama2.pdf’data/llama2.pdf     100%[===================>]  13.03M  7.59MB/s    in 1.7s    2023-10-13 01:45:16 (7.59 MB/s) - ‘data/llama2.pdf’ saved [13661300/13661300]
```

```
import fitz
```

```
file\_path = "./data/llama2.pdf"doc = fitz.open(file\_path)
```
### 2. Use a Text Splitter to Split Documents[](#use-a-text-splitter-to-split-documents "Permalink to this heading")

Here we import our `SentenceSplitter` to split document texts into smaller chunks, while preserving paragraphs/sentences as much as possible.


```
from llama\_index.text\_splitter import SentenceSplitter
```

```
text\_splitter = SentenceSplitter(    chunk\_size=1024,    # separator=" ",)
```

```
text\_chunks = []# maintain relationship with source doc index, to help inject doc metadata in (3)doc\_idxs = []for doc\_idx, page in enumerate(doc):    page\_text = page.get\_text("text")    cur\_text\_chunks = text\_splitter.split\_text(page\_text)    text\_chunks.extend(cur\_text\_chunks)    doc\_idxs.extend([doc\_idx] \* len(cur\_text\_chunks))
```
### 3. Manually Construct Nodes from Text Chunks[](#manually-construct-nodes-from-text-chunks "Permalink to this heading")

We convert each chunk into a `TextNode` object, a low-level data abstraction in LlamaIndex that stores content but also allows defining metadata + relationships with other Nodes.

We inject metadata from the document into each node.

This essentially replicates logic in our `SimpleNodeParser`.


```
from llama\_index.schema import TextNode
```

```
nodes = []for idx, text\_chunk in enumerate(text\_chunks):    node = TextNode(        text=text\_chunk,    )    src\_doc\_idx = doc\_idxs[idx]    src\_page = doc[src\_doc\_idx]    nodes.append(node)
```

```
print(nodes[0].metadata)
```

```
# print a sample nodeprint(nodes[0].get\_content(metadata\_mode="all"))
```
### [Optional] 4. Extract Metadata from each Node[](#optional-4-extract-metadata-from-each-node "Permalink to this heading")

We extract metadata from each Node using our Metadata extractors.

This will add more metadata to each Node.


```
from llama\_index.node\_parser.extractors import (    MetadataExtractor,    QuestionsAnsweredExtractor,    TitleExtractor,)from llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")metadata\_extractor = MetadataExtractor(    extractors=[        TitleExtractor(nodes=5, llm=llm),        QuestionsAnsweredExtractor(questions=3, llm=llm),    ],    in\_place=False,)
```

```
nodes = metadata\_extractor.process\_nodes(nodes)
```

```
print(nodes[0].metadata)
```
### 5. Generate Embeddings for each Node[](#generate-embeddings-for-each-node "Permalink to this heading")

Generate document embeddings for each Node using our OpenAI embedding model (`text-embedding-ada-002`).

Store these on the `embedding` property on each Node.


```
from llama\_index.embeddings import OpenAIEmbeddingembed\_model = OpenAIEmbedding()
```

```
for node in nodes:    node\_embedding = embed\_model.get\_text\_embedding(        node.get\_content(metadata\_mode="all")    )    node.embedding = node\_embedding
```
### 6. Load Nodes into a Vector Store[](#load-nodes-into-a-vector-store "Permalink to this heading")

We now insert these nodes into our `PineconeVectorStore`.

**NOTE**: We skip the VectorStoreIndex abstraction, which is a higher-level abstraction that handles ingestion as well. We use `VectorStoreIndex` in the next section to fast-track retrieval/querying.


```
vector\_store.add(nodes)
```
Retrieve and Query from the Vector Store[](#retrieve-and-query-from-the-vector-store "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

Now that our ingestion is complete, we can retrieve/query this vector store.

**NOTE**: We can use our high-level `VectorStoreIndex` abstraction here. See the next section to see how to define retrieval at a lower-level!


```
from llama\_index import VectorStoreIndexfrom llama\_index.storage import StorageContext
```

```
index = VectorStoreIndex.from\_vector\_store(vector\_store)
```

```
query\_engine = index.as\_query\_engine()
```

```
query\_str = "Can you tell me about the key concepts for safety finetuning"
```

```
response = query\_engine.query(query\_str)
```

```
print(str(response))
```
