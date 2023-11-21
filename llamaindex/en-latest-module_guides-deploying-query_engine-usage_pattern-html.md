Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Build a query engine from index:


```
query\_engine = index.as\_query\_engine()
```
Tip

To learn how to build an index, see [Indexing](../../indexing/indexing.html)

Ask a question over your data


```
response = query\_engine.query("Who is Paul Graham?")
```
Configuring a Query Engine[](#configuring-a-query-engine "Permalink to this heading")
--------------------------------------------------------------------------------------

### High-Level API[](#high-level-api "Permalink to this heading")

You can directly build and configure a query engine from an index in 1 line of code:


```
query\_engine = index.as\_query\_engine(    response\_mode="tree\_summarize",    verbose=True,)
```

> Note: While the high-level API optimizes for ease-of-use, it does *NOT* expose full range of configurability.
> 
> 

See [**Response Modes**](response_modes.html) for a full list of response modes and what they do.

### Low-Level Composition API[](#low-level-composition-api "Permalink to this heading")

You can use the low-level composition API if you need more granular control.Concretely speaking, you would explicitly construct a `QueryEngine` object instead of calling `index.as\_query\_engine(...)`.


> Note: You may need to look at API references or example notebooks.
> 
> 


```
from llama\_index import (    VectorStoreIndex,    get\_response\_synthesizer,)from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.query\_engine import RetrieverQueryEngine# build indexindex = VectorStoreIndex.from\_documents(documents)# configure retrieverretriever = VectorIndexRetriever(    index=index,    similarity\_top\_k=2,)# configure response synthesizerresponse\_synthesizer = get\_response\_synthesizer(    response\_mode="tree\_summarize",)# assemble query enginequery\_engine = RetrieverQueryEngine(    retriever=retriever,    response\_synthesizer=response\_synthesizer,)# queryresponse = query\_engine.query("What did the author do growing up?")print(response)
```
### Streaming[](#streaming "Permalink to this heading")

To enable streaming, you simply need to pass in a `streaming=True` flag


```
query\_engine = index.as\_query\_engine(    streaming=True,)streaming\_response = query\_engine.query(    "What did the author do growing up?",)streaming\_response.print\_response\_stream()
```
* Read the full [streaming guide](streaming.html)
* See an [end-to-end example](../../../examples/customization/streaming/SimpleIndexDemo-streaming.html)
Defining a Custom Query Engine[](#defining-a-custom-query-engine "Permalink to this heading")
----------------------------------------------------------------------------------------------

You can also define a custom query engine. Simply subclass the `CustomQueryEngine` class, define any attributes you’d want to have (similar to defining a Pydantic class), and implement a `custom\_query` function that returns either a `Response` object or a string.


```
from llama\_index.query\_engine import CustomQueryEnginefrom llama\_index.retrievers import BaseRetrieverfrom llama\_index.response\_synthesizers import (    get\_response\_synthesizer,    BaseSynthesizer,)class RAGQueryEngine(CustomQueryEngine): """RAG Query Engine."""    retriever: BaseRetriever    response\_synthesizer: BaseSynthesizer    def custom\_query(self, query\_str: str):        nodes = self.retriever.retrieve(query\_str)        response\_obj = self.response\_synthesizer.synthesize(query\_str, nodes)        return response\_obj
```
See the [Custom Query Engine guide](../../../examples/query_engine/custom_query_engine.html) for more details.

