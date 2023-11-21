Retriever Modes[](#retriever-modes "Permalink to this heading")
================================================================

Here we show the mapping from `retriever\_mode` configuration to the selected retriever class.


> Note that `retriever\_mode` can mean different thing for different index classes.
> 
> 

Vector Index[](#vector-index "Permalink to this heading")
----------------------------------------------------------

Specifying `retriever\_mode` has no effect (silently ignored).`vector\_index.as\_retriever(...)` always returns a VectorIndexRetriever.

Summary Index[](#summary-index "Permalink to this heading")
------------------------------------------------------------

* `default`: SummaryIndexRetriever
* `embedding`: SummaryIndexEmbeddingRetriever
* `llm`: SummaryIndexLLMRetriever
Tree Index[](#tree-index "Permalink to this heading")
------------------------------------------------------

* `select\_leaf`: TreeSelectLeafRetriever
* `select\_leaf\_embedding`: TreeSelectLeafEmbeddingRetriever
* `all\_leaf`: TreeAllLeafRetriever
* `root`: TreeRootRetriever
Keyword Table Index[](#keyword-table-index "Permalink to this heading")
------------------------------------------------------------------------

* `default`: KeywordTableGPTRetriever
* `simple`: KeywordTableSimpleRetriever
* `rake`: KeywordTableRAKERetriever
Knowledge Graph Index[](#knowledge-graph-index "Permalink to this heading")
----------------------------------------------------------------------------

* `keyword`: KGTableRetriever
* `embedding`: KGTableRetriever
* `hybrid`: KGTableRetriever
Document Summary Index[](#document-summary-index "Permalink to this heading")
------------------------------------------------------------------------------

* `llm`: DocumentSummaryIndexLLMRetriever
* `embedding`: DocumentSummaryIndexEmbeddingRetrievers
