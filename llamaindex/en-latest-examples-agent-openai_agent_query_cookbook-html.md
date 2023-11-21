[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent_query_cookbook.ipynb)

OpenAI Agent + Query Engine Experimental Cookbook[](#openai-agent-query-engine-experimental-cookbook "Permalink to this heading")
==================================================================================================================================

In this notebook, we try out the OpenAIAgent across a variety of query engine tools and datasets. We explore how OpenAIAgent can compare/replace existing workflows solved by our retrievers/query engines.

* Auto retrieval
* Joint SQL and vector search

AutoRetrieval from a Vector Database[](#autoretrieval-from-a-vector-database "Permalink to this heading")
----------------------------------------------------------------------------------------------------------

Our existing “auto-retrieval” capabilities (in `VectorIndexAutoRetriever`) allow an LLM to infer the right query parameters for a vector database - including both the query string and metadata filter.

Since the OpenAI Function API can infer function parameters, we explore its capabilities in performing auto-retrieval here.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp")
```

```
# dimensions are for text-embedding-ada-002try:    pinecone.create\_index(        "quickstart", dimension=1536, metric="euclidean", pod\_type="p1"    )except Exception:    # most likely index already exists    pass
```

```
pinecone\_index = pinecone.Index("quickstart")
```

```
# Optional: delete data in your pinecone indexpinecone\_index.delete(deleteAll=True, namespace="test")
```

```
{}
```

```
from llama\_index import VectorStoreIndex, StorageContextfrom llama\_index.vector\_stores import PineconeVectorStore
```

```
from llama\_index.schema import TextNodenodes = [    TextNode(        text=(            "Michael Jordan is a retired professional basketball player,"            " widely regarded as one of the greatest basketball players of all"            " time."        ),        metadata={            "category": "Sports",            "country": "United States",        },    ),    TextNode(        text=(            "Angelina Jolie is an American actress, filmmaker, and"            " humanitarian. She has received numerous awards for her acting"            " and is known for her philanthropic work."        ),        metadata={            "category": "Entertainment",            "country": "United States",        },    ),    TextNode(        text=(            "Elon Musk is a business magnate, industrial designer, and"            " engineer. He is the founder, CEO, and lead designer of SpaceX,"            " Tesla, Inc., Neuralink, and The Boring Company."        ),        metadata={            "category": "Business",            "country": "United States",        },    ),    TextNode(        text=(            "Rihanna is a Barbadian singer, actress, and businesswoman. She"            " has achieved significant success in the music industry and is"            " known for her versatile musical style."        ),        metadata={            "category": "Music",            "country": "Barbados",        },    ),    TextNode(        text=(            "Cristiano Ronaldo is a Portuguese professional footballer who is"            " considered one of the greatest football players of all time. He"            " has won numerous awards and set multiple records during his"            " career."        ),        metadata={            "category": "Sports",            "country": "Portugal",        },    ),]
```

```
vector\_store = PineconeVectorStore(    pinecone\_index=pinecone\_index, namespace="test")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)
```

```
index = VectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
Upserted vectors: 100%|███████████████████████████████████████████████████| 5/5 [00:00<00:00,  9.61it/s]
```
### Define Function Tool[](#define-function-tool "Permalink to this heading")

Here we define the function interface, which is passed to OpenAI to perform auto-retrieval.

We were not able to get OpenAI to work with nested pydantic objects or tuples as arguments,so we converted the metadata filter keys and values into lists for the function API to work with.


```
# define function toolfrom llama\_index.tools import FunctionToolfrom llama\_index.vector\_stores.types import (    VectorStoreInfo,    MetadataInfo,    ExactMatchFilter,    MetadataFilters,)from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom typing import List, Tuple, Anyfrom pydantic import BaseModel, Field# hardcode top k for nowtop\_k = 3# define vector store info describing schema of vector storevector\_store\_info = VectorStoreInfo(    content\_info="brief biography of celebrities",    metadata\_info=[        MetadataInfo(            name="category",            type="str",            description=(                "Category of the celebrity, one of [Sports, Entertainment,"                " Business, Music]"            ),        ),        MetadataInfo(            name="country",            type="str",            description=(                "Country of the celebrity, one of [United States, Barbados,"                " Portugal]"            ),        ),    ],)# define pydantic model for auto-retrieval functionclass AutoRetrieveModel(BaseModel):    query: str = Field(..., description="natural language query string")    filter\_key\_list: List[str] = Field(        ..., description="List of metadata filter field names"    )    filter\_value\_list: List[str] = Field(        ...,        description=(            "List of metadata filter field values (corresponding to names"            " specified in filter\_key\_list)"        ),    )def auto\_retrieve\_fn(    query: str, filter\_key\_list: List[str], filter\_value\_list: List[str]): """Auto retrieval function. Performs auto-retrieval from a vector database, and then applies a set of filters. """    query = query or "Query"    exact\_match\_filters = [        ExactMatchFilter(key=k, value=v)        for k, v in zip(filter\_key\_list, filter\_value\_list)    ]    retriever = VectorIndexRetriever(        index,        filters=MetadataFilters(filters=exact\_match\_filters),        top\_k=top\_k,    )    query\_engine = RetrieverQueryEngine.from\_args(retriever)    response = query\_engine.query(query)    return str(response)description = f"""\Use this tool to look up biographical information about celebrities.The vector database schema is given below:{vector\_store\_info.json()}"""auto\_retrieve\_tool = FunctionTool.from\_defaults(    fn=auto\_retrieve\_fn,    name="celebrity\_bios",    description=description,    fn\_schema=AutoRetrieveModel,)
```
### Initialize Agent[](#initialize-agent "Permalink to this heading")


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAIagent = OpenAIAgent.from\_tools(    [auto\_retrieve\_tool],    llm=OpenAI(temperature=0, model="gpt-4-0613"),    verbose=True,)
```

```
response = agent.chat("Tell me about two celebrities from the United States. ")print(str(response))
```

```
=== Calling Function ===Calling function: celebrity_bios with args: {  "query": "celebrities",  "filter_key_list": ["country"],  "filter_value_list": ["United States"]}Got output: Celebrities in the United States who are associated with Entertainment and Sports include Angelina Jolie and Michael Jordan.========================Angelina Jolie is an American actress, filmmaker, and humanitarian. She has received an Academy Award and three Golden Globe Awards, and has been cited as Hollywood's highest-paid actress. Jolie made her screen debut as a child alongside her father, Jon Voight, in Lookin' to Get Out (1982), and her film career began in earnest a decade later with the low-budget production Cyborg 2 (1993), followed by her first leading role in a major film, Hackers (1995).Michael Jordan is a retired professional basketball player from the United States. He is widely regarded as one of the greatest basketball players in history. Jordan was one of the most effectively marketed athletes of his generation and was instrumental in popularizing the NBA around the world in the 1980s and 1990s. He played 15 seasons in the NBA, winning six championships with the Chicago Bulls.
```
Joint Text-to-SQL and Semantic Search[](#joint-text-to-sql-and-semantic-search "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

This is currenty handled by our `SQLAutoVectorQueryEngine`.

Let’s try implementing this by giving our `OpenAIAgent` access to two query tools: SQL and Vector

### Load and Index Structured Data[](#load-and-index-structured-data "Permalink to this heading")

We load sample structured datapoints into a SQL db and index it.


```
from sqlalchemy import (    create\_engine,    MetaData,    Table,    Column,    String,    Integer,    select,    column,)from llama\_index import SQLDatabase, SQLStructStoreIndexengine = create\_engine("sqlite:///:memory:", future=True)metadata\_obj = MetaData()
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

```
from sqlalchemy import insertrows = [    {"city\_name": "Toronto", "population": 2930000, "country": "Canada"},    {"city\_name": "Tokyo", "population": 13960000, "country": "Japan"},    {"city\_name": "Berlin", "population": 3645000, "country": "Germany"},]for row in rows:    stmt = insert(city\_stats\_table).values(\*\*row)    with engine.begin() as connection:        cursor = connection.execute(stmt)
```

```
with engine.connect() as connection:    cursor = connection.exec\_driver\_sql("SELECT \* FROM city\_stats")    print(cursor.fetchall())
```

```
[('Toronto', 2930000, 'Canada'), ('Tokyo', 13960000, 'Japan'), ('Berlin', 3645000, 'Germany')]
```

```
sql\_database = SQLDatabase(engine, include\_tables=["city\_stats"])
```

```
from llama\_index.indices.struct\_store.sql\_query import NLSQLTableQueryEngine
```

```
query\_engine = NLSQLTableQueryEngine(    sql\_database=sql\_database,    tables=["city\_stats"],)
```
### Load and Index Unstructured Data[](#load-and-index-unstructured-data "Permalink to this heading")

We load unstructured data into a vector index backed by Pinecone


```
# install wikipedia python package!pip install wikipedia
```

```
Requirement already satisfied: wikipedia in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (1.4.0)Requirement already satisfied: requests<3.0.0,>=2.0.0 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from wikipedia) (2.28.2)Requirement already satisfied: beautifulsoup4 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from wikipedia) (4.12.2)Requirement already satisfied: charset-normalizer<4,>=2 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.1.0)Requirement already satisfied: idna<4,>=2.5 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (3.4)Requirement already satisfied: certifi>=2017.4.17 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (2022.12.7)Requirement already satisfied: urllib3<1.27,>=1.21.1 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from requests<3.0.0,>=2.0.0->wikipedia) (1.26.15)Requirement already satisfied: soupsieve>1.2 in /Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages (from beautifulsoup4->wikipedia) (2.4.1)[notice] A new release of pip available: 22.3.1 -> 23.1.2[notice] To update, run: pip install --upgrade pip
```

```
from llama\_index import (    WikipediaReader,    SimpleDirectoryReader,    VectorStoreIndex,)
```

```
cities = ["Toronto", "Berlin", "Tokyo"]wiki\_docs = WikipediaReader().load\_data(pages=cities)
```

```
# define pinecone indeximport pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp")# dimensions are for text-embedding-ada-002# pinecone.create\_index("quickstart", dimension=1536, metric="euclidean", pod\_type="p1")pinecone\_index = pinecone.Index("quickstart")
```

```
# OPTIONAL: delete allpinecone\_index.delete(deleteAll=True)
```

```
{}
```

```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index import ServiceContextfrom llama\_index.storage import StorageContextfrom llama\_index.vector\_stores import PineconeVectorStorefrom llama\_index.text\_splitter import TokenTextSplitterfrom llama\_index.llms import OpenAI# define node parser and LLMchunk\_size = 1024llm = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(chunk\_size=chunk\_size, llm=llm)text\_splitter = TokenTextSplitter(chunk\_size=chunk\_size)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)# define pinecone vector indexvector\_store = PineconeVectorStore(    pinecone\_index=pinecone\_index, namespace="wiki\_cities")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)vector\_index = VectorStoreIndex([], storage\_context=storage\_context)
```

```
# Insert documents into vector index# Each document has metadata of the city attachedfor city, wiki\_doc in zip(cities, wiki\_docs):    nodes = node\_parser.get\_nodes\_from\_documents([wiki\_doc])    # add metadata to each node    for node in nodes:        node.metadata = {"title": city}    vector\_index.insert\_nodes(nodes)
```

```
Upserted vectors: 100%|█████████████████████████████████████████████████| 20/20 [00:00<00:00, 38.13it/s]Upserted vectors: 100%|████████████████████████████████████████████████| 21/21 [00:00<00:00, 101.89it/s]Upserted vectors: 100%|█████████████████████████████████████████████████| 13/13 [00:00<00:00, 97.91it/s]
```
### Define Query Engines / Tools[](#define-query-engines-tools "Permalink to this heading")


```
from llama\_index.query\_engine import (    SQLAutoVectorQueryEngine,    RetrieverQueryEngine,)from llama\_index.tools.query\_engine import QueryEngineToolfrom llama\_index.indices.vector\_store import VectorIndexAutoRetriever
```

```
from llama\_index.indices.vector\_store.retrievers import (    VectorIndexAutoRetriever,)from llama\_index.vector\_stores.types import MetadataInfo, VectorStoreInfofrom llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)vector\_store\_info = VectorStoreInfo(    content\_info="articles about different cities",    metadata\_info=[        MetadataInfo(            name="title", type="str", description="The name of the city"        ),    ],)vector\_auto\_retriever = VectorIndexAutoRetriever(    vector\_index, vector\_store\_info=vector\_store\_info)retriever\_query\_engine = RetrieverQueryEngine.from\_args(    vector\_auto\_retriever, service\_context=service\_context)
```

```
sql\_tool = QueryEngineTool.from\_defaults(    query\_engine=query\_engine,    name="sql\_tool",    description=(        "Useful for translating a natural language query into a SQL query over"        " a table containing: city\_stats, containing the population/country of"        " each city"    ),)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=retriever\_query\_engine,    name="vector\_tool",    description=(        f"Useful for answering semantic questions about different cities"    ),)
```
### Initialize Agent[](#id1 "Permalink to this heading")


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAIagent = OpenAIAgent.from\_tools(    [sql\_tool, vector\_tool],    llm=OpenAI(temperature=0, model="gpt-4-0613"),    verbose=True,)
```

