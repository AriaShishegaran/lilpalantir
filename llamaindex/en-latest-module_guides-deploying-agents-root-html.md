Data Agents[](#data-agents "Permalink to this heading")
========================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Data Agents are LLM-powered knowledge workers in LlamaIndex that can intelligently perform various tasks over your data, in both a “read” and “write” function. They are capable of the following:

* Perform automated search and retrieval over different types of data - unstructured, semi-structured, and structured.
* Calling any external service API in a structured fashion, and processing the response + storing it for later.

In that sense, agents are a step beyond our [query engines](../query_engine/root.html) in that they can not only “read” from a static source of data, but can dynamically ingest and modify data from a variety of different tools.

Building a data agent requires the following core components:

* A reasoning loop
* Tool abstractions

A data agent is initialized with set of APIs, or Tools, to interact with; these APIs can be called by the agent to return information or modify state. Given an input task, the data agent uses a reasoning loop to decide which tools to use, in which sequence, and the parameters to call each tool.

### Reasoning Loop[](#reasoning-loop "Permalink to this heading")

The reasoning loop depends on the type of agent. We have support for the following agents:

* OpenAI Function agent (built on top of the OpenAI Function API)
* a ReAct agent (which works across any chat/text completion endpoint).
### Tool Abstractions[](#tool-abstractions "Permalink to this heading")

You can learn more about our Tool abstractions in our [Tools section](tools/root.html).

### Blog Post[](#blog-post "Permalink to this heading")

For full details, please check out our detailed [blog post](https://medium.com/llamaindex-blog/data-agents-eed797d7972f).

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Data agents can be used in the following manner (the example uses the OpenAI Function API)


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAI# import and define tools...# initialize llmllm = OpenAI(model="gpt-3.5-turbo-0613")# initialize openai agentagent = OpenAIAgent.from\_tools(tools, llm=llm, verbose=True)
```
See our usage pattern guide for more details.

* [Usage Pattern](usage_pattern.html)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

Learn more about our different agent types in our module guides below.

Also take a look at our [tools section](tools/root.html)!

* [Module Guides](modules.html)
	+ [OpenAI Agent](modules.html#openai-agent)
	+ [[Beta] OpenAI Assistant Agent](modules.html#beta-openai-assistant-agent)
	+ [ReAct Agent](modules.html#react-agent)
* [Tools](tools/root.html)
	+ [Concept](tools/root.html#concept)
	+ [Usage Pattern](tools/root.html#usage-pattern)
	+ [LlamaHub Tools Guide 🛠️](tools/root.html#llamahub-tools-guide)
