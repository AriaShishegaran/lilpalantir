Structured Data[](#structured-data "Permalink to this heading")
================================================================

A Guide to LlamaIndex + Structured Data[](#a-guide-to-llamaindex-structured-data "Permalink to this heading")
==============================================================================================================

A lot of modern data systems depend on structured data, such as a Postgres DB or a Snowflake data warehouse.LlamaIndex provides a lot of advanced features, powered by LLM’s, to both create structured data fromunstructured data, as well as analyze this structured data through augmented text-to-SQL capabilities.

This guide helps walk through each of these capabilities. Specifically, we cover the following topics:

* **Setup**: Defining up our example SQL Table.
* **Building our Table Index**: How to go from sql database to a Table Schema Index
* **Using natural language SQL queries**: How to query our SQL database using natural language.

We will walk through a toy example table which contains city/population/country information.A notebook for this tutorial is [available here](../../examples/index_structs/struct_indices/SQLIndexDemo.html).

Setup[](#setup "Permalink to this heading")
--------------------------------------------

First, we use SQLAlchemy to setup a simple sqlite db:


```
from sqlalchemy import (    create\_engine,    MetaData,    Table,    Column,    String,    Integer,    select,    column,)engine = create\_engine("sqlite:///:memory:")metadata\_obj = MetaData()
```
We then create a toy `city\_stats` table:


```
# create city SQL tabletable\_name = "city\_stats"city\_stats\_table = Table(    table\_name,    metadata\_obj,    Column("city\_name", String(16), primary\_key=True),    Column("population", Integer),    Column("country", String(16), nullable=False),)metadata\_obj.create\_all(engine)
```
Now it’s time to insert some datapoints!

If you want to look into filling into this table by inferring structured datapointsfrom unstructured data, take a look at the below section. Otherwise, you can chooseto directly populate this table:


```
from sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2731571, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13929286, "country": "Japan"},    {"city\_name": "Berlin", "population": 600000, "country": "Germany"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```
Finally, we can wrap the SQLAlchemy engine with our SQLDatabase wrapper;this allows the db to be used within LlamaIndex:


```
from llama\_index import SQLDatabasesql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```
Natural language SQL[](#natural-language-sql "Permalink to this heading")
--------------------------------------------------------------------------

Once we have constructed our SQL database, we can use the NLSQLTableQueryEngine toconstruct natural language queries that are synthesized into SQL queries.

Note that we need to specify the tables we want to use with this query engine.If we don’t the query engine will pull all the schema context, which couldoverflow the context window of the LLM.


```
from llama\_index.indices.struct\_store import NLSQLTableQueryEnginequery\_engine = NLSQLTableQueryEngine(    sql\_database=sql\_database,    tables=["city\_stats"],)query\_str = "Which city has the highest population?"response = query\_engine.query(query\_str)
```
This query engine should used in any case where you can specify the tables you wantto query over beforehand, or the total size of all the table schema plus the rest ofthe prompt fits your context window.

Building our Table Index[](#building-our-table-index "Permalink to this heading")
----------------------------------------------------------------------------------

If we don’t know ahead of time which table we would like to use, and the total size ofthe table schema overflows your context window size, we should store the table schemain an index so that during query time we can retrieve the right schema.

The way we can do this is using the SQLTableNodeMapping object, which takes in aSQLDatabase and produces a Node object for each SQLTableSchema object passedinto the ObjectIndex constructor.


```
from llama\_index.objects import (    SQLTableNodeMapping,    ObjectIndex,    SQLTableSchema,)table\_node\_mapping = SQLTableNodeMapping(sql\_database)table\_schema\_objs = [    (SQLTableSchema(table\_name="city\_stats")),    ...,]  # one SQLTableSchema for each tableobj\_index = ObjectIndex.from\_objects(    table\_schema\_objs,    table\_node\_mapping,    VectorStoreIndex,)
```
Here you can see we define our table\_node\_mapping, and a single SQLTableSchema with the“city\_stats” table name. We pass these into the ObjectIndex constructor, along with theVectorStoreIndex class definition we want to use. This will give us a VectorStoreIndex whereeach Node contains table schema and other context information. You can also add any additionalcontext information you’d like.


```
# manually set extra context textcity\_stats\_text = (    "This table gives information regarding the population and country of a given city.\n"    "The user will query with codewords, where 'foo' corresponds to population and 'bar'"    "corresponds to city.")table\_node\_mapping = SQLTableNodeMapping(sql\_database)table\_schema\_objs = [    (SQLTableSchema(table\_name="city\_stats", context\_str=city\_stats\_text))]
```
Using natural language SQL queries[](#using-natural-language-sql-queries "Permalink to this heading")
------------------------------------------------------------------------------------------------------

Once we have defined our table schema index obj\_index, we can construct a SQLTableRetrieverQueryEngineby passing in our SQLDatabase, and a retriever constructed from our object index.


```
from llama\_index.indices.struct\_store import SQLTableRetrieverQueryEnginequery\_engine = SQLTableRetrieverQueryEngine(    sql\_database, obj\_index.as\_retriever(similarity\_top\_k=1))response = query\_engine.query("Which city has the highest population?")print(response)
```
Now when we query the retriever query engine, it will retrieve the relevant table schemaand synthesize a SQL query and a response from the results of that query.

Concluding Thoughts[](#concluding-thoughts "Permalink to this heading")
------------------------------------------------------------------------

This is it for now! We’re constantly looking for ways to improve our structured data support.If you have any questions let us know in [our Discord](https://discord.gg/dGcwcsnxhU).

Relevant Resources:

* [Airbyte SQL Index Guide](structured_data/Airbyte_demo.html)
