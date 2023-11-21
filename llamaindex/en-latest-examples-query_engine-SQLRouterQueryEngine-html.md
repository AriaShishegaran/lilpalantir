[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/SQLRouterQueryEngine.ipynb)

SQL Router Query Engine[](#sql-router-query-engine "Permalink to this heading")
================================================================================

In this tutorial, we define a custom router query engine that can route to either a SQL database or a vector database.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,    SQLDatabase,    WikipediaReader,)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
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
Requirement already satisfied: wikipedia in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (1.4.0)Requirement already satisfied: requests<3.0.0,>=2.0.0 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from wikipedia) (2.28.2)Requirement already satisfied: beautifulsoup4 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from wikipedia) (4.12.2)Requirement already satisfied: idna<4,>=2.5 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.4)Requirement already satisfied: charset-normalizer<4,>=2 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.1.0)Requirement already satisfied: certifi>=2017.4.17 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (2022.12.7)Requirement already satisfied: urllib3<1.27,>=1.21.1 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (1.26.15)Requirement already satisfied: soupsieve>1.2 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from beautifulsoup4->wikipedia) (2.4.1)[notice] A new release of pip available: 22.3.1 -> 23.1.2[notice] To update, run: pip install --upgrade pip
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

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/langchain/sql_database.py:227: UserWarning: This method is deprecated - please use `get_usable_table_names`.  warnings.warn(
```
Build Vector Index[](#build-vector-index "Permalink to this heading")
----------------------------------------------------------------------


```
# build a separate vector index per city# You could also choose to define a single vector index across all docs, and annotate each chunk by metadatavector\_indices = []for wiki\_doc in wiki\_docs:    vector\_index = VectorStoreIndex.from\_documents([wiki\_doc])    vector\_indices.append(vector\_index)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 20744 tokens> [build_index_from_nodes] Total embedding token usage: 20744 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 21947 tokens> [build_index_from_nodes] Total embedding token usage: 21947 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 12786 tokens> [build_index_from_nodes] Total embedding token usage: 12786 tokens
```
Define Query Engines, Set as Tools[](#define-query-engines-set-as-tools "Permalink to this heading")
-----------------------------------------------------------------------------------------------------


```
vector\_query\_engines = [index.as\_query\_engine() for index in vector\_indices]
```

```
from llama\_index.tools.query\_engine import QueryEngineToolsql\_tool = QueryEngineTool.from\_defaults(    query\_engine=sql\_query\_engine,    description=(        "Useful for translating a natural language query into a SQL query over"        " a table containing: city\_stats, containing the population/country of"        " each city"    ),)vector\_tools = []for city, query\_engine in zip(cities, vector\_query\_engines):    vector\_tool = QueryEngineTool.from\_defaults(        query\_engine=query\_engine,        description=f"Useful for answering semantic questions about {city}",    )    vector\_tools.append(vector\_tool)
```
Define Router Query Engine[](#define-router-query-engine "Permalink to this heading")
--------------------------------------------------------------------------------------


```
from llama\_index.query\_engine.router\_query\_engine import RouterQueryEnginefrom llama\_index.selectors.llm\_selectors import LLMSingleSelectorquery\_engine = RouterQueryEngine(    selector=LLMSingleSelector.from\_defaults(),    query\_engine\_tools=([sql\_tool] + vector\_tools),)
```

```
response = query\_engine.query("Which city has the highest population?")print(str(response))
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 0: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each city.Selecting query engine 0: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each city.INFO:llama_index.indices.struct_store.sql_query:> Table desc str: Schema of table city_stats:Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .> Table desc str: Schema of table city_stats:Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 347 tokens> [query] Total LLM token usage: 347 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 0 tokens> [query] Total embedding token usage: 0 tokens Tokyo has the highest population, with 13,960,000 people.
```

```
response = query\_engine.query("Tell me about the historical museums in Berlin")print(str(response))
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 2: Useful for answering semantic questions about Berlin.Selecting query engine 2: Useful for answering semantic questions about Berlin.INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2031 tokens> [get_response] Total LLM token usage: 2031 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensBerlin is home to many historical museums, including the Altes Museum, Neues Museum, Alte Nationalgalerie, Pergamon Museum, and Bode Museum, which are all located on Museum Island. The Gemäldegalerie (Painting Gallery) focuses on the paintings of the "old masters" from the 13th to the 18th centuries, while the Neue Nationalgalerie (New National Gallery, built by Ludwig Mies van der Rohe) specializes in 20th-century European painting. The Hamburger Bahnhof, in Moabit, exhibits a major collection of modern and contemporary art. The expanded Deutsches Historisches Museum reopened in the Zeughaus with an overview of German history spanning more than a millennium. The Bauhaus Archive is a museum of 20th-century design from the famous Bauhaus school. Museum Berggruen houses the collection of noted 20th century collector Heinz Berggruen, and features an extensive assortment of works by Picasso, Matisse, Cézanne, and Giacometti, among others. The Kupferstichkabinett Berlin (Museum of Prints and Drawings) is part of the Staatlichen Museen z
```

```
response = query\_engine.query("Which countries are each city from?")print(str(response))
```

```
INFO:llama_index.query_engine.router_query_engine:Selecting query engine 0: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each city.Selecting query engine 0: Useful for translating a natural language query into a SQL query over a table containing: city_stats, containing the population/country of each city.INFO:llama_index.indices.struct_store.sql_query:> Table desc str: Schema of table city_stats:Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .> Table desc str: Schema of table city_stats:Table 'city_stats' has columns: city_name (VARCHAR(16)), population (INTEGER), country (VARCHAR(16)) and foreign keys: .INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 334 tokens> [query] Total LLM token usage: 334 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 0 tokens> [query] Total embedding token usage: 0 tokens Toronto is from Canada, Tokyo is from Japan, and Berlin is from Germany.
```
