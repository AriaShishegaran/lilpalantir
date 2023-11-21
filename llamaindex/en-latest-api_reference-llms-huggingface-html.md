HuggingFaceLLM[](#huggingfacellm "Permalink to this heading")
==============================================================

*pydantic model* llama\_index.llms.huggingface.HuggingFaceLLM[](#llama_index.llms.huggingface.HuggingFaceLLM "Permalink to this definition")HuggingFace LLM.

Show JSON schema
```
{ "title": "HuggingFaceLLM", "description": "HuggingFace LLM.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model\_name": { "title": "Model Name", "description": "The model name to use from HuggingFace. Unused if `model` is passed in directly.", "type": "string" }, "context\_window": { "title": "Context Window", "description": "The maximum number of tokens available for input.", "type": "integer" }, "max\_new\_tokens": { "title": "Max New Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "system\_prompt": { "title": "System Prompt", "description": "The system prompt, containing any extra instructions or context. The model card on HuggingFace should specify if this is needed.", "type": "string" }, "query\_wrapper\_prompt": { "title": "Query Wrapper Prompt", "description": "The query wrapper prompt, containing the query placeholder. The model card on HuggingFace should specify if this is needed. Should contain a `{query\_str}` placeholder.", "type": "string" }, "tokenizer\_name": { "title": "Tokenizer Name", "description": "The name of the tokenizer to use from HuggingFace. Unused if `tokenizer` is passed in directly.", "type": "string" }, "device\_map": { "title": "Device Map", "description": "The device\_map to use. Defaults to 'auto'.", "type": "string" }, "stopping\_ids": { "title": "Stopping Ids", "description": "The stopping ids to use. Generation stops when these token IDs are predicted.", "type": "array", "items": { "type": "integer" } }, "tokenizer\_outputs\_to\_remove": { "title": "Tokenizer Outputs To Remove", "description": "The outputs to remove from the tokenizer. Sometimes huggingface tokenizers return extra inputs that cause errors.", "type": "array", "items": {} }, "tokenizer\_kwargs": { "title": "Tokenizer Kwargs", "description": "The kwargs to pass to the tokenizer.", "type": "object" }, "model\_kwargs": { "title": "Model Kwargs", "description": "The kwargs to pass to the model during initialization.", "type": "object" }, "generate\_kwargs": { "title": "Generate Kwargs", "description": "The kwargs to pass to the model during generation.", "type": "object" } }, "required": [ "model\_name", "context\_window", "max\_new\_tokens", "system\_prompt", "query\_wrapper\_prompt", "tokenizer\_name" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`context\_window (int)`](#llama_index.llms.huggingface.HuggingFaceLLM.context_window "llama_index.llms.huggingface.HuggingFaceLLM.context_window")
* [`device\_map (Optional[str])`](#llama_index.llms.huggingface.HuggingFaceLLM.device_map "llama_index.llms.huggingface.HuggingFaceLLM.device_map")
* [`generate\_kwargs (dict)`](#llama_index.llms.huggingface.HuggingFaceLLM.generate_kwargs "llama_index.llms.huggingface.HuggingFaceLLM.generate_kwargs")
* [`max\_new\_tokens (int)`](#llama_index.llms.huggingface.HuggingFaceLLM.max_new_tokens "llama_index.llms.huggingface.HuggingFaceLLM.max_new_tokens")
* [`model\_kwargs (dict)`](#llama_index.llms.huggingface.HuggingFaceLLM.model_kwargs "llama_index.llms.huggingface.HuggingFaceLLM.model_kwargs")
* [`model\_name (str)`](#llama_index.llms.huggingface.HuggingFaceLLM.model_name "llama_index.llms.huggingface.HuggingFaceLLM.model_name")
* [`query\_wrapper\_prompt (str)`](#llama_index.llms.huggingface.HuggingFaceLLM.query_wrapper_prompt "llama_index.llms.huggingface.HuggingFaceLLM.query_wrapper_prompt")
* [`stopping\_ids (List[int])`](#llama_index.llms.huggingface.HuggingFaceLLM.stopping_ids "llama_index.llms.huggingface.HuggingFaceLLM.stopping_ids")
* [`system\_prompt (str)`](#llama_index.llms.huggingface.HuggingFaceLLM.system_prompt "llama_index.llms.huggingface.HuggingFaceLLM.system_prompt")
* [`tokenizer\_kwargs (dict)`](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_kwargs "llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_kwargs")
* [`tokenizer\_name (str)`](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_name "llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_name")
* [`tokenizer\_outputs\_to\_remove (list)`](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_outputs_to_remove "llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_outputs_to_remove")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* context\_window*: int* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.context_window "Permalink to this definition")The maximum number of tokens available for input.

*field* device\_map*: Optional[str]* *= None*[](#llama_index.llms.huggingface.HuggingFaceLLM.device_map "Permalink to this definition")The device\_map to use. Defaults to ‘auto’.

*field* generate\_kwargs*: dict* *[Optional]*[](#llama_index.llms.huggingface.HuggingFaceLLM.generate_kwargs "Permalink to this definition")The kwargs to pass to the model during generation.

*field* max\_new\_tokens*: int* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.max_new_tokens "Permalink to this definition")The maximum number of tokens to generate.

*field* model\_kwargs*: dict* *[Optional]*[](#llama_index.llms.huggingface.HuggingFaceLLM.model_kwargs "Permalink to this definition")The kwargs to pass to the model during initialization.

*field* model\_name*: str* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.model_name "Permalink to this definition")The model name to use from HuggingFace. Unused if model is passed in directly.

*field* query\_wrapper\_prompt*: str* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.query_wrapper_prompt "Permalink to this definition")The query wrapper prompt, containing the query placeholder. The model card on HuggingFace should specify if this is needed. Should contain a {query\_str} placeholder.

*field* stopping\_ids*: List[int]* *[Optional]*[](#llama_index.llms.huggingface.HuggingFaceLLM.stopping_ids "Permalink to this definition")The stopping ids to use. Generation stops when these token IDs are predicted.

*field* system\_prompt*: str* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.system_prompt "Permalink to this definition")The system prompt, containing any extra instructions or context. The model card on HuggingFace should specify if this is needed.

*field* tokenizer\_kwargs*: dict* *[Optional]*[](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_kwargs "Permalink to this definition")The kwargs to pass to the tokenizer.

*field* tokenizer\_name*: str* *[Required]*[](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_name "Permalink to this definition")The name of the tokenizer to use from HuggingFace. Unused if tokenizer is passed in directly.

*field* tokenizer\_outputs\_to\_remove*: list* *[Optional]*[](#llama_index.llms.huggingface.HuggingFaceLLM.tokenizer_outputs_to_remove "Permalink to this definition")The outputs to remove from the tokenizer. Sometimes huggingface tokenizers return extra inputs that cause errors.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.huggingface.HuggingFaceLLM.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.huggingface.HuggingFaceLLM.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.huggingface.HuggingFaceLLM.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.huggingface.HuggingFaceLLM.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.huggingface.HuggingFaceLLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.huggingface.HuggingFaceLLM.metadata "Permalink to this definition")LLM metadata.

