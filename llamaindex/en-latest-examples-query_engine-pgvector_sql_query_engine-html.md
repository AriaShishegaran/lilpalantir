[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/pgvector_sql_query_engine.ipynb)

[Beta] Text-to-SQL with PGVector[](#beta-text-to-sql-with-pgvector "Permalink to this heading")
================================================================================================

This notebook demo shows how to perform text-to-SQL with pgvector. This allows us to jointly do both semantic search and structured querying, *all* within SQL!

This hypothetically enables more expressive queries than semantic search + metadata filters.

**NOTE**: This is a beta feature, interfaces might change. But in the meantime hope you find it useful!

Setup Data[](#setup-data "Permalink to this heading")
------------------------------------------------------

### Load Documents[](#load-documents "Permalink to this heading")

Load in the Lyft 2021 10k document.


```
from llama\_hub.file.pdf.base import PDFReader
```

```
reader = PDFReader()
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
docs = reader.load\_data("./data/10k/lyft\_2021.pdf")
```

```
from llama\_index.node\_parser import SimpleNodeParsernode\_parser = SimpleNodeParser.from\_defaults()nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
print(nodes[8].get\_content(metadata\_mode="all"))
```
### Insert data into Postgres + PGVector[](#insert-data-into-postgres-pgvector "Permalink to this heading")

Make sure you have all the necessary dependencies installed!


```
!pip install psycopg2-binary pgvector asyncpg "sqlalchemy[asyncio]" greenlet
```

```
from pgvector.sqlalchemy import Vectorfrom sqlalchemy import insert, create\_engine, String, text, Integerfrom sqlalchemy.orm import declarative\_base, mapped\_column
```
#### Establish Connection[](#establish-connection "Permalink to this heading")


```
engine = create\_engine("postgresql+psycopg2://localhost/postgres")with engine.connect() as conn:    conn.execute(text("CREATE EXTENSION IF NOT EXISTS vector"))    conn.commit()
```
#### Define Table Schema[](#define-table-schema "Permalink to this heading")

Define as Python class. Note we store the page\_label, embedding, and text.


```
Base = declarative\_base()class SECTextChunk(Base):    \_\_tablename\_\_ = "sec\_text\_chunk"    id = mapped\_column(Integer, primary\_key=True)    page\_label = mapped\_column(Integer)    file\_name = mapped\_column(String)    text = mapped\_column(String)    embedding = mapped\_column(Vector(384))
```

```
Base.metadata.drop\_all(engine)Base.metadata.create\_all(engine)
```
#### Generate embedding for each Node with a sentence\_transformers model[](#generate-embedding-for-each-node-with-a-sentence-transformers-model "Permalink to this heading")


```
# get embeddings for each rowfrom llama\_index.embeddings import HuggingFaceEmbeddingembed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en")for node in nodes:    text\_embedding = embed\_model.get\_text\_embedding(node.get\_content())    node.embedding = text\_embedding
```
#### Insert into Database[](#insert-into-database "Permalink to this heading")


```
# insert into databasefor node in nodes:    row\_dict = {        "text": node.get\_content(),        "embedding": node.embedding,        \*\*node.metadata,    }    stmt = insert(SECTextChunk).values(\*\*row\_dict)    with engine.connect() as connection:        cursor = connection.execute(stmt)        connection.commit()
```
Define PGVectorSQLQueryEngine[](#define-pgvectorsqlqueryengine "Permalink to this heading")
--------------------------------------------------------------------------------------------

Now that we’ve loaded the data into the database, we’re ready to setup our query engine.

### Define Prompt[](#define-prompt "Permalink to this heading")

We create a modified version of our default text-to-SQL prompt to inject awareness of the pgvector syntax.We also prompt it with some few-shot examples of how to use the syntax (<–>).

**NOTE**: This is included by default in the `PGVectorSQLQueryEngine`, we included it here mostly for visibility!


```
from llama\_index.prompts import PromptTemplatetext\_to\_sql\_tmpl = """\Given an input question, first create a syntactically correct {dialect} \query to run, then look at the results of the query and return the answer. \You can order the results by a relevant column to return the most \interesting examples in the database.Pay attention to use only the column names that you can see in the schema \description. Be careful to not query for columns that do not exist. \Pay attention to which column is in which table. Also, qualify column names \with the table name when needed. IMPORTANT NOTE: you can use specialized pgvector syntax (`<->`) to do nearest \neighbors/semantic search to a given vector from an embeddings column in the table. \The embeddings value for a given row typically represents the semantic meaning of that row. \The vector represents an embedding representation \of the question, given below. Do NOT fill in the vector values directly, but rather specify a \`[query\_vector]` placeholder. For instance, some select statement examples below \(the name of the embeddings column is `embedding`):SELECT \* FROM items ORDER BY embedding <-> '[query\_vector]' LIMIT 5;SELECT \* FROM items WHERE id != 1 ORDER BY embedding <-> (SELECT embedding FROM items WHERE id = 1) LIMIT 5;SELECT \* FROM items WHERE embedding <-> '[query\_vector]' < 5;You are required to use the following format, \each taking one line:Question: Question hereSQLQuery: SQL Query to runSQLResult: Result of the SQLQueryAnswer: Final answer hereOnly use tables listed below.{schema}Question: {query\_str}SQLQuery: \"""text\_to\_sql\_prompt = PromptTemplate(text\_to\_sql\_tmpl)
```
### Setup LLM, Embedding Model, and Misc.[](#setup-llm-embedding-model-and-misc "Permalink to this heading")

Besides LLM and embedding model, note we also add annotations on the table itself. This better helps the LLMunderstand the column schema (e.g. by telling it what the embedding column represents) to better doeither tabular querying or semantic search.


```
from llama\_index import ServiceContext, SQLDatabasefrom llama\_index.llms import OpenAIfrom llama\_index.query\_engine import PGVectorSQLQueryEnginesql\_database = SQLDatabase(engine, include\_tables=["sec\_text\_chunk"])llm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)table\_desc = """\This table represents text chunks from an SEC filing. Each row contains the following columns:id: id of rowpage\_label: page number file\_name: top-level file nametext: all text chunk is hereembedding: the embeddings representing the text chunkFor most queries you should perform semantic search against the `embedding` column values, since \that encodes the meaning of the text."""context\_query\_kwargs = {"sec\_text\_chunk": table\_desc}
```
### Define Query Engine[](#define-query-engine "Permalink to this heading")


```
query\_engine = PGVectorSQLQueryEngine(    sql\_database=sql\_database,    text\_to\_sql\_prompt=text\_to\_sql\_prompt,    service\_context=service\_context,    context\_query\_kwargs=context\_query\_kwargs,)
```
Run Some Queries[](#run-some-queries "Permalink to this heading")
------------------------------------------------------------------

Now we’re ready to run some queries


```
response = query\_engine.query(    "Can you tell me about the risk factors described in page 6?",)
```

```
print(str(response))
```

```
Page 6 discusses the impact of the COVID-19 pandemic on the business. It mentions that the pandemic has affected communities in the United States, Canada, and globally. The pandemic has led to a significant decrease in the demand for ridesharing services, which has negatively impacted the company's financial performance. The page also discusses the company's efforts to adapt to the changing environment by focusing on the delivery of essential goods and services. Additionally, it mentions the company's transportation network, which offers riders seamless, personalized, and on-demand access to a variety of mobility options.
```

```
print(response.metadata["sql\_query"])
```

```
response = query\_engine.query(    "Tell me more about Lyft's real estate operating leases",)
```

```
print(str(response))
```

```
Lyft's lease arrangements include vehicle rental programs, office space, and data centers. Leases that do not meet any specific criteria are accounted for as operating leases. The lease term begins when Lyft is available to use the underlying asset and ends upon the termination of the lease. The lease term includes any periods covered by an option to extend if Lyft is reasonably certain to exercise that option. Leasehold improvements are amortized on a straight-line basis over the shorter of the term of the lease, or the useful life of the assets.
```

```
print(response.metadata["sql\_query"][:300])
```

```
SELECT * FROM sec_text_chunk WHERE text LIKE '%Lyft%' AND text LIKE '%real estate%' AND text LIKE '%operating leases%' ORDER BY embedding <-> '[-0.007079003844410181, -0.04383348673582077, 0.02910166047513485, 0.02049737051129341, 0.009460929781198502, -0.017539210617542267, 0.04225028306245804, 0.0
```

```
# looked at returned resultprint(response.metadata["result"])
```

```
[(157, 93, 'lyft_2021.pdf', "Leases that do not meet any of the above criteria are accounted for as operating leases.Lessor\nThe\n Company's lease arrangements include vehicle re ... (4356 characters truncated) ...  realized. Leasehold improvements are amortized on a straight-line basis over the shorter of the term of the lease, or the useful life of the assets.", '[0.017818017,-0.024016099,0.0042511695,0.03114478,0.003591422,-0.0097886855,0.02455732,0.013048866,0.018157514,-0.009401044,0.031699456,0.01678178,0. ... (4472 characters truncated) ... 6,0.01127416,0.045080125,-0.017046565,-0.028544193,-0.016320521,0.01062995,-0.021007432,-0.006999497,-0.08426073,-0.014918887,0.059064835,0.03307945]')]
```

```
# structured queryresponse = query\_engine.query(    "Tell me about the max page number in this table",)
```

```
print(str(response))
```

```
The maximum page number in this table is 238.
```

```
print(response.metadata["sql\_query"][:300])
```

```
SELECT MAX(page_label) FROM sec_text_chunk;
```
