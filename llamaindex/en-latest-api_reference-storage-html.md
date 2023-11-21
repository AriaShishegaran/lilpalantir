Storage Context[](#storage-context "Permalink to this heading")
================================================================

LlamaIndex offers core abstractions around storage of Nodes, indices, and vectors.A key abstraction is the StorageContext - this contains the underlyingBaseDocumentStore (for nodes), BaseIndexStore (for indices), and VectorStore (for vectors).

The Document/Node and index stores rely on a common KVStore abstraction, which is also detailed below.

We show the API references for the Storage Classes, loading indices from the Storage Context, and the Storage Context class itself below.

  
Storage Classes

* [Document Store](storage/docstore.html)
* [Index Store](storage/index_store.html)
* [Vector Store](storage/vector_store.html)
* [KV Storage](storage/kv_store.html)
  
Loading Indices

* [Loading Indices](storage/indices_save_load.html)


---

*class* llama\_index.storage.storage\_context.StorageContext(*docstore: [BaseDocumentStore](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")*, *index\_store: BaseIndexStore*, *vector\_stores: Dict[str, VectorStore]*, *graph\_store: GraphStore*)[](#llama_index.storage.storage_context.StorageContext "Permalink to this definition")Storage context.

The storage context container is a utility container for storing nodes,indices, and vectors. It contains the following:- docstore: BaseDocumentStore- index\_store: BaseIndexStore- vector\_store: VectorStore- graph\_store: GraphStore

add\_vector\_store(*vector\_store: VectorStore*, *namespace: str*) → None[](#llama_index.storage.storage_context.StorageContext.add_vector_store "Permalink to this definition")Add a vector store to the storage context.

*classmethod* from\_defaults(*docstore: Optional[[BaseDocumentStore](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.types.BaseDocumentStore")] = None*, *index\_store: Optional[BaseIndexStore] = None*, *vector\_store: Optional[VectorStore] = None*, *vector\_stores: Optional[Dict[str, VectorStore]] = None*, *graph\_store: Optional[GraphStore] = None*, *persist\_dir: Optional[str] = None*, *fs: Optional[AbstractFileSystem] = None*) → [StorageContext](#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")[](#llama_index.storage.storage_context.StorageContext.from_defaults "Permalink to this definition")Create a StorageContext from defaults.

Parameters* **docstore** (*Optional**[*[*BaseDocumentStore*](storage/docstore.html#llama_index.storage.docstore.BaseDocumentStore "llama_index.storage.docstore.BaseDocumentStore")*]*) – document store
* **index\_store** (*Optional**[**BaseIndexStore**]*) – index store
* **vector\_store** (*Optional**[**VectorStore**]*) – vector store
* **graph\_store** (*Optional**[**GraphStore**]*) – graph store
*classmethod* from\_dict(*save\_dict: dict*) → [StorageContext](#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")[](#llama_index.storage.storage_context.StorageContext.from_dict "Permalink to this definition")Create a StorageContext from dict.

persist(*persist\_dir: Union[str, PathLike] = './storage'*, *docstore\_fname: str = 'docstore.json'*, *index\_store\_fname: str = 'index\_store.json'*, *vector\_store\_fname: str = 'vector\_store.json'*, *image\_store\_fname: str = 'image\_store.json'*, *graph\_store\_fname: str = 'graph\_store.json'*, *fs: Optional[AbstractFileSystem] = None*) → None[](#llama_index.storage.storage_context.StorageContext.persist "Permalink to this definition")Persist the storage context.

Parameters**persist\_dir** (*str*) – directory to persist the storage context

*property* vector\_store*: VectorStore*[](#llama_index.storage.storage_context.StorageContext.vector_store "Permalink to this definition")Backwrds compatibility for vector\_store property.

