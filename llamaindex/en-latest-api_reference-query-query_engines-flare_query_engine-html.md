Flare Query Engine[](#module-llama_index.query_engine.flare.base "Permalink to this heading")
==============================================================================================

Query engines based on the FLARE paper.

Active Retrieval Augmented Generation.

*class* llama\_index.query\_engine.flare.base.FLAREInstructQueryEngine(*query\_engine: BaseQueryEngine*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *instruct\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *lookahead\_answer\_inserter: Optional[BaseLookaheadAnswerInserter] = None*, *done\_output\_parser: Optional[IsDoneOutputParser] = None*, *query\_task\_output\_parser: Optional[QueryTaskOutputParser] = None*, *max\_iterations: int = 10*, *max\_lookahead\_query\_tasks: int = 1*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *verbose: bool = False*)[](#llama_index.query_engine.flare.base.FLAREInstructQueryEngine "Permalink to this definition")FLARE Instruct query engine.

This is the version of FLARE that uses retrieval-encouraging instructions.

NOTE: this is a beta feature. Interfaces might change, and it might notalways give correct answers.

Parameters* **query\_engine** (*BaseQueryEngine*) – query engine to use
* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – service context.Defaults to None.
* **instruct\_prompt** (*Optional**[*[*PromptTemplate*](../../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")*]*) – instruct prompt. Defaults to None.
* **lookahead\_answer\_inserter** (*Optional**[**BaseLookaheadAnswerInserter**]*) – lookahead answer inserter. Defaults to None.
* **done\_output\_parser** (*Optional**[**IsDoneOutputParser**]*) – done output parser.Defaults to None.
* **query\_task\_output\_parser** (*Optional**[**QueryTaskOutputParser**]*) – query task output parser. Defaults to None.
* **max\_iterations** (*int*) – max iterations. Defaults to 10.
* **max\_lookahead\_query\_tasks** (*int*) – max lookahead query tasks. Defaults to 1.
* **callback\_manager** (*Optional**[*[*CallbackManager*](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")*]*) – callback manager.Defaults to None.
* **verbose** (*bool*) – give verbose outputs. Defaults to False.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.flare.base.FLAREInstructQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.flare.base.FLAREInstructQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

