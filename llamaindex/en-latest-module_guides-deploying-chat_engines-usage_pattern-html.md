Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Build a chat engine from index:


```
chat\_engine = index.as\_chat\_engine()
```
Tip

To learn how to build an index, see [Indexing](../../indexing/indexing.html)

Have a conversation with your data:


```
response = chat\_engine.chat("Tell me a joke.")
```
Reset chat history to start a new conversation:


```
chat\_engine.reset()
```
Enter an interactive chat REPL:


```
chat\_engine.chat\_repl()
```
Configuring a Chat Engine[](#configuring-a-chat-engine "Permalink to this heading")
------------------------------------------------------------------------------------

Configuring a chat engine is very similar to configuring a query engine.

### High-Level API[](#high-level-api "Permalink to this heading")

You can directly build and configure a chat engine from an index in 1 line of code:


```
chat\_engine = index.as\_chat\_engine(chat\_mode="condense\_question", verbose=True)
```

> Note: you can access different chat engines by specifying the `chat\_mode` as a kwarg. `condense\_question` corresponds to `CondenseQuestionChatEngine`, `react` corresponds to `ReActChatEngine`, `context` corresponds to a `ContextChatEngine`.
> 
> 


> Note: While the high-level API optimizes for ease-of-use, it does *NOT* expose full range of configurability.
> 
> 

#### Available Chat Modes[](#available-chat-modes "Permalink to this heading")

* `best` - Turn the query engine into a tool, for use with a `ReAct` data agent or an `OpenAI` data agent, depending on what your LLM supports. `OpenAI` data agents require `gpt-3.5-turbo` or `gpt-4` as they use the function calling API from OpenAI.
* `context` - Retrieve nodes from the index using every user message. The retrieved text is inserted into the system prompt, so that the chat engine can either respond naturally or use the context from the query engine.
* `condense\_question` - Look at the chat history and re-write the user message to be a query for the index. Return the response after reading the response from the query engine.
* `simple` - A simple chat with the LLM directly, no query engine involved.
* `react` - Same as `best`, but forces a `ReAct` data agent.
* `openai` - Same as `best`, but forces an `OpenAI` data agent.
### Low-Level Composition API[](#low-level-composition-api "Permalink to this heading")

You can use the low-level composition API if you need more granular control.Concretely speaking, you would explicitly construct `ChatEngine` object instead of calling `index.as\_chat\_engine(...)`.


> Note: You may need to look at API references or example notebooks.
> 
> 

Here’s an example where we configure the following:

* configure the condense question prompt,
* initialize the conversation with some existing history,
* print verbose debug message.


```
from llama\_index.prompts import PromptTemplatefrom llama\_index.llms import ChatMessage, MessageRolefrom llama\_index.chat\_engine.condense\_question import (    CondenseQuestionChatEngine,)custom\_prompt = PromptTemplate( """\Given a conversation (between Human and Assistant) and a follow up message from Human, \rewrite the message to be a standalone question that captures all relevant context \from the conversation.<Chat History>{chat\_history}<Follow Up Message>{question}<Standalone question>""")# list of `ChatMessage` objectscustom\_chat\_history = [    ChatMessage(        role=MessageRole.USER,        content="Hello assistant, we are having a insightful discussion about Paul Graham today.",    ),    ChatMessage(role=MessageRole.ASSISTANT, content="Okay, sounds good."),]query\_engine = index.as\_query\_engine()chat\_engine = CondenseQuestionChatEngine.from\_defaults(    query\_engine=query\_engine,    condense\_question\_prompt=custom\_prompt,    chat\_history=custom\_chat\_history,    verbose=True,)
```
### Streaming[](#streaming "Permalink to this heading")

To enable streaming, you simply need to call the `stream\_chat` endpoint instead of the `chat` endpoint.

Warning

This somewhat inconsistent with query engine (where you pass in a `streaming=True` flag). We are working on making the behavior more consistent!


```
chat\_engine = index.as\_chat\_engine()streaming\_response = chat\_engine.stream\_chat("Tell me a joke.")for token in streaming\_response.response\_gen:    print(token, end="")
```
See an [end-to-end tutorial](../../../examples/customization/streaming/chat_engine_condense_question_stream_response.html)

