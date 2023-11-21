LlamaCPP[](#llamacpp "Permalink to this heading")
==================================================

*pydantic model* llama\_index.llms.llama\_cpp.LlamaCPP[](#llama_index.llms.llama_cpp.LlamaCPP "Permalink to this definition")Show JSON schema
```
{ "title": "LlamaCPP", "description": "Simple abstract base class for custom LLMs.\n\nSubclasses must implement the `\_\_init\_\_`, `complete`,\n `stream\_complete`, and `metadata` methods.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model\_url": { "title": "Model Url", "description": "The URL llama-cpp model to download and use.", "type": "string" }, "model\_path": { "title": "Model Path", "description": "The path to the llama-cpp model to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use for sampling.", "type": "number" }, "max\_new\_tokens": { "title": "Max New Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "context\_window": { "title": "Context Window", "description": "The maximum number of context tokens for the model.", "default": 3900, "type": "integer" }, "generate\_kwargs": { "title": "Generate Kwargs", "description": "Kwargs used for generation.", "type": "object" }, "model\_kwargs": { "title": "Model Kwargs", "description": "Kwargs used for model initialization.", "type": "object" }, "verbose": { "title": "Verbose", "description": "Whether to print verbose output.", "default": true, "type": "boolean" } }, "required": [ "temperature", "max\_new\_tokens" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`completion\_to\_prompt (Callable)`](#llama_index.llms.llama_cpp.LlamaCPP.completion_to_prompt "llama_index.llms.llama_cpp.LlamaCPP.completion_to_prompt")
* [`context\_window (int)`](#llama_index.llms.llama_cpp.LlamaCPP.context_window "llama_index.llms.llama_cpp.LlamaCPP.context_window")
* [`generate\_kwargs (Dict[str, Any])`](#llama_index.llms.llama_cpp.LlamaCPP.generate_kwargs "llama_index.llms.llama_cpp.LlamaCPP.generate_kwargs")
* [`max\_new\_tokens (int)`](#llama_index.llms.llama_cpp.LlamaCPP.max_new_tokens "llama_index.llms.llama_cpp.LlamaCPP.max_new_tokens")
* [`messages\_to\_prompt (Callable)`](#llama_index.llms.llama_cpp.LlamaCPP.messages_to_prompt "llama_index.llms.llama_cpp.LlamaCPP.messages_to_prompt")
* [`model\_kwargs (Dict[str, Any])`](#llama_index.llms.llama_cpp.LlamaCPP.model_kwargs "llama_index.llms.llama_cpp.LlamaCPP.model_kwargs")
* [`model\_path (Optional[str])`](#llama_index.llms.llama_cpp.LlamaCPP.model_path "llama_index.llms.llama_cpp.LlamaCPP.model_path")
* [`model\_url (Optional[str])`](#llama_index.llms.llama_cpp.LlamaCPP.model_url "llama_index.llms.llama_cpp.LlamaCPP.model_url")
* [`temperature (float)`](#llama_index.llms.llama_cpp.LlamaCPP.temperature "llama_index.llms.llama_cpp.LlamaCPP.temperature")
* [`verbose (bool)`](#llama_index.llms.llama_cpp.LlamaCPP.verbose "llama_index.llms.llama_cpp.LlamaCPP.verbose")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* completion\_to\_prompt*: Callable* *[Required]*[](#llama_index.llms.llama_cpp.LlamaCPP.completion_to_prompt "Permalink to this definition")The function to convert a completion to a prompt.

*field* context\_window*: int* *= 3900*[](#llama_index.llms.llama_cpp.LlamaCPP.context_window "Permalink to this definition")The maximum number of context tokens for the model.

*field* generate\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.llama_cpp.LlamaCPP.generate_kwargs "Permalink to this definition")Kwargs used for generation.

*field* max\_new\_tokens*: int* *[Required]*[](#llama_index.llms.llama_cpp.LlamaCPP.max_new_tokens "Permalink to this definition")The maximum number of tokens to generate.

*field* messages\_to\_prompt*: Callable* *[Required]*[](#llama_index.llms.llama_cpp.LlamaCPP.messages_to_prompt "Permalink to this definition")The function to convert messages to a prompt.

*field* model\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.llms.llama_cpp.LlamaCPP.model_kwargs "Permalink to this definition")Kwargs used for model initialization.

*field* model\_path*: Optional[str]* *= None*[](#llama_index.llms.llama_cpp.LlamaCPP.model_path "Permalink to this definition")The path to the llama-cpp model to use.

*field* model\_url*: Optional[str]* *= None*[](#llama_index.llms.llama_cpp.LlamaCPP.model_url "Permalink to this definition")The URL llama-cpp model to download and use.

*field* temperature*: float* *[Required]*[](#llama_index.llms.llama_cpp.LlamaCPP.temperature "Permalink to this definition")The temperature to use for sampling.

*field* verbose*: bool* *= True*[](#llama_index.llms.llama_cpp.LlamaCPP.verbose "Permalink to this definition")Whether to print verbose output.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.llama_cpp.LlamaCPP.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.llama_cpp.LlamaCPP.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.llama_cpp.LlamaCPP.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.llama_cpp.LlamaCPP.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.llama_cpp.LlamaCPP.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.llama_cpp.LlamaCPP.metadata "Permalink to this definition")LLM metadata.

