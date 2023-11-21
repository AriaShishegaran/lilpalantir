Evaluation[](#evaluation "Permalink to this heading")
======================================================

We have modules for both LLM-based evaluation and retrieval-based evaluation.

Evaluation modules.

*class* llama\_index.evaluation.BaseEvaluator[](#llama_index.evaluation.BaseEvaluator "Permalink to this definition")Base Evaluator class.

*abstract async* aevaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.BaseEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.BaseEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.BaseEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.BaseEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.BaseEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.BaseEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*pydantic model* llama\_index.evaluation.BaseRetrievalEvaluator[](#llama_index.evaluation.BaseRetrievalEvaluator "Permalink to this definition")Base Retrieval Evaluator class.

Show JSON schema
```
{ "title": "BaseRetrievalEvaluator", "description": "Base Retrieval Evaluator class.", "type": "object", "properties": { "metrics": { "title": "Metrics" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `metrics (List[llama\_index.evaluation.retrieval.metrics\_base.BaseRetrievalMetric])`
*field* metrics*: List[BaseRetrievalMetric]* *[Required]*[](#llama_index.evaluation.BaseRetrievalEvaluator.metrics "Permalink to this definition")List of metrics to evaluate

*async* aevaluate(*query: str*, *expected\_ids: List[str]*, *\*\*kwargs: Any*) → [RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")[](#llama_index.evaluation.BaseRetrievalEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_dataset(*dataset: [EmbeddingQAFinetuneDataset](finetuning.html#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")*, *workers: int = 2*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → List[[RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")][](#llama_index.evaluation.BaseRetrievalEvaluator.aevaluate_dataset "Permalink to this definition")Run evaluation with dataset.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.BaseRetrievalEvaluator.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

evaluate(*query: str*, *expected\_ids: List[str]*, *\*\*kwargs: Any*) → [RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")[](#llama_index.evaluation.BaseRetrievalEvaluator.evaluate "Permalink to this definition")Run evaluation results with query string and expected ids.

Parameters* **query** (*str*) – Query string
* **expected\_ids** (*List**[**str**]*) – Expected ids
ReturnsEvaluation result

Return type[RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.RetrievalEvalResult")

*classmethod* from\_metric\_names(*metric\_names: List[str]*, *\*\*kwargs: Any*) → [BaseRetrievalEvaluator](#llama_index.evaluation.BaseRetrievalEvaluator "llama_index.evaluation.retrieval.base.BaseRetrievalEvaluator")[](#llama_index.evaluation.BaseRetrievalEvaluator.from_metric_names "Permalink to this definition")Create evaluator from metric names.

Parameters* **metric\_names** (*List**[**str**]*) – List of metric names
* **\*\*kwargs** – Additional arguments for the evaluator
*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.BaseRetrievalEvaluator.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.BaseRetrievalEvaluator.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.BaseRetrievalEvaluator.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.BaseRetrievalEvaluator.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.BaseRetrievalEvaluator.validate "Permalink to this definition")*class* llama\_index.evaluation.BatchEvalRunner(*evaluators: Dict[str, [BaseEvaluator](#llama_index.evaluation.BaseEvaluator "llama_index.evaluation.base.BaseEvaluator")]*, *workers: int = 2*, *show\_progress: bool = False*)[](#llama_index.evaluation.BatchEvalRunner "Permalink to this definition")Batch evaluation runner.

Parameters* **evaluators** (*Dict**[**str**,* [*BaseEvaluator*](#llama_index.evaluation.BaseEvaluator "llama_index.evaluation.BaseEvaluator")*]*) – Dictionary of evaluators.
* **workers** (*int*) – Number of workers to use for parallelization.Defaults to 2.
* **show\_progress** (*bool*) – Whether to show progress bars. Defaults to False.
*async* aevaluate\_queries(*query\_engine: BaseQueryEngine*, *queries: Optional[List[str]] = None*, *\*\*eval\_kwargs\_lists: Dict[str, Any]*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.aevaluate_queries "Permalink to this definition")Evaluate queries.

Parameters* **query\_engine** (*BaseQueryEngine*) – Query engine.
* **queries** (*Optional**[**List**[**str**]**]*) – List of query strings. Defaults to None.
* **\*\*eval\_kwargs\_lists** (*Dict**[**str**,* *Any**]*) – Dict of lists of kwargs topass to evaluator. Defaults to None.
*async* aevaluate\_response\_strs(*queries: Optional[List[str]] = None*, *response\_strs: Optional[List[str]] = None*, *contexts\_list: Optional[List[List[str]]] = None*, *\*\*eval\_kwargs\_lists: List*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.aevaluate_response_strs "Permalink to this definition")Evaluate query, response pairs.

This evaluates queries, responses, contexts as string inputs.Can supply additional kwargs to the evaluator in eval\_kwargs\_lists.

Parameters* **queries** (*Optional**[**List**[**str**]**]*) – List of query strings. Defaults to None.
* **response\_strs** (*Optional**[**List**[**str**]**]*) – List of response strings.Defaults to None.
* **contexts\_list** (*Optional**[**List**[**List**[**str**]**]**]*) – List of context lists.Defaults to None.
* **\*\*eval\_kwargs\_lists** (*Dict**[**str**,* *Any**]*) – Dict of lists of kwargs topass to evaluator. Defaults to None.
*async* aevaluate\_responses(*queries: Optional[List[str]] = None*, *responses: Optional[List[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")]] = None*, *\*\*eval\_kwargs\_lists: Dict[str, Any]*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.aevaluate_responses "Permalink to this definition")Evaluate query, response pairs.

This evaluates queries and response objects.

Parameters* **queries** (*Optional**[**List**[**str**]**]*) – List of query strings. Defaults to None.
* **responses** (*Optional**[**List**[*[*Response*](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")*]**]*) – List of response objects.Defaults to None.
* **\*\*eval\_kwargs\_lists** (*Dict**[**str**,* *Any**]*) – Dict of lists of kwargs topass to evaluator. Defaults to None.
evaluate\_queries(*query\_engine: BaseQueryEngine*, *queries: Optional[List[str]] = None*, *\*\*eval\_kwargs\_lists: Dict[str, Any]*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.evaluate_queries "Permalink to this definition")Evaluate queries.

Sync version of aevaluate\_queries.

evaluate\_response\_strs(*queries: Optional[List[str]] = None*, *response\_strs: Optional[List[str]] = None*, *contexts\_list: Optional[List[List[str]]] = None*, *\*\*eval\_kwargs\_lists: List*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.evaluate_response_strs "Permalink to this definition")Evaluate query, response pairs.

Sync version of aevaluate\_response\_strs.

evaluate\_responses(*queries: Optional[List[str]] = None*, *responses: Optional[List[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")]] = None*, *\*\*eval\_kwargs\_lists: Dict[str, Any]*) → Dict[str, List[[EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")]][](#llama_index.evaluation.BatchEvalRunner.evaluate_responses "Permalink to this definition")Evaluate query, response objs.

Sync version of aevaluate\_responses.

*class* llama\_index.evaluation.CorrectnessEvaluator(*service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *eval\_template: Optional[Union[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate"), str]] = None*, *score\_threshold: float = 4.0*)[](#llama_index.evaluation.CorrectnessEvaluator "Permalink to this definition")Correctness evaluator.

Evaluates the correctness of a question answering system.This evaluator depends on reference answer to be provided, in addition to thequery string and response string.

It outputs a score between 1 and 5, where 1 is the worst and 5 is the best,along with a reasoning for the score.Passing is defined as a score greater than or equal to the given threshold.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – Service context.
* **eval\_template** (*Optional**[**Union**[*[*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*,* *str**]**]*) – Template for the evaluation prompt.
* **score\_threshold** (*float*) – Numerical threshold for passing the evaluation,defaults to 4.0.
*async* aevaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *reference: Optional[str] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.CorrectnessEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.CorrectnessEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.CorrectnessEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.CorrectnessEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.CorrectnessEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.CorrectnessEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.evaluation.DatasetGenerator(*nodes: List[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *service\_context: [llama\_index.indices.service\_context.ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext") | None = None*, *num\_questions\_per\_chunk: int = 10*, *text\_question\_template: [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *text\_qa\_template: [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *question\_gen\_query: str | None = None*, *metadata\_mode: [MetadataMode](node.html#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.NONE*, *show\_progress: bool = False*)[](#llama_index.evaluation.DatasetGenerator "Permalink to this definition")Generate dataset (question/ question-answer pairs) based on the given documents.

NOTE: this is a beta feature, subject to change!

Parameters* **nodes** (*List**[**Node**]*) – List of nodes. (Optional)
* **service\_context** ([*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")) – Service Context.
* **num\_questions\_per\_chunk** – number of question to be generated per chunk. Each document is chunked of size 512 words.
* **text\_question\_template** – Question generation template.
* **question\_gen\_query** – Question generation query.
*async* agenerate\_dataset\_from\_nodes(*num: int | None = None*) → [QueryResponseDataset](#llama_index.evaluation.QueryResponseDataset "llama_index.evaluation.dataset_generation.QueryResponseDataset")[](#llama_index.evaluation.DatasetGenerator.agenerate_dataset_from_nodes "Permalink to this definition")Generates questions for each document.

*async* agenerate\_questions\_from\_nodes(*num: int | None = None*) → List[str][](#llama_index.evaluation.DatasetGenerator.agenerate_questions_from_nodes "Permalink to this definition")Generates questions for each document.

*classmethod* from\_documents(*documents: List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *service\_context: [llama\_index.indices.service\_context.ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext") | None = None*, *num\_questions\_per\_chunk: int = 10*, *text\_question\_template: [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *text\_qa\_template: [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *question\_gen\_query: str | None = None*, *required\_keywords: Optional[List[str]] = None*, *exclude\_keywords: Optional[List[str]] = None*, *show\_progress: bool = False*) → [DatasetGenerator](#llama_index.evaluation.DatasetGenerator "llama_index.evaluation.dataset_generation.DatasetGenerator")[](#llama_index.evaluation.DatasetGenerator.from_documents "Permalink to this definition")Generate dataset from documents.

generate\_dataset\_from\_nodes(*num: int | None = None*) → [QueryResponseDataset](#llama_index.evaluation.QueryResponseDataset "llama_index.evaluation.dataset_generation.QueryResponseDataset")[](#llama_index.evaluation.DatasetGenerator.generate_dataset_from_nodes "Permalink to this definition")Generates questions for each document.

generate\_questions\_from\_nodes(*num: int | None = None*) → List[str][](#llama_index.evaluation.DatasetGenerator.generate_questions_from_nodes "Permalink to this definition")Generates questions for each document.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.DatasetGenerator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.DatasetGenerator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*pydantic model* llama\_index.evaluation.EmbeddingQAFinetuneDataset[](#llama_index.evaluation.EmbeddingQAFinetuneDataset "Permalink to this definition")Embedding QA Finetuning Dataset.

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
*field* corpus*: Dict[str, str]* *[Required]*[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.corpus "Permalink to this definition")*field* queries*: Dict[str, str]* *[Required]*[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.queries "Permalink to this definition")*field* relevant\_docs*: Dict[str, List[str]]* *[Required]*[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.relevant_docs "Permalink to this definition")*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_json(*path: str*) → [EmbeddingQAFinetuneDataset](finetuning.html#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.from_json "Permalink to this definition")Load json.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.parse_raw "Permalink to this definition")save\_json(*path: str*) → None[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.save_json "Permalink to this definition")Save json.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.validate "Permalink to this definition")*property* query\_docid\_pairs*: List[Tuple[str, List[str]]]*[](#llama_index.evaluation.EmbeddingQAFinetuneDataset.query_docid_pairs "Permalink to this definition")Get query, relevant doc ids.

*pydantic model* llama\_index.evaluation.EvaluationResult[](#llama_index.evaluation.EvaluationResult "Permalink to this definition")Evaluation result.

Output of an BaseEvaluator.

Show JSON schema
```
{ "title": "EvaluationResult", "description": "Evaluation result.\n\nOutput of an BaseEvaluator.", "type": "object", "properties": { "query": { "title": "Query", "description": "Query string", "type": "string" }, "contexts": { "title": "Contexts", "description": "Context strings", "type": "array", "items": { "type": "string" } }, "response": { "title": "Response", "description": "Response string", "type": "string" }, "passing": { "title": "Passing", "description": "Binary evaluation result (passing or not)", "type": "boolean" }, "feedback": { "title": "Feedback", "description": "Feedback or reasoning for the response", "type": "string" }, "score": { "title": "Score", "description": "Score for the response", "type": "number" }, "pairwise\_source": { "title": "Pairwise Source", "description": "Used only for pairwise and specifies whether it is from original order of presented answers or flipped order", "type": "string" } }}
```


Fields* `contexts (Optional[Sequence[str]])`
* `feedback (Optional[str])`
* `pairwise\_source (Optional[str])`
* `passing (Optional[bool])`
* `query (Optional[str])`
* `response (Optional[str])`
* `score (Optional[float])`
*field* contexts*: Optional[Sequence[str]]* *= None*[](#llama_index.evaluation.EvaluationResult.contexts "Permalink to this definition")Context strings

*field* feedback*: Optional[str]* *= None*[](#llama_index.evaluation.EvaluationResult.feedback "Permalink to this definition")Feedback or reasoning for the response

*field* pairwise\_source*: Optional[str]* *= None*[](#llama_index.evaluation.EvaluationResult.pairwise_source "Permalink to this definition")Used only for pairwise and specifies whether it is from original order of presented answers or flipped order

*field* passing*: Optional[bool]* *= None*[](#llama_index.evaluation.EvaluationResult.passing "Permalink to this definition")Binary evaluation result (passing or not)

*field* query*: Optional[str]* *= None*[](#llama_index.evaluation.EvaluationResult.query "Permalink to this definition")Query string

*field* response*: Optional[str]* *= None*[](#llama_index.evaluation.EvaluationResult.response "Permalink to this definition")Response string

*field* score*: Optional[float]* *= None*[](#llama_index.evaluation.EvaluationResult.score "Permalink to this definition")Score for the response

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.EvaluationResult.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.EvaluationResult.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.EvaluationResult.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.EvaluationResult.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.EvaluationResult.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.EvaluationResult.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.EvaluationResult.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.EvaluationResult.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.EvaluationResult.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.EvaluationResult.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.EvaluationResult.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.EvaluationResult.validate "Permalink to this definition")*class* llama\_index.evaluation.FaithfulnessEvaluator(*service\_context: [llama\_index.indices.service\_context.ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext") | None = None*, *raise\_error: bool = False*, *eval\_template: str | [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *refine\_template: str | [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*)[](#llama_index.evaluation.FaithfulnessEvaluator "Permalink to this definition")Faithfulness evaluator.

Evaluates whether a response is faithful to the contexts(i.e. whether the response is supported by the contexts or hallucinated.)

This evaluator only considers the response string and the list of context strings.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – The service context to use for evaluation.
* **raise\_error** (*bool*) – Whether to raise an error when the response is invalid.Defaults to False.
* **eval\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for evaluation.
* **refine\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for refining the evaluation.
*async* aevaluate(*query: str | None = None*, *response: str | None = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.FaithfulnessEvaluator.aevaluate "Permalink to this definition")Evaluate whether the response is faithful to the contexts.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.FaithfulnessEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.FaithfulnessEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.FaithfulnessEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.FaithfulnessEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.FaithfulnessEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.evaluation.GuidelineEvaluator(*service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *guidelines: Optional[str] = None*, *eval\_template: Optional[Union[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate"), str]] = None*)[](#llama_index.evaluation.GuidelineEvaluator "Permalink to this definition")Guideline evaluator.

Evaluates whether a query and response pair passes the given guidelines.

This evaluator only considers the query string and the response string.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – The service context to use for evaluation.
* **guidelines** (*Optional**[**str**]*) – User-added guidelines to use for evaluation.Defaults to None, which uses the default guidelines.
* **eval\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for evaluation.
*async* aevaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.GuidelineEvaluator.aevaluate "Permalink to this definition")Evaluate whether the query and response pair passes the guidelines.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.GuidelineEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.GuidelineEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.GuidelineEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.GuidelineEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.GuidelineEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.evaluation.HitRate[](#llama_index.evaluation.HitRate "Permalink to this definition")Hit rate metric.

compute(*query: Optional[str] = None*, *expected\_ids: Optional[List[str]] = None*, *retrieved\_ids: Optional[List[str]] = None*, *\*\*kwargs: Any*) → [RetrievalMetricResult](#llama_index.evaluation.RetrievalMetricResult "llama_index.evaluation.retrieval.metrics_base.RetrievalMetricResult")[](#llama_index.evaluation.HitRate.compute "Permalink to this definition")Compute metric.

*class* llama\_index.evaluation.MRR[](#llama_index.evaluation.MRR "Permalink to this definition")MRR metric.

compute(*query: Optional[str] = None*, *expected\_ids: Optional[List[str]] = None*, *retrieved\_ids: Optional[List[str]] = None*, *\*\*kwargs: Any*) → [RetrievalMetricResult](#llama_index.evaluation.RetrievalMetricResult "llama_index.evaluation.retrieval.metrics_base.RetrievalMetricResult")[](#llama_index.evaluation.MRR.compute "Permalink to this definition")Compute metric.

*class* llama\_index.evaluation.PairwiseComparisonEvaluator(*service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *eval\_template: Optional[Union[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate"), str]] = None*, *enforce\_consensus: bool = True*)[](#llama_index.evaluation.PairwiseComparisonEvaluator "Permalink to this definition")Pairwise comparison evaluator.

Evaluates the quality of a response vs. a “reference” response given a question byhaving an LLM judge which response is better.

Outputs whether the response given is better than the reference response.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – The service context to use for evaluation.
* **eval\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for evaluation.
* **enforce\_consensus** (*bool*) – Whether to enforce consensus (consistency if weflip the order of the answers). Defaults to True.
*async* aevaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *second\_response: Optional[str] = None*, *reference: Optional[str] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.PairwiseComparisonEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.PairwiseComparisonEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.PairwiseComparisonEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.PairwiseComparisonEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.PairwiseComparisonEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.PairwiseComparisonEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*pydantic model* llama\_index.evaluation.QueryResponseDataset[](#llama_index.evaluation.QueryResponseDataset "Permalink to this definition")Query Response Dataset.

The response can be empty if the dataset is generated from documents.

Parameters* **queries** (*Dict**[**str**,* *str**]*) – Query id -> query.
* **responses** (*Dict**[**str**,* *str**]*) – Query id -> response.
Show JSON schema
```
{ "title": "QueryResponseDataset", "description": "Query Response Dataset.\n\nThe response can be empty if the dataset is generated from documents.\n\nArgs:\n queries (Dict[str, str]): Query id -> query.\n responses (Dict[str, str]): Query id -> response.", "type": "object", "properties": { "queries": { "title": "Queries", "description": "Query id -> query", "type": "object", "additionalProperties": { "type": "string" } }, "responses": { "title": "Responses", "description": "Query id -> response", "type": "object", "additionalProperties": { "type": "string" } } }}
```


Fields* `queries (Dict[str, str])`
* `responses (Dict[str, str])`
*field* queries*: Dict[str, str]* *[Optional]*[](#llama_index.evaluation.QueryResponseDataset.queries "Permalink to this definition")Query id -> query

*field* responses*: Dict[str, str]* *[Optional]*[](#llama_index.evaluation.QueryResponseDataset.responses "Permalink to this definition")Query id -> response

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.QueryResponseDataset.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.QueryResponseDataset.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.QueryResponseDataset.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_json(*path: str*) → [QueryResponseDataset](#llama_index.evaluation.QueryResponseDataset "llama_index.evaluation.dataset_generation.QueryResponseDataset")[](#llama_index.evaluation.QueryResponseDataset.from_json "Permalink to this definition")Load json.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.QueryResponseDataset.from_orm "Permalink to this definition")*classmethod* from\_qr\_pairs(*qr\_pairs: List[Tuple[str, str]]*) → [QueryResponseDataset](#llama_index.evaluation.QueryResponseDataset "llama_index.evaluation.dataset_generation.QueryResponseDataset")[](#llama_index.evaluation.QueryResponseDataset.from_qr_pairs "Permalink to this definition")Create from qr pairs.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.QueryResponseDataset.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.QueryResponseDataset.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.QueryResponseDataset.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.QueryResponseDataset.parse_raw "Permalink to this definition")save\_json(*path: str*) → None[](#llama_index.evaluation.QueryResponseDataset.save_json "Permalink to this definition")Save json.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.QueryResponseDataset.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.QueryResponseDataset.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.QueryResponseDataset.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.QueryResponseDataset.validate "Permalink to this definition")*property* qr\_pairs*: List[Tuple[str, str]]*[](#llama_index.evaluation.QueryResponseDataset.qr_pairs "Permalink to this definition")Get pairs.

*property* questions*: List[str]*[](#llama_index.evaluation.QueryResponseDataset.questions "Permalink to this definition")Get questions.

llama\_index.evaluation.QueryResponseEvaluator[](#llama_index.evaluation.QueryResponseEvaluator "Permalink to this definition")alias of [`RelevancyEvaluator`](#llama_index.evaluation.RelevancyEvaluator "llama_index.evaluation.relevancy.RelevancyEvaluator")

*class* llama\_index.evaluation.RelevancyEvaluator(*service\_context: [llama\_index.indices.service\_context.ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext") | None = None*, *raise\_error: bool = False*, *eval\_template: str | [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*, *refine\_template: str | [llama\_index.prompts.base.BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate") | None = None*)[](#llama_index.evaluation.RelevancyEvaluator "Permalink to this definition")Relenvancy evaluator.

Evaluates the relevancy of retrieved contexts and response to a query.This evaluator considers the query string, retrieved contexts, and response string.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – The service context to use for evaluation.
* **raise\_error** (*Optional**[**bool**]*) – Whether to raise an error if the response is invalid.Defaults to False.
* **eval\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for evaluation.
* **refine\_template** (*Optional**[**Union**[**str**,* [*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]**]*) – The template to use for refinement.
*async* aevaluate(*query: str | None = None*, *response: str | None = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.RelevancyEvaluator.aevaluate "Permalink to this definition")Evaluate whether the contexts and response are relevant to the query.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.RelevancyEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.RelevancyEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.RelevancyEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.RelevancyEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.RelevancyEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.evaluation.ResponseEvaluator[](#llama_index.evaluation.ResponseEvaluator "Permalink to this definition")alias of [`FaithfulnessEvaluator`](#llama_index.evaluation.FaithfulnessEvaluator "llama_index.evaluation.faithfulness.FaithfulnessEvaluator")

*pydantic model* llama\_index.evaluation.RetrievalEvalResult[](#llama_index.evaluation.RetrievalEvalResult "Permalink to this definition")Retrieval eval result.

NOTE: this abstraction might change in the future.

query[](#llama_index.evaluation.RetrievalEvalResult.query "Permalink to this definition")Query string

Typestr

expected\_ids[](#llama_index.evaluation.RetrievalEvalResult.expected_ids "Permalink to this definition")Expected ids

TypeList[str]

retrieved\_ids[](#llama_index.evaluation.RetrievalEvalResult.retrieved_ids "Permalink to this definition")Retrieved ids

TypeList[str]

metric\_dict[](#llama_index.evaluation.RetrievalEvalResult.metric_dict "Permalink to this definition")Metric dictionary for the evaluation

TypeDict[str, BaseRetrievalMetric]

Show JSON schema
```
{ "title": "RetrievalEvalResult", "description": "Retrieval eval result.\n\nNOTE: this abstraction might change in the future.\n\nAttributes:\n query (str): Query string\n expected\_ids (List[str]): Expected ids\n retrieved\_ids (List[str]): Retrieved ids\n metric\_dict (Dict[str, BaseRetrievalMetric]): Metric dictionary for the evaluation", "type": "object", "properties": { "query": { "title": "Query", "description": "Query string", "type": "string" }, "expected\_ids": { "title": "Expected Ids", "description": "Expected ids", "type": "array", "items": { "type": "string" } }, "retrieved\_ids": { "title": "Retrieved Ids", "description": "Retrieved ids", "type": "array", "items": { "type": "string" } }, "metric\_dict": { "title": "Metric Dict", "description": "Metric dictionary for the evaluation", "type": "object", "additionalProperties": { "$ref": "#/definitions/RetrievalMetricResult" } } }, "required": [ "query", "expected\_ids", "retrieved\_ids", "metric\_dict" ], "definitions": { "RetrievalMetricResult": { "title": "RetrievalMetricResult", "description": "Metric result.\n\nAttributes:\n score (float): Score for the metric\n metadata (Dict[str, Any]): Metadata for the metric result", "type": "object", "properties": { "score": { "title": "Score", "description": "Score for the metric", "type": "number" }, "metadata": { "title": "Metadata", "description": "Metadata for the metric result", "type": "object" } }, "required": [ "score" ] } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `expected\_ids (List[str])`
* `metric\_dict (Dict[str, llama\_index.evaluation.retrieval.metrics\_base.RetrievalMetricResult])`
* `query (str)`
* `retrieved\_ids (List[str])`
*field* expected\_ids*: List[str]* *[Required]*[](#id0 "Permalink to this definition")Expected ids

*field* metric\_dict*: Dict[str, [RetrievalMetricResult](#llama_index.evaluation.RetrievalMetricResult "llama_index.evaluation.retrieval.metrics_base.RetrievalMetricResult")]* *[Required]*[](#id1 "Permalink to this definition")Metric dictionary for the evaluation

*field* query*: str* *[Required]*[](#id2 "Permalink to this definition")Query string

*field* retrieved\_ids*: List[str]* *[Required]*[](#id3 "Permalink to this definition")Retrieved ids

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.RetrievalEvalResult.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.RetrievalEvalResult.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.RetrievalEvalResult.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.RetrievalEvalResult.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrievalEvalResult.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrievalEvalResult.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.RetrievalEvalResult.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrievalEvalResult.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.RetrievalEvalResult.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrievalEvalResult.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.RetrievalEvalResult.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.RetrievalEvalResult.validate "Permalink to this definition")*property* metric\_vals\_dict*: Dict[str, float]*[](#llama_index.evaluation.RetrievalEvalResult.metric_vals_dict "Permalink to this definition")Dictionary of metric values.

*pydantic model* llama\_index.evaluation.RetrievalMetricResult[](#llama_index.evaluation.RetrievalMetricResult "Permalink to this definition")Metric result.

score[](#llama_index.evaluation.RetrievalMetricResult.score "Permalink to this definition")Score for the metric

Typefloat

metadata[](#llama_index.evaluation.RetrievalMetricResult.metadata "Permalink to this definition")Metadata for the metric result

TypeDict[str, Any]

Show JSON schema
```
{ "title": "RetrievalMetricResult", "description": "Metric result.\n\nAttributes:\n score (float): Score for the metric\n metadata (Dict[str, Any]): Metadata for the metric result", "type": "object", "properties": { "score": { "title": "Score", "description": "Score for the metric", "type": "number" }, "metadata": { "title": "Metadata", "description": "Metadata for the metric result", "type": "object" } }, "required": [ "score" ]}
```


Fields* `metadata (Dict[str, Any])`
* `score (float)`
*field* metadata*: Dict[str, Any]* *[Optional]*[](#id4 "Permalink to this definition")Metadata for the metric result

*field* score*: float* *[Required]*[](#id5 "Permalink to this definition")Score for the metric

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.RetrievalMetricResult.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.RetrievalMetricResult.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.RetrievalMetricResult.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.RetrievalMetricResult.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrievalMetricResult.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrievalMetricResult.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.RetrievalMetricResult.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrievalMetricResult.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.RetrievalMetricResult.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrievalMetricResult.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.RetrievalMetricResult.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.RetrievalMetricResult.validate "Permalink to this definition")*pydantic model* llama\_index.evaluation.RetrieverEvaluator[](#llama_index.evaluation.RetrieverEvaluator "Permalink to this definition")Retriever evaluator.

This module will evaluate a retriever using a set of metrics.

Parameters* **metrics** (*List**[**BaseRetrievalMetric**]*) – Sequence of metrics to evaluate
* **retriever** – Retriever to evaluate.
Show JSON schema
```
{ "title": "RetrieverEvaluator", "description": "Retriever evaluator.\n\nThis module will evaluate a retriever using a set of metrics.\n\nArgs:\n metrics (List[BaseRetrievalMetric]): Sequence of metrics to evaluate\n retriever: Retriever to evaluate.", "type": "object", "properties": { "metrics": { "title": "Metrics" }, "retriever": { "title": "Retriever" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `metrics (List[llama\_index.evaluation.retrieval.metrics\_base.BaseRetrievalMetric])`
* `retriever (llama\_index.indices.base\_retriever.BaseRetriever)`
*field* metrics*: List[BaseRetrievalMetric]* *[Required]*[](#llama_index.evaluation.RetrieverEvaluator.metrics "Permalink to this definition")List of metrics to evaluate

*field* retriever*: [BaseRetriever](query/retrievers.html#llama_index.indices.base_retriever.BaseRetriever "llama_index.indices.base_retriever.BaseRetriever")* *[Required]*[](#llama_index.evaluation.RetrieverEvaluator.retriever "Permalink to this definition")Retriever to evaluate

*async* aevaluate(*query: str*, *expected\_ids: List[str]*, *\*\*kwargs: Any*) → [RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")[](#llama_index.evaluation.RetrieverEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_dataset(*dataset: [EmbeddingQAFinetuneDataset](finetuning.html#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")*, *workers: int = 2*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → List[[RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")][](#llama_index.evaluation.RetrieverEvaluator.aevaluate_dataset "Permalink to this definition")Run evaluation with dataset.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.evaluation.RetrieverEvaluator.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.evaluation.RetrieverEvaluator.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.evaluation.RetrieverEvaluator.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

evaluate(*query: str*, *expected\_ids: List[str]*, *\*\*kwargs: Any*) → [RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")[](#llama_index.evaluation.RetrieverEvaluator.evaluate "Permalink to this definition")Run evaluation results with query string and expected ids.

Parameters* **query** (*str*) – Query string
* **expected\_ids** (*List**[**str**]*) – Expected ids
ReturnsEvaluation result

Return type[RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.RetrievalEvalResult")

*classmethod* from\_metric\_names(*metric\_names: List[str]*, *\*\*kwargs: Any*) → [BaseRetrievalEvaluator](#llama_index.evaluation.BaseRetrievalEvaluator "llama_index.evaluation.retrieval.base.BaseRetrievalEvaluator")[](#llama_index.evaluation.RetrieverEvaluator.from_metric_names "Permalink to this definition")Create evaluator from metric names.

Parameters* **metric\_names** (*List**[**str**]*) – List of metric names
* **\*\*kwargs** – Additional arguments for the evaluator
*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.evaluation.RetrieverEvaluator.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrieverEvaluator.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrieverEvaluator.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.evaluation.RetrieverEvaluator.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.evaluation.RetrieverEvaluator.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.evaluation.RetrieverEvaluator.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.evaluation.RetrieverEvaluator.schema_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.evaluation.RetrieverEvaluator.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.evaluation.RetrieverEvaluator.validate "Permalink to this definition")*class* llama\_index.evaluation.SemanticSimilarityEvaluator(*service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *similarity\_fn: Optional[Callable[[...], float]] = None*, *similarity\_mode: Optional[SimilarityMode] = None*, *similarity\_threshold: float = 0.8*)[](#llama_index.evaluation.SemanticSimilarityEvaluator "Permalink to this definition")Embedding similarity evaluator.

Evaluate the quality of a question answering system bycomparing the similarity between embeddings of the generated answerand the reference answer.

Inspired by this paper:- Semantic Answer Similarity for Evaluating Question Answering Models


> <https://arxiv.org/pdf/2108.06130.pdf>
> 
> 

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – Service context.
* **similarity\_threshold** (*float*) – Embedding similarity threshold for “passing”.Defaults to 0.8.
*async* aevaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *reference: Optional[str] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.SemanticSimilarityEvaluator.aevaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

*async* aevaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.SemanticSimilarityEvaluator.aevaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate(*query: Optional[str] = None*, *response: Optional[str] = None*, *contexts: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.SemanticSimilarityEvaluator.evaluate "Permalink to this definition")Run evaluation with query string, retrieved contexts,and generated response string.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

evaluate\_response(*query: Optional[str] = None*, *response: Optional[[Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")] = None*, *\*\*kwargs: Any*) → [EvaluationResult](#llama_index.evaluation.EvaluationResult "llama_index.evaluation.base.EvaluationResult")[](#llama_index.evaluation.SemanticSimilarityEvaluator.evaluate_response "Permalink to this definition")Run evaluation with query string and generated Response object.

Subclasses can override this method to provide custom evaluation logic andtake in additional arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.evaluation.SemanticSimilarityEvaluator.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.evaluation.SemanticSimilarityEvaluator.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.evaluation.generate\_qa\_embedding\_pairs(*nodes: List[TextNode]*, *llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *qa\_generate\_prompt\_tmpl: str = 'Context information is below.\n\n---------------------\n{context\_str}\n---------------------\n\nGiven the context information and not prior knowledge.\ngenerate only questions based on the below query.\n\nYou are a Teacher/ Professor. Your task is to setup {num\_questions\_per\_chunk} questions for an upcoming quiz/examination. The questions should be diverse in nature across the document. Restrict the questions to the context information provided."\n'*, *num\_questions\_per\_chunk: int = 2*) → [EmbeddingQAFinetuneDataset](finetuning.html#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")[](#llama_index.evaluation.generate_qa_embedding_pairs "Permalink to this definition")Generate examples given a set of nodes.

llama\_index.evaluation.generate\_question\_context\_pairs(*nodes: List[TextNode]*, *llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *qa\_generate\_prompt\_tmpl: str = 'Context information is below.\n\n---------------------\n{context\_str}\n---------------------\n\nGiven the context information and not prior knowledge.\ngenerate only questions based on the below query.\n\nYou are a Teacher/ Professor. Your task is to setup {num\_questions\_per\_chunk} questions for an upcoming quiz/examination. The questions should be diverse in nature across the document. Restrict the questions to the context information provided."\n'*, *num\_questions\_per\_chunk: int = 2*) → [EmbeddingQAFinetuneDataset](finetuning.html#llama_index.finetuning.EmbeddingQAFinetuneDataset "llama_index.finetuning.embeddings.common.EmbeddingQAFinetuneDataset")[](#llama_index.evaluation.generate_question_context_pairs "Permalink to this definition")Generate examples given a set of nodes.

llama\_index.evaluation.get\_retrieval\_results\_df(*names: List[str]*, *results\_arr: List[List[[RetrievalEvalResult](#llama_index.evaluation.RetrievalEvalResult "llama_index.evaluation.retrieval.base.RetrievalEvalResult")]]*, *metric\_keys: Optional[List[str]] = None*) → DataFrame[](#llama_index.evaluation.get_retrieval_results_df "Permalink to this definition")Display retrieval results.

llama\_index.evaluation.resolve\_metrics(*metrics: List[str]*) → List[BaseRetrievalMetric][](#llama_index.evaluation.resolve_metrics "Permalink to this definition")Resolve metrics from list of metric names.

