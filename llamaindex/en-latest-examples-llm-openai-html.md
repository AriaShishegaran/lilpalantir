[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/openai.ipynb)

OpenAI[](#openai "Permalink to this heading")
==============================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Basic Usage[](#basic-usage "Permalink to this heading")
--------------------------------------------------------

### Call `complete` with a prompt[](#call-complete-with-a-prompt "Permalink to this heading")


```
from llama\_index.llms import OpenAIresp = OpenAI().complete("Paul Graham is ")
```

```
print(resp)
```

```
a computer scientist, entrepreneur, and venture capitalist. He is best known as the co-founder of Y Combinator, a startup accelerator and seed capital firm. Graham has also written several influential essays on startups and entrepreneurship, which have gained a large following in the tech community. He has been involved in the founding and funding of numerous successful startups, including Dropbox, Airbnb, and Reddit. Graham is considered a thought leader in the startup world and has been recognized for his contributions to the tech industry.
```
### Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")


```
from llama\_index.llms import ChatMessage, OpenAImessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = OpenAI().chat(messages)
```

```
print(resp)
```

```
assistant: Ahoy there, matey! The name be Captain Crimsonbeard, the most colorful pirate to sail the seven seas!
```
Streaming[](#streaming "Permalink to this heading")
----------------------------------------------------

Using `stream\_complete` endpoint


```
from llama\_index.llms import OpenAIllm = OpenAI()resp = llm.stream\_complete("Paul Graham is ")
```

```
for r in resp:    print(r.delta, end="")
```

```
a computer scientist, entrepreneur, and venture capitalist. He is best known as the co-founder of the startup accelerator Y Combinator. Graham has also written several influential essays on startups and entrepreneurship, which have gained a large following in the tech community. He has been involved in the founding and funding of numerous successful startups, including Reddit, Dropbox, and Airbnb. Graham is known for his insightful and often controversial opinions on various topics, including education, inequality, and the future of technology.
```
Using `stream\_chat` endpoint


```
from llama\_index.llms import OpenAI, ChatMessagellm = OpenAI()messages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = llm.stream\_chat(messages)
```

```
for r in resp:    print(r.delta, end="")
```

```
Ahoy there, matey! The name be Captain Crimsonbeard, the most colorful pirate to sail the seven seas!
```
Configure Model[](#configure-model "Permalink to this heading")
----------------------------------------------------------------


```
from llama\_index.llms import OpenAIllm = OpenAI(model="text-davinci-003")
```

```
resp = llm.complete("Paul Graham is ")
```

```
print(resp)
```

```
Paul Graham is an entrepreneur, venture capitalist, and computer scientist. He is best known for his work in the startup world, having co-founded the accelerator Y Combinator and investing in hundreds of startups. He is also a prolific writer, having authored several books on topics such as startups, programming, and technology.
```

```
messages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = llm.chat(messages)
```

```
print(resp)
```

```
assistant: My name is Captain Jack Sparrow.
```
Function Calling[](#function-calling "Permalink to this heading")
------------------------------------------------------------------


```
from pydantic import BaseModelfrom llama\_index.llms.openai\_utils import to\_openai\_toolclass Song(BaseModel): """A song with name and artist"""    name: str    artist: strsong\_fn = to\_openai\_tool(Song)
```

```
from llama\_index.llms import OpenAIresponse = OpenAI().complete("Generate a song", tools=[song\_fn])tool\_calls = response.additional\_kwargs["tool\_calls"]print(tool\_calls)
```

```
[{'id': 'call_cW8rD7s9cm48YSvY3j93hjqC', 'function': {'arguments': '{\n  "name": "Sunshine",\n  "artist": "John Smith"\n}', 'name': 'Song'}, 'type': 'function'}]
```
Async[](#async "Permalink to this heading")
--------------------------------------------


```
from llama\_index.llms import OpenAIllm = OpenAI(model="text-davinci-003")
```

```
resp = await llm.acomplete("Paul Graham is ")
```

```
print(resp)
```

```
Paul Graham is an entrepreneur, venture capitalist, and computer scientist. He is best known for his work as a co-founder of the Y Combinator startup accelerator, and for his essays on technology and business. He is also the author of several books, including Hackers & Painters and On Lisp.
```

```
resp = await llm.astream\_complete("Paul Graham is ")
```

```
async for delta in resp:    print(delta.delta, end="")
```

```
Paul Graham is an entrepreneur, venture capitalist, and computer scientist. He is best known for his work in the startup world, having co-founded the accelerator Y Combinator and investing in many successful startups such as Airbnb, Dropbox, and Stripe. He is also a prolific writer, having authored several books on topics such as startups, programming, and technology.
```
Set API Key at a per-instance level[](#set-api-key-at-a-per-instance-level "Permalink to this heading")
--------------------------------------------------------------------------------------------------------

If desired, you can have separate LLM instances use separate API keys.


```
from llama\_index.llms import OpenAIllm = OpenAI(model="text-davinci-003", api\_key="BAD\_KEY")resp = OpenAI().complete("Paul Graham is ")print(resp)
```

```
a computer scientist, entrepreneur, and venture capitalist. He is best known as the co-founder of the startup accelerator Y Combinator. Graham has also written several influential essays on startups and entrepreneurship, which have gained a wide following in the tech industry. He has been involved in the founding and funding of numerous successful startups, including Reddit, Dropbox, and Airbnb. Graham is known for his insightful and often controversial opinions on various topics, including education, inequality, and the future of technology.
```
