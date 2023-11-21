Indexing[](#indexing "Permalink to this heading")
==================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

An `Index` is a data structure that allows us to quickly retrieve relevant context for a user query.For LlamaIndex, it’s the core foundation for retrieval-augmented generation (RAG) use-cases.

At a high-level, `Indexes` are built from [Documents](../loading/documents_and_nodes/root.html).They are used to build [Query Engines](../deploying/query_engine/root.html) and [Chat Engines](../deploying/chat_engines/root.html)which enables question & answer and chat over your data.

Under the hood, `Indexes` store data in `Node` objects (which represent chunks of the original documents), and expose a [Retriever](../querying/retriever/root.html) interface that supports additional configuration and automation.

For a more in-depth explanation, check out our guide below:

* [How Each Index Works](index_guide.html)
Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex.from\_documents(docs)
```
* [Usage Pattern](usage_pattern.html)
	+ [Get Started](usage_pattern.html#get-started)
	+ [Configuring Document Parsing](usage_pattern.html#configuring-document-parsing)
	+ [Handling Document Update](usage_pattern.html#handling-document-update)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

* [Module Guides](modules.html)
	+ [Vector Store Index](vector_store_guide.html)
	+ [Summary Index](index_guide.html)
	+ [Tree Index](index_guide.html)
	+ [Keyword Table Index](index_guide.html)
	+ [Knowledge Graph Index](../../examples/index_structs/knowledge_graph/KnowledgeGraphDemo.html)
	+ [Custom Retriever combining KG Index and VectorStore Index](../../examples/index_structs/knowledge_graph/KnowledgeGraphIndex_vs_VectorStoreIndex_vs_CustomIndex_combined.html)
	+ [Knowledge Graph Query Engine](../../examples/query_engine/knowledge_graph_query_engine.html)
	+ [Knowledge Graph RAG Query Engine](../../examples/query_engine/knowledge_graph_rag_query_engine.html)
	+ [REBEL + Knowledge Graph Index](https://colab.research.google.com/drive/1G6pcR0pXvSkdMQlAK_P-IrYgo-_staxd?usp=sharing)
	+ [REBEL + Wikipedia Filtering](../../examples/index_structs/knowledge_graph/knowledge_graph2.html)
	+ [SQL Index](../../examples/index_structs/struct_indices/SQLIndexDemo.html)
	+ [SQL Query Engine with LlamaIndex + DuckDB](../../examples/index_structs/struct_indices/duckdb_sql_query.html)
	+ [Document Summary Index](../../examples/index_structs/doc_summary/DocSummary.html)
Advanced Concepts[](#advanced-concepts "Permalink to this heading")
--------------------------------------------------------------------

* [Composability](composability.html)
