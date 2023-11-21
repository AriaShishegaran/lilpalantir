SQL Join Query Engine[](#module-llama_index.query_engine.sql_join_query_engine "Permalink to this heading")
============================================================================================================

SQL Join query engine.

*class* llama\_index.query\_engine.sql\_join\_query\_engine.SQLAugmentQueryTransform(*llm\_predictor: Optional[BaseLLMPredictor] = None*, *sql\_augment\_transform\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *check\_stop\_parser: Optional[Callable[[[QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")], bool]] = None*)[](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform "Permalink to this definition")SQL Augment Query Transform.

This query transform will transform the query into a more specific queryafter augmenting with SQL results.

Parameters* **llm\_predictor** ([*LLMPredictor*](../../llm_predictor.html#llama_index.llm_predictor.LLMPredictor "llama_index.llm_predictor.LLMPredictor")) – LLM predictor to use for query transformation.
* **sql\_augment\_transform\_prompt** ([*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – PromptTemplate to usefor query transformation.
* **check\_stop\_parser** (*Optional**[**Callable**[**[**str**]**,* *bool**]**]*) – Check stop function.
check\_stop(*query\_bundle: [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")*) → bool[](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform.check_stop "Permalink to this definition")Check if query indicates stop.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform.get_prompts "Permalink to this definition")Get a prompt.

run(*query\_bundle\_or\_str: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *metadata: Optional[Dict] = None*) → [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")[](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform.run "Permalink to this definition")Run query transform.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.query\_engine.sql\_join\_query\_engine.SQLJoinQueryEngine(*sql\_query\_tool: QueryEngineTool*, *other\_query\_tool: QueryEngineTool*, *selector: Optional[Union[LLMSingleSelector, PydanticSingleSelector]] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *sql\_join\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *sql\_augment\_query\_transform: Optional[[SQLAugmentQueryTransform](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform "llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform")] = None*, *use\_sql\_join\_synthesis: bool = True*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *verbose: bool = True*)[](#llama_index.query_engine.sql_join_query_engine.SQLJoinQueryEngine "Permalink to this definition")SQL Join Query Engine.

This query engine can “Join” a SQL database resultswith another query engine.It can decide it needs to query the SQL database or the other query engine.If it decides to query the SQL database, it will first query the SQL database,whether to augment information with retrieved results from the other query engine.

Parameters* **sql\_query\_tool** (*QueryEngineTool*) – Query engine tool for SQL database.other\_query\_tool (QueryEngineTool): Other query engine tool.
* **selector** (*Optional**[**Union**[**LLMSingleSelector**,* *PydanticSingleSelector**]**]*) – Selector to use.
* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – Service context to use.
* **sql\_join\_synthesis\_prompt** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – PromptTemplate to use for SQL join synthesis.
* **sql\_augment\_query\_transform** (*Optional**[*[*SQLAugmentQueryTransform*](#llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform "llama_index.query_engine.sql_join_query_engine.SQLAugmentQueryTransform")*]*) – Querytransform to use for SQL augmentation.
* **use\_sql\_join\_synthesis** (*bool*) – Whether to use SQL join synthesis.
* **callback\_manager** (*Optional**[*[*CallbackManager*](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")*]*) – Callback manager to use.
* **verbose** (*bool*) – Whether to print intermediate results.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.sql_join_query_engine.SQLJoinQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.sql_join_query_engine.SQLJoinQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

