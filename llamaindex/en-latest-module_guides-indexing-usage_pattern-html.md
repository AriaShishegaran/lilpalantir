Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Build an index from documents:


```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex.from\_documents(docs)
```
Tip

To learn how to load documents, see [data connectors](../loading/connector/root.html)

### What is happening under the hood?[](#what-is-happening-under-the-hood "Permalink to this heading")

1. Documents are chunked up and parsed into `Node` objects (which are lightweight abstractions over text str that additionally keep track of metadata and relationships).
2. Additional computation is performed to add `Node` into index data structure


> Note: the computation is index-specific.
> 
> 
> 	* For a vector store index, this means calling an embedding model (via API or locally) to compute embedding for the `Node` objects
> 	* For a document summary index, this means calling an LLM to generate a summary
Configuring Document Parsing[](#configuring-document-parsing "Permalink to this heading")
------------------------------------------------------------------------------------------

The most common configuration you might want to change is how to parse document into `Node` objects.

### High-Level API[](#high-level-api "Permalink to this heading")

We can configure our service context to use the desired chunk size and set `show\_progress` to display a progress bar during index construction.


```
from llama\_index import ServiceContext, VectorStoreIndexservice\_context = ServiceContext.from\_defaults(chunk\_size=512)index = VectorStoreIndex.from\_documents(    docs, service\_context=service\_context, show\_progress=True)
```

> Note: While the high-level API optimizes for ease-of-use, it does *NOT* expose full range of configurability.
> 
> 

### Low-Level API[](#low-level-api "Permalink to this heading")

You can use the low-level composition API if you need more granular control.

Here we show an example where you want to both modify the text chunk size, disable injecting metadata, and disable creating `Node` relationships.The steps are:

1. Configure a node parser


```
from llama\_index.node\_parser import SimpleNodeParserparser = SimpleNodeParser.from\_defaults(    chunk\_size=512,    include\_extra\_info=False,    include\_prev\_next\_rel=False,)
```
2. Parse document into `Node` objects


```
nodes = parser.get\_nodes\_from\_documents(documents)
```
3. build index from `Node` objects


```
index = VectorStoreIndex(nodes)
```
Handling Document Update[](#handling-document-update "Permalink to this heading")
----------------------------------------------------------------------------------

Read more about how to deal with data sources that change over time with `Index` **insertion**, **deletion**, **update**, and **refresh** operations.

* [Metadata Extraction](metadata_extraction.html)
* [Document Management](document_management.html)
