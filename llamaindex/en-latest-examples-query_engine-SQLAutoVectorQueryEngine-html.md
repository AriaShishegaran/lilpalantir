[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/SQLAutoVectorQueryEngine.ipynb)

SQL Auto Vector Query Engine[](#sql-auto-vector-query-engine "Permalink to this heading")
==========================================================================================

In this tutorial, we show you how to use our SQLAutoVectorQueryEngine.

This query engine allows you to combine insights from your structured tables with your unstructured data.It first decides whether to query your structured tables for insights.Once it does, it can then infer a corresponding query to the vector store in order to fetch corresponding documents.


```
import openaiimport osos.environ["OPENAI\_API\_KEY"] = "[You API key]"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,    SQLDatabase,    WikipediaReader,)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Create Common Objects[](#create-common-objects "Permalink to this heading")
----------------------------------------------------------------------------

This includes a `ServiceContext` object containing abstractions such as the LLM and chunk size.This also includes a `StorageContext` object containing our vector store abstractions.


```
# define pinecone indeximport pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp-free")# dimensions are for text-embedding-ada-002# pinecone.create\_index("quickstart", dimension=1536, metric="euclidean", pod\_type="p1")pinecone\_index = pinecone.Index("quickstart")
```

```
/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/pinecone/index.py:4: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from tqdm.autonotebook import tqdm
```

```
# OPTIONAL: delete allpinecone\_index.delete(deleteAll=True)
```

```
{}
```

```
from llama\_index.node\_parser.simple import SimpleNodeParserfrom llama\_index import ServiceContext, LLMPredictorfrom llama\_index.storage import StorageContextfrom llama\_index.vector\_stores import PineconeVectorStorefrom llama\_index.text\_splitter import TokenTextSplitterfrom llama\_index.llms import OpenAI# define node parser and LLMchunk\_size = 1024llm = OpenAI(temperature=0, model="gpt-4", streaming=True)service\_context = ServiceContext.from\_defaults(chunk\_size=chunk\_size, llm=llm)text\_splitter = TokenTextSplitter(chunk\_size=chunk\_size)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)# define pinecone vector indexvector\_store = PineconeVectorStore(    pinecone\_index=pinecone\_index, namespace="wiki\_cities")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)vector\_index = VectorStoreIndex([], storage\_context=storage\_context)
```
Create Database Schema + Test Data[](#create-database-schema-test-data "Permalink to this heading")
----------------------------------------------------------------------------------------------------

Here we introduce a toy scenario where there are 100 tables (too big to fit into the prompt)


```
from sqlalchemy import (    create\_engine,    MetaData,    Table,    Column,    String,    Integer,    select,    column,)
```

```
engine = create\_engine("sqlite:///:memory:", future=True)metadata\_obj = MetaData()
```

```
# create city SQL tabletable\_name = "city\_stats"city\_stats\_table = Table(    table\_name,    metadata\_obj,    Column("city\_name", String(16), primary\_key=True),    Column("population", Integer),    Column("country", String(16), nullable=False),)metadata\_obj.create\_all(engine)
```

```
# print tablesmetadata\_obj.tables.keys()
```

```
dict_keys(['city_stats'])
```
We introduce some test data into the `city\_stats` table


```
from sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2930000, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13960000, "country": "Japan"},    {"city\_name": "Berlin", "population": 3645000, "country": "Germany"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```

```
with engine.connect() as connection:    cursor = connection.exec\_driver\_sql("SELECT \* FROM city\_stats")    print(cursor.fetchall())
```

```
[('Toronto', 2930000, 'Canada'), ('Tokyo', 13960000, 'Japan'), ('Berlin', 3645000, 'Germany')]
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

We first show how to convert a Document into a set of Nodes, and insert into a DocumentStore.


```
# install wikipedia python package!pip install wikipedia
```

```
Requirement already satisfied: wikipedia in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (1.4.0)Requirement already satisfied: beautifulsoup4 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from wikipedia) (4.12.2)Requirement already satisfied: requests<3.0.0,>=2.0.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from wikipedia) (2.31.0)Requirement already satisfied: idna<4,>=2.5 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.4)Requirement already satisfied: charset-normalizer<4,>=2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.2.0)Requirement already satisfied: certifi>=2017.4.17 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (2023.5.7)Requirement already satisfied: urllib3<3,>=1.21.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (1.26.16)Requirement already satisfied: soupsieve>1.2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from beautifulsoup4->wikipedia) (2.4.1)WARNING: You are using pip version 21.2.4; however, version 23.2 is available.You should consider upgrading via the '/Users/loganmarkewich/llama\_index/llama-index/bin/python3 -m pip install --upgrade pip' command.
```

```
cities = ["Toronto", "Berlin", "Tokyo"]wiki\_docs = WikipediaReader().load\_data(pages=cities)
```
Build SQL Index[](#build-sql-index "Permalink to this heading")
----------------------------------------------------------------


```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```

```
from llama\_index.indices.struct\_store.sql\_query import NLSQLTableQueryEngine
```

```
sql\_query\_engine = NLSQLTableQueryEngine(    sql\_database=sql\_database,    tables=["city\_stats"],)
```
Build Vector Index[](#build-vector-index "Permalink to this heading")
----------------------------------------------------------------------


```
# Insert documents into vector index# Each document has metadata of the city attachedfor city, wiki\_doc in zip(cities, wiki\_docs):    nodes = node\_parser.get\_nodes\_from\_documents([wiki\_doc])    # add metadata to each node    for node in nodes:        node.metadata = {"title": city}    vector\_index.insert\_nodes(nodes)
```

```
Upserted vectors: 100%|██████████| 20/20 [00:00<00:00, 22.37it/s]Upserted vectors: 100%|██████████| 22/22 [00:00<00:00, 23.14it/s]Upserted vectors: 100%|██████████| 13/13 [00:00<00:00, 17.67it/s]
```
Define Query Engines, Set as Tools[](#define-query-engines-set-as-tools "Permalink to this heading")
-----------------------------------------------------------------------------------------------------


```
from llama\_index.query\_engine import (    SQLAutoVectorQueryEngine,    RetrieverQueryEngine,)from llama\_index.tools.query\_engine import QueryEngineToolfrom llama\_index.indices.vector\_store import VectorIndexAutoRetriever
```

```
from llama\_index.indices.vector\_store.retrievers import (    VectorIndexAutoRetriever,)from llama\_index.vector\_stores.types import MetadataInfo, VectorStoreInfofrom llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)vector\_store\_info = VectorStoreInfo(    content\_info="articles about different cities",    metadata\_info=[        MetadataInfo(            name="title", type="str", description="The name of the city"        ),    ],)vector\_auto\_retriever = VectorIndexAutoRetriever(    vector\_index, vector\_store\_info=vector\_store\_info)retriever\_query\_engine = RetrieverQueryEngine.from\_args(    vector\_auto\_retriever, service\_context=service\_context)
```

```
sql\_tool = QueryEngineTool.from\_defaults(    query\_engine=sql\_query\_engine,    description=(        "Useful for translating a natural language query into a SQL query over"        " a table containing: city\_stats, containing the population/country of"        " each city"    ),)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=retriever\_query\_engine,    description=(        f"Useful for answering semantic questions about different cities"    ),)
```
Define SQLAutoVectorQueryEngine[](#define-sqlautovectorqueryengine "Permalink to this heading")
------------------------------------------------------------------------------------------------


```
query\_engine = SQLAutoVectorQueryEngine(    sql\_tool, vector\_tool, service\_context=service\_context)
```

```
response = query\_engine.query(    "Tell me about the arts and culture of the city with the highest"    " population")
```

```
Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing city\_stats, containing the population/country of each cityINFO:llama_index.query_engine.sql_join_query_engine:> Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing city_stats, containing the population/country of each city> Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing city_stats, containing the population/country of each cityINFO:llama_index.indices.struct_store.sql_query:> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .SQL query: SELECT city\_name, population FROM city\_stats ORDER BY population DESC LIMIT 1;SQL response: Tokyo is the city with the highest population, with 13.96 million people. It is a vibrant city with a rich culture and a wide variety of art forms. From traditional Japanese art such as calligraphy and woodblock prints to modern art galleries and museums, Tokyo has something for everyone. There are also many festivals and events throughout the year that celebrate the city's culture and art.Transformed query given SQL response: What are some specific cultural festivals, events, and notable art galleries or museums in Tokyo?INFO:llama_index.query_engine.sql_join_query_engine:> Transformed query given SQL response: What are some specific cultural festivals, events, and notable art galleries or museums in Tokyo?> Transformed query given SQL response: What are some specific cultural festivals, events, and notable art galleries or museums in Tokyo?INFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using query str: cultural festivals events art galleries museums TokyoUsing query str: cultural festivals events art galleries museums TokyoINFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using filters: {'title': 'Tokyo'}Using filters: {'title': 'Tokyo'}INFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using top_k: 2Using top_k: 2query engine response: The context information mentions the Tokyo National Museum, which houses 37% of the country's artwork national treasures. It also mentions the Studio Ghibli anime center as a subcultural attraction. However, the text does not provide information on specific cultural festivals or events in Tokyo.INFO:llama_index.query_engine.sql_join_query_engine:> query engine response: The context information mentions the Tokyo National Museum, which houses 37% of the country's artwork national treasures. It also mentions the Studio Ghibli anime center as a subcultural attraction. However, the text does not provide information on specific cultural festivals or events in Tokyo.> query engine response: The context information mentions the Tokyo National Museum, which houses 37% of the country's artwork national treasures. It also mentions the Studio Ghibli anime center as a subcultural attraction. However, the text does not provide information on specific cultural festivals or events in Tokyo.Final response: Tokyo, the city with the highest population of 13.96 million people, is known for its vibrant culture and diverse art forms. It is home to traditional Japanese art such as calligraphy and woodblock prints, as well as modern art galleries and museums. Notably, the Tokyo National Museum houses 37% of the country's artwork national treasures, and the Studio Ghibli anime center is a popular subcultural attraction. While there are many festivals and events throughout the year that celebrate the city's culture and art, specific examples were not provided in the available information.
```

```
print(str(response))
```

```
Tokyo, the city with the highest population of 13.96 million people, is known for its vibrant culture and diverse art forms. It is home to traditional Japanese art such as calligraphy and woodblock prints, as well as modern art galleries and museums. Notably, the Tokyo National Museum houses 37% of the country's artwork national treasures, and the Studio Ghibli anime center is a popular subcultural attraction. While there are many festivals and events throughout the year that celebrate the city's culture and art, specific examples were not provided in the available information.
```

```
response = query\_engine.query("Tell me about the history of Berlin")
```

```
Querying other query engine: Useful for answering semantic questions about different citiesINFO:llama_index.query_engine.sql_join_query_engine:> Querying other query engine: Useful for answering semantic questions about different cities> Querying other query engine: Useful for answering semantic questions about different citiesINFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using query str: history of BerlinUsing query str: history of BerlinINFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using filters: {'title': 'Berlin'}Using filters: {'title': 'Berlin'}INFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using top_k: 2Using top_k: 2Query Engine response: Berlin's history dates back to around 60,000 BC, with the earliest human traces found in the area. A Mesolithic deer antler mask found in Biesdorf (Berlin) was dated around 9000 BC. During Neolithic times, a large number of communities existed in the area and in the Bronze Age, up to 1000 people lived in 50 villages. Early Germanic tribes took settlement from 500 BC and Slavic settlements and castles began around 750 AD.The earliest evidence of middle age settlements in the area of today's Berlin are remnants of a house foundation dated to 1174, found in excavations in Berlin Mitte, and a wooden beam dated from approximately 1192. The first written records of towns in the area of present-day Berlin date from the late 12th century. Spandau is first mentioned in 1197 and Köpenick in 1209, although these areas did not join Berlin until 1920. The central part of Berlin can be traced back to two towns. Cölln on the Fischerinsel is first mentioned in a 1237 document, and Berlin, across the Spree in what is now called the Nikolaiviertel, is referenced in a document from 1244. 1237 is considered the founding date of the city. The two towns over time formed close economic and social ties, and profited from the staple right on the two important trade routes Via Imperii and from Bruges to Novgorod. In 1307, they formed an alliance with a common external policy, their internal administrations still being separated. In 1415, Frederick I became the elector of the Margraviate of Brandenburg, which he ruled until 1440.The name Berlin has its roots in the language of West Slavic inhabitants of the area of today's Berlin, and may be related to the Old Polabian stem berl-/birl- ("swamp"). or Proto-Slavic bьrlogъ, (lair, den). Since the Ber- at the beginning sounds like the German word Bär ("bear"), a bear appears in the coat of arms of the city. It is therefore an example of canting arms.
```

```
print(str(response))
```

```
Berlin's history dates back to around 60,000 BC, with the earliest human traces found in the area. A Mesolithic deer antler mask found in Biesdorf (Berlin) was dated around 9000 BC. During Neolithic times, a large number of communities existed in the area and in the Bronze Age, up to 1000 people lived in 50 villages. Early Germanic tribes took settlement from 500 BC and Slavic settlements and castles began around 750 AD.The earliest evidence of middle age settlements in the area of today's Berlin are remnants of a house foundation dated to 1174, found in excavations in Berlin Mitte, and a wooden beam dated from approximately 1192. The first written records of towns in the area of present-day Berlin date from the late 12th century. Spandau is first mentioned in 1197 and Köpenick in 1209, although these areas did not join Berlin until 1920. The central part of Berlin can be traced back to two towns. Cölln on the Fischerinsel is first mentioned in a 1237 document, and Berlin, across the Spree in what is now called the Nikolaiviertel, is referenced in a document from 1244. 1237 is considered the founding date of the city. The two towns over time formed close economic and social ties, and profited from the staple right on the two important trade routes Via Imperii and from Bruges to Novgorod. In 1307, they formed an alliance with a common external policy, their internal administrations still being separated. In 1415, Frederick I became the elector of the Margraviate of Brandenburg, which he ruled until 1440.The name Berlin has its roots in the language of West Slavic inhabitants of the area of today's Berlin, and may be related to the Old Polabian stem berl-/birl- ("swamp"). or Proto-Slavic bьrlogъ, (lair, den). Since the Ber- at the beginning sounds like the German word Bär ("bear"), a bear appears in the coat of arms of the city. It is therefore an example of canting arms.
```

```
response = query\_engine.query(    "Can you give me the country corresponding to each city?")
```

```
Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing: city\_stats, containing the population/country of each cityINFO:llama_index.query_engine.sql_join_query_engine:> Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each city> Querying SQL database: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each cityINFO:llama_index.indices.struct_store.sql_query:> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .SQL query: SELECT city\_name, country FROM city\_stats;SQL response: Toronto is in Canada, Tokyo is in Japan, and Berlin is in Germany.Transformed query given SQL response: What countries are New York, San Francisco, and other cities in?INFO:llama_index.query_engine.sql_join_query_engine:> Transformed query given SQL response: What countries are New York, San Francisco, and other cities in?> Transformed query given SQL response: What countries are New York, San Francisco, and other cities in?INFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using query str: New York San FranciscoUsing query str: New York San FranciscoINFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using filters: {'title': 'San Francisco'}Using filters: {'title': 'San Francisco'}INFO:llama_index.indices.vector_store.retrievers.auto_retriever.auto_retriever:Using top_k: 2Using top_k: 2query engine response: NoneINFO:llama_index.query_engine.sql_join_query_engine:> query engine response: None> query engine response: NoneFinal response: The country corresponding to each city is as follows: Toronto is in Canada, Tokyo is in Japan, and Berlin is in Germany. Unfortunately, I do not have information on the countries for New York, San Francisco, and other cities.
```

```
print(str(response))
```

```
The country corresponding to each city is as follows: Toronto is in Canada, Tokyo is in Japan, and Berlin is in Germany. Unfortunately, I do not have information on the countries for New York, San Francisco, and other cities.
```
