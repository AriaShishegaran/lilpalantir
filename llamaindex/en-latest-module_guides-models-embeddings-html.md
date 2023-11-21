Embeddings[](#embeddings "Permalink to this heading")
======================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Embeddings are used in LlamaIndex to represent your documents using a sophisticated numerical representation. Embedding models take text as input, and return a long list of numbers used to capture the semantics of the text. These embedding models have been trained to represent text this way, and help enable many applications, including search!

At a high level, if a user asks a question about dogs, then the embedding for that question will be highly similar to text that talks about dogs.

When calculating the similarity between embeddings, there are many methods to use (dot product, cosine similarity, etc.). By default, LlamaIndex uses cosine similarity when comparing embeddings.

There are many embedding models to pick from. By default, LlamaIndex uses `text-embedding-ada-002` from OpenAI. We also support any embedding model offered by Langchain [here](https://python.langchain.com/docs/modules/data_connection/text_embedding/), as well as providing an easy to extend base class for implementing your own embeddings.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Most commonly in LlamaIndex, embedding models will be specified in the `ServiceContext` object, and then used in a vector index. The embedding model will be used to embed the documents used during index construction, as well as embedding any queries you make using the query engine later on.


```
from llama\_index import ServiceContextfrom llama\_index.embeddings import OpenAIEmbeddingembed\_model = OpenAIEmbedding()service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)
```
To save costs, you may want to use a local model.


```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(embed\_model="local")
```
This will use a well-performing and fast default from Hugging Face.

You can find more usage details and available customization options below.

Getting Started[](#getting-started "Permalink to this heading")
----------------------------------------------------------------

The most common usage for an embedding model will be setting it in the service context object, and then using it to construct an index and query. The input documents will be broken into nodes, and the emedding model will generate an embedding for each node.

By default, LlamaIndex will use `text-embedding-ada-002`, which is what the example below manually sets up for you.


```
from llama\_index import ServiceContext, VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.embeddings import OpenAIEmbeddingembed\_model = OpenAIEmbedding()service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)# optionally set a global service context to avoid passing it into other objects every timefrom llama\_index import set\_global\_service\_contextset\_global\_service\_context(service\_context)documents = SimpleDirectoryReader("./data").load\_data()index = VectorStoreIndex.from\_documents(documents)
```
Then, at query time, the embedding model will be used again to embed the query text.


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("query string")
```
Customization[](#customization "Permalink to this heading")
------------------------------------------------------------

### Batch Size[](#batch-size "Permalink to this heading")

By default, embeddings requests are sent to OpenAI in batches of 10. For some users, this may (rarely) incur a rate limit. For other users embedding many documents, this batch size may be too small.


```
# set the batch size to 42embed\_model = OpenAIEmbedding(embed\_batch\_size=42)
```
### Local Embedding Models[](#local-embedding-models "Permalink to this heading")

The easiest way to use a local model is:


```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(embed\_model="local")
```
To configure the model used (from Hugging Face hub), add the model name separated by a colon:


```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(    embed\_model="local:BAAI/bge-large-en")
```
### HuggingFace Optimum ONNX Embeddings[](#huggingface-optimum-onnx-embeddings "Permalink to this heading")

LlamaIndex also supports creating and using ONNX embeddings using the Optimum library from HuggingFace. Simple create and save the ONNX embeddings, and use them.

Some prerequisites:


```
pip install transformers optimum[exporters]
```
Creation with specifying the model and output path:


```
from llama\_index.embeddings import OptimumEmbeddingOptimumEmbedding.create\_and\_save\_optimum\_model(    "BAAI/bge-small-en-v1.5", "./bge\_onnx")
```
And then usage:


```
embed\_model = OptimumEmbedding(folder\_name="./bge\_onnx")service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)
```
### LangChain Integrations[](#langchain-integrations "Permalink to this heading")

We also support any embeddings offered by Langchain [here](https://python.langchain.com/docs/modules/data_connection/text_embedding/).

The example below loads a model from Hugging Face, using Langchain’s embedding class.


```
from langchain.embeddings.huggingface import HuggingFaceBgeEmbeddingsfrom llama\_index import ServiceContextembed\_model = HuggingFaceBgeEmbeddings(model\_name="BAAI/bge-base-en")service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)
```
### Custom Embedding Model[](#custom-embedding-model "Permalink to this heading")

If you wanted to use embeddings not offered by LlamaIndex or Langchain, you can also extend our base embeddings class and implement your own!

The example below uses Instructor Embeddings ([install/setup details here](https://huggingface.co/hkunlp/instructor-large)), and implements a custom embeddings class. Instructor embeddings work by providing text, as well as “instructions” on the domain of the text to embed. This is helpful when embedding text from a very specific and specialized topic.


```
from typing import Any, Listfrom InstructorEmbedding import INSTRUCTORfrom llama\_index.embeddings.base import BaseEmbeddingclass InstructorEmbeddings(BaseEmbedding):    def \_\_init\_\_(        self,        instructor\_model\_name: str = "hkunlp/instructor-large",        instruction: str = "Represent the Computer Science documentation or question:",        \*\*kwargs: Any,    ) -> None:        self.\_model = INSTRUCTOR(instructor\_model\_name)        self.\_instruction = instruction        super().\_\_init\_\_(\*\*kwargs)        def \_get\_query\_embedding(self, query: str) -> List[float]:            embeddings = self.\_model.encode([[self.\_instruction, query]])            return embeddings[0]        def \_get\_text\_embedding(self, text: str) -> List[float]:            embeddings = self.\_model.encode([[self.\_instruction, text]])            return embeddings[0]        def \_get\_text\_embeddings(self, texts: List[str]) -> List[List[float]]:            embeddings = self.\_model.encode(                [[self.\_instruction, text] for text in texts]            )            return embeddings
```
Standalone Usage[](#standalone-usage "Permalink to this heading")
------------------------------------------------------------------

You can also use embeddings as a standalone module for your project, existing application, or general testing and exploration.


```
embeddings = embed\_model.get\_text\_embedding(    "It is raining cats and dogs here!")
```
Modules[](#modules "Permalink to this heading")
------------------------------------------------

We support integrations with OpenAI, Azure, and anything LangChain offers.

* [OpenAI Embeddings](../../examples/embeddings/OpenAI.html)
* [Langchain Embeddings](../../examples/embeddings/Langchain.html)
* [CohereAI Embeddings](../../examples/embeddings/cohereai.html)
* [Gradient Embeddings](../../examples/embeddings/gradient.html)
* [Azure OpenAI](../../examples/customization/llms/AzureOpenAI.html)
* [Custom Embeddings](../../examples/embeddings/custom_embeddings.html)
* [Local Embeddings with HuggingFace](../../examples/embeddings/huggingface.html)
* [Elasticsearch Embeddings](../../examples/embeddings/elasticsearch.html)
* [Embeddings with Clarifai](../../examples/embeddings/clarifai.html)
* [LLMRails Embeddings](../../examples/embeddings/llm_rails.html)
* [Text Embedding Inference](../../examples/embeddings/text_embedding_inference.html)
* [Google PaLM Embeddings](../../examples/embeddings/google_palm.html)
* [Jina Embeddings](../../examples/embeddings/jinaai_embeddings.html)
