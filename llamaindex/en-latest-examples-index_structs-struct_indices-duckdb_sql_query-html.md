[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/index_structs/struct_indices/duckdb_sql_query.ipynb)

SQL Query Engine with LlamaIndex + DuckDB[](#sql-query-engine-with-llamaindex-duckdb "Permalink to this heading")
==================================================================================================================

This guide showcases the core LlamaIndex SQL capabilities with DuckDB.

We go through some core LlamaIndex data structures, including the `NLSQLTableQueryEngine` and `SQLTableRetrieverQueryEngine`.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
!pip install duckdb duckdb-engine
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import (    SQLDatabase,    SimpleDirectoryReader,    WikipediaReader,    Document,)from llama\_index.indices.struct\_store import (    NLSQLTableQueryEngine,    SQLTableRetrieverQueryEngine,)
```

```
from IPython.display import Markdown, display
```
Basic Text-to-SQL with our `NLSQLTableQueryEngine`[](#basic-text-to-sql-with-our-nlsqltablequeryengine "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------

In this initial example, we walk through populating a SQL database with some test datapoints, and querying it with our text-to-SQL capabilities.

### Create Database Schema + Test Data[](#create-database-schema-test-data "Permalink to this heading")

We use sqlalchemy, a popular SQL database toolkit, to connect to DuckDB and create an empty `city\_stats` Table. We then populate it with some test data.


```
from sqlalchemy import (    create\_engine,    MetaData,    Table,    Column,    String,    Integer,    select,    column,)
```

```
engine = create\_engine("duckdb:///:memory:")# uncomment to make this work with MotherDuck# engine = create\_engine("duckdb:///md:llama-index")metadata\_obj = MetaData()
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
from sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2930000, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13960000, "country": "Japan"},    {        "city\_name": "Chicago",        "population": 2679000,        "country": "United States",    },    {"city\_name": "Seoul", "population": 9776000, "country": "South Korea"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```

```
with engine.connect() as connection:    cursor = connection.exec\_driver\_sql("SELECT \* FROM city\_stats")    print(cursor.fetchall())
```

```
[('Toronto', 2930000, 'Canada'), ('Tokyo', 13960000, 'Japan'), ('Chicago', 2679000, 'United States'), ('Seoul', 9776000, 'South Korea')]
```
### Create SQLDatabase Object[](#create-sqldatabase-object "Permalink to this heading")

We first define our SQLDatabase abstraction (a light wrapper around SQLAlchemy).


```
from llama\_index import SQLDatabase
```

```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/duckdb_engine/__init__.py:162: DuckDBEngineWarning: duckdb-engine doesn't yet support reflection on indices  warnings.warn(
```
### Query Index[](#query-index "Permalink to this heading")

Here we demonstrate the capabilities of `NLSQLTableQueryEngine`, which performs text-to-SQL.

1. We construct a `NLSQLTableQueryEngine` and pass in our SQL database object.
2. We run queries against the query engine.


```
query\_engine = NLSQLTableQueryEngine(sql\_database)
```

```
response = query\_engine.query("Which city has the highest population?")
```

```
INFO:llama_index.indices.struct_store.sql_query:> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR), population (INTEGER), country (VARCHAR) and foreign keys: .> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR), population (INTEGER), country (VARCHAR) and foreign keys: .
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/langchain/sql_database.py:238: UserWarning: This method is deprecated - please use `get_usable_table_names`.  warnings.warn(
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 332 tokens> [query] Total LLM token usage: 332 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 0 tokens> [query] Total embedding token usage: 0 tokens
```

```
str(response)
```

```
' Tokyo has the highest population, with 13,960,000 people.'
```

```
response.metadata
```

```
{'result': [('Tokyo', 13960000)], 'sql_query': 'SELECT city_name, population \nFROM city_stats \nORDER BY population DESC \nLIMIT 1;'}
```
Advanced Text-to-SQL with our `SQLTableRetrieverQueryEngine`[](#advanced-text-to-sql-with-our-sqltableretrieverqueryengine "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------

In this guide, we tackle the setting where you have a large number of tables in your database, and putting all the table schemas into the prompt may overflow the text-to-SQL prompt.

We first index the schemas with our `ObjectIndex`, and then use our `SQLTableRetrieverQueryEngine` abstraction on top.


```
engine = create\_engine("duckdb:///:memory:")# uncomment to make this work with MotherDuck# engine = create\_engine("duckdb:///md:llama-index")metadata\_obj = MetaData()
```

```
# create city SQL tabletable\_name = "city\_stats"city\_stats\_table = Table(    table\_name,    metadata\_obj,    Column("city\_name", String(16), primary\_key=True),    Column("population", Integer),    Column("country", String(16), nullable=False),)all\_table\_names = ["city\_stats"]# create a ton of dummy tablesn = 100for i in range(n):    tmp\_table\_name = f"tmp\_table\_{i}"    tmp\_table = Table(        tmp\_table\_name,        metadata\_obj,        Column(f"tmp\_field\_{i}\_1", String(16), primary\_key=True),        Column(f"tmp\_field\_{i}\_2", Integer),        Column(f"tmp\_field\_{i}\_3", String(16), nullable=False),    )    all\_table\_names.append(f"tmp\_table\_{i}")metadata\_obj.create\_all(engine)
```

```
# insert dummy datafrom sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2930000, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13960000, "country": "Japan"},    {        "city\_name": "Chicago",        "population": 2679000,        "country": "United States",    },    {"city\_name": "Seoul", "population": 9776000, "country": "South Korea"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```

```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```
### Construct Object Index[](#construct-object-index "Permalink to this heading")


```
from llama\_index.indices.struct\_store import SQLTableRetrieverQueryEnginefrom llama\_index.objects import (    SQLTableNodeMapping,    ObjectIndex,    SQLTableSchema,)from llama\_index import VectorStoreIndex
```

```
table\_node\_mapping = SQLTableNodeMapping(sql\_database)table\_schema\_objs = []for table\_name in all\_table\_names:    table\_schema\_objs.append(SQLTableSchema(table\_name=table\_name))obj\_index = ObjectIndex.from\_objects(    table\_schema\_objs,    table\_node\_mapping,    VectorStoreIndex,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 6343 tokens> [build_index_from_nodes] Total embedding token usage: 6343 tokens
```
### Query Index with `SQLTableRetrieverQueryEngine`[](#query-index-with-sqltableretrieverqueryengine "Permalink to this heading")


```
query\_engine = SQLTableRetrieverQueryEngine(    sql\_database,    obj\_index.as\_retriever(similarity\_top\_k=1),)
```

```
response = query\_engine.query("Which city has the highest population?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 7 tokens> [retrieve] Total embedding token usage: 7 tokensINFO:llama_index.indices.struct_store.sql_query:> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR), population (INTEGER), country (VARCHAR) and foreign keys: .> Table desc str: Table 'city_stats' has columns: city_name (VARCHAR), population (INTEGER), country (VARCHAR) and foreign keys: .INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 337 tokens> [query] Total LLM token usage: 337 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 0 tokens> [query] Total embedding token usage: 0 tokens
```

```
response
```

```
Response(response=' The city with the highest population is Tokyo, with a population of 13,960,000.', source_nodes=[], metadata={'result': [('Tokyo', 13960000)], 'sql_query': 'SELECT city_name, population \nFROM city_stats \nORDER BY population DESC \nLIMIT 1;'})
```
