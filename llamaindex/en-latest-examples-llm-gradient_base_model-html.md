[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/llm/gradient_base_model.ipynb)

Gradient Base Model[](#gradient-base-model "Permalink to this heading")
========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%pip install llama-index --quiet%pip install gradientai --quiet
```

```
import osos.environ["GRADIENT\_ACCESS\_TOKEN"] = "{GRADIENT\_ACCESS\_TOKEN}"os.environ["GRADIENT\_WORKSPACE\_ID"] = "{GRADIENT\_WORKSPACE\_ID}"
```
Flow 1: Query Gradient LLM directly[](#flow-1-query-gradient-llm-directly "Permalink to this heading")
-------------------------------------------------------------------------------------------------------


```
from llama\_index.llms import GradientBaseModelLLMllm = GradientBaseModelLLM(    base\_model\_slug="llama2-7b-chat",    max\_tokens=400,)
```

```
result = llm.complete("Can you tell me about large language models?")print(result)
```
Flow 2: Retrieval Augmented Generation (RAG) with Gradient LLM[](#flow-2-retrieval-augmented-generation-rag-with-gradient-llm "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.embeddings import LangchainEmbeddingfrom langchain.embeddings import HuggingFaceEmbeddings
```
### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
### Load Documents[](#load-documents "Permalink to this heading")


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
### Configure Gradient LLM[](#configure-gradient-llm "Permalink to this heading")


```
embed\_model = LangchainEmbedding(HuggingFaceEmbeddings())service\_context = ServiceContext.from\_defaults(    chunk\_size=1024, llm=llm, embed\_model=embed\_model)
```
### Setup and Query Index[](#setup-and-query-index "Permalink to this heading")


```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)query\_engine = index.as\_query\_engine()
```

```
response = query\_engine.query(    "What did the author do after his time at Y Combinator?")print(response)
```
