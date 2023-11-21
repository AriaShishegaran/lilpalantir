[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/chat_engine/chat_engine_react.ipynb)

Chat Engine - ReAct Agent Mode[](#chat-engine-react-agent-mode "Permalink to this heading")
============================================================================================

ReAct is an agent based chat mode built on top of a query engine over your data.

For each chat interaction, the agent enter a ReAct loop:

* first decide whether to use the query engine tool and come up with appropriate input
* (optional) use the query engine tool and observe its output
* decide whether to repeat or give final response

This approach is flexible, since it can flexibility choose between querying the knowledge base or not.However, the performance is also more dependent on the quality of the LLM.You might need to do more coercing to make sure it chooses to query the knowledge base at right times, instead of hallucinating an answer.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
### Get started in 5 lines of code[](#get-started-in-5-lines-of-code "Permalink to this heading")

Load data and build index


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import OpenAI, Anthropicservice\_context = ServiceContext.from\_defaults(llm=OpenAI())data = SimpleDirectoryReader(input\_dir="./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data, service\_context=service\_context)
```
Configure chat engine


```
chat\_engine = index.as\_chat\_engine(chat\_mode="react", verbose=True)
```
Chat with your data


```
response = chat\_engine.chat(    "Use the tool to answer what did Paul Graham do in the summer of 1995?")
```

```
Thought: I need to use a tool to help me answer the question.Action: query\_engine\_toolAction Input: {'input': 'What did Paul Graham do in the summer of 1995?'}Observation: In the summer of 1995, Paul Graham worked on building a web application for making web applications. He recruited Dan Giffin, who had worked for Viaweb, and two undergrads who wanted summer jobs, and they got to work trying to build what it's now clear is about twenty companies and several open source projects worth of software. The language for defining applications would of course be a dialect of Lisp.Response: In the summer of 1995, Paul Graham worked on building a web application for making web applications. He recruited Dan Giffin, who had worked for Viaweb, and two undergrads who wanted summer jobs, and they got to work trying to build what it's now clear is about twenty companies and several open source projects worth of software. The language for defining applications would of course be a dialect of Lisp.
```

```
print(response)
```

```
In the summer of 1995, Paul Graham worked on building a web application for making web applications. He recruited Dan Giffin, who had worked for Viaweb, and two undergrads who wanted summer jobs, and they got to work trying to build what it's now clear is about twenty companies and several open source projects worth of software. The language for defining applications would of course be a dialect of Lisp.
```
### Customize LLM[](#customize-llm "Permalink to this heading")

Use Anthropic (“claude-2”)


```
service\_context = ServiceContext.from\_defaults(llm=Anthropic())
```
Configure chat engine


```
chat\_engine = index.as\_chat\_engine(    service\_context=service\_context, chat\_mode="react", verbose=True)
```

```
response = chat\_engine.chat("what did Paul Graham do in the summer of 1995?")
```

```
Thought: I need to use a tool to help me answer the question.Action: query\_engine\_toolAction Input: {'input': 'what did Paul Graham do in the summer of 1995?'}Observation: Based on the context, in the summer of 1995 Paul Graham:- Painted a second still life using the same objects he had used for a previous still life painting.- Looked for an apartment to buy in New York, trying to find a neighborhood similar to Cambridge, MA. - Realized there wasn't really a "Cambridge of New York" after visiting the actual Cambridge.The passage does not mention what Paul Graham did in the summer of 1995 specifically. It talks about painting a second still life at some point and looking for an apartment in New York at some point, but it does not connect those events to the summer of 1995.Response: The passage does not provide enough information to know specifically what Paul Graham did in the summer of 1995. It mentions some activities like painting and looking for an apartment in New York, but does not say these occurred specifically in the summer of 1995.
```

```
print(response)
```

```
The passage does not provide enough information to know specifically what Paul Graham did in the summer of 1995. It mentions some activities like painting and looking for an apartment in New York, but does not say these occurred specifically in the summer of 1995.
```

```
response = chat\_engine.chat("What did I ask you before?")
```

```
Response: You asked me "what did Paul Graham do in the summer of 1995?".
```

```
print(response)
```

```
 You asked me "what did Paul Graham do in the summer of 1995?".
```
Reset chat engine


```
chat\_engine.reset()
```

```
response = chat\_engine.chat("What did I ask you before?")
```

```
Response: I'm afraid I don't have any context about previous questions in our conversation. This seems to be the start of a new conversation between us.
```

```
print(response)
```

```
I'm afraid I don't have any context about previous questions in our conversation. This seems to be the start of a new conversation between us.
```
