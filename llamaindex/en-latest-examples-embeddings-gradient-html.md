[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/gradient.ipynb)

Gradient Embeddings[](#gradient-embeddings "Permalink to this heading")
========================================================================

[Gradient](https://gradient.ai) offers embeddings model that can be easily integrated with LlamaIndex. Below is an example of how to use it with LlamaIndex.


```
# Install the required packages%pip install llama-index --quiet%pip install gradientai --quiet
```
Gradient needs an access token and workspaces id for authorization. They can be obtained from:

* [Gradient UI](https://auth.gradient.ai/login), or
* [Gradient CLI](https://docs.gradient.ai/docs/cli-quickstart) with `gradient env` command.


```
import osos.environ["GRADIENT\_ACCESS\_TOKEN"] = "{GRADIENT\_ACCESS\_TOKEN}"os.environ["GRADIENT\_WORKSPACE\_ID"] = "{GRADIENT\_WORKSPACE\_ID}"
```

```
from llama\_index.llms import GradientBaseModelLLM# NOTE: we use a base model here, you can as well insert your fine-tuned model.llm = GradientBaseModelLLM(    base\_model\_slug="llama2-7b-chat",    max\_tokens=400,)
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Documents[](#load-documents "Permalink to this heading")
--------------------------------------------------------------


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()print(f"Loaded {len(documents)} document(s).")
```
Configure Gradient embeddings[](#configure-gradient-embeddings "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
from llama\_index import ServiceContextfrom llama\_index.embeddings import GradientEmbeddingembed\_model = GradientEmbedding(    gradient\_access\_token=os.environ["GRADIENT\_ACCESS\_TOKEN"],    gradient\_workspace\_id=os.environ["GRADIENT\_WORKSPACE\_ID"],    gradient\_model\_slug="bge-large",)service\_context = ServiceContext.from\_defaults(    chunk\_size=1024, llm=llm, embed\_model=embed\_model)
```
Setup and Query Index[](#setup-and-query-index "Permalink to this heading")
----------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)query\_engine = index.as\_query\_engine()
```

```
response = query\_engine.query(    "What did the author do after his time at Y Combinator?")print(response)
```
