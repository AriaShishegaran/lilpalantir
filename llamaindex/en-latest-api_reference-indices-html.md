Indices[](#indices "Permalink to this heading")
================================================

This doc shows both the overarching class used to represent an index. Theseclasses allow for index creation, insertion, and also querying.We first show the different index subclasses.We then show the base class that all indices inherit from, which containsparameters and methods common to all indices.

  
Index Data Structures

* [Summary Index](indices/list.html)
* [Table Index](indices/table.html)
* [Tree Index](indices/tree.html)
* [Vector Store Index](indices/vector_store.html)
* [Structured Store Index](indices/struct_store.html)
* [Knowledge Graph Index](indices/kg.html)
* [Empty Index](indices/empty.html)
Base Index Class[](#module-llama_index.indices.base "Permalink to this heading")
---------------------------------------------------------------------------------

Base index classes.

llama\_index.indices.base.BaseGPTIndex[](#llama_index.indices.base.BaseGPTIndex "Permalink to this definition")alias of [`BaseIndex`](#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")

*class* llama\_index.indices.base.BaseIndex(*nodes: Optional[Sequence[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[IS] = None*, *storage\_context: Optional[[StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.base.BaseIndex "Permalink to this definition")Base LlamaIndex.

Parameters* **nodes** (*List**[**Node**]*) – List of nodes to index
* **show\_progress** (*bool*) – Whether to show tqdm progress bars. Defaults to False.
* **service\_context** ([*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")) – Service context container (containscomponents like LLMPredictor, PromptHelper, etc.).
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.base.BaseIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete(*doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.delete "Permalink to this definition")Delete a document from the index.All nodes in the index related to the index will be deleted.

Parameters**doc\_id** (*str*) – A doc\_id of the ingested document

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*property* docstore*: [BaseDocumentStore](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*[](#llama_index.indices.base.BaseIndex.docstore "Permalink to this definition")Get the docstore corresponding to the index.

*classmethod* from\_documents(*documents: Sequence[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.base.BaseIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.base.BaseIndex.index_id "Permalink to this definition")Get the index struct.

*property* index\_struct*: IS*[](#llama_index.indices.base.BaseIndex.index_struct "Permalink to this definition")Get the index struct.

insert(*document: [Document](node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.insert_nodes "Permalink to this definition")Insert nodes.

*abstract property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.base.BaseIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.base.BaseIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.base.BaseIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.base.BaseIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.base.BaseIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