```
# NOTE: gpt-3.5 gives the wrong answer, but gpt-4 is able to reason over both loopsresponse = agent.chat(    "Tell me about the arts and culture of the city with the highest"    " population")print(str(response))
```

```
=== Calling Function ===Calling function: sql_tool with args: {  "input": "SELECT city FROM city_stats ORDER BY population DESC LIMIT 1"}Got output:  The city with the highest population is Tokyo.=========================== Calling Function ===Calling function: vector_tool with args: {  "input": "Tell me about the arts and culture of Tokyo"}Got output: Tokyo has a rich arts and culture scene, with many theaters for performing arts, including national and private theaters for traditional forms of Japanese drama. Noteworthy theaters are the National Noh Theatre for noh and the Kabuki-za for Kabuki. Symphony orchestras and other musical organizations perform modern and traditional music. The New National Theater Tokyo in Shibuya is the national center for the performing arts, including opera, ballet, contemporary dance, and drama. Tokyo also hosts modern Japanese and international pop and rock music at various venues, ranging from intimate clubs to internationally known areas such as the Nippon Budokan.Many different festivals occur throughout Tokyo, with major events including the Sannō at Hie Shrine, the Sanja at Asakusa Shrine, and the biennial Kanda Festivals. Annually on the last Saturday of July, a massive fireworks display over the Sumida River attracts over a million viewers. Once cherry blossoms bloom in spring, residents gather in Ueno Park, Inokashira Park, and the Shinjuku Gyoen National Garden for picnics under the blossoms. Harajuku, a neighborhood in Shibuya, is known internationally for its youth style, fashion, and cosplay.Tokyo is also renowned for its fine dining, with Michelin awarding a significant number of stars to the city's restaurants. As of 2017, 227 restaurants in Tokyo have been awarded Michelin stars, surpassing the number awarded in Paris.========================Tokyo, the city with the highest population, has a rich arts and culture scene. It is home to many theaters for performing arts, including national and private theaters for traditional forms of Japanese drama such as Noh and Kabuki. The New National Theater Tokyo in Shibuya is the national center for the performing arts, including opera, ballet, contemporary dance, and drama.Tokyo also hosts modern Japanese and international pop and rock music at various venues, ranging from intimate clubs to internationally known areas such as the Nippon Budokan.The city is known for its festivals, with major events including the Sannō at Hie Shrine, the Sanja at Asakusa Shrine, and the biennial Kanda Festivals. Once cherry blossoms bloom in spring, residents gather in Ueno Park, Inokashira Park, and the Shinjuku Gyoen National Garden for picnics under the blossoms.Harajuku, a neighborhood in Shibuya, is known internationally for its youth style, fashion, and cosplay. Tokyo is also renowned for its fine dining, with Michelin awarding a significant number of stars to the city's restaurants. As of 2017, 227 restaurants in Tokyo have been awarded Michelin stars, surpassing the number awarded in Paris.
```

