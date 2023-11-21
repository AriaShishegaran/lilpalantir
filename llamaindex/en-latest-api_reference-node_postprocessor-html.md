Node Postprocessor[](#module-llama_index.indices.postprocessor "Permalink to this heading")
============================================================================================

Node PostProcessor module.

*pydantic model* llama\_index.indices.postprocessor.AutoPrevNextNodePostprocessor[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor "Permalink to this definition")Previous/Next Node post-processor.

Allows users to fetch additional nodes from the document store,based on the prev/next relationships of the nodes.

NOTE: difference with PrevNextPostprocessor is thatthis infers forward/backwards direction.

NOTE: this is a beta feature.

Parameters* **docstore** ([*BaseDocumentStore*](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.BaseDocumentStore")) – The document store.
* **llm\_predictor** ([*LLMPredictor*](llm_predictor.html#llama_index.llm_predictor.LLMPredictor "llama_index.llm_predictor.LLMPredictor")) – The LLM predictor.
* **num\_nodes** (*int*) – The number of nodes to return (default: 1)
* **infer\_prev\_next\_tmpl** (*str*) – The template to use for inference.Required fields are {context\_str} and {query\_str}.
Show JSON schema
```
{ "title": "AutoPrevNextNodePostprocessor", "description": "Previous/Next Node post-processor.\n\nAllows users to fetch additional nodes from the document store,\nbased on the prev/next relationships of the nodes.\n\nNOTE: difference with PrevNextPostprocessor is that\nthis infers forward/backwards direction.\n\nNOTE: this is a beta feature.\n\nArgs:\n docstore (BaseDocumentStore): The document store.\n llm\_predictor (LLMPredictor): The LLM predictor.\n num\_nodes (int): The number of nodes to return (default: 1)\n infer\_prev\_next\_tmpl (str): The template to use for inference.\n Required fields are {context\_str} and {query\_str}.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "docstore": { "title": "Docstore" }, "service\_context": { "title": "Service Context" }, "num\_nodes": { "title": "Num Nodes", "default": 1, "type": "integer" }, "infer\_prev\_next\_tmpl": { "title": "Infer Prev Next Tmpl", "default": "The current context information is provided. \nA question is also provided. \nYou are a retrieval agent deciding whether to search the document store for additional prior context or future context. \nGiven the context and question, return PREVIOUS or NEXT or NONE. \nExamples: \n\nContext: Describes the author's experience at Y Combinator.Question: What did the author do after his time at Y Combinator? \nAnswer: NEXT \n\nContext: Describes the author's experience at Y Combinator.Question: What did the author do before his time at Y Combinator? \nAnswer: PREVIOUS \n\nContext: Describe the author's experience at Y Combinator.Question: What did the author do at Y Combinator? \nAnswer: NONE \n\nContext: {context\_str}\nQuestion: {query\_str}\nAnswer: ", "type": "string" }, "refine\_prev\_next\_tmpl": { "title": "Refine Prev Next Tmpl", "default": "The current context information is provided. \nA question is also provided. \nAn existing answer is also provided.\nYou are a retrieval agent deciding whether to search the document store for additional prior context or future context. \nGiven the context, question, and previous answer, return PREVIOUS or NEXT or NONE.\nExamples: \n\nContext: {context\_msg}\nQuestion: {query\_str}\nExisting Answer: {existing\_answer}\nAnswer: ", "type": "string" }, "verbose": { "title": "Verbose", "default": false, "type": "boolean" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `docstore (llama\_index.storage.docstore.types.BaseDocumentStore)`
* `infer\_prev\_next\_tmpl (str)`
* `num\_nodes (int)`
* `refine\_prev\_next\_tmpl (str)`
* `service\_context (llama\_index.indices.service\_context.ServiceContext)`
* `verbose (bool)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.callback_manager "Permalink to this definition")*field* docstore*: [BaseDocumentStore](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")* *[Required]*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.docstore "Permalink to this definition")*field* infer\_prev\_next\_tmpl*: str* *= "The current context information is provided. \nA question is also provided. \nYou are a retrieval agent deciding whether to search the document store for additional prior context or future context. \nGiven the context and question, return PREVIOUS or NEXT or NONE. \nExamples: \n\nContext: Describes the author's experience at Y Combinator.Question: What did the author do after his time at Y Combinator? \nAnswer: NEXT \n\nContext: Describes the author's experience at Y Combinator.Question: What did the author do before his time at Y Combinator? \nAnswer: PREVIOUS \n\nContext: Describe the author's experience at Y Combinator.Question: What did the author do at Y Combinator? \nAnswer: NONE \n\nContext: {context\_str}\nQuestion: {query\_str}\nAnswer: "*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.infer_prev_next_tmpl "Permalink to this definition")*field* num\_nodes*: int* *= 1*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.num_nodes "Permalink to this definition")*field* refine\_prev\_next\_tmpl*: str* *= 'The current context information is provided. \nA question is also provided. \nAn existing answer is also provided.\nYou are a retrieval agent deciding whether to search the document store for additional prior context or future context. \nGiven the context, question, and previous answer, return PREVIOUS or NEXT or NONE.\nExamples: \n\nContext: {context\_msg}\nQuestion: {query\_str}\nExisting Answer: {existing\_answer}\nAnswer: '*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.refine_prev_next_tmpl "Permalink to this definition")*field* service\_context*: [ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")* *[Required]*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.service_context "Permalink to this definition")*field* verbose*: bool* *= False*[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.verbose "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.AutoPrevNextNodePostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.CohereRerank[](#llama_index.indices.postprocessor.CohereRerank "Permalink to this definition")Show JSON schema
```
{ "title": "CohereRerank", "description": "Base component object to capture class names.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "Cohere model name.", "type": "string" }, "top\_n": { "title": "Top N", "description": "Top N nodes to return.", "type": "integer" } }, "required": [ "model", "top\_n" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `model (str)`
* `top\_n (int)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.CohereRerank.callback_manager "Permalink to this definition")*field* model*: str* *[Required]*[](#llama_index.indices.postprocessor.CohereRerank.model "Permalink to this definition")Cohere model name.

*field* top\_n*: int* *[Required]*[](#llama_index.indices.postprocessor.CohereRerank.top_n "Permalink to this definition")Top N nodes to return.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.CohereRerank.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.CohereRerank.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.CohereRerank.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.CohereRerank.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.CohereRerank.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.CohereRerank.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.CohereRerank.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.CohereRerank.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.CohereRerank.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.CohereRerank.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.CohereRerank.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.CohereRerank.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.CohereRerank.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.CohereRerank.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.CohereRerank.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.CohereRerank.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.CohereRerank.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.CohereRerank.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.EmbeddingRecencyPostprocessor[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor "Permalink to this definition")Recency post-processor.

This post-processor does the following steps:

* Decides if we need to use the post-processor given the query(is it temporal-related?)
* If yes, sorts nodes by date.
* For each node, look at subsequent nodes and filter out nodesthat have high embedding similarity with the current node.Because this means the subsequent node may have overlapping contentwith the current node but is also out of date

Show JSON schema
```
{ "title": "EmbeddingRecencyPostprocessor", "description": "Recency post-processor.\n\nThis post-processor does the following steps:\n\n- Decides if we need to use the post-processor given the query\n (is it temporal-related?)\n- If yes, sorts nodes by date.\n- For each node, look at subsequent nodes and filter out nodes\n that have high embedding similarity with the current node.\n Because this means the subsequent node may have overlapping content\n with the current node but is also out of date", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "service\_context": { "title": "Service Context" }, "date\_key": { "title": "Date Key", "default": "date", "type": "string" }, "similarity\_cutoff": { "title": "Similarity Cutoff", "default": 0.7, "type": "number" }, "query\_embedding\_tmpl": { "title": "Query Embedding Tmpl", "default": "The current document is provided.\n----------------\n{context\_str}\n----------------\nGiven the document, we wish to find documents that contain \nsimilar context. Note that these documents are older than the current document, meaning that certain details may be changed. \nHowever, the high-level context should be similar.\n", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `date\_key (str)`
* `query\_embedding\_tmpl (str)`
* `service\_context (llama\_index.indices.service\_context.ServiceContext)`
* `similarity\_cutoff (float)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.callback_manager "Permalink to this definition")*field* date\_key*: str* *= 'date'*[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.date_key "Permalink to this definition")*field* query\_embedding\_tmpl*: str* *= 'The current document is provided.\n----------------\n{context\_str}\n----------------\nGiven the document, we wish to find documents that contain \nsimilar context. Note that these documents are older than the current document, meaning that certain details may be changed. \nHowever, the high-level context should be similar.\n'*[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.query_embedding_tmpl "Permalink to this definition")*field* service\_context*: [ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")* *[Required]*[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.service_context "Permalink to this definition")*field* similarity\_cutoff*: float* *= 0.7*[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.similarity_cutoff "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.EmbeddingRecencyPostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.FixedRecencyPostprocessor[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor "Permalink to this definition")Recency post-processor.

This post-processor does the following steps:

* Decides if we need to use the post-processor given the query(is it temporal-related?)
* If yes, sorts nodes by date.
* Take the first k nodes (by default 1), and use that to synthesize an answer.

Show JSON schema
```
{ "title": "FixedRecencyPostprocessor", "description": "Recency post-processor.\n\nThis post-processor does the following steps:\n\n- Decides if we need to use the post-processor given the query\n (is it temporal-related?)\n- If yes, sorts nodes by date.\n- Take the first k nodes (by default 1), and use that to synthesize an answer.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "service\_context": { "title": "Service Context" }, "top\_k": { "title": "Top K", "default": 1, "type": "integer" }, "date\_key": { "title": "Date Key", "default": "date", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `date\_key (str)`
* `service\_context (llama\_index.indices.service\_context.ServiceContext)`
* `top\_k (int)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.callback_manager "Permalink to this definition")*field* date\_key*: str* *= 'date'*[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.date_key "Permalink to this definition")*field* service\_context*: [ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")* *[Required]*[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.service_context "Permalink to this definition")*field* top\_k*: int* *= 1*[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.top_k "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.FixedRecencyPostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.KeywordNodePostprocessor[](#llama_index.indices.postprocessor.KeywordNodePostprocessor "Permalink to this definition")Keyword-based Node processor.

Show JSON schema
```
{ "title": "KeywordNodePostprocessor", "description": "Keyword-based Node processor.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "required\_keywords": { "title": "Required Keywords", "type": "array", "items": { "type": "string" } }, "exclude\_keywords": { "title": "Exclude Keywords", "type": "array", "items": { "type": "string" } }, "lang": { "title": "Lang", "default": "en", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `exclude\_keywords (List[str])`
* `lang (str)`
* `required\_keywords (List[str])`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.callback_manager "Permalink to this definition")*field* exclude\_keywords*: List[str]* *[Optional]*[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.exclude_keywords "Permalink to this definition")*field* lang*: str* *= 'en'*[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.lang "Permalink to this definition")*field* required\_keywords*: List[str]* *[Optional]*[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.required_keywords "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.KeywordNodePostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.KeywordNodePostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.KeywordNodePostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.LLMRerank[](#llama_index.indices.postprocessor.LLMRerank "Permalink to this definition")LLM-based reranker.

Show JSON schema
```
{ "title": "LLMRerank", "description": "LLM-based reranker.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "top\_n": { "title": "Top N", "description": "Top N nodes to return.", "type": "integer" }, "choice\_select\_prompt": { "title": "Choice Select Prompt" }, "choice\_batch\_size": { "title": "Choice Batch Size", "description": "Batch size for choice select.", "type": "integer" }, "service\_context": { "title": "Service Context" } }, "required": [ "top\_n", "choice\_batch\_size" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `choice\_batch\_size (int)`
* `choice\_select\_prompt (llama\_index.prompts.base.BasePromptTemplate)`
* `service\_context (llama\_index.indices.service\_context.ServiceContext)`
* `top\_n (int)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.LLMRerank.callback_manager "Permalink to this definition")*field* choice\_batch\_size*: int* *[Required]*[](#llama_index.indices.postprocessor.LLMRerank.choice_batch_size "Permalink to this definition")Batch size for choice select.

*field* choice\_select\_prompt*: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")* *[Required]*[](#llama_index.indices.postprocessor.LLMRerank.choice_select_prompt "Permalink to this definition")Choice select prompt.

*field* service\_context*: [ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")* *[Required]*[](#llama_index.indices.postprocessor.LLMRerank.service_context "Permalink to this definition")Service context.

*field* top\_n*: int* *[Required]*[](#llama_index.indices.postprocessor.LLMRerank.top_n "Permalink to this definition")Top N nodes to return.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.LLMRerank.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.LLMRerank.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.LLMRerank.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.LLMRerank.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LLMRerank.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LLMRerank.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LLMRerank.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LLMRerank.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LLMRerank.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LLMRerank.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LLMRerank.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.LLMRerank.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.LLMRerank.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LLMRerank.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.LLMRerank.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.LLMRerank.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.LLMRerank.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.LLMRerank.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.LongContextReorder[](#llama_index.indices.postprocessor.LongContextReorder "Permalink to this definition")Models struggle to access significant details foundin the center of extended contexts. A study(<https://arxiv.org/abs/2307.03172>) observed that the bestperformance typically arises when crucial data is positionedat the start or conclusion of the input context. Additionally,as the input context lengthens, performance drops notably, evenin models designed for long contexts.”.

Show JSON schema
```
{ "title": "LongContextReorder", "description": "Models struggle to access significant details found\nin the center of extended contexts. A study\n(https://arxiv.org/abs/2307.03172) observed that the best\nperformance typically arises when crucial data is positioned\nat the start or conclusion of the input context. Additionally,\nas the input context lengthens, performance drops notably, even\nin models designed for long contexts.\".", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.LongContextReorder.callback_manager "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.LongContextReorder.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.LongContextReorder.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LongContextReorder.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LongContextReorder.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LongContextReorder.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.LongContextReorder.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.LongContextReorder.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LongContextReorder.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.LongContextReorder.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.LongContextReorder.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.LongContextReorder.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.LongContextReorder.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.LongLLMLinguaPostprocessor[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor "Permalink to this definition")Optimization of nodes.

Compress using LongLLMLingua paper.

Show JSON schema
```
{ "title": "LongLLMLinguaPostprocessor", "description": "Optimization of nodes.\n\nCompress using LongLLMLingua paper.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "metadata\_mode": { "description": "Metadata mode.", "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "instruction\_str": { "title": "Instruction Str", "description": "Instruction string.", "default": "Given the context, please answer the final question", "type": "string" }, "target\_token": { "title": "Target Token", "description": "Target number of compressed tokens.", "default": 300, "type": "integer" }, "rank\_method": { "title": "Rank Method", "description": "Ranking method.", "default": "longllmlingua", "type": "string" }, "additional\_compress\_kwargs": { "title": "Additional Compress Kwargs", "description": "Additional compress kwargs.", "type": "object" } }, "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `additional\_compress\_kwargs (Dict[str, Any])`
* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `instruction\_str (str)`
* `metadata\_mode (llama\_index.schema.MetadataMode)`
* `rank\_method (str)`
* `target\_token (int)`
*field* additional\_compress\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.additional_compress_kwargs "Permalink to this definition")Additional compress kwargs.

*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.callback_manager "Permalink to this definition")*field* instruction\_str*: str* *= 'Given the context, please answer the final question'*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.instruction_str "Permalink to this definition")Instruction string.

*field* metadata\_mode*: [MetadataMode](node.html#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode")* *= MetadataMode.ALL*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.metadata_mode "Permalink to this definition")Metadata mode.

*field* rank\_method*: str* *= 'longllmlingua'*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.rank_method "Permalink to this definition")Ranking method.

*field* target\_token*: int* *= 300*[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.target_token "Permalink to this definition")Target number of compressed tokens.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.LongLLMLinguaPostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.MetadataReplacementPostProcessor[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor "Permalink to this definition")Show JSON schema
```
{ "title": "MetadataReplacementPostProcessor", "description": "Base component object to capture class names.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "target\_metadata\_key": { "title": "Target Metadata Key", "description": "Target metadata key to replace node content with.", "type": "string" } }, "required": [ "target\_metadata\_key" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `target\_metadata\_key (str)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.callback_manager "Permalink to this definition")*field* target\_metadata\_key*: str* *[Required]*[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.target_metadata_key "Permalink to this definition")Target metadata key to replace node content with.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.MetadataReplacementPostProcessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.NERPIINodePostprocessor[](#llama_index.indices.postprocessor.NERPIINodePostprocessor "Permalink to this definition")NER PII Node processor.

Uses a HF transformers model.

Show JSON schema
```
{ "title": "NERPIINodePostprocessor", "description": "NER PII Node processor.\n\nUses a HF transformers model.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "pii\_node\_info\_key": { "title": "Pii Node Info Key", "default": "\_\_pii\_node\_info\_\_", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `pii\_node\_info\_key (str)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.callback_manager "Permalink to this definition")*field* pii\_node\_info\_key*: str* *= '\_\_pii\_node\_info\_\_'*[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.pii_node_info_key "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

mask\_pii(*ner: Callable*, *text: str*) → Tuple[str, Dict][](#llama_index.indices.postprocessor.NERPIINodePostprocessor.mask_pii "Permalink to this definition")Mask PII in text.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.NERPIINodePostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.NERPIINodePostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.NERPIINodePostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.PIINodePostprocessor[](#llama_index.indices.postprocessor.PIINodePostprocessor "Permalink to this definition")PII Node processor.

NOTE: the ServiceContext should contain a LOCAL model, not an external API.

NOTE: this is a beta feature, the API might change.

Parameters**service\_context** ([*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")) – Service context.

Show JSON schema
```
{ "title": "PIINodePostprocessor", "description": "PII Node processor.\n\nNOTE: the ServiceContext should contain a LOCAL model, not an external API.\n\nNOTE: this is a beta feature, the API might change.\n\nArgs:\n service\_context (ServiceContext): Service context.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "service\_context": { "title": "Service Context" }, "pii\_str\_tmpl": { "title": "Pii Str Tmpl", "default": "The current context information is provided. \nA task is also provided to mask the PII within the context. \nReturn the text, with all PII masked out, and a mapping of the original PII to the masked PII. \nReturn the output of the task in JSON. \nContext:\nHello Zhang Wei, I am John. Your AnyCompany Financial Services, LLC credit card account 1111-0000-1111-0008 has a minimum payment of $24.53 that is due by July 31st. Based on your autopay settings, we will withdraw your payment. Task: Mask out the PII, replace each PII with a tag, and return the text. Return the mapping in JSON. \nOutput: \nHello [NAME1], I am [NAME2]. Your AnyCompany Financial Services, LLC credit card account [CREDIT\_CARD\_NUMBER] has a minimum payment of $24.53 that is due by [DATE\_TIME]. Based on your autopay settings, we will withdraw your payment. Output Mapping:\n{{\"NAME1\": \"Zhang Wei\", \"NAME2\": \"John\", \"CREDIT\_CARD\_NUMBER\": \"1111-0000-1111-0008\", \"DATE\_TIME\": \"July 31st\"}}\nContext:\n{context\_str}\nTask: {query\_str}\nOutput: \n", "type": "string" }, "pii\_node\_info\_key": { "title": "Pii Node Info Key", "default": "\_\_pii\_node\_info\_\_", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `pii\_node\_info\_key (str)`
* `pii\_str\_tmpl (str)`
* `service\_context (llama\_index.indices.service\_context.ServiceContext)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.PIINodePostprocessor.callback_manager "Permalink to this definition")*field* pii\_node\_info\_key*: str* *= '\_\_pii\_node\_info\_\_'*[](#llama_index.indices.postprocessor.PIINodePostprocessor.pii_node_info_key "Permalink to this definition")*field* pii\_str\_tmpl*: str* *= 'The current context information is provided. \nA task is also provided to mask the PII within the context. \nReturn the text, with all PII masked out, and a mapping of the original PII to the masked PII. \nReturn the output of the task in JSON. \nContext:\nHello Zhang Wei, I am John. Your AnyCompany Financial Services, LLC credit card account 1111-0000-1111-0008 has a minimum payment of $24.53 that is due by July 31st. Based on your autopay settings, we will withdraw your payment. Task: Mask out the PII, replace each PII with a tag, and return the text. Return the mapping in JSON. \nOutput: \nHello [NAME1], I am [NAME2]. Your AnyCompany Financial Services, LLC credit card account [CREDIT\_CARD\_NUMBER] has a minimum payment of $24.53 that is due by [DATE\_TIME]. Based on your autopay settings, we will withdraw your payment. Output Mapping:\n{{"NAME1": "Zhang Wei", "NAME2": "John", "CREDIT\_CARD\_NUMBER": "1111-0000-1111-0008", "DATE\_TIME": "July 31st"}}\nContext:\n{context\_str}\nTask: {query\_str}\nOutput: \n'*[](#llama_index.indices.postprocessor.PIINodePostprocessor.pii_str_tmpl "Permalink to this definition")*field* service\_context*: [ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")* *[Required]*[](#llama_index.indices.postprocessor.PIINodePostprocessor.service_context "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.PIINodePostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.PIINodePostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.PIINodePostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.PIINodePostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.PIINodePostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

mask\_pii(*text: str*) → Tuple[str, Dict][](#llama_index.indices.postprocessor.PIINodePostprocessor.mask_pii "Permalink to this definition")Mask PII in text.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.PIINodePostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.PIINodePostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.PIINodePostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.PIINodePostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.PIINodePostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.PIINodePostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.PIINodePostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.PrevNextNodePostprocessor[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor "Permalink to this definition")Previous/Next Node post-processor.

Allows users to fetch additional nodes from the document store,based on the relationships of the nodes.

NOTE: this is a beta feature.

Parameters* **docstore** ([*BaseDocumentStore*](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.BaseDocumentStore")) – The document store.
* **num\_nodes** (*int*) – The number of nodes to return (default: 1)
* **mode** (*str*) – The mode of the post-processor.Can be “previous”, “next”, or “both.
Show JSON schema
```
{ "title": "PrevNextNodePostprocessor", "description": "Previous/Next Node post-processor.\n\nAllows users to fetch additional nodes from the document store,\nbased on the relationships of the nodes.\n\nNOTE: this is a beta feature.\n\nArgs:\n docstore (BaseDocumentStore): The document store.\n num\_nodes (int): The number of nodes to return (default: 1)\n mode (str): The mode of the post-processor.\n Can be \"previous\", \"next\", or \"both.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "docstore": { "title": "Docstore" }, "num\_nodes": { "title": "Num Nodes", "default": 1, "type": "integer" }, "mode": { "title": "Mode", "default": "next", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `docstore (llama\_index.storage.docstore.types.BaseDocumentStore)`
* `mode (str)`
* `num\_nodes (int)`
Validators* `\_validate\_mode` » `mode`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.callback_manager "Permalink to this definition")*field* docstore*: [BaseDocumentStore](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")* *[Required]*[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.docstore "Permalink to this definition")*field* mode*: str* *= 'next'*[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.mode "Permalink to this definition")Validated by* `\_validate\_mode`
*field* num\_nodes*: int* *= 1*[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.num_nodes "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.PrevNextNodePostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.SentenceEmbeddingOptimizer[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer "Permalink to this definition")Optimization of a text chunk given the query by shortening the input text.

Show JSON schema
```
{ "title": "SentenceEmbeddingOptimizer", "description": "Optimization of a text chunk given the query by shortening the input text.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "percentile\_cutoff": { "title": "Percentile Cutoff", "description": "Percentile cutoff for the top k sentences to use.", "type": "number" }, "threshold\_cutoff": { "title": "Threshold Cutoff", "description": "Threshold cutoff for similarity for each sentence to use.", "type": "number" }, "context\_before": { "title": "Context Before", "description": "Number of sentences before retrieved sentence for further context", "type": "integer" }, "context\_after": { "title": "Context After", "description": "Number of sentences after retrieved sentence for further context", "type": "integer" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `context\_after (Optional[int])`
* `context\_before (Optional[int])`
* `percentile\_cutoff (Optional[float])`
* `threshold\_cutoff (Optional[float])`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.callback_manager "Permalink to this definition")*field* context\_after*: Optional[int]* *= None*[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.context_after "Permalink to this definition")Number of sentences after retrieved sentence for further context

*field* context\_before*: Optional[int]* *= None*[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.context_before "Permalink to this definition")Number of sentences before retrieved sentence for further context

*field* percentile\_cutoff*: Optional[float]* *= None*[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.percentile_cutoff "Permalink to this definition")Percentile cutoff for the top k sentences to use.

*field* threshold\_cutoff*: Optional[float]* *= None*[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.threshold_cutoff "Permalink to this definition")Threshold cutoff for similarity for each sentence to use.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.SentenceEmbeddingOptimizer.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.SentenceTransformerRerank[](#llama_index.indices.postprocessor.SentenceTransformerRerank "Permalink to this definition")Show JSON schema
```
{ "title": "SentenceTransformerRerank", "description": "Base component object to capture class names.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "ddescription": "Sentence transformer model name.", "type": "string" }, "top\_n": { "title": "Top N", "description": "Number of nodes to return sorted by score.", "type": "integer" } }, "required": [ "model", "top\_n" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `model (str)`
* `top\_n (int)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.SentenceTransformerRerank.callback_manager "Permalink to this definition")*field* model*: str* *[Required]*[](#llama_index.indices.postprocessor.SentenceTransformerRerank.model "Permalink to this definition")*field* top\_n*: int* *[Required]*[](#llama_index.indices.postprocessor.SentenceTransformerRerank.top_n "Permalink to this definition")Number of nodes to return sorted by score.

*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.SentenceTransformerRerank.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.SentenceTransformerRerank.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SentenceTransformerRerank.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SentenceTransformerRerank.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SentenceTransformerRerank.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.SentenceTransformerRerank.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.SentenceTransformerRerank.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SentenceTransformerRerank.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.SentenceTransformerRerank.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.SentenceTransformerRerank.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.SentenceTransformerRerank.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.SentenceTransformerRerank.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.SimilarityPostprocessor[](#llama_index.indices.postprocessor.SimilarityPostprocessor "Permalink to this definition")Similarity-based Node processor.

Show JSON schema
```
{ "title": "SimilarityPostprocessor", "description": "Similarity-based Node processor.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "similarity\_cutoff": { "title": "Similarity Cutoff", "type": "number" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `similarity\_cutoff (float)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.SimilarityPostprocessor.callback_manager "Permalink to this definition")*field* similarity\_cutoff*: float* *= None*[](#llama_index.indices.postprocessor.SimilarityPostprocessor.similarity_cutoff "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.SimilarityPostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.SimilarityPostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SimilarityPostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.SimilarityPostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SimilarityPostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.SimilarityPostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.SimilarityPostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.SimilarityPostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.SimilarityPostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.SimilarityPostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.SimilarityPostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.SimilarityPostprocessor.validate "Permalink to this definition")*pydantic model* llama\_index.indices.postprocessor.TimeWeightedPostprocessor[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor "Permalink to this definition")Time-weighted post-processor.

Reranks a set of nodes based on their recency.

Show JSON schema
```
{ "title": "TimeWeightedPostprocessor", "description": "Time-weighted post-processor.\n\nReranks a set of nodes based on their recency.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "time\_decay": { "title": "Time Decay", "default": 0.99, "type": "number" }, "last\_accessed\_key": { "title": "Last Accessed Key", "default": "\_\_last\_accessed\_\_", "type": "string" }, "time\_access\_refresh": { "title": "Time Access Refresh", "default": true, "type": "boolean" }, "now": { "title": "Now", "type": "number" }, "top\_k": { "title": "Top K", "default": 1, "type": "integer" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `last\_accessed\_key (str)`
* `now (Optional[float])`
* `time\_access\_refresh (bool)`
* `time\_decay (float)`
* `top\_k (int)`
*field* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")* *[Optional]*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.callback_manager "Permalink to this definition")*field* last\_accessed\_key*: str* *= '\_\_last\_accessed\_\_'*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.last_accessed_key "Permalink to this definition")*field* now*: Optional[float]* *= None*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.now "Permalink to this definition")*field* time\_access\_refresh*: bool* *= True*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.time_access_refresh "Permalink to this definition")*field* time\_decay*: float* *= 0.99*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.time_decay "Permalink to this definition")*field* top\_k*: int* *= 1*[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.top_k "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.parse_raw "Permalink to this definition")postprocess\_nodes(*nodes: List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")]*, *query\_bundle: Optional[[QueryBundle](query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")] = None*, *query\_str: Optional[str] = None*) → List[[NodeWithScore](node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.postprocess_nodes "Permalink to this definition")Postprocess nodes.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.postprocessor.TimeWeightedPostprocessor.validate "Permalink to this definition")