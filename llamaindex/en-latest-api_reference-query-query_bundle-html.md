Query Bundle[](#module-llama_index.indices.query.schema "Permalink to this heading")
=====================================================================================

Query Schema.

This schema is used under the hood for all queries, but is primarilyexposed for recursive queries over composable indices.

*class* llama\_index.indices.query.schema.QueryBundle(*query\_str: str*, *custom\_embedding\_strs: Optional[List[str]] = None*, *embedding: Optional[List[float]] = None*)[](#llama_index.indices.query.schema.QueryBundle "Permalink to this definition")Query bundle.

This dataclass contains the original query string and associated transformations.

Parameters* **query\_str** (*str*) – the original user-specified query string.This is currently used by all non embedding-based queries.
* **embedding\_strs** (*list**[**str**]*) – list of strings used for embedding the query.This is currently used by all embedding-based queries.
* **embedding** (*list**[**float**]*) – the stored embedding for the query.
*property* embedding\_strs*: List[str]*[](#llama_index.indices.query.schema.QueryBundle.embedding_strs "Permalink to this definition")Use custom embedding strs if specified, otherwise use query str.

