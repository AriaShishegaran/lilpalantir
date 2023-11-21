PaLM[](#palm "Permalink to this heading")
==========================================

*pydantic model* llama\_index.llms.palm.PaLM[](#llama_index.llms.palm.PaLM "Permalink to this definition")PaLM LLM.

Show JSON schema
```
{ "title": "PaLM", "description": "PaLM LLM.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model\_name": { "title": "Model Name", "description": "The PaLM model to use.", "type": "string" }, "num\_output": { "title": "Num Output", "description": "The number of tokens to generate.", "type": "integer" }, "generate\_kwargs": { "title": "Generate Kwargs", "description": "Kwargs for generation.", "type": "object" } }, "required": [ "model\_name", "num\_output" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`generate\_kwargs (dict)`](#llama_index.llms.palm.PaLM.generate_kwargs "llama_index.llms.palm.PaLM.generate_kwargs")
* [`model\_name (str)`](#llama_index.llms.palm.PaLM.model_name "llama_index.llms.palm.PaLM.model_name")
* [`num\_output (int)`](#llama_index.llms.palm.PaLM.num_output "llama_index.llms.palm.PaLM.num_output")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* generate\_kwargs*: dict* *[Optional]*[](#llama_index.llms.palm.PaLM.generate_kwargs "Permalink to this definition")Kwargs for generation.

*field* model\_name*: str* *[Required]*[](#llama_index.llms.palm.PaLM.model_name "Permalink to this definition")The PaLM model to use.

*field* num\_output*: int* *[Required]*[](#llama_index.llms.palm.PaLM.num_output "Permalink to this definition")The number of tokens to generate.

*classmethod* class\_name() → str[](#llama_index.llms.palm.PaLM.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.palm.PaLM.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.palm.PaLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.palm.PaLM.metadata "Permalink to this definition")Get LLM metadata.

