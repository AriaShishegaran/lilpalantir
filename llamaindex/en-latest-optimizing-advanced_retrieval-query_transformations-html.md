Query Transformations[](#query-transformations "Permalink to this heading")
============================================================================

LlamaIndex allows you to perform *query transformations* over your index structures.Query transformations are modules that will convert a query into another query. They can be **single-step**, as in the transformation is run once before the query is executed against an index.

They can also be **multi-step**, as in:

1. The query is transformed, executed against an index,
2. The response is retrieved.
3. Subsequent queries are transformed/executed in a sequential fashion.

We list some of our query transformations in more detail below.

Use Cases[](#use-cases "Permalink to this heading")
----------------------------------------------------

Query transformations have multiple use cases:

* Transforming an initial query into a form that can be more easily embedded (e.g. HyDE)
* Transforming an initial query into a subquestion that can be more easily answered from the data (single-step query decomposition)
* Breaking an initial query into multiple subquestions that can be more easily answered on their own. (multi-step query decomposition)
HyDE (Hypothetical Document Embeddings)[](#hyde-hypothetical-document-embeddings "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

[HyDE](http://boston.lti.cs.cmu.edu/luyug/HyDE/HyDE.pdf) is a technique where given a natural language query, a hypothetical document/answer is generated first. This hypothetical document is then used for embedding lookup rather than the raw query.

To use HyDE, an example code snippet is shown below.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.indices.query.query\_transform.base import HyDEQueryTransformfrom llama\_index.query\_engine.transform\_query\_engine import (    TransformQueryEngine,)# load documents, build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectorStoreIndex(documents)# run query with HyDE query transformquery\_str = "what did paul graham do after going to RISD"hyde = HyDEQueryTransform(include\_original=True)query\_engine = index.as\_query\_engine()query\_engine = TransformQueryEngine(query\_engine, query\_transform=hyde)response = query\_engine.query(query\_str)print(response)
```
Check out our [example notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_transformations/HyDEQueryTransformDemo.ipynb) for a full walkthrough.

Single-Step Query Decomposition[](#single-step-query-decomposition "Permalink to this heading")
------------------------------------------------------------------------------------------------

Some recent approaches (e.g. [self-ask](https://ofir.io/self-ask.pdf), [ReAct](https://arxiv.org/abs/2210.03629)) have suggested that LLM’sperform better at answering complex questions when they break the question into smaller steps. We have found that this is true for queries that require knowledge augmentation as well.

If your query is complex, different parts of your knowledge base may answer different “subqueries” around the overall query.

Our single-step query decomposition feature transforms a **complicated** question into a simpler one over the data collection to help provide a sub-answer to the original question.

This is especially helpful over a [composed graph](../../module_guides/indexing/composability.html). Within a composed graph, a query can be routed to multiple subindexes, each representing a subset of the overall knowledge corpus. Query decomposition allows us to transform the query into a more suitable question over any given index.

An example image is shown below.

![](../../_images/single_step_diagram.png)

Here’s a corresponding example code snippet over a composed graph.


```
# Setting: a summary index composed over multiple vector indices# llm\_predictor\_chatgpt corresponds to the ChatGPT LLM interfacefrom llama\_index.indices.query.query\_transform.base import (    DecomposeQueryTransform,)decompose\_transform = DecomposeQueryTransform(    llm\_predictor\_chatgpt, verbose=True)# initialize indexes and graph...# configure retrieversvector\_query\_engine = vector\_index.as\_query\_engine()vector\_query\_engine = TransformQueryEngine(    vector\_query\_engine,    query\_transform=decompose\_transform,    transform\_extra\_info={"index\_summary": vector\_index.index\_struct.summary},)custom\_query\_engines = {vector\_index.index\_id: vector\_query\_engine}# queryquery\_str = (    "Compare and contrast the airports in Seattle, Houston, and Toronto. ")query\_engine = graph.as\_query\_engine(custom\_query\_engines=custom\_query\_engines)response = query\_engine.query(query\_str)
```
Check out our [example notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/city_analysis/City_Analysis-Decompose.ipynb) for a full walkthrough.

Multi-Step Query Transformations[](#multi-step-query-transformations "Permalink to this heading")
--------------------------------------------------------------------------------------------------

Multi-step query transformations are a generalization on top of existing single-step query transformation approaches.

Given an initial, complex query, the query is transformed and executed against an index. The response is retrieved from the query.Given the response (along with prior responses) and the query, followup questions may be asked against the index as well. This technique allows a query to be run against a single knowledge source until that query has satisfied all questions.

An example image is shown below.

![](../../_images/multi_step_diagram.png)

Here’s a corresponding example code snippet.


```
from llama\_index.indices.query.query\_transform.base import (    StepDecomposeQueryTransform,)# gpt-4step\_decompose\_transform = StepDecomposeQueryTransform(    llm\_predictor, verbose=True)query\_engine = index.as\_query\_engine()query\_engine = MultiStepQueryEngine(    query\_engine, query\_transform=step\_decompose\_transform)response = query\_engine.query(    "Who was in the first batch of the accelerator program the author started?",)print(str(response))
```
Check out our [example notebook](https://github.com/jerryjliu/llama_index/blob/main/examples/vector_indices/SimpleIndexDemo-multistep.ipynb) for a full walkthrough.

Examples

* [HyDE Query Transform](../../examples/query_transformations/HyDEQueryTransformDemo.html)
* [Multi-Step Query Engine](../../examples/query_transformations/SimpleIndexDemo-multistep.html)
