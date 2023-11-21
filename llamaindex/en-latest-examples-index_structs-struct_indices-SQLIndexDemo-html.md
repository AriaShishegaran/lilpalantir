[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/index_structs/struct_indices/SQLIndexDemo.ipynb)

Text-to-SQL Guide (Query Engine + Retriever)[](#text-to-sql-guide-query-engine-retriever "Permalink to this heading")
======================================================================================================================

This is a basic guide to LlamaIndex’s Text-to-SQL capabilities.

1. We first show how to perform text-to-SQL over a toy dataset: this will do “retrieval” (sql query over db) and “synthesis”.
2. We then show how to buid a TableIndex over the schema to dynamically retrieve relevant tables during query-time.
3. We finally show you how to define a text-to-SQL retriever on its own.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-.."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
# import logging# import sys# logging.basicConfig(stream=sys.stdout, level=logging.INFO)# logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from IPython.display import Markdown, display
```
Create Database Schema[](#create-database-schema "Permalink to this heading")
------------------------------------------------------------------------------

We use `sqlalchemy`, a popular SQL database toolkit, to create an empty `city\_stats` Table


```
from sqlalchemy import (    create\_engine,    MetaData,    Table,    Column,    String,    Integer,    select,)
```

```
engine = create\_engine("sqlite:///:memory:")metadata\_obj = MetaData()
```

```
# create city SQL tabletable\_name = "city\_stats"city\_stats\_table = Table(    table\_name,    metadata\_obj,    Column("city\_name", String(16), primary\_key=True),    Column("population", Integer),    Column("country", String(16), nullable=False),)metadata\_obj.create\_all(engine)
```
Define SQL Database[](#define-sql-database "Permalink to this heading")
------------------------------------------------------------------------

We first define our `SQLDatabase` abstraction (a light wrapper around SQLAlchemy).


```
from llama\_index import SQLDatabase, ServiceContextfrom llama\_index.llms import OpenAI
```

```
llm = OpenAI(temperature=0.1, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm)
```

```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```
We add some testing data to our SQL database.


```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])from sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2930000, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13960000, "country": "Japan"},    {        "city\_name": "Chicago",        "population": 2679000,        "country": "United States",    },    {"city\_name": "Seoul", "population": 9776000, "country": "South Korea"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```

```
# view current tablestmt = select(    city\_stats\_table.c.city\_name,    city\_stats\_table.c.population,    city\_stats\_table.c.country,).select\_from(city\_stats\_table)with engine.connect() as connection:    results = connection.execute(stmt).fetchall()    print(results)
```

```
[('Toronto', 2930000, 'Canada'), ('Tokyo', 13960000, 'Japan'), ('Chicago', 2679000, 'United States'), ('Seoul', 9776000, 'South Korea')]
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------

We first show how we can execute a raw SQL query, which directly executes over the table.


```
from sqlalchemy import textwith engine.connect() as con:    rows = con.execute(text("SELECT city\_name from city\_stats"))    for row in rows:        print(row)
```

```
('Chicago',)('Seoul',)('Tokyo',)('Toronto',)
```
Part 1: Text-to-SQL Query Engine[](#part-1-text-to-sql-query-engine "Permalink to this heading")
-------------------------------------------------------------------------------------------------

Once we have constructed our SQL database, we can use the NLSQLTableQueryEngine toconstruct natural language queries that are synthesized into SQL queries.

Note that we need to specify the tables we want to use with this query engine.If we don’t the query engine will pull all the schema context, which couldoverflow the context window of the LLM.


```
from llama\_index.indices.struct\_store.sql\_query import NLSQLTableQueryEnginequery\_engine = NLSQLTableQueryEngine(    sql\_database=sql\_database,    tables=["city\_stats"],)query\_str = "Which city has the highest population?"response = query\_engine.query(query\_str)
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The city with the highest population is Tokyo.**

This query engine should used in any case where you can specify the tables you wantto query over beforehand, or the total size of all the table schema plus the rest ofthe prompt fits your context window.

Part 2: Query-Time Retrieval of Tables for Text-to-SQL[](#part-2-query-time-retrieval-of-tables-for-text-to-sql "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------------

If we don’t know ahead of time which table we would like to use, and the total size ofthe table schema overflows your context window size, we should store the table schemain an index so that during query time we can retrieve the right schema.

The way we can do this is using the SQLTableNodeMapping object, which takes in aSQLDatabase and produces a Node object for each SQLTableSchema object passedinto the ObjectIndex constructor.


```
from llama\_index.indices.struct\_store.sql\_query import (    SQLTableRetrieverQueryEngine,)from llama\_index.objects import (    SQLTableNodeMapping,    ObjectIndex,    SQLTableSchema,)from llama\_index import VectorStoreIndex# set Logging to DEBUG for more detailed outputstable\_node\_mapping = SQLTableNodeMapping(sql\_database)table\_schema\_objs = [    (SQLTableSchema(table\_name="city\_stats"))]  # add a SQLTableSchema for each tableobj\_index = ObjectIndex.from\_objects(    table\_schema\_objs,    table\_node\_mapping,    VectorStoreIndex,)query\_engine = SQLTableRetrieverQueryEngine(    sql\_database, obj\_index.as\_retriever(similarity\_top\_k=1))
```
Now we can take our SQLTableRetrieverQueryEngine and query it for our response.


```
response = query\_engine.query("Which city has the highest population?")display(Markdown(f"<b>{response}</b>"))
```
**The city with the highest population is Tokyo.**


```
# you can also fetch the raw result from SQLAlchemy!response.metadata["result"]
```

```
[('Tokyo',)]
```
You can also add additional context information for each table schema you define.


```
# manually set context textcity\_stats\_text = (    "This table gives information regarding the population and country of a"    " given city.\nThe user will query with codewords, where 'foo' corresponds"    " to population and 'bar'corresponds to city.")table\_node\_mapping = SQLTableNodeMapping(sql\_database)table\_schema\_objs = [    (SQLTableSchema(table\_name="city\_stats", context\_str=city\_stats\_text))]
```
Part 3: Text-to-SQL Retriever[](#part-3-text-to-sql-retriever "Permalink to this heading")
-------------------------------------------------------------------------------------------

So far our text-to-SQL capability is packaged in a query engine and consists of both retrieval and synthesis.

You can use the SQL retriever on its own. We show you some different parameters you can try, and also show how to plug it into our `RetrieverQueryEngine` to get roughly the same results.


```
from llama\_index.retrievers import NLSQLRetriever# default retrieval (return\_raw=True)nl\_sql\_retriever = NLSQLRetriever(    sql\_database, tables=["city\_stats"], return\_raw=True)
```

```
results = nl\_sql\_retriever.retrieve(    "Return the top 5 cities (along with their populations) with the highest population.")
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor n in results:    display\_source\_node(n)
```
**Node ID:** 458f723e-f1ac-4423-917a-522a71763390  
**Similarity:** None  
**Text:** [(‘Tokyo’, 13960000), (‘Seoul’, 9776000), (‘Toronto’, 2930000), (‘Chicago’, 2679000)]  



```
# default retrieval (return\_raw=False)nl\_sql\_retriever = NLSQLRetriever(    sql\_database, tables=["city\_stats"], return\_raw=False)
```

```
results = nl\_sql\_retriever.retrieve(    "Return the top 5 cities (along with their populations) with the highest population.")
```

```
# NOTE: all the content is in the metadatafor n in results:    display\_source\_node(n, show\_source\_metadata=True)
```
**Node ID:** 7c0e4c94-c9a6-4917-aa3f-e3b3f4cbcd5c  
**Similarity:** None  
**Text:**   
**Metadata:** {‘city\_name’: ‘Tokyo’, ‘population’: 13960000}  


**Node ID:** 3c1d1caa-cec2-451e-8fd1-adc944e1d050  
**Similarity:** None  
**Text:**   
**Metadata:** {‘city\_name’: ‘Seoul’, ‘population’: 9776000}  


**Node ID:** fb9f9b25-b913-4dde-a0e3-6111f704aea9  
**Similarity:** None  
**Text:**   
**Metadata:** {‘city\_name’: ‘Toronto’, ‘population’: 2930000}  


**Node ID:** c31ba8e7-de5d-4f28-a464-5e0339547c70  
**Similarity:** None  
**Text:**   
**Metadata:** {‘city\_name’: ‘Chicago’, ‘population’: 2679000}  


### Plug into our `RetrieverQueryEngine`[](#plug-into-our-retrieverqueryengine "Permalink to this heading")

We compose our SQL Retriever with our standard `RetrieverQueryEngine` to synthesize a response. The result is roughly similar to our packaged `Text-to-SQL` query engines.


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(nl\_sql\_retriever)
```

```
response = query\_engine.query(    "Return the top 5 cities (along with their populations) with the highest population.")
```

```
print(str(response))
```

```
The top 5 cities with the highest population are:1. Tokyo - 13,960,0002. Seoul - 9,776,0003. Toronto - 2,930,0004. Chicago - 2,679,000
```
