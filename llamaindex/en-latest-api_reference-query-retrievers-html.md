Retrievers[](#retrievers "Permalink to this heading")
======================================================

Index Retrievers[](#index-retrievers "Permalink to this heading")
------------------------------------------------------------------

Below we show index-specific retriever classes.

Index Retrievers

* [Empty Index Retriever](retrievers/empty.html)
* [Knowledge Graph Retriever](retrievers/kg.html)
* [List Retriever](retrievers/list.html)
* [Keyword Table Retrievers](retrievers/table.html)
* [Tree Retrievers](retrievers/tree.html)
* [Vector Store Retrievers](retrievers/vector_store.html)
NOTE: our structured indices (e.g. PandasIndex) don’t haveany retrievers, since they are not designed to be used with the retriever API.Please see the [Query Engine](query_engines.html#ref-query-engines) page for more details.

Additional Retrievers[](#additional-retrievers "Permalink to this heading")
----------------------------------------------------------------------------

Here we show additional retriever classes; these classescan augment existing retrievers with new capabilities (e.g. query transforms).

Additional Retrievers

* [Transform Retriever](retrievers/transform.html)
Base Retriever[](#base-retriever "Permalink to this heading")
--------------------------------------------------------------

Here we show the base retriever class, which contains the retrievemethod which is shared amongst all retrievers.

*class* llama\_index.indices.base\_retriever.BaseRetriever[](#llama_index.indices.base_retriever.BaseRetriever "Permalink to this definition")Base retriever.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.base_retriever.BaseRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.base_retriever.BaseRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.base_retriever.BaseRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.base_retriever.BaseRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

