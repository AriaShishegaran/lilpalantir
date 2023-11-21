[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/ensemble_query_engine.ipynb)

Ensemble Query Engine Guide[](#ensemble-query-engine-guide "Permalink to this heading")
========================================================================================

Oftentimes when building a RAG application there are different query pipelines you need to experiment with (e.g. top-k retrieval, keyword search, knowledge graphs).

Thought: what if we could try a bunch of strategies at once, and have the LLM 1) rate the relevance of each query, and 2) synthesize the results?

This guide showcases this over the Great Gatsby. We do ensemble retrieval over different chunk sizes and also different indices.

**NOTE**: Please also see our closely-related [Ensemble Retrieval Guide](https://gpt-index.readthedocs.io/en/stable/examples/retrievers/ensemble_retrieval.html)!

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().handlers = []logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,    SimpleKeywordTableIndex,    KnowledgeGraphIndex,)from llama\_index.response.notebook\_utils import display\_responsefrom llama\_index.llms import OpenAI
```

```
Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.NumExpr defaulting to 8 threads.
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!wget 'https://raw.githubusercontent.com/jerryjliu/llama\_index/main/examples/gatsby/gatsby\_full.txt' -O 'gatsby\_full.txt'
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

We first show how to convert a Document into a set of Nodes, and insert into a DocumentStore.


