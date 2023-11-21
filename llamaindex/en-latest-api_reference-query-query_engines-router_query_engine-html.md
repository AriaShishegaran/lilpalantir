Router Query Engine[](#module-llama_index.query_engine.router_query_engine "Permalink to this heading")
========================================================================================================

*class* llama\_index.query\_engine.router\_query\_engine.RetrieverRouterQueryEngine(*retriever: [BaseRetriever](../retrievers.html#llama_index.indices.base_retriever.BaseRetriever "llama_index.indices.base_retriever.BaseRetriever")*, *node\_to\_query\_engine\_fn: Callable*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*)[](#llama_index.query_engine.router_query_engine.RetrieverRouterQueryEngine "Permalink to this definition")Retriever-based router query engine.

NOTE: this is deprecated, please use our new ToolRetrieverRouterQueryEngine

Use a retriever to select a set of Nodes. Each node will be convertedinto a ToolMetadata object, and also used to retrieve a query engine, to forma QueryEngineTool.

NOTE: this is a beta feature. We are figuring out the right interfacebetween the retriever and query engine.

Parameters* **selector** (*BaseSelector*) – A selector that chooses one out of many options basedon each candidate’s metadata and query.
* **query\_engine\_tools** (*Sequence**[**QueryEngineTool**]*) – A sequence of candidatequery engines. They must be wrapped as tools to expose metadata tothe selector.
* **callback\_manager** (*Optional**[*[*CallbackManager*](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")*]*) – A callback manager.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.router_query_engine.RetrieverRouterQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.router_query_engine.RetrieverRouterQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.query\_engine.router\_query\_engine.RouterQueryEngine(*selector: BaseSelector*, *query\_engine\_tools: Sequence[QueryEngineTool]*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *summarizer: Optional[[TreeSummarize](../response_synthesizer.html#llama_index.response_synthesizers.TreeSummarize "llama_index.response_synthesizers.tree_summarize.TreeSummarize")] = None*)[](#llama_index.query_engine.router_query_engine.RouterQueryEngine "Permalink to this definition")Router query engine.

Selects one out of several candidate query engines to execute a query.

Parameters* **selector** (*BaseSelector*) – A selector that chooses one out of many options basedon each candidate’s metadata and query.
* **query\_engine\_tools** (*Sequence**[**QueryEngineTool**]*) – A sequence of candidatequery engines. They must be wrapped as tools to expose metadata tothe selector.
* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context.
* **summarizer** (*Optional**[*[*TreeSummarize*](../response_synthesizer.html#llama_index.response_synthesizers.TreeSummarize "llama_index.response_synthesizers.TreeSummarize")*]*) – Tree summarizer to summarize sub-results.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.router_query_engine.RouterQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.router_query_engine.RouterQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.query\_engine.router\_query\_engine.ToolRetrieverRouterQueryEngine(*retriever: ObjectRetriever[QueryEngineTool]*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *summarizer: Optional[[TreeSummarize](../response_synthesizer.html#llama_index.response_synthesizers.TreeSummarize "llama_index.response_synthesizers.tree_summarize.TreeSummarize")] = None*)[](#llama_index.query_engine.router_query_engine.ToolRetrieverRouterQueryEngine "Permalink to this definition")Tool Retriever router query engine.

Selects a set of candidate query engines to execute a query.

Parameters* **retriever** (*ObjectRetriever*) – A retriever that retrieves a set ofquery engine tools.
* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context.
* **summarizer** (*Optional**[*[*TreeSummarize*](../response_synthesizer.html#llama_index.response_synthesizers.TreeSummarize "llama_index.response_synthesizers.TreeSummarize")*]*) – Tree summarizer to summarize sub-results.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.router_query_engine.ToolRetrieverRouterQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.router_query_engine.ToolRetrieverRouterQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

