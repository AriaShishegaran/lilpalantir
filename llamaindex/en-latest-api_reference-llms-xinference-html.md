XOrbits Xinference[](#xorbits-xinference "Permalink to this heading")
======================================================================

*pydantic model* llama\_index.llms.xinference.Xinference[](#llama_index.llms.xinference.Xinference "Permalink to this definition")Show JSON schema
```
{ "title": "Xinference", "description": "Simple abstract base class for custom LLMs.\n\nSubclasses must implement the `\_\_init\_\_`, `complete`,\n `stream\_complete`, and `metadata` methods.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model\_uid": { "title": "Model Uid", "description": "The Xinference model to use.", "type": "string" }, "endpoint": { "title": "Endpoint", "description": "The Xinference endpoint URL to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use for sampling.", "type": "number" }, "max\_tokens": { "title": "Max Tokens", "description": "The maximum new tokens to generate as answer.", "type": "integer" }, "context\_window": { "title": "Context Window", "description": "The maximum number of context tokens for the model.", "type": "integer" }, "model\_description": { "title": "Model Description", "description": "The model description from Xinference.", "type": "object" } }, "required": [ "model\_uid", "endpoint", "temperature", "max\_tokens", "context\_window", "model\_description" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`context\_window (int)`](#llama_index.llms.xinference.Xinference.context_window "llama_index.llms.xinference.Xinference.context_window")
* [`endpoint (str)`](#llama_index.llms.xinference.Xinference.endpoint "llama_index.llms.xinference.Xinference.endpoint")
* [`max\_tokens (int)`](#llama_index.llms.xinference.Xinference.max_tokens "llama_index.llms.xinference.Xinference.max_tokens")
* [`model\_description (Dict[str, Any])`](#llama_index.llms.xinference.Xinference.model_description "llama_index.llms.xinference.Xinference.model_description")
* [`model\_uid (str)`](#llama_index.llms.xinference.Xinference.model_uid "llama_index.llms.xinference.Xinference.model_uid")
* [`temperature (float)`](#llama_index.llms.xinference.Xinference.temperature "llama_index.llms.xinference.Xinference.temperature")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* context\_window*: int* *[Required]*[](#llama_index.llms.xinference.Xinference.context_window "Permalink to this definition")The maximum number of context tokens for the model.

*field* endpoint*: str* *[Required]*[](#llama_index.llms.xinference.Xinference.endpoint "Permalink to this definition")The Xinference endpoint URL to use.

*field* max\_tokens*: int* *[Required]*[](#llama_index.llms.xinference.Xinference.max_tokens "Permalink to this definition")The maximum new tokens to generate as answer.

*field* model\_description*: Dict[str, Any]* *[Required]*[](#llama_index.llms.xinference.Xinference.model_description "Permalink to this definition")The model description from Xinference.

*field* model\_uid*: str* *[Required]*[](#llama_index.llms.xinference.Xinference.model_uid "Permalink to this definition")The Xinference model to use.

*field* temperature*: float* *[Required]*[](#llama_index.llms.xinference.Xinference.temperature "Permalink to this definition")The temperature to use for sampling.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.xinference.Xinference.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.xinference.Xinference.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.xinference.Xinference.complete "Permalink to this definition")Completion endpoint for LLM.

load\_model(*model\_uid: str*, *endpoint: str*) → Tuple[Any, int, dict][](#llama_index.llms.xinference.Xinference.load_model "Permalink to this definition")stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.xinference.Xinference.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.xinference.Xinference.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.xinference.Xinference.metadata "Permalink to this definition")LLM metadata.

