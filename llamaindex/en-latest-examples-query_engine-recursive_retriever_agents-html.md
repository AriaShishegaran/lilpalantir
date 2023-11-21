[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/recursive_retriever_agents.ipynb)

Recursive Retriever + Document Agents[](#recursive-retriever-document-agents "Permalink to this heading")
==========================================================================================================

This guide shows how to combine recursive retrieval and “document agents” for advanced decision making over heterogeneous documents.

There are two motivating factors that lead to solutions for better retrieval:

* Decoupling retrieval embeddings from chunk-based synthesis. Oftentimes fetching documents by their summaries will return more relevant context to queries rather than raw chunks. This is something that recursive retrieval directly allows.
* Within a document, users may need to dynamically perform tasks beyond fact-based question-answering. We introduce the concept of “document agents” - agents that have access to both vector search and summary tools for a given document.

Setup and Download Data[](#setup-and-download-data "Permalink to this heading")
--------------------------------------------------------------------------------

In this section, we’ll define imports and then download Wikipedia articles about different cities. Each article is stored separately.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import (    VectorStoreIndex,    SummaryIndex,    SimpleKeywordTableIndex,    SimpleDirectoryReader,    ServiceContext,)from llama\_index.schema import IndexNodefrom llama\_index.tools import QueryEngineTool, ToolMetadatafrom llama\_index.llms import OpenAI
```

```
wiki\_titles = ["Toronto", "Seattle", "Chicago", "Boston", "Houston"]
```

```
from pathlib import Pathimport requestsfor title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```

```
# Load all wiki documentscity\_docs = {}for wiki\_title in wiki\_titles:    city\_docs[wiki\_title] = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()
```
Define LLM + Service Context + Callback Manager


```
llm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm)
```
Build Document Agent for each Document[](#build-document-agent-for-each-document "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

In this section we define “document agents” for each document.

First we define both a vector index (for semantic search) and summary index (for summarization) for each document. The two query engines are then converted into tools that are passed to an OpenAI function calling agent.

This document agent can dynamically choose to perform semantic search or summarization within a given document.

We create a separate document agent for each city.


```
from llama\_index.agent import OpenAIAgent# Build agents dictionaryagents = {}for wiki\_title in wiki\_titles:    # build vector index    vector\_index = VectorStoreIndex.from\_documents(        city\_docs[wiki\_title], service\_context=service\_context    )    # build summary index    summary\_index = SummaryIndex.from\_documents(        city\_docs[wiki\_title], service\_context=service\_context    )    # define query engines    vector\_query\_engine = vector\_index.as\_query\_engine()    list\_query\_engine = summary\_index.as\_query\_engine()    # define tools    query\_engine\_tools = [        QueryEngineTool(            query\_engine=vector\_query\_engine,            metadata=ToolMetadata(                name="vector\_tool",                description=(                    "Useful for summarization questions related to"                    f" {wiki\_title}"                ),            ),        ),        QueryEngineTool(            query\_engine=list\_query\_engine,            metadata=ToolMetadata(                name="summary\_tool",                description=(                    f"Useful for retrieving specific context from {wiki\_title}"                ),            ),        ),    ]    # build agent    function\_llm = OpenAI(model="gpt-3.5-turbo-0613")    agent = OpenAIAgent.from\_tools(        query\_engine\_tools,        llm=function\_llm,        verbose=True,    )    agents[wiki\_title] = agent
```
Build Recursive Retriever over these Agents[](#build-recursive-retriever-over-these-agents "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------

Now we define a set of summary nodes, where each node links to the corresponding Wikipedia city article. We then define a `RecursiveRetriever` on top of these Nodes to route queries down to a given node, which will in turn route it to the relevant document agent.

We finally define a full query engine combining `RecursiveRetriever` into a `RetrieverQueryEngine`.


```
# define top-level nodesnodes = []for wiki\_title in wiki\_titles:    # define index node that links to these agents    wiki\_summary = (        f"This content contains Wikipedia articles about {wiki\_title}. Use"        " this index if you need to lookup specific facts about"        f" {wiki\_title}.\nDo not use this index if you want to analyze"        " multiple cities."    )    node = IndexNode(text=wiki\_summary, index\_id=wiki\_title)    nodes.append(node)
```

```
# define top-level retrievervector\_index = VectorStoreIndex(nodes)vector\_retriever = vector\_index.as\_retriever(similarity\_top\_k=1)
```

```
# define recursive retrieverfrom llama\_index.retrievers import RecursiveRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom llama\_index.response\_synthesizers import get\_response\_synthesizer
```

```
# note: can pass `agents` dict as `query\_engine\_dict` since every agent can be used as a query enginerecursive\_retriever = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever},    query\_engine\_dict=agents,    verbose=True,)
```
### Define Full Query Engine[](#define-full-query-engine "Permalink to this heading")

This query engine uses the recursive retriever + response synthesis module to synthesize a response.


```
response\_synthesizer = get\_response\_synthesizer(    # service\_context=service\_context,    response\_mode="compact",)query\_engine = RetrieverQueryEngine.from\_args(    recursive\_retriever,    response\_synthesizer=response\_synthesizer,    service\_context=service\_context,)
```
Running Example Queries[](#running-example-queries "Permalink to this heading")
--------------------------------------------------------------------------------


```
# should use Boston agent -> vector toolresponse = query\_engine.query("Tell me about the sports teams in Boston")
```

```
Retrieving with query id None: Tell me about the sports teams in BostonRetrieved node with id, entering: BostonRetrieving with query id Boston: Tell me about the sports teams in Boston=== Calling Function ===Calling function: vector_tool with args: {  "input": "Boston sports teams"}Got output: Boston has teams in the four major North American men's professional sports leagues: Major League Baseball (MLB), National Football League (NFL), National Basketball Association (NBA), and National Hockey League (NHL). The city is home to the Boston Red Sox (MLB), New England Patriots (NFL), Boston Celtics (NBA), and Boston Bruins (NHL). These teams have collectively won 39 championships in their respective leagues. Additionally, Boston has a Major League Soccer (MLS) team called the New England Revolution.========================Got response: Boston is home to several professional sports teams in the major North American leagues. Here are the teams:1. Boston Red Sox (MLB): The Red Sox are one of the oldest and most successful baseball teams in MLB. They have won multiple World Series championships, including recent victories in 2004, 2007, 2013, and 2018.2. New England Patriots (NFL): The Patriots are one of the most successful teams in NFL history. Led by legendary quarterback Tom Brady, they have won six Super Bowl championships, including victories in 2001, 2003, 2004, 2014, 2016, and 2018.3. Boston Celtics (NBA): The Celtics are one of the most storied franchises in NBA history. They have won a record 17 NBA championships, including notable victories in the 1960s and recent success in 2008.4. Boston Bruins (NHL): The Bruins are a successful NHL team with a passionate fan base. They have won six Stanley Cup championships, with victories in 1929, 1939, 1941, 1970, 1972, and 2011.In addition to these major sports teams, Boston also has a Major League Soccer (MLS) team called the New England Revolution. The Revolution play their home games at Gillette Stadium in Foxborough, Massachusetts.Overall, Boston has a rich sports culture and a history of success in various sports leagues. The city's teams have a dedicated fan base and are an integral part of the local community.
```

```
print(response)
```

```
Boston is home to several professional sports teams in the major North American leagues. The city has teams in MLB, NFL, NBA, and NHL. The Boston Red Sox are a successful baseball team with multiple World Series championships. The New England Patriots are a dominant NFL team with six Super Bowl championships. The Boston Celtics have a rich history in the NBA, winning a record 17 NBA championships. The Boston Bruins are a successful NHL team with six Stanley Cup championships. Additionally, Boston has a Major League Soccer team called the New England Revolution. Overall, Boston has a strong sports culture and its teams have a dedicated fan base.
```

```
# should use Houston agent -> vector toolresponse = query\_engine.query("Tell me about the sports teams in Houston")
```

```
Retrieving with query id None: Tell me about the sports teams in HoustonRetrieved node with id, entering: HoustonRetrieving with query id Houston: Tell me about the sports teams in HoustonGot response: Houston is home to several professional sports teams across different leagues. Here are some of the major sports teams in Houston:1. Houston Texans (NFL): The Houston Texans are a professional football team and compete in the National Football League (NFL). They were established in 2002 and play their home games at NRG Stadium.2. Houston Rockets (NBA): The Houston Rockets are a professional basketball team and compete in the National Basketball Association (NBA). They were established in 1967 and have won two NBA championships. The Rockets play their home games at the Toyota Center.3. Houston Astros (MLB): The Houston Astros are a professional baseball team and compete in Major League Baseball (MLB). They were established in 1962 and have won one World Series championship. The Astros play their home games at Minute Maid Park.4. Houston Dynamo (MLS): The Houston Dynamo is a professional soccer team and compete in Major League Soccer (MLS). They were established in 2005 and have won two MLS Cup championships. The Dynamo play their home games at BBVA Stadium.5. Houston Dash (NWSL): The Houston Dash is a professional women's soccer team and compete in the National Women's Soccer League (NWSL). They were established in 2013 and have won one NWSL Challenge Cup. The Dash also play their home games at BBVA Stadium.These are just a few of the sports teams in Houston. The city also has minor league baseball, basketball, and hockey teams, as well as college sports teams representing universities in the area.
```

```
print(response)
```

```
Houston is home to several professional sports teams across different leagues. Some of the major sports teams in Houston include the Houston Texans (NFL), Houston Rockets (NBA), Houston Astros (MLB), Houston Dynamo (MLS), and Houston Dash (NWSL). These teams compete in football, basketball, baseball, soccer, and women's soccer respectively. Additionally, Houston also has minor league baseball, basketball, and hockey teams, as well as college sports teams representing universities in the area.
```

```
# should use Seattle agent -> summary toolresponse = query\_engine.query(    "Give me a summary on all the positive aspects of Chicago")
```

```
Retrieving with query id None: Give me a summary on all the positive aspects of ChicagoRetrieved node with id, entering: ChicagoRetrieving with query id Chicago: Give me a summary on all the positive aspects of Chicago=== Calling Function ===Calling function: summary_tool with args: {  "input": "positive aspects of Chicago"}Got output: Chicago is known for its vibrant arts and culture scene, with numerous museums, theaters, and galleries that showcase a wide range of artistic expressions. The city is also home to several prestigious universities and colleges, including the University of Chicago, Northwestern University, and Illinois Institute of Technology, which consistently rank among the top "National Universities" in the United States. These institutions offer excellent educational opportunities for students in various fields of study. Chicago's culinary scene is also renowned, with regional specialties like deep-dish pizza, Chicago-style hot dogs, and Italian beef sandwiches. The city's diverse population has contributed to a unique food culture, with dishes like Chicken Vesuvio, the Puerto Rican-influenced jibarito, and the Maxwell Street Polish reflecting its cultural melting pot. Overall, Chicago embraces its cultural diversity through its arts, education, and culinary offerings.========================Got response: Chicago is known for its vibrant arts and culture scene, with numerous museums, theaters, and galleries that showcase a wide range of artistic expressions. The city is also home to several prestigious universities and colleges, including the University of Chicago, Northwestern University, and Illinois Institute of Technology, which consistently rank among the top "National Universities" in the United States. These institutions offer excellent educational opportunities for students in various fields of study. Chicago's culinary scene is also renowned, with regional specialties like deep-dish pizza, Chicago-style hot dogs, and Italian beef sandwiches. The city's diverse population has contributed to a unique food culture, with dishes like Chicken Vesuvio, the Puerto Rican-influenced jibarito, and the Maxwell Street Polish reflecting its cultural melting pot. Overall, Chicago embraces its cultural diversity through its arts, education, and culinary offerings.
```

```
print(response)
```

```
Chicago is known for its vibrant arts and culture scene, with numerous museums, theaters, and galleries that showcase a wide range of artistic expressions. The city is also home to several prestigious universities and colleges, including the University of Chicago, Northwestern University, and Illinois Institute of Technology, which consistently rank among the top "National Universities" in the United States. These institutions offer excellent educational opportunities for students in various fields of study. Chicago's culinary scene is also renowned, with regional specialties like deep-dish pizza, Chicago-style hot dogs, and Italian beef sandwiches. The city's diverse population has contributed to a unique food culture, with dishes like Chicken Vesuvio, the Puerto Rican-influenced jibarito, and the Maxwell Street Polish reflecting its cultural melting pot. Overall, Chicago embraces its cultural diversity through its arts, education, and culinary offerings.
```
