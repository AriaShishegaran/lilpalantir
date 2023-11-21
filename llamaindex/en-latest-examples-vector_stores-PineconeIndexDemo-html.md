[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/PineconeIndexDemo.ipynb)

Pinecone Vector Store[](#pinecone-vector-store "Permalink to this heading")
============================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysimport oslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Creating a Pinecone Index[](#creating-a-pinecone-index "Permalink to this heading")
------------------------------------------------------------------------------------


```
import pinecone
```

```
/Users/suo/miniconda3/envs/llama/lib/python3.9/site-packages/pinecone/index.py:4: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from tqdm.autonotebook import tqdm
```

```
api\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="eu-west1-gcp")
```

```
# dimensions are for text-embedding-ada-002pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")
```

```
pinecone\_index = pinecone.Index("quickstart")
```
Load documents, build the PineconeVectorStore and VectorStoreIndex[](#load-documents-build-the-pineconevectorstore-and-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.vector\_stores import PineconeVectorStorefrom IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
# initialize without metadata filterfrom llama\_index.storage.storage\_context import StorageContextvector\_store = PineconeVectorStore(pinecone\_index=pinecone\_index)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 20729 tokens> [build_index_from_nodes] Total embedding token usage: 20729 tokens> [build_index_from_nodes] Total embedding token usage: 20729 tokens
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1917 tokens> [get_response] Total LLM token usage: 1917 tokens> [get_response] Total LLM token usage: 1917 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author grew up writing short stories and programming on the IBM 1401. He also nagged his father to buy him a TRS-80 microcomputer, which he used to write simple games, a program to predict how high his model rockets would fly, and a word processor. He also studied philosophy in college, but eventually switched to AI.**