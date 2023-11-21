LLM Predictors[](#module-llama_index.llm_predictor "Permalink to this heading")
================================================================================

Init params.

*pydantic model* llama\_index.llm\_predictor.LLMPredictor[](#llama_index.llm_predictor.LLMPredictor "Permalink to this definition")LLM predictor class.

A lightweight wrapper on top of LLMs that handles:- conversion of prompts to the string input format expected by LLMs- logging of prompts and responses to a callback manager

NOTE: Mostly keeping around for legacy reasons. A potential future path is todeprecate this class and move all functionality into the LLM class.

Show JSON schema
```
{ "title": "LLMPredictor", "description": "LLM predictor class.\n\nA lightweight wrapper on top of LLMs that handles:\n- conversion of prompts to the string input format expected by LLMs\n- logging of prompts and responses to a callback manager\n\nNOTE: Mostly keeping around for legacy reasons. A potential future path is to\ndeprecate this class and move all functionality into the LLM class.", "type": "object", "properties": { "system\_prompt": { "title": "System Prompt", "type": "string" }, "query\_wrapper\_prompt": { "title": "Query Wrapper Prompt" }, "pydantic\_program\_mode": { "default": "default", "allOf": [ { "$ref": "#/definitions/PydanticProgramMode" } ] } }, "definitions": { "PydanticProgramMode": { "title": "PydanticProgramMode", "description": "Pydantic program mode.", "enum": [ "default", "openai", "llm", "guidance", "lm-format-enforcer" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `pydantic\_program\_mode (llama\_index.types.PydanticProgramMode)`
* `query\_wrapper\_prompt (Optional[llama\_index.prompts.base.BasePromptTemplate])`
* `system\_prompt (Optional[str])`
*field* pydantic\_program\_mode*: PydanticProgramMode* *= PydanticProgramMode.DEFAULT*[](#llama_index.llm_predictor.LLMPredictor.pydantic_program_mode "Permalink to this definition")*field* query\_wrapper\_prompt*: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]* *= None*[](#llama_index.llm_predictor.LLMPredictor.query_wrapper_prompt "Permalink to this definition")*field* system\_prompt*: Optional[str]* *= None*[](#llama_index.llm_predictor.LLMPredictor.system_prompt "Permalink to this definition")*async* apredict(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[BaseModel] = None*, *\*\*prompt\_args: Any*) → str[](#llama_index.llm_predictor.LLMPredictor.apredict "Permalink to this definition")Async predict.

*async* astream(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[BaseModel] = None*, *\*\*prompt\_args: Any*) → AsyncGenerator[str, None][](#llama_index.llm_predictor.LLMPredictor.astream "Permalink to this definition")Async stream.

*classmethod* class\_name() → str[](#llama_index.llm_predictor.LLMPredictor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.llm_predictor.LLMPredictor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.llm_predictor.LLMPredictor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.llm_predictor.LLMPredictor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.llm_predictor.LLMPredictor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.llm_predictor.LLMPredictor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.llm_predictor.LLMPredictor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.llm_predictor.LLMPredictor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.llm_predictor.LLMPredictor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.llm_predictor.LLMPredictor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.llm_predictor.LLMPredictor.parse_raw "Permalink to this definition")predict(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[BaseModel] = None*, *\*\*prompt\_args: Any*) → str[](#llama_index.llm_predictor.LLMPredictor.predict "Permalink to this definition")Predict.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.llm_predictor.LLMPredictor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.llm_predictor.LLMPredictor.schema_json "Permalink to this definition")stream(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[BaseModel] = None*, *\*\*prompt\_args: Any*) → Generator[str, None, None][](#llama_index.llm_predictor.LLMPredictor.stream "Permalink to this definition")Stream.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.llm_predictor.LLMPredictor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.llm_predictor.LLMPredictor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.llm_predictor.LLMPredictor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.llm_predictor.LLMPredictor.validate "Permalink to this definition")*property* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")*[](#llama_index.llm_predictor.LLMPredictor.callback_manager "Permalink to this definition")Get callback manager.

*property* llm*: [LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")*[](#llama_index.llm_predictor.LLMPredictor.llm "Permalink to this definition")Get LLM.

*property* metadata*: [LLMMetadata](llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llm_predictor.LLMPredictor.metadata "Permalink to this definition")Get LLM metadata.

*pydantic model* llama\_index.llm\_predictor.StructuredLLMPredictor[](#llama_index.llm_predictor.StructuredLLMPredictor "Permalink to this definition")Structured LLM predictor class.

Parameters**llm\_predictor** (*BaseLLMPredictor*) – LLM Predictor to use.

Show JSON schema
```
{ "title": "StructuredLLMPredictor", "description": "Structured LLM predictor class.\n\nArgs:\n llm\_predictor (BaseLLMPredictor): LLM Predictor to use.", "type": "object", "properties": { "system\_prompt": { "title": "System Prompt", "type": "string" }, "query\_wrapper\_prompt": { "title": "Query Wrapper Prompt" }, "pydantic\_program\_mode": { "default": "default", "allOf": [ { "$ref": "#/definitions/PydanticProgramMode" } ] } }, "definitions": { "PydanticProgramMode": { "title": "PydanticProgramMode", "description": "Pydantic program mode.", "enum": [ "default", "openai", "llm", "guidance", "lm-format-enforcer" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `pydantic\_program\_mode (llama\_index.types.PydanticProgramMode)`
* `query\_wrapper\_prompt (Optional[llama\_index.prompts.base.BasePromptTemplate])`
* `system\_prompt (Optional[str])`
*field* pydantic\_program\_mode*: PydanticProgramMode* *= PydanticProgramMode.DEFAULT*[](#llama_index.llm_predictor.StructuredLLMPredictor.pydantic_program_mode "Permalink to this definition")*field* query\_wrapper\_prompt*: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]* *= None*[](#llama_index.llm_predictor.StructuredLLMPredictor.query_wrapper_prompt "Permalink to this definition")*field* system\_prompt*: Optional[str]* *= None*[](#llama_index.llm_predictor.StructuredLLMPredictor.system_prompt "Permalink to this definition")*async* apredict(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[Any] = None*, *\*\*prompt\_args: Any*) → str[](#llama_index.llm_predictor.StructuredLLMPredictor.apredict "Permalink to this definition")Async predict the answer to a query.

Parameters**prompt** ([*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – BasePromptTemplate to use for prediction.

ReturnsTuple of the predicted answer and the formatted prompt.

Return typeTuple[str, str]

*async* astream(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[BaseModel] = None*, *\*\*prompt\_args: Any*) → AsyncGenerator[str, None][](#llama_index.llm_predictor.StructuredLLMPredictor.astream "Permalink to this definition")Async stream.

*classmethod* class\_name() → str[](#llama_index.llm_predictor.StructuredLLMPredictor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.llm_predictor.StructuredLLMPredictor.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.llm_predictor.StructuredLLMPredictor.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.llm_predictor.StructuredLLMPredictor.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.llm_predictor.StructuredLLMPredictor.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.parse_raw "Permalink to this definition")predict(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[Any] = None*, *\*\*prompt\_args: Any*) → str[](#llama_index.llm_predictor.StructuredLLMPredictor.predict "Permalink to this definition")Predict the answer to a query.

Parameters**prompt** ([*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – BasePromptTemplate to use for prediction.

ReturnsTuple of the predicted answer and the formatted prompt.

Return typeTuple[str, str]

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.llm_predictor.StructuredLLMPredictor.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.llm_predictor.StructuredLLMPredictor.schema_json "Permalink to this definition")stream(*prompt: [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *output\_cls: Optional[Any] = None*, *\*\*prompt\_args: Any*) → Generator[str, None, None][](#llama_index.llm_predictor.StructuredLLMPredictor.stream "Permalink to this definition")Stream the answer to a query.

NOTE: this is a beta feature. Will try to build or usebetter abstractions about response handling.

Parameters**prompt** ([*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – BasePromptTemplate to use for prediction.

ReturnsThe predicted answer.

Return typestr

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.llm_predictor.StructuredLLMPredictor.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.llm_predictor.StructuredLLMPredictor.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.llm_predictor.StructuredLLMPredictor.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.llm_predictor.StructuredLLMPredictor.validate "Permalink to this definition")*property* callback\_manager*: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")*[](#llama_index.llm_predictor.StructuredLLMPredictor.callback_manager "Permalink to this definition")Get callback manager.

*property* llm*: [LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")*[](#llama_index.llm_predictor.StructuredLLMPredictor.llm "Permalink to this definition")Get LLM.

*property* metadata*: [LLMMetadata](llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llm_predictor.StructuredLLMPredictor.metadata "Permalink to this definition")Get LLM metadata.

