[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/callbacks/TokenCountingHandler.ipynb)

Token Counting Handler[](#token-counting-handler "Permalink to this heading")
==============================================================================

This notebook walks through how to use the TokenCountingHandler and how it can be used to track your prompt, completion, and embedding token usage over time.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import tiktokenfrom llama\_index.llms import Anthropicfrom llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    ServiceContext,    set\_global\_service\_context,)from llama\_index.callbacks import CallbackManager, TokenCountingHandlerimport osos.environ["ANTHROPIC\_API\_KEY"] = "YOUR\_API\_KEY"
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

Here, we setup the callback and the serivce context. We set a global service context so that we don’t have to worry about passing it into indexes and queries.


```
token\_counter = TokenCountingHandler(    tokenizer=tiktoken.encoding\_for\_model("gpt-3.5-turbo").encode)callback\_manager = CallbackManager([token\_counter])llm = Anthropic()service\_context = ServiceContext.from\_defaults(    llm=llm, callback\_manager=callback\_manager, embed\_model="local")# set the global default!set\_global\_service\_context(service\_context)
```

```
/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/tqdm/auto.py:22: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Token Counting[](#token-counting "Permalink to this heading")
--------------------------------------------------------------

The token counter will track embedding, prompt, and completion token usage. The token counts are **cummulative** and are only reset when you choose to do so, with `token\_counter.reset\_counts()`.

### Embedding Token Usage[](#embedding-token-usage "Permalink to this heading")

Now that the service context is setup, let’s track our embedding token usage.

Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
documents = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)
```

```
print(token\_counter.total\_embedding\_token\_count)
```

```
16852
```
That looks right! Before we go any further, lets reset the counts


```
token\_counter.reset\_counts()
```
### LLM + Embedding Token Usage[](#llm-embedding-token-usage "Permalink to this heading")

Next, let’s test a query and see what the counts look like.


```
query\_engine = index.as\_query\_engine(similarity\_top\_k=4)response = query\_engine.query("What did the author do growing up?")
```

```
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...To disable this warning, you can either:	- Avoid using `tokenizers` before the fork if possible	- Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
```

```
print(    "Embedding Tokens: ",    token\_counter.total\_embedding\_token\_count,    "\n",    "LLM Prompt Tokens: ",    token\_counter.prompt\_llm\_token\_count,    "\n",    "LLM Completion Tokens: ",    token\_counter.completion\_llm\_token\_count,    "\n",    "Total LLM Token Count: ",    token\_counter.total\_llm\_token\_count,    "\n",)
```

```
Embedding Tokens:  8  LLM Prompt Tokens:  3527  LLM Completion Tokens:  214  Total LLM Token Count:  3741 
```
### Token Counting + Streaming![](#token-counting-streaming "Permalink to this heading")

The token counting handler also handles token counting during streaming.

Here, token counting will only happen once the stream is completed.


```
token\_counter.reset\_counts()query\_engine = index.as\_query\_engine(similarity\_top\_k=4, streaming=True)response = query\_engine.query("What happened at Interleaf?")# finish the streamfor token in response.response\_gen:    # print(token, end="", flush=True)    continue
```

```
print(    "Embedding Tokens: ",    token\_counter.total\_embedding\_token\_count,    "\n",    "LLM Prompt Tokens: ",    token\_counter.prompt\_llm\_token\_count,    "\n",    "LLM Completion Tokens: ",    token\_counter.completion\_llm\_token\_count,    "\n",    "Total LLM Token Count: ",    token\_counter.total\_llm\_token\_count,    "\n",)
```

```
Embedding Tokens:  6  LLM Prompt Tokens:  3631  LLM Completion Tokens:  214  Total LLM Token Count:  3845 
```
Advanced Usage[](#advanced-usage "Permalink to this heading")
--------------------------------------------------------------

The token counter tracks each token usage event in an object called a `TokenCountingEvent`. This object has the following attributes:

* prompt -> The prompt string sent to the LLM or Embedding model
* prompt\_token\_count -> The token count of the LLM prompt
* completion -> The string completion received from the LLM (not used for embeddings)
* completion\_token\_count -> The token count of the LLM completion (not used for embeddings)
* total\_token\_count -> The total prompt + completion tokens for the event
* event\_id -> A string ID for the event, which aligns with other callback handlers

These events are tracked on the token counter in two lists:

* llm\_token\_counts
* embedding\_token\_counts

Let’s explore what these look like!


```
print("Num LLM token count events: ", len(token\_counter.llm\_token\_counts))print(    "Num Embedding token count events: ",    len(token\_counter.embedding\_token\_counts),)
```

```
Num LLM token count events:  1Num Embedding token count events:  1
```
This makes sense! The previous query embedded the query text, and then made 2 LLM calls (since the top k was 4, and the default chunk size is 1024, two seperate calls need to be made so the LLM can read all the retrieved text).

Next, let’s quickly see what these events look like for a single event.


```
print("prompt: ", token\_counter.llm\_token\_counts[0].prompt[:100], "...\n")print(    "prompt token count: ",    token\_counter.llm\_token\_counts[0].prompt\_token\_count,    "\n",)print(    "completion: ", token\_counter.llm\_token\_counts[0].completion[:100], "...\n")print(    "completion token count: ",    token\_counter.llm\_token\_counts[0].completion\_token\_count,    "\n",)print("total token count", token\_counter.llm\_token\_counts[0].total\_token\_count)
```

```
prompt:  user: Context information is below.---------------------a web app, is common now, but at the time  ...prompt token count:  3631 completion:  assistant:  Based on the context, a few key things happened at Interleaf:- It was a software compa ...completion token count:  199 total token count 3830
```
