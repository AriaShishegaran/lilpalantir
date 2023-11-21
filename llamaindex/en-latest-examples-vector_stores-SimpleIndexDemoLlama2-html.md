[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/SimpleIndexDemoLlama2.ipynb)

Llama2 + VectorStoreIndex[](#llama2-vectorstoreindex "Permalink to this heading")
==================================================================================

This notebook walks through the proper setup to use llama-2 with LlamaIndex. Specifically, we look at using a vector store index.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
### Keys[](#keys "Permalink to this heading")


```
import osos.environ["OPENAI\_API\_KEY"] = "OPENAI\_API\_KEY"os.environ["REPLICATE\_API\_TOKEN"] = "REPLICATE\_API\_TOKEN"# currently needed for notebooksimport openaiopenai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
### Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,)from IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
from llama\_index.llms import Replicatefrom llama\_index import ServiceContext, set\_global\_service\_contextfrom llama\_index.llms.llama\_utils import (    messages\_to\_prompt,    completion\_to\_prompt,)# The replicate endpointLLAMA\_13B\_V2\_CHAT = "a16z-infra/llama13b-v2-chat:df7690f1994d94e96ad9d568eac121aecf50684a0b0963b25a41cc40061269e5"# inject custom system prompt into llama-2def custom\_completion\_to\_prompt(completion: str) -> str:    return completion\_to\_prompt(        completion,        system\_prompt=(            "You are a Q&A assistant. Your goal is to answer questions as "            "accurately as possible is the instructions and context provided."        ),    )llm = Replicate(    model=LLAMA\_13B\_V2\_CHAT,    temperature=0.01,    # override max tokens since it's interpreted    # as context window instead of max tokens    context\_window=4096,    # override completion representation for llama 2    completion\_to\_prompt=custom\_completion\_to\_prompt,    # if using llama 2 for data agents, also override the message representation    messages\_to\_prompt=messages\_to\_prompt,)# set a global service contextctx = ServiceContext.from\_defaults(llm=llm)set\_global\_service\_context(ctx)
```
Download Data


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)
```
Querying[](#querying "Permalink to this heading")
--------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()
```

```
response = query\_engine.query("What did the author do growing up?")display(Markdown(f"<b>{response}</b>"))
```
 **Based on the context information provided, the author’s activities growing up were:**

1. Writing short stories, which were “awful” and lacked a strong plot.
2. Programming on an IBM 1401 computer in 9th grade, using an early version of Fortran.
3. Building a microcomputer with a friend, and writing simple games, a program to predict the height of model rockets, and a word processor.
4. Studying philosophy in college, but finding it boring and switching to AI.
5. Writing essays online, which became a turning point in their career.
### Streaming Support[](#streaming-support "Permalink to this heading")


```
query\_engine = index.as\_query\_engine(streaming=True)response = query\_engine.query("What happened at interleaf?")for token in response.response\_gen:    print(token, end="")
```

```
 Based on the context information provided, it appears that the author worked at Interleaf, a company that made software for creating and managing documents. The author mentions that Interleaf was "on the way down" and that the company's Release Engineering group was large compared to the group that actually wrote the software. It is inferred that Interleaf was experiencing financial difficulties and that the author was nervous about money. However, there is no explicit mention of what specifically happened at Interleaf.
```
