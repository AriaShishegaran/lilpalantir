Keyword Table Retrievers[](#module-llama_index.indices.keyword_table.retrievers "Permalink to this heading")
=============================================================================================================

Query for KeywordTableIndex.

*class* llama\_index.indices.keyword\_table.retrievers.BaseKeywordTableRetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.retrievers.BaseKeywordTableRetriever "Permalink to this definition")Base Keyword Table Retriever.

Arguments are shared among subclasses.

Parameters* **keyword\_extract\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A KeywordExtraction Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **query\_keyword\_extract\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A QueryKeyword ExtractionPrompt (see [Prompt Templates](../../prompts.html#prompt-templates)).
* **refine\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Refinement Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Question Answering Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **max\_keywords\_per\_query** (*int*) – Maximum number of keywords to extract from query.
* **num\_chunks\_per\_query** (*int*) – Maximum number of text chunks to query.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.retrievers.BaseKeywordTableRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.retrievers.BaseKeywordTableRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.retrievers.BaseKeywordTableRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.retrievers.BaseKeywordTableRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.retrievers.KeywordTableGPTRetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.retrievers.KeywordTableGPTRetriever "Permalink to this definition")Keyword Table Index GPT Retriever.

Extracts keywords using GPT. Set when using retriever\_mode=”default”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.retrievers.KeywordTableGPTRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.retrievers.KeywordTableGPTRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.retrievers.KeywordTableGPTRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.retrievers.KeywordTableGPTRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.retrievers.KeywordTableRAKERetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.retrievers.KeywordTableRAKERetriever "Permalink to this definition")Keyword Table Index RAKE Retriever.

Extracts keywords using RAKE keyword extractor.Set when retriever\_mode=”rake”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.retrievers.KeywordTableRAKERetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.retrievers.KeywordTableRAKERetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.retrievers.KeywordTableRAKERetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.retrievers.KeywordTableRAKERetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.retrievers.KeywordTableSimpleRetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.retrievers.KeywordTableSimpleRetriever "Permalink to this definition")Keyword Table Index Simple Retriever.

Extracts keywords using simple regex-based keyword extractor.Set when retriever\_mode=”simple”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.retrievers.KeywordTableSimpleRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.retrievers.KeywordTableSimpleRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.retrievers.KeywordTableSimpleRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.retrievers.KeywordTableSimpleRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

