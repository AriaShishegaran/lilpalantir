Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Estimating LLM and Embedding Token Counts[](#estimating-llm-and-embedding-token-counts "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------

In order to measure LLM and Embedding token counts, you’ll need to

1. Setup `MockLLM` and `MockEmbedding` objects


```
from llama\_index.llms import MockLLMfrom llama\_index import MockEmbeddingllm = MockLLM(max\_tokens=256)embed\_model = MockEmbedding(embed\_dim=1536)
```
2. Setup the `TokenCountingCallback` handler


```
import tiktokenfrom llama\_index.callbacks import CallbackManager, TokenCountingHandlertoken\_counter = TokenCountingHandler(    tokenizer=tiktoken.encoding\_for\_model("gpt-3.5-turbo").encode)callback\_manager = CallbackManager([token\_counter])
```
3. Add them to the global `ServiceContext`


```
from llama\_index import ServiceContext, set\_global\_service\_contextset\_global\_service\_context(    ServiceContext.from\_defaults(        llm=llm, embed\_model=embed\_model, callback\_manager=callback\_manager    ))
```
4. Construct an Index


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader(    "./docs/examples/data/paul\_graham").load\_data()index = VectorStoreIndex.from\_documents(documents)
```
5. Measure the counts!


```
print(    "Embedding Tokens: ",    token\_counter.total\_embedding\_token\_count,    "\n",    "LLM Prompt Tokens: ",    token\_counter.prompt\_llm\_token\_count,    "\n",    "LLM Completion Tokens: ",    token\_counter.completion\_llm\_token\_count,    "\n",    "Total LLM Token Count: ",    token\_counter.total\_llm\_token\_count,    "\n",)# reset countstoken\_counter.reset\_counts()
```
6. Run a query, mesaure again


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("query")print(    "Embedding Tokens: ",    token\_counter.total\_embedding\_token\_count,    "\n",    "LLM Prompt Tokens: ",    token\_counter.prompt\_llm\_token\_count,    "\n",    "LLM Completion Tokens: ",    token\_counter.completion\_llm\_token\_count,    "\n",    "Total LLM Token Count: ",    token\_counter.total\_llm\_token\_count,    "\n",)
```
