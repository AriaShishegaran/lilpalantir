Finetuning[](#module-llama_index.finetuning "Permalink to this heading")
=========================================================================

Finetuning modules.

*class* llama\_index.finetuning.EmbeddingAdapterFinetuneEngine(*dataset: [EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")*, *embed\_model: BaseEmbedding*, *batch\_size: int = 10*, *epochs: int = 1*, *adapter\_model: Optional[Any] = None*, *dim: Optional[int] = None*, *device: Optional[str] = None*, *model\_output\_path: str = 'model\_output'*, *model\_checkpoint\_path: Optional[str] = None*, *checkpoint\_save\_steps: int = 100*, *verbose: bool = False*, *bias: bool = False*, *\*\*train\_kwargs: Any*)[](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine "Permalink to this definition")Embedding adapter finetune engine.

Parameters* **dataset** ([*EmbeddingQAFinetuneDataset*](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.EmbeddingQAFinetuneDataset")) – Dataset to finetune on.
* **embed\_model** (*BaseEmbedding*) – Embedding model to finetune.
* **batch\_size** (*Optional**[**int**]*) – Batch size. Defaults to 10.
* **epochs** (*Optional**[**int**]*) – Number of epochs. Defaults to 1.
* **dim** (*Optional**[**int**]*) – Dimension of embedding. Defaults to None.
* **adapter\_model** (*Optional**[**BaseAdapter**]*) – Adapter model. Defaults to None, in whichcase a linear adapter is used.
* **device** (*Optional**[**str**]*) – Device to use. Defaults to None.
* **model\_output\_path** (*str*) – Path to save model output. Defaults to “model\_output”.
* **model\_checkpoint\_path** (*Optional**[**str**]*) – Path to save model checkpoints.Defaults to None (don’t save checkpoints).
* **verbose** (*bool*) – Whether to show progress bar. Defaults to False.
* **bias** (*bool*) – Whether to use bias. Defaults to False.
finetune(*\*\*train\_kwargs: Any*) → None[](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine.finetune "Permalink to this definition")Finetune.

*classmethod* from\_model\_path(*dataset: [EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")*, *embed\_model: BaseEmbedding*, *model\_path: str*, *model\_cls: Optional[Type[Any]] = None*, *\*\*kwargs: Any*) → [EmbeddingAdapterFinetuneEngine](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine "llama_index.finetuning.embeddings.adapter.EmbeddingAdapterFinetuneEngine")[](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine.from_model_path "Permalink to this definition")Load from model path.

Parameters* **dataset** ([*EmbeddingQAFinetuneDataset*](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.EmbeddingQAFinetuneDataset")) – Dataset to finetune on.
* **embed\_model** (*BaseEmbedding*) – Embedding model to finetune.
* **model\_path** (*str*) – Path to model.
* **model\_cls** (*Optional**[**Type**[**Any**]**]*) – Adapter model class. Defaults to None.
* **\*\*kwargs** (*Any*) – Additional kwargs (see \_\_init\_\_)
get\_finetuned\_model(*\*\*model\_kwargs: Any*) → BaseEmbedding[](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine.get_finetuned_model "Permalink to this definition")Get finetuned model.

smart\_batching\_collate(*batch: List*) → Tuple[Any, Any][](#llama_index.finetuning.EmbeddingAdapterFinetuneEngine.smart_batching_collate "Permalink to this definition")Smart batching collate.

*pydantic model* llama\_index.finetuning.EmbeddingQAFinetuneDataset[](#llama_index.finetuning.EmbeddingQAFinetuneDataset "Permalink to this definition")Embedding QA Finetuning Dataset.

Parameters* **queries** (*Dict**[**str**,* *str**]*) – Dict id -> query.
* **corpus** (*Dict**[**str**,* *str**]*) – Dict id -> string.
* **relevant\_docs** (*Dict**[**str**,* *List**[**str**]**]*) – Dict query id -> list of doc ids.
Show JSON schema
```
{ "title": "EmbeddingQAFinetuneDataset", "description": "Embedding QA Finetuning Dataset.\n\nArgs:\n queries (Dict[str, str]): Dict id -> query.\n corpus (Dict[str, str]): Dict id -> string.\n relevant\_docs (Dict[str, List[str]]): Dict query id -> list of doc ids.", "type": "object", "properties": { "queries": { "title": "Queries", "type": "object", "additionalProperties": { "type": "string" } }, "corpus": { "title": "Corpus", "type": "object", "additionalProperties": { "type": "string" } }, "relevant\_docs": { "title": "Relevant Docs", "type": "object", "additionalProperties": { "type": "array", "items": { "type": "string" } } } }, "required": [ "queries", "corpus", "relevant\_docs" ]}
```


Fields* `corpus (Dict[str, str])`
* `queries (Dict[str, str])`
* `relevant\_docs (Dict[str, List[str]])`
*field* corpus*: Dict[str, str]* *[Required]*[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.corpus "Permalink to this definition")*field* queries*: Dict[str, str]* *[Required]*[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.queries "Permalink to this definition")*field* relevant\_docs*: Dict[str, List[str]]* *[Required]*[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.relevant_docs "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_json(*path: str*) → [EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.from_json "Permalink to this definition")Load json.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.parse_raw "Permalink to this definition")save\_json(*path: str*) → None[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.save_json "Permalink to this definition")Save json.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.validate "Permalink to this definition")*property* query\_docid\_pairs*: List[Tuple[str, List[str]]]*[](#llama_index.finetuning.EmbeddingQAFinetuneDataset.query_docid_pairs "Permalink to this definition")Get query, relevant doc ids.

*class* llama\_index.finetuning.GradientFinetuneEngine(*\**, *access\_token: Optional[str] = None*, *base\_model\_slug: str*, *data\_path: str*, *host: Optional[str] = None*, *learning\_rate: Optional[float] = None*, *name: str*, *rank: Optional[int] = None*, *workspace\_id: Optional[str] = None*)[](#llama_index.finetuning.GradientFinetuneEngine "Permalink to this definition")*class* llama\_index.finetuning.GradientFinetuneEngine(*\**, *access\_token: Optional[str] = None*, *data\_path: str*, *host: Optional[str] = None*, *model\_adapter\_id: str*, *workspace\_id: Optional[str] = None*)finetune() → None[](#llama_index.finetuning.GradientFinetuneEngine.finetune "Permalink to this definition")Goes off and does stuff.

get\_finetuned\_model(*\*\*model\_kwargs: Any*) → [GradientModelAdapterLLM](llms/gradient_model_adapter.html#llama_index.llms.gradient.GradientModelAdapterLLM "llama_index.llms.gradient.GradientModelAdapterLLM")[](#llama_index.finetuning.GradientFinetuneEngine.get_finetuned_model "Permalink to this definition")Gets finetuned model.

*class* llama\_index.finetuning.OpenAIFinetuneEngine(*base\_model: str*, *data\_path: str*, *verbose: bool = False*, *start\_job\_id: Optional[str] = None*, *validate\_json: bool = True*)[](#llama_index.finetuning.OpenAIFinetuneEngine "Permalink to this definition")OpenAI Finetuning Engine.

finetune() → None[](#llama_index.finetuning.OpenAIFinetuneEngine.finetune "Permalink to this definition")Finetune model.

*classmethod* from\_finetuning\_handler(*finetuning\_handler: [OpenAIFineTuningHandler](callbacks.html#llama_index.callbacks.OpenAIFineTuningHandler "llama_index.callbacks.finetuning_handler.OpenAIFineTuningHandler")*, *base\_model: str*, *data\_path: str*, *\*\*kwargs: Any*) → [OpenAIFinetuneEngine](#llama_index.finetuning.OpenAIFinetuneEngine "llama_index.finetuning.openai.base.OpenAIFinetuneEngine")[](#llama_index.finetuning.OpenAIFinetuneEngine.from_finetuning_handler "Permalink to this definition")Initialize from finetuning handler.

Used to finetune an OpenAI model into anotherOpenAI model (e.g. gpt-3.5-turbo on top of GPT-4).

get\_current\_job() → FineTuningJob[](#llama_index.finetuning.OpenAIFinetuneEngine.get_current_job "Permalink to this definition")Get current job.

get\_finetuned\_model(*\*\*model\_kwargs: Any*) → [LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")[](#llama_index.finetuning.OpenAIFinetuneEngine.get_finetuned_model "Permalink to this definition")Gets finetuned model.

*class* llama\_index.finetuning.SentenceTransformersFinetuneEngine(*dataset: [EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")*, *model\_id: str = 'BAAI/bge-small-en'*, *model\_output\_path: str = 'exp\_finetune'*, *batch\_size: int = 10*, *val\_dataset: Optional[[EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")] = None*, *loss: Optional[Any] = None*, *epochs: int = 2*, *show\_progress\_bar: bool = True*, *evaluation\_steps: int = 50*)[](#llama_index.finetuning.SentenceTransformersFinetuneEngine "Permalink to this definition")Sentence Transformers Finetune Engine.

finetune(*\*\*train\_kwargs: Any*) → None[](#llama_index.finetuning.SentenceTransformersFinetuneEngine.finetune "Permalink to this definition")Finetune model.

get\_finetuned\_model(*\*\*model\_kwargs: Any*) → BaseEmbedding[](#llama_index.finetuning.SentenceTransformersFinetuneEngine.get_finetuned_model "Permalink to this definition")Gets finetuned model.

llama\_index.finetuning.generate\_qa\_embedding\_pairs(*nodes: List[TextNode]*, *llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *qa\_generate\_prompt\_tmpl: str = 'Context information is below.\n\n---------------------\n{context\_str}\n---------------------\n\nGiven the context information and not prior knowledge.\ngenerate only questions based on the below query.\n\nYou are a Teacher/ Professor. Your task is to setup {num\_questions\_per\_chunk} questions for an upcoming quiz/examination. The questions should be diverse in nature across the document. Restrict the questions to the context information provided."\n'*, *num\_questions\_per\_chunk: int = 2*) → [EmbeddingQAFinetuneDataset](#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")[](#llama_index.finetuning.generate_qa_embedding_pairs "Permalink to this definition")Generate examples given a set of nodes.

