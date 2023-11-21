Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

An agent is initialized from a set of Tools. Here’s an example of instantiating a ReActagent from a set of Tools.


```
from llama\_index.tools import FunctionToolfrom llama\_index.llms import OpenAIfrom llama\_index.agent import ReActAgent# define sample Tooldef multiply(a: int, b: int) -> int: """Multiple two integers and returns the result integer"""    return a \* bmultiply\_tool = FunctionTool.from\_defaults(fn=multiply)# initialize llmllm = OpenAI(model="gpt-3.5-turbo-0613")# initialize ReAct agentagent = ReActAgent.from\_tools([multiply\_tool], llm=llm, verbose=True)
```
An agent supports both `chat` and `query` endpoints, inheriting from our `ChatEngine` and `QueryEngine` respectively.

Example usage:


```
agent.chat("What is 2123 \* 215123")
```
Query Engine Tools[](#query-engine-tools "Permalink to this heading")
----------------------------------------------------------------------

It is easy to wrap query engines as tools for an agent as well. Simply do the following:


```
from llama\_index.agent import ReActAgentfrom llama\_index.tools import QueryEngineTool# NOTE: lyft\_index and uber\_index are both SimpleVectorIndex instanceslyft\_engine = lyft\_index.as\_query\_engine(similarity\_top\_k=3)uber\_engine = uber\_index.as\_query\_engine(similarity\_top\_k=3)query\_engine\_tools = [    QueryEngineTool(        query\_engine=lyft\_engine,        metadata=ToolMetadata(            name="lyft\_10k",            description="Provides information about Lyft financials for year 2021. "            "Use a detailed plain text question as input to the tool.",        ),    ),    QueryEngineTool(        query\_engine=uber\_engine,        metadata=ToolMetadata(            name="uber\_10k",            description="Provides information about Uber financials for year 2021. "            "Use a detailed plain text question as input to the tool.",        ),    ),]# initialize ReAct agentagent = ReActAgent.from\_tools(query\_engine\_tools, llm=llm, verbose=True)
```
Use other agents as Tools[](#use-other-agents-as-tools "Permalink to this heading")
------------------------------------------------------------------------------------

A nifty feature of our agents is that since they inherit from `BaseQueryEngine`, you can easily define other agents as toolsthrough our `QueryEngineTool`.


```
from llama\_index.tools import QueryEngineToolquery\_engine\_tools = [    QueryEngineTool(        query\_engine=sql\_agent,        metadata=ToolMetadata(            name="sql\_agent", description="Agent that can execute SQL queries."        ),    ),    QueryEngineTool(        query\_engine=gmail\_agent,        metadata=ToolMetadata(            name="gmail\_agent",            description="Tool that can send emails on Gmail.",        ),    ),]outer\_agent = ReActAgent.from\_tools(query\_engine\_tools, llm=llm, verbose=True)
```
Advanced Concepts (for `OpenAIAgent`, in beta)[](#advanced-concepts-for-openaiagent-in-beta "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------

You can also use agents in more advanced settings. For instance, being able to retrieve tools from an index during query-time, andbeing able to perform query planning over an existing set of Tools.

These are largely implemented with our `OpenAIAgent` classes (which depend on the OpenAI Function API). Supportfor our more general `ReActAgent` is something we’re actively investigating.

NOTE: these are largely still in beta. The abstractions may change and become more general over time.

### Function Retrieval Agents[](#function-retrieval-agents "Permalink to this heading")

If the set of Tools is very large, you can create an `ObjectIndex` to index the tools, and then pass in an `ObjectRetriever` to the agent during query-time, to first dynamically retrieve the relevant tools before having the agent pick from the candidate tools.

We first build an `ObjectIndex` over an existing set of Tools.


```
# define an "object" index over these toolsfrom llama\_index import VectorStoreIndexfrom llama\_index.objects import ObjectIndex, SimpleToolNodeMappingtool\_mapping = SimpleToolNodeMapping.from\_objects(all\_tools)obj\_index = ObjectIndex.from\_objects(    all\_tools,    tool\_mapping,    VectorStoreIndex,)
```
We then define our `FnRetrieverOpenAIAgent`:


```
from llama\_index.agent import FnRetrieverOpenAIAgentagent = FnRetrieverOpenAIAgent.from\_retriever(    obj\_index.as\_retriever(), verbose=True)
```
### Context Retrieval Agents[](#context-retrieval-agents "Permalink to this heading")

Our context-augmented OpenAI Agent will always perform retrieval before calling any tools.

This helps to provide additional context that can help the agent better pick Tools, versusjust trying to make a decision without any context.


```
from llama\_index.schema import Documentfrom llama\_index.agent import ContextRetrieverOpenAIAgent# toy index - stores a list of Abbreviationstexts = [    "Abbreviation: X = Revenue",    "Abbreviation: YZ = Risk Factors",    "Abbreviation: Z = Costs",]docs = [Document(text=t) for t in texts]context\_index = VectorStoreIndex.from\_documents(docs)# add context agentcontext\_agent = ContextRetrieverOpenAIAgent.from\_tools\_and\_retriever(    query\_engine\_tools,    context\_index.as\_retriever(similarity\_top\_k=1),    verbose=True,)response = context\_agent.chat("What is the YZ of March 2022?")
```
### Query Planning[](#query-planning "Permalink to this heading")

OpenAI Function Agents can be capable of advanced query planning. The trick is to provide the agentwith a `QueryPlanTool` - if the agent calls the QueryPlanTool, it is forced to infer a full Pydantic schema representing a queryplan over a set of subtools.


```
# define query plan toolfrom llama\_index.tools import QueryPlanToolfrom llama\_index import get\_response\_synthesizerresponse\_synthesizer = get\_response\_synthesizer(    service\_context=service\_context)query\_plan\_tool = QueryPlanTool.from\_defaults(    query\_engine\_tools=[query\_tool\_sept, query\_tool\_june, query\_tool\_march],    response\_synthesizer=response\_synthesizer,)# initialize agentagent = OpenAIAgent.from\_tools(    [query\_plan\_tool],    max\_function\_calls=10,    llm=OpenAI(temperature=0, model="gpt-4-0613"),    verbose=True,)# should output a query plan to call march, june, and september toolsresponse = agent.query(    "Analyze Uber revenue growth in March, June, and September")
```
