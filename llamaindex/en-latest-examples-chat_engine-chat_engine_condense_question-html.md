[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/chat_engine/chat_engine_condense_question.ipynb)

Chat Engine - Condense Question Mode[](#chat-engine-condense-question-mode "Permalink to this heading")
========================================================================================================

Condense question is a simple chat mode built on top of a query engine over your data.

For each chat interaction:

* first generate a standalone question from conversation context and last message, then
* query the query engine with the condensed question for a response.

This approach is simple, and works for questions directly related to the knowledge base.Since it *always* queries the knowledge base, it can have difficulty answering meta questions like “what did I ask you before?”

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
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdata = SimpleDirectoryReader(input\_dir="./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data)
```
Configure chat engine


```
chat\_engine = index.as\_chat\_engine(chat\_mode="condense\_question", verbose=True)
```
Chat with your data


```
response = chat\_engine.chat("What did Paul Graham do after YC?")
```

```
Querying with: What was the next step in Paul Graham's career after his involvement with Y Combinator?
```

```
print(response)
```

```
Paul Graham's next step in his career after his involvement with Y Combinator was to take up painting. He spent most of the rest of 2014 painting and then in March 2015 he started working on Lisp again.
```
Ask a follow up question


```
response = chat\_engine.chat("What about after that?")
```

```
Querying with: What did Paul Graham do after he started working on Lisp again in March 2015?
```

```
print(response)
```

```
Paul Graham spent the rest of 2015 writing essays and working on his new dialect of Lisp, which he called Arc. He also looked for an apartment to buy and started planning a second still life painting from the same objects.
```

```
response = chat\_engine.chat("Can you tell me more?")
```

```
Querying with: What did Paul Graham do after he started working on Lisp again in March 2015?
```

```
print(response)
```

```
Paul Graham spent the rest of 2015 writing essays and working on his new dialect of Lisp, which he called Arc. He also looked for an apartment to buy and started planning for a second still life painting.
```
Reset conversation state


```
chat\_engine.reset()
```

```
response = chat\_engine.chat("What about after that?")
```

```
Querying with: What happens after the current situation?
```

```
print(response)
```

```
After the current situation, the narrator resumes painting and experimenting with a new kind of still life. He also resumes his old life in New York, now that he is rich. He is able to take taxis and eat in restaurants, which is exciting for a while. He also starts to make connections with other people who are trying to paint in New York.
```
Streaming Support[](#streaming-support "Permalink to this heading")
--------------------------------------------------------------------


```
from llama\_index import ServiceContext, VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.llms import OpenAIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0))data = SimpleDirectoryReader(input\_dir="../data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data, service\_context=service\_context)
```

```
chat\_engine = index.as\_chat\_engine(chat\_mode="condense\_question", verbose=True)
```

```
response = chat\_engine.stream\_chat("What did Paul Graham do after YC?")for token in response.response\_gen:    print(token, end="")
```

```
Querying with: What did Paul Graham do after leaving YC?After leaving YC, Paul Graham started painting and focused on improving his skills in that area. He then started writing essays again and began working on Lisp.
```
