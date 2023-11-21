Tools[](#tools "Permalink to this heading")
============================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Having proper tool abstractions is at the core of building [data agents](../root.html). Defining a set of Tools is similar to defining any API interface, with the exception that these Tools are meant for agent rather than human use. We allow users to define both a **Tool** as well as a **ToolSpec** containing a series of functions under the hood.

A Tool implements a very generic interface - simply define `\_\_call\_\_` and also return some basic metadata (name, description, function schema).

A Tool Spec defines a full API specification of any service that can be converted into a list of Tools.

We offer a few different types of Tools:

* `FunctionTool`: A function tool allows users to easily convert any user-defined function into a Tool. It can also auto-infer the function schema.
* `QueryEngineTool`: A tool that wraps an existing [query engine](../../query_engine/root.html). Note: since our agent abstractions inherit from `BaseQueryEngine`, these tools can also wrap other agents.

We offer a rich set of Tools and Tool Specs through [LlamaHub](https://llamahub.ai/) 🦙.

### Blog Post[](#blog-post "Permalink to this heading")

For full details, please check out our detailed [blog post](https://blog.llamaindex.ai/building-better-tools-for-llm-agents-f8c5a6714f11).

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Our Tool Specs and Tools can be imported from the `llama-hub` package.

To use with our agent,


```
from llama\_index.agent import OpenAIAgentfrom llama\_hub.tools.gmail.base import GmailToolSpectool\_spec = GmailToolSpec()agent = OpenAIAgent.from\_tools(tool\_spec.to\_tool\_list(), verbose=True)
```
See our Usage Pattern Guide for more details.

* [Usage Pattern](usage_pattern.html)
LlamaHub Tools Guide 🛠️[](#llamahub-tools-guide "Permalink to this heading")
-----------------------------------------------------------------------------

Check out our guide for a full overview of the Tools/Tool Specs in LlamaHub!

* [LlamaHub Tools Guide](llamahub_tools_guide.html)
