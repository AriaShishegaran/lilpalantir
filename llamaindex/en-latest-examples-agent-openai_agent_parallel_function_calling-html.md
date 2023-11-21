Single-Turn Multi-Function Calling OpenAI Agents[](#single-turn-multi-function-calling-openai-agents "Permalink to this heading")
==================================================================================================================================

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent_parallel_function_calling.ipynb)

With the latest OpenAI API (v. 1.1.0+), users can now execute multiple function calls within a single turn of `User` and `Agent` dialogue. We’ve updated our library to enable this new feature as well, and in this notebook we’ll show you how it all works!

NOTE: OpenAI refers to this as “Parallel” function calling, but the current implementation doesn’t invoke parallel computations of the multiple function calls. So, it’s “parallelizable” function calling in terms of our current implementation.


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAIfrom llama\_index.tools import BaseTool, FunctionTool
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’ve seen any of our previous notebooks on OpenAI Agents, then you’re already familiar with the cookbook recipe that we have to follow here. But if not, or if you fancy a refresher then all we need to do (at a high level) are the following steps:

1. Define a set of tools (we’ll use `FunctionTool`) since Agents work with tools
2. Define the `LLM` for the Agent
3. Define a `OpenAIAgent`


```
def multiply(a: int, b: int) -> int: """Multiple two integers and returns the result integer"""    return a \* bmultiply\_tool = FunctionTool.from\_defaults(fn=multiply)
```

```
def add(a: int, b: int) -> int: """Add two integers and returns the result integer"""    return a + badd\_tool = FunctionTool.from\_defaults(fn=add)
```

```
llm = OpenAI(model="gpt-3.5-turbo-1106")agent = OpenAIAgent.from\_tools(    [multiply\_tool, add\_tool], llm=llm, verbose=True)
```
Sync mode[](#sync-mode "Permalink to this heading")
----------------------------------------------------


```
response = agent.chat("What is (121 \* 3) + 42?")print(str(response))
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: multiply with args: {"a": 121, "b": 3}Got output: 363=========================== Calling Function ===Calling function: add with args: {"a": 363, "b": 42}Got output: 405========================STARTING TURN 2---------------The result of (121 * 3) + 42 is 405.
```

```
response = agent.stream\_chat("What is (121 \* 3) + 42?")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: add with args: {"a":363,"b":42}Got output: 405========================STARTING TURN 2---------------
```
Async mode[](#async-mode "Permalink to this heading")
------------------------------------------------------


```
import nest\_asyncionest\_asyncio.apply()
```

```
response = await agent.achat("What is (121 \* 3) + 42?")print(str(response))
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: add with args: {"a":363,"b":42}Got output: 405========================STARTING TURN 2---------------The result of (121 * 3) + 42 is 405.
```

```
response = await agent.astream\_chat("What is (121 \* 3) + 42?")response\_gen = response.response\_genasync for token in response.async\_response\_gen():    print(token, end="")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: multiply with args: {"a": 121, "b": 3}Got output: 363=========================== Calling Function ===Calling function: add with args: {"a": 363, "b": 42}Got output: 405========================STARTING TURN 2---------------The result of (121 * 3) + 42 is 405.
```
Example from OpenAI docs[](#example-from-openai-docs "Permalink to this heading")
----------------------------------------------------------------------------------

Here’s an example straight from the OpenAI [docs](https://platform.openai.com/docs/guides/function-calling/parallel-function-calling) on Parallel function calling. (Their example gets this done in 76 lines of code, whereas with the `llama\_index` library you can get that down to about 18 lines.)


```
import json# Example dummy function hard coded to return the same weather# In production, this could be your backend API or an external APIdef get\_current\_weather(location, unit="fahrenheit"): """Get the current weather in a given location"""    if "tokyo" in location.lower():        return json.dumps(            {"location": location, "temperature": "10", "unit": "celsius"}        )    elif "san francisco" in location.lower():        return json.dumps(            {"location": location, "temperature": "72", "unit": "fahrenheit"}        )    else:        return json.dumps(            {"location": location, "temperature": "22", "unit": "celsius"}        )weather\_tool = FunctionTool.from\_defaults(fn=get\_current\_weather)
```

```
llm = OpenAI(model="gpt-3.5-turbo-1106")agent = OpenAIAgent.from\_tools([weather\_tool], llm=llm, verbose=True)response = agent.chat(    "What's the weather like in San Francisco, Tokyo, and Paris?")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: get_current_weather with args: {"location": "San Francisco", "unit": "fahrenheit"}Got output: {"location": "San Francisco", "temperature": "72", "unit": "fahrenheit"}=========================== Calling Function ===Calling function: get_current_weather with args: {"location": "Tokyo", "unit": "fahrenheit"}Got output: {"location": "Tokyo", "temperature": "10", "unit": "celsius"}=========================== Calling Function ===Calling function: get_current_weather with args: {"location": "Paris", "unit": "fahrenheit"}Got output: {"location": "Paris", "temperature": "22", "unit": "celsius"}========================STARTING TURN 2---------------
```
All of the above function calls that the Agent has done above were in a single turn of dialogue between the `Assistant` and the `User`. What’s interesting is that an older version of GPT-3.5 is not quite advanced enough compared to is successor — it will do the above task in 3 separate turns. For the sake of demonstration, here it is below.


```
llm = OpenAI(model="gpt-3.5-turbo-0613")agent = OpenAIAgent.from\_tools([weather\_tool], llm=llm, verbose=True)response = agent.chat(    "What's the weather like in San Francisco, Tokyo, and Paris?")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: get_current_weather with args: {  "location": "San Francisco"}Got output: {"location": "San Francisco", "temperature": "72", "unit": "fahrenheit"}========================STARTING TURN 2---------------=== Calling Function ===Calling function: get_current_weather with args: {  "location": "Tokyo"}Got output: {"location": "Tokyo", "temperature": "10", "unit": "celsius"}========================STARTING TURN 3---------------=== Calling Function ===Calling function: get_current_weather with args: {  "location": "Paris"}Got output: {"location": "Paris", "temperature": "22", "unit": "celsius"}========================STARTING TURN 4---------------
```
Conclusion[](#conclusion "Permalink to this heading")
------------------------------------------------------

And so, as you can see the `llama\_index` library can handle multiple function calls (as well as a single function call) within a single turn of dialogue between the user and the OpenAI agent!

