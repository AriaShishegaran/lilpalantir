Query Transform[](#module-llama_index.indices.query.query_transform "Permalink to this heading")
=================================================================================================

Query Transforms.

*class* llama\_index.indices.query.query\_transform.DecomposeQueryTransform(*llm\_predictor: Optional[BaseLLMPredictor] = None*, *decompose\_query\_prompt: Optional[[PromptTemplate](../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")] = None*, *verbose: bool = False*)[](#llama_index.indices.query.query_transform.DecomposeQueryTransform "Permalink to this definition")Decompose query transform.

Decomposes query into a subquery given the current index struct.Performs a single step transformation.

Parameters**llm\_predictor** (*Optional**[*[*LLMPredictor*](../llm_predictor.html#llama_index.llm_predictor.LLMPredictor "llama_index.llm_predictor.LLMPredictor")*]*) – LLM for generatinghypothetical documents

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.query.query_transform.DecomposeQueryTransform.get_prompts "Permalink to this definition")Get a prompt.

run(*query\_bundle\_or\_str: Union[str, [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *metadata: Optional[Dict] = None*) → [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")[](#llama_index.indices.query.query_transform.DecomposeQueryTransform.run "Permalink to this definition")Run query transform.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.query.query_transform.DecomposeQueryTransform.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.query.query\_transform.HyDEQueryTransform(*llm\_predictor: Optional[BaseLLMPredictor] = None*, *hyde\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *include\_original: bool = True*)[](#llama_index.indices.query.query_transform.HyDEQueryTransform "Permalink to this definition")Hypothetical Document Embeddings (HyDE) query transform.

It uses an LLM to generate hypothetical answer(s) to a given query,and use the resulting documents as embedding strings.

As described in [Precise Zero-Shot Dense Retrieval without Relevance Labels](https://arxiv.org/abs/2212.10496)

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.query.query_transform.HyDEQueryTransform.get_prompts "Permalink to this definition")Get a prompt.

run(*query\_bundle\_or\_str: Union[str, [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *metadata: Optional[Dict] = None*) → [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")[](#llama_index.indices.query.query_transform.HyDEQueryTransform.run "Permalink to this definition")Run query transform.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.query.query_transform.HyDEQueryTransform.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.query.query\_transform.StepDecomposeQueryTransform(*llm\_predictor: Optional[BaseLLMPredictor] = None*, *step\_decompose\_query\_prompt: Optional[[PromptTemplate](../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")] = None*, *verbose: bool = False*)[](#llama_index.indices.query.query_transform.StepDecomposeQueryTransform "Permalink to this definition")Step decompose query transform.

Decomposes query into a subquery given the current index structand previous reasoning.

NOTE: doesn’t work yet.

Parameters**llm\_predictor** (*Optional**[*[*LLMPredictor*](../llm_predictor.html#llama_index.llm_predictor.LLMPredictor "llama_index.llm_predictor.LLMPredictor")*]*) – LLM for generatinghypothetical documents

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.query.query_transform.StepDecomposeQueryTransform.get_prompts "Permalink to this definition")Get a prompt.

run(*query\_bundle\_or\_str: Union[str, [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*, *metadata: Optional[Dict] = None*) → [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")[](#llama_index.indices.query.query_transform.StepDecomposeQueryTransform.run "Permalink to this definition")Run query transform.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.query.query_transform.StepDecomposeQueryTransform.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

