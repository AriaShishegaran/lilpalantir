OpenAI[](#openai "Permalink to this heading")
==============================================

*pydantic model* llama\_index.llms.openai.OpenAI[](#llama_index.llms.openai.OpenAI "Permalink to this definition")Show JSON schema
```
{ "title": "OpenAI", "description": "LLM interface.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "The OpenAI model to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use during generation.", "type": "number" }, "max\_tokens": { "title": "Max Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the OpenAI API.", "type": "object" }, "max\_retries": { "title": "Max Retries", "description": "The maximum number of API retries.", "default": 3, "gte": 0, "type": "integer" }, "timeout": { "title": "Timeout", "description": "The timeout, in seconds, for API requests.", "default": 60.0, "gte": 0, "type": "number" }, "api\_key": { "title": "Api Key", "description": "The OpenAI API key.", "type": "string" }, "api\_base": { "title": "Api Base", "description": "The base URL for OpenAI API.", "type": "string" }, "api\_version": { "title": "Api Version", "description": "The API version for OpenAI API.", "type": "string" } }, "required": [ "model", "temperature", "api\_base", "api\_version" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`additional\_kwargs (Dict[str, Any])`](#llama_index.llms.openai.OpenAI.additional_kwargs "llama_index.llms.openai.OpenAI.additional_kwargs")
* [`api\_base (str)`](#llama_index.llms.openai.OpenAI.api_base "llama_index.llms.openai.OpenAI.api_base")
* [`api\_key (str)`](#llama_index.llms.openai.OpenAI.api_key "llama_index.llms.openai.OpenAI.api_key")
* [`api\_version (str)`](#llama_index.llms.openai.OpenAI.api_version "llama_index.llms.openai.OpenAI.api_version")
* [`max\_retries (int)`](#llama_index.llms.openai.OpenAI.max_retries "llama_index.llms.openai.OpenAI.max_retries")
* [`max\_tokens (Optional[int])`](#llama_index.llms.openai.OpenAI.max_tokens "llama_index.llms.openai.OpenAI.max_tokens")
* [`model (str)`](#llama_index.llms.openai.OpenAI.model "llama_index.llms.openai.OpenAI.model")
* [`temperature (float)`](#llama_index.llms.openai.OpenAI.temperature "llama_index.llms.openai.OpenAI.temperature")
* [`timeout (float)`](#llama_index.llms.openai.OpenAI.timeout "llama_index.llms.openai.OpenAI.timeout")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* additional\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.openai.OpenAI.additional_kwargs "Permalink to this definition")Additional kwargs for the OpenAI API.

*field* api\_base*: str* *[Required]*[](#llama_index.llms.openai.OpenAI.api_base "Permalink to this definition")The base URL for OpenAI API.

*field* api\_key*: str* *= None*[](#llama_index.llms.openai.OpenAI.api_key "Permalink to this definition")The OpenAI API key.

*field* api\_version*: str* *[Required]*[](#llama_index.llms.openai.OpenAI.api_version "Permalink to this definition")The API version for OpenAI API.

*field* max\_retries*: int* *= 3*[](#llama_index.llms.openai.OpenAI.max_retries "Permalink to this definition")The maximum number of API retries.

*field* max\_tokens*: Optional[int]* *= None*[](#llama_index.llms.openai.OpenAI.max_tokens "Permalink to this definition")The maximum number of tokens to generate.

*field* model*: str* *[Required]*[](#llama_index.llms.openai.OpenAI.model "Permalink to this definition")The OpenAI model to use.

*field* temperature*: float* *[Required]*[](#llama_index.llms.openai.OpenAI.temperature "Permalink to this definition")The temperature to use during generation.

*field* timeout*: float* *= 60.0*[](#llama_index.llms.openai.OpenAI.timeout "Permalink to this definition")The timeout, in seconds, for API requests.

*async* achat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.achat "Permalink to this definition")Async chat endpoint for LLM.

*async* acomplete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.acomplete "Permalink to this definition")Async completion endpoint for LLM.

*async* astream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.astream_chat "Permalink to this definition")Async streaming chat endpoint for LLM.

*async* astream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.astream_complete "Permalink to this definition")Async streaming completion endpoint for LLM.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.openai.OpenAI.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.openai.OpenAI.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.openai.OpenAI.metadata "Permalink to this definition")LLM metadata.

