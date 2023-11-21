[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/customization/llms/AzureOpenAI.ipynb)

Azure OpenAI[](#azure-openai "Permalink to this heading")
==========================================================

Azure openAI resources unfortunately differ from standard openAI resources as you can’t generate embeddings unless you use an embedding model. The regions where these models are available can be found here: https://learn.microsoft.com/en-us/azure/cognitive-services/openai/concepts/models#embeddings-models

Furthermore the regions that support embedding models unfortunately don’t support the latest versions (<\*>-003) of openAI models, so we are forced to use one region for embeddings and another for the text generation.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import AzureOpenAIEmbeddingfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextimport loggingimport syslogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputlogging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Here, we setup the embedding model (for retrieval) and llm (for text generation).Note that you need not only model names (e.g. “text-embedding-ada-002”), but also model deployment names (the one you chose when deploying the model in Azure.You must pass the deployment name as a parameter when you initialize `AzureOpenAI` and `OpenAIEmbedding`.


```
api\_key = "<api-key>"azure\_endpoint = "https://<your-resource-name>.openai.azure.com/"api\_version = "2023-07-01-preview"llm = AzureOpenAI(    model="gpt-35-turbo-16k",    deployment\_name="my-custom-llm",    api\_key=api\_key,    azure\_endpoint=azure\_endpoint,    api\_version=api\_version,)# You need to deploy your own embedding model as well as your own chat completion modelembed\_model = AzureOpenAIEmbedding(    model="text-embedding-ada-002",    deployment\_name="my-custom-embedding",    api\_key=api\_key,    azure\_endpoint=azure\_endpoint,    api\_version=api\_version,)
```

```
from llama\_index import set\_global\_service\_contextservice\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embed\_model,)set\_global\_service\_context(service\_context)
```

```
documents = SimpleDirectoryReader(    input\_files=["../../data/paul\_graham/paul\_graham\_essay.txt"]).load\_data()index = VectorStoreIndex.from\_documents(documents)
```

```
INFO:httpx:HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"
```

```
query = "What is most interesting about this essay?"query\_engine = index.as\_query\_engine()answer = query\_engine.query(query)print(answer.get\_formatted\_sources())print("query was:", query)print("answer was:", answer)
```

```
INFO:httpx:HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-embedding/embeddings?api-version=2023-07-01-preview "HTTP/1.1 200 OK"INFO:httpx:HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-llm/chat/completions?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-llm/chat/completions?api-version=2023-07-01-preview "HTTP/1.1 200 OK"HTTP Request: POST https://test-simon.openai.azure.com//openai/deployments/my-custom-llm/chat/completions?api-version=2023-07-01-preview "HTTP/1.1 200 OK"> Source (Doc id: 3e0d1e3f-9099-483f-9abd-8f352c5e730f): A lot of Lisp hackers dream of building a new Lisp, partly because one of the distinctive feature...> Source (Doc id: 06c1d986-1856-44cd-980d-651252ad1caf): What I Worked OnFebruary 2021Before college the two main things I worked on, outside of schoo...query was: What is most interesting about this essay?answer was: The most interesting aspect of this essay is the author's exploration of the transformative power of publishing essays online. The author reflects on how the internet has democratized the publishing process, allowing anyone to publish their work and reach a wide audience. This realization led the author to start writing and publishing essays online, which eventually became a significant part of their work. The author also discusses the initial skepticism and lack of prestige associated with online essays, but they find encouragement in the potential for genuine discovery and the absence of the desire to impress others. Overall, the essay highlights the author's personal journey and the impact of online publishing on their career.
```
