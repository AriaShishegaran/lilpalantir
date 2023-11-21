[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/RetryQuery.ipynb)

Self Correcting Query Engines - Evaluation & Retry[](#self-correcting-query-engines-evaluation-retry "Permalink to this heading")
==================================================================================================================================

In this notebook, we showcase several advanced, self-correcting query engines.  
They leverage the latest LLM’s ability to evaluate its own output, and then self-correct to give better responses.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Uncomment to add your OpenAI API key# import os# os.environ['OPENAI\_API\_KEY'] = "INSERT OPENAI KEY"
```

```
# Uncomment for debug level logging# import logging# import sys# logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

First we ingest the document.


```
from llama\_index.indices.vector\_store.base import VectorStoreIndexfrom llama\_index.readers.file.base import SimpleDirectoryReader# Needed for running async functions in Jupyter Notebookimport nest\_asyncionest\_asyncio.apply()
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Data


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(documents)query = "What did the author do growing up?"
```
Let’s what the response from the default query engine looks like


```
base\_query\_engine = index.as\_query\_engine()response = base\_query\_engine.query(query)print(response)
```

```
The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer and started programming on it, writing simple games and a word processor. They also mentioned their interest in philosophy and AI.
```
Retry Query Engine[](#retry-query-engine "Permalink to this heading")
----------------------------------------------------------------------

The retry query engine uses an evaluator to improve the response from a base query engine.

It does the following:

1. first queries the base query engine, then
2. use the evaluator to decided if the response passes.
3. If the response passes, then return response,
4. Otherwise, transform the original query with the evaluation result (query, response, and feedback) into a new query,
5. Repeat up to max\_retries


```
from llama\_index.query\_engine import RetryQueryEnginefrom llama\_index.evaluation import RelevancyEvaluatorquery\_response\_evaluator = RelevancyEvaluator()retry\_query\_engine = RetryQueryEngine(    base\_query\_engine, query\_response\_evaluator)retry\_response = retry\_query\_engine.query(query)print(retry\_response)
```

```
The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer, a TRS-80, and started programming more extensively, including writing simple games and a word processor.
```
Retry Source Query Engine[](#retry-source-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------

The Source Retry modifies the query source nodes by filtering the existing source nodes for the query based on llm node evaluation.


```
from llama\_index.query\_engine import RetrySourceQueryEngineretry\_source\_query\_engine = RetrySourceQueryEngine(    base\_query\_engine, query\_response\_evaluator)retry\_source\_response = retry\_source\_query\_engine.query(query)print(retry\_source\_response)
```

```
The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer and started programming on it, writing simple games and a word processor. They also mentioned their interest in philosophy and AI.
```
Retry Guideline Query Engine[](#retry-guideline-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------------

This module tries to use guidelines to direct the evaluator’s behavior. You can customize your own guidelines.


```
from llama\_index.evaluation.guideline import (    GuidelineEvaluator,    DEFAULT\_GUIDELINES,)from llama\_index.response.schema import Responsefrom llama\_index.indices.query.query\_transform.feedback\_transform import (    FeedbackQueryTransformation,)from llama\_index.query\_engine.retry\_query\_engine import (    RetryGuidelineQueryEngine,)# Guideline evalguideline\_eval = GuidelineEvaluator(    guidelines=DEFAULT\_GUIDELINES    + "\nThe response should not be overly long.\n"    "The response should try to summarize where possible.\n")  # just for example
```
Let’s look like what happens under the hood.


```
typed\_response = (    response if isinstance(response, Response) else response.get\_response())eval = guideline\_eval.evaluate\_response(query, typed\_response)print(f"Guideline eval evaluation result: {eval.feedback}")feedback\_query\_transform = FeedbackQueryTransformation(resynthesize\_query=True)transformed\_query = feedback\_query\_transform.run(query, {"evaluation": eval})print(f"Transformed query: {transformed\_query.query\_str}")
```

```
Guideline eval evaluation result: The response partially answers the query but lacks specific statistics or numbers. It provides some details about the author's activities growing up, such as writing short stories and programming on different computers, but it could be more concise and focused. Additionally, the response does not mention any statistics or numbers to support the author's experiences.Transformed query: Here is a previous bad answer.The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer and started programming on it, writing simple games and a word processor. They also mentioned their interest in philosophy and AI.Here is some feedback from the evaluator about the response given.The response partially answers the query but lacks specific statistics or numbers. It provides some details about the author's activities growing up, such as writing short stories and programming on different computers, but it could be more concise and focused. Additionally, the response does not mention any statistics or numbers to support the author's experiences.Now answer the question.What were the author's activities and interests during their childhood and adolescence?
```
Now let’s run the full query engine


```
retry\_guideline\_query\_engine = RetryGuidelineQueryEngine(    base\_query\_engine, guideline\_eval, resynthesize\_query=True)retry\_guideline\_response = retry\_guideline\_query\_engine.query(query)print(retry\_guideline\_response)
```

```
During their childhood and adolescence, the author worked on writing short stories and programming. They mentioned that their short stories were not very good, lacking plot but focusing on characters with strong feelings. In terms of programming, they tried writing programs on the IBM 1401 computer in 9th grade using an early version of Fortran. However, they mentioned being puzzled by the 1401 and not being able to do much with it due to the limited input options. They also mentioned getting a microcomputer, a TRS-80, and starting to write simple games, a program to predict rocket heights, and a word processor.
```
