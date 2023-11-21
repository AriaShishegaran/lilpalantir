Chat Engine[](#chat-engine "Permalink to this heading")
========================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Chat engine is a high-level interface for having a conversation with your data(multiple back-and-forth instead of a single question & answer).Think ChatGPT, but augmented with your knowledge base.

Conceptually, it is a **stateful** analogy of a [Query Engine](../query_engine/root.html).By keeping track of the conversation history, it can answer questions with past context in mind.

Tip

If you want to ask standalone question over your data (i.e. without keeping track of conversation history), use [Query Engine](../query_engine/root.html) instead.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
chat\_engine = index.as\_chat\_engine()response = chat\_engine.chat("Tell me a joke.")
```
To stream response:


```
chat\_engine = index.as\_chat\_engine()streaming\_response = chat\_engine.stream\_chat("Tell me a joke.")for token in streaming\_response.response\_gen:    print(token, end="")
```
* [Usage Pattern](usage_pattern.html)
	+ [Get Started](usage_pattern.html#get-started)
	+ [Configuring a Chat Engine](usage_pattern.html#configuring-a-chat-engine)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

Below you can find corresponding tutorials to see the available chat engines in action.

* [Module Guides](modules.html)
	+ [ReAct Chat Engine](../../../examples/chat_engine/chat_engine_react.html)
	+ [OpenAI Chat Engine](../../../examples/chat_engine/chat_engine_openai.html)
	+ [Context Chat Engine](../../../examples/chat_engine/chat_engine_context.html)
	+ [Condense Question Chat Engine](../../../examples/chat_engine/chat_engine_condense_question.html)
	+ [Simple Chat Engine](../../../examples/chat_engine/chat_engine_repl.html)
