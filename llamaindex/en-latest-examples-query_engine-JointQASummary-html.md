[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/JointQASummary.ipynb)

Joint QA Summary Query Engine[](#joint-qa-summary-query-engine "Permalink to this heading")
============================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index.composability.joint\_qa\_summary import (    QASummaryQueryEngineBuilder,)from llama\_index import SimpleDirectoryReader, ServiceContext, LLMPredictorfrom llama\_index.response.notebook\_utils import display\_responsefrom llama\_index.llms import OpenAI
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------


```
reader = SimpleDirectoryReader("./data/paul\_graham/")documents = reader.load\_data()
```

```
gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4, chunk\_size=1024)chatgpt = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context\_chatgpt = ServiceContext.from\_defaults(    llm=chatgpt, chunk\_size=1024)
```

```
WARNING:llama_index.llm_predictor.base:Unknown max input size for gpt-3.5-turbo, using defaults.Unknown max input size for gpt-3.5-turbo, using defaults.
```

```
# NOTE: can also specify an existing docstore, service context, summary text, qa\_text, etc.query\_engine\_builder = QASummaryQueryEngineBuilder(    service\_context=service\_context\_gpt4)query\_engine = query\_engine\_builder.build\_from\_documents(documents)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 20729 tokens> [build_index_from_nodes] Total embedding token usage: 20729 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens
```

```
response = query\_engine.query(    "Can you give me a summary of the author's life?",)
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 1 because: This choice is relevant because it is specifically for summarization queries, which matches the request for a summary of the author's life..Selecting query engine 1 because: This choice is relevant because it is specifically for summarization queries, which matches the request for a summary of the author's life..INFO:llama_index.indices.common_tree.base:> Building index from nodes: 6 chunks> Building index from nodes: 6 chunksINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1012 tokens> [get_response] Total LLM token usage: 1012 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 23485 tokens> [get_response] Total LLM token usage: 23485 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
response = query\_engine.query(    "What did the author do growing up?",)
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 0 because: This choice is relevant because it involves retrieving specific context from documents, which is needed to answer the question about the author's activities growing up..Selecting query engine 0 because: This choice is relevant because it involves retrieving specific context from documents, which is needed to answer the question about the author's activities growing up..INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1893 tokens> [get_response] Total LLM token usage: 1893 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
response = query\_engine.query(    "What did the author do during his time in art school?",)
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 0 because: This choice is relevant because it involves retrieving specific context from documents, which is needed to answer the question about the author's activities in art school..Selecting query engine 0 because: This choice is relevant because it involves retrieving specific context from documents, which is needed to answer the question about the author's activities in art school..INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 12 tokens> [retrieve] Total embedding token usage: 12 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1883 tokens> [get_response] Total LLM token usage: 1883 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
