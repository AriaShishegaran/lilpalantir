Memory[](#module-llama_index.memory "Permalink to this heading")
=================================================================

*pydantic model* llama\_index.memory.BaseMemory[](#llama_index.memory.BaseMemory "Permalink to this definition")Base class for all memory types.

NOTE: The interface for memory is not yet finalized and is subject to change.

Show JSON schema
```
{ "title": "BaseMemory", "description": "Base class for all memory types.\n\nNOTE: The interface for memory is not yet finalized and is subject to change.", "type": "object", "properties": {}}
```


*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.memory.BaseMemory.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.memory.BaseMemory.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.memory.BaseMemory.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*abstract classmethod* from\_defaults(*chat\_history: Optional[List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]] = None*, *llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → [BaseMemory](#llama_index.memory.BaseMemory "llama_index.memory.types.BaseMemory")[](#llama_index.memory.BaseMemory.from_defaults "Permalink to this definition")Create a chat memory from defaults.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.memory.BaseMemory.from_orm "Permalink to this definition")*abstract* get(*\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.memory.BaseMemory.get "Permalink to this definition")Get chat history.

*abstract* get\_all() → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.memory.BaseMemory.get_all "Permalink to this definition")Get all chat history.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.memory.BaseMemory.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.memory.BaseMemory.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.memory.BaseMemory.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.memory.BaseMemory.parse_raw "Permalink to this definition")*abstract* put(*message: [ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")*) → None[](#llama_index.memory.BaseMemory.put "Permalink to this definition")Put chat history.

*abstract* reset() → None[](#llama_index.memory.BaseMemory.reset "Permalink to this definition")Reset chat history.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.memory.BaseMemory.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.memory.BaseMemory.schema_json "Permalink to this definition")*abstract* set(*messages: List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*) → None[](#llama_index.memory.BaseMemory.set "Permalink to this definition")Set chat history.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.memory.BaseMemory.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.memory.BaseMemory.validate "Permalink to this definition")*pydantic model* llama\_index.memory.ChatMemoryBuffer[](#llama_index.memory.ChatMemoryBuffer "Permalink to this definition")Simple buffer for storing chat history.

Show JSON schema
```
{ "title": "ChatMemoryBuffer", "description": "Simple buffer for storing chat history.", "type": "object", "properties": { "token\_limit": { "title": "Token Limit", "type": "integer" }, "chat\_history": { "title": "Chat History", "type": "array", "items": { "$ref": "#/definitions/ChatMessage" } } }, "required": [ "token\_limit" ], "definitions": { "MessageRole": { "title": "MessageRole", "description": "Message role.", "enum": [ "system", "user", "assistant", "function", "tool" ], "type": "string" }, "ChatMessage": { "title": "ChatMessage", "description": "Chat message.", "type": "object", "properties": { "role": { "default": "user", "allOf": [ { "$ref": "#/definitions/MessageRole" } ] }, "content": { "title": "Content", "default": "", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" } } } }}
```


Fields* `chat\_history (List[llama\_index.llms.base.ChatMessage])`
* `token\_limit (int)`
* `tokenizer\_fn (Callable[[str], List])`
*field* chat\_history*: List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]* *[Optional]*[](#llama_index.memory.ChatMemoryBuffer.chat_history "Permalink to this definition")Validated by* `validate\_memory`
*field* token\_limit*: int* *[Required]*[](#llama_index.memory.ChatMemoryBuffer.token_limit "Permalink to this definition")Validated by* `validate\_memory`
*field* tokenizer\_fn*: Callable[[str], List]* *[Optional]*[](#llama_index.memory.ChatMemoryBuffer.tokenizer_fn "Permalink to this definition")Validated by* `validate\_memory`
*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.memory.ChatMemoryBuffer.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.memory.ChatMemoryBuffer.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.memory.ChatMemoryBuffer.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_defaults(*chat\_history: Optional[List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]] = None*, *llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *token\_limit: Optional[int] = None*, *tokenizer\_fn: Optional[Callable[[str], List]] = None*) → [ChatMemoryBuffer](#llama_index.memory.ChatMemoryBuffer "llama_index.memory.chat_memory_buffer.ChatMemoryBuffer")[](#llama_index.memory.ChatMemoryBuffer.from_defaults "Permalink to this definition")Create a chat memory buffer from an LLM.

*classmethod* from\_dict(*json\_dict: dict*) → [ChatMemoryBuffer](#llama_index.memory.ChatMemoryBuffer "llama_index.memory.chat_memory_buffer.ChatMemoryBuffer")[](#llama_index.memory.ChatMemoryBuffer.from_dict "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.memory.ChatMemoryBuffer.from_orm "Permalink to this definition")*classmethod* from\_string(*json\_str: str*) → [ChatMemoryBuffer](#llama_index.memory.ChatMemoryBuffer "llama_index.memory.chat_memory_buffer.ChatMemoryBuffer")[](#llama_index.memory.ChatMemoryBuffer.from_string "Permalink to this definition")get(*initial\_token\_count: int = 0*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.memory.ChatMemoryBuffer.get "Permalink to this definition")Get chat history.

get\_all() → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.memory.ChatMemoryBuffer.get_all "Permalink to this definition")Get all chat history.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.memory.ChatMemoryBuffer.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.memory.ChatMemoryBuffer.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.memory.ChatMemoryBuffer.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.memory.ChatMemoryBuffer.parse_raw "Permalink to this definition")put(*message: [ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")*) → None[](#llama_index.memory.ChatMemoryBuffer.put "Permalink to this definition")Put chat history.

reset() → None[](#llama_index.memory.ChatMemoryBuffer.reset "Permalink to this definition")Reset chat history.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.memory.ChatMemoryBuffer.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.memory.ChatMemoryBuffer.schema_json "Permalink to this definition")set(*messages: List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*) → None[](#llama_index.memory.ChatMemoryBuffer.set "Permalink to this definition")Set chat history.

to\_dict() → dict[](#llama_index.memory.ChatMemoryBuffer.to_dict "Permalink to this definition")Convert memory to dict.

to\_string() → str[](#llama_index.memory.ChatMemoryBuffer.to_string "Permalink to this definition")Convert memory to string.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.memory.ChatMemoryBuffer.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.memory.ChatMemoryBuffer.validate "Permalink to this definition")*validator* validate\_memory*»* *all fields*[](#llama_index.memory.ChatMemoryBuffer.validate_memory "Permalink to this definition")