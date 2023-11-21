[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/sub_question_query_engine.ipynb)

Sub Question Query Engine[](#sub-question-query-engine "Permalink to this heading")
====================================================================================

In this tutorial, we showcase how to use a **sub question query engine** to tackle the problem of answering a complex query using multiple data sources.  
It first breaks down the complex query into sub questions for each relevant data source,then gather all the intermediate reponses and synthesizes a final response.

Preparation[](#preparation "Permalink to this heading")
--------------------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]import nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.tools import QueryEngineTool, ToolMetadatafrom llama\_index.query\_engine import SubQuestionQueryEnginefrom llama\_index.callbacks import CallbackManager, LlamaDebugHandlerfrom llama\_index import ServiceContext
```

```
# Using the LlamaDebugHandler to print the trace of the sub questions# captured by the SUB\_QUESTION callback event typellama\_debug = LlamaDebugHandler(print\_trace\_on\_end=True)callback\_manager = CallbackManager([llama\_debug])service\_context = ServiceContext.from\_defaults(    callback\_manager=callback\_manager)
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load datapg\_essay = SimpleDirectoryReader(input\_dir="./data/paul\_graham/").load\_data()# build index and query enginevector\_query\_engine = VectorStoreIndex.from\_documents(    pg\_essay, use\_async=True, service\_context=service\_context).as\_query\_engine()
```

```
**********Trace: index_construction    |_node_parsing ->  0.394271 seconds      |_chunking ->  0.393344 seconds    |_embedding ->  0.753133 seconds    |_embedding ->  0.749828 seconds**********
```
Setup sub question query engine[](#setup-sub-question-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------------------


```
# setup base query engine as toolquery\_engine\_tools = [    QueryEngineTool(        query\_engine=vector\_query\_engine,        metadata=ToolMetadata(            name="pg\_essay",            description="Paul Graham essay on What I Worked On",        ),    ),]query\_engine = SubQuestionQueryEngine.from\_defaults(    query\_engine\_tools=query\_engine\_tools,    service\_context=service\_context,    use\_async=True,)
```
Run queries[](#run-queries "Permalink to this heading")
--------------------------------------------------------


```
response = query\_engine.query(    "How was Paul Grahams life different before, during, and after YC?")
```

```
Generated 3 sub questions.[pg\_essay] Q: What did Paul Graham do before YC?[pg\_essay] Q: What did Paul Graham do during YC?[pg\_essay] Q: What did Paul Graham do after YC?[pg\_essay] A: Before YC, Paul Graham was a hacker, writer, and worked on Arc, a programming language. He also wrote essays and worked on other projects.[pg\_essay] A: Paul Graham stopped working on YC in March 2014 and began painting. He spent most of the rest of the year painting and then in November he ran out of steam and stopped. He then began writing essays again and in March 2015 he started working on Lisp again.[pg\_essay] A: Paul Graham worked on YC in a variety of ways. He wrote essays, worked on internal software in Arc, and created Hacker News. He also helped select and support founders, dealt with disputes between cofounders, and fought with people who maltreated the startups. He worked hard even at the parts he didn't like, and was determined to make YC a success. In 2010, he was offered unsolicited advice to make sure YC wasn't the last cool thing he did, which set him thinking about his future. In 2012, he decided to hand YC over to someone else and recruited Sam Altman to take over. He worked on YC until March 2014, when his mother passed away, and then he checked out completely.**********Trace: query    |_query ->  13.064431 seconds      |_llm ->  2.499768 seconds      |_sub_question ->  2.05934 seconds        |_query ->  2.059142 seconds          |_retrieve ->  0.278184 seconds            |_embedding ->  0.274593 seconds          |_synthesize ->  1.780895 seconds            |_llm ->  1.740488 seconds      |_sub_question ->  5.364061 seconds        |_query ->  5.363695 seconds          |_retrieve ->  0.230257 seconds            |_embedding ->  0.226763 seconds          |_synthesize ->  5.133343 seconds            |_llm ->  5.091069 seconds      |_sub_question ->  2.148964 seconds        |_query ->  2.14889 seconds          |_retrieve ->  0.323438 seconds            |_embedding ->  0.319841 seconds          |_synthesize ->  1.825401 seconds            |_llm ->  1.783064 seconds      |_synthesize ->  5.198214 seconds        |_llm ->  5.175849 seconds**********
```

```
print(response)
```

```
Before YC, Paul Graham was a hacker, writer, and worked on Arc, a programming language. During YC, he wrote essays, worked on internal software in Arc, and created Hacker News. He also helped select and support founders, dealt with disputes between cofounders, and fought with people who maltreated the startups. After YC, Paul Graham stopped working on YC and began painting. He then began writing essays again and in March 2015 he started working on Lisp again. Paul Graham's life was different before, during, and after YC in that he changed his focus from programming and writing to painting and then back to programming and writing.
```

```
# iterate through sub\_question items captured in SUB\_QUESTION eventfrom llama\_index.callbacks.schema import CBEventType, EventPayloadfor i, (start\_event, end\_event) in enumerate(    llama\_debug.get\_event\_pairs(CBEventType.SUB\_QUESTION)):    qa\_pair = end\_event.payload[EventPayload.SUB\_QUESTION]    print("Sub Question " + str(i) + ": " + qa\_pair.sub\_q.sub\_question.strip())    print("Answer: " + qa\_pair.answer.strip())    print("====================================")
```

```
Sub Question 0: What did Paul Graham do before YC?Answer: Before YC, Paul Graham was a hacker, writer, and worked on Arc, a programming language. He also wrote essays and worked on other projects.====================================Sub Question 1: What did Paul Graham do during YC?Answer: Paul Graham worked on YC in a variety of ways. He wrote essays, worked on internal software in Arc, and created Hacker News. He also helped select and support founders, dealt with disputes between cofounders, and fought with people who maltreated the startups. He worked hard even at the parts he didn't like, and was determined to make YC a success. In 2010, he was offered unsolicited advice to make sure YC wasn't the last cool thing he did, which set him thinking about his future. In 2012, he decided to hand YC over to someone else and recruited Sam Altman to take over. He worked on YC until March 2014, when his mother passed away, and then he checked out completely.====================================Sub Question 2: What did Paul Graham do after YC?Answer: Paul Graham stopped working on YC in March 2014 and began painting. He spent most of the rest of the year painting and then in November he ran out of steam and stopped. He then began writing essays again and in March 2015 he started working on Lisp again.====================================
```
