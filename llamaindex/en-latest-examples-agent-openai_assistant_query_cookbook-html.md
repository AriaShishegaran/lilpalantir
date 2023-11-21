[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_assistant_query_cookbook.ipynb)

OpenAI Assistant Advanced Retrieval Cookbook[](#openai-assistant-advanced-retrieval-cookbook "Permalink to this heading")
==========================================================================================================================

In this notebook, we try out OpenAI Assistant API for advanced retrieval tasks, by plugging in a variety of query engine tools and datasets. The wrapper abstraction we use is our `OpenAIAssistantAgent` class, which allows us to plug in custom tools. We explore how `OpenAIAssistant` can complement/replace existing workflows solved by our retrievers/query engines through its agent execution + function calling loop.

* Joint QA + Summarization
* Auto retrieval
* Joint SQL and vector search


```
!pip install llama-index
```

```
import nest\_asyncionest\_asyncio.apply()
```
Joint QA and Summarization[](#joint-qa-and-summarization "Permalink to this heading")
--------------------------------------------------------------------------------------

In this section we show how we can get the Assistant agent to both answer fact-based questions and summarization questions. This is something that the in-house retrieval tool struggles to accomplish.

### Load Data[](#load-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
--2023-11-11 09:40:13--  https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/paul_graham/paul_graham_essay.txtResolving raw.githubusercontent.com (raw.githubusercontent.com)... 2606:50c0:8002::154, 2606:50c0:8003::154, 2606:50c0:8000::154, ...Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|2606:50c0:8002::154|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 75042 (73K) [text/plain]Saving to: ‘data/paul_graham/paul_graham_essay.txt’data/paul_graham/pa 100%[===================>]  73.28K  --.-KB/s    in 0.009s  2023-11-11 09:40:14 (8.24 MB/s) - ‘data/paul_graham/paul_graham_essay.txt’ saved [75042/75042]
```

```
from llama\_index import SimpleDirectoryReader# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
### Setup Vector + Summary Indexes/Query Engines/Tools[](#setup-vector-summary-indexes-query-engines-tools "Permalink to this heading")


```
from llama\_index.llms import OpenAIfrom llama\_index import (    ServiceContext,    StorageContext,    SummaryIndex,    VectorStoreIndex,)# initialize service context (set chunk size)llm = OpenAI()service\_context = ServiceContext.from\_defaults(chunk\_size=1024, llm=llm)nodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)# initialize storage context (by default it's in-memory)storage\_context = StorageContext.from\_defaults()storage\_context.docstore.add\_documents(nodes)# Define Summary Index and Vector Index over Same Datasummary\_index = SummaryIndex(nodes, storage\_context=storage\_context)vector\_index = VectorStoreIndex(nodes, storage\_context=storage\_context)# define query enginessummary\_query\_engine = summary\_index.as\_query\_engine(    response\_mode="tree\_summarize",    use\_async=True,)vector\_query\_engine = vector\_index.as\_query\_engine()
```

```
from llama\_index.tools.query\_engine import QueryEngineToolsummary\_tool = QueryEngineTool.from\_defaults(    query\_engine=summary\_query\_engine,    name="summary\_tool",    description=(        "Useful for summarization questions related to the author's life"    ),)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_query\_engine,    name="vector\_tool",    description=(        "Useful for retrieving specific context to answer specific questions about the author's life"    ),)
```
### Define Assistant Agent[](#define-assistant-agent "Permalink to this heading")


```
from llama\_index.agent import OpenAIAssistantAgentagent = OpenAIAssistantAgent.from\_new(    name="QA bot",    instructions="You are a bot designed to answer questions about the author",    openai\_tools=[],    tools=[summary\_tool, vector\_tool],    verbose=True,    run\_retrieve\_sleep\_time=1.0,)
```
#### Results: A bit flaky[](#results-a-bit-flaky "Permalink to this heading")


```
response = agent.chat("Can you give me a summary about the author's life?")print(str(response))
```

```
=== Calling Function ===Calling function: summary_tool with args: {"input":"Can you give me a summary about the author's life?"}Got output: The author, Paul Graham, had a strong interest in writing and programming from a young age. They started writing short stories and experimenting with programming in high school. In college, they initially studied philosophy but switched to studying artificial intelligence. However, they realized that the AI being practiced at the time was not going to lead to true understanding of natural language. This led them to focus on Lisp programming and eventually write a book about Lisp hacking. Despite being in a PhD program in computer science, the author also developed a passion for art and decided to pursue it further. They attended the Accademia di Belli Arti in Florence but found that it did not teach them much. They then returned to the US and got a job at a software company. Afterward, they attended the Rhode Island School of Design but dropped out due to the focus on developing a signature style rather than teaching the fundamentals of art. They then moved to New York City and became interested in the World Wide Web, eventually starting a company called Viaweb. They later founded Y Combinator, an investment firm, and created Hacker News.========================Paul Graham is an author with eclectic interests and a varied career path. He began with interests in writing and programming, engaged in philosophy and artificial intelligence during college, and authored a book on Lisp programming. With an equally strong passion for art, he studied at the Accademia di Belli Arti in Florence and briefly at the Rhode Island School of Design before immersing himself in the tech industry by starting Viaweb and later founding the influential startup accelerator Y Combinator. He also created Hacker News, a social news website focused on computer science and entrepreneurship. Graham's life reflects a blend of technology, entrepreneurship, and the arts.
```

```
response = agent.query("What did the author do after RICS?")print(str(response))
```

```
=== Calling Function ===Calling function: vector_tool with args: {"input":"After RICS"}Got output: After RICS, the author moved back to Providence to continue at RISD. However, it became clear that art school, specifically the painting department, did not have the same relationship to art as medical school had to medicine. Painting students were expected to express themselves and develop a distinctive signature style.========================After the author's time at the Royal Institution of Chartered Surveyors (RICS), they moved back to Providence to continue their studies at the Rhode Island School of Design (RISD). There, the author noted a significant difference in the educational approaches between RISD and medical school, specifically in the painting department. At RISD, students were encouraged to express themselves and to develop a unique and distinctive signature style in their artwork.
```
AutoRetrieval from a Vector Database[](#autoretrieval-from-a-vector-database "Permalink to this heading")
----------------------------------------------------------------------------------------------------------

Our existing “auto-retrieval” capabilities (in `VectorIndexAutoRetriever`) allow an LLM to infer the right query parameters for a vector database - including both the query string and metadata filter.

Since the Assistant API can call functions + infer function parameters, we explore its capabilities in performing auto-retrieval here.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
import pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp")
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/pinecone/index.py:4: TqdmExperimentalWarning: Using `tqdm.autonotebook.tqdm` in notebook mode. Use `tqdm.tqdm` instead to force console mode (e.g. in jupyter console)  from tqdm.autonotebook import tqdm
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
### Define Function Tool[](#define-function-tool "Permalink to this heading")

Here we define the function interface, which is passed to OpenAI to perform auto-retrieval.

We were not able to get OpenAI to work with nested pydantic objects or tuples as arguments,so we converted the metadata filter keys and values into lists for the function API to work with.


```
# define function toolfrom llama\_index.tools import FunctionToolfrom llama\_index.vector\_stores.types import (    VectorStoreInfo,    MetadataInfo,    ExactMatchFilter,    MetadataFilters,)from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom typing import List, Tuple, Anyfrom pydantic import BaseModel, Field# hardcode top k for nowtop\_k = 3# define vector store info describing schema of vector storevector\_store\_info = VectorStoreInfo(    content\_info="brief biography of celebrities",    metadata\_info=[        MetadataInfo(            name="category",            type="str",            description=(                "Category of the celebrity, one of [Sports, Entertainment,"                " Business, Music]"            ),        ),        MetadataInfo(            name="country",            type="str",            description=(                "Country of the celebrity, one of [United States, Barbados,"                " Portugal]"            ),        ),    ],)# define pydantic model for auto-retrieval functionclass AutoRetrieveModel(BaseModel):    query: str = Field(..., description="natural language query string")    filter\_key\_list: List[str] = Field(        ..., description="List of metadata filter field names"    )    filter\_value\_list: List[str] = Field(        ...,        description=(            "List of metadata filter field values (corresponding to names"            " specified in filter\_key\_list)"        ),    )def auto\_retrieve\_fn(    query: str, filter\_key\_list: List[str], filter\_value\_list: List[str]): """Auto retrieval function. Performs auto-retrieval from a vector database, and then applies a set of filters. """    query = query or "Query"    exact\_match\_filters = [        ExactMatchFilter(key=k, value=v)        for k, v in zip(filter\_key\_list, filter\_value\_list)    ]    retriever = VectorIndexRetriever(        index,        filters=MetadataFilters(filters=exact\_match\_filters),        top\_k=top\_k,    )    results = retriever.retrieve(query)    return [r.get\_content() for r in results]description = f"""\Use this tool to look up biographical information about celebrities.The vector database schema is given below:{vector\_store\_info.json()}"""auto\_retrieve\_tool = FunctionTool.from\_defaults(    fn=auto\_retrieve\_fn,    name="celebrity\_bios",    description=description,    fn\_schema=AutoRetrieveModel,)
```

```
auto\_retrieve\_fn(    "celebrity from the United States",    filter\_key\_list=["country"],    filter\_value\_list=["United States"],)
```

```
['Angelina Jolie is an American actress, filmmaker, and humanitarian. She has received numerous awards for her acting and is known for her philanthropic work.', 'Michael Jordan is a retired professional basketball player, widely regarded as one of the greatest basketball players of all time.']
```
### Initialize Agent[](#initialize-agent "Permalink to this heading")


```
from llama\_index.agent import OpenAIAssistantAgentagent = OpenAIAssistantAgent.from\_new(    name="Celebrity bot",    instructions="You are a bot designed to answer questions about celebrities.",    tools=[auto\_retrieve\_tool],    verbose=True,)
```

```
response = agent.chat("Tell me about two celebrities from the United States. ")print(str(response))
```

```
=== Calling Function ===Calling function: celebrity_bios with args: {"query": "celebrity from United States", "filter_key_list": ["country"], "filter_value_list": ["United States"]}Got output: ['Angelina Jolie is an American actress, filmmaker, and humanitarian. She has received numerous awards for her acting and is known for her philanthropic work.', 'Michael Jordan is a retired professional basketball player, widely regarded as one of the greatest basketball players of all time.']=========================== Calling Function ===Calling function: celebrity_bios with args: {"query": "celebrity from United States", "filter_key_list": ["country"], "filter_value_list": ["United States"]}Got output: ['Angelina Jolie is an American actress, filmmaker, and humanitarian. She has received numerous awards for her acting and is known for her philanthropic work.', 'Michael Jordan is a retired professional basketball player, widely regarded as one of the greatest basketball players of all time.']========================Here is some information about two celebrities from the United States:1. Angelina Jolie - Angelina Jolie is an American actress, filmmaker, and humanitarian. She has received numerous awards for her acting and is known for her philanthropic work. Over the years, Jolie has starred in several critically acclaimed and commercially successful films, and she has also been involved in various humanitarian causes, advocating for refugees and children's education, among other things.2. Michael Jordan - Michael Jordan is a retired professional basketball player, widely regarded as one of the greatest basketball players of all time. During his career, Jordan dominated the NBA with his scoring ability, athleticism, and competitiveness. He won six NBA championships with the Chicago Bulls and earned the NBA Most Valuable Player Award five times. Jordan has also been a successful businessman and the principal owner of the Charlotte Hornets basketball team.Both figures have made significant impacts in their respective fields and continue to be influential even after reaching the peaks of their careers.
```
Joint Text-to-SQL and Semantic Search[](#joint-text-to-sql-and-semantic-search "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

This is currenty handled by our `SQLAutoVectorQueryEngine`.

Let’s try implementing this by giving our `OpenAIAssistantAgent` access to two query tools: SQL and Vector search.

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
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index import ServiceContextfrom llama\_index.storage import StorageContextfrom llama\_index.text\_splitter import TokenTextSplitterfrom llama\_index.llms import OpenAI# define node parser and LLMchunk\_size = 1024llm = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(chunk\_size=chunk\_size, llm=llm)text\_splitter = TokenTextSplitter(chunk\_size=chunk\_size)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)# use default in-memory storestorage\_context = StorageContext.from\_defaults()vector\_index = VectorStoreIndex([], storage\_context=storage\_context)
```

```
# Insert documents into vector index# Each document has metadata of the city attachedfor city, wiki\_doc in zip(cities, wiki\_docs):    nodes = node\_parser.get\_nodes\_from\_documents([wiki\_doc])    # add metadata to each node    for node in nodes:        node.metadata = {"title": city}    vector\_index.insert\_nodes(nodes)
```
### Define Query Engines / Tools[](#define-query-engines-tools "Permalink to this heading")


```
from llama\_index.tools.query\_engine import QueryEngineTool
```

```
sql\_tool = QueryEngineTool.from\_defaults(    query\_engine=query\_engine,    name="sql\_tool",    description=(        "Useful for translating a natural language query into a SQL query over"        " a table containing: city\_stats, containing the population/country of"        " each city"    ),)vector\_tool = QueryEngineTool.from\_defaults(    query\_engine=vector\_index.as\_query\_engine(similarity\_top\_k=2),    name="vector\_tool",    description=(        f"Useful for answering semantic questions about different cities"    ),)
```
### Initialize Agent[](#id1 "Permalink to this heading")


```
from llama\_index.agent import OpenAIAssistantAgentagent = OpenAIAssistantAgent.from\_new(    name="City bot",    instructions="You are a bot designed to answer questions about cities (both unstructured and structured data)",    tools=[sql\_tool, vector\_tool],    verbose=True,)
```

```
response = agent.chat(    "Tell me about the arts and culture of the city with the highest"    " population")print(str(response))
```

```
=== Calling Function ===Calling function: sql_tool with args: {"input":"SELECT name, country FROM city_stats ORDER BY population DESC LIMIT 1"}Got output: The city with the highest population is Tokyo, Japan.=========================== Calling Function ===Calling function: vector_tool with args: {"input":"What are the arts and culture like in Tokyo, Japan?"}Got output: Tokyo has a vibrant arts and culture scene. The city is home to many museums, including the Tokyo National Museum, which specializes in traditional Japanese art, the National Museum of Western Art, and the Edo-Tokyo Museum. There are also theaters for traditional forms of Japanese drama, such as the National Noh Theatre and the Kabuki-za. Tokyo hosts modern Japanese and international pop and rock music concerts, and the New National Theater Tokyo is a hub for opera, ballet, contemporary dance, and drama. The city also celebrates various festivals throughout the year, including the Sannō, Sanja, and Kanda Festivals. Additionally, Tokyo is known for its youth style, fashion, and cosplay in the Harajuku neighborhood.========================Tokyo, Japan, which has the highest population of any city, boasts a rich and diverse arts and culture landscape. The city is a hub for traditional Japanese art as showcased in prominent institutions like the Tokyo National Museum, and it also features artwork from different parts of the world at the National Museum of Western Art. Tokyo has a deep appreciation for its historical roots, with the Edo-Tokyo Museum presenting the past in a detailed and engaging manner.The traditional performing arts have a significant presence in Tokyo, with theaters such as the National Noh Theatre presenting classical Noh dramas and the iconic Kabuki-za offering enchanting Kabuki performances. For enthusiasts of modern entertainment, Tokyo is a prime spot for contemporary music, including both Japanese pop and rock as well as international acts.Opera, ballet, contemporary dance, and drama find a prestigious platform at the New National Theater Tokyo. Tokyo's calendar is filled with a variety of festivals that reflect the city's vibrant cultural heritage, including the Sannō, Sanja, and Kanda Festivals. Additionally, Tokyo is at the forefront of fashion and youth culture, particularly in the Harajuku district, which is famous for its unique fashion, style, and cosplay.This mix of traditional and modern, local and international arts and culture makes Tokyo a dynamic and culturally rich city.
```

```
response = agent.chat("Tell me about the history of Berlin")print(str(response))
```

```
=== Calling Function ===Calling function: vector_tool with args: {"input":"What is the history of Berlin, Germany?"}Got output: Berlin has a rich and diverse history. It was first documented in the 13th century and has served as the capital of various entities throughout history, including the Margraviate of Brandenburg, the Kingdom of Prussia, the German Empire, the Weimar Republic, and Nazi Germany. After World War II, the city was divided, with West Berlin becoming a part of West Germany and East Berlin becoming the capital of East Germany. Following German reunification in 1990, Berlin once again became the capital of all of Germany. Throughout its history, Berlin has been a center of scientific, artistic, and philosophical activity, and has experienced periods of economic growth and cultural flourishing. Today, it is a world city of culture, politics, media, and science, known for its vibrant arts scene, diverse architecture, and high quality of life.========================Berlin, the capital city of Germany, has a rich and complex history that stretches back to its first documentation in the 13th century. Throughout the centuries, Berlin has been at the heart of numerous important historical movements and events.Initially a small town, Berlin grew in significance as the capital of the Margraviate of Brandenburg. Later on, it ascended in prominence as the capital of the Kingdom of Prussia. With the unification of Germany, Berlin became the imperial capital of the German Empire, a position it retained until the end of World War I.The interwar period saw Berlin as the capital of the Weimar Republic, and it was during this time that the city became known for its vibrant cultural scene. However, the rise of the Nazi regime in the 1930s led to a dark period in Berlin's history, and the city was heavily damaged during World War II.Following the war's end, Berlin became a divided city. The division was physical, represented by the Berlin Wall, and ideological, with West Berlin aligning with democratic West Germany while East Berlin became the capital of the socialist East Germany.The fall of the Berlin Wall in November 1989 was a historic moment, leading to German reunification in 1990. Berlin was once again chosen as the capital of a united Germany. Since reunification, Berlin has undergone massive reconstruction and has become a hub of contemporary culture, politics, media, and science.Today, Berlin celebrates its diverse heritage, from its grand historical landmarks like the Brandenburg Gate and the Reichstag, to its remembrance of the past with monuments such as the Berlin Wall Memorial and the Holocaust Memorial. It is a city known for its cultural dynamism, thriving arts and music scenes, and a high quality of life. Berlin's history has shaped it into a unique world city that continues to play a significant role on the global stage.
```

```
response = agent.chat(    "Can you give me the country corresponding to each city?")print(str(response))
```

```
=== Calling Function ===Calling function: sql_tool with args: {"input":"SELECT name, country FROM city_stats"}Got output: The cities in the city_stats table are Toronto from Canada, Tokyo from Japan, and Berlin from Germany.========================Here are the countries corresponding to each city:- Toronto: Canada- Tokyo: Japan- Berlin: Germany
```