```
from llama\_index import SimpleDirectoryReader# try loading great gatsbydocuments = SimpleDirectoryReader(    input\_files=["./gatsby\_full.txt"]).load\_data()
```
Define Query Engines[](#define-query-engines "Permalink to this heading")
--------------------------------------------------------------------------


```
# initialize service context (set chunk size)from llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(chunk\_size=1024, llm=llm)nodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)
```

```
# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)
```

```
keyword\_index = SimpleKeywordTableIndex(    nodes,    storage\_context=storage\_context,    service\_context=service\_context,    show\_progress=True,)vector\_index = VectorStoreIndex(    nodes,    storage\_context=storage\_context,    service\_context=service\_context,    show\_progress=True,)# graph\_index = KnowledgeGraphIndex(nodes, storage\_context=storage\_context, service\_context=service\_context, show\_progress=True)
```

```
from llama\_index.prompts import PromptTemplateQA\_PROMPT\_TMPL = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the question. If the answer is not in the context, inform "    "the user that you can't answer the question - DO NOT MAKE UP AN ANSWER.\n"    "In addition to returning the answer, also return a relevance score as to "    "how relevant the answer is to the question. "    "Question: {query\_str}\n"    "Answer (including relevance score): ")QA\_PROMPT = PromptTemplate(QA\_PROMPT\_TMPL)keyword\_query\_engine = keyword\_index.as\_query\_engine(    text\_qa\_template=QA\_PROMPT)vector\_query\_engine = vector\_index.as\_query\_engine(text\_qa\_template=QA\_PROMPT)
```

```
response = vector\_query\_engine.query(    "Describe and summarize the interactions between Gatsby and Daisy")
```

```
print(response)
```

```
Gatsby and Daisy's interactions are described as intimate and conspiring. They sit opposite each other at a kitchen table, with Gatsby's hand covering Daisy's hand. They communicate through nods and seem to have a natural intimacy. Gatsby waits for Daisy to go to bed and is reluctant to leave until he knows what she will do. They have a conversation in which Gatsby tells the story of his youth with Dan Cody. Daisy's face is smeared with tears, but Gatsby glows with a new well-being. Gatsby invites Daisy to his house and expresses his desire for her to come. They admire Gatsby's house together and discuss the interesting people who visit. The relevance score of this answer is 10/10.
```

```
response = keyword\_query\_engine.query(    "Describe and summarize the interactions between Gatsby and Daisy")
```

```
> Starting query: Describe and summarize the interactions between Gatsby and Daisyquery keywords: ['describe', 'interactions', 'gatsby', 'summarize', 'daisy']> Extracted keywords: ['gatsby', 'daisy']
```

```
print(response)
```

```
The interactions between Gatsby and Daisy are characterized by a sense of tension and longing. Gatsby is visibly disappointed when Daisy expresses her dissatisfaction with their time together and insists that she didn't have a good time. He feels distant from her and struggles to make her understand his emotions. Gatsby dismisses the significance of the dance and instead focuses on his desire for Daisy to confess her love for him and leave Tom. He yearns for a deep connection with Daisy, but feels that she doesn't fully comprehend his feelings. These interactions highlight the complexities of their relationship and the challenges they face in rekindling their romance. The relevance score for these interactions is 8 out of 10.
```
Define Router Query Engine[](#define-router-query-engine "Permalink to this heading")
--------------------------------------------------------------------------------------


```
from llama\_index.tools.query\_engine import QueryEngineToolkeyword\_tool = QueryEngineTool.from\_defaults(    query\_engine=keyword\_query\_engine,    description="Useful for answering questions about this essay",)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    description="Useful for answering questions about this essay",)
```

```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.llm\_selectors import (    LLMSingleSelector,    LLMMultiSelector,)from llama\_index.selectors.pydantic\_selectors import (    PydanticMultiSelector,    PydanticSingleSelector,)from llama\_index.response\_synthesizers import TreeSummarizeTREE\_SUMMARIZE\_PROMPT\_TMPL = (    "Context information from multiple sources is below. Each source may or"    " may not have \na relevance score attached to"    " it.\n---------------------\n{context\_str}\n---------------------\nGiven"    " the information from multiple sources and their associated relevance"    " scores (if provided) and not prior knowledge, answer the question. If"    " the answer is not in the context, inform the user that you can't answer"    " the question.\nQuestion: {query\_str}\nAnswer: ")tree\_summarize = TreeSummarize(    summary\_template=PromptTemplate(TREE\_SUMMARIZE\_PROMPT\_TMPL))query\_engine = RouterQueryEngine(    selector=LLMMultiSelector.from\_defaults(),    query\_engine\_tools=[        keyword\_tool,        vector\_tool,    ],    summarizer=tree\_summarize,)
```
Experiment with Queries[](#experiment-with-queries "Permalink to this heading")
--------------------------------------------------------------------------------


```
response = await query\_engine.aquery(    "Describe and summarize the interactions between Gatsby and Daisy")print(response)
```

```
message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=1590 request_id=b049001384d0e2f2d96e308903351ca3 response_code=200Selecting query engine 0: Useful for answering questions about this essay.Selecting query engine 1: Useful for answering questions about this essay.> Starting query: Describe and summarize the interactions between Gatsby and Daisyquery keywords: ['interactions', 'summarize', 'describe', 'daisy', 'gatsby']> Extracted keywords: ['daisy', 'gatsby']message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=75 request_id=3f76f611bb063605c3c2365437480f87 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=4482 request_id=597221bd776638356f16034c4d8ad2f6 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=5773 request_id=50a6030879054f470a1e45952b4b80b3 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6478 request_id=9171e42c7ced18baedc77cc89ec7478c response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6166 request_id=f3218012e3f9a12e00daeee0b9b06f67 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=4808 request_id=ab6887cbec9a44c2342d6402e28129d6 response_code=200Combining responses from multiple query engines.message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=4506 request_id=5fd128dab043f58111521d19e7c4f59a response_code=200The interactions between Gatsby and Daisy are portrayed as intense, passionate, and filled with longing and desire. Gatsby is deeply in love with Daisy and throws extravagant parties in the hopes of winning her back. Despite Daisy's marriage to Tom Buchanan, they reconnect and begin an affair. They spend time together at Gatsby's lavish house and even plan to run away together. However, their relationship ends tragically when Daisy accidentally kills Tom's mistress, Myrtle, while driving Gatsby's car. Gatsby takes the blame for the accident and is later killed by Myrtle's husband. Overall, their interactions explore themes of love, wealth, and the pursuit of happiness.
```

```
response.source\_nodes
```

```
[]
```

```
response = await query\_engine.aquery(    "What part of his past is Gatsby trying to recapture?")print(response)
```

```
Selecting query engine 0: Keywords: Gatsby, past, recapture.> Starting query: What part of his past is Gatsby trying to recapture?query keywords: ['gatsby', 'past', 'recapture']> Extracted keywords: ['gatsby', 'past']
```

```
KeyboardInterrupt
```
Compare Against Baseline[](#compare-against-baseline "Permalink to this heading")
----------------------------------------------------------------------------------

Compare against a baseline of chunk size 1024 (k=2)


```
query\_engine\_1024 = query\_engines[-1]
```

```
response\_1024 = query\_engine\_1024.query(    "Describe and summarize the interactions between Gatsby and Daisy")
```

```
display\_response(response\_1024, show\_source=True, source\_length=500)
```
