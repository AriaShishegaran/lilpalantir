[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/chat_engine/chat_engine_openai.ipynb)

Chat Engine - OpenAI Agent Mode[](#chat-engine-openai-agent-mode "Permalink to this heading")
==============================================================================================

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
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import OpenAI# Necessary to use the latest OpenAI models that support function calling APIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo-0613"))data = SimpleDirectoryReader(input\_dir="../data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(data, service\_context=service\_context)
```
Configure chat engine


```
chat\_engine = index.as\_chat\_engine(chat\_mode="openai", verbose=True)
```
Chat with your data


```
response = chat\_engine.chat("Hi")print(response)
```

```
Hello! How can I assist you today?
```

```
response = chat\_engine.chat(    "Use the tool to answer: Who did Paul Graham hand over YC to?")print(response)
```

```
=== Calling Function ===Calling function: query_engine_tool with args: {  "input": "Who did Paul Graham hand over YC to?"}Got output: Paul Graham handed over YC to Sam Altman.========================Paul Graham handed over Y Combinator (YC) to Sam Altman.
```
### Force chat engine to query the index[](#force-chat-engine-to-query-the-index "Permalink to this heading")

NOTE: this is a feature unique to the “openai” chat mode (which uses the `OpenAIAgent` under the hood).


```
response = chat\_engine.chat(    "What did Paul Graham do growing up?", function\_call="query\_engine\_tool")
```

```
=== Calling Function ===Calling function: query_engine_tool with args: {  "input": "What did Paul Graham do growing up?"}Got output: Growing up, Paul Graham worked on writing and programming. He wrote short stories and tried programming on the IBM 1401 computer in his school's basement. He later got a microcomputer and started programming games and a word processor. He initially planned to study philosophy in college but switched to AI. He also started publishing essays online, which became a significant focus for him.========================
```

```
print(response)
```

```
Growing up, Paul Graham had a passion for writing and programming. He wrote short stories and explored programming on the IBM 1401 computer in his school's basement. He later acquired a microcomputer and began programming games and a word processor. While initially intending to study philosophy in college, he ultimately changed his focus to artificial intelligence (AI). Additionally, he started publishing essays online, which became a significant part of his pursuits.
```
