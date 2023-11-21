Tree Index[](#tree-index "Permalink to this heading")
======================================================

Building the Tree Index

Tree-structured Index Data Structures.

llama\_index.indices.tree.GPTTreeIndex[](#llama_index.indices.tree.GPTTreeIndex "Permalink to this definition")alias of [`TreeIndex`](#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")

*class* llama\_index.indices.tree.TreeAllLeafRetriever(*index: [TreeIndex](#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.TreeAllLeafRetriever "Permalink to this definition")GPT all leaf retriever.

This class builds a query-specific tree from leaf nodes to return a response.Using this query mode means that the tree index doesn’t need to be builtwhen initialized, since we rebuild the tree for each query.

Parameters**text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Question-Answer Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.TreeAllLeafRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.TreeAllLeafRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.TreeAllLeafRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.TreeAllLeafRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.tree.TreeIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[IndexGraph] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *summary\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *insert\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *num\_children: int = 10*, *build\_tree: bool = True*, *use\_async: bool = False*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.TreeIndex "Permalink to this definition")Tree Index.

The tree index is a tree-structured index, where each node is a summary ofthe children nodes. During index construction, the tree is constructedin a bottoms-up fashion until we end up with a set of root\_nodes.

There are a few different options during query time (see [Querying an Index](../query.html#ref-query)).The main option is to traverse down the tree from the root nodes.A secondary answer is to directly synthesize the answer from the root nodes.

Parameters* **summary\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Summarization Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **insert\_prompt** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – An Tree Insertion Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **num\_children** (*int*) – The number of children each node should have.
* **build\_tree** (*bool*) – Whether to build the tree during index construction.
* **show\_progress** (*bool*) – Whether to show progress bars. Defaults to False.
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.tree.TreeIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete(*doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.delete "Permalink to this definition")Delete a document from the index.All nodes in the index related to the index will be deleted.

Parameters**doc\_id** (*str*) – A doc\_id of the ingested document

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*property* docstore*: [BaseDocumentStore](../storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*[](#llama_index.indices.tree.TreeIndex.docstore "Permalink to this definition")Get the docstore corresponding to the index.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.tree.TreeIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.tree.TreeIndex.index_id "Permalink to this definition")Get the index struct.

*property* index\_struct*: IS*[](#llama_index.indices.tree.TreeIndex.index_struct "Permalink to this definition")Get the index struct.

index\_struct\_cls[](#llama_index.indices.tree.TreeIndex.index_struct_cls "Permalink to this definition")alias of `IndexGraph`

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.tree.TreeIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.tree.TreeIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.tree.TreeIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.tree.TreeIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.tree.TreeIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.tree.TreeRootRetriever(*index: [TreeIndex](#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.TreeRootRetriever "Permalink to this definition")Tree root retriever.

This class directly retrieves the answer from the root nodes.

Unlike GPTTreeIndexLeafQuery, this class assumes the graph already storesthe answer (because it was constructed with a query\_str), so it does notattempt to parse information down the graph in order to synthesize an answer.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.TreeRootRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.TreeRootRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.TreeRootRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.TreeRootRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.tree.TreeSelectLeafEmbeddingRetriever(*index: [TreeIndex](#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *query\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_template\_multiple: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *child\_branch\_factor: int = 1*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.TreeSelectLeafEmbeddingRetriever "Permalink to this definition")Tree select leaf embedding retriever.

This class traverses the index graph using the embedding similarity between thequery and the node text.

Parameters* **query\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree Select Query Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **query\_template\_multiple** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree SelectQuery Prompt (Multiple)(see [Prompt Templates](../prompts.html#prompt-templates)).
* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Question-Answer Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **refine\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Refinement Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **child\_branch\_factor** (*int*) – Number of child nodes to consider at each level.If child\_branch\_factor is 1, then the query will only choose one child nodeto traverse for any given parent node.If child\_branch\_factor is 2, then the query will choose two child nodes.
* **embed\_model** (*Optional**[**BaseEmbedding**]*) – Embedding model to use forembedding similarity.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.TreeSelectLeafEmbeddingRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.TreeSelectLeafEmbeddingRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.TreeSelectLeafEmbeddingRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.TreeSelectLeafEmbeddingRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.tree.TreeSelectLeafRetriever(*index: [TreeIndex](#llama_index.indices.tree.TreeIndex "llama_index.indices.tree.base.TreeIndex")*, *query\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_template\_multiple: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *child\_branch\_factor: int = 1*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.tree.TreeSelectLeafRetriever "Permalink to this definition")Tree select leaf retriever.

This class traverses the index graph and searches for a leaf node that can bestanswer the query.

Parameters* **query\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree Select Query Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **query\_template\_multiple** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Tree SelectQuery Prompt (Multiple)(see [Prompt Templates](../prompts.html#prompt-templates)).
* **child\_branch\_factor** (*int*) – Number of child nodes to consider at each level.If child\_branch\_factor is 1, then the query will only choose one child nodeto traverse for any given parent node.If child\_branch\_factor is 2, then the query will choose two child nodes.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.tree.TreeSelectLeafRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.tree.TreeSelectLeafRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.tree.TreeSelectLeafRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.tree.TreeSelectLeafRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

