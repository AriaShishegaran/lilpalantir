Query Engines + Pydantic Outputs[](#query-engines-pydantic-outputs "Permalink to this heading")
================================================================================================

Using `index.as\_query\_engine()` and it’s underlying `RetrieverQueryEngine`, we can support structured pydantic outputs without an additional LLM calls (in contrast to a typical output parser.)

Every query engine has support for integrated structured responses using the following `response\_mode`s in `RetrieverQueryEngine`:

* `refine`
* `compact`
* `tree\_summarize`
* `accumulate` (beta, requires extra parsing to convert to objects)
* `compact\_accumulate` (beta, requires extra parsing to convert to objects)

Under the hood, this uses `OpenAIPydanitcProgam` or `LLMTextCompletionProgram` depending on which LLM you’ve setup. If there are intermediate LLM responses (i.e. during `refine` or `tree\_summarize` with multiple LLM calls), the pydantic object is injected into the next LLM prompt as a JSON object.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

First, you need to define the object you want to extract.


```
from typing import Listfrom pydantic import BaseModelclass Biography(BaseModel): """Data model for a biography."""    name: str    best\_known\_for: List[str]    extra\_info: str
```
Then, you create your query engine.


```
query\_engine = index.as\_query\_engine(    response\_mode="tree\_summarize", output\_cls=Biography)
```
Lastly, you can get a response and inspect the output.


```
response = query\_engine.query("Who is Paul Graham?")print(response.name)# > 'Paul Graham'print(response.best\_known\_for)# > ['working on Bel', 'co-founding Viaweb', 'creating the programming language Arc']print(response.extra\_info)# > "Paul Graham is a computer scientist, entrepreneur, and writer. He is best known for ..."
```
Modules[](#modules "Permalink to this heading")
------------------------------------------------

Detailed usage is available in the notebooks below:

* [Query Engine with Pydantic Outputs](../../../examples/query_engine/pydantic_query_engine.html)
	+ [Setup](../../../examples/query_engine/pydantic_query_engine.html#setup)
	+ [Create the Index + Query Engine (OpenAI)](../../../examples/query_engine/pydantic_query_engine.html#create-the-index-query-engine-openai)
	+ [Create the Index + Query Engine (Non-OpenAI, Beta)](../../../examples/query_engine/pydantic_query_engine.html#create-the-index-query-engine-non-openai-beta)
	+ [Accumulate Examples (Beta)](../../../examples/query_engine/pydantic_query_engine.html#accumulate-examples-beta)
* [Pydantic Tree Summarize](../../../examples/response_synthesizers/pydantic_tree_summarize.html)
* [Download Data](../../../examples/response_synthesizers/pydantic_tree_summarize.html#download-data)
	+ [Load Data](../../../examples/response_synthesizers/pydantic_tree_summarize.html#load-data)
	+ [Summarize](../../../examples/response_synthesizers/pydantic_tree_summarize.html#summarize)
