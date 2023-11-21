Query Engine[](#query-engine "Permalink to this heading")
==========================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Query engine is a generic interface that allows you to ask question over your data.

A query engine takes in a natural language query, and returns a rich response.It is most often (but not always) built on one or many [indexes](../../indexing/indexing.html) via [retrievers](../../querying/retriever/root.html).You can compose multiple query engines to achieve more advanced capability.

Tip

If you want to have a conversation with your data (multiple back-and-forth instead of a single question & answer), take a look at [chat Engine](../chat_engines/root.html)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Who is Paul Graham.")
```
To stream response:


```
query\_engine = index.as\_query\_engine(streaming=True)streaming\_response = query\_engine.query("Who is Paul Graham.")streaming\_response.print\_response\_stream()
```
* [Usage Pattern](usage_pattern.html)
	+ [Get Started](usage_pattern.html#get-started)
	+ [Configuring a Query Engine](usage_pattern.html#configuring-a-query-engine)
	+ [Defining a Custom Query Engine](usage_pattern.html#defining-a-custom-query-engine)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

* [Module Guides](modules.html)
	+ [Basic](modules.html#basic)
		- [Custom Query Engine](../../../examples/query_engine/custom_query_engine.html)
		- [Retriever Query Engine](../../../examples/query_engine/CustomRetrievers.html)
	+ [Structured & Semi-Structured Data](modules.html#structured-semi-structured-data)
		- [Text-to-SQL Guide (Query Engine + Retriever)](../../../examples/index_structs/struct_indices/SQLIndexDemo.html)
		- [JSON Query Engine](../../../examples/query_engine/json_query_engine.html)
		- [Pandas Query Engine](../../../examples/query_engine/pandas_query_engine.html)
		- [Knowledge Graph Query Engine](../../../examples/query_engine/knowledge_graph_query_engine.html)
		- [Knowledge Graph RAG Query Engine](../../../examples/query_engine/knowledge_graph_rag_query_engine.html)
	+ [Advanced](modules.html#advanced)
		- [Router Query Engine](../../../examples/query_engine/RouterQueryEngine.html)
		- [Retriever Router Query Engine](../../../examples/query_engine/RetrieverRouterQueryEngine.html)
		- [Joint QA Summary Query Engine](../../../examples/query_engine/JointQASummary.html)
		- [Sub Question Query Engine](../../../examples/query_engine/sub_question_query_engine.html)
		- [Multi-Step Query Engine](../../../examples/query_transformations/SimpleIndexDemo-multistep.html)
		- [SQL Router Query Engine](../../../examples/query_engine/SQLRouterQueryEngine.html)
		- [SQL Auto Vector Query Engine](../../../examples/query_engine/SQLAutoVectorQueryEngine.html)
		- [SQL Join Query Engine](../../../examples/query_engine/SQLJoinQueryEngine.html)
		- [[Beta] Text-to-SQL with PGVector](../../../examples/query_engine/pgvector_sql_query_engine.html)
		- [SQL Query Engine with LlamaIndex + DuckDB](../../../examples/index_structs/struct_indices/duckdb_sql_query.html)
		- [Retry Query Engine](../../../examples/evaluation/RetryQuery.html)
		- [CitationQueryEngine](../../../examples/query_engine/citation_query_engine.html)
		- [Recursive Retriever + Query Engine Demo](../../../examples/query_engine/pdf_tables/recursive_retriever.html)
		- [Joint Tabular/Semantic QA over Tesla 10K](../../../examples/query_engine/sec_tables/tesla_10q_table.html)
		- [Recursive Retriever + Document Agents](../../../examples/query_engine/recursive_retriever_agents.html)
		- [Ensemble Query Engine Guide](../../../examples/query_engine/ensemble_query_engine.html)
		- [Advanced: Towards Multi-Document Querying/Analysis](modules.html#advanced-towards-multi-document-querying-analysis)
	+ [Experimental](modules.html#experimental)
		- [FLARE Query Engine](../../../examples/query_engine/flare_query_engine.html)
Supporting Modules[](#supporting-modules "Permalink to this heading")
----------------------------------------------------------------------

* [Supporting Modules](supporting_modules.html)
	+ [Query Transformations](../../../optimizing/advanced_retrieval/query_transformations.html)
