Tree Retrievers[](#module-llama_index.indices.tree.all_leaf_retriever "Permalink to this heading")
===================================================================================================

Summarize query.

*class* llama\_index.indices.tree.all\_leaf\_retriever.TreeAllLeafRetriever(*index: [TreeIndex](../../indices/tree.html#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.all_leaf_retriever.TreeAllLeafRetriever "Permalink to this definition")GPT all leaf retriever.

This class builds a query-specific tree from leaf nodes to return a response.Using this query mode means that the tree index doesn’t need to be builtwhen initialized, since we rebuild the tree for each query.

Parameters**text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Question-Answer Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.all_leaf_retriever.TreeAllLeafRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.all_leaf_retriever.TreeAllLeafRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.all_leaf_retriever.TreeAllLeafRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.all_leaf_retriever.TreeAllLeafRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

Leaf query mechanism.

*class* llama\_index.indices.tree.select\_leaf\_retriever.TreeSelectLeafRetriever(*index: [TreeIndex](../../indices/tree.html#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *query\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_template\_multiple: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *child\_branch\_factor: int = 1*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.select_leaf_retriever.TreeSelectLeafRetriever "Permalink to this definition")Tree select leaf retriever.

This class traverses the index graph and searches for a leaf node that can bestanswer the query.

Parameters* **query\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree Select Query Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **query\_template\_multiple** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree SelectQuery Prompt (Multiple)(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **child\_branch\_factor** (*int*) – Number of child nodes to consider at each level.If child\_branch\_factor is 1, then the query will only choose one child nodeto traverse for any given parent node.If child\_branch\_factor is 2, then the query will choose two child nodes.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.select_leaf_retriever.TreeSelectLeafRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.select_leaf_retriever.TreeSelectLeafRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.select_leaf_retriever.TreeSelectLeafRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.select_leaf_retriever.TreeSelectLeafRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.indices.tree.select\_leaf\_retriever.get\_text\_from\_node(*node: [BaseNode](../../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*, *level: Optional[int] = None*, *verbose: bool = False*) → str[](#llama_index.indices.tree.select_leaf_retriever.get_text_from_node "Permalink to this definition")Get text from node.

Query Tree using embedding similarity between query and node text.

*class* llama\_index.indices.tree.select\_leaf\_embedding\_retriever.TreeSelectLeafEmbeddingRetriever(*index: [TreeIndex](../../indices/tree.html#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *query\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_template\_multiple: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *child\_branch\_factor: int = 1*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.select_leaf_embedding_retriever.TreeSelectLeafEmbeddingRetriever "Permalink to this definition")Tree select leaf embedding retriever.

This class traverses the index graph using the embedding similarity between thequery and the node text.

Parameters* **query\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree Select Query Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **query\_template\_multiple** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree SelectQuery Prompt (Multiple)(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Question-Answer Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **refine\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Refinement Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **child\_branch\_factor** (*int*) – Number of child nodes to consider at each level.If child\_branch\_factor is 1, then the query will only choose one child nodeto traverse for any given parent node.If child\_branch\_factor is 2, then the query will choose two child nodes.
* **embed\_model** (*Optional**[**BaseEmbedding**]*) – Embedding model to use forembedding similarity.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.select_leaf_embedding_retriever.TreeSelectLeafEmbeddingRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.select_leaf_embedding_retriever.TreeSelectLeafEmbeddingRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.select_leaf_embedding_retriever.TreeSelectLeafEmbeddingRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.select_leaf_embedding_retriever.TreeSelectLeafEmbeddingRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

