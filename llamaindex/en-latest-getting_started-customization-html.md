Customization Tutorial[](#customization-tutorial "Permalink to this heading")
==============================================================================

Tip

If you haven’t already, [install LlamaIndex](installation.html) and complete the [starter tutorial](starter_example.html). If you run into terms you don’t recognize, check out the [high-level concepts](concepts.html).

In this tutorial, we start with the code you wrote for the [starter example](starter_example.html) and show you the most common ways you might want to customize it for your use case:


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```


---

**“I want to parse my documents into smaller chunks”**


```
from llama\_index import ServiceContextservice\_context = ServiceContext.from\_defaults(chunk\_size=1000)
```
The [ServiceContext](../module_guides/supporting_modules/service_context.html) is a bundle of services and configurations used across a LlamaIndex pipeline.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```


---

**“I want to use a different vector store”**


```
import chromadbfrom llama\_index.vector\_stores import ChromaVectorStorefrom llama\_index import StorageContextchroma\_client = chromadb.PersistentClient()chroma\_collection = chroma\_client.create\_collection("quickstart")vector\_store = ChromaVectorStore(chroma\_collection=chroma\_collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)
```
StorageContext defines the storage backend for where the documents, embeddings, and indexes are stored. You can learn more about [storage](../module_guides/storing/storing.html) and [how to customize it](../module_guides/storing/customization.html).


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```


---

**“I want to retrieve more context when I query”**


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(similarity\_top\_k=5)response = query\_engine.query("What did the author do growing up?")print(response)
```
as\_query\_engine builds a default retriever and query engine on top of the index. You can configure the retriever and query engine by passing in keyword arguments. Here, we configure the retriever to return the top 5 most similar documents (instead of the default of 2). You can learn more about retrievers <../module\_guides/querying/retrievers.html>\_ and query engines <../module\_guides/putting\_it\_all\_together/query\_engine/root.html>\_



---

**“I want to use a different LLM”**


```
from llama\_index import ServiceContextfrom llama\_index.llms import PaLMservice\_context = ServiceContext.from\_defaults(llm=PaLM())
```
You can learn more about [customizing LLMs](../module_guides/models/llms.html).


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(service\_context=service\_context)response = query\_engine.query("What did the author do growing up?")print(response)
```


---

**“I want to use a different response mode”**


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(response\_mode="tree\_summarize")response = query\_engine.query("What did the author do growing up?")print(response)
```
You can learn more about [query engines](../module_guides/querying/querying.html) and [response modes](../module_guides/putting_it_all_together/query_engine/response_modes.html).



---

**“I want to stream the response back”**


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(streaming=True)response = query\_engine.query("What did the author do growing up?")response.print\_response\_stream()
```
You can learn more about [streaming responses](../module_guides/putting_it_all_together/query_engine/streaming.html).



---

**“I want a chatbot instead of Q&A”**


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_chat\_engine()response = query\_engine.chat("What did the author do growing up?")print(response)response = query\_engine.chat("Oh interesting, tell me more.")print(response)
```
Learn more about the [chat engine](../module_guides/putting_it_all_together/chat_engines/usage_pattern.html).



---

Next Steps

* want a thorough walkthrough of (almost) everything you can configure? Get started with [Understanding LlamaIndex](../understanding/understanding.html).
* want more in-depth understanding of specific modules? Check out the module guides in the left nav 👈
