Gradient Base Model[](#gradient-base-model "Permalink to this heading")
========================================================================

*pydantic model* llama\_index.llms.gradient.GradientBaseModelLLM[](#llama_index.llms.gradient.GradientBaseModelLLM "Permalink to this definition")Show JSON schema
```
{ "title": "GradientBaseModelLLM", "description": "Simple abstract base class for custom LLMs.\n\nSubclasses must implement the `\_\_init\_\_`, `complete`,\n `stream\_complete`, and `metadata` methods.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "max\_tokens": { "title": "Max Tokens", "description": "The number of tokens to generate.", "exclusiveMinimum": 0, "exclusiveMaximum": 512, "type": "integer" }, "access\_token": { "title": "Access Token", "description": "The Gradient access token to use.", "type": "string" }, "host": { "title": "Host", "description": "The url of the Gradient service to access.", "type": "string" }, "workspace\_id": { "title": "Workspace Id", "description": "The Gradient workspace id to use.", "type": "string" }, "is\_chat\_model": { "title": "Is Chat Model", "description": "Whether the model is a chat model.", "default": false, "type": "boolean" }, "base\_model\_slug": { "title": "Base Model Slug", "description": "The slug of the base model to use.", "type": "string" } }, "required": [ "base\_model\_slug" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`access\_token (Optional[str])`](#llama_index.llms.gradient.GradientBaseModelLLM.access_token "llama_index.llms.gradient.GradientBaseModelLLM.access_token")
* [`base\_model\_slug (str)`](#llama_index.llms.gradient.GradientBaseModelLLM.base_model_slug "llama_index.llms.gradient.GradientBaseModelLLM.base_model_slug")
* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* [`host (Optional[str])`](#llama_index.llms.gradient.GradientBaseModelLLM.host "llama_index.llms.gradient.GradientBaseModelLLM.host")
* [`is\_chat\_model (bool)`](#llama_index.llms.gradient.GradientBaseModelLLM.is_chat_model "llama_index.llms.gradient.GradientBaseModelLLM.is_chat_model")
* [`max\_tokens (Optional[int])`](#llama_index.llms.gradient.GradientBaseModelLLM.max_tokens "llama_index.llms.gradient.GradientBaseModelLLM.max_tokens")
* [`workspace\_id (Optional[str])`](#llama_index.llms.gradient.GradientBaseModelLLM.workspace_id "llama_index.llms.gradient.GradientBaseModelLLM.workspace_id")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* access\_token*: Optional[str]* *= None*[](#llama_index.llms.gradient.GradientBaseModelLLM.access_token "Permalink to this definition")The Gradient access token to use.

*field* base\_model\_slug*: str* *[Required]*[](#llama_index.llms.gradient.GradientBaseModelLLM.base_model_slug "Permalink to this definition")The slug of the base model to use.

*field* host*: Optional[str]* *= None*[](#llama_index.llms.gradient.GradientBaseModelLLM.host "Permalink to this definition")The url of the Gradient service to access.

*field* is\_chat\_model*: bool* *= False*[](#llama_index.llms.gradient.GradientBaseModelLLM.is_chat_model "Permalink to this definition")Whether the model is a chat model.

*field* max\_tokens*: Optional[int]* *= None*[](#llama_index.llms.gradient.GradientBaseModelLLM.max_tokens "Permalink to this definition")The number of tokens to generate.

Constraints* **exclusiveMinimum** = 0
* **exclusiveMaximum** = 512
*field* workspace\_id*: Optional[str]* *= None*[](#llama_index.llms.gradient.GradientBaseModelLLM.workspace_id "Permalink to this definition")The Gradient workspace id to use.

close() → None[](#llama_index.llms.gradient.GradientBaseModelLLM.close "Permalink to this definition")complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.gradient.GradientBaseModelLLM.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_complete(*prompt: str*, *\*\*kwargs: Any*) → Generator[[CompletionResponse](../llms.html#llama_index.llms.base.CompletionResponse "llama_index.llms.base.CompletionResponse"), None, None][](#llama_index.llms.gradient.GradientBaseModelLLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.gradient.GradientBaseModelLLM.metadata "Permalink to this definition")LLM metadata.

