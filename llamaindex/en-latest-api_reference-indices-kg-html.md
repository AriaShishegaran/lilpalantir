Knowledge Graph Index[](#knowledge-graph-index "Permalink to this heading")
============================================================================

Building the Knowledge Graph Index

KG-based data structures.

llama\_index.indices.knowledge\_graph.GPTKnowledgeGraphIndex[](#llama_index.indices.knowledge_graph.GPTKnowledgeGraphIndex "Permalink to this definition")alias of [`KnowledgeGraphIndex`](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex "llama_index.indices.knowledge_graph.base.KnowledgeGraphIndex")

*class* llama\_index.indices.knowledge\_graph.KGTableRetriever(*index: [KnowledgeGraphIndex](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex "llama_index.indices.knowledge_graph.base.KnowledgeGraphIndex")*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *include\_text: bool = True*, *retriever\_mode: Optional[[KGRetrieverMode](../query/retrievers/kg.html#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode "llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode")] = KGRetrieverMode.KEYWORD*, *similarity\_top\_k: int = 2*, *graph\_store\_query\_depth: int = 2*, *use\_global\_node\_triplets: bool = False*, *max\_knowledge\_sequence: int = 30*, *\*\*kwargs: Any*)[](#llama_index.indices.knowledge_graph.KGTableRetriever "Permalink to this definition")KG Table Retriever.

Arguments are shared among subclasses.

Parameters* **query\_keyword\_extract\_template** (*Optional**[**QueryKGExtractPrompt**]*) – A QueryKG ExtractionPrompt (see [Prompt Templates](../prompts.html#prompt-templates)).
* **refine\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Refinement Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Question Answering Prompt(see [Prompt Templates](../prompts.html#prompt-templates)).
* **max\_keywords\_per\_query** (*int*) – Maximum number of keywords to extract from query.
* **num\_chunks\_per\_query** (*int*) – Maximum number of text chunks to query.
* **include\_text** (*bool*) – Use the document text source from each relevant tripletduring queries.
* **retriever\_mode** ([*KGRetrieverMode*](../query/retrievers/kg.html#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode "llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode")) – Specifies whether to use keywords,embeddings, or both to find relevant triplets. Should be one of “keyword”,“embedding”, or “hybrid”.
* **similarity\_top\_k** (*int*) – The number of top embeddings to use(if embeddings are used).
* **graph\_store\_query\_depth** (*int*) – The depth of the graph store query.
* **use\_global\_node\_triplets** (*bool*) – Whether to get more keywords(entities) fromtext chunks matched by keywords. This helps introduce more global knowledge.While it’s more expensive, thus to be turned off by default.
* **max\_knowledge\_sequence** (*int*) – The maximum number of knowledge sequence toinclude in the response. By default, it’s 30.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.knowledge_graph.KGTableRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.knowledge_graph.KGTableRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.knowledge_graph.KGTableRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.knowledge_graph.KGTableRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.knowledge\_graph.KnowledgeGraphIndex(*nodes: Optional[Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]] = None*, *index\_struct: Optional[KG] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *kg\_triple\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_triplets\_per\_chunk: int = 10*, *include\_embeddings: bool = False*, *show\_progress: bool = False*, *max\_object\_length: int = 128*, *kg\_triplet\_extract\_fn: Optional[Callable] = None*, *\*\*kwargs: Any*)[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex "Permalink to this definition")Knowledge Graph Index.

Build a KG by extracting triplets, and leveraging the KG during query-time.

Parameters* **kg\_triple\_extract\_template** ([*BasePromptTemplate*](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")) – The prompt to use forextracting triplets.
* **max\_triplets\_per\_chunk** (*int*) – The maximum number of triplets to extract.
* **service\_context** (*Optional**[*[*ServiceContext*](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – The service context to use.
* **storage\_context** (*Optional**[*[*StorageContext*](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*]*) – The storage context to use.
* **graph\_store** (*Optional**[**GraphStore**]*) – The graph store to use.
* **show\_progress** (*bool*) – Whether to show tqdm progress bars. Defaults to False.
* **include\_embeddings** (*bool*) – Whether to include embeddings in the index.Defaults to False.
* **max\_object\_length** (*int*) – The maximum length of the object in a triplet.Defaults to 128.
* **kg\_triplet\_extract\_fn** (*Optional**[**Callable**]*) – The function to use forextracting triplets. Defaults to None.
add\_node(*keywords: List[str]*, *node: [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.add_node "Permalink to this definition")Add node.

Used for manual insertion of nodes (keyed by keywords).

Parameters* **keywords** (*List**[**str**]*) – Keywords to index the node.
* **node** (*Node*) – Node to be indexed.
build\_index\_from\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → IS[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.build_index_from_nodes "Permalink to this definition")Build the index from nodes.

delete\_nodes(*node\_ids: List[str]*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.delete_nodes "Permalink to this definition")Delete a list of nodes from the index.

Parameters**doc\_ids** (*List**[**str**]*) – A list of doc\_ids from the nodes to delete

delete\_ref\_doc(*ref\_doc\_id: str*, *delete\_from\_docstore: bool = False*, *\*\*delete\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.delete_ref_doc "Permalink to this definition")Delete a document and it’s nodes by using ref\_doc\_id.

*classmethod* from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *show\_progress: bool = False*, *\*\*kwargs: Any*) → IndexType[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.from_documents "Permalink to this definition")Create index from documents.

Parameters**documents** (*Optional**[**Sequence**[**BaseDocument**]**]*) – List of documents tobuild the index from.

get\_networkx\_graph(*limit: int = 100*) → Any[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.get_networkx_graph "Permalink to this definition")Get networkx representation of the graph structure.

Parameters**limit** (*int*) – Number of starting nodes to be included in the graph.

NOTE: This function requires networkx to be installed.NOTE: This is a beta feature.

*property* index\_id*: str*[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.index_id "Permalink to this definition")Get the index struct.

insert(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.insert "Permalink to this definition")Insert a document.

insert\_nodes(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *\*\*insert\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.insert_nodes "Permalink to this definition")Insert nodes.

*property* ref\_doc\_info*: Dict[str, RefDocInfo]*[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.ref_doc_info "Permalink to this definition")Retrieve a dict mapping of ingested documents and their nodes+metadata.

refresh(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.refresh "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

refresh\_ref\_docs(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *\*\*update\_kwargs: Any*) → List[bool][](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.refresh_ref_docs "Permalink to this definition")Refresh an index with documents that have changed.

This allows users to save LLM and Embedding model calls, while onlyupdating documents that have any changes in text or metadata. Itwill also insert any documents that previously were not stored.

set\_index\_id(*index\_id: str*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.set_index_id "Permalink to this definition")Set the index id.

NOTE: if you decide to set the index\_id on the index\_struct manually,you will need to explicitly call add\_index\_struct on the index\_storeto update the index store.

Parameters**index\_id** (*str*) – Index id to set.

update(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.update "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
update\_ref\_doc(*document: [Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")*, *\*\*update\_kwargs: Any*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.update_ref_doc "Permalink to this definition")Update a document and it’s corresponding nodes.

This is equivalent to deleting the document and then inserting it again.

Parameters* **document** (*Union**[**BaseDocument**,* [*BaseIndex*](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")*]*) – document to update
* **insert\_kwargs** (*Dict*) – kwargs to pass to insert
* **delete\_kwargs** (*Dict*) – kwargs to pass to delete
upsert\_triplet(*triplet: Tuple[str, str, str]*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.upsert_triplet "Permalink to this definition")Insert triplets.

Used for manual insertion of KG triplets (in the formof (subject, relationship, object)).

Parameters**triplet** (*str*) – Knowledge triplet

upsert\_triplet\_and\_node(*triplet: Tuple[str, str, str]*, *node: [BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphIndex.upsert_triplet_and_node "Permalink to this definition")Upsert KG triplet and node.

Calls both upsert\_triplet and add\_node.Behavior is idempotent; if Node already exists,only triplet will be added.

Parameters* **keywords** (*List**[**str**]*) – Keywords to index the node.
* **node** (*Node*) – Node to be indexed.
*class* llama\_index.indices.knowledge\_graph.KnowledgeGraphRAGRetriever(*service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *entity\_extract\_fn: Optional[Callable] = None*, *entity\_extract\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *entity\_extract\_policy: Optional[str] = 'union'*, *synonym\_expand\_fn: Optional[Callable] = None*, *synonym\_expand\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *synonym\_expand\_policy: Optional[str] = 'union'*, *max\_entities: int = 5*, *max\_synonyms: int = 5*, *retriever\_mode: Optional[str] = 'keyword'*, *with\_nl2graphquery: bool = False*, *graph\_traversal\_depth: int = 2*, *max\_knowledge\_sequence: int = 30*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.knowledge_graph.KnowledgeGraphRAGRetriever "Permalink to this definition")Knowledge Graph RAG retriever.

Retriever that perform SubGraph RAG towards knowledge graph.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context to use.
* **storage\_context** (*Optional**[*[*StorageContext*](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*]*) – A storage context to use.
* **entity\_extract\_fn** (*Optional**[**Callable**]*) – A function to extract entities.
* **Optional****[****BasePromptTemplate****]****)** (*entity\_extract\_template*) – A Query Key EntityExtraction Prompt (see [Prompt Templates](../prompts.html#prompt-templates)).
* **entity\_extract\_policy** (*Optional**[**str**]*) – The entity extraction policy to use.default: “union”possible values: “union”, “intersection”
* **synonym\_expand\_fn** (*Optional**[**Callable**]*) – A function to expand synonyms.
* **synonym\_expand\_template** (*Optional**[**QueryKeywordExpandPrompt**]*) – A Query Key EntityExpansion Prompt (see [Prompt Templates](../prompts.html#prompt-templates)).
* **synonym\_expand\_policy** (*Optional**[**str**]*) – The synonym expansion policy to use.default: “union”possible values: “union”, “intersection”
* **max\_entities** (*int*) – The maximum number of entities to extract.default: 5
* **max\_synonyms** (*int*) – The maximum number of synonyms to expand per entity.default: 5
* **retriever\_mode** (*Optional**[**str**]*) – The retriever mode to use.default: “keyword”possible values: “keyword”, “embedding”, “keyword\_embedding”
* **with\_nl2graphquery** (*bool*) – Whether to combine NL2GraphQuery in context.default: False
* **graph\_traversal\_depth** (*int*) – The depth of graph traversal.default: 2
* **max\_knowledge\_sequence** (*int*) – The maximum number of knowledge sequence toinclude in the response. By default, it’s 30.
* **verbose** (*bool*) – Whether to print out debug info.
get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.knowledge_graph.KnowledgeGraphRAGRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.knowledge_graph.KnowledgeGraphRAGRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query/query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.knowledge_graph.KnowledgeGraphRAGRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.knowledge_graph.KnowledgeGraphRAGRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

