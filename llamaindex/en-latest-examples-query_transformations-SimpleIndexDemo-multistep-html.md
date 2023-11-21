[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_transformations/SimpleIndexDemo-multistep.ipynb)

Multi-Step Query Engine[](#multi-step-query-engine "Permalink to this heading")
================================================================================

We have a multi-step query engine that’s able to decompose a complex query into sequential subquestions. Thisguide walks you through how to set it up!

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,)from llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```

```
# LLM Predictor (gpt-3)gpt3 = OpenAI(temperature=0, model="text-davinci-003")service\_context\_gpt3 = ServiceContext.from\_defaults(llm=gpt3)# LLMPredictor (gpt-4)gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
from llama\_index.indices.query.query\_transform.base import (    StepDecomposeQueryTransform,)from llama\_index import LLMPredictor# gpt-4step\_decompose\_transform = StepDecomposeQueryTransform(    LLMPredictor(llm=gpt4), verbose=True)# gpt-3step\_decompose\_transform\_gpt3 = StepDecomposeQueryTransform(    LLMPredictor(llm=gpt3), verbose=True)
```

```
index\_summary = "Used to answer questions about the author"
```

```
# set Logging to DEBUG for more detailed outputsfrom llama\_index.query\_engine.multistep\_query\_engine import (    MultiStepQueryEngine,)query\_engine = index.as\_query\_engine(service\_context=service\_context\_gpt4)query\_engine = MultiStepQueryEngine(    query\_engine=query\_engine,    query\_transform=step\_decompose\_transform,    index\_summary=index\_summary,)response\_gpt4 = query\_engine.query(    "Who was in the first batch of the accelerator program the author"    " started?",)
```

```
display(Markdown(f"<b>{response\_gpt4}</b>"))
```

```
sub\_qa = response\_gpt4.metadata["sub\_qa"]tuples = [(t[0], t[1].response) for t in sub\_qa]print(tuples)
```

```
response\_gpt4 = query\_engine.query(    "In which city did the author found his first company, Viaweb?",)
```

```
print(response\_gpt4)
```

```
query\_engine = index.as\_query\_engine(service\_context=service\_context\_gpt3)query\_engine = MultiStepQueryEngine(    query\_engine=query\_engine,    query\_transform=step\_decompose\_transform\_gpt3,    index\_summary=index\_summary,)response\_gpt3 = query\_engine.query(    "In which city did the author found his first company, Viaweb?",)
```

```
print(response\_gpt3)
```
