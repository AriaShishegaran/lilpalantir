[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/custom_query_engine.ipynb)

Defining a Custom Query Engine[](#defining-a-custom-query-engine "Permalink to this heading")
==============================================================================================

You can (and should) define your custom query engines in order to plug into your downstream LlamaIndex workflows, whether you’re building RAG, agents, or other applications.

We provide a `CustomQueryEngine` that makes it easy to define your own queries.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We first load some sample data and index it.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,)
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data//paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)retriever = index.as\_retriever()
```
Building a Custom Query Engine[](#building-a-custom-query-engine "Permalink to this heading")
----------------------------------------------------------------------------------------------

We build a custom query engine that simulates a RAG pipeline. First perform retrieval, and then synthesis.

To define a `CustomQueryEngine`, you just have to define some initialization parameters as attributes and implement the `custom\_query` function.

By default, the `custom\_query` can return a `Response` object (which the response synthesizer returns), but it can also just return a string. These are options 1 and 2 respectively.


```
from llama\_index.query\_engine import CustomQueryEnginefrom llama\_index.retrievers import BaseRetrieverfrom llama\_index.response\_synthesizers import (    get\_response\_synthesizer,    BaseSynthesizer,)
```
### Option 1 (`RAGQueryEngine`)[](#option-1-ragqueryengine "Permalink to this heading")


```
class RAGQueryEngine(CustomQueryEngine): """RAG Query Engine."""    retriever: BaseRetriever    response\_synthesizer: BaseSynthesizer    def custom\_query(self, query\_str: str):        nodes = self.retriever.retrieve(query\_str)        response\_obj = self.response\_synthesizer.synthesize(query\_str, nodes)        return response\_obj
```
### Option 2 (`RAGStringQueryEngine`)[](#option-2-ragstringqueryengine "Permalink to this heading")


```
# Option 2: return a string (we use a raw LLM call for illustration)from llama\_index.llms import OpenAIfrom llama\_index.prompts import PromptTemplateqa\_prompt = PromptTemplate(    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query.\n"    "Query: {query\_str}\n"    "Answer: ")class RAGStringQueryEngine(CustomQueryEngine): """RAG String Query Engine."""    retriever: BaseRetriever    response\_synthesizer: BaseSynthesizer    llm: OpenAI    qa\_prompt: PromptTemplate    def custom\_query(self, query\_str: str):        nodes = self.retriever.retrieve(query\_str)        context\_str = "\n\n".join([n.node.get\_content() for n in nodes])        response = self.llm.complete(            qa\_prompt.format(context\_str=context\_str, query\_str=query\_str)        )        return str(response)
```
Trying it out[](#trying-it-out "Permalink to this heading")
------------------------------------------------------------

We now try it out on our sample data.

### Trying Option 1 (`RAGQueryEngine`)[](#trying-option-1-ragqueryengine "Permalink to this heading")


```
synthesizer = get\_response\_synthesizer(response\_mode="compact")query\_engine = RAGQueryEngine(    retriever=retriever, response\_synthesizer=synthesizer)
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(str(response))
```

```
The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They also mentioned getting a microcomputer, building it themselves, and writing simple games and programs on it.
```

```
print(response.source\_nodes[0].get\_content())
```
### Trying Option 2 (`RAGStringQueryEngine`)[](#trying-option-2-ragstringqueryengine "Permalink to this heading")


```
llm = OpenAI(model="gpt-3.5-turbo")query\_engine = RAGStringQueryEngine(    retriever=retriever,    response\_synthesizer=synthesizer,    llm=llm,    qa\_prompt=qa\_prompt,)
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(str(response))
```

```
The author worked on writing and programming before college. They wrote short stories and started programming on the IBM 1401 computer in 9th grade. They later got a microcomputer and continued programming, writing simple games and a word processor.
```
