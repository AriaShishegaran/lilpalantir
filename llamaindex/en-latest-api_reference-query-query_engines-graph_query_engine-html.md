Graph Query Engine[](#module-llama_index.query_engine.graph_query_engine "Permalink to this heading")
======================================================================================================

*class* llama\_index.query\_engine.graph\_query\_engine.ComposableGraphQueryEngine(*graph: [ComposableGraph](../../composability.html#llama_index.composability.ComposableGraph "llama_index.indices.composability.graph.ComposableGraph")*, *custom\_query\_engines: Optional[Dict[str, BaseQueryEngine]] = None*, *recursive: bool = True*, *\*\*kwargs: Any*)[](#llama_index.query_engine.graph_query_engine.ComposableGraphQueryEngine "Permalink to this definition")Composable graph query engine.

This query engine can operate over a ComposableGraph.It can take in custom query engines for its sub-indices.

Parameters* **graph** ([*ComposableGraph*](../../composability.html#llama_index.composability.ComposableGraph "llama_index.composability.ComposableGraph")) – A ComposableGraph object.
* **custom\_query\_engines** (*Optional**[**Dict**[**str**,* *BaseQueryEngine**]**]*) – A dictionary ofcustom query engines.
* **recursive** (*bool*) – Whether to recursively query the graph.
* **\*\*kwargs** – additional arguments to be passed to the underlying index queryengine.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.graph_query_engine.ComposableGraphQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.graph_query_engine.ComposableGraphQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

