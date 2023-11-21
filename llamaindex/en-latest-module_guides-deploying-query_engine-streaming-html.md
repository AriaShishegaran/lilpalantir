Streaming[](#streaming "Permalink to this heading")
====================================================

LlamaIndex supports streaming the response as it’s being generated.This allows you to start printing or processing the beginning of the response before the full response is finished.This can drastically reduce the perceived latency of queries.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

To enable streaming, you need to use an LLM that supports streaming.Right now, streaming is supported by `OpenAI`, `HuggingFaceLLM`, and most LangChain LLMs (via `LangChainLLM`).

Configure query engine to use streaming:

If you are using the high-level API, set `streaming=True` when building a query engine.


```
query\_engine = index.as\_query\_engine(streaming=True, similarity\_top\_k=1)
```
If you are using the low-level API to compose the query engine,pass `streaming=True` when constructing the `Response Synthesizer`:


```
from llama\_index import get\_response\_synthesizersynth = get\_response\_synthesizer(streaming=True, ...)query\_engine = RetrieverQueryEngine(response\_synthesizer=synth, ...)
```
Streaming Response[](#streaming-response "Permalink to this heading")
----------------------------------------------------------------------

After properly configuring both the LLM and the query engine,calling `query` now returns a `StreamingResponse` object.


```
streaming\_response = query\_engine.query(    "What did the author do growing up?",)
```
The response is returned immediately when the LLM call *starts*, without having to wait for the full completion.


> Note: In the case where the query engine makes multiple LLM calls, only the last LLM call will be streamed and the response is returned when the last LLM call starts.
> 
> 

You can obtain a `Generator` from the streaming response and iterate over the tokens as they arrive:


```
for text in streaming\_response.response\_gen:    # do something with text as they arrive.    pass
```
Alternatively, if you just want to print the text as they arrive:


```
streaming\_response.print\_response\_stream()
```
See an [end-to-end example](../../../examples/customization/streaming/SimpleIndexDemo-streaming.html)

