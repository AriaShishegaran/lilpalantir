Response Synthesis Modules[](#response-synthesis-modules "Permalink to this heading")
======================================================================================

Detailed inputs/outputs for each response synthesizer are found below.

API Example[](#api-example "Permalink to this heading")
--------------------------------------------------------

The following shows the setup for utilizing all kwargs.

* `response\_mode` specifies which response synthesizer to use
* `service\_context` defines the LLM and related settings for synthesis
* `text\_qa\_template` and `refine\_template` are the prompts used at various stages
* `use\_async` is used for only the `tree\_summarize` response mode right now, to asynchronously build the summary tree
* `streaming` configures whether to return a streaming response object or not
* `structured\_answer\_filtering` enables the active filtering of text chunks that are not relevant to a given question

In the `synthesize`/`asyntheszie` functions, you can optionally provide additional source nodes, which will be added to the `response.source\_nodes` list.


```
from llama\_index.schema import Node, NodeWithScorefrom llama\_index import get\_response\_synthesizerresponse\_synthesizer = get\_response\_synthesizer(    response\_mode="refine",    service\_context=service\_context,    text\_qa\_template=text\_qa\_template,    refine\_template=refine\_template,    use\_async=False,    streaming=False,)# synchronousresponse = response\_synthesizer.synthesize(    "query string",    nodes=[NodeWithScore(node=Node(text="text"), score=1.0), ...],    additional\_source\_nodes=[        NodeWithScore(node=Node(text="text"), score=1.0),        ...,    ],)# asynchronousresponse = await response\_synthesizer.asynthesize(    "query string",    nodes=[NodeWithScore(node=Node(text="text"), score=1.0), ...],    additional\_source\_nodes=[        NodeWithScore(node=Node(text="text"), score=1.0),        ...,    ],)
```
You can also directly return a string, using the lower-level `get\_response` and `aget\_response` functions


```
response\_str = response\_synthesizer.get\_response(    "query string", text\_chunks=["text1", "text2", ...])
```
Example Notebooks[](#example-notebooks "Permalink to this heading")
--------------------------------------------------------------------

* [Refine](../../../examples/response_synthesizers/refine.html)
* [Refine with Structured Answer Filtering](../../../examples/response_synthesizers/structured_refine.html)
* [Tree Summarize](../../../examples/response_synthesizers/tree_summarize.html)
* [Pydantic Tree Summarize](../../../examples/response_synthesizers/custom_prompt_synthesizer.html)
