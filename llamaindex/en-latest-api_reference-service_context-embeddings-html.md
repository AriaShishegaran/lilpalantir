Embeddings[](#embeddings "Permalink to this heading")
======================================================

Users have a few options to choose from when it comes to embeddings.

* `OpenAIEmbedding`: the default embedding class. Defaults to “text-embedding-ada-002”
* `HuggingFaceEmbedding`: a generic wrapper around HuggingFace’s transformers models.
* `OptimumEmbedding`: support for usage and creation of ONNX models from Optimum and HuggingFace.
* `InstructorEmbedding`: a wrapper around Instructor embedding models.
* `LangchainEmbedding`: a wrapper around Langchain’s embedding models.
* `GoogleUnivSentEncoderEmbedding`: a wrapper around Google’s Universal Sentence Encoder.
* `AdapterEmbeddingModel`: an adapter around any embedding model.
OpenAIEmbedding[](#openaiembedding "Permalink to this heading")
================================================================

*pydantic model* llama\_index.embeddings.openai.OpenAIEmbedding[](#llama_index.embeddings.openai.OpenAIEmbedding "Permalink to this definition")OpenAI class for embeddings.

Parameters* **mode** (*str*) – Mode for embedding.Defaults to OpenAIEmbeddingMode.TEXT\_SEARCH\_MODE.Options are:


	+ OpenAIEmbeddingMode.SIMILARITY\_MODE
	+ OpenAIEmbeddingMode.TEXT\_SEARCH\_MODE
* **model** (*str*) – Model for embedding.Defaults to OpenAIEmbeddingModelType.TEXT\_EMBED\_ADA\_002.Options are:


	+ OpenAIEmbeddingModelType.DAVINCI
	+ OpenAIEmbeddingModelType.CURIE
	+ OpenAIEmbeddingModelType.BABBAGE
	+ OpenAIEmbeddingModelType.ADA
	+ OpenAIEmbeddingModelType.TEXT\_EMBED\_ADA\_002
Show JSON schema
```
{ "title": "OpenAIEmbedding", "description": "OpenAI class for embeddings.\n\nArgs:\n mode (str): Mode for embedding.\n Defaults to OpenAIEmbeddingMode.TEXT\_SEARCH\_MODE.\n Options are:\n\n - OpenAIEmbeddingMode.SIMILARITY\_MODE\n - OpenAIEmbeddingMode.TEXT\_SEARCH\_MODE\n\n model (str): Model for embedding.\n Defaults to OpenAIEmbeddingModelType.TEXT\_EMBED\_ADA\_002.\n Options are:\n\n - OpenAIEmbeddingModelType.DAVINCI\n - OpenAIEmbeddingModelType.CURIE\n - OpenAIEmbeddingModelType.BABBAGE\n - OpenAIEmbeddingModelType.ADA\n - OpenAIEmbeddingModelType.TEXT\_EMBED\_ADA\_002", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the OpenAI API.", "type": "object" }, "api\_key": { "title": "Api Key", "description": "The OpenAI API key.", "type": "string" }, "api\_base": { "title": "Api Base", "description": "The base URL for OpenAI API.", "type": "string" }, "api\_version": { "title": "Api Version", "description": "The version for OpenAI API.", "type": "string" }, "max\_retries": { "title": "Max Retries", "description": "Maximum number of retries.", "default": 10, "gte": 0, "type": "integer" }, "timeout": { "title": "Timeout", "description": "Timeout for each request.", "default": 60.0, "gte": 0, "type": "number" } }, "required": [ "api\_key", "api\_base", "api\_version" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`additional\_kwargs (Dict[str, Any])`](#llama_index.embeddings.openai.OpenAIEmbedding.additional_kwargs "llama_index.embeddings.openai.OpenAIEmbedding.additional_kwargs")
* [`api\_base (str)`](#llama_index.embeddings.openai.OpenAIEmbedding.api_base "llama_index.embeddings.openai.OpenAIEmbedding.api_base")
* [`api\_key (str)`](#llama_index.embeddings.openai.OpenAIEmbedding.api_key "llama_index.embeddings.openai.OpenAIEmbedding.api_key")
* [`api\_version (str)`](#llama_index.embeddings.openai.OpenAIEmbedding.api_version "llama_index.embeddings.openai.OpenAIEmbedding.api_version")
* [`max\_retries (int)`](#llama_index.embeddings.openai.OpenAIEmbedding.max_retries "llama_index.embeddings.openai.OpenAIEmbedding.max_retries")
* [`timeout (float)`](#llama_index.embeddings.openai.OpenAIEmbedding.timeout "llama_index.embeddings.openai.OpenAIEmbedding.timeout")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* additional\_kwargs*: Dict[str, Any]* *[Optional]*[](#llama_index.embeddings.openai.OpenAIEmbedding.additional_kwargs "Permalink to this definition")Additional kwargs for the OpenAI API.

*field* api\_base*: str* *[Required]*[](#llama_index.embeddings.openai.OpenAIEmbedding.api_base "Permalink to this definition")The base URL for OpenAI API.

*field* api\_key*: str* *[Required]*[](#llama_index.embeddings.openai.OpenAIEmbedding.api_key "Permalink to this definition")The OpenAI API key.

*field* api\_version*: str* *[Required]*[](#llama_index.embeddings.openai.OpenAIEmbedding.api_version "Permalink to this definition")The version for OpenAI API.

*field* max\_retries*: int* *= 10*[](#llama_index.embeddings.openai.OpenAIEmbedding.max_retries "Permalink to this definition")Maximum number of retries.

*field* timeout*: float* *= 60.0*[](#llama_index.embeddings.openai.OpenAIEmbedding.timeout "Permalink to this definition")Timeout for each request.

*classmethod* class\_name() → str[](#llama_index.embeddings.openai.OpenAIEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

HuggingFaceEmbedding[](#huggingfaceembedding "Permalink to this heading")
==========================================================================

*pydantic model* llama\_index.embeddings.huggingface.HuggingFaceEmbedding[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding "Permalink to this definition")Show JSON schema
```
{ "title": "HuggingFaceEmbedding", "description": "Base class for embeddings.", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" }, "tokenizer\_name": { "title": "Tokenizer Name", "description": "Tokenizer name from HuggingFace.", "type": "string" }, "max\_length": { "title": "Max Length", "description": "Maximum length of input.", "type": "integer" }, "pooling": { "description": "Pooling strategy.", "default": "cls", "allOf": [ { "$ref": "#/definitions/Pooling" } ] }, "normalize": { "title": "Normalize", "description": "Normalize embeddings or not.", "default": true, "type": "string" }, "query\_instruction": { "title": "Query Instruction", "description": "Instruction to prepend to query text.", "type": "string" }, "text\_instruction": { "title": "Text Instruction", "description": "Instruction to prepend to text.", "type": "string" }, "cache\_folder": { "title": "Cache Folder", "description": "Cache folder for huggingface files.", "type": "string" } }, "required": [ "tokenizer\_name", "max\_length" ], "definitions": { "Pooling": { "title": "Pooling", "description": "Enum of possible pooling choices with pooling behaviors.", "enum": [ "cls", "mean" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`cache\_folder (Optional[str])`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.cache_folder "llama_index.embeddings.huggingface.HuggingFaceEmbedding.cache_folder")
* [`max\_length (int)`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.max_length "llama_index.embeddings.huggingface.HuggingFaceEmbedding.max_length")
* [`normalize (str)`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.normalize "llama_index.embeddings.huggingface.HuggingFaceEmbedding.normalize")
* [`pooling (llama\_index.embeddings.pooling.Pooling)`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.pooling "llama_index.embeddings.huggingface.HuggingFaceEmbedding.pooling")
* [`query\_instruction (Optional[str])`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.query_instruction "llama_index.embeddings.huggingface.HuggingFaceEmbedding.query_instruction")
* [`text\_instruction (Optional[str])`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.text_instruction "llama_index.embeddings.huggingface.HuggingFaceEmbedding.text_instruction")
* [`tokenizer\_name (str)`](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.tokenizer_name "llama_index.embeddings.huggingface.HuggingFaceEmbedding.tokenizer_name")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* cache\_folder*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.cache_folder "Permalink to this definition")Cache folder for huggingface files.

*field* max\_length*: int* *[Required]*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.max_length "Permalink to this definition")Maximum length of input.

*field* normalize*: str* *= True*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.normalize "Permalink to this definition")Normalize embeddings or not.

*field* pooling*: Pooling* *= Pooling.CLS*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.pooling "Permalink to this definition")Pooling strategy.

