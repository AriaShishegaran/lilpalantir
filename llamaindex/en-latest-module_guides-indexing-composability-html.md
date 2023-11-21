Composability[](#composability "Permalink to this heading")
============================================================

LlamaIndex offers **composability** of your indices, meaning that you can build indices on top of other indices. This allows you to more effectively index your entire document tree in order to feed custom knowledge to GPT.

Composability allows you to to define lower-level indices for each document, and higher-order indices over a collection of documents. To see how this works, imagine defining 1) a tree index for the text within each document, and 2) a summary index over each tree index (one document) within your collection.

Defining Subindices[](#defining-subindices "Permalink to this heading")
------------------------------------------------------------------------

To see how this works, imagine you have 3 documents: `doc1`, `doc2`, and `doc3`.


```
from llama\_index import SimpleDirectoryReaderdoc1 = SimpleDirectoryReader("data1").load\_data()doc2 = SimpleDirectoryReader("data2").load\_data()doc3 = SimpleDirectoryReader("data3").load\_data()
```
![](../../_images/diagram_b0.png)

Now let’s define a tree index for each document. In order to persist the graph later, each index should share the same storage context.

In Python, we have:


```
from llama\_index import TreeIndexstorage\_context = storage\_context.from\_defaults()index1 = TreeIndex.from\_documents(doc1, storage\_context=storage\_context)index2 = TreeIndex.from\_documents(doc2, storage\_context=storage\_context)index3 = TreeIndex.from\_documents(doc3, storage\_context=storage\_context)
```
![](../../_images/diagram_b1.png)

Defining Summary Text[](#defining-summary-text "Permalink to this heading")
----------------------------------------------------------------------------

You then need to explicitly define *summary text* for each subindex. This allowsthe subindices to be used as Documents for higher-level indices.


```
index1\_summary = "<summary1>"index2\_summary = "<summary2>"index3\_summary = "<summary3>"
```
You may choose to manually specify the summary text, or use LlamaIndex itself to generatea summary, for instance with the following:


```
summary = index1.query(    "What is a summary of this document?", retriever\_mode="all\_leaf")index1\_summary = str(summary)
```
**If specified**, this summary text for each subindex can be used to refine the answer during query-time.

Creating a Graph with a Top-Level Index[](#creating-a-graph-with-a-top-level-index "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------

We can then create a graph with a summary index on top of these 3 tree indices:We can query, save, and load the graph to/from disk as any other index.


```
from llama\_index.indices.composability import ComposableGraphgraph = ComposableGraph.from\_indices(    SummaryIndex,    [index1, index2, index3],    index\_summaries=[index1\_summary, index2\_summary, index3\_summary],    storage\_context=storage\_context,)
```
![](../../_images/diagram.png)

Querying the Graph[](#querying-the-graph "Permalink to this heading")
----------------------------------------------------------------------

During a query, we would start with the top-level summary index. Each node in the list corresponds to an underlying tree index.The query will be executed recursively, starting from the root index, then the sub-indices.The default query engine for each index is called under the hood (i.e. `index.as\_query\_engine()`), unless otherwise configured by passing `custom\_query\_engines` to the `ComposableGraphQueryEngine`.Below we show an example that configure the tree index retrievers to use `child\_branch\_factor=2` (instead of the default `child\_branch\_factor=1`).

More detail on how to configure `ComposableGraphQueryEngine` can be found [here](../../api_reference/query/query_engines/graph_query_engine.html).


```
# set custom retrievers. An example is provided belowcustom\_query\_engines = {    index.index\_id: index.as\_query\_engine(child\_branch\_factor=2)    for index in [index1, index2, index3]}query\_engine = graph.as\_query\_engine(custom\_query\_engines=custom\_query\_engines)response = query\_engine.query("Where did the author grow up?")
```

> Note that specifying custom retriever for index by idmight require you to inspect e.g., `index1.index\_id`.Alternatively, you can explicitly set it as follows:
> 
> 


```
index1.set\_index\_id("<index\_id\_1>")index2.set\_index\_id("<index\_id\_2>")index3.set\_index\_id("<index\_id\_3>")
```
![](../../_images/diagram_q1.png)

So within a node, instead of fetching the text, we would recursively query the stored tree index to retrieve our answer.

![](../../_images/diagram_q2.png)

NOTE: You can stack indices as many times as you want, depending on the hierarchies of your knowledge base!

[Optional] Persisting the Graph[](#optional-persisting-the-graph "Permalink to this heading")
----------------------------------------------------------------------------------------------

The graph can also be persisted to storage, and then loaded again when needed. Note that you’ll need to set theID of the root index, or keep track of the default.


```
# set the IDgraph.root\_index.set\_index\_id("my\_id")# persist to storagegraph.root\_index.storage\_context.persist(persist\_dir="./storage")# loadfrom llama\_index import StorageContext, load\_graph\_from\_storagestorage\_context = StorageContext.from\_defaults(persist\_dir="./storage")graph = load\_graph\_from\_storage(storage\_context, root\_id="my\_id")
```
We can take a look at a code example below as well. We first build two tree indices, one over the Wikipedia NYC page, and the other over Paul Graham’s essay. We then define a keyword extractor index over the two tree indices.

[Here is an example notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/ComposableIndices.ipynb).

Examples

* [Composable Graph Basic](../../examples/composable_indices/ComposableIndices-Prior.html)
* [Composable Graph with Weaviate](../../examples/composable_indices/ComposableIndices-Weaviate.html)
* [Composable Graph](../../examples/composable_indices/ComposableIndices.html)
