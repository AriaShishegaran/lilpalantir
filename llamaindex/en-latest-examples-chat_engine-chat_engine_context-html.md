[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/chat_engine/chat_engine_context.ipynb)

Chat Engine - Context Mode[](#chat-engine-context-mode "Permalink to this heading")
====================================================================================

ContextChatEngine is a simple chat mode built on top of a retriever over your data.

For each chat interaction:

* first retrieve text from the index using the user message
* set the retrieved text as context in the system prompt
* return an answer to the user message

This approach is simple, and works for questions directly related to the knowledge base and general interactions.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Get started in 5 lines of code[](#get-started-in-5-lines-of-code "Permalink to this heading")
----------------------------------------------------------------------------------------------

Load data and build index


```
import openaiimport osos.environ["OPENAI\_API\_KEY"] = "API\_KEY\_HERE"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdata = SimpleDirectoryReader(input\_dir="./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data)
```
Configure chat engine

Since the context retrieved can take up a large amount of the available LLM context, let’s ensure we configure a smaller limit to the chat history!


```
from llama\_index.memory import ChatMemoryBuffermemory = ChatMemoryBuffer.from\_defaults(token\_limit=1500)chat\_engine = index.as\_chat\_engine(    chat\_mode="context",    memory=memory,    system\_prompt=(        "You are a chatbot, able to have normal interactions, as well as talk"        " about an essay discussing Paul Grahams life."    ),)
```
Chat with your data


```
response = chat\_engine.chat("Hello!")
```

```
print(response)
```

```
Hello! How can I assist you today?
```
Ask a follow up question


```
response = chat\_engine.chat("What did Paul Graham do growing up?")
```

```
print(response)
```

```
Growing up, Paul Graham had a keen interest in writing and programming. He spent a lot of time writing short stories, although he admits that they weren't particularly good. In terms of programming, he started working with computers in 9th grade when he had access to an IBM 1401 computer at his school. He learned an early version of Fortran and experimented with writing programs on punch cards. However, he found it challenging to figure out what to do with the computer since he didn't have much data to work with. It wasn't until microcomputers became available that he truly delved into programming, starting with a kit-built microcomputer called the Heathkit. Eventually, he convinced his father to buy a TRS-80, which allowed him to write simple games, create a word processor, and explore programming further.
```

```
response = chat\_engine.chat("Can you tell me more?")
```

```
print(response)
```

```
Certainly! As Paul Graham continued to explore programming, he became fascinated with the possibilities it offered. He enjoyed the process of creating something out of nothing and the logical thinking required in programming. During his high school years, he also developed an interest in painting and considered pursuing it as a career.After high school, Paul Graham attended Cornell University, where he studied philosophy. However, he found himself spending more time programming than studying philosophy. He even started a company called Viaweb with some friends, which aimed to create an online store builder. Viaweb eventually became successful and was acquired by Yahoo in 1998.After the acquisition, Paul Graham moved to California and became a millionaire. However, he soon realized that he was burnt out from the stress of running Viaweb. He decided to leave Yahoo and pursue his passion for painting. He enrolled in the Accademia di Belle Arti in Florence, Italy, to study painting.During his time in Florence, Paul Graham immersed himself in the world of art and painting. He experimented with different techniques and styles, particularly focusing on still life paintings. He found joy in closely observing everyday objects and capturing their details on canvas.After a year in Florence, Paul Graham returned to the United States and worked at a software company called Interleaf. Although he was not particularly enthusiastic about the job, it provided him with a steady income and allowed him to save money to pursue his dream of attending the Rhode Island School of Design (RISD) to further his studies in painting.Overall, Paul Graham's journey from programming to painting reflects his curiosity and willingness to explore different passions. He has found success in both fields and continues to share his insights and experiences through his writings and lectures.
```
Reset conversation state


```
chat\_engine.reset()
```

```
response = chat\_engine.chat("Hello! What do you know?")
```

```
print(response)
```

```
Hi there! I know a lot about Paul Graham's life. He is an entrepreneur, programmer, and investor who is best known for co-founding the venture capital firm Y Combinator. He is also the author of several essays on technology and startups, including the influential essay "Hackers and Painters". He has had a long and successful career in the tech industry, and his experiences have shaped his views on entrepreneurship and technology.
```
Streaming Support[](#streaming-support "Permalink to this heading")
--------------------------------------------------------------------


```
from llama\_index import (    ServiceContext,    VectorStoreIndex,    SimpleDirectoryReader,    set\_global\_service\_context,)from llama\_index.llms import OpenAIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0))set\_global\_service\_context(service\_context)data = SimpleDirectoryReader(input\_dir="./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data)
```

```
chat\_engine = index.as\_chat\_engine(chat\_mode="context")
```

```
response = chat\_engine.stream\_chat("What did Paul Graham do after YC?")for token in response.response\_gen:    print(token, end="")
```

```
After stepping down from his role at Y Combinator (YC), Paul Graham focused on pursuing different interests. Initially, he decided to dedicate his time to painting and see how good he could become with focused practice. He spent most of 2014 painting, but eventually ran out of steam and stopped.Following his break from painting, Graham returned to writing essays and also resumed working on Lisp, a programming language. He delved into the core of Lisp, which involves writing an interpreter in the language itself. Graham continued to write essays and work on Lisp in the years following his departure from YC.
```
