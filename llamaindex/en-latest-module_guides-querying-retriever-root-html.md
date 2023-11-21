Retriever[](#retriever "Permalink to this heading")
====================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Retrievers are responsible for fetching the most relevant context given a user query (or chat message).

It can be built on top of [indexes](../../indexing/indexing.html), but can also be defined independently.It is used as a key building block in [query engines](../../deploying/query_engine/root.html) (and [Chat Engines](../../deploying/chat_engines/root.html)) for retrieving relevant context.

Tip

Confused about where retriever fits in the pipeline? Read about [high-level concepts](../../../getting_started/concepts.html)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
retriever = index.as\_retriever()nodes = retriever.retrieve("Who is Paul Graham?")
```
Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Get a retriever from index:


```
retriever = index.as\_retriever()
```
Retrieve relevant context for a question:


```
nodes = retriever.retrieve("Who is Paul Graham?")
```

> Note: To learn how to build an index, see [Indexing](../../indexing/indexing.html)
> 
> 

High-Level API[](#high-level-api "Permalink to this heading")
--------------------------------------------------------------

### Selecting a Retriever[](#selecting-a-retriever "Permalink to this heading")

You can select the index-specific retriever class via `retriever\_mode`.For example, with a `SummaryIndex`:


```
retriever = summary\_index.as\_retriever(    retriever\_mode="llm",)
```
This creates a [SummaryIndexLLMRetriever](../../../api_reference/query/retrievers/list.html) on top of the summary index.

See [**Retriever Modes**](retriever_modes.html) for a full list of (index-specific) retriever modesand the retriever classes they map to.

### Configuring a Retriever[](#configuring-a-retriever "Permalink to this heading")

In the same way, you can pass kwargs to configure the selected retriever.


> Note: take a look at the API reference for the selected retriever class’ constructor parameters for a list of valid kwargs.
> 
> 

For example, if we selected the “llm” retriever mode, we might do the following:


```
retriever = summary\_index.as\_retriever(    retriever\_mode="llm",    choice\_batch\_size=5,)
```
Low-Level Composition API[](#low-level-composition-api "Permalink to this heading")
------------------------------------------------------------------------------------

You can use the low-level composition API if you need more granular control.

To achieve the same outcome as above, you can directly import and construct the desired retriever class:


```
from llama\_index.indices.list import SummaryIndexLLMRetrieverretriever = SummaryIndexLLMRetriever(    index=summary\_index,    choice\_batch\_size=5,)
```
Examples[](#examples "Permalink to this heading")
--------------------------------------------------

* [Retriever Modules](retrievers.html)
