Multistep Query Engine[](#module-llama_index.query_engine.multistep_query_engine "Permalink to this heading")
==============================================================================================================

*class* llama\_index.query\_engine.multistep\_query\_engine.MultiStepQueryEngine(*query\_engine: BaseQueryEngine*, *query\_transform: [StepDecomposeQueryTransform](../query_transform.html#llama_index.indices.query.query_transform.StepDecomposeQueryTransform "llama_index.indices.query.query_transform.base.StepDecomposeQueryTransform")*, *response\_synthesizer: Optional[[BaseSynthesizer](../response_synthesizer.html#llama_index.response_synthesizers.BaseSynthesizer "llama_index.response_synthesizers.base.BaseSynthesizer")] = None*, *num\_steps: Optional[int] = 3*, *early\_stopping: bool = True*, *index\_summary: str = 'None'*, *stop\_fn: Optional[Callable[[Dict], bool]] = None*)[](#llama_index.query_engine.multistep_query_engine.MultiStepQueryEngine "Permalink to this definition")Multi-step query engine.

This query engine can operate over an existing base query engine,along with the multi-step query transform.

Parameters* **query\_engine** (*BaseQueryEngine*) – A BaseQueryEngine object.
* **query\_transform** ([*StepDecomposeQueryTransform*](../query_transform.html#llama_index.indices.query.query_transform.StepDecomposeQueryTransform "llama_index.indices.query.query_transform.StepDecomposeQueryTransform")) – A StepDecomposeQueryTransformobject.
* **response\_synthesizer** (*Optional**[*[*BaseSynthesizer*](../response_synthesizer.html#llama_index.response_synthesizers.BaseSynthesizer "llama_index.response_synthesizers.BaseSynthesizer")*]*) – A BaseSynthesizerobject.
* **num\_steps** (*Optional**[**int**]*) – Number of steps to run the multi-step query.
* **early\_stopping** (*bool*) – Whether to stop early if the stop function returns True.
* **index\_summary** (*str*) – A string summary of the index.
* **stop\_fn** (*Optional**[**Callable**[**[**Dict**]**,* *bool**]**]*) – A stop function that takes in adictionary of information and returns a boolean.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.multistep_query_engine.MultiStepQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.multistep_query_engine.MultiStepQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.query\_engine.multistep\_query\_engine.default\_stop\_fn(*stop\_dict: Dict*) → bool[](#llama_index.query_engine.multistep_query_engine.default_stop_fn "Permalink to this definition")Stop function for multi-step query combiner.

