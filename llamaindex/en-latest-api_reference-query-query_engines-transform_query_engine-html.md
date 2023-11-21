Transform Query Engine[](#module-llama_index.query_engine.transform_query_engine "Permalink to this heading")
==============================================================================================================

*class* llama\_index.query\_engine.transform\_query\_engine.TransformQueryEngine(*query\_engine: BaseQueryEngine*, *query\_transform: BaseQueryTransform*, *transform\_metadata: Optional[dict] = None*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*)[](#llama_index.query_engine.transform_query_engine.TransformQueryEngine "Permalink to this definition")Transform query engine.

Applies a query transform to a query bundle before passingit to a query engine.

Parameters* **query\_engine** (*BaseQueryEngine*) – A query engine object.
* **query\_transform** (*BaseQueryTransform*) – A query transform object.
* **transform\_metadata** (*Optional**[**dict**]*) – metadata to pass to thequery transform.
* **callback\_manager** (*Optional**[*[*CallbackManager*](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")*]*) – A callback manager.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.transform_query_engine.TransformQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.transform_query_engine.TransformQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

