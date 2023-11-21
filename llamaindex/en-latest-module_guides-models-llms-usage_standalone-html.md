Using LLMs as standalone modules[](#using-llms-as-standalone-modules "Permalink to this heading")
==================================================================================================

You can use our LLM modules on their own.

Text Completion Example[](#text-completion-example "Permalink to this heading")
--------------------------------------------------------------------------------


```
from llama\_index.llms import OpenAI# non-streamingresp = OpenAI().complete("Paul Graham is ")print(resp)# using streaming endpointfrom llama\_index.llms import OpenAIllm = OpenAI()resp = llm.stream\_complete("Paul Graham is ")for delta in resp:    print(delta, end="")
```
Chat Example[](#chat-example "Permalink to this heading")
----------------------------------------------------------


```
from llama\_index.llms import ChatMessage, OpenAImessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = OpenAI().chat(messages)print(resp)
```
Check out our [modules section](modules.html) for usage guides for each LLM.

