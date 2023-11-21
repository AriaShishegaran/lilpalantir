Composability[](#composability "Permalink to this heading")
============================================================

Below we show the API reference for composable data structures.This contains both the ComposableGraph class as well as anybuilder classes that generate ComposableGraph objects.

Init composability.

*class* llama\_index.composability.ComposableGraph(*all\_indices: Dict[str, [BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*, *root\_id: str*, *storage\_context: Optional[[StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*)[](#llama_index.composability.ComposableGraph "Permalink to this definition")Composable graph.

*classmethod* from\_indices(*root\_index\_cls: Type[[BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*, *children\_indices: Sequence[[BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*, *index\_summaries: Optional[Sequence[str]] = None*, *service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *\*\*kwargs: Any*) → [ComposableGraph](#llama_index.composability.ComposableGraph "llama_index.indices.composability.graph.ComposableGraph")[](#llama_index.composability.ComposableGraph.from_indices "Permalink to this definition")Create composable graph using this index class as the root.

get\_index(*index\_struct\_id: Optional[str] = None*) → [BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")[](#llama_index.composability.ComposableGraph.get_index "Permalink to this definition")Get index from index struct id.

*class* llama\_index.composability.QASummaryQueryEngineBuilder(*storage\_context: Optional[[StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *service\_context: Optional[[ServiceContext](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *summary\_text: str = 'Use this index for summarization queries'*, *qa\_text: str = 'Use this index for queries that require retrieval of specific context from documents.'*)[](#llama_index.composability.QASummaryQueryEngineBuilder "Permalink to this definition")Joint QA Summary graph builder.

Can build a graph that provides a unified query interfacefor both QA and summarization tasks.

NOTE: this is a beta feature. The API may change in the future.

Parameters* **docstore** ([*BaseDocumentStore*](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.BaseDocumentStore")) – A BaseDocumentStore to use for storing nodes.
* **service\_context** ([*ServiceContext*](service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")) – A ServiceContext to use forbuilding indices.
* **summary\_text** (*str*) – Text to use for the summary index.
* **qa\_text** (*str*) – Text to use for the QA index.
* **node\_parser** ([*NodeParser*](service_context/node_parser.html#llama_index.node_parser.NodeParser "llama_index.node_parser.NodeParser")) – A NodeParser to use for parsing.
build\_from\_documents(*documents: Sequence[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")]*) → [RouterQueryEngine](query/query_engines/router_query_engine.html#llama_index.query_engine.router_query_engine.RouterQueryEngine "llama_index.query_engine.router_query_engine.RouterQueryEngine")[](#llama_index.composability.QASummaryQueryEngineBuilder.build_from_documents "Permalink to this definition")Build query engine.

