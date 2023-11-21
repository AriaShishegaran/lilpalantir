ServiceContext[](#servicecontext "Permalink to this heading")
==============================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

The `ServiceContext` is a bundle of commonly used resources used during the indexing and querying stage in a LlamaIndex pipeline/application.You can use it to set the [global configuration](#setting-global-configuration), as well as [local configurations](#setting-local-configuration) at specific parts of the pipeline.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

### Configuring the service context[](#configuring-the-service-context "Permalink to this heading")

The `ServiceContext` is a simple python dataclass that you can directly construct by passing in the desired components.


```
@dataclassclass ServiceContext:    # The LLM used to generate natural language responses to queries.    # If not provided, defaults to gpt-3.5-turbo from OpenAI    # If your OpenAI key is not set, defaults to llama2-chat-13B from Llama.cpp    llm: LLM    # The PromptHelper object that helps with truncating and repacking text chunks to fit in the LLM's context window.    prompt\_helper: PromptHelper    # The embedding model used to generate vector representations of text.    # If not provided, defaults to text-embedding-ada-002    # If your OpenAI key is not set, defaults to BAAI/bge-small-en    embed\_model: BaseEmbedding    # The parser that converts documents into nodes.    node\_parser: NodeParser    # The callback manager object that calls it's handlers on events. Provides basic logging and tracing capabilities.    callback\_manager: CallbackManager    @classmethod    def from\_defaults(cls, ...) -> "ServiceContext":      ...
```
Tip

Learn how to configure specific modules:

* [LLM](../models/llms/usage_custom.html)
* [Embedding Model](../models/embeddings.html)
* [Node Parser](../loading/node_parsers/root.html)
We also expose some common kwargs (of the above components) via the `ServiceContext.from\_defaults` methodfor convenience (so you don’t have to manually construct them).

**Kwargs for node parser**:

* `chunk\_size`: The size of the text chunk for a node . Is used for the node parser when they aren’t provided.
* `chunk\_overlap`: The amount of overlap between nodes (i.e. text chunks).

**Kwargs for prompt helper**:

* `context\_window`: The size of the context window of the LLM. Typically we set thisautomatically with the model metadata. But we also allow explicit override via this parameterfor additional control (or in case the default is not available for certain latestmodels)
* `num\_output`: The number of maximum output from the LLM. Typically we set thisautomatically given the model metadata. This parameter does not actually limit the modeloutput, it affects the amount of “space” we save for the output, when computingavailable context window size for packing text from retrieved Nodes.

Here’s a complete example that sets up all objects using their default settings:


```
from llama\_index import (    ServiceContext,    LLMPredictor,    OpenAIEmbedding,    PromptHelper,)from llama\_index.llms import OpenAIfrom llama\_index.text\_splitter import TokenTextSplitterfrom llama\_index.node\_parser import SimpleNodeParserllm = OpenAI(model="text-davinci-003", temperature=0, max\_tokens=256)embed\_model = OpenAIEmbedding()node\_parser = SimpleNodeParser.from\_defaults(    text\_splitter=TokenTextSplitter(chunk\_size=1024, chunk\_overlap=20))prompt\_helper = PromptHelper(    context\_window=4096,    num\_output=256,    chunk\_overlap\_ratio=0.1,    chunk\_size\_limit=None,)service\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embed\_model,    node\_parser=node\_parser,    prompt\_helper=prompt\_helper,)
```
### Setting global configuration[](#setting-global-configuration "Permalink to this heading")

You can set a service context as the global default that applies to the entire LlamaIndex pipeline:


```
from llama\_index import set\_global\_service\_contextset\_global\_service\_context(service\_context)
```
### Setting local configuration[](#setting-local-configuration "Permalink to this heading")

You can pass in a service context to specific part of the pipeline to override the default configuration:


```
query\_engine = index.as\_query\_engine(service\_context=service\_context)response = query\_engine.query("What did the author do growing up?")print(response)
```
