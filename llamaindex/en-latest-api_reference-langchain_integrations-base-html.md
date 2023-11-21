Langchain Integrations[](#langchain-integrations "Permalink to this heading")
==============================================================================

Agent Tools + Functions

Llama integration with Langchain agents.

*pydantic model* llama\_index.langchain\_helpers.agents.IndexToolConfig[](#llama_index.langchain_helpers.agents.IndexToolConfig "Permalink to this definition")Configuration for LlamaIndex index tool.

Show JSON schema
```
{ "title": "IndexToolConfig", "description": "Configuration for LlamaIndex index tool.", "type": "object", "properties": { "query\_engine": { "title": "Query Engine" }, "name": { "title": "Name", "type": "string" }, "description": { "title": "Description", "type": "string" }, "tool\_kwargs": { "title": "Tool Kwargs", "type": "object" } }, "required": [ "name", "description" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `description (str)`
* `name (str)`
* `query\_engine (llama\_index.indices.query.base.BaseQueryEngine)`
* `tool\_kwargs (Dict)`
*field* description*: str* *[Required]*[](#llama_index.langchain_helpers.agents.IndexToolConfig.description "Permalink to this definition")*field* name*: str* *[Required]*[](#llama_index.langchain_helpers.agents.IndexToolConfig.name "Permalink to this definition")*field* query\_engine*: BaseQueryEngine* *[Required]*[](#llama_index.langchain_helpers.agents.IndexToolConfig.query_engine "Permalink to this definition")*field* tool\_kwargs*: Dict* *[Optional]*[](#llama_index.langchain_helpers.agents.IndexToolConfig.tool_kwargs "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.langchain_helpers.agents.IndexToolConfig.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.IndexToolConfig.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.langchain_helpers.agents.IndexToolConfig.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.IndexToolConfig.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.langchain_helpers.agents.IndexToolConfig.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.langchain_helpers.agents.IndexToolConfig.validate "Permalink to this definition")*pydantic model* llama\_index.langchain\_helpers.agents.LlamaIndexTool[](#llama_index.langchain_helpers.agents.LlamaIndexTool "Permalink to this definition")Tool for querying a LlamaIndex.

Show JSON schema
```
{ "title": "LlamaIndexTool", "description": "Tool for querying a LlamaIndex.", "type": "object", "properties": { "name": { "title": "Name", "type": "string" }, "description": { "title": "Description", "type": "string" }, "args\_schema": { "title": "Args Schema" }, "return\_direct": { "title": "Return Direct", "default": false, "type": "boolean" }, "verbose": { "title": "Verbose", "default": false, "type": "boolean" }, "callbacks": { "title": "Callbacks" }, "callback\_manager": { "title": "Callback Manager" }, "tags": { "title": "Tags", "type": "array", "items": { "type": "string" } }, "metadata": { "title": "Metadata", "type": "object" }, "query\_engine": { "title": "Query Engine" }, "return\_sources": { "title": "Return Sources", "default": false, "type": "boolean" } }, "required": [ "name", "description" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
* **extra**: *str = ignore*
Fields* `args\_schema (Optional[Type[pydantic.main.BaseModel]])`
* `callback\_manager (Optional[langchain.callbacks.base.BaseCallbackManager])`
* `callbacks (Optional[Union[List[langchain.callbacks.base.BaseCallbackHandler], langchain.callbacks.base.BaseCallbackManager]])`
* `description (str)`
* `handle\_tool\_error (Optional[Union[bool, str, Callable[[langchain.tools.base.ToolException], str]]])`
* `metadata (Optional[Dict[str, Any]])`
* `name (str)`
* `query\_engine (llama\_index.indices.query.base.BaseQueryEngine)`
* `return\_direct (bool)`
* `return\_sources (bool)`
* `tags (Optional[List[str]])`
* `verbose (bool)`
*field* args\_schema*: Optional[Type[BaseModel]]* *= None*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.args_schema "Permalink to this definition")Pydantic model class to validate and parse the tool’s input arguments.

Validated by* `raise\_deprecation`
*field* callback\_manager*: Optional[BaseCallbackManager]* *= None*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.callback_manager "Permalink to this definition")Deprecated. Please use callbacks instead.

Validated by* `raise\_deprecation`
*field* callbacks*: Callbacks* *= None*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.callbacks "Permalink to this definition")Callbacks to be called during tool execution.

Validated by* `raise\_deprecation`
*field* description*: str* *[Required]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.description "Permalink to this definition")Used to tell the model how/when/why to use the tool.

