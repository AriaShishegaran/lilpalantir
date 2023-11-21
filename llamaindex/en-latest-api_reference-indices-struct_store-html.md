Structured Store Index[](#module-llama_index.indices.struct_store "Permalink to this heading")
===============================================================================================

Structured store indices.

llama\_index.indices.struct\_store.GPTNLStructStoreQueryEngine[](#llama_index.indices.struct_store.GPTNLStructStoreQueryEngine "Permalink to this definition")alias of [`NLStructStoreQueryEngine`](../query/query_engines/sql_query_engine.html#llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine "llama_index.indices.struct_store.sql_query.NLStructStoreQueryEngine")

llama\_index.indices.struct\_store.GPTPandasIndex[](#llama_index.indices.struct_store.GPTPandasIndex "Permalink to this definition")alias of [`PandasIndex`](#llama_index.indices.struct_store.PandasIndex "llama_index.indices.struct_store.pandas.PandasIndex")

llama\_index.indices.struct\_store.GPTSQLStructStoreIndex[](#llama_index.indices.struct_store.GPTSQLStructStoreIndex "Permalink to this definition")alias of [`SQLStructStoreIndex`](#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.sql.SQLStructStoreIndex")

llama\_index.indices.struct\_store.GPTSQLStructStoreQueryEngine[](#llama_index.indices.struct_store.GPTSQLStructStoreQueryEngine "Permalink to this definition")alias of [`SQLStructStoreQueryEngine`](../query/query_engines/sql_query_engine.html#llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine "llama_index.indices.struct_store.sql_query.SQLStructStoreQueryEngine")

*class* llama\_index.indices.struct\_store.JSONQueryEngine(*json\_value: Optional[Union[Dict[str, Optional[Union[Dict[str, JSONType], List[JSONType], str, int, float, bool]]], List[Optional[Union[Dict[str, JSONType], List[JSONType], str, int, float, bool]]], str, int, float, bool]]*, *json\_schema: Optional[Union[Dict[str, Optional[Union[Dict[str, JSONType], List[JSONType], str, int, float, bool]]], List[Optional[Union[Dict[str, JSONType], List[JSONType], str, int, float, bool]]], str, int, float, bool]]*, *service\_context: [ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*, *json\_path\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *output\_processor: Optional[Callable] = None*, *output\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.JSONQueryEngine "Permalink to this definition")GPT JSON Query Engine.

Converts natural language to JSON Path queries.

Parameters* **json\_value** (*JSONType*) – JSON value
* **json\_schema** (*JSONType*) – JSON schema
* **service\_context** ([*ServiceContext*](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")) – ServiceContext
* **json\_path\_prompt** ([*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – The JSON Path prompt to use.
* **output\_processor** (*Callable*) – The output processor that executes theJSON Path query.
* **output\_kwargs** (*dict*) – Additional output processor kwargs for theoutput\_processor function.
* **verbose** (*bool*) – Whether to print verbose output.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.JSONQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.JSONQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.NLSQLTableQueryEngine(*sql\_database: [SQLDatabase](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *tables: Optional[Union[List[str], List[Table]]] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *context\_str\_prefix: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.NLSQLTableQueryEngine "Permalink to this definition")Natural language SQL Table query engine.

Read NLStructStoreQueryEngine’s docstring for more info on NL SQL.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.NLSQLTableQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.NLSQLTableQueryEngine.service_context "Permalink to this definition")Get service context.

*property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.NLSQLTableQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.NLSQLTableQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.NLStructStoreQueryEngine(*index: [SQLStructStoreIndex](#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.sql.SQLStructStoreIndex")*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.NLStructStoreQueryEngine "Permalink to this definition")GPT natural language query engine over a structured database.

NOTE: deprecated in favor of SQLTableRetriever, kept for backward compatibility.

Given a natural language query, we will extract the query to SQL.Runs raw SQL over a SQLStructStoreIndex. No LLM calls are made duringthe SQL execution.

NOTE: this query cannot work with composed indices - if the indexcontains subindices, those subindices will not be queried.

Parameters* **index** ([*SQLStructStoreIndex*](#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.SQLStructStoreIndex")) – A SQL Struct Store Index
* **text\_to\_sql\_prompt** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Text to SQLBasePromptTemplate to use for the query.Defaults to DEFAULT\_TEXT\_TO\_SQL\_PROMPT.
* **context\_query\_kwargs** (*Optional**[**dict**]*) – Keyword arguments for thecontext query. Defaults to {}.
* **synthesize\_response** (*bool*) – Whether to synthesize a response from thequery results. Defaults to True.
* **response\_synthesis\_prompt** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – AResponse Synthesis BasePromptTemplate to use for the query. Defaults toDEFAULT\_RESPONSE\_SYNTHESIS\_PROMPT.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.NLStructStoreQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.NLStructStoreQueryEngine.service_context "Permalink to this definition")Get service context.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.NLStructStoreQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.PandasIndex(*df: DataFrame*, *nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[PandasStructTable] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.PandasIndex "Permalink to this definition")Pandas Index.

Deprecated. Please use `PandasQueryEngine` instead.

The PandasIndex is an index that storesa Pandas dataframe under the hood.Currently index “construction” is not supported.

During query time, the user can either specify a raw SQL queryor a natural language query to retrieve their data.

Parameters**pandas\_df** (*Optional**[**pd.DataFrame**]*) – Pandas dataframe to use.See [Structured Index Configuration](../struct_store.html#ref-struct-store) for more details.

build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.struct_store.PandasIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.struct_store.PandasIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.struct_store.PandasIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.struct_store.PandasIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.struct_store.PandasIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.struct_store.PandasIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.struct_store.PandasIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.struct_store.PandasIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.struct\_store.SQLContextContainerBuilder(*sql\_database: [SQLDatabase](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *context\_dict: Optional[Dict[str, str]] = None*, *context\_str: Optional[str] = None*)[](#llama_index.indices.struct_store.SQLContextContainerBuilder "Permalink to this definition")SQLContextContainerBuilder.

Build a SQLContextContainer that can be passed to the SQL indexduring index construction or during query-time.

NOTE: if context\_str is specified, that will be used as contextinstead of context\_dict

Parameters* **sql\_database** ([*SQLDatabase*](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")) – SQL database
* **context\_dict** (*Optional**[**Dict**[**str**,* *str**]**]*) – context dict
build\_context\_container(*ignore\_db\_schema: bool = False*) → SQLContextContainer[](#llama_index.indices.struct_store.SQLContextContainerBuilder.build_context_container "Permalink to this definition")Build index structure.

derive\_index\_from\_context(*index\_cls: Type[[BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*, *ignore\_db\_schema: bool = False*, *\*\*index\_kwargs: Any*) → [BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")[](#llama_index.indices.struct_store.SQLContextContainerBuilder.derive_index_from_context "Permalink to this definition")Derive index from context.

*classmethod* from\_documents(*documents\_dict: Dict[str, List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]]*, *sql\_database: [SQLDatabase](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *\*\*context\_builder\_kwargs: Any*) → [SQLContextContainerBuilder](../struct_store.html#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder "llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder")[](#llama_index.indices.struct_store.SQLContextContainerBuilder.from_documents "Permalink to this definition")Build context from documents.

query\_index\_for\_context(*index: [BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*, *query\_str: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *query\_tmpl: Optional[str] = 'Please return the relevant tables (including the full schema) for the following query: {orig\_query\_str}'*, *store\_context\_str: bool = True*, *\*\*index\_kwargs: Any*) → str[](#llama_index.indices.struct_store.SQLContextContainerBuilder.query_index_for_context "Permalink to this definition")Query index for context.

A simple wrapper around the index.query call whichinjects a query template to specifically fetch table information,and can store a context\_str.

Parameters* **index** ([*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")) – index data structure
* **query\_str** (*QueryType*) – query string
* **query\_tmpl** (*Optional**[**str**]*) – query template
* **store\_context\_str** (*bool*) – store context\_str
*class* llama\_index.indices.struct\_store.SQLStructStoreIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[SQLStructTable] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *sql\_database: Optional[[SQLDatabase](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")] = None*, *table\_name: Optional[str] = None*, *table: Optional[Table] = None*, *ref\_doc\_id\_column: Optional[str] = None*, *sql\_context\_container: Optional[SQLContextContainer] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.SQLStructStoreIndex "Permalink to this definition")SQL Struct Store Index.

The SQLStructStoreIndex is an index that uses a SQL databaseunder the hood. During index construction, the data can be inferredfrom unstructured documents given a schema extract prompt,or it can be pre-loaded in the database.

During query time, the user can either specify a raw SQL queryor a natural language query to retrieve their data.

NOTE: this is deprecated.

Parameters* **documents** (*Optional**[**Sequence**[**DOCUMENTS\_INPUT**]**]*) – Documents to index.NOTE: in the SQL index, this is an optional field.
* **sql\_database** (*Optional**[*[*SQLDatabase*](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*]*) – SQL database to use,including table names to specify.See [Structured Index Configuration](../struct_store.html#ref-struct-store) for more details.
* **table\_name** (*Optional**[**str**]*) – Name of the table to usefor extracting data.Either table\_name or table must be specified.
* **table** (*Optional**[**Table**]*) – SQLAlchemy Table object to use.Specifying the Table object explicitly, instead ofthe table name, allows you to pass in a view.Either table\_name or table must be specified.
* **sql\_context\_container** (*Optional**[**SQLContextContainer**]*) – SQL context container.an be generated from a SQLContextContainerBuilder.See [Structured Index Configuration](../struct_store.html#ref-struct-store) for more details.
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.struct_store.SQLStructStoreIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.struct_store.SQLStructStoreIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.struct_store.SQLStructStoreIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.struct_store.SQLStructStoreIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.struct_store.SQLStructStoreIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.struct_store.SQLStructStoreIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.struct_store.SQLStructStoreIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.struct\_store.SQLStructStoreQueryEngine(*index: [SQLStructStoreIndex](#llama_index.indices.struct_store.SQLStructStoreIndex "llama_index.indices.struct_store.sql.SQLStructStoreIndex")*, *sql\_context\_container: Optional[[SQLContextContainerBuilder](../struct_store.html#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder "llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.SQLStructStoreQueryEngine "Permalink to this definition")GPT SQL query engine over a structured database.

NOTE: deprecated in favor of SQLTableRetriever, kept for backward compatibility.

Runs raw SQL over a SQLStructStoreIndex. No LLM calls are made here.NOTE: this query cannot work with composed indices - if the indexcontains subindices, those subindices will not be queried.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.SQLStructStoreQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.SQLStructStoreQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.struct\_store.SQLTableRetrieverQueryEngine(*sql\_database: [SQLDatabase](../struct_store.html#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *table\_retriever: ObjectRetriever[SQLTableSchema]*, *text\_to\_sql\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *context\_query\_kwargs: Optional[dict] = None*, *synthesize\_response: bool = True*, *response\_synthesis\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *context\_str\_prefix: Optional[str] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.struct_store.SQLTableRetrieverQueryEngine "Permalink to this definition")SQL Table retriever query engine.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.struct_store.SQLTableRetrieverQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

*property* service\_context*: [ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*[](#llama_index.indices.struct_store.SQLTableRetrieverQueryEngine.service_context "Permalink to this definition")Get service context.

*property* sql\_retriever*: NLSQLRetriever*[](#llama_index.indices.struct_store.SQLTableRetrieverQueryEngine.sql_retriever "Permalink to this definition")Get SQL retriever.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.struct_store.SQLTableRetrieverQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

