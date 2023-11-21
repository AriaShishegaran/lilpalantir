Summary Index[](#summary-index "Permalink to this heading")
============================================================

Building the Summary Index

List-based data structures.

llama\_index.indices.list.GPTListIndex[](#llama_index.indices.list.GPTListIndex "Permalink to this definition")alias of [`SummaryIndex`](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")

llama\_index.indices.list.ListIndex[](#llama_index.indices.list.ListIndex "Permalink to this definition")alias of [`SummaryIndex`](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")

llama\_index.indices.list.ListIndexEmbeddingRetriever[](#llama_index.indices.list.ListIndexEmbeddingRetriever "Permalink to this definition")alias of [`SummaryIndexEmbeddingRetriever`](../query/retrievers/list.html#llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever "llama_index.indices.list.retrievers.SummaryIndexEmbeddingRetriever")

llama\_index.indices.list.ListIndexLLMRetriever[](#llama_index.indices.list.ListIndexLLMRetriever "Permalink to this definition")alias of [`SummaryIndexLLMRetriever`](../query/retrievers/list.html#llama_index.indices.list.retrievers.SummaryIndexLLMRetriever "llama_index.indices.list.retrievers.SummaryIndexLLMRetriever")

llama\_index.indices.list.ListIndexRetriever[](#llama_index.indices.list.ListIndexRetriever "Permalink to this definition")alias of [`SummaryIndexRetriever`](../query/retrievers/list.html#llama_index.indices.list.retrievers.SummaryIndexRetriever "llama_index.indices.list.retrievers.SummaryIndexRetriever")

*class* llama\_index.indices.list.SummaryIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[IndexList] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.list.SummaryIndex "Permalink to this definition")Summary Index.

The summary index is a simple data structure where nodes are stored ina sequence. During index construction, the document texts arechunked up, converted to nodes, and stored in a list.

During query time, the summary index iterates through the nodeswith some optional filter parameters, and synthesizes ananswer from all the nodes.

Parameters* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Question-Answer Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).NOTE: this is a deprecated field.
* **show\_progress** (*bool*) – Whether to show tqdm progress bars. Defaults to False.
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.list.SummaryIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.list.SummaryIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.list.SummaryIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.list.SummaryIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.list.SummaryIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.list.SummaryIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.list.SummaryIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.list.SummaryIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.list.SummaryIndexEmbeddingRetriever(*index: [SummaryIndex](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *similarity\_top\_k: Optional[int] = 1*, *\*\*kwargs: Any*)[](#llama_index.indices.list.SummaryIndexEmbeddingRetriever "Permalink to this definition")Embedding based retriever for SummaryIndex.

Generates embeddings in a lazy fashion for allnodes that are traversed.

Parameters* **index** ([*SummaryIndex*](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.
* **similarity\_top\_k** (*Optional**[**int**]*) – The number of top nodes to return.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.SummaryIndexEmbeddingRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.SummaryIndexEmbeddingRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.SummaryIndexEmbeddingRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.SummaryIndexEmbeddingRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.list.SummaryIndexLLMRetriever(*index: [SummaryIndex](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *choice\_select\_prompt: Optional[[PromptTemplate](../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")] = None*, *choice\_batch\_size: int = 10*, *format\_node\_batch\_fn: Optional[Callable] = None*, *parse\_choice\_select\_answer\_fn: Optional[Callable] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.list.SummaryIndexLLMRetriever "Permalink to this definition")LLM retriever for SummaryIndex.

Parameters* **index** ([*SummaryIndex*](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.
* **choice\_select\_prompt** (*Optional**[*[*PromptTemplate*](../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")*]*) – A Choice-Select Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).)
* **choice\_batch\_size** (*int*) – The number of nodes to query at a time.
* **format\_node\_batch\_fn** (*Optional**[**Callable**]*) – A function that formats abatch of nodes.
* **parse\_choice\_select\_answer\_fn** (*Optional**[**Callable**]*) – A function that parses thechoice select answer.
* **service\_context** (*Optional**[*[*ServiceContext*](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.SummaryIndexLLMRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.SummaryIndexLLMRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.SummaryIndexLLMRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.SummaryIndexLLMRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.list.SummaryIndexRetriever(*index: [SummaryIndex](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.base.SummaryIndex")*, *\*\*kwargs: Any*)[](#llama_index.indices.list.SummaryIndexRetriever "Permalink to this definition")Simple retriever for SummaryIndex that returns all nodes.

Parameters**index** ([*SummaryIndex*](#llama_index.indices.list.SummaryIndex "llama_index.indices.list.SummaryIndex")) – The index to retrieve from.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.list.SummaryIndexRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.list.SummaryIndexRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.list.SummaryIndexRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.list.SummaryIndexRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

