LiteLLM[](#litellm "Permalink to this heading")
================================================

*pydantic model* llama\_index.llms.litellm.LiteLLM[](#llama_index.llms.litellm.LiteLLM "Permalink to this definition")Show JSON schema
```
{ "title": "LiteLLM", "description": "LLM interface.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "The LiteLLM model to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use during generation.", "type": "number" }, "max\_tokens": { "title": "Max Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the LLM API.", "type": "object" }, "max\_retries": { "title": "Max Retries", "description": "The maximum number of API retries.", "type": "integer" } }, "required": [ "model", "temperature", "max\_retries" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`additional\_kwargs (Dict[str, Any])`](#llama_index.llms.litellm.LiteLLM.additional_kwargs "llama_index.llms.litellm.LiteLLM.additional_kwargs")
* [`max\_retries (int)`](#llama_index.llms.litellm.LiteLLM.max_retries "llama_index.llms.litellm.LiteLLM.max_retries")
* [`max\_tokens (Optional[int])`](#llama_index.llms.litellm.LiteLLM.max_tokens "llama_index.llms.litellm.LiteLLM.max_tokens")
* [`model (str)`](#llama_index.llms.litellm.LiteLLM.model "llama_index.llms.litellm.LiteLLM.model")
* [`temperature (float)`](#llama_index.llms.litellm.LiteLLM.temperature "llama_index.llms.litellm.LiteLLM.temperature")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* additional\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.litellm.LiteLLM.additional_kwargs "Permalink to this definition")Additional kwargs for the LLM API.

*field* max\_retries*: int* *[Required]*[](#llama_index.llms.litellm.LiteLLM.max_retries "Permalink to this definition")The maximum number of API retries.

*field* max\_tokens*: Optional[int]* *= None*[](#llama_index.llms.litellm.LiteLLM.max_tokens "Permalink to this definition")The maximum number of tokens to generate.

*field* model*: str* *[Required]*[](#llama_index.llms.litellm.LiteLLM.model "Permalink to this definition")The LiteLLM model to use.

*field* temperature*: float* *[Required]*[](#llama_index.llms.litellm.LiteLLM.temperature "Permalink to this definition")The temperature to use during generation.

*async* achat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.achat "Permalink to this definition")Async chat endpoint for LLM.

*async* acomplete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.acomplete "Permalink to this definition")Async completion endpoint for LLM.

*async* astream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.astream_chat "Permalink to this definition")Async streaming chat endpoint for LLM.

*async* astream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.astream_complete "Permalink to this definition")Async streaming completion endpoint for LLM.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.litellm.LiteLLM.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.litellm.LiteLLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.litellm.LiteLLM.metadata "Permalink to this definition")LLM metadata.

