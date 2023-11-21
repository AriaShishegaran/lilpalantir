Replicate[](#replicate "Permalink to this heading")
====================================================

*pydantic model* llama\_index.llms.replicate.Replicate[](#llama_index.llms.replicate.Replicate "Permalink to this definition")Show JSON schema
```
{ "title": "Replicate", "description": "Simple abstract base class for custom LLMs.\n\nSubclasses must implement the `\_\_init\_\_`, `complete`,\n `stream\_complete`, and `metadata` methods.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "The Replicate model to use.", "type": "string" }, "image": { "title": "Image", "description": "The image file for multimodal model to use. (optional)", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use for sampling.", "type": "number" }, "context\_window": { "title": "Context Window", "description": "The maximum number of context tokens for the model.", "type": "integer" }, "prompt\_key": { "title": "Prompt Key", "description": "The key to use for the prompt in API calls.", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the Replicate API.", "type": "object" }, "is\_chat\_model": { "title": "Is Chat Model", "description": "Whether the model is a chat model.", "default": false, "type": "boolean" } }, "required": [ "model", "image", "temperature", "context\_window", "prompt\_key" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`additional\_kwargs (Dict[str, Any])`](#llama_index.llms.replicate.Replicate.additional_kwargs "llama_index.llms.replicate.Replicate.additional_kwargs")
* [`context\_window (int)`](#llama_index.llms.replicate.Replicate.context_window "llama_index.llms.replicate.Replicate.context_window")
* [`image (str)`](#llama_index.llms.replicate.Replicate.image "llama_index.llms.replicate.Replicate.image")
* [`is\_chat\_model (bool)`](#llama_index.llms.replicate.Replicate.is_chat_model "llama_index.llms.replicate.Replicate.is_chat_model")
* [`model (str)`](#llama_index.llms.replicate.Replicate.model "llama_index.llms.replicate.Replicate.model")
* [`prompt\_key (str)`](#llama_index.llms.replicate.Replicate.prompt_key "llama_index.llms.replicate.Replicate.prompt_key")
* [`temperature (float)`](#llama_index.llms.replicate.Replicate.temperature "llama_index.llms.replicate.Replicate.temperature")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* additional\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.replicate.Replicate.additional_kwargs "Permalink to this definition")Additional kwargs for the Replicate API.

*field* context\_window*: int* *[Required]*[](#llama_index.llms.replicate.Replicate.context_window "Permalink to this definition")The maximum number of context tokens for the model.

*field* image*: str* *[Required]*[](#llama_index.llms.replicate.Replicate.image "Permalink to this definition")The image file for multimodal model to use. (optional)

*field* is\_chat\_model*: bool* *= False*[](#llama_index.llms.replicate.Replicate.is_chat_model "Permalink to this definition")Whether the model is a chat model.

*field* model*: str* *[Required]*[](#llama_index.llms.replicate.Replicate.model "Permalink to this definition")The Replicate model to use.

*field* prompt\_key*: str* *[Required]*[](#llama_index.llms.replicate.Replicate.prompt_key "Permalink to this definition")The key to use for the prompt in API calls.

*field* temperature*: float* *[Required]*[](#llama_index.llms.replicate.Replicate.temperature "Permalink to this definition")The temperature to use for sampling.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.replicate.Replicate.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.replicate.Replicate.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.replicate.Replicate.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.replicate.Replicate.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.replicate.Replicate.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.replicate.Replicate.metadata "Permalink to this definition")LLM metadata.

