Anthropic[](#anthropic "Permalink to this heading")
====================================================

*pydantic model* llama\_index.llms.anthropic.Anthropic[](#llama_index.llms.anthropic.Anthropic "Permalink to this definition")Show JSON schema
```
{ "title": "Anthropic", "description": "LLM interface.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "The anthropic model to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use for sampling.", "type": "number" }, "max\_tokens": { "title": "Max Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "base\_url": { "title": "Base Url", "description": "The base URL to use.", "type": "string" }, "timeout": { "title": "Timeout", "description": "The timeout to use in seconds.", "type": "number" }, "max\_retries": { "title": "Max Retries", "description": "The maximum number of API retries.", "default": 10, "type": "integer" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the anthropic API.", "type": "object" } }, "required": [ "model", "temperature", "max\_tokens" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`additional\_kwargs (Dict[str, Any])`](#llama_index.llms.anthropic.Anthropic.additional_kwargs "llama_index.llms.anthropic.Anthropic.additional_kwargs")
* [`base\_url (Optional[str])`](#llama_index.llms.anthropic.Anthropic.base_url "llama_index.llms.anthropic.Anthropic.base_url")
* [`max\_retries (int)`](#llama_index.llms.anthropic.Anthropic.max_retries "llama_index.llms.anthropic.Anthropic.max_retries")
* [`max\_tokens (int)`](#llama_index.llms.anthropic.Anthropic.max_tokens "llama_index.llms.anthropic.Anthropic.max_tokens")
* [`model (str)`](#llama_index.llms.anthropic.Anthropic.model "llama_index.llms.anthropic.Anthropic.model")
* [`temperature (float)`](#llama_index.llms.anthropic.Anthropic.temperature "llama_index.llms.anthropic.Anthropic.temperature")
* [`timeout (Optional[float])`](#llama_index.llms.anthropic.Anthropic.timeout "llama_index.llms.anthropic.Anthropic.timeout")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* additional\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.anthropic.Anthropic.additional_kwargs "Permalink to this definition")Additional kwargs for the anthropic API.

*field* base\_url*: Optional[str]* *= None*[](#llama_index.llms.anthropic.Anthropic.base_url "Permalink to this definition")The base URL to use.

*field* max\_retries*: int* *= 10*[](#llama_index.llms.anthropic.Anthropic.max_retries "Permalink to this definition")The maximum number of API retries.

*field* max\_tokens*: int* *[Required]*[](#llama_index.llms.anthropic.Anthropic.max_tokens "Permalink to this definition")The maximum number of tokens to generate.

*field* model*: str* *[Required]*[](#llama_index.llms.anthropic.Anthropic.model "Permalink to this definition")The anthropic model to use.

*field* temperature*: float* *[Required]*[](#llama_index.llms.anthropic.Anthropic.temperature "Permalink to this definition")The temperature to use for sampling.

*field* timeout*: Optional[float]* *= None*[](#llama_index.llms.anthropic.Anthropic.timeout "Permalink to this definition")The timeout to use in seconds.

*async* achat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.achat "Permalink to this definition")Async chat endpoint for LLM.

*async* acomplete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.acomplete "Permalink to this definition")Async completion endpoint for LLM.

*async* astream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.astream_chat "Permalink to this definition")Async streaming chat endpoint for LLM.

*async* astream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.astream_complete "Permalink to this definition")Async streaming completion endpoint for LLM.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.anthropic.Anthropic.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.anthropic.Anthropic.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.anthropic.Anthropic.metadata "Permalink to this definition")LLM metadata.

