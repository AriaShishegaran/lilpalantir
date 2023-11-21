Transform Retriever[](#module-llama_index.retrievers.transform_retriever "Permalink to this heading")
======================================================================================================

*class* llama\_index.retrievers.transform\_retriever.TransformRetriever(*retriever: [BaseRetriever](../retrievers.html#llama_index.indices.base_retriever.BaseRetriever "llama_index.indices.base_retriever.BaseRetriever")*, *query\_transform: BaseQueryTransform*, *transform\_metadata: Optional[dict] = None*)[](#llama_index.retrievers.transform_retriever.TransformRetriever "Permalink to this definition")Transform Retriever.

Takes in an existing retriever and a query transform and runs the query transformbefore running the retriever.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.retrievers.transform_retriever.TransformRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.retrievers.transform_retriever.TransformRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.retrievers.transform_retriever.TransformRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.retrievers.transform_retriever.TransformRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

