[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/low_level/oss_ingestion_retrieval.ipynb)

Building RAG from Scratch (Open-source only!)[](#building-rag-from-scratch-open-source-only "Permalink to this heading")
=========================================================================================================================

In this tutorial, we show you how to build a data ingestion pipeline into a vector database, and then build a retrieval pipeline from that vector database, from scratch.

Notably, we use a fully open-source stack:

* Sentence Transformers as the embedding model
* Postgres as the vector store (we support many other [vector stores](https://gpt-index.readthedocs.io/en/stable/core_modules/data_modules/storage/vector_stores.html) too!)
* Llama 2 as the LLM (through [llama.cpp](https://github.com/ggerganov/llama.cpp))

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We setup our open-source components.

1. Sentence Transformers
2. Llama 2
3. We initialize postgres and wrap it with our wrappers/abstractions.

### Sentence Transformers[](#sentence-transformers "Permalink to this heading")


```
# sentence transformersfrom llama\_index.embeddings import HuggingFaceEmbeddingembed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en")
```
### Llama CPP[](#llama-cpp "Permalink to this heading")

In this notebook, we use the [`llama-2-chat-13b-ggml`](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML) model, along with the proper prompt formatting.

Check out our [Llama CPP guide](https://gpt-index.readthedocs.io/en/stable/examples/llm/llama_2_llama_cpp.html) for full setup instructions/details.


```
!pip install llama-cpp-python
```

```
Requirement already satisfied: llama-cpp-python in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (0.2.7)Requirement already satisfied: numpy>=1.20.0 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from llama-cpp-python) (1.23.5)Requirement already satisfied: typing-extensions>=4.5.0 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from llama-cpp-python) (4.7.1)Requirement already satisfied: diskcache>=5.6.1 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from llama-cpp-python) (5.6.3)[notice] A new release of pip available: 22.3.1 -> 23.2.1[notice] To update, run: pip install --upgrade pip
```

```
from llama\_index.llms import LlamaCPP# model\_url = "https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML/resolve/main/llama-2-13b-chat.ggmlv3.q4\_0.bin"model\_url = "https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q4\_0.gguf"llm = LlamaCPP(    # You can pass in the URL to a GGML model to download it automatically    model\_url=model\_url,    # optionally, you can set the path to a pre-downloaded model instead of model\_url    model\_path=None,    temperature=0.1,    max\_new\_tokens=256,    # llama2 has a context window of 4096 tokens, but we set it lower to allow for some wiggle room    context\_window=3900,    # kwargs to pass to \_\_call\_\_()    generate\_kwargs={},    # kwargs to pass to \_\_init\_\_()    # set to at least 1 to use GPU    model\_kwargs={"n\_gpu\_layers": 1},    verbose=True,)
```
### Define Service Context[](#define-service-context "Permalink to this heading")


```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)
```
### Initialize Postgres[](#initialize-postgres "Permalink to this heading")

Using an existing postgres running at localhost, create the database we’ll be using.

**NOTE**: Of course there are plenty of other open-source/self-hosted databases you can use! e.g. Chroma, Qdrant, Weaviate, and many more. Take a look at our [vector store guide](https://gpt-index.readthedocs.io/en/stable/core_modules/data_modules/storage/vector_stores.html).

**NOTE**: You will need to setup postgres on your local system. Here’s an example of how to set it up on OSX: https://www.sqlshack.com/setting-up-a-postgresql-database-on-mac/.

**NOTE**: You will also need to install pgvector (https://github.com/pgvector/pgvector).

You can add a role like the following:


```
CREATE ROLE <user> WITH LOGIN PASSWORD '<password>';ALTER ROLE <user> SUPERUSER;
```

```
!pip install psycopg2-binary pgvector asyncpg "sqlalchemy[asyncio]" greenlet
```

```
import psycopg2db\_name = "vector\_db"host = "localhost"password = "password"port = "5432"user = "jerry"# conn = psycopg2.connect(connection\_string)conn = psycopg2.connect(    dbname="postgres",    host=host,    password=password,    port=port,    user=user,)conn.autocommit = Truewith conn.cursor() as c:    c.execute(f"DROP DATABASE IF EXISTS {db\_name}")    c.execute(f"CREATE DATABASE {db\_name}")
```

```
from sqlalchemy import make\_urlfrom llama\_index.vector\_stores import PGVectorStorevector\_store = PGVectorStore.from\_params(    database=db\_name,    host=host,    password=password,    port=port,    user=user,    table\_name="llama2\_paper",    embed\_dim=384,  # openai embedding dimension)
```
Build an Ingestion Pipeline from Scratch[](#build-an-ingestion-pipeline-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

We show how to build an ingestion pipeline as mentioned in the introduction.

We fast-track the steps here (can skip metadata extraction). More details can be found [in our dedicated ingestion guide](https://gpt-index.readthedocs.io/en/latest/examples/low_level/ingestion.html).

### 1. Load Data[](#load-data "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()documents = loader.load(file\_path="./data/llama2.pdf")
```
### 2. Use a Text Splitter to Split Documents[](#use-a-text-splitter-to-split-documents "Permalink to this heading")


```
from llama\_index.text\_splitter import SentenceSplitter
```

```
text\_splitter = SentenceSplitter(    chunk\_size=1024,    # separator=" ",)
```

```
text\_chunks = []# maintain relationship with source doc index, to help inject doc metadata in (3)doc\_idxs = []for doc\_idx, doc in enumerate(documents):    cur\_text\_chunks = text\_splitter.split\_text(doc.text)    text\_chunks.extend(cur\_text\_chunks)    doc\_idxs.extend([doc\_idx] \* len(cur\_text\_chunks))
```
### 3. Manually Construct Nodes from Text Chunks[](#manually-construct-nodes-from-text-chunks "Permalink to this heading")


```
from llama\_index.schema import TextNodenodes = []for idx, text\_chunk in enumerate(text\_chunks):    node = TextNode(        text=text\_chunk,    )    src\_doc = documents[doc\_idxs[idx]]    node.metadata = src\_doc.metadata    nodes.append(node)
```
### 4. Generate Embeddings for each Node[](#generate-embeddings-for-each-node "Permalink to this heading")

Here we generate embeddings for each Node using a sentence\_transformers model.


```
for node in nodes:    node\_embedding = embed\_model.get\_text\_embedding(        node.get\_content(metadata\_mode="all")    )    node.embedding = node\_embedding
```
### 5. Load Nodes into a Vector Store[](#load-nodes-into-a-vector-store "Permalink to this heading")

We now insert these nodes into our `PostgresVectorStore`.


```
vector\_store.add(nodes)
```
Build Retrieval Pipeline from Scratch[](#build-retrieval-pipeline-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

We show how to build a retrieval pipeline. Similar to ingestion, we fast-track the steps. Take a look at our [retrieval guide](https://gpt-index.readthedocs.io/en/latest/examples/low_level/retrieval.html) for more details!


```
query\_str = "Can you tell me about the key concepts for safety finetuning"
```
### 1. Generate a Query Embedding[](#generate-a-query-embedding "Permalink to this heading")


```
query\_embedding = embed\_model.get\_query\_embedding(query\_str)
```
### 2. Query the Vector Database[](#query-the-vector-database "Permalink to this heading")


```
# construct vector store queryfrom llama\_index.vector\_stores import VectorStoreQueryquery\_mode = "default"# query\_mode = "sparse"# query\_mode = "hybrid"vector\_store\_query = VectorStoreQuery(    query\_embedding=query\_embedding, similarity\_top\_k=2, mode=query\_mode)
```

```
# returns a VectorStoreQueryResultquery\_result = vector\_store.query(vector\_store\_query)print(query\_result.nodes[0].get\_content())
```
### 3. Parse Result into a Set of Nodes[](#parse-result-into-a-set-of-nodes "Permalink to this heading")


```
from llama\_index.schema import NodeWithScorefrom typing import Optionalnodes\_with\_scores = []for index, node in enumerate(query\_result.nodes):    score: Optional[float] = None    if query\_result.similarities is not None:        score = query\_result.similarities[index]    nodes\_with\_scores.append(NodeWithScore(node=node, score=score))
```
### 4. Put into a Retriever[](#put-into-a-retriever "Permalink to this heading")


```
from llama\_index import QueryBundlefrom llama\_index.retrievers import BaseRetrieverfrom typing import Any, Listclass VectorDBRetriever(BaseRetriever): """Retriever over a postgres vector store."""    def \_\_init\_\_(        self,        vector\_store: PGVectorStore,        embed\_model: Any,        query\_mode: str = "default",        similarity\_top\_k: int = 2,    ) -> None: """Init params."""        self.\_vector\_store = vector\_store        self.\_embed\_model = embed\_model        self.\_query\_mode = query\_mode        self.\_similarity\_top\_k = similarity\_top\_k    def \_retrieve(self, query\_bundle: QueryBundle) -> List[NodeWithScore]: """Retrieve."""        query\_embedding = embed\_model.get\_query\_embedding(            query\_bundle.query\_str        )        vector\_store\_query = VectorStoreQuery(            query\_embedding=query\_embedding,            similarity\_top\_k=self.\_similarity\_top\_k,            mode=self.\_query\_mode,        )        query\_result = vector\_store.query(vector\_store\_query)        nodes\_with\_scores = []        for index, node in enumerate(query\_result.nodes):            score: Optional[float] = None            if query\_result.similarities is not None:                score = query\_result.similarities[index]            nodes\_with\_scores.append(NodeWithScore(node=node, score=score))        return nodes\_with\_scores
```

```
retriever = VectorDBRetriever(    vector\_store, embed\_model, query\_mode="default", similarity\_top\_k=2)
```
Plug this into our RetrieverQueryEngine to synthesize a response[](#plug-this-into-our-retrieverqueryengine-to-synthesize-a-response "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(    retriever, service\_context=service\_context)
```

```
query\_str = "How does Llama 2 perform compared to other open-source models?"response = query\_engine.query(query\_str)
```

```
Llama.generate: prefix-match hitllama_print_timings:        load time = 15473.66 msllama_print_timings:      sample time =    35.20 ms /    53 runs   (    0.66 ms per token,  1505.85 tokens per second)llama_print_timings: prompt eval time = 16132.70 ms /  1816 tokens (    8.88 ms per token,   112.57 tokens per second)llama_print_timings:        eval time =  3149.79 ms /    52 runs   (   60.57 ms per token,    16.51 tokens per second)llama_print_timings:       total time = 19380.78 ms
```

```
print(str(response))
```

```
 Based on the results shown in Table 3, Llama 2 outperforms all open-source models on most of the benchmarks, with an average improvement of around 5 points over the next best model (GPT-3.5).
```

```
print(response.source\_nodes[0].get\_content())
```
