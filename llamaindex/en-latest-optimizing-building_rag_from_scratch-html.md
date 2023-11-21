Building RAG from Scratch (Lower-Level)[](#building-rag-from-scratch-lower-level "Permalink to this heading")
==============================================================================================================

This doc is a hub for showing how you can build RAG and agent-based apps using only lower-level abstractions (e.g. LLMs, prompts, embedding models), and without using more “packaged” out of the box abstractions.

Out of the box abstractions include:

* High-level ingestion code e.g. `VectorStoreIndex.from\_documents`
* High-level query and retriever code e.g. `VectorStoreIndex.as\_retriever()` and `VectorStoreIndex.as\_query\_engine()`
* High-level agent abstractions e.g. `OpenAIAgent`

Instead of using these, the goal here is to educate users on what’s going on under the hood. By showing you the underlying algorithms for constructing RAG and agent pipelines, you can then be empowered to create your own custom LLM workflows (while still using LlamaIndex abstractions at any level of granularity that makes sense).

We show how to build an app from scratch, component by component. For the sake of focus, each tutorial will show how to build a specific component from scratch while using out-of-the-box abstractions for other components. **NOTE**: This is a WIP document, we’re in the process of fleshing this out!

Building Ingestion from Scratch[](#building-ingestion-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------

This tutorial shows how you can define an ingestion pipeline into a vector store.

* [Building Data Ingestion from Scratch](../examples/low_level/ingestion.html)
* [Pinecone](../examples/low_level/ingestion.html#pinecone)
* [OpenAI](../examples/low_level/ingestion.html#openai)
Building Vector Retrieval from Scratch[](#building-vector-retrieval-from-scratch "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

This tutorial shows you how to build a retriever to query an vector store.

* [Building Retrieval from Scratch](../examples/low_level/retrieval.html)
Building Ingestion/Retrieval from Scratch (Open-Source/Local Components)[](#building-ingestion-retrieval-from-scratch-open-source-local-components "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

This tutoral shows you how to build an ingestion/retrieval pipeline using onlyopen-source components.

* [Building RAG from Scratch (Open-source only!)](../examples/low_level/oss_ingestion_retrieval.html)
Building a (Very Simple) Vector Store from Scratch[](#building-a-very-simple-vector-store-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------

If you want to learn more about how vector stores work, here’s a tutorial showing you how to build a very simple vector store capable of dense search + metadata filtering.

Obviously not a replacement for production databases.

* [Building a (Very Simple) Vector Store from Scratch](../examples/low_level/vector_store.html)
Building Response Synthesis from Scratch[](#building-response-synthesis-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

This tutorial shows you how to use the LLM to synthesize results given a set of retrieved context. Deals with context overflows, async calls, and source citations!

* [Building Response Synthesis from Scratch](../examples/low_level/response_synthesis.html)
Building Evaluation from Scratch[](#building-evaluation-from-scratch "Permalink to this heading")
--------------------------------------------------------------------------------------------------

Learn how to build common LLM-based eval modules (correctness, faithfulness) using LLMs and prompt modules; this will help you define your own custom evals!

* [Building Evaluation from Scratch](../examples/low_level/evaluation.html)
Building Advanced RAG from Scratch[](#building-advanced-rag-from-scratch "Permalink to this heading")
------------------------------------------------------------------------------------------------------

These tutorials will show you how to build advanced functionality beyond the basic RAG pipeline. Especially helpful for advanced users with custom workflows / production needs.

### Building a Router from Scratch[](#building-a-router-from-scratch "Permalink to this heading")

Beyond the standard RAG pipeline, this takes you one step towards automated decision making with LLMs by showing you how to build a router module from scratch.

* [Building a Router from Scratch](../examples/low_level/router.html)
### Building RAG Fusion Retriever from Scratch[](#building-rag-fusion-retriever-from-scratch "Permalink to this heading")

Here we show you how to build an advanced retriever capable of query-rewriting, ensembling, dynamic retrieval.

* [Building an Advanced Fusion Retriever from Scratch](../examples/low_level/fusion_retriever.html)
