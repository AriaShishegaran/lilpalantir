Loading Indices[](#module-llama_index.indices.loading "Permalink to this heading")
===================================================================================

llama\_index.indices.loading.load\_graph\_from\_storage(*storage\_context: [StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*, *root\_id: str*, *\*\*kwargs: Any*) → [ComposableGraph](../composability.html#llama_index.composability.ComposableGraph "llama_index.indices.composability.graph.ComposableGraph")[](#llama_index.indices.loading.load_graph_from_storage "Permalink to this definition")Load composable graph from storage context.

Parameters* **storage\_context** ([*StorageContext*](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")) – storage context containingdocstore, index store and vector store.
* **root\_id** (*str*) – ID of the root index of the graph.
* **\*\*kwargs** – Additional keyword args to pass to the index constructors.
llama\_index.indices.loading.load\_index\_from\_storage(*storage\_context: [StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*, *index\_id: Optional[str] = None*, *\*\*kwargs: Any*) → [BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")[](#llama_index.indices.loading.load_index_from_storage "Permalink to this definition")Load index from storage context.

Parameters* **storage\_context** ([*StorageContext*](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")) – storage context containingdocstore, index store and vector store.
* **index\_id** (*Optional**[**str**]*) – ID of the index to load.Defaults to None, which assumes there’s only a single indexin the index store and load it.
* **\*\*kwargs** – Additional keyword args to pass to the index constructors.
llama\_index.indices.loading.load\_indices\_from\_storage(*storage\_context: [StorageContext](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*, *index\_ids: Optional[Sequence[str]] = None*, *\*\*kwargs: Any*) → List[[BaseIndex](../indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")][](#llama_index.indices.loading.load_indices_from_storage "Permalink to this definition")Load multiple indices from storage context.

Parameters* **storage\_context** ([*StorageContext*](../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")) – storage context containingdocstore, index store and vector store.
* **index\_id** (*Optional**[**Sequence**[**str**]**]*) – IDs of the indices to load.Defaults to None, which loads all indices in the index store.
* **\*\*kwargs** – Additional keyword args to pass to the index constructors.
