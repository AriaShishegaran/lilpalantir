List Retriever[](#module-llama_index.indices.list.retrievers "Permalink to this heading")
==========================================================================================

Retrievers for SummaryIndex.

llama\_index.indices.list.retrievers.ListIndexEmbeddingRetriever[](#llama_index.indices.list.retrievers.ListIndexEmbeddingRetriever "Permalink to this definition")alias of [`SummaryIndexEmbeddingRetriever`](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever "llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever")

llama\_index.indices.list.retrievers.ListIndexLLMRetriever[](#llama_index.indices.list.retrievers.ListIndexLLMRetriever "Permalink to this definition")alias of [`SummaryIndexLLMRetriever`](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever "llama_index.indices.list.retrievers.SummaryIndexLLMRetriever")

llama\_index.indices.list.retrievers.ListIndexRetriever[](#llama_index.indices.list.retrievers.ListIndexRetriever "Permalink to this definition")alias of [`SummaryIndexRetriever`](#llama_index.indices.list.retrievers.SummaryIndexRetriever "llama_index.indices.list.retrievers.SummaryIndexRetriever")

*class* llama\_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever(*index: [SummaryIndex](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *similarity\_top\_k: Optional[int] = 1*, *\*\*kwargs: Any*)[](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever "Permalink to this definition")Embedding based retriever for SummaryIndex.

Generates embeddings in a lazy fashion for allnodes that are traversed.

Parameters* **index** ([*SummaryIndex*](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.
* **similarity\_top\_k** (*Optional**[**int**]*) – The number of top nodes to return.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.list.retrievers.SummaryIndexLLMRetriever(*index: [SummaryIndex](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *choice\_select\_prompt: Optional[[PromptTemplate](../../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")] = None*, *choice\_batch\_size: int = 10*, *format\_node\_batch\_fn: Optional[Callable] = None*, *parse\_choice\_select\_answer\_fn: Optional[Callable] = None*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever "Permalink to this definition")LLM retriever for SummaryIndex.

Parameters* **index** ([*SummaryIndex*](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.
* **choice\_select\_prompt** (*Optional**[*[*PromptTemplate*](../../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")*]*) – A Choice-Select Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).)
* **choice\_batch\_size** (*int*) – The number of nodes to query at a time.
* **format\_node\_batch\_fn** (*Optional**[**Callable**]*) – A function that formats abatch of nodes.
* **parse\_choice\_select\_answer\_fn** (*Optional**[**Callable**]*) – A function that parses thechoice select answer.
* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.list.retrievers.SummaryIndexRetriever(*index: [SummaryIndex](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *\*\*kwargs: Any*)[](#llama_index.indices.list.retrievers.SummaryIndexRetriever "Permalink to this definition")Simple retriever for SummaryIndex that returns all nodes.

Parameters**index** ([*SummaryIndex*](../../indices/list.html#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.retrievers.SummaryIndexRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.retrievers.SummaryIndexRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.retrievers.SummaryIndexRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.retrievers.SummaryIndexRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

