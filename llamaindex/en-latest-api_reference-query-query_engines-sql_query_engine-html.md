SQL Query Engine[](#module-llama_index.indices.struct_store.sql_query "Permalink to this heading")
===================================================================================================

Default query for SQLStructStoreIndex.

*class* llama\_index.indices.struct\_store.sql\_query.BaseSQLTableQueryEngine(*synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.BaseSQLTableQueryEngine "Permalink to this definition")get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.BaseSQLTableQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.sql_query.BaseSQLTableQueryEngine.service_context "Permalink to this definition")Get service context.

*abstract property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.sql_query.BaseSQLTableQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.BaseSQLTableQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.indices.struct\_store.sql\_query.GPTNLStructStoreQueryEngine[](#llama_index.indices.struct_store.sql_query.GPTNLStructStoreQueryEngine "Permalink to this definition")alias of [`NLStructStoreQueryEngine`](#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine "llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine")

llama\_index.indices.struct\_store.sql\_query.GPTSQLStructStoreQueryEngine[](#llama_index.indices.struct_store.sql_query.GPTSQLStructStoreQueryEngine "Permalink to this definition")alias of [`SQLStructStoreQueryEngine`](#llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine "llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine")

*class* llama\_index.indices.struct\_store.sql\_query.NLSQLTableQueryEngine(*sql\_database: [SQLDatabase](../../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *tables: Optional[Union[List[str], List[Table]]] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *context\_str\_prefix: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.NLSQLTableQueryEngine "Permalink to this definition")Natural language SQL Table query engine.

Read NLStructStoreQueryEngine’s docstring for more info on NL SQL.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.NLSQLTableQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.sql_query.NLSQLTableQueryEngine.service_context "Permalink to this definition")Get service context.

*property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.sql_query.NLSQLTableQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.NLSQLTableQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.sql\_query.NLStructStoreQueryEngine(*index: [SQLStructStoreIndex](../../indices/struct_store.html#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.sql.SQLStructStoreIndex")*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine "Permalink to this definition")GPT natural language query engine over a structured database.

NOTE: deprecated in favor of SQLTableRetriever, kept for backward compatibility.

Given a natural language query, we will extract the query to SQL.Runs raw SQL over a SQLStructStoreIndex. No LLM calls are made duringthe SQL execution.

NOTE: this query cannot work with composed indices - if the indexcontains subindices, those subindices will not be queried.

Parameters* **index** ([*SQLStructStoreIndex*](../../indices/struct_store.html#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.SQLStructStoreIndex")) – A SQL Struct Store Index
* **text\_to\_sql\_prompt** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Text to SQLBasePromptTemplate to use for the query.Defaults to DEFAULT\_TEXT\_TO\_SQL\_PROMPT.
* **context\_query\_kwargs** (*Optional**[**dict**]*) – Keyword arguments for thecontext query. Defaults to {}.
* **synthesize\_response** (*bool*) – Whether to synthesize a response from thequery results. Defaults to True.
* **response\_synthesis\_prompt** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – AResponse Synthesis BasePromptTemplate to use for the query. Defaults toDEFAULT\_RESPONSE\_SYNTHESIS\_PROMPT.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine.service_context "Permalink to this definition")Get service context.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.sql\_query.PGVectorSQLQueryEngine(*sql\_database: [SQLDatabase](../../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *tables: Optional[Union[List[str], List[Table]]] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *context\_str\_prefix: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.PGVectorSQLQueryEngine "Permalink to this definition")PGvector SQL query engine.

A modified version of the normal text-to-SQL query engine becausewe can infer embedding vectors in the sql query.

NOTE: this is a beta feature

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.PGVectorSQLQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.sql_query.PGVectorSQLQueryEngine.service_context "Permalink to this definition")Get service context.

*property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.sql_query.PGVectorSQLQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.PGVectorSQLQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.sql\_query.SQLStructStoreQueryEngine(*index: [SQLStructStoreIndex](../../indices/struct_store.html#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.sql.SQLStructStoreIndex")*, *sql\_context\_container: Optional[[SQLContextContainerBuilder](../../struct_store.html#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder "llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine "Permalink to this definition")GPT SQL query engine over a structured database.

NOTE: deprecated in favor of SQLTableRetriever, kept for backward compatibility.

Runs raw SQL over a SQLStructStoreIndex. No LLM calls are made here.NOTE: this query cannot work with composed indices - if the indexcontains subindices, those subindices will not be queried.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.sql\_query.SQLTableRetrieverQueryEngine(*sql\_database: [SQLDatabase](../../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *table\_retriever: ObjectRetriever[SQLTableSchema]*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *context\_str\_prefix: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.sql_query.SQLTableRetrieverQueryEngine "Permalink to this definition")SQL Table retriever query engine.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.sql_query.SQLTableRetrieverQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.sql_query.SQLTableRetrieverQueryEngine.service_context "Permalink to this definition")Get service context.

*property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.sql_query.SQLTableRetrieverQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.sql_query.SQLTableRetrieverQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

