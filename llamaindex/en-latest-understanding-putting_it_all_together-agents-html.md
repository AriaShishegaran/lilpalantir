Agents[](#agents "Permalink to this heading")
==============================================

“Agent-like” Components within LlamaIndex[](#agent-like-components-within-llamaindex "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

LlamaIndex provides core modules capable of automated reasoning for different use cases over your data.

Some of these core modules are shown below along with example tutorials (not comprehensive, please click into the guides/how-tos for more details).

**SubQuestionQueryEngine for Multi-Document Analysis**

* [Sub Question Query Engine (Intro)](../../examples/query_engine/sub_question_query_engine.html)
* [10Q Analysis (Uber)](../../examples/usecases/10q_sub_question.html)
* [10K Analysis (Uber and Lyft)](../../examples/usecases/10k_sub_question.html)

**Query Transformations**

* [How-To](../../optimizing/advanced_retrieval/query_transformations.html)
* [Multi-Step Query Decomposition](../../examples/query_transformations/HyDEQueryTransformDemo.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_transformations/HyDEQueryTransformDemo.ipynb))

**Routing**

* [Usage](../../module_guides/querying/router/root.html)
* [Router Query Engine Guide](../../examples/query_engine/RouterQueryEngine.html) ([Notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/query_engine/RouterQueryEngine.ipynb))

**LLM Reranking**

* [Second Stage Processing How-To](../../module_guides/querying/node_postprocessors/root.html)
* [LLM Reranking Guide (Great Gatsby)](../../examples/node_postprocessor/LLMReranker-Gatsby.html)

**Chat Engines**

* [Chat Engines How-To](../../module_guides/deploying/chat_engines/root.html)
Using LlamaIndex as as Tool within an Agent Framework[](#using-llamaindex-as-as-tool-within-an-agent-framework "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------

LlamaIndex can be used as as Tool within an agent framework - including LangChain, ChatGPT. These integrations are described below.

### LangChain[](#langchain "Permalink to this heading")

We have deep integrations with LangChain.LlamaIndex query engines can be easily packaged as Tools to be used within a LangChain agent, and LlamaIndex can also be used as a memory module / retriever. Check out our guides/tutorials below!

**Resources**

* [LangChain integration guide](../../community/integrations/using_with_langchain.html)
* [Building a Chatbot Tutorial (LangChain + LlamaIndex)](chatbots/building_a_chatbot.html)
* [OnDemandLoaderTool Tutorial](../../examples/tools/OnDemandLoaderTool.html)
### ChatGPT[](#chatgpt "Permalink to this heading")

LlamaIndex can be used as a ChatGPT retrieval plugin (we have a TODO to develop a more general plugin as well).

**Resources**

* [LlamaIndex ChatGPT Retrieval Plugin](https://github.com/openai/chatgpt-retrieval-plugin#llamaindex)
Native OpenAIAgent[](#native-openaiagent "Permalink to this heading")
----------------------------------------------------------------------

With the [new OpenAI API](https://openai.com/blog/function-calling-and-other-api-updates) that supports function calling, it’s never been easier to build your own agent!

Learn how to write your own OpenAI agent in **under 50 lines of code**, or directly use our super simple`OpenAIAgent` implementation.

