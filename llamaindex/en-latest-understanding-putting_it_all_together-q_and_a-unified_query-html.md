A Guide to Creating a Unified Query Framework over your Indexes[](#a-guide-to-creating-a-unified-query-framework-over-your-indexes "Permalink to this heading")
================================================================================================================================================================

LlamaIndex offers a variety of different use cases.

For simple queries, we may want to use a single index data structure, such as a `VectorStoreIndex` for semantic search, or `SummaryIndex` for summarization.

For more complex queries, we may want to use a composable graph.

But how do we integrate indexes and graphs into our LLM application? Different indexes and graphs may be better suited for different types of queries that you may want to run.

In this guide, we show how you can unify the diverse use cases of different index/graph structures under a **single** query framework.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

In this example, we will analyze Wikipedia articles of different cities: Boston, Seattle, San Francisco, and more.

The below code snippet downloads the relevant data into files.


```
from pathlib import Pathimport requestswiki\_titles = ["Toronto", "Seattle", "Chicago", "Boston", "Houston"]for title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```
The next snippet loads all files into Document objects.


```
# Load all wiki documentscity\_docs = {}for wiki\_title in wiki\_titles:    city\_docs[wiki\_title] = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()
```
Defining the Set of Indexes[](#defining-the-set-of-indexes "Permalink to this heading")
----------------------------------------------------------------------------------------

We will now define a set of indexes and graphs over our data. You can think of each index/graph as a lightweight structurethat solves a distinct use case.

We will first define a vector index over the documents of each city.


```
from llama\_index import VectorStoreIndex, ServiceContext, StorageContextfrom llama\_index.llms import OpenAI# set service contextllm\_gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm\_gpt4, chunk\_size=1024)# Build city document indexvector\_indices = {}for wiki\_title in wiki\_titles:    storage\_context = StorageContext.from\_defaults()    # build vector index    vector\_indices[wiki\_title] = VectorStoreIndex.from\_documents(        city\_docs[wiki\_title],        service\_context=service\_context,        storage\_context=storage\_context,    )    # set id for vector index    vector\_indices[wiki\_title].index\_struct.index\_id = wiki\_title    # persist to disk    storage\_context.persist(persist\_dir=f"./storage/{wiki\_title}")
```
Querying a vector index lets us easily perform semantic search over a given city’s documents.


```
response = (    vector\_indices["Toronto"]    .as\_query\_engine()    .query("What are the sports teams in Toronto?"))print(str(response))
```
Example response:


```
The sports teams in Toronto are the Toronto Maple Leafs (NHL), Toronto Blue Jays (MLB), Toronto Raptors (NBA), Toronto Argonauts (CFL), Toronto FC (MLS), Toronto Rock (NLL), Toronto Wolfpack (RFL), and Toronto Rush (NARL).
```
Defining a Graph for Compare/Contrast Queries[](#defining-a-graph-for-compare-contrast-queries "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

We will now define a composed graph in order to run **compare/contrast** queries (see [use cases](../../../use_cases/q_and_a.html)).This graph contains a keyword table composed on top of existing vector indexes.

To do this, we first want to set the “summary text” for each vector index.


```
index\_summaries = {}for wiki\_title in wiki\_titles:    # set summary text for city    index\_summaries[wiki\_title] = (        f"This content contains Wikipedia articles about {wiki\_title}. "        f"Use this index if you need to lookup specific facts about {wiki\_title}.\n"        "Do not use this index if you want to analyze multiple cities."    )
```
Next, we compose a keyword table on top of these vector indexes, with these indexes and summaries, in order to build the graph.


```
from llama\_index.indices.composability import ComposableGraphgraph = ComposableGraph.from\_indices(    SimpleKeywordTableIndex,    [index for \_, index in vector\_indices.items()],    [summary for \_, summary in index\_summaries.items()],    max\_keywords\_per\_chunk=50,)# get root indexroot\_index = graph.get\_index(    graph.index\_struct.root\_id, SimpleKeywordTableIndex)# set id of root indexroot\_index.set\_index\_id("compare\_contrast")root\_summary = (    "This index contains Wikipedia articles about multiple cities. "    "Use this index if you want to compare multiple cities. ")
```
Querying this graph (with a query transform module), allows us to easily compare/contrast between different cities.An example is shown below.


```
# define decompose\_transformfrom llama\_index import LLMPredictorfrom llama\_index.indices.query.query\_transform.base import (    DecomposeQueryTransform,)decompose\_transform = DecomposeQueryTransform(    LLMPredictor(llm=llm\_gpt4), verbose=True)# define custom query enginesfrom llama\_index.query\_engine.transform\_query\_engine import (    TransformQueryEngine,)custom\_query\_engines = {}for index in vector\_indices.values():    query\_engine = index.as\_query\_engine(service\_context=service\_context)    query\_engine = TransformQueryEngine(        query\_engine,        query\_transform=decompose\_transform,        transform\_extra\_info={"index\_summary": index.index\_struct.summary},    )    custom\_query\_engines[index.index\_id] = query\_enginecustom\_query\_engines[graph.root\_id] = graph.root\_index.as\_query\_engine(    retriever\_mode="simple",    response\_mode="tree\_summarize",    service\_context=service\_context,)# define query enginequery\_engine = graph.as\_query\_engine(custom\_query\_engines=custom\_query\_engines)# query the graphquery\_str = "Compare and contrast the arts and culture of Houston and Boston. "response\_chatgpt = query\_engine.query(query\_str)
```
Defining the Unified Query Interface[](#defining-the-unified-query-interface "Permalink to this heading")
----------------------------------------------------------------------------------------------------------

Now that we’ve defined the set of indexes/graphs, we want to build an **outer abstraction** layer that provides a unified query interfaceto our data structures. This means that during query-time, we can query this outer abstraction layer and trust that the right index/graphwill be used for the job.

There are a few ways to do this, both within our framework as well as outside of it!

* Build a **router query engine** on top of your existing indexes/graphs
* Define each index/graph as a Tool within an agent framework (e.g. LangChain).

For the purposes of this tutorial, we follow the former approach. If you want to take a look at how the latter approach works,take a look at [our example tutorial here](../chatbots/building_a_chatbot.html).

Let’s take a look at an example of building a router query engine to automatically “route” any query to the set of indexes/graphs that you have define under the hood.

First, we define the query engines for the set of indexes/graph that we want to route our query to. We also give each a description (about what data it holds and what it’s useful for) to help the router choose between them depending on the specific query.


```
from llama\_index.tools.query\_engine import QueryEngineToolquery\_engine\_tools = []# add vector index toolsfor wiki\_title in wiki\_titles:    index = vector\_indices[wiki\_title]    summary = index\_summaries[wiki\_title]    query\_engine = index.as\_query\_engine(service\_context=service\_context)    vector\_tool = QueryEngineTool.from\_defaults(        query\_engine, description=summary    )    query\_engine\_tools.append(vector\_tool)# add graph toolgraph\_description = (    "This tool contains Wikipedia articles about multiple cities. "    "Use this tool if you want to compare multiple cities. ")graph\_tool = QueryEngineTool.from\_defaults(    graph\_query\_engine, description=graph\_description)query\_engine\_tools.append(graph\_tool)
```
Now, we can define the routing logic and overall router query engine.Here, we use the `LLMSingleSelector`, which uses LLM to choose a underlying query engine to route the query to.


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.llm\_selectors import LLMSingleSelectorrouter\_query\_engine = RouterQueryEngine(    selector=LLMSingleSelector.from\_defaults(service\_context=service\_context),    query\_engine\_tools=query\_engine\_tools,)
```
Querying our Unified Interface[](#querying-our-unified-interface "Permalink to this heading")
----------------------------------------------------------------------------------------------

The advantage of a unified query interface is that it can now handle different types of queries.

It can now handle queries about specific cities (by routing to the specific city vector index), and also compare/contrast different cities.

Let’s take a look at a few examples!

**Asking a Compare/Contrast Question**


```
# ask a compare/contrast questionresponse = router\_query\_engine.query(    "Compare and contrast the arts and culture of Houston and Boston.",)print(str(response))
```
**Asking Questions about specific Cities**


```
response = router\_query\_engine.query("What are the sports teams in Toronto?")print(str(response))
```
This “outer” abstraction is able to handle different queries by routing to the right underlying abstractions.

