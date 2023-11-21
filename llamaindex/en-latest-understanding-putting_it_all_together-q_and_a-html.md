Q&A patterns[](#q-a-patterns "Permalink to this heading")
==========================================================

Semantic Search[](#semantic-search "Permalink to this heading")
----------------------------------------------------------------

The most basic example usage of LlamaIndex is through semantic search. We provide a simple in-memory vector store for you to get started, but you can also choose to use any one of our [vector store integrations](../../community/integrations/vector_stores.html):


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```
**Tutorials**

* [Starter Tutorial](../../getting_started/starter_example.html)
* [Basic Usage Pattern](../querying/querying.html)

**Guides**

* [Example](../../examples/vector_stores/SimpleIndexDemo.html) ([Notebook](https://github.com/run-llama/llama_index/tree/main/docs/examples/vector_stores/SimpleIndexDemo.ipynb))
Summarization[](#summarization "Permalink to this heading")
------------------------------------------------------------

A summarization query requires the LLM to iterate through many if not most documents in order to synthesize an answer.For instance, a summarization query could look like one of the following:

* “What is a summary of this collection of text?”
* “Give me a summary of person X’s experience with the company.”

In general, a summary index would be suited for this use case. A summary index by default goes through all the data.

Empirically, setting `response\_mode="tree\_summarize"` also leads to better summarization results.


```
index = SummaryIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(response\_mode="tree\_summarize")response = query\_engine.query("<summarization\_query>")
```
Queries over Structured Data[](#queries-over-structured-data "Permalink to this heading")
------------------------------------------------------------------------------------------

LlamaIndex supports queries over structured data, whether that’s a Pandas DataFrame or a SQL Database.

Here are some relevant resources:

**Tutorials**

* [Guide on Text-to-SQL](structured_data.html)

**Guides**

* [SQL Guide (Core)](../../examples/index_structs/struct_indices/SQLIndexDemo.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/index_structs/struct_indices/SQLIndexDemo.ipynb))
* [Pandas Demo](../../examples/query_engine/pandas_query_engine.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_engine/pandas_query_engine.ipynb))
Synthesis over Heterogeneous Data[](#synthesis-over-heterogeneous-data "Permalink to this heading")
----------------------------------------------------------------------------------------------------

LlamaIndex supports synthesizing across heterogeneous data sources. This can be done by composing a graph over your existing data.Specifically, compose a summary index over your subindices. A summary index inherently combines information for each node; thereforeit can synthesize information across your heterogeneous data sources.


```
from llama\_index import VectorStoreIndex, SummaryIndexfrom llama\_index.indices.composability import ComposableGraphindex1 = VectorStoreIndex.from\_documents(notion\_docs)index2 = VectorStoreIndex.from\_documents(slack\_docs)graph = ComposableGraph.from\_indices(    SummaryIndex, [index1, index2], index\_summaries=["summary1", "summary2"])query\_engine = graph.as\_query\_engine()response = query\_engine.query("<query\_str>")
```
**Guides**

* [City Analysis](../../examples/composable_indices/city_analysis/PineconeDemo-CityAnalysis.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/city_analysis/PineconeDemo-CityAnalysis.ipynb))
Routing over Heterogeneous Data[](#routing-over-heterogeneous-data "Permalink to this heading")
------------------------------------------------------------------------------------------------

LlamaIndex also supports routing over heterogeneous data sources with `RouterQueryEngine` - for instance, if you want to “route” a query to anunderlying Document or a sub-index.

To do this, first build the sub-indices over different data sources.Then construct the corresponding query engines, and give each query engine a description to obtain a `QueryEngineTool`.


```
from llama\_index import TreeIndex, VectorStoreIndexfrom llama\_index.tools import QueryEngineTool...# define sub-indicesindex1 = VectorStoreIndex.from\_documents(notion\_docs)index2 = VectorStoreIndex.from\_documents(slack\_docs)# define query engines and toolstool1 = QueryEngineTool.from\_defaults(    query\_engine=index1.as\_query\_engine(),    description="Use this query engine to do...",)tool2 = QueryEngineTool.from\_defaults(    query\_engine=index2.as\_query\_engine(),    description="Use this query engine for something else...",)
```
Then, we define a `RouterQueryEngine` over them.By default, this uses a `LLMSingleSelector` as the router, which uses the LLM to choose the best sub-index to router the query to, given the descriptions.


```
from llama\_index.query\_engine import RouterQueryEnginequery\_engine = RouterQueryEngine.from\_defaults(    query\_engine\_tools=[tool1, tool2])response = query\_engine.query(    "In Notion, give me a summary of the product roadmap.")
```
**Guides**

* [Router Query Engine Guide](../../examples/query_engine/RouterQueryEngine.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_engine/RouterQueryEngine.ipynb))
* [City Analysis Unified Query Interface](../../examples/composable_indices/city_analysis/City_Analysis-Unified-Query.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/city_analysis/PineconeDemo-CityAnalysis.ipynb))
Compare/Contrast Queries[](#compare-contrast-queries "Permalink to this heading")
----------------------------------------------------------------------------------

You can explicitly perform compare/contrast queries with a **query transformation** module within a ComposableGraph.


```
from llama\_index.indices.query.query\_transform.base import (    DecomposeQueryTransform,)decompose\_transform = DecomposeQueryTransform(    service\_context.llm\_predictor, verbose=True)
```
This module will help break down a complex query into a simpler one over your existing index structure.

**Guides**

* [Query Transformations](../../optimizing/advanced_retrieval/query_transformations.html)
* [City Analysis Compare/Contrast Example](../../examples/composable_indices/city_analysis/City_Analysis-Decompose.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/city_analysis/City_Analysis-Decompose.ipynb))

You can also rely on the LLM to *infer* whether to perform compare/contrast queries (see Multi-Document Queries below).

Multi-Document Queries[](#multi-document-queries "Permalink to this heading")
------------------------------------------------------------------------------

Besides the explicit synthesis/routing flows described above, LlamaIndex can support more general multi-document queries as well.It can do this through our `SubQuestionQueryEngine` class. Given a query, this query engine will generate a “query plan” containingsub-queries against sub-documents before synthesizing the final answer.

To do this, first define an index for each document/data source, and wrap it with a `QueryEngineTool` (similar to above):


```
from llama\_index.tools import QueryEngineTool, ToolMetadataquery\_engine\_tools = [    QueryEngineTool(        query\_engine=sept\_engine,        metadata=ToolMetadata(            name="sept\_22",            description="Provides information about Uber quarterly financials ending September 2022",        ),    ),    QueryEngineTool(        query\_engine=june\_engine,        metadata=ToolMetadata(            name="june\_22",            description="Provides information about Uber quarterly financials ending June 2022",        ),    ),    QueryEngineTool(        query\_engine=march\_engine,        metadata=ToolMetadata(            name="march\_22",            description="Provides information about Uber quarterly financials ending March 2022",        ),    ),]
```
Then, we define a `SubQuestionQueryEngine` over these tools:


```
from llama\_index.query\_engine import SubQuestionQueryEnginequery\_engine = SubQuestionQueryEngine.from\_defaults(    query\_engine\_tools=query\_engine\_tools)
```
This query engine can execute any number of sub-queries against any subset of query engine tools before synthesizing the final answer.This makes it especially well-suited for compare/contrast queries across documents as well as queries pertaining to a specific document.

**Guides**

* [Sub Question Query Engine (Intro)](../../examples/query_engine/sub_question_query_engine.html)
* [10Q Analysis (Uber)](../../examples/usecases/10q_sub_question.html)
* [10K Analysis (Uber and Lyft)](../../examples/usecases/10k_sub_question.html)
Multi-Step Queries[](#multi-step-queries "Permalink to this heading")
----------------------------------------------------------------------

LlamaIndex can also support iterative multi-step queries. Given a complex query, break it down into an initial subquestions,and sequentially generate subquestions based on returned answers until the final answer is returned.

For instance, given a question “Who was in the first batch of the accelerator program the author started?”,the module will first decompose the query into a simpler initial question “What was the accelerator program the author started?”,query the index, and then ask followup questions.

**Guides**

* [Query Transformations](../../optimizing/advanced_retrieval/query_transformations.html)
* [Multi-Step Query Decomposition](../../examples/query_transformations/HyDEQueryTransformDemo.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_transformations/HyDEQueryTransformDemo.ipynb))
Temporal Queries[](#temporal-queries "Permalink to this heading")
------------------------------------------------------------------

LlamaIndex can support queries that require an understanding of time. It can do this in two ways:

* Decide whether the query requires utilizing temporal relationships between nodes (prev/next relationships) in order to retrieve additional context to answer the question.
* Sort by recency and filter outdated context.

**Guides**

* [Postprocessing Guide](../../module_guides/querying/node_postprocessors/node_postprocessors.html)
* [Prev/Next Postprocessing](../../examples/node_postprocessor/PrevNextPostprocessorDemo.html)
* [Recency Postprocessing](../../examples/node_postprocessor/RecencyPostprocessorDemo.html)
Additional Resources[](#additional-resources "Permalink to this heading")
--------------------------------------------------------------------------

* [A Guide to Creating a Unified Query Framework over your indexes](q_and_a/unified_query.html)
* [A Guide to Extracting Terms and Definitions](q_and_a/terms_definitions_tutorial.html)
* [SEC 10k Analysis](https://medium.com/@jerryjliu98/how-unstructured-and-llamaindex-can-help-bring-the-power-of-llms-to-your-own-data-3657d063e30d)

