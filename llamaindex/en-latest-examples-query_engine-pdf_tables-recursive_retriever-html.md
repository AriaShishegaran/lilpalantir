Recursive Retriever + Query Engine Demo[](#recursive-retriever-query-engine-demo "Permalink to this heading")
==============================================================================================================

In this demo, we walk through a use case of showcasing our “RecursiveRetriever” module over hierarchical data.

The concept of recursive retrieval is that we not only explore the directly most relevant nodes, but also explorenode relationships to additional retrievers/query engines and execute them. For instance, a node may represent a concise summary of a structured table,and link to a SQL/Pandas query engine over that structured table. Then if the node is retrieved, we want to also query the underlying query engine for the answer.

This can be especially useful for documents with hierarchical relationships. In this example, we walk through a Wikipedia article about billionaires (in PDF form), which contains both text and a variety of embedded structured tables. We first create a Pandas query engine over each table, but also represent each table by an `IndexNode` (stores a link to the query engine); this Node is stored along with other Nodes in a vector store.

During query-time, if an `IndexNode` is fetched, then the underlying query engine/retriever will be queried.

**Notes about Setup**

We use `camelot` to extract text-based tables from PDFs.


```
import camelotfrom llama\_index import Document, SummaryIndex# https://en.wikipedia.org/wiki/The\_World%27s\_Billionairesfrom llama\_index import VectorStoreIndex, ServiceContext, LLMPredictorfrom llama\_index.query\_engine import PandasQueryEngine, RetrieverQueryEnginefrom llama\_index.retrievers import RecursiveRetrieverfrom llama\_index.schema import IndexNodefrom llama\_index.llms import OpenAIfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderfrom pathlib import Pathfrom typing import List
```
Load in Document (and Tables)[](#load-in-document-and-tables "Permalink to this heading")
------------------------------------------------------------------------------------------

We use our `PyMuPDFReader` to read in the main text of the document.

We also use `camelot` to extract some structured tables from the document


```
file\_path = "billionaires\_page.pdf"
```

```
# initialize PDF readerreader = PyMuPDFReader()
```

```
docs = reader.load(file\_path)
```

```
# use camelot to parse tablesdef get\_tables(path: str, pages: List[int]):    table\_dfs = []    for page in pages:        table\_list = camelot.read\_pdf(path, pages=str(page))        table\_df = table\_list[0].df        table\_df = (            table\_df.rename(columns=table\_df.iloc[0])            .drop(table\_df.index[0])            .reset\_index(drop=True)        )        table\_dfs.append(table\_df)    return table\_dfs
```

```
table\_dfs = get\_tables(file\_path, pages=[3, 25])
```

```
# shows list of top billionaires in 2023table\_dfs[0]
```


|  | No. | Name | Net worth\n(USD) | Age | Nationality | Primary source(s) of wealth |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 1 | Bernard Arnault &\nfamily | $211 billion | 74 | France | LVMH |
| 1 | 2 | Elon Musk | $180 billion | 51 | United\nStates | Tesla, SpaceX, X Corp. |
| 2 | 3 | Jeff Bezos | $114 billion | 59 | United\nStates | Amazon |
| 3 | 4 | Larry Ellison | $107 billion | 78 | United\nStates | Oracle Corporation |
| 4 | 5 | Warren Buffett | $106 billion | 92 | United\nStates | Berkshire Hathaway |
| 5 | 6 | Bill Gates | $104 billion | 67 | United\nStates | Microsoft |
| 6 | 7 | Michael Bloomberg | $94.5 billion | 81 | United\nStates | Bloomberg L.P. |
| 7 | 8 | Carlos Slim & family | $93 billion | 83 | Mexico | Telmex, América Móvil, Grupo\nCarso |
| 8 | 9 | Mukesh Ambani | $83.4 billion | 65 | India | Reliance Industries |
| 9 | 10 | Steve Ballmer | $80.7 billion | 67 | United\nStates | Microsoft |


```
# shows list of top billionairestable\_dfs[1]
```


|  | Year | Number of billionaires | Group's combined net worth |
| --- | --- | --- | --- |
| 0 | 2023[2] | 2,640 | $12.2 trillion |
| 1 | 2022[6] | 2,668 | $12.7 trillion |
| 2 | 2021[11] | 2,755 | $13.1 trillion |
| 3 | 2020 | 2,095 | $8.0 trillion |
| 4 | 2019 | 2,153 | $8.7 trillion |
| 5 | 2018 | 2,208 | $9.1 trillion |
| 6 | 2017 | 2,043 | $7.7 trillion |
| 7 | 2016 | 1,810 | $6.5 trillion |
| 8 | 2015[18] | 1,826 | $7.1 trillion |
| 9 | 2014[67] | 1,645 | $6.4 trillion |
| 10 | 2013[68] | 1,426 | $5.4 trillion |
| 11 | 2012 | 1,226 | $4.6 trillion |
| 12 | 2011 | 1,210 | $4.5 trillion |
| 13 | 2010 | 1,011 | $3.6 trillion |
| 14 | 2009 | 793 | $2.4 trillion |
| 15 | 2008 | 1,125 | $4.4 trillion |
| 16 | 2007 | 946 | $3.5 trillion |
| 17 | 2006 | 793 | $2.6 trillion |
| 18 | 2005 | 691 | $2.2 trillion |
| 19 | 2004 | 587 | $1.9 trillion |
| 20 | 2003 | 476 | $1.4 trillion |
| 21 | 2002 | 497 | $1.5 trillion |
| 22 | 2001 | 538 | $1.8 trillion |
| 23 | 2000 | 470 | $898 billion |
| 24 | Sources: Forbes.[18][67][66][68] |  |  |

Create Pandas Query Engines[](#create-pandas-query-engines "Permalink to this heading")
----------------------------------------------------------------------------------------

We create a pandas query engine over each structured table.

These can be executed on their own to answer queries about each table.


```
# define query engines over these tablesllm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)df\_query\_engines = [    PandasQueryEngine(table\_df, service\_context=service\_context)    for table\_df in table\_dfs]
```

```
response = df\_query\_engines[0].query(    "What's the net worth of the second richest billionaire in 2023?")print(str(response))
```

```
$180 billion
```

```
response = df\_query\_engines[1].query(    "How many billionaires were there in 2009?")print(str(response))
```

```
793
```
Build Vector Index[](#build-vector-index "Permalink to this heading")
----------------------------------------------------------------------

Build vector index over the chunked document as well as over the additional `IndexNode` objects linked to the tables.


```
llm = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(    llm=llm,)
```

```
doc\_nodes = service\_context.node\_parser.get\_nodes\_from\_documents(docs)
```

```
# define index nodessummaries = [    (        "This node provides information about the world's richest billionaires"        " in 2023"    ),    (        "This node provides information on the number of billionaires and"        " their combined net worth from 2000 to 2023."    ),]df\_nodes = [    IndexNode(text=summary, index\_id=f"pandas{idx}")    for idx, summary in enumerate(summaries)]df\_id\_query\_engine\_mapping = {    f"pandas{idx}": df\_query\_engine    for idx, df\_query\_engine in enumerate(df\_query\_engines)}
```

```
# construct top-level vector index + query enginevector\_index = VectorStoreIndex(doc\_nodes + df\_nodes)vector\_retriever = vector\_index.as\_retriever(similarity\_top\_k=1)
```
Use `RecursiveRetriever` in our `RetrieverQueryEngine`[](#use-recursiveretriever-in-our-retrieverqueryengine "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------

We define a `RecursiveRetriever` object to recursively retrieve/query nodes. We then put this in our `RetrieverQueryEngine` along with a `ResponseSynthesizer` to synthesize a response.

We pass in mappings from id to retriever and id to query engine. We then pass in a root id representing the retriever we query first.


```
# baseline vector index (that doesn't include the extra df nodes).# used to benchmarkvector\_index0 = VectorStoreIndex(doc\_nodes)vector\_query\_engine0 = vector\_index0.as\_query\_engine()
```

```
from llama\_index.retrievers import RecursiveRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom llama\_index.response\_synthesizers import get\_response\_synthesizerrecursive\_retriever = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever},    query\_engine\_dict=df\_id\_query\_engine\_mapping,    verbose=True,)response\_synthesizer = get\_response\_synthesizer(    # service\_context=service\_context,    response\_mode="compact")query\_engine = RetrieverQueryEngine.from\_args(    recursive\_retriever, response\_synthesizer=response\_synthesizer)
```

```
response = query\_engine.query(    "What's the net worth of the second richest billionaire in 2023?")
```

```
Retrieving with query id None: What's the net worth of the second richest billionaire in 2023?Retrieved node with id, entering: pandas0Retrieving with query id pandas0: What's the net worth of the second richest billionaire in 2023?Got response: $180 billion
```

```
response.source\_nodes[0].node.get\_content()
```

```
"Query: What's the net worth of the second richest billionaire in 2023?\nResponse: $180\xa0billion"
```

```
str(response)
```

```
'$180 billion.'
```

```
response = query\_engine.query("How many billionaires were there in 2009?")
```

```
Retrieving with query id None: How many billionaires were there in 2009?Retrieved node with id, entering: pandas1Retrieving with query id pandas1: How many billionaires were there in 2009?Got response: 793
```

```
str(response)
```

```
'793'
```

```
response = vector\_query\_engine0.query(    "How many billionaires were there in 2009?")
```

```
print(response.source\_nodes[0].node.get\_content())
```

```
print(str(response))
```

```
Based on the context information, it is not possible to determine the exact number of billionaires in 2009. The provided information only mentions the number of billionaires in 2013 and 2014.
```

```
response.source\_nodes[0].node.get\_content()
```

```
response = query\_engine.query(    "Which billionaires are excluded from this list?")
```

```
print(str(response))
```

```
Royal families and dictators whose wealth is contingent on a position are excluded from this list.
```
