How Each Index Works[](#how-each-index-works "Permalink to this heading")
==========================================================================

This guide describes how each index works with diagrams.

Some terminology:

* **Node**: Corresponds to a chunk of text from a Document. LlamaIndex takes in Document objects and internally parses/chunks them into Node objects.
* **Response Synthesis**: Our module which synthesizes a response given the retrieved Node. You can see how to[specify different response modes](../deploying/query_engine/response_modes.html).

Summary Index (formerly List Index)[](#summary-index-formerly-list-index "Permalink to this heading")
------------------------------------------------------------------------------------------------------

The summary index simply stores Nodes as a sequential chain.

![](../../_images/list.png)

### Querying[](#querying "Permalink to this heading")

During query time, if no other query parameters are specified, LlamaIndex simply loads all Nodes in the list intoour Response Synthesis module.

![](../../_images/list_query.png)

The summary index does offer numerous ways of querying a summary index, from an embedding-based query whichwill fetch the top-k neighbors, or with the addition of a keyword filter, as seen below:

![](../../_images/list_filter_query.png)

Vector Store Index[](#vector-store-index "Permalink to this heading")
----------------------------------------------------------------------

The vector store index stores each Node and a corresponding embedding in a [Vector Store](../../community/integrations/vector_stores.html#vector-store-index).

![](../../_images/vector_store.png)

### Querying[](#id1 "Permalink to this heading")

Querying a vector store index involves fetching the top-k most similar Nodes, and passingthose into our Response Synthesis module.

![](../../_images/vector_store_query.png)

Tree Index[](#tree-index "Permalink to this heading")
------------------------------------------------------

The tree index builds a hierarchical tree from a set of Nodes (which become leaf nodes in this tree).

![](../../_images/tree.png)

### Querying[](#id2 "Permalink to this heading")

Querying a tree index involves traversing from root nodes downto leaf nodes. By default, (`child\_branch\_factor=1`), a querychooses one child node given a parent node. If `child\_branch\_factor=2`, a querychooses two child nodes per level.

![](../../_images/tree_query.png)

Keyword Table Index[](#keyword-table-index "Permalink to this heading")
------------------------------------------------------------------------

The keyword table index extracts keywords from each Node and builds a mapping fromeach keyword to the corresponding Nodes of that keyword.

![](../../_images/keyword.png)

### Querying[](#id3 "Permalink to this heading")

During query time, we extract relevant keywords from the query, and match those with pre-extractedNode keywords to fetch the corresponding Nodes. The extracted Nodes are passed to ourResponse Synthesis module.

![](../../_images/keyword_query.png)

