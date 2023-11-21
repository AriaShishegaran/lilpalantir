Structured Index Configuration[](#structured-index-configuration "Permalink to this heading")
==============================================================================================

Our structured indices are documented in [Structured Store Index](indices/struct_store.html#ref-indices-structstore).Below, we provide a reference of the classes that are used to configure our structured indices.

SQL wrapper around SQLDatabase in langchain.

*class* llama\_index.utilities.sql\_wrapper.SQLDatabase(*engine: Engine*, *schema: Optional[str] = None*, *metadata: Optional[MetaData] = None*, *ignore\_tables: Optional[List[str]] = None*, *include\_tables: Optional[List[str]] = None*, *sample\_rows\_in\_table\_info: int = 3*, *indexes\_in\_table\_info: bool = False*, *custom\_table\_info: Optional[dict] = None*, *view\_support: bool = False*, *max\_string\_length: int = 300*)[](#llama_index.utilities.sql_wrapper.SQLDatabase "Permalink to this definition")SQL Database.

This class provides a wrapper around the SQLAlchemy engine to interact with a SQLdatabase.It provides methods to execute SQL commands, insert data into tables, and retrieveinformation about the database schema.It also supports optional features such as including or excluding specific tables,sampling rows for table info,including indexes in table info, and supporting views.

Based on langchain SQLDatabase.<https://github.com/langchain-ai/langchain/blob/e355606b1100097665207ca259de6dc548d44c78/libs/langchain/langchain/utilities/sql_database.py#L39>

Parameters* **engine** (*Engine*) – The SQLAlchemy engine instance to use for database operations.
* **schema** (*Optional**[**str**]*) – The name of the schema to use, if any.
* **metadata** (*Optional**[**MetaData**]*) – The metadata instance to use, if any.
* **ignore\_tables** (*Optional**[**List**[**str**]**]*) – List of table names to ignore. If set,include\_tables must be None.
* **include\_tables** (*Optional**[**List**[**str**]**]*) – List of table names to include. If set,ignore\_tables must be None.
* **sample\_rows\_in\_table\_info** (*int*) – The number of sample rows to include in tableinfo.
* **indexes\_in\_table\_info** (*bool*) – Whether to include indexes in table info.
* **custom\_table\_info** (*Optional**[**dict**]*) – Custom table info to use.
* **view\_support** (*bool*) – Whether to support views.
* **max\_string\_length** (*int*) – The maximum string length to use.
*property* dialect*: str*[](#llama_index.utilities.sql_wrapper.SQLDatabase.dialect "Permalink to this definition")Return string representation of dialect to use.

*property* engine*: Engine*[](#llama_index.utilities.sql_wrapper.SQLDatabase.engine "Permalink to this definition")Return SQL Alchemy engine.

*classmethod* from\_uri(*database\_uri: str*, *engine\_args: Optional[dict] = None*, *\*\*kwargs: Any*) → [SQLDatabase](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")[](#llama_index.utilities.sql_wrapper.SQLDatabase.from_uri "Permalink to this definition")Construct a SQLAlchemy engine from URI.

get\_single\_table\_info(*table\_name: str*) → str[](#llama_index.utilities.sql_wrapper.SQLDatabase.get_single_table_info "Permalink to this definition")Get table info for a single table.

get\_table\_columns(*table\_name: str*) → List[Any][](#llama_index.utilities.sql_wrapper.SQLDatabase.get_table_columns "Permalink to this definition")Get table columns.

get\_usable\_table\_names() → Iterable[str][](#llama_index.utilities.sql_wrapper.SQLDatabase.get_usable_table_names "Permalink to this definition")Get names of tables available.

insert\_into\_table(*table\_name: str*, *data: dict*) → None[](#llama_index.utilities.sql_wrapper.SQLDatabase.insert_into_table "Permalink to this definition")Insert data into a table.

*property* metadata\_obj*: MetaData*[](#llama_index.utilities.sql_wrapper.SQLDatabase.metadata_obj "Permalink to this definition")Return SQL Alchemy metadata.

run\_sql(*command: str*) → Tuple[str, Dict][](#llama_index.utilities.sql_wrapper.SQLDatabase.run_sql "Permalink to this definition")Execute a SQL statement and return a string representing the results.

If the statement returns rows, a string of the results is returned.If the statement returns no rows, an empty string is returned.

SQL Container builder.

*class* llama\_index.indices.struct\_store.container\_builder.SQLContextContainerBuilder(*sql\_database: [SQLDatabase](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *context\_dict: Optional[Dict[str, str]] = None*, *context\_str: Optional[str] = None*)[](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder "Permalink to this definition")SQLContextContainerBuilder.

Build a SQLContextContainer that can be passed to the SQL indexduring index construction or during query-time.

NOTE: if context\_str is specified, that will be used as contextinstead of context\_dict

Parameters* **sql\_database** ([*SQLDatabase*](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")) – SQL database
* **context\_dict** (*Optional**[**Dict**[**str**,* *str**]**]*) – context dict
build\_context\_container(*ignore\_db\_schema: bool = False*) → SQLContextContainer[](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder.build_context_container "Permalink to this definition")Build index structure.

derive\_index\_from\_context(*index\_cls: Type[[BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*, *ignore\_db\_schema: bool = False*, *\*\*index\_kwargs: Any*) → [BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")[](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder.derive_index_from_context "Permalink to this definition")Derive index from context.

*classmethod* from\_documents(*documents\_dict: Dict[str, List[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]]*, *sql\_database: [SQLDatabase](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *\*\*context\_builder\_kwargs: Any*) → [SQLContextContainerBuilder](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder "llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder")[](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder.from_documents "Permalink to this definition")Build context from documents.

query\_index\_for\_context(*index: [BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*, *query\_str: Union[str, [QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *query\_tmpl: Optional[str] = 'Please return the relevant tables (including the full schema) for the following query: {orig\_query\_str}'*, *store\_context\_str: bool = True*, *\*\*index\_kwargs: Any*) → str[](#llama_index.indices.struct_store.container_builder.SQLContextContainerBuilder.query_index_for_context "Permalink to this definition")Query index for context.

A simple wrapper around the index.query call whichinjects a query template to specifically fetch table information,and can store a context\_str.

Parameters* **index** ([*BaseIndex*](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")) – index data structure
* **query\_str** (*QueryType*) – query string
* **query\_tmpl** (*Optional**[**str**]*) – query template
* **store\_context\_str** (*bool*) – store context\_str
Common classes for structured operations.

*class* llama\_index.indices.common.struct\_store.base.BaseStructDatapointExtractor(*llm\_predictor: BaseLLMPredictor*, *schema\_extract\_prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_parser: Callable[[str], Optional[Dict[str, Any]]]*)[](#llama_index.indices.common.struct_store.base.BaseStructDatapointExtractor "Permalink to this definition")Extracts datapoints from a structured document.

insert\_datapoint\_from\_nodes(*nodes: Sequence[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → None[](#llama_index.indices.common.struct_store.base.BaseStructDatapointExtractor.insert_datapoint_from_nodes "Permalink to this definition")Extract datapoint from a document and insert it.

*class* llama\_index.indices.common.struct\_store.base.SQLDocumentContextBuilder(*sql\_database: [SQLDatabase](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*, *service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *text\_splitter: Optional[TextSplitter] = None*, *table\_context\_prompt: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_table\_context\_prompt: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *table\_context\_task: Optional[str] = None*)[](#llama_index.indices.common.struct_store.base.SQLDocumentContextBuilder "Permalink to this definition")Builder that builds context for a given set of SQL tables.

Parameters* **sql\_database** (*Optional**[*[*SQLDatabase*](#llama_index.utilities.sql_wrapper.SQLDatabase "llama_index.utilities.sql_wrapper.SQLDatabase")*]*) – SQL database to use,
* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLM Predictor to use.
* **prompt\_helper** (*Optional**[*[*PromptHelper*](service_context/prompt_helper.html#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")*]*) – Prompt Helper to use.
* **text\_splitter** (*Optional**[**TextSplitter**]*) – Text Splitter to use.
* **table\_context\_prompt** (*Optional**[*[*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – ATable Context Prompt (see [Prompt Templates](prompts.html#prompt-templates)).
* **refine\_table\_context\_prompt** (*Optional**[*[*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Refine Table Context Prompt (see [Prompt Templates](prompts.html#prompt-templates)).
* **table\_context\_task** (*Optional**[**str**]*) – The query to performon the table context. A default query string is usedif none is provided by the user.
build\_all\_context\_from\_documents(*documents\_dict: Dict[str, List[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]]*) → Dict[str, str][](#llama_index.indices.common.struct_store.base.SQLDocumentContextBuilder.build_all_context_from_documents "Permalink to this definition")Build context for all tables in the database.

build\_table\_context\_from\_documents(*documents: Sequence[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *table\_name: str*) → str[](#llama_index.indices.common.struct_store.base.SQLDocumentContextBuilder.build_table_context_from_documents "Permalink to this definition")Build context from documents for a single table.

