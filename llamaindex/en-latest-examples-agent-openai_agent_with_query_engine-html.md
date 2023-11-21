[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent_with_query_engine.ipynb)

OpenAI Agent with Query Engine Tools[](#openai-agent-with-query-engine-tools "Permalink to this heading")
==========================================================================================================

Build Query Engine Tools[](#build-query-engine-tools "Permalink to this heading")
----------------------------------------------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    StorageContext,    load\_index\_from\_storage,)from llama\_index.tools import QueryEngineTool, ToolMetadata
```

```
try:    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/lyft"    )    lyft\_index = load\_index\_from\_storage(storage\_context)    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/uber"    )    uber\_index = load\_index\_from\_storage(storage\_context)    index\_loaded = Trueexcept:    index\_loaded = False
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
if not index\_loaded:    # load data    lyft\_docs = SimpleDirectoryReader(        input\_files=["./data/10k/lyft\_2021.pdf"]    ).load\_data()    uber\_docs = SimpleDirectoryReader(        input\_files=["./data/10k/uber\_2021.pdf"]    ).load\_data()    # build index    lyft\_index = VectorStoreIndex.from\_documents(lyft\_docs)    uber\_index = VectorStoreIndex.from\_documents(uber\_docs)    # persist index    lyft\_index.storage\_context.persist(persist\_dir="./storage/lyft")    uber\_index.storage\_context.persist(persist\_dir="./storage/uber")
```

```
lyft\_engine = lyft\_index.as\_query\_engine(similarity\_top\_k=3)uber\_engine = uber\_index.as\_query\_engine(similarity\_top\_k=3)
```

```
query\_engine\_tools = [    QueryEngineTool(        query\_engine=lyft\_engine,        metadata=ToolMetadata(            name="lyft\_10k",            description=(                "Provides information about Lyft financials for year 2021. "                "Use a detailed plain text question as input to the tool."            ),        ),    ),    QueryEngineTool(        query\_engine=uber\_engine,        metadata=ToolMetadata(            name="uber\_10k",            description=(                "Provides information about Uber financials for year 2021. "                "Use a detailed plain text question as input to the tool."            ),        ),    ),]
```
Setup OpenAI Agent[](#setup-openai-agent "Permalink to this heading")
----------------------------------------------------------------------


```
from llama\_index.agent import OpenAIAgent
```

```
agent = OpenAIAgent.from\_tools(query\_engine\_tools, verbose=True)
```
Let’s Try It Out![](#let-s-try-it-out "Permalink to this heading")
-------------------------------------------------------------------


```
agent.chat\_repl()
```

```
===== Entering Chat REPL =====Type "exit" to exit.=== Calling Function ===Calling function: lyft_10k with args: {  "input": "What was Lyft's revenue growth in 2021?"}Got output: Lyft's revenue growth in 2021 was 36%.=========================== Calling Function ===Calling function: uber_10k with args: {  "input": "What was Uber's revenue growth in 2021?"}Got output: Uber's revenue growth in 2021 was 57%.========================Assistant: Lyft's revenue growth in 2021 was 36%, while Uber's revenue growth in 2021 was 57%.
```
