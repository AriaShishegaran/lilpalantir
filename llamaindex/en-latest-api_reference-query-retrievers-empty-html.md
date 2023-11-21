Empty Index Retriever[](#module-llama_index.indices.empty.retrievers "Permalink to this heading")
==================================================================================================

Default query for EmptyIndex.

*class* llama\_index.indices.empty.retrievers.EmptyIndexRetriever(*index: [EmptyIndex](../../indices/empty.html#llama_index.indices.empty.EmptyIndex "llama_index.indices.empty.base.EmptyIndex")*, *input\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.empty.retrievers.EmptyIndexRetriever "Permalink to this definition")EmptyIndex query.

Passes the raw LLM call to the underlying LLM model.

Parameters**input\_prompt** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Simple Input Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.empty.retrievers.EmptyIndexRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.empty.retrievers.EmptyIndexRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.empty.retrievers.EmptyIndexRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.empty.retrievers.EmptyIndexRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