You can provide few-shot examples as a part of the description.

Validated by* `raise\_deprecation`
*field* handle\_tool\_error*: Optional[Union[bool, str, Callable[[ToolException], str]]]* *= False*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.handle_tool_error "Permalink to this definition")Handle the content of the ToolException thrown.

Validated by* `raise\_deprecation`
*field* metadata*: Optional[Dict[str, Any]]* *= None*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.metadata "Permalink to this definition")Optional metadata associated with the tool. Defaults to NoneThis metadata will be associated with each call to this tool,and passed as arguments to the handlers defined in callbacks.You can use these to eg identify a specific instance of a tool with its use case.

Validated by* `raise\_deprecation`
*field* name*: str* *[Required]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.name "Permalink to this definition")The unique name of the tool that clearly communicates its purpose.

Validated by* `raise\_deprecation`
*field* query\_engine*: BaseQueryEngine* *[Required]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.query_engine "Permalink to this definition")Validated by* `raise\_deprecation`
*field* return\_direct*: bool* *= False*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.return_direct "Permalink to this definition")Whether to return the tool’s output directly. Setting this to True means

that after the tool is called, the AgentExecutor will stop looping.

Validated by* `raise\_deprecation`
*field* return\_sources*: bool* *= False*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.return_sources "Permalink to this definition")Validated by* `raise\_deprecation`
*field* tags*: Optional[List[str]]* *= None*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.tags "Permalink to this definition")Optional list of tags associated with the tool. Defaults to NoneThese tags will be associated with each call to this tool,and passed as arguments to the handlers defined in callbacks.You can use these to eg identify a specific instance of a tool with its use case.

Validated by* `raise\_deprecation`
*field* verbose*: bool* *= False*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.verbose "Permalink to this definition")Whether to log the tool’s progress.

Validated by* `raise\_deprecation`
*async* abatch(*inputs: List[Input]*, *config: Optional[Union[RunnableConfig, List[RunnableConfig]]] = None*, *\**, *return\_exceptions: bool = False*, *\*\*kwargs: Optional[Any]*) → List[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.abatch "Permalink to this definition")Default implementation of abatch, which calls ainvoke N times.Subclasses should override this method if they can batch more efficiently.

