[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/predibase.ipynb)

Predibase[](#predibase "Permalink to this heading")
====================================================

This notebook shows how you can use Predibase-hosted LLM’s within Llamaindex. You can add [Predibase](https://predibase.com) to your existing Llamaindex worklow to:

1. Deploy and query pre-trained or custom open source LLM’s without the hassle
2. Operationalize an end-to-end Retrieval Augmented Generation (RAG) system
3. Fine-tune your own LLM in just a few lines of code

Getting Started[](#getting-started "Permalink to this heading")
----------------------------------------------------------------

1. Sign up for a free Predibase account [here](https://predibase.com/free-trial)
2. Create an Account
3. Go to Settings > My profile and Generate a new API Token.


```
!pip install llama-index --quiet!pip install predibase --quiet!pip install sentence-transformers --quiet
```

```
import osos.environ["PREDIBASE\_API\_TOKEN"] = "{PREDIBASE\_API\_TOKEN}"from llama\_index.llms import PredibaseLLM
```
Flow 1: Query Predibase LLM directly[](#flow-1-query-predibase-llm-directly "Permalink to this heading")
---------------------------------------------------------------------------------------------------------


```
llm = PredibaseLLM(    model\_name="llama-2-13b", temperature=0.3, max\_new\_tokens=512)# You can query any HuggingFace or fine-tuned LLM that's hosted on Predibase
```

```
result = llm.complete("Can you recommend me a nice dry white wine?")print(result)
```
Flow 2: Retrieval Augmented Generation (RAG) with Predibase LLM[](#flow-2-retrieval-augmented-generation-rag-with-predibase-llm "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContext
```
### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
### Load Documents[](#load-documents "Permalink to this heading")


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
### Configure Predibase LLM[](#configure-predibase-llm "Permalink to this heading")


```
llm = PredibaseLLM(    model\_name="llama-2-13b",    temperature=0.3,    max\_new\_tokens=400,    context\_window=1024,)service\_context = ServiceContext.from\_defaults(    chunk\_size=1024, llm=llm, embed\_model="local:BAAI/bge-small-en-v1.5")
```
### Setup and Query Index[](#setup-and-query-index "Permalink to this heading")


```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
print(response)
```
