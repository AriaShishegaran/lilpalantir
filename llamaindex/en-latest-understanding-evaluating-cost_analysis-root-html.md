Cost Analysis[](#cost-analysis "Permalink to this heading")
============================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Each call to an LLM will cost some amount of money - for instance, OpenAI’s gpt-3.5-turbo costs $0.002 / 1k tokens. The cost of building an index and querying depends on

* the type of LLM used
* the type of data structure used
* parameters used during building
* parameters used during querying

The cost of building and querying each index is a TODO in the reference documentation. In the meantime, we provide the following information:

1. A high-level overview of the cost structure of the indices.
2. A token predictor that you can use directly within LlamaIndex!

### Overview of Cost Structure[](#overview-of-cost-structure "Permalink to this heading")

#### Indices with no LLM calls[](#indices-with-no-llm-calls "Permalink to this heading")

The following indices don’t require LLM calls at all during building (0 cost):

* `SummaryIndex`
* `SimpleKeywordTableIndex` - uses a regex keyword extractor to extract keywords from each document
* `RAKEKeywordTableIndex` - uses a RAKE keyword extractor to extract keywords from each document
#### Indices with LLM calls[](#indices-with-llm-calls "Permalink to this heading")

The following indices do require LLM calls during build time:

* `TreeIndex` - use LLM to hierarchically summarize the text to build the tree
* `KeywordTableIndex` - use LLM to extract keywords from each document
### Query Time[](#query-time "Permalink to this heading")

There will always be >= 1 LLM call during query time, in order to synthesize the final answer.Some indices contain cost tradeoffs between index building and querying. `SummaryIndex`, for instance,is free to build, but running a query over a summary index (without filtering or embedding lookups), willcall the LLM \(N\) times.

Here are some notes regarding each of the indices:

* `SummaryIndex`: by default requires \(N\) LLM calls, where N is the number of nodes.
* `TreeIndex`: by default requires \(\log (N)\) LLM calls, where N is the number of leaf nodes.


	+ Setting `child\_branch\_factor=2` will be more expensive than the default `child\_branch\_factor=1` (polynomial vs logarithmic), because we traverse 2 children instead of just 1 for each parent node.
* `KeywordTableIndex`: by default requires an LLM call to extract query keywords.


	+ Can do `index.as\_retriever(retriever\_mode="simple")` or `index.as\_retriever(retriever\_mode="rake")` to also use regex/RAKE keyword extractors on your query text.
* `VectorStoreIndex`: by default, requires one LLM call per query. If you increase the `similarity\_top\_k` or `chunk\_size`, or change the `response\_mode`, then this number will increase.
Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

LlamaIndex offers token **predictors** to predict token usage of LLM and embedding calls.This allows you to estimate your costs during 1) index construction, and 2) index querying, beforeany respective LLM calls are made.

Tokens are counted using the `TokenCountingHandler` callback. See the [example notebook](../../../examples/callbacks/TokenCountingHandler.html) for details on the setup.

### Using MockLLM[](#using-mockllm "Permalink to this heading")

To predict token usage of LLM calls, import and instantiate the MockLLM as shown below. The `max\_tokens` parameter is used as a “worst case” prediction, where each LLM response will contain exactly that number of tokens. If `max\_tokens` is not specified, then it will simply predict back the prompt.


```
from llama\_index import ServiceContext, set\_global\_service\_contextfrom llama\_index.llms import MockLLMllm = MockLLM(max\_tokens=256)service\_context = ServiceContext.from\_defaults(llm=llm)# optionally set a global service contextset\_global\_service\_context(service\_context)
```
You can then use this predictor during both index construction and querying.

### Using MockEmbedding[](#using-mockembedding "Permalink to this heading")

You may also predict the token usage of embedding calls with `MockEmbedding`.


```
from llama\_index import ServiceContext, set\_global\_service\_contextfrom llama\_index import MockEmbedding# specify a MockLLMPredictorembed\_model = MockEmbedding(embed\_dim=1536)service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)# optionally set a global service contextset\_global\_service\_context(service\_context)
```
Usage Pattern[](#id1 "Permalink to this heading")
--------------------------------------------------

Read about the full usage pattern below!

Examples

* [Usage Pattern](usage_pattern.html)