*field* query\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.query_instruction "Permalink to this definition")Instruction to prepend to query text.

*field* text\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.text_instruction "Permalink to this definition")Instruction to prepend to text.

*field* tokenizer\_name*: str* *[Required]*[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.tokenizer_name "Permalink to this definition")Tokenizer name from HuggingFace.

*classmethod* class\_name() → str[](#llama_index.embeddings.huggingface.HuggingFaceEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

OptimumEmbedding[](#optimumembedding "Permalink to this heading")
==================================================================

*pydantic model* llama\_index.embeddings.huggingface\_optimum.OptimumEmbedding[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding "Permalink to this definition")Show JSON schema
```
{ "title": "OptimumEmbedding", "description": "Base class for embeddings.", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" }, "folder\_name": { "title": "Folder Name", "description": "Folder name to load from.", "type": "string" }, "max\_length": { "title": "Max Length", "description": "Maximum length of input.", "type": "integer" }, "pooling": { "title": "Pooling", "description": "Pooling strategy. One of ['cls', 'mean'].", "type": "string" }, "normalize": { "title": "Normalize", "description": "Normalize embeddings or not.", "default": true, "type": "string" }, "query\_instruction": { "title": "Query Instruction", "description": "Instruction to prepend to query text.", "type": "string" }, "text\_instruction": { "title": "Text Instruction", "description": "Instruction to prepend to text.", "type": "string" }, "cache\_folder": { "title": "Cache Folder", "description": "Cache folder for huggingface files.", "type": "string" } }, "required": [ "folder\_name", "max\_length", "pooling" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`cache\_folder (Optional[str])`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.cache_folder "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.cache_folder")
* [`folder\_name (str)`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.folder_name "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.folder_name")
* [`max\_length (int)`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.max_length "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.max_length")
* [`normalize (str)`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.normalize "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.normalize")
* [`pooling (str)`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.pooling "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.pooling")
* [`query\_instruction (Optional[str])`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.query_instruction "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.query_instruction")
* [`text\_instruction (Optional[str])`](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.text_instruction "llama_index.embeddings.huggingface_optimum.OptimumEmbedding.text_instruction")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* cache\_folder*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.cache_folder "Permalink to this definition")Cache folder for huggingface files.

*field* folder\_name*: str* *[Required]*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.folder_name "Permalink to this definition")Folder name to load from.

*field* max\_length*: int* *[Required]*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.max_length "Permalink to this definition")Maximum length of input.

*field* normalize*: str* *= True*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.normalize "Permalink to this definition")Normalize embeddings or not.

*field* pooling*: str* *[Required]*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.pooling "Permalink to this definition")Pooling strategy. One of [‘cls’, ‘mean’].

*field* query\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.query_instruction "Permalink to this definition")Instruction to prepend to query text.

*field* text\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.text_instruction "Permalink to this definition")Instruction to prepend to text.

*classmethod* class\_name() → str[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* create\_and\_save\_optimum\_model(*model\_name\_or\_path: str*, *output\_path: str*, *export\_kwargs: Optional[dict] = None*) → None[](#llama_index.embeddings.huggingface_optimum.OptimumEmbedding.create_and_save_optimum_model "Permalink to this definition")InstructorEmbedding[](#instructorembedding "Permalink to this heading")
========================================================================

*pydantic model* llama\_index.embeddings.instructor.InstructorEmbedding[](#llama_index.embeddings.instructor.InstructorEmbedding "Permalink to this definition")Show JSON schema
```
{ "title": "InstructorEmbedding", "description": "Base class for embeddings.", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" }, "query\_instruction": { "title": "Query Instruction", "description": "Instruction to prepend to query text.", "type": "string" }, "text\_instruction": { "title": "Text Instruction", "description": "Instruction to prepend to text.", "type": "string" }, "cache\_folder": { "title": "Cache Folder", "description": "Cache folder for huggingface files.", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`cache\_folder (Optional[str])`](#llama_index.embeddings.instructor.InstructorEmbedding.cache_folder "llama_index.embeddings.instructor.InstructorEmbedding.cache_folder")
* [`query\_instruction (Optional[str])`](#llama_index.embeddings.instructor.InstructorEmbedding.query_instruction "llama_index.embeddings.instructor.InstructorEmbedding.query_instruction")
* [`text\_instruction (Optional[str])`](#llama_index.embeddings.instructor.InstructorEmbedding.text_instruction "llama_index.embeddings.instructor.InstructorEmbedding.text_instruction")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
*field* cache\_folder*: Optional[str]* *= None*[](#llama_index.embeddings.instructor.InstructorEmbedding.cache_folder "Permalink to this definition")Cache folder for huggingface files.

*field* query\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.instructor.InstructorEmbedding.query_instruction "Permalink to this definition")Instruction to prepend to query text.

*field* text\_instruction*: Optional[str]* *= None*[](#llama_index.embeddings.instructor.InstructorEmbedding.text_instruction "Permalink to this definition")Instruction to prepend to text.

*classmethod* class\_name() → str[](#llama_index.embeddings.instructor.InstructorEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

LangchainEmbedding[](#langchainembedding "Permalink to this heading")
======================================================================

*pydantic model* llama\_index.embeddings.langchain.LangchainEmbedding[](#llama_index.embeddings.langchain.LangchainEmbedding "Permalink to this definition")External embeddings (taken from Langchain).

Parameters**langchain\_embedding** (*langchain.embeddings.Embeddings*) – Langchainembeddings class.

Show JSON schema
```
{ "title": "LangchainEmbedding", "description": "External embeddings (taken from Langchain).\n\nArgs:\n langchain\_embedding (langchain.embeddings.Embeddings): Langchain\n embeddings class.", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
FieldsValidators* `\_validate\_callback\_manager` » `callback\_manager`
*classmethod* class\_name() → str[](#llama_index.embeddings.langchain.LangchainEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

GoogleUnivSentEncoderEmbedding[](#googleunivsentencoderembedding "Permalink to this heading")
==============================================================================================

*pydantic model* llama\_index.embeddings.google.GoogleUnivSentEncoderEmbedding[](#llama_index.embeddings.google.GoogleUnivSentEncoderEmbedding "Permalink to this definition")Show JSON schema
```
{ "title": "GoogleUnivSentEncoderEmbedding", "description": "Base class for embeddings.", "type": "object", "properties": { "model\_name": { "title": "Model Name", "description": "The name of the embedding model.", "default": "unknown", "type": "string" }, "embed\_batch\_size": { "title": "Embed Batch Size", "description": "The batch size for embedding calls.", "default": 10, "type": "integer" }, "callback\_manager": { "title": "Callback Manager" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
FieldsValidators* `\_validate\_callback\_manager` » `callback\_manager`
*classmethod* class\_name() → str[](#llama_index.embeddings.google.GoogleUnivSentEncoderEmbedding.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