*async* ainvoke(*input: Union[str, Dict]*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Any*) → Any[](#llama_index.langchain_helpers.agents.LlamaIndexTool.ainvoke "Permalink to this definition")Default implementation of ainvoke, which calls invoke in a thread pool.Subclasses should override this method if they can run asynchronously.

*async* arun(*tool\_input: Union[str, Dict]*, *verbose: Optional[bool] = None*, *start\_color: Optional[str] = 'green'*, *color: Optional[str] = 'green'*, *callbacks: Optional[Union[List[BaseCallbackHandler], BaseCallbackManager]] = None*, *\**, *tags: Optional[List[str]] = None*, *metadata: Optional[Dict[str, Any]] = None*, *run\_name: Optional[str] = None*, *\*\*kwargs: Any*) → Any[](#llama_index.langchain_helpers.agents.LlamaIndexTool.arun "Permalink to this definition")Run the tool asynchronously.

*async* astream(*input: Input*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Optional[Any]*) → AsyncIterator[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.astream "Permalink to this definition")Default implementation of astream, which calls ainvoke.Subclasses should override this method if they support streaming output.

*async* astream\_log(*input: Any*, *config: Optional[RunnableConfig] = None*, *\**, *diff: bool = True*, *include\_names: Optional[Sequence[str]] = None*, *include\_types: Optional[Sequence[str]] = None*, *include\_tags: Optional[Sequence[str]] = None*, *exclude\_names: Optional[Sequence[str]] = None*, *exclude\_types: Optional[Sequence[str]] = None*, *exclude\_tags: Optional[Sequence[str]] = None*, *\*\*kwargs: Optional[Any]*) → Union[AsyncIterator[RunLogPatch], AsyncIterator[RunLog]][](#llama_index.langchain_helpers.agents.LlamaIndexTool.astream_log "Permalink to this definition")Stream all output from a runnable, as reported to the callback system.This includes all inner runs of LLMs, Retrievers, Tools, etc.

Output is streamed as Log objects, which include a list ofjsonpatch ops that describe how the state of the run has changed in eachstep, and the final state of the run.

The jsonpatch ops can be applied in order to construct state.

*async* atransform(*input: AsyncIterator[Input]*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Optional[Any]*) → AsyncIterator[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.atransform "Permalink to this definition")Default implementation of atransform, which buffers input and calls astream.Subclasses should override this method if they can start producing output whileinput is still being generated.

batch(*inputs: List[Input]*, *config: Optional[Union[RunnableConfig, List[RunnableConfig]]] = None*, *\**, *return\_exceptions: bool = False*, *\*\*kwargs: Optional[Any]*) → List[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.batch "Permalink to this definition")Default implementation of batch, which calls invoke N times.Subclasses should override this method if they can batch more efficiently.

bind(*\*\*kwargs: Any*) → Runnable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.bind "Permalink to this definition")Bind arguments to a Runnable, returning a new Runnable.

config\_schema(*\**, *include: Optional[Sequence[str]] = None*) → Type[BaseModel][](#llama_index.langchain_helpers.agents.LlamaIndexTool.config_schema "Permalink to this definition")The type of config this runnable accepts specified as a pydantic model.

To mark a field as configurable, see the configurable\_fieldsand configurable\_alternatives methods.

Parameters**include** – A list of fields to include in the config schema.

ReturnsA pydantic model that can be used to validate config.

configurable\_alternatives(*which: ConfigurableField*, *default\_key: str = 'default'*, *\*\*kwargs: Union[Runnable[Input, Output], Callable[[], Runnable[Input, Output]]]*) → RunnableSerializable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.configurable_alternatives "Permalink to this definition")configurable\_fields(*\*\*kwargs: Union[ConfigurableField, ConfigurableFieldSingleOption, ConfigurableFieldMultiOption]*) → RunnableSerializable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.configurable_fields "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.langchain_helpers.agents.LlamaIndexTool.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.from_orm "Permalink to this definition")*classmethod* from\_tool\_config(*tool\_config: [IndexToolConfig](#llama_index.langchain_helpers.agents.IndexToolConfig "llama_index.langchain_helpers.agents.tools.IndexToolConfig")*) → [LlamaIndexTool](#llama_index.langchain_helpers.agents.LlamaIndexTool "llama_index.langchain_helpers.agents.tools.LlamaIndexTool")[](#llama_index.langchain_helpers.agents.LlamaIndexTool.from_tool_config "Permalink to this definition")Create a tool from a tool config.

get\_input\_schema(*config: Optional[RunnableConfig] = None*) → Type[BaseModel][](#llama_index.langchain_helpers.agents.LlamaIndexTool.get_input_schema "Permalink to this definition")The tool’s input schema.

*classmethod* get\_lc\_namespace() → List[str][](#llama_index.langchain_helpers.agents.LlamaIndexTool.get_lc_namespace "Permalink to this definition")Get the namespace of the langchain object.

For example, if the class is langchain.llms.openai.OpenAI, then thenamespace is [“langchain”, “llms”, “openai”]

get\_output\_schema(*config: Optional[RunnableConfig] = None*) → Type[BaseModel][](#llama_index.langchain_helpers.agents.LlamaIndexTool.get_output_schema "Permalink to this definition")The type of output this runnable produces specified as a pydantic model.

invoke(*input: Union[str, Dict]*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Any*) → Any[](#llama_index.langchain_helpers.agents.LlamaIndexTool.invoke "Permalink to this definition")Transform a single input into an output. Override to implement.

*classmethod* is\_lc\_serializable() → bool[](#llama_index.langchain_helpers.agents.LlamaIndexTool.is_lc_serializable "Permalink to this definition")Is this class serializable?

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.LlamaIndexTool.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* lc\_id() → List[str][](#llama_index.langchain_helpers.agents.LlamaIndexTool.lc_id "Permalink to this definition")A unique identifier for this class for serialization purposes.

The unique identifier is a list of strings that describes the pathto the object.

map() → Runnable[List[Input], List[Output]][](#llama_index.langchain_helpers.agents.LlamaIndexTool.map "Permalink to this definition")Return a new Runnable that maps a list of inputs to a list of outputs,by calling invoke() with each input.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.parse_raw "Permalink to this definition")*validator* raise\_deprecation*»* *all fields*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.raise_deprecation "Permalink to this definition")Raise deprecation warning if callback\_manager is used.

run(*tool\_input: Union[str, Dict]*, *verbose: Optional[bool] = None*, *start\_color: Optional[str] = 'green'*, *color: Optional[str] = 'green'*, *callbacks: Optional[Union[List[BaseCallbackHandler], BaseCallbackManager]] = None*, *\**, *tags: Optional[List[str]] = None*, *metadata: Optional[Dict[str, Any]] = None*, *run\_name: Optional[str] = None*, *\*\*kwargs: Any*) → Any[](#llama_index.langchain_helpers.agents.LlamaIndexTool.run "Permalink to this definition")Run the tool.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.langchain_helpers.agents.LlamaIndexTool.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.LlamaIndexTool.schema_json "Permalink to this definition")stream(*input: Input*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Optional[Any]*) → Iterator[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.stream "Permalink to this definition")Default implementation of stream, which calls invoke.Subclasses should override this method if they support streaming output.

to\_json() → Union[SerializedConstructor, SerializedNotImplemented][](#llama_index.langchain_helpers.agents.LlamaIndexTool.to_json "Permalink to this definition")to\_json\_not\_implemented() → SerializedNotImplemented[](#llama_index.langchain_helpers.agents.LlamaIndexTool.to_json_not_implemented "Permalink to this definition")transform(*input: Iterator[Input]*, *config: Optional[RunnableConfig] = None*, *\*\*kwargs: Optional[Any]*) → Iterator[Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.transform "Permalink to this definition")Default implementation of transform, which buffers input and then calls stream.Subclasses should override this method if they can start producing output whileinput is still being generated.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.langchain_helpers.agents.LlamaIndexTool.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaIndexTool.validate "Permalink to this definition")with\_config(*config: Optional[RunnableConfig] = None*, *\*\*kwargs: Any*) → Runnable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.with_config "Permalink to this definition")Bind config to a Runnable, returning a new Runnable.

with\_fallbacks(*fallbacks: Sequence[Runnable[Input, Output]], \*, exceptions\_to\_handle: Tuple[Type[BaseException], ...] = (<class 'Exception'>,)*) → RunnableWithFallbacksT[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.with_fallbacks "Permalink to this definition")with\_listeners(*\**, *on\_start: Optional[Listener] = None*, *on\_end: Optional[Listener] = None*, *on\_error: Optional[Listener] = None*) → Runnable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.with_listeners "Permalink to this definition")Bind lifecycle listeners to a Runnable, returning a new Runnable.

on\_start: Called before the runnable starts running, with the Run object.on\_end: Called after the runnable finishes running, with the Run object.on\_error: Called if the runnable throws an error, with the Run object.

The Run object contains information about the run, including its id,type, input, output, error, start\_time, end\_time, and any tags or metadataadded to the run.

with\_retry(*\*, retry\_if\_exception\_type: ~typing.Tuple[~typing.Type[BaseException], ...] = (<class 'Exception'>,), wait\_exponential\_jitter: bool = True, stop\_after\_attempt: int = 3*) → Runnable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.with_retry "Permalink to this definition")Create a new Runnable that retries the original runnable on exceptions.

Parameters* **retry\_if\_exception\_type** – A tuple of exception types to retry on
* **wait\_exponential\_jitter** – Whether to add jitter to the wait timebetween retries
* **stop\_after\_attempt** – The maximum number of attempts to make before giving up
ReturnsA new Runnable that retries the original runnable on exceptions.

with\_types(*\**, *input\_type: Optional[Type[Input]] = None*, *output\_type: Optional[Type[Output]] = None*) → Runnable[Input, Output][](#llama_index.langchain_helpers.agents.LlamaIndexTool.with_types "Permalink to this definition")Bind input and output types to a Runnable, returning a new Runnable.

*property* InputType*: Type[Input]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.InputType "Permalink to this definition")The type of input this runnable accepts specified as a type annotation.

*property* OutputType*: Type[Output]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.OutputType "Permalink to this definition")The type of output this runnable produces specified as a type annotation.

*property* args*: dict*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.args "Permalink to this definition")*property* config\_specs*: Sequence[ConfigurableFieldSpec]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.config_specs "Permalink to this definition")List configurable fields for this runnable.

*property* input\_schema*: Type[BaseModel]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.input_schema "Permalink to this definition")The type of input this runnable accepts specified as a pydantic model.

*property* is\_single\_input*: bool*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.is_single_input "Permalink to this definition")Whether the tool only accepts a single input.

*property* lc\_attributes*: Dict*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.lc_attributes "Permalink to this definition")List of attribute names that should be included in the serialized kwargs.

These attributes must be accepted by the constructor.

*property* lc\_secrets*: Dict[str, str]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.lc_secrets "Permalink to this definition")A map of constructor argument names to secret ids.

For example,{“openai\_api\_key”: “OPENAI\_API\_KEY”}

*property* output\_schema*: Type[BaseModel]*[](#llama_index.langchain_helpers.agents.LlamaIndexTool.output_schema "Permalink to this definition")The type of output this runnable produces specified as a pydantic model.

*pydantic model* llama\_index.langchain\_helpers.agents.LlamaToolkit[](#llama_index.langchain_helpers.agents.LlamaToolkit "Permalink to this definition")Toolkit for interacting with Llama indices.

Show JSON schema
```
{ "title": "LlamaToolkit", "description": "Toolkit for interacting with Llama indices.", "type": "object", "properties": { "index\_configs": { "title": "Index Configs" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `index\_configs (List[llama\_index.langchain\_helpers.agents.tools.IndexToolConfig])`
*field* index\_configs*: List[[IndexToolConfig](#llama_index.langchain_helpers.agents.IndexToolConfig "llama_index.langchain_helpers.agents.tools.IndexToolConfig")]* *[Optional]*[](#llama_index.langchain_helpers.agents.LlamaToolkit.index_configs "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.langchain_helpers.agents.LlamaToolkit.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.from_orm "Permalink to this definition")get\_tools() → List[BaseTool][](#llama_index.langchain_helpers.agents.LlamaToolkit.get_tools "Permalink to this definition")Get the tools in the toolkit.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.LlamaToolkit.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.langchain_helpers.agents.LlamaToolkit.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.agents.LlamaToolkit.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.langchain_helpers.agents.LlamaToolkit.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.langchain_helpers.agents.LlamaToolkit.validate "Permalink to this definition")llama\_index.langchain\_helpers.agents.create\_llama\_agent(*toolkit: [LlamaToolkit](#llama_index.langchain_helpers.agents.LlamaToolkit "llama_index.langchain_helpers.agents.toolkits.LlamaToolkit")*, *llm: BaseLLM*, *agent: Optional[AgentType] = None*, *callback\_manager: Optional[BaseCallbackManager] = None*, *agent\_path: Optional[str] = None*, *agent\_kwargs: Optional[dict] = None*, *\*\*kwargs: Any*) → AgentExecutor[](#llama_index.langchain_helpers.agents.create_llama_agent "Permalink to this definition")Load an agent executor given a Llama Toolkit and LLM.

NOTE: this is a light wrapper around initialize\_agent in langchain.

Parameters* **toolkit** – LlamaToolkit to use.
* **llm** – Language model to use as the agent.
* **agent** – A string that specified the agent type to use. Valid options are:zero-shot-react-descriptionreact-docstoreself-ask-with-searchconversational-react-descriptionchat-zero-shot-react-description,chat-conversational-react-description,

If None and agent\_path is also None, will default tozero-shot-react-description.
* **callback\_manager** – CallbackManager to use. Global callback manager is used ifnot provided. Defaults to None.
* **agent\_path** – Path to serialized agent to use.
* **agent\_kwargs** – Additional key word arguments to pass to the underlying agent
* **\*\*kwargs** – Additional key word arguments passed to the agent executor
ReturnsAn agent executor

llama\_index.langchain\_helpers.agents.create\_llama\_chat\_agent(*toolkit: [LlamaToolkit](#llama_index.langchain_helpers.agents.LlamaToolkit "llama_index.langchain_helpers.agents.toolkits.LlamaToolkit")*, *llm: BaseLLM*, *callback\_manager: Optional[BaseCallbackManager] = None*, *agent\_kwargs: Optional[dict] = None*, *\*\*kwargs: Any*) → AgentExecutor[](#llama_index.langchain_helpers.agents.create_llama_chat_agent "Permalink to this definition")Load a chat llama agent given a Llama Toolkit and LLM.

Parameters* **toolkit** – LlamaToolkit to use.
* **llm** – Language model to use as the agent.
* **callback\_manager** – CallbackManager to use. Global callback manager is used ifnot provided. Defaults to None.
* **agent\_kwargs** – Additional key word arguments to pass to the underlying agent
* **\*\*kwargs** – Additional key word arguments passed to the agent executor
ReturnsAn agent executor

Memory Module

Langchain memory wrapper (for LlamaIndex).

*pydantic model* llama\_index.langchain\_helpers.memory\_wrapper.GPTIndexChatMemory[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory "Permalink to this definition")Langchain chat memory wrapper (for LlamaIndex).

Parameters* **human\_prefix** (*str*) – Prefix for human input. Defaults to “Human”.
* **ai\_prefix** (*str*) – Prefix for AI output. Defaults to “AI”.
* **memory\_key** (*str*) – Key for memory. Defaults to “history”.
* **index** ([*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")) – LlamaIndex instance.
* **query\_kwargs** (*Dict**[**str**,* *Any**]*) – Keyword arguments for LlamaIndex query.
* **input\_key** (*Optional**[**str**]*) – Input key. Defaults to None.
* **output\_key** (*Optional**[**str**]*) – Output key. Defaults to None.
Show JSON schema
```
{ "title": "GPTIndexChatMemory", "description": "Langchain chat memory wrapper (for LlamaIndex).\n\nArgs:\n human\_prefix (str): Prefix for human input. Defaults to \"Human\".\n ai\_prefix (str): Prefix for AI output. Defaults to \"AI\".\n memory\_key (str): Key for memory. Defaults to \"history\".\n index (BaseIndex): LlamaIndex instance.\n query\_kwargs (Dict[str, Any]): Keyword arguments for LlamaIndex query.\n input\_key (Optional[str]): Input key. Defaults to None.\n output\_key (Optional[str]): Output key. Defaults to None.", "type": "object", "properties": { "chat\_memory": { "title": "Chat Memory" }, "output\_key": { "title": "Output Key", "type": "string" }, "input\_key": { "title": "Input Key", "type": "string" }, "return\_messages": { "title": "Return Messages", "default": false, "type": "boolean" }, "human\_prefix": { "title": "Human Prefix", "default": "Human", "type": "string" }, "ai\_prefix": { "title": "Ai Prefix", "default": "AI", "type": "string" }, "memory\_key": { "title": "Memory Key", "default": "history", "type": "string" }, "index": { "title": "Index" }, "query\_kwargs": { "title": "Query Kwargs", "type": "object" }, "return\_source": { "title": "Return Source", "default": false, "type": "boolean" }, "id\_to\_message": { "title": "Id To Message", "type": "object", "additionalProperties": { "$ref": "#/definitions/BaseMessage" } } }, "required": [ "index" ], "definitions": { "BaseMessage": { "title": "BaseMessage", "description": "The base abstract Message class.\n\nMessages are the inputs and outputs of ChatModels.", "type": "object", "properties": { "content": { "title": "Content", "anyOf": [ { "type": "string" }, { "type": "array", "items": { "anyOf": [ { "type": "string" }, { "type": "object" } ] } } ] }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" }, "type": { "title": "Type", "type": "string" } }, "required": [ "content", "type" ] } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`ai\_prefix (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.ai_prefix "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.ai_prefix")
* [`chat\_memory (langchain.schema.chat\_history.BaseChatMessageHistory)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.chat_memory "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.chat_memory")
* [`human\_prefix (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.human_prefix "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.human_prefix")
* [`id\_to\_message (Dict[str, langchain.schema.messages.BaseMessage])`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.id_to_message "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.id_to_message")
* [`index (llama\_index.indices.base.BaseIndex)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.index "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.index")
* [`input\_key (Optional[str])`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.input_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.input_key")
* [`memory\_key (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.memory_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.memory_key")
* [`output\_key (Optional[str])`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.output_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.output_key")
* [`query\_kwargs (Dict)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.query_kwargs "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.query_kwargs")
* [`return\_messages (bool)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_messages "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_messages")
* [`return\_source (bool)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_source "llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_source")
*field* ai\_prefix*: str* *= 'AI'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.ai_prefix "Permalink to this definition")*field* chat\_memory*: BaseChatMessageHistory* *[Optional]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.chat_memory "Permalink to this definition")*field* human\_prefix*: str* *= 'Human'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.human_prefix "Permalink to this definition")*field* id\_to\_message*: Dict[str, BaseMessage]* *[Optional]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.id_to_message "Permalink to this definition")*field* index*: [BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")* *[Required]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.index "Permalink to this definition")*field* input\_key*: Optional[str]* *= None*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.input_key "Permalink to this definition")*field* memory\_key*: str* *= 'history'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.memory_key "Permalink to this definition")*field* output\_key*: Optional[str]* *= None*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.output_key "Permalink to this definition")*field* query\_kwargs*: Dict* *[Optional]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.query_kwargs "Permalink to this definition")*field* return\_messages*: bool* *= False*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_messages "Permalink to this definition")*field* return\_source*: bool* *= False*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.return_source "Permalink to this definition")clear() → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.clear "Permalink to this definition")Clear memory contents.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.from_orm "Permalink to this definition")*classmethod* get\_lc\_namespace() → List[str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.get_lc_namespace "Permalink to this definition")Get the namespace of the langchain object.

For example, if the class is langchain.llms.openai.OpenAI, then thenamespace is [“langchain”, “llms”, “openai”]

*classmethod* is\_lc\_serializable() → bool[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.is_lc_serializable "Permalink to this definition")Is this class serializable?

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* lc\_id() → List[str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.lc_id "Permalink to this definition")A unique identifier for this class for serialization purposes.

The unique identifier is a list of strings that describes the pathto the object.

load\_memory\_variables(*inputs: Dict[str, Any]*) → Dict[str, str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.load_memory_variables "Permalink to this definition")Return key-value pairs given the text input to the chain.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.parse_raw "Permalink to this definition")save\_context(*inputs: Dict[str, Any]*, *outputs: Dict[str, str]*) → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.save_context "Permalink to this definition")Save the context of this model run to memory.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.schema_json "Permalink to this definition")to\_json() → Union[SerializedConstructor, SerializedNotImplemented][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.to_json "Permalink to this definition")to\_json\_not\_implemented() → SerializedNotImplemented[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.to_json_not_implemented "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.validate "Permalink to this definition")*property* lc\_attributes*: Dict*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.lc_attributes "Permalink to this definition")List of attribute names that should be included in the serialized kwargs.

These attributes must be accepted by the constructor.

*property* lc\_secrets*: Dict[str, str]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.lc_secrets "Permalink to this definition")A map of constructor argument names to secret ids.

For example,{“openai\_api\_key”: “OPENAI\_API\_KEY”}

*property* memory\_variables*: List[str]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexChatMemory.memory_variables "Permalink to this definition")Return memory variables.

*pydantic model* llama\_index.langchain\_helpers.memory\_wrapper.GPTIndexMemory[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory "Permalink to this definition")Langchain memory wrapper (for LlamaIndex).

Parameters* **human\_prefix** (*str*) – Prefix for human input. Defaults to “Human”.
* **ai\_prefix** (*str*) – Prefix for AI output. Defaults to “AI”.
* **memory\_key** (*str*) – Key for memory. Defaults to “history”.
* **index** ([*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")) – LlamaIndex instance.
* **query\_kwargs** (*Dict**[**str**,* *Any**]*) – Keyword arguments for LlamaIndex query.
* **input\_key** (*Optional**[**str**]*) – Input key. Defaults to None.
* **output\_key** (*Optional**[**str**]*) – Output key. Defaults to None.
Show JSON schema
```
{ "title": "GPTIndexMemory", "description": "Langchain memory wrapper (for LlamaIndex).\n\nArgs:\n human\_prefix (str): Prefix for human input. Defaults to \"Human\".\n ai\_prefix (str): Prefix for AI output. Defaults to \"AI\".\n memory\_key (str): Key for memory. Defaults to \"history\".\n index (BaseIndex): LlamaIndex instance.\n query\_kwargs (Dict[str, Any]): Keyword arguments for LlamaIndex query.\n input\_key (Optional[str]): Input key. Defaults to None.\n output\_key (Optional[str]): Output key. Defaults to None.", "type": "object", "properties": { "human\_prefix": { "title": "Human Prefix", "default": "Human", "type": "string" }, "ai\_prefix": { "title": "Ai Prefix", "default": "AI", "type": "string" }, "memory\_key": { "title": "Memory Key", "default": "history", "type": "string" }, "index": { "title": "Index" }, "query\_kwargs": { "title": "Query Kwargs", "type": "object" }, "output\_key": { "title": "Output Key", "type": "string" }, "input\_key": { "title": "Input Key", "type": "string" } }, "required": [ "index" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`ai\_prefix (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.ai_prefix "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.ai_prefix")
* [`human\_prefix (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.human_prefix "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.human_prefix")
* [`index (llama\_index.indices.base.BaseIndex)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.index "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.index")
* [`input\_key (Optional[str])`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.input_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.input_key")
* [`memory\_key (str)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.memory_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.memory_key")
* [`output\_key (Optional[str])`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.output_key "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.output_key")
* [`query\_kwargs (Dict)`](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.query_kwargs "llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.query_kwargs")
*field* ai\_prefix*: str* *= 'AI'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.ai_prefix "Permalink to this definition")*field* human\_prefix*: str* *= 'Human'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.human_prefix "Permalink to this definition")*field* index*: [BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")* *[Required]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.index "Permalink to this definition")*field* input\_key*: Optional[str]* *= None*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.input_key "Permalink to this definition")*field* memory\_key*: str* *= 'history'*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.memory_key "Permalink to this definition")*field* output\_key*: Optional[str]* *= None*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.output_key "Permalink to this definition")*field* query\_kwargs*: Dict* *[Optional]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.query_kwargs "Permalink to this definition")clear() → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.clear "Permalink to this definition")Clear memory contents.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.from_orm "Permalink to this definition")*classmethod* get\_lc\_namespace() → List[str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.get_lc_namespace "Permalink to this definition")Get the namespace of the langchain object.

For example, if the class is langchain.llms.openai.OpenAI, then thenamespace is [“langchain”, “llms”, “openai”]

*classmethod* is\_lc\_serializable() → bool[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.is_lc_serializable "Permalink to this definition")Is this class serializable?

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* lc\_id() → List[str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.lc_id "Permalink to this definition")A unique identifier for this class for serialization purposes.

The unique identifier is a list of strings that describes the pathto the object.

load\_memory\_variables(*inputs: Dict[str, Any]*) → Dict[str, str][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.load_memory_variables "Permalink to this definition")Return key-value pairs given the text input to the chain.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.parse_raw "Permalink to this definition")save\_context(*inputs: Dict[str, Any]*, *outputs: Dict[str, str]*) → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.save_context "Permalink to this definition")Save the context of this model run to memory.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.schema_json "Permalink to this definition")to\_json() → Union[SerializedConstructor, SerializedNotImplemented][](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.to_json "Permalink to this definition")to\_json\_not\_implemented() → SerializedNotImplemented[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.to_json_not_implemented "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.validate "Permalink to this definition")*property* lc\_attributes*: Dict*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.lc_attributes "Permalink to this definition")List of attribute names that should be included in the serialized kwargs.

These attributes must be accepted by the constructor.

*property* lc\_secrets*: Dict[str, str]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.lc_secrets "Permalink to this definition")A map of constructor argument names to secret ids.

For example,{“openai\_api\_key”: “OPENAI\_API\_KEY”}

*property* memory\_variables*: List[str]*[](#llama_index.langchain_helpers.memory_wrapper.GPTIndexMemory.memory_variables "Permalink to this definition")Return memory variables.

llama\_index.langchain\_helpers.memory\_wrapper.get\_prompt\_input\_key(*inputs: Dict[str, Any]*, *memory\_variables: List[str]*) → str[](#llama_index.langchain_helpers.memory_wrapper.get_prompt_input_key "Permalink to this definition")Get prompt input key.

Copied over from langchain.

