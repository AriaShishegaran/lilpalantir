Playground[](#module-llama_index.playground.base "Permalink to this heading")
==============================================================================

Experiment with different indices, models, and more.

*class* llama\_index.playground.base.Playground(*indices: ~typing.List[~llama\_index.indices.base.BaseIndex], retriever\_modes: ~typing.Dict[~typing.Type[~llama\_index.indices.base.BaseIndex], ~typing.List[str]] = {<class 'llama\_index.indices.tree.base.TreeIndex'>: ['select\_leaf', 'select\_leaf\_embedding', 'all\_leaf', 'root'], <class 'llama\_index.indices.list.base.SummaryIndex'>: ['default', 'embedding', 'llm'], <class 'llama\_index.indices.vector\_store.base.VectorStoreIndex'>: ['default']}*)[](#llama_index.playground.base.Playground "Permalink to this definition")Experiment with indices, models, embeddings, retriever\_modes, and more.

compare(*query\_text: str*, *to\_pandas: bool | None = True*) → Union[DataFrame, List[Dict[str, Any]]][](#llama_index.playground.base.Playground.compare "Permalink to this definition")Compare index outputs on an input query.

Parameters* **query\_text** (*str*) – Query to run all indices on.
* **to\_pandas** (*Optional**[**bool**]*) – Return results in a pandas dataframe.True by default.
ReturnsThe output of each index along with other data, such as the time it took tocompute. Results are stored in a Pandas Dataframe or a list of Dicts.

*classmethod* from\_docs(*documents: ~typing.List[~llama\_index.schema.Document], index\_classes: ~typing.List[~typing.Type[~llama\_index.indices.base.BaseIndex]] = [<class 'llama\_index.indices.vector\_store.base.VectorStoreIndex'>, <class 'llama\_index.indices.tree.base.TreeIndex'>, <class 'llama\_index.indices.list.base.SummaryIndex'>], retriever\_modes: ~typing.Dict[~typing.Type[~llama\_index.indices.base.BaseIndex], ~typing.List[str]] = {<class 'llama\_index.indices.tree.base.TreeIndex'>: ['select\_leaf', 'select\_leaf\_embedding', 'all\_leaf', 'root'], <class 'llama\_index.indices.list.base.SummaryIndex'>: ['default', 'embedding', 'llm'], <class 'llama\_index.indices.vector\_store.base.VectorStoreIndex'>: ['default']}, \*\*kwargs: ~typing.Any*) → [Playground](#llama_index.playground.base.Playground "llama_index.playground.base.Playground")[](#llama_index.playground.base.Playground.from_docs "Permalink to this definition")Initialize with Documents using the default list of indices.

Parameters**documents** – A List of Documents to experiment with.

*property* indices*: List[[BaseIndex](indices.html#llama_index.indices.base.BaseIndex "llama_index.indices.base.BaseIndex")]*[](#llama_index.playground.base.Playground.indices "Permalink to this definition")Get Playground’s indices.

*property* retriever\_modes*: dict*[](#llama_index.playground.base.Playground.retriever_modes "Permalink to this definition")Get Playground’s indices.

