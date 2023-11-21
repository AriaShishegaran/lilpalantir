Vector Store Index[](#vector-store-index "Permalink to this heading")
======================================================================

Below we show the vector store index classes.

Each vector store index class is a combination of a base vector store indexclass and a vector store, shown below.

Base vector store index.

An index that that is built on top of an existing vector store.

llama\_index.indices.vector\_store.base.GPTVectorStoreIndex[](#llama_index.indices.vector_store.base.GPTVectorStoreIndex "Permalink to this definition")alias of [`VectorStoreIndex`](#llama_index.indices.vector_store.base.VectorStoreIndex "llama_index.indices.vector_store.base.VectorStoreIndex")

*class* llama\_index.indices.vector\_store.base.VectorStoreIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[IndexDict] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *use\_async: bool = False*, *store\_nodes\_override: bool = False*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.vector_store.base.VectorStoreIndex "Permalink to this definition")Vector Store Index.

Parameters* **use\_async** (*bool*) – Whether to use asynchronous calls. Defaults to False.
* **show\_progress** (*bool*) – Whether to show tqdm progress bars. Defaults to False.
* **store\_nodes\_override** (*bool*) – set to True to always store Node objects in indexstore and document store even if vector store keeps text. Defaults to False
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → IndexDict[](#llama_index.indices.vector_store.base.VectorStoreIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

NOTE: Overrides BaseIndex.build\_index\_from\_nodes.VectorStoreIndex only stores nodes in document storeif vector store does not store text

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.vector_store.base.VectorStoreIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.vector_store.base.VectorStoreIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.insert_nodes "Permalink to this definition")Insert nodes.

NOTE: overrides BaseIndex.insert\_nodes.VectorStoreIndex only stores nodes in document storeif vector store does not store text

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.vector_store.base.VectorStoreIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.vector_store.base.VectorStoreIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.vector_store.base.VectorStoreIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.vector_store.base.VectorStoreIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
