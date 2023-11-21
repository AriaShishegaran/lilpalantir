Using with Langchain 🦜🔗[](#using-with-langchain "Permalink to this heading")
=============================================================================

LlamaIndex provides both Tool abstractions for a Langchain agent as well as a memory module.

The API reference of the Tool abstractions + memory modules are [here](../../api_reference/langchain_integrations/base.html).

Use any data loader as a Langchain Tool[](#use-any-data-loader-as-a-langchain-tool "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------

LlamaIndex allows you to use any data loader within the LlamaIndex core repo or in [LlamaHub](https://llamahub.ai/) as an “on-demand” data query Tool within a LangChain agent.

The Tool will 1) load data using the data loader, 2) index the data, and 3) query the data and return the response in an ad-hoc manner.

**Resources**

* [OnDemandLoaderTool Tutorial](../../examples/tools/OnDemandLoaderTool.html)
Use a query engine as a Langchain Tool[](#use-a-query-engine-as-a-langchain-tool "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

LlamaIndex provides Tool abstractions so that you can use a LlamaIndex query engine along with a Langchain agent.

For instance, you can choose to create a “Tool” from an `QueryEngine` directly as follows:


```
from llama\_index.langchain\_helpers.agents import (    IndexToolConfig,    LlamaIndexTool,)tool\_config = IndexToolConfig(    query\_engine=query\_engine,    name=f"Vector Index",    description=f"useful for when you want to answer queries about X",    tool\_kwargs={"return\_direct": True},)tool = LlamaIndexTool.from\_tool\_config(tool\_config)
```
Llama Demo Notebook: Tool + Memory module[](#llama-demo-notebook-tool-memory-module "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------

We provide another demo notebook showing how you can build a chat agent with the following components.

* Using LlamaIndex as a generic callable tool with a Langchain agent
* Using LlamaIndex as a memory module; this allows you to insert arbitrary amounts of conversation history with a Langchain chatbot!

Please see the [notebook here](https://github.com/jerryjliu/llama_index/blob/main/examples/langchain_demo/LangchainDemo.ipynb).

