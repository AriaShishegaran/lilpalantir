Knowledge Graph Query Engine[](#module-llama_index.query_engine.knowledge_graph_query_engine "Permalink to this heading")
==========================================================================================================================

Knowledge Graph Query Engine.

*class* llama\_index.query\_engine.knowledge\_graph\_query\_engine.KnowledgeGraphQueryEngine(*service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](../../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *graph\_query\_synthesis\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *graph\_response\_answer\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refresh\_schema: bool = False*, *verbose: bool = False*, *response\_synthesizer: Optional[[BaseSynthesizer](../response_synthesizer.html#llama_index.response_synthesizers.BaseSynthesizer "llama_index.response_synthesizers.base.BaseSynthesizer")] = None*, *\*\*kwargs: Any*)[](#llama_index.query_engine.knowledge_graph_query_engine.KnowledgeGraphQueryEngine "Permalink to this definition")Knowledge graph query engine.

Query engine to call a knowledge graph.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context to use.
* **storage\_context** (*Optional**[*[*StorageContext*](../../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*]*) – A storage context to use.
* **refresh\_schema** (*bool*) – Whether to refresh the schema.
* **verbose** (*bool*) – Whether to print intermediate results.
* **response\_synthesizer** (*Optional**[*[*BaseSynthesizer*](../response_synthesizer.html#llama_index.response_synthesizers.BaseSynthesizer "llama_index.response_synthesizers.BaseSynthesizer")*]*) – A BaseSynthesizer object.
* **\*\*kwargs** – Additional keyword arguments.
*async* agenerate\_query(*query\_str: str*) → str[](#llama_index.query_engine.knowledge_graph_query_engine.KnowledgeGraphQueryEngine.agenerate_query "Permalink to this definition")Generate a Graph Store Query from a query bundle.

generate\_query(*query\_str: str*) → str[](#llama_index.query_engine.knowledge_graph_query_engine.KnowledgeGraphQueryEngine.generate_query "Permalink to this definition")Generate a Graph Store Query from a query bundle.

get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.knowledge_graph_query_engine.KnowledgeGraphQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.knowledge_graph_query_engine.KnowledgeGraphQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

