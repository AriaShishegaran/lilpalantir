Empty Index[](#empty-index "Permalink to this heading")
========================================================

Building the Empty Index

Empty Index.

*class* llama\_index.indices.empty.EmptyIndex(*index\_struct: Optional[EmptyIndexStruct] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.empty.EmptyIndex "Permalink to this definition")Empty Index.

An index that doesn’t contain any documents. Used forpure LLM calls.NOTE: this exists because an empty index it allows certain properties,such as the ability to be composed with other indices + tokencounting + others.

build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.empty.EmptyIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.empty.EmptyIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.empty.EmptyIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.empty.EmptyIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.empty.EmptyIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.empty.EmptyIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.empty.EmptyIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.empty.EmptyIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.empty.EmptyIndexRetriever(*index: [EmptyIndex](#llama_index.indices.empty.EmptyIndex "llama_index.indices.empty.base.EmptyIndex")*, *input\_prompt: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.empty.EmptyIndexRetriever "Permalink to this definition")EmptyIndex query.

Passes the raw LLM call to the underlying LLM model.

Parameters**input\_prompt** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Simple Input Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.empty.EmptyIndexRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.empty.EmptyIndexRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.empty.EmptyIndexRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.empty.EmptyIndexRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.indices.empty.GPTEmptyIndex[](#llama_index.indices.empty.GPTEmptyIndex "Permalink to this definition")alias of [`EmptyIndex`](#llama_index.indices.empty.EmptyIndex "llama_index.indices.empty.base.EmptyIndex")