```
response = agent.chat("Tell me about the history of Berlin")print(str(response))
```

```
=== Calling Function ===Calling function: vector_tool with args: {  "input": "Tell me about the history of Berlin"}Got output: Berlin's history dates back to the 15th century when it was established as the capital of the Margraviate of Brandenburg. The Hohenzollern family ruled Berlin until 1918, first as electors of Brandenburg, then as kings of Prussia, and eventually as German emperors. In 1443, Frederick II Irontooth started the construction of a new royal palace in the twin city Berlin-Cölln, which later became the permanent residence of the Brandenburg electors of the Hohenzollerns.The Thirty Years' War between 1618 and 1648 devastated Berlin, with the city losing half of its population. Frederick William, known as the "Great Elector", initiated a policy of promoting immigration and religious tolerance. In 1701, the dual state of the Margraviate of Brandenburg and the Duchy of Prussia formed the Kingdom of Prussia, with Berlin as its capital. Under the rule of Frederick II, Berlin became a center of the Enlightenment.The Industrial Revolution in the 19th century transformed Berlin, expanding its economy and population. In 1871, Berlin became the capital of the newly founded German Empire. The early 20th century saw Berlin as a fertile ground for the German Expressionist movement. At the end of the First World War in 1918, a republic was proclaimed, and in 1920, the Greater Berlin Act incorporated dozens of suburban cities, villages, and estates around Berlin.========================
```

