Response Synthesizer[](#response-synthesizer "Permalink to this heading")
==========================================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

A `Response Synthesizer` is what generates a response from an LLM, using a user query and a given set of text chunks. The output of a response synthesizer is a `Response` object.

The method for doing this can take many forms, from as simple as iterating over text chunks, to as complex as building a tree. The main idea here is to simplify the process of generating a response using an LLM across your data.

When used in a query engine, the response synthesizer is used after nodes are retrieved from a retriever, and after any node-postprocessors are ran.

Tip

Confused about where response synthesizer fits in the pipeline? Read the [high-level concepts](../../../getting_started/concepts.html)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Use a response synthesizer on it’s own:


```
from llama\_index.schema import Nodefrom llama\_index.response\_synthesizers import (    ResponseMode,    get\_response\_synthesizer,)response\_synthesizer = get\_response\_synthesizer(    response\_mode=ResponseMode.COMPACT)response = response\_synthesizer.synthesize(    "query text", nodes=[Node(text="text"), ...])
```
Or in a query engine after you’ve created an index:


```
query\_engine = index.as\_query\_engine(response\_synthesizer=response\_synthesizer)response = query\_engine.query("query\_text")
```
You can find more details on all available response synthesizers, modes, and how to build your own below.

Usage Pattern[](#id1 "Permalink to this heading")
--------------------------------------------------

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Configuring the response synthesizer for a query engine using `response\_mode`:


```
from llama\_index.schema import Node, NodeWithScorefrom llama\_index.response\_synthesizers import get\_response\_synthesizerresponse\_synthesizer = get\_response\_synthesizer(response\_mode="compact")response = response\_synthesizer.synthesize(    "query text", nodes=[NodeWithScore(node=Node(text="text"), score=1.0), ...])
```
Or, more commonly, in a query engine after you’ve created an index:


```
query\_engine = index.as\_query\_engine(response\_synthesizer=response\_synthesizer)response = query\_engine.query("query\_text")
```
Tip

To learn how to build an index, see [Indexing](../../indexing/indexing.html)

Configuring the Response Mode[](#configuring-the-response-mode "Permalink to this heading")
--------------------------------------------------------------------------------------------

Response synthesizers are typically specified through a `response\_mode` kwarg setting.

Several response synthesizers are implemented already in LlamaIndex:

* `refine`: ***create and refine*** an answer by sequentially going through each retrieved text chunk.This makes a separate LLM call per Node/retrieved chunk.

**Details:** the first chunk is used in a query using the`text\_qa\_template` prompt. Then the answer and the next chunk (as well as the original question) are usedin another query with the `refine\_template` prompt. And so on until all chunks have been parsed.

If a chunk is too large to fit within the window (considering the prompt size), it is split using a `TokenTextSplitter`(allowing some text overlap between chunks) and the (new) additional chunks are considered as chunksof the original chunks collection (and thus queried with the `refine\_template` as well).

Good for more detailed answers.
* `compact` (default): similar to `refine` but ***compact*** (concatenate) the chunks beforehand, resulting in less LLM calls.

**Details:** stuff as many text (concatenated/packed from the retrieved chunks) that can fit within the context window(considering the maximum prompt size between `text\_qa\_template` and `refine\_template`).If the text is too long to fit in one prompt, it is split in as many parts as needed(using a `TokenTextSplitter` and thus allowing some overlap between text chunks).

Each text part is considered a “chunk” and is sent to the `refine` synthesizer.

In short, it is like `refine`, but with less LLM calls.
* `tree\_summarize`: Query the LLM using the `summary\_template` prompt as many times as needed so that all concatenated chunkshave been queried, resulting in as many answers that are themselves recursively used as chunks in a `tree\_summarize` LLM calland so on, until there’s only one chunk left, and thus only one final answer.

**Details:** concatenate the chunks as much as possible to fit within the context window using the `summary\_template` prompt,and split them if needed (again with a `TokenTextSplitter` and some text overlap). Then, query each resulting chunk/split against`summary\_template` (there is no ***refine*** query !) and get as many answers.

If there is only one answer (because there was only one chunk), then it’s the final answer.

If there are more than one answer, these themselves are considered as chunks and sent recursivelyto the `tree\_summarize` process (concatenated/splitted-to-fit/queried).

Good for summarization purposes.
* `simple\_summarize`: Truncates all text chunks to fit into a single LLM prompt. Good for quicksummarization purposes, but may lose detail due to truncation.
* `no\_text`: Only runs the retriever to fetch the nodes that would have been sent to the LLM,without actually sending them. Then can be inspected by checking `response.source\_nodes`.
* `accumulate`: Given a set of text chunks and the query, apply the query to each textchunk while accumulating the responses into an array. Returns a concatenated string of allresponses. Good for when you need to run the same query separately against each textchunk.
* `compact\_accumulate`: The same as accumulate, but will “compact” each LLM prompt similar to`compact`, and run the same query against each text chunk.
Custom Response Synthesizers[](#custom-response-synthesizers "Permalink to this heading")
------------------------------------------------------------------------------------------

Each response synthesizer inherits from `llama\_index.response\_synthesizers.base.BaseSynthesizer`. The base API is extremely simple, which makes it easy to create your own response synthesizer.

Maybe you want to customize which template is used at each step in `tree\_summarize`, or maybe a new research paper came out detailing a new way to generate a response to a query, you can create your own response synthesizer and plug it into any query engine or use it on it’s own.

Below we show the `\_\_init\_\_()` function, as well as the two abstract methods that every response synthesizer must implement. The basic requirements are to process a query and text chunks, and return a string (or string generator) response.


```
class BaseSynthesizer(ABC): """Response builder class."""    def \_\_init\_\_(        self,        service\_context: Optional[ServiceContext] = None,        streaming: bool = False,    ) -> None: """Init params."""        self.\_service\_context = (            service\_context or ServiceContext.from\_defaults()        )        self.\_callback\_manager = self.\_service\_context.callback\_manager        self.\_streaming = streaming    @abstractmethod    def get\_response(        self,        query\_str: str,        text\_chunks: Sequence[str],        \*\*response\_kwargs: Any,    ) -> RESPONSE\_TEXT\_TYPE: """Get response."""        ...    @abstractmethod    async def aget\_response(        self,        query\_str: str,        text\_chunks: Sequence[str],        \*\*response\_kwargs: Any,    ) -> RESPONSE\_TEXT\_TYPE: """Get response."""        ...
```
Using Structured Answer Filtering[](#using-structured-answer-filtering "Permalink to this heading")
----------------------------------------------------------------------------------------------------

When using either the `"refine"` or `"compact"` response synthesis modules, you may find it beneficial to experiment with the `structured\_answer\_filtering` option.


```
from llama\_index.response\_synthesizers import get\_response\_synthesizerresponse\_synthesizer = get\_response\_synthesizer(structured\_answer\_filtering=True)
```
With `structured\_answer\_filtering` set to `True`, our refine module is able to filter out any input nodes that are not relevant to the question being asked. This is particularly useful for RAG-based Q&A systems that involve retrieving chunks of text from external vector store for a given user query.

This option is particularly useful if you’re using an [OpenAI model that supports function calling](https://openai.com/blog/function-calling-and-other-api-updates). Other LLM providers or models that don’t have native function calling support may be less reliable in producing the structured response this feature relies on.

Using Custom Prompt Templates (with additional variables)[](#using-custom-prompt-templates-with-additional-variables "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------

You may want to customize the prompts used in our response synthesizer, and also add additional variables during query-time.

You can specify these additional variables in the `\*\*kwargs` for `get\_response`.

For example,


```
from llama\_index import PromptTemplatefrom llama\_index.response\_synthesizers import TreeSummarize# NOTE: we add an extra tone\_name variable hereqa\_prompt\_tmpl = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query.\n"    "Please also write the answer in the tone of {tone\_name}.\n"    "Query: {query\_str}\n"    "Answer: ")qa\_prompt = PromptTemplate(qa\_prompt\_tmpl)# initialize response synthesizersummarizer = TreeSummarize(verbose=True, summary\_template=qa\_prompt)# get responseresponse = summarizer.get\_response(    "who is Paul Graham?", [text], tone\_name="a Shakespeare play")
```
Modules[](#modules "Permalink to this heading")
------------------------------------------------

* [Response Synthesis Modules](response_synthesizers.html)
	+ [API Example](response_synthesizers.html#api-example)
	+ [Example Notebooks](response_synthesizers.html#example-notebooks)
