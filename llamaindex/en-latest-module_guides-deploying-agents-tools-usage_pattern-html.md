Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

You can create custom LlamaHub Tool Specs and Tools or they can be imported from the `llama-hub` package. They can be plugged into our native agents, or LangChain agents.

Using with our Agents[](#using-with-our-agents "Permalink to this heading")
----------------------------------------------------------------------------

To use with our OpenAIAgent,


```
from llama\_index.agent import OpenAIAgentfrom llama\_hub.tools.gmail.base import GmailToolSpecfrom llama\_index.tools.function\_tool import FunctionTool# Use a tool spec from Llama-Hubtool\_spec = GmailToolSpec()# Create a custom tool. Type annotations and docstring are used for the# tool definition sent to the Function calling API.def add\_numbers(x: int, y: int) -> int: """ Adds the two numbers together and returns the result. """    return x + yfunction\_tool = FunctionTool.from\_defaults(fn=add\_numbers)tools = tool\_spec.to\_tool\_list() + [function\_tool]agent = OpenAIAgent.from\_tools(tools, verbose=True)# use agentagent.chat(    "Can you create a new email to helpdesk and support @example.com about a service outage")
```
Full Tool details can be found on our [LlamaHub](https://llamahub.ai) page. Each tool contains a “Usage” section showing how that tool can be used.

Using with LangChain[](#using-with-langchain "Permalink to this heading")
--------------------------------------------------------------------------

To use with a LangChain agent, simply convert tools to LangChain tools with `to\_langchain\_tool()`.


```
tools = tool\_spec.to\_tool\_list()langchain\_tools = [t.to\_langchain\_tool() for t in tools]# plug into LangChain agentfrom langchain.agents import initialize\_agentagent\_executor = initialize\_agent(    langchain\_tools,    llm,    agent="conversational-react-description",    memory=memory,)
```
