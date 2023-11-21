Deprecated Terms[](#deprecated-terms "Permalink to this heading")
==================================================================

As LlamaIndex continues to evolve, many class names and APIs have been adjusted, improved, and deprecated.

The following is a list of previously popular terms that have been deprecated, with links to their replacements.

GPTSimpleVectorIndex[](#gptsimplevectorindex "Permalink to this heading")
--------------------------------------------------------------------------

This has been renamed to `VectorStoreIndex`, as well as unifying all vector indexes to a single unified interface. You can integrate with various vector databases by modifying the underlying `vector\_store`.

Please see the following links for more details on usage.

* [Index Usage Pattern](../module_guides/indexing/usage_pattern.html)
* [Vector Store Guide](../module_guides/indexing/vector_store_guide.html)
* [Vector Store Integrations](../community/integrations/vector_stores.html)
GPTVectorStoreIndex[](#gptvectorstoreindex "Permalink to this heading")
------------------------------------------------------------------------

This has been renamed to `VectorStoreIndex`, but it is only a cosmetic change. Please see the following links for more details on usage.

* [Index Usage Pattern](../module_guides/indexing/usage_pattern.html)
* [Vector Store Guide](../module_guides/indexing/vector_store_guide.html)
* [Vector Store Integrations](../community/integrations/vector_stores.html)
LLMPredictor[](#llmpredictor "Permalink to this heading")
----------------------------------------------------------

The `LLMPredictor` object is no longer intended to be used by users. Instead, you can setup an LLM directly and pass it into the `ServiceContext`.

* [LLMs in LlamaIndex](../module_guides/models/llms.html)
* [Setting LLMs in the ServiceContext](../module_guides/supporting_modules/service_context.html)
PromptHelper and max\_input\_size/[](#prompthelper-and-max-input-size "Permalink to this heading")
---------------------------------------------------------------------------------------------------

The `max\_input\_size` parameter for the prompt helper has since been replaced with `context\_window`.

The `PromptHelper` in general has been deprecated in favour of specifying parameters directly in the `service\_context` and `node\_parser`.

See the following links for more details.

* [Configuring settings in the Service Context](../module_guides/supporting_modules/service_context.html)
* [Parsing Documents into Nodes](../module_guides/loading/node_parsers/root.html)
