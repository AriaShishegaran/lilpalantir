[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent_query_plan.ipynb)

OpenAI Agent Query Planning[](#openai-agent-query-planning "Permalink to this heading")
========================================================================================

In this demo, we explore adding a `QueryPlanTool` to an `OpenAIAgent`. This effectively enables the agentto do advanced query planning, all through a single tool!

The `QueryPlanTool` is designed to work well with the OpenAI Function API. The tool takes in a set of other tools as input.The tool function signature contains of a QueryPlan Pydantic object, which can in turn contain a DAG of QueryNode objects defining a compute graph.The agent is responsible for defining this graph through the function signature when calling the tool. The tool itself executes the DAG over any corresponding tools.

In this setting we use a familiar example: Uber 10Q filings in March, June, and September of 2022.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# # uncomment to turn on logging# import logging# import sys# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
%load\_ext autoreload%autoreload 2
```

```
from llama\_index import (    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,    GPTVectorStoreIndex,)from llama\_index.response.pprint\_utils import pprint\_responsefrom llama\_index.llms import OpenAI
```

```
llm = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/10q/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10q/uber\_10q\_march\_2022.pdf' -O 'data/10q/uber\_10q\_march\_2022.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10q/uber\_10q\_june\_2022.pdf' -O 'data/10q/uber\_10q\_june\_2022.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10q/uber\_10q\_sept\_2022.pdf' -O 'data/10q/uber\_10q\_sept\_2022.pdf'
```
Load data[](#load-data "Permalink to this heading")
----------------------------------------------------


```
march\_2022 = SimpleDirectoryReader(    input\_files=["./data/10q/uber\_10q\_march\_2022.pdf"]).load\_data()june\_2022 = SimpleDirectoryReader(    input\_files=["./data/10q/uber\_10q\_june\_2022.pdf"]).load\_data()sept\_2022 = SimpleDirectoryReader(    input\_files=["./data/10q/uber\_10q\_sept\_2022.pdf"]).load\_data()
```
Build indices[](#build-indices "Permalink to this heading")
------------------------------------------------------------

We build a vector index / query engine over each of the documents (March, June, September).


```
march\_index = GPTVectorStoreIndex.from\_documents(march\_2022)june\_index = GPTVectorStoreIndex.from\_documents(june\_2022)sept\_index = GPTVectorStoreIndex.from\_documents(sept\_2022)
```

```
march\_engine = march\_index.as\_query\_engine(    similarity\_top\_k=3, service\_context=service\_context)june\_engine = june\_index.as\_query\_engine(    similarity\_top\_k=3, service\_context=service\_context)sept\_engine = sept\_index.as\_query\_engine(    similarity\_top\_k=3, service\_context=service\_context)
```
OpenAI Function Agent with a Query Plan Tool[](#openai-function-agent-with-a-query-plan-tool "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------

Use OpenAIAgent, built on top of the OpenAI tool use interface.

Feed it our QueryPlanTool, which is a Tool that takes in other tools. And the agent to generate a query plan DAG over these tools.


```
from llama\_index.tools import QueryEngineToolquery\_tool\_sept = QueryEngineTool.from\_defaults(    query\_engine=sept\_engine,    name="sept\_2022",    description=(        f"Provides information about Uber quarterly financials ending"        f" September 2022"    ),)query\_tool\_june = QueryEngineTool.from\_defaults(    query\_engine=june\_engine,    name="june\_2022",    description=(        f"Provides information about Uber quarterly financials ending June"        f" 2022"    ),)query\_tool\_march = QueryEngineTool.from\_defaults(    query\_engine=march\_engine,    name="march\_2022",    description=(        f"Provides information about Uber quarterly financials ending March"        f" 2022"    ),)
```

```
# define query plan toolfrom llama\_index.tools import QueryPlanToolfrom llama\_index import get\_response\_synthesizerresponse\_synthesizer = get\_response\_synthesizer(    service\_context=service\_context)query\_plan\_tool = QueryPlanTool.from\_defaults(    query\_engine\_tools=[query\_tool\_sept, query\_tool\_june, query\_tool\_march],    response\_synthesizer=response\_synthesizer,)
```

```
query\_plan\_tool.metadata.to\_openai\_tool()  # to\_openai\_function() deprecated
```

```
{'name': 'query_plan_tool', 'description': '        This is a query plan tool that takes in a list of tools and executes a query plan over these tools to answer a query. The query plan is a DAG of query nodes.\n\nGiven a list of tool names and the query plan schema, you can choose to generate a query plan to answer a question.\n\nThe tool names and descriptions are as follows:\n\n\n\n        Tool Name: sept_2022\nTool Description: Provides information about Uber quarterly financials ending September 2022 \n\nTool Name: june_2022\nTool Description: Provides information about Uber quarterly financials ending June 2022 \n\nTool Name: march_2022\nTool Description: Provides information about Uber quarterly financials ending March 2022 \n        ', 'parameters': {'title': 'QueryPlan',  'description': "Query plan.\n\nContains a list of QueryNode objects (which is a recursive object).\nOut of the list of QueryNode objects, one of them must be the root node.\nThe root node is the one that isn't a dependency of any other node.",  'type': 'object',  'properties': {'nodes': {'title': 'Nodes',    'description': 'The original question we are asking.',    'type': 'array',    'items': {'$ref': '#/definitions/QueryNode'}}},  'required': ['nodes'],  'definitions': {'QueryNode': {'title': 'QueryNode',    'description': 'Query node.\n\nA query node represents a query (query_str) that must be answered.\nIt can either be answered by a tool (tool_name), or by a list of child nodes\n(child_nodes).\nThe tool_name and child_nodes fields are mutually exclusive.',    'type': 'object',    'properties': {'id': {'title': 'Id',      'description': 'ID of the query node.',      'type': 'integer'},     'query_str': {'title': 'Query Str',      'description': 'Question we are asking. This is the query string that will be executed. ',      'type': 'string'},     'tool_name': {'title': 'Tool Name',      'description': 'Name of the tool to execute the `query_str`.',      'type': 'string'},     'dependencies': {'title': 'Dependencies',      'description': 'List of sub-questions that need to be answered in order to answer the question given by `query_str`.Should be blank if there are no sub-questions to be specified, in which case `tool_name` is specified.',      'type': 'array',      'items': {'type': 'integer'}}},    'required': ['id', 'query_str']}}}}
```

```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAIagent = OpenAIAgent.from\_tools(    [query\_plan\_tool],    max\_function\_calls=10,    llm=OpenAI(temperature=0, model="gpt-4-0613"),    verbose=True,)
```

```
response = agent.query("What were the risk factors in sept 2022?")
```

```
from llama\_index.tools.query\_plan import QueryPlan, QueryNodequery\_plan = QueryPlan(    nodes=[        QueryNode(            id=1,            query\_str="risk factors",            tool\_name="sept\_2022",            dependencies=[],        )    ])
```

```
QueryPlan.schema()
```

```
{'title': 'QueryPlan', 'description': 'Query plan.\n\nContains the root QueryNode (which is a recursive object).\nThe root node should contain the original query string to be executed.\n\nExample query plan in JSON format:\n\n```json\n{\n    "root": {\n        "query_str": "Compare the demographics of France and Italy.",\n        "child_nodes": [\n            {\n                "query_str": "What are the demographics of France?",\n                "tool_name": "france_demographics",\n                "child_nodes": []\n            },\n            {\n                "query_str": "What are the demographics of Italy?",\n                "tool_name": "italy_demographics",\n                "child_nodes": []\n            }\n        ]\n    }\n}\n```', 'type': 'object', 'properties': {'root': {'title': 'Root',   'description': 'Root node of the query plan. Should contain the original query string to be executed.',   'allOf': [{'$ref': '#/definitions/QueryNode'}]}}, 'required': ['root'], 'definitions': {'QueryNode': {'title': 'QueryNode',   'description': 'Query node.\n\nA query node represents a query (query_str) that must be answered.\nIt can either be answered by a tool (tool_name), or by a list of child nodes\n(child_nodes).\nThe tool_name and child_nodes fields are mutually exclusive.',   'type': 'object',   'properties': {'query_str': {'title': 'Query Str',     'description': 'Question we are asking. This is the query string that will be executed. We will either provide a tool to execute the query, or a list of child nodes containing sub-questions that will be executed first, and the results of which will be used as context to execute the current query string.',     'type': 'string'},    'tool_name': {'title': 'Tool Name',     'description': 'Name of the tool to execute the `query_str`.',     'type': 'string'},    'child_nodes': {'title': 'Child Nodes',     'description': 'List of child nodes representing sub-questions that need to be answered in order to answer the question given by `query_str`.Should be blank if `tool_name` is specified.',     'type': 'array',     'items': {'$ref': '#/definitions/QueryNode'}}},   'required': ['query_str', 'child_nodes']}}}
```

```
response = agent.query(    "Analyze Uber revenue growth in March, June, and September")
```

```
=== Calling Function ===Calling function: query_plan_tool with args: {  "nodes": [    {      "id": 1,      "query_str": "What is Uber's revenue for March 2022?",      "tool_name": "march_2022",      "dependencies": []    },    {      "id": 2,      "query_str": "What is Uber's revenue for June 2022?",      "tool_name": "june_2022",      "dependencies": []    },    {      "id": 3,      "query_str": "What is Uber's revenue for September 2022?",      "tool_name": "sept_2022",      "dependencies": []    },    {      "id": 4,      "query_str": "Analyze Uber revenue growth in March, June, and September",      "tool_name": "revenue_growth_analyzer",      "dependencies": [1, 2, 3]    }  ]}Executing node {"id": 4, "query\_str": "Analyze Uber revenue growth in March, June, and September", "tool\_name": "revenue\_growth\_analyzer", "dependencies": [1, 2, 3]}Executing 3 child nodesExecuting node {"id": 1, "query\_str": "What is Uber's revenue for March 2022?", "tool\_name": "march\_2022", "dependencies": []}Selected Tool: ToolMetadata(description='Provides information about Uber quarterly financials ending March 2022', name='march\_2022', fn\_schema=None)Executed query, got response.Query: What is Uber's revenue for March 2022?Response: Uber's revenue for March 2022 was $6.854 billion.Executing node {"id": 2, "query\_str": "What is Uber's revenue for June 2022?", "tool\_name": "june\_2022", "dependencies": []}Selected Tool: ToolMetadata(description='Provides information about Uber quarterly financials ending June 2022', name='june\_2022', fn\_schema=None)Executed query, got response.Query: What is Uber's revenue for June 2022?Response: Uber's revenue for June 2022 cannot be determined from the provided information. However, the revenue for the three months ended June 30, 2022, was $8,073 million.Executing node {"id": 3, "query\_str": "What is Uber's revenue for September 2022?", "tool\_name": "sept\_2022", "dependencies": []}Selected Tool: ToolMetadata(description='Provides information about Uber quarterly financials ending September 2022', name='sept\_2022', fn\_schema=None)Executed query, got response.Query: What is Uber's revenue for September 2022?Response: Uber's revenue for the three months ended September 30, 2022, was $8.343 billion.Got output: Based on the provided context information, we can analyze Uber's revenue growth as follows:- In March 2022, Uber's revenue was $6.854 billion.- For the three months ended June 30, 2022, Uber's revenue was $8,073 million (or $8.073 billion). However, we do not have the specific revenue for June 2022.- For the three months ended September 30, 2022, Uber's revenue was $8.343 billion.From this information, we can observe that Uber's revenue has been growing between the periods mentioned. The revenue increased from $6.854 billion in March 2022 to $8.073 billion for the three months ended June 2022, and further increased to $8.343 billion for the three months ended September 2022. However, we cannot provide a month-by-month analysis for June and September as the specific monthly revenue figures are not available.========================
```

```
print(str(response))
```

```
Based on the provided context information, we can analyze Uber's revenue growth for the three-month periods ending in March, June, and September.1. For the three months ended March 31, 2022, Uber's revenue was $6.854 billion.2. For the three months ended June 30, 2022, Uber's revenue was $8.073 billion.3. For the three months ended September 30, 2022, Uber's revenue was $8.343 billion.To analyze the growth, we can compare the revenue figures for each period:- From March to June, Uber's revenue increased by $1.219 billion ($8.073 billion - $6.854 billion), which represents a growth of approximately 17.8% (($1.219 billion / $6.854 billion) * 100).- From June to September, Uber's revenue increased by $0.270 billion ($8.343 billion - $8.073 billion), which represents a growth of approximately 3.3% (($0.270 billion / $8.073 billion) * 100).In summary, Uber experienced significant revenue growth of 17.8% between the three-month periods ending in March and June, followed by a smaller growth of 3.3% between the periods ending in June and September.
```

```
response = agent.query(    "Analyze changes in risk factors in march, june, and september for Uber")
```

```
print(str(response))
```

```
# response = agent.query("Analyze both Uber revenue growth and risk factors over march, june, and september")
```

```
print(str(response))
```

```
Based on the provided context information, we can analyze Uber's revenue growth for the three-month periods ending in March, June, and September.1. For the three months ended March 31, 2022, Uber's revenue was $6.854 billion.2. For the three months ended June 30, 2022, Uber's revenue was $8.073 billion.3. For the three months ended September 30, 2022, Uber's revenue was $8.343 billion.To analyze the growth, we can compare the revenue figures for each period:- From March to June, Uber's revenue increased by $1.219 billion ($8.073 billion - $6.854 billion), which represents a growth of approximately 17.8% (($1.219 billion / $6.854 billion) * 100).- From June to September, Uber's revenue increased by $0.270 billion ($8.343 billion - $8.073 billion), which represents a growth of approximately 3.3% (($0.270 billion / $8.073 billion) * 100).In summary, Uber experienced significant revenue growth of 17.8% between the three-month periods ending in March and June, followed by a smaller growth of 3.3% between the periods ending in June and September.
```

```
response = agent.query(    "First look at Uber's revenue growth and risk factors in March, "    + "then revenue growth and risk factors in September, and then compare and"    " contrast the two documents?")
```

```
response
```
