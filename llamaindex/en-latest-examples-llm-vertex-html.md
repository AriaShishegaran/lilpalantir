Getting Started[](#getting-started "Permalink to this heading")
================================================================

Installing Vertex AI[](#installing-vertex-ai "Permalink to this heading")
--------------------------------------------------------------------------

To Install Vertex AI you need to follow the following steps

* Install Vertex Cloud SDK (https://googleapis.dev/python/aiplatform/latest/index.html)
* Setup your Default Project , credentials , region
Basic Usage[](#basic-usage "Permalink to this heading")
--------------------------------------------------------

a Basic call to the text-bison model


```
from llama\_index.llms.vertex import Vertexfrom llama\_index.llms.base import ChatMessage, MessageRole, CompletionResponsellm = Vertex(model="text-bison", temperature=0, additional\_kwargs={})llm.complete("Hello this is a sample text").text
```

```
' ```\nHello this is a sample text\n```'
```
Async Usage[](#async-usage "Permalink to this heading")
--------------------------------------------------------

### Async[](#async "Permalink to this heading")


```
(await llm.acomplete("hello")).text
```

```
' Hello! How can I help you?'
```
Streaming Usage[](#streaming-usage "Permalink to this heading")
================================================================

Streaming[](#streaming "Permalink to this heading")
----------------------------------------------------


```
list(llm.stream\_complete("hello"))[-1].text
```

```
' Hello! How can I help you?'
```
Chat Usage[](#chat-usage "Permalink to this heading")
======================================================

chat generation[](#chat-generation "Permalink to this heading")
----------------------------------------------------------------


```
chat = Vertex(model="chat-bison")messages = [    ChatMessage(role=MessageRole.SYSTEM, content="Reply everything in french"),    ChatMessage(role=MessageRole.USER, content="Hello"),]
```

```
chat.chat(messages=messages).message.content
```

```
' Bonjour! Comment vas-tu?'
```
Async Chat[](#async-chat "Permalink to this heading")
======================================================

Asynchronous chat response[](#asynchronous-chat-response "Permalink to this heading")
--------------------------------------------------------------------------------------


```
(await chat.achat(messages=messages)).message.content
```

```
' Bonjour! Comment vas-tu?'
```
Streaming Chat[](#streaming-chat "Permalink to this heading")
==============================================================

streaming chat response[](#streaming-chat-response "Permalink to this heading")
--------------------------------------------------------------------------------


```
list(chat.stream\_chat(messages=messages))[-1].message.content
```

```
' Bonjour! Comment vas-tu?'
```
