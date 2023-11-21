Vector Store Retrievers[](#module-llama_index.indices.vector_store.retrievers.retriever "Permalink to this heading")
=====================================================================================================================

Base vector store index query.

*class* llama\_index.indices.vector\_store.retrievers.retriever.VectorIndexRetriever(*index: [VectorStoreIndex](../../indices/vector_store.html#llama_index.indices.vector_store.base.VectorStoreIndex "llama_index.indices.vector_store.base.VectorStoreIndex")*, *similarity\_top\_k: int = 2*, *vector\_store\_query\_mode: [VectorStoreQueryMode](#llama_index.vector_stores.types.VectorStoreQueryMode "llama_index.vector_stores.types.VectorStoreQueryMode") = VectorStoreQueryMode.DEFAULT*, *filters: Optional[[MetadataFilters](#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")] = None*, *alpha: Optional[float] = None*, *node\_ids: Optional[List[str]] = None*, *doc\_ids: Optional[List[str]] = None*, *sparse\_top\_k: Optional[int] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever "Permalink to this definition")Vector index retriever.

Parameters* **index** ([*VectorStoreIndex*](../../indices/vector_store.html#llama_index.indices.vector_store.base.VectorStoreIndex "llama_index.indices.vector_store.base.VectorStoreIndex")) – vector store index.
* **similarity\_top\_k** (*int*) – number of top k results to return.
* **vector\_store\_query\_mode** (*str*) – vector store query modeSee reference for VectorStoreQueryMode for full list of supported modes.
* **filters** (*Optional**[*[*MetadataFilters*](#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")*]*) – metadata filters, defaults to None
* **alpha** (*float*) – weight for sparse/dense retrieval, only used forhybrid query mode.
* **doc\_ids** (*Optional**[**List**[**str**]**]*) – list of documents to constrain search.
* **vector\_store\_kwargs** (*dict*) – Additional vector store specific kwargs to passthrough to the vector store at query time.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

*property* similarity\_top\_k*: int*[](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever.similarity_top_k "Permalink to this definition")Return similarity top k.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.vector_store.retrievers.retriever.VectorIndexRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.vector\_store.retrievers.auto\_retriever.auto\_retriever.VectorIndexAutoRetriever(*index: [VectorStoreIndex](../../indices/vector_store.html#llama_index.indices.vector_store.base.VectorStoreIndex "llama_index.indices.vector_store.base.VectorStoreIndex")*, *vector\_store\_info: [VectorStoreInfo](#llama_index.vector_stores.types.VectorStoreInfo "llama_index.vector_stores.types.VectorStoreInfo")*, *prompt\_template\_str: Optional[str] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *max\_top\_k: int = 10*, *similarity\_top\_k: int = 2*, *vector\_store\_query\_mode: [VectorStoreQueryMode](#llama_index.vector_stores.types.VectorStoreQueryMode "llama_index.vector_stores.types.VectorStoreQueryMode") = VectorStoreQueryMode.DEFAULT*, *\*\*kwargs: Any*)[](#llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever.VectorIndexAutoRetriever "Permalink to this definition")Vector store auto retriever.

A retriever for vector store index that uses an LLM to automatically setvector store query parameters.

Parameters* **index** ([*VectorStoreIndex*](../../indices/vector_store.html#llama_index.indices.vector_store.base.VectorStoreIndex "llama_index.indices.vector_store.base.VectorStoreIndex")) – vector store index
* **vector\_store\_info** ([*VectorStoreInfo*](#llama_index.vector_stores.types.VectorStoreInfo "llama_index.vector_stores.types.VectorStoreInfo")) – additional information information aboutvector store content and supported metadata filters. The natural languagedescription is used by an LLM to automatically set vector store queryparameters.
* **prompt\_template\_str** – custom prompt template string for LLM.Uses default template string if None.
* **service\_context** – service context containing reference to LLMPredictor.Uses service context from index be default if None.
* **similarity\_top\_k** (*int*) – number of top k results to return.
* **max\_top\_k** (*int*) – the maximum top\_k allowed. The top\_k set by LLM or similarity\_top\_k willbe clamped to this value.
* **vector\_store\_query\_mode** (*str*) – vector store query modeSee reference for VectorStoreQueryMode for full list of supported modes.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever.VectorIndexAutoRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever.VectorIndexAutoRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever.VectorIndexAutoRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever.VectorIndexAutoRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

Vector store index types.

*pydantic model* llama\_index.vector\_stores.types.BasePydanticVectorStore[](#llama_index.vector_stores.types.BasePydanticVectorStore "Permalink to this definition")Abstract vector store protocol.

Show JSON schema
```
{ "title": "BasePydanticVectorStore", "description": "Abstract vector store protocol.", "type": "object", "properties": { "stores\_text": { "title": "Stores Text", "type": "boolean" }, "is\_embedding\_query": { "title": "Is Embedding Query", "default": true, "type": "boolean" } }, "required": [ "stores\_text" ]}
```


Fields* [`is\_embedding\_query (bool)`](#llama_index.vector_stores.types.BasePydanticVectorStore.is_embedding_query "llama_index.vector_stores.types.BasePydanticVectorStore.is_embedding_query")
* [`stores\_text (bool)`](#llama_index.vector_stores.types.BasePydanticVectorStore.stores_text "llama_index.vector_stores.types.BasePydanticVectorStore.stores_text")
*field* is\_embedding\_query*: bool* *= True*[](#llama_index.vector_stores.types.BasePydanticVectorStore.is_embedding_query "Permalink to this definition")*field* stores\_text*: bool* *[Required]*[](#llama_index.vector_stores.types.BasePydanticVectorStore.stores_text "Permalink to this definition")*abstract* add(*nodes: List[[BaseNode](../../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.types.BasePydanticVectorStore.add "Permalink to this definition")Add nodes to vector store.

*async* adelete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.types.BasePydanticVectorStore.adelete "Permalink to this definition")Delete nodes using with ref\_doc\_id.NOTE: this is not implemented for all vector stores. If not implemented,it will just call delete synchronously.

*async* aquery(*query: [VectorStoreQuery](../../storage/vector_store.html#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](../../storage/vector_store.html#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.types.BasePydanticVectorStore.aquery "Permalink to this definition")Asynchronously query vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call query synchronously.

*async* async\_add(*nodes: List[[BaseNode](../../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[str][](#llama_index.vector_stores.types.BasePydanticVectorStore.async_add "Permalink to this definition")Asynchronously add nodes to vector store.NOTE: this is not implemented for all vector stores. If not implemented,it will just call add synchronously.

*abstract classmethod* class\_name() → str[](#llama_index.vector_stores.types.BasePydanticVectorStore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

*abstract* delete(*ref\_doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.vector_stores.types.BasePydanticVectorStore.delete "Permalink to this definition")Delete nodes using with ref\_doc\_id.

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.types.BasePydanticVectorStore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.types.BasePydanticVectorStore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.vector_stores.types.BasePydanticVectorStore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.BasePydanticVectorStore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.parse_raw "Permalink to this definition")persist(*persist\_path: str*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.vector_stores.types.BasePydanticVectorStore.persist "Permalink to this definition")*abstract* query(*query: [VectorStoreQuery](../../storage/vector_store.html#llama_index.vector_stores.VectorStoreQuery "llama_index.vector_stores.types.VectorStoreQuery")*, *\*\*kwargs: Any*) → [VectorStoreQueryResult](../../storage/vector_store.html#llama_index.vector_stores.VectorStoreQueryResult "llama_index.vector_stores.types.VectorStoreQueryResult")[](#llama_index.vector_stores.types.BasePydanticVectorStore.query "Permalink to this definition")Query vector store.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.types.BasePydanticVectorStore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.BasePydanticVectorStore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.vector_stores.types.BasePydanticVectorStore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.vector_stores.types.BasePydanticVectorStore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.types.BasePydanticVectorStore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.types.BasePydanticVectorStore.validate "Permalink to this definition")*abstract property* client*: Any*[](#llama_index.vector_stores.types.BasePydanticVectorStore.client "Permalink to this definition")Get client.

*pydantic model* llama\_index.vector\_stores.types.ExactMatchFilter[](#llama_index.vector_stores.types.ExactMatchFilter "Permalink to this definition")Exact match metadata filter for vector stores.

Value uses Strict\* types, as int, float and str are compatible types and were allconverted to string before.

See: <https://docs.pydantic.dev/latest/usage/types/#strict-types>

Show JSON schema
```
{ "title": "ExactMatchFilter", "description": "Exact match metadata filter for vector stores.\n\nValue uses Strict\* types, as int, float and str are compatible types and were all\nconverted to string before.\n\nSee: https://docs.pydantic.dev/latest/usage/types/#strict-types", "type": "object", "properties": { "key": { "title": "Key", "type": "string" }, "value": { "title": "Value", "anyOf": [ { "type": "integer" }, { "type": "number" }, { "type": "string" } ] } }, "required": [ "key", "value" ]}
```


Fields* [`key (str)`](#llama_index.vector_stores.types.ExactMatchFilter.key "llama_index.vector_stores.types.ExactMatchFilter.key")
* [`value (Union[pydantic.types.StrictInt, pydantic.types.StrictFloat, pydantic.types.StrictStr])`](#llama_index.vector_stores.types.ExactMatchFilter.value "llama_index.vector_stores.types.ExactMatchFilter.value")
*field* key*: str* *[Required]*[](#llama_index.vector_stores.types.ExactMatchFilter.key "Permalink to this definition")*field* value*: Union[StrictInt, StrictFloat, StrictStr]* *[Required]*[](#llama_index.vector_stores.types.ExactMatchFilter.value "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.types.ExactMatchFilter.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.ExactMatchFilter.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.types.ExactMatchFilter.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.ExactMatchFilter.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.types.ExactMatchFilter.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.types.ExactMatchFilter.validate "Permalink to this definition")*pydantic model* llama\_index.vector\_stores.types.MetadataFilters[](#llama_index.vector_stores.types.MetadataFilters "Permalink to this definition")Metadata filters for vector stores.

Currently only supports exact match filters.TODO: support more advanced expressions.

Show JSON schema
```
{ "title": "MetadataFilters", "description": "Metadata filters for vector stores.\n\nCurrently only supports exact match filters.\nTODO: support more advanced expressions.", "type": "object", "properties": { "filters": { "title": "Filters", "type": "array", "items": { "$ref": "#/definitions/ExactMatchFilter" } } }, "required": [ "filters" ], "definitions": { "ExactMatchFilter": { "title": "ExactMatchFilter", "description": "Exact match metadata filter for vector stores.\n\nValue uses Strict\* types, as int, float and str are compatible types and were all\nconverted to string before.\n\nSee: https://docs.pydantic.dev/latest/usage/types/#strict-types", "type": "object", "properties": { "key": { "title": "Key", "type": "string" }, "value": { "title": "Value", "anyOf": [ { "type": "integer" }, { "type": "number" }, { "type": "string" } ] } }, "required": [ "key", "value" ] } }}
```


Fields* [`filters (List[llama\_index.vector\_stores.types.ExactMatchFilter])`](#llama_index.vector_stores.types.MetadataFilters.filters "llama_index.vector_stores.types.MetadataFilters.filters")
*field* filters*: List[[ExactMatchFilter](#llama_index.vector_stores.types.ExactMatchFilter "llama_index.vector_stores.types.ExactMatchFilter")]* *[Required]*[](#llama_index.vector_stores.types.MetadataFilters.filters "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.types.MetadataFilters.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataFilters.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.types.MetadataFilters.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*filter\_dict: Dict*) → [MetadataFilters](#llama_index.vector_stores.types.MetadataFilters "llama_index.vector_stores.types.MetadataFilters")[](#llama_index.vector_stores.types.MetadataFilters.from_dict "Permalink to this definition")Create MetadataFilters from json.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.types.MetadataFilters.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.MetadataFilters.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataFilters.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.types.MetadataFilters.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataFilters.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.types.MetadataFilters.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.MetadataFilters.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.types.MetadataFilters.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.types.MetadataFilters.validate "Permalink to this definition")*pydantic model* llama\_index.vector\_stores.types.MetadataInfo[](#llama_index.vector_stores.types.MetadataInfo "Permalink to this definition")Information about a metadata filter supported by a vector store.

Currently only used by VectorIndexAutoRetriever.

Show JSON schema
```
{ "title": "MetadataInfo", "description": "Information about a metadata filter supported by a vector store.\n\nCurrently only used by VectorIndexAutoRetriever.", "type": "object", "properties": { "name": { "title": "Name", "type": "string" }, "type": { "title": "Type", "type": "string" }, "description": { "title": "Description", "type": "string" } }, "required": [ "name", "type", "description" ]}
```


Fields* [`description (str)`](#llama_index.vector_stores.types.MetadataInfo.description "llama_index.vector_stores.types.MetadataInfo.description")
* [`name (str)`](#llama_index.vector_stores.types.MetadataInfo.name "llama_index.vector_stores.types.MetadataInfo.name")
* [`type (str)`](#llama_index.vector_stores.types.MetadataInfo.type "llama_index.vector_stores.types.MetadataInfo.type")
*field* description*: str* *[Required]*[](#llama_index.vector_stores.types.MetadataInfo.description "Permalink to this definition")*field* name*: str* *[Required]*[](#llama_index.vector_stores.types.MetadataInfo.name "Permalink to this definition")*field* type*: str* *[Required]*[](#llama_index.vector_stores.types.MetadataInfo.type "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.types.MetadataInfo.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataInfo.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.types.MetadataInfo.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.types.MetadataInfo.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.MetadataInfo.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataInfo.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.types.MetadataInfo.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.MetadataInfo.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.types.MetadataInfo.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.MetadataInfo.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.types.MetadataInfo.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.types.MetadataInfo.validate "Permalink to this definition")*pydantic model* llama\_index.vector\_stores.types.VectorStoreInfo[](#llama_index.vector_stores.types.VectorStoreInfo "Permalink to this definition")Information about a vector store (content and supported metadata filters).

Currently only used by VectorIndexAutoRetriever.

Show JSON schema
```
{ "title": "VectorStoreInfo", "description": "Information about a vector store (content and supported metadata filters).\n\nCurrently only used by VectorIndexAutoRetriever.", "type": "object", "properties": { "metadata\_info": { "title": "Metadata Info", "type": "array", "items": { "$ref": "#/definitions/MetadataInfo" } }, "content\_info": { "title": "Content Info", "type": "string" } }, "required": [ "metadata\_info", "content\_info" ], "definitions": { "MetadataInfo": { "title": "MetadataInfo", "description": "Information about a metadata filter supported by a vector store.\n\nCurrently only used by VectorIndexAutoRetriever.", "type": "object", "properties": { "name": { "title": "Name", "type": "string" }, "type": { "title": "Type", "type": "string" }, "description": { "title": "Description", "type": "string" } }, "required": [ "name", "type", "description" ] } }}
```


Fields* [`content\_info (str)`](#llama_index.vector_stores.types.VectorStoreInfo.content_info "llama_index.vector_stores.types.VectorStoreInfo.content_info")
* [`metadata\_info (List[llama\_index.vector\_stores.types.MetadataInfo])`](#llama_index.vector_stores.types.VectorStoreInfo.metadata_info "llama_index.vector_stores.types.VectorStoreInfo.metadata_info")
*field* content\_info*: str* *[Required]*[](#llama_index.vector_stores.types.VectorStoreInfo.content_info "Permalink to this definition")*field* metadata\_info*: List[[MetadataInfo](#llama_index.vector_stores.types.MetadataInfo "llama_index.vector_stores.types.MetadataInfo")]* *[Required]*[](#llama_index.vector_stores.types.VectorStoreInfo.metadata_info "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.vector_stores.types.VectorStoreInfo.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.VectorStoreInfo.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.vector_stores.types.VectorStoreInfo.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.vector_stores.types.VectorStoreInfo.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.vector_stores.types.VectorStoreInfo.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.vector_stores.types.VectorStoreInfo.validate "Permalink to this definition")*class* llama\_index.vector\_stores.types.VectorStoreQueryMode(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.vector_stores.types.VectorStoreQueryMode "Permalink to this definition")Vector store query mode.

capitalize()[](#llama_index.vector_stores.types.VectorStoreQueryMode.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.vector_stores.types.VectorStoreQueryMode.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.vector_stores.types.VectorStoreQueryMode.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.vector_stores.types.VectorStoreQueryMode.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.vector_stores.types.VectorStoreQueryMode.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.vector_stores.types.VectorStoreQueryMode.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.vector_stores.types.VectorStoreQueryMode.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.vector_stores.types.VectorStoreQueryMode.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.vector_stores.types.VectorStoreQueryMode.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.vector_stores.types.VectorStoreQueryMode.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.vector_stores.types.VectorStoreQueryMode.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.vector_stores.types.VectorStoreQueryMode.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.vector_stores.types.VectorStoreQueryMode.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.vector_stores.types.VectorStoreQueryMode.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.vector_stores.types.VectorStoreQueryMode.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.vector_stores.types.VectorStoreQueryMode.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.vector_stores.types.VectorStoreQueryMode.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.vector_stores.types.VectorStoreQueryMode.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.vector_stores.types.VectorStoreQueryMode.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.vector_stores.types.VectorStoreQueryMode.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

