PromptHelper[](#module-llama_index.indices.prompt_helper "Permalink to this heading")
======================================================================================

General prompt helper that can help deal with LLM context window token limitations.

At its core, it calculates available context size by starting with the context windowsize of an LLM and reserve token space for the prompt template, and the output.

It provides utility for “repacking” text chunks (retrieved from index) to maximallymake use of the available context window (and thereby reducing the number of LLM callsneeded), or truncating them so that they fit in a single LLM call.

*pydantic model* llama\_index.indices.prompt\_helper.PromptHelper[](#llama_index.indices.prompt_helper.PromptHelper "Permalink to this definition")Prompt helper.

General prompt helper that can help deal with LLM context window token limitations.

At its core, it calculates available context size by starting with the contextwindow size of an LLM and reserve token space for the prompt template, and theoutput.

It provides utility for “repacking” text chunks (retrieved from index) to maximallymake use of the available context window (and thereby reducing the number of LLMcalls needed), or truncating them so that they fit in a single LLM call.

Parameters* **context\_window** (*int*) – Context window for the LLM.
* **num\_output** (*int*) – Number of outputs for the LLM.
* **chunk\_overlap\_ratio** (*float*) – Chunk overlap as a ratio of chunk size
* **chunk\_size\_limit** (*Optional**[**int**]*) – Maximum chunk size to use.
* **tokenizer** (*Optional**[**Callable**[**[**str**]**,* *List**]**]*) – Tokenizer to use.
* **separator** (*str*) – Separator for text splitter
Show JSON schema
```
{ "title": "PromptHelper", "description": "Prompt helper.\n\nGeneral prompt helper that can help deal with LLM context window token limitations.\n\nAt its core, it calculates available context size by starting with the context\nwindow size of an LLM and reserve token space for the prompt template, and the\noutput.\n\nIt provides utility for \"repacking\" text chunks (retrieved from index) to maximally\nmake use of the available context window (and thereby reducing the number of LLM\ncalls needed), or truncating them so that they fit in a single LLM call.\n\nArgs:\n context\_window (int): Context window for the LLM.\n num\_output (int): Number of outputs for the LLM.\n chunk\_overlap\_ratio (float): Chunk overlap as a ratio of chunk size\n chunk\_size\_limit (Optional[int]): Maximum chunk size to use.\n tokenizer (Optional[Callable[[str], List]]): Tokenizer to use.\n separator (str): Separator for text splitter", "type": "object", "properties": { "context\_window": { "title": "Context Window", "description": "The maximum context size that will get sent to the LLM.", "default": 3900, "type": "integer" }, "num\_output": { "title": "Num Output", "description": "The amount of token-space to leave in input for generation.", "default": 256, "type": "integer" }, "chunk\_overlap\_ratio": { "title": "Chunk Overlap Ratio", "description": "The percentage token amount that each chunk should overlap.", "default": 0.1, "type": "number" }, "chunk\_size\_limit": { "title": "Chunk Size Limit", "description": "The maximum size of a chunk.", "type": "integer" }, "separator": { "title": "Separator", "description": "The separator when chunking tokens.", "default": " ", "type": "string" } }}
```


Fields* [`chunk\_overlap\_ratio (float)`](#llama_index.indices.prompt_helper.PromptHelper.chunk_overlap_ratio "llama_index.indices.prompt_helper.PromptHelper.chunk_overlap_ratio")
* [`chunk\_size\_limit (Optional[int])`](#llama_index.indices.prompt_helper.PromptHelper.chunk_size_limit "llama_index.indices.prompt_helper.PromptHelper.chunk_size_limit")
* [`context\_window (int)`](#llama_index.indices.prompt_helper.PromptHelper.context_window "llama_index.indices.prompt_helper.PromptHelper.context_window")
* [`num\_output (int)`](#llama_index.indices.prompt_helper.PromptHelper.num_output "llama_index.indices.prompt_helper.PromptHelper.num_output")
* [`separator (str)`](#llama_index.indices.prompt_helper.PromptHelper.separator "llama_index.indices.prompt_helper.PromptHelper.separator")
*field* chunk\_overlap\_ratio*: float* *= 0.1*[](#llama_index.indices.prompt_helper.PromptHelper.chunk_overlap_ratio "Permalink to this definition")The percentage token amount that each chunk should overlap.

*field* chunk\_size\_limit*: Optional[int]* *= None*[](#llama_index.indices.prompt_helper.PromptHelper.chunk_size_limit "Permalink to this definition")The maximum size of a chunk.

*field* context\_window*: int* *= 3900*[](#llama_index.indices.prompt_helper.PromptHelper.context_window "Permalink to this definition")The maximum context size that will get sent to the LLM.

*field* num\_output*: int* *= 256*[](#llama_index.indices.prompt_helper.PromptHelper.num_output "Permalink to this definition")The amount of token-space to leave in input for generation.

*field* separator*: str* *= ' '*[](#llama_index.indices.prompt_helper.PromptHelper.separator "Permalink to this definition")The separator when chunking tokens.

*classmethod* class\_name() → str[](#llama_index.indices.prompt_helper.PromptHelper.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.indices.prompt_helper.PromptHelper.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.prompt_helper.PromptHelper.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.indices.prompt_helper.PromptHelper.from_json "Permalink to this definition")*classmethod* from\_llm\_metadata(*llm\_metadata: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*, *chunk\_overlap\_ratio: float = 0.1*, *chunk\_size\_limit: Optional[int] = None*, *tokenizer: Optional[Callable[[str], List]] = None*, *separator: str = ' '*) → [PromptHelper](#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")[](#llama_index.indices.prompt_helper.PromptHelper.from_llm_metadata "Permalink to this definition")Create from llm predictor.

This will autofill values like context\_window and num\_output.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.from_orm "Permalink to this definition")get\_text\_splitter\_given\_prompt(*prompt: [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *num\_chunks: int = 1*, *padding: int = 5*) → TokenTextSplitter[](#llama_index.indices.prompt_helper.PromptHelper.get_text_splitter_given_prompt "Permalink to this definition")Get text splitter configured to maximally pack available context window,taking into account of given prompt, and desired number of chunks.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.prompt_helper.PromptHelper.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.parse_raw "Permalink to this definition")repack(*prompt: [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *text\_chunks: Sequence[str]*, *padding: int = 5*) → List[str][](#llama_index.indices.prompt_helper.PromptHelper.repack "Permalink to this definition")Repack text chunks to fit available context window.

This will combine text chunks into consolidated chunksthat more fully “pack” the prompt template given the context\_window.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.indices.prompt_helper.PromptHelper.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.indices.prompt_helper.PromptHelper.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.indices.prompt_helper.PromptHelper.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.indices.prompt_helper.PromptHelper.to_json "Permalink to this definition")truncate(*prompt: [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *text\_chunks: Sequence[str]*, *padding: int = 5*) → List[str][](#llama_index.indices.prompt_helper.PromptHelper.truncate "Permalink to this definition")Truncate text chunks to fit available context window.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.indices.prompt_helper.PromptHelper.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.indices.prompt_helper.PromptHelper.validate "Permalink to this definition")