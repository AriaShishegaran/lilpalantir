Table Index[](#table-index "Permalink to this heading")
========================================================

Building the Keyword Table Index

Keyword Table Index Data Structures.

llama\_index.indices.keyword\_table.GPTKeywordTableIndex[](#llama_index.indices.keyword_table.GPTKeywordTableIndex "Permalink to this definition")alias of [`KeywordTableIndex`](#llama_index.indices.keyword_table.KeywordTableIndex "llama_index.indices.keyword_table.base.KeywordTableIndex")

llama\_index.indices.keyword\_table.GPTRAKEKeywordTableIndex[](#llama_index.indices.keyword_table.GPTRAKEKeywordTableIndex "Permalink to this definition")alias of [`RAKEKeywordTableIndex`](#llama_index.indices.keyword_table.RAKEKeywordTableIndex "llama_index.indices.keyword_table.rake_base.RAKEKeywordTableIndex")

llama\_index.indices.keyword\_table.GPTSimpleKeywordTableIndex[](#llama_index.indices.keyword_table.GPTSimpleKeywordTableIndex "Permalink to this definition")alias of [`SimpleKeywordTableIndex`](#llama_index.indices.keyword_table.SimpleKeywordTableIndex "llama_index.indices.keyword_table.simple_base.SimpleKeywordTableIndex")

*class* llama\_index.indices.keyword\_table.KeywordTableGPTRetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.KeywordTableGPTRetriever "Permalink to this definition")Keyword Table Index GPT Retriever.

Extracts keywords using GPT. Set when using retriever\_mode=”default”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.KeywordTableGPTRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.KeywordTableGPTRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.KeywordTableGPTRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.KeywordTableGPTRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.KeywordTableIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[KeywordTable] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_chunk: int = 10*, *use\_async: bool = False*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.KeywordTableIndex "Permalink to this definition")Keyword Table Index.

This index uses a GPT model to extract keywords from the text.

build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.keyword_table.KeywordTableIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete(*doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.delete "Permalink to this definition")Delete a document from the index.All nodes in the index related to the index will be deleted.

Parameters**doc\_id** (*str*) – A doc\_id of the ingested document

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*property* docstore*: [BaseDocumentStore](../storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*[](#llama_index.indices.keyword_table.KeywordTableIndex.docstore "Permalink to this definition")Get the docstore corresponding to the index.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.keyword_table.KeywordTableIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.keyword_table.KeywordTableIndex.index_id "Permalink to this definition")Get the index struct.

*property* index\_struct*: IS*[](#llama_index.indices.keyword_table.KeywordTableIndex.index_struct "Permalink to this definition")Get the index struct.

index\_struct\_cls[](#llama_index.indices.keyword_table.KeywordTableIndex.index_struct_cls "Permalink to this definition")alias of `KeywordTable`

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.keyword_table.KeywordTableIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.KeywordTableIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.KeywordTableIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.KeywordTableIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.keyword\_table.KeywordTableRAKERetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.KeywordTableRAKERetriever "Permalink to this definition")Keyword Table Index RAKE Retriever.

Extracts keywords using RAKE keyword extractor.Set when retriever\_mode=”rake”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.KeywordTableRAKERetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.KeywordTableRAKERetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.KeywordTableRAKERetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.KeywordTableRAKERetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.KeywordTableSimpleRetriever(*index: BaseKeywordTableIndex*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.KeywordTableSimpleRetriever "Permalink to this definition")Keyword Table Index Simple Retriever.

Extracts keywords using simple regex-based keyword extractor.Set when retriever\_mode=”simple”.

See BaseGPTKeywordTableQuery for arguments.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.keyword_table.KeywordTableSimpleRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.keyword_table.KeywordTableSimpleRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.keyword_table.KeywordTableSimpleRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.keyword_table.KeywordTableSimpleRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.keyword\_table.RAKEKeywordTableIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[KeywordTable] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_chunk: int = 10*, *use\_async: bool = False*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex "Permalink to this definition")RAKE Keyword Table Index.

This index uses a RAKE keyword extractor to extract keywords from the text.

build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete(*doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.delete "Permalink to this definition")Delete a document from the index.All nodes in the index related to the index will be deleted.

Parameters**doc\_id** (*str*) – A doc\_id of the ingested document

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*property* docstore*: [BaseDocumentStore](../storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.docstore "Permalink to this definition")Get the docstore corresponding to the index.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.index_id "Permalink to this definition")Get the index struct.

*property* index\_struct*: IS*[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.index_struct "Permalink to this definition")Get the index struct.

index\_struct\_cls[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.index_struct_cls "Permalink to this definition")alias of `KeywordTable`

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.RAKEKeywordTableIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
*class* llama\_index.indices.keyword\_table.SimpleKeywordTableIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[KeywordTable] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_chunk: int = 10*, *use\_async: bool = False*, *show\_progress: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex "Permalink to this definition")Simple Keyword Table Index.

This index uses a simple regex extractor to extract keywords from the text.

build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete(*doc\_id: str*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.delete "Permalink to this definition")Delete a document from the index.All nodes in the index related to the index will be deleted.

Parameters**doc\_id** (*str*) – A doc\_id of the ingested document

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*property* docstore*: [BaseDocumentStore](../storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.docstore "Permalink to this definition")Get the docstore corresponding to the index.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

*property* index\_id*: str*[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.index_id "Permalink to this definition")Get the index struct.

*property* index\_struct*: IS*[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.index_struct "Permalink to this definition")Get the index struct.

index\_struct\_cls[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.index_struct_cls "Permalink to this definition")alias of `KeywordTable`

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.keyword_table.SimpleKeywordTableIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