```
Response(response='Berlin\'s history dates back to the 15th century when it was established as the capital of the Margraviate of Brandenburg. The Hohenzollern family ruled Berlin until 1918, first as electors of Brandenburg, then as kings of Prussia, and eventually as German emperors. In 1443, Frederick II Irontooth started the construction of a new royal palace in the twin city Berlin-Cölln.\n\nThe Thirty Years\' War between 1618 and 1648 devastated Berlin, with the city losing half of its population. Frederick William, known as the "Great Elector", initiated a policy of promoting immigration and religious tolerance. In 1701, the dual state of the Margraviate of Brandenburg and the Duchy of Prussia formed the Kingdom of Prussia, with Berlin as its capital. Under the rule of Frederick II, Berlin became a center of the Enlightenment.\n\nThe Industrial Revolution in the 19th century transformed Berlin, expanding its economy and population. In 1871, Berlin became the capital of the newly founded German Empire. The early 20th century saw Berlin as a fertile ground for the German Expressionist movement. At the end of the First World War in 1918, a republic was proclaimed, and in 1920, the Greater Berlin Act incorporated dozens of suburban cities, villages, and estates around Berlin.', source_nodes=[], extra_info=None)
```

```
response = agent.chat(    "Can you give me the country corresponding to each city?")print(str(response))
```

```
=== Calling Function ===Calling function: sql_tool with args: {  "input": "SELECT city, country FROM city_stats"}Got output:  The cities Toronto, Tokyo, and Berlin are located in the countries Canada, Japan, and Germany respectively.========================
```

```
Response(response='Sure, here are the countries corresponding to each city:\n\n- Toronto is in Canada\n- Tokyo is in Japan\n- Berlin is in Germany', source_nodes=[], extra_info=None)
```
