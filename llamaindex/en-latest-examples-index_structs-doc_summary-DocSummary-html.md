[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/index_structs/doc_summary/DocSummary.ipynb)

Document Summary Index[](#document-summary-index "Permalink to this heading")
==============================================================================

This demo showcases the document summary index, over Wikipedia articles on different cities.

The document summary index will extract a summary from each document and store that summary, as well as all nodes corresponding to the document.

Retrieval can be performed through the LLM or embeddings (which is a TODO). We first select the relevant documents to the query based on their summaries. All retrieved nodes corresponding to the selected documents are retrieved.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.WARNING)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))# # Uncomment if you want to temporarily disable logger# logger = logging.getLogger()# logger.disabled = True
```

```
import nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index import (    SimpleDirectoryReader,    ServiceContext,    get\_response\_synthesizer,)from llama\_index.indices.document\_summary import DocumentSummaryIndexfrom llama\_index.llms import OpenAI
```
Load Datasets[](#load-datasets "Permalink to this heading")
------------------------------------------------------------

Load Wikipedia pages on different cities


```
wiki\_titles = ["Toronto", "Seattle", "Chicago", "Boston", "Houston"]
```

```
from pathlib import Pathimport requestsfor title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```

```
# Load all wiki documentscity\_docs = []for wiki\_title in wiki\_titles:    docs = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()    docs[0].doc\_id = wiki\_title    city\_docs.extend(docs)
```
Build Document Summary Index[](#build-document-summary-index "Permalink to this heading")
------------------------------------------------------------------------------------------

We show two ways of building the index:

* default mode of building the document summary index
* customizing the summary query


```
# LLM (gpt-3.5-turbo)chatgpt = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=chatgpt, chunk\_size=1024)
```

```
# default mode of building the indexresponse\_synthesizer = get\_response\_synthesizer(    response\_mode="tree\_summarize", use\_async=True)doc\_summary\_index = DocumentSummaryIndex.from\_documents(    city\_docs,    service\_context=service\_context,    response\_synthesizer=response\_synthesizer,    show\_progress=True,)
```

```
current doc id: Torontocurrent doc id: Seattlecurrent doc id: Chicagocurrent doc id: Bostoncurrent doc id: Houston
```

```
doc\_summary\_index.get\_document\_summary("Boston")
```

```
"The provided text is about the city of Boston and covers various aspects of the city, including its history, geography, demographics, economy, education system, healthcare facilities, public safety, culture, environment, transportation infrastructure, and international relations. It provides information on Boston's development over time, key events in its history, its significance as a cultural and educational center, its economic sectors, neighborhoods, climate, population, ethnic diversity, landmarks and attractions, colleges and universities, healthcare facilities, public safety measures, cultural scene, annual events, environmental initiatives, churches, pollution control, water purity and availability, climate change and sea level rise, sports teams, parks and recreational areas, government and political system, media, and transportation infrastructure.\n\nSome questions that this text can answer include:\n- What is the history of Boston and how did it develop over time?\n- What were some key events that took place in Boston during the American Revolution?\n- What is the significance of Boston in terms of education and academic research?\n- What are some of the economic sectors that contribute to Boston's economy?\n- How has Boston changed and evolved in the 20th and 21st centuries?\n- What is the geography of Boston and how does it impact the city?\n- What are the neighborhoods in Boston?\n- What is the climate like in Boston?\n- What is the population of Boston and its demographic breakdown?\n- What is the economy of Boston like?\n- What are some notable landmarks and attractions in Boston?\n- What is the ethnic diversity of Boston?\n- What is the religious composition of Boston?\n- What is the impact of colleges and universities on the economy of Boston?\n- What is the role of technology and biotechnology in Boston's economy?\n- What healthcare facilities are located in Boston?\n- How does Boston ensure public safety?\n- What is the cultural scene like in Boston?\n- What are some of the annual events in Boston?\n- What environmental initiatives are being undertaken in Boston?\n- What are some of the churches in Boston and their historical significance?\n- How does Boston control pollution and maintain air quality?\n- What is the status of water purity and availability in Boston?\n- How is Boston addressing climate change and sea level rise?\n- What sports teams are based in Boston and what championships have they won?\n- What are some of the parks and recreational areas in Boston?\n- How is the government and political system structured in Boston?\n- What are some of the major newspapers, radio stations, and television stations in Boston?\n- What is the transportation infrastructure in Boston, including the airport and major highways?\n- What are some notable movies filmed in Boston?\n- Which video games have used Boston as a setting?\n- What are some of Boston's sister cities and partnership relationships?\n- Where can I find more information about Boston's history and landmarks?"
```

```
doc\_summary\_index.storage\_context.persist("index")
```

```
from llama\_index.indices.loading import load\_index\_from\_storagefrom llama\_index import StorageContext# rebuild storage contextstorage\_context = StorageContext.from\_defaults(persist\_dir="index")doc\_summary\_index = load\_index\_from\_storage(storage\_context)
```
Perform Retrieval from Document Summary Index[](#perform-retrieval-from-document-summary-index "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

We show how to execute queries at a high-level. We also show how to perform retrieval at a lower-level so that you can view the parameters that are in place. We show both LLM-based retrieval and embedding-based retrieval using the document summaries.

### High-level Querying[](#high-level-querying "Permalink to this heading")

Note: this uses the default, embedding-based form of retrieval


```
query\_engine = doc\_summary\_index.as\_query\_engine(    response\_mode="tree\_summarize", use\_async=True)
```

```
response = query\_engine.query("What are the sports teams in Toronto?")
```

```
print(response)
```

```
The sports teams in Toronto include the Toronto Maple Leafs (NHL), Toronto Raptors (NBA), Toronto Blue Jays (MLB), Toronto FC (MLS), Toronto Argonauts (CFL), Toronto Six (NWHL), Toronto Rock (National Lacrosse League), Toronto Wolfpack (Rugby Football League), and Toronto Rush (American Ultimate Disc League).
```
### LLM-based Retrieval[](#llm-based-retrieval "Permalink to this heading")


```
from llama\_index.indices.document\_summary import (    DocumentSummaryIndexLLMRetriever,)
```

```
retriever = DocumentSummaryIndexLLMRetriever(    doc\_summary\_index,    # choice\_select\_prompt=None,    # choice\_batch\_size=10,    # choice\_top\_k=1,    # format\_node\_batch\_fn=None,    # parse\_choice\_select\_answer\_fn=None,    # service\_context=None)
```

```
retrieved\_nodes = retriever.retrieve("What are the sports teams in Toronto?")
```

```
print(len(retrieved\_nodes))
```

```
20
```

```
print(retrieved\_nodes[0].score)print(retrieved\_nodes[0].node.get\_text())
```

```
10.0Toronto is the most populous city in Canada and the capital city of the Canadian province of Ontario. With a recorded population of 2,794,356 in 2021, it is the fourth-most populous city in North America. The city is the anchor of the Golden Horseshoe, an urban agglomeration of 9,765,188 people (as of 2021) surrounding the western end of Lake Ontario, while the Greater Toronto Area proper had a 2021 population of 6,712,341. Toronto is an international centre of business, finance, arts, sports and culture, and is recognized as one of the most multicultural and cosmopolitan cities in the world.Indigenous peoples have travelled through and inhabited the Toronto area, located on a broad sloping plateau interspersed with rivers, deep ravines, and urban forest, for more than 10,000 years. After the broadly disputed Toronto Purchase, when the Mississauga surrendered the area to the British Crown, the British established the town of York in 1793 and later designated it as the capital of Upper Canada. During the War of 1812, the town was the site of the Battle of York and suffered heavy damage by American troops. York was renamed and incorporated in 1834 as the city of Toronto. It was designated as the capital of the province of Ontario in 1867 during Canadian Confederation. The city proper has since expanded past its original limits through both annexation and amalgamation to its current area of 630.2 km2 (243.3 sq mi).The diverse population of Toronto reflects its current and historical role as an important destination for immigrants to Canada. More than half of residents were born outside of Canada, more than half of residents belong to a visible minority group, and over 200 distinct ethnic origins are represented among its inhabitants. While the majority of Torontonians speak English as their primary language, over 160 languages are spoken in the city. The mayor of Toronto is elected by direct popular vote to serve as the chief executive of the city. The Toronto City Council is a unicameral legislative body, comprising 25 councillors since the 2018 municipal election, representing geographical wards throughout the city.Toronto is a prominent centre for music, theatre, motion picture production, and television production, and is home to the headquarters of Canada's major national broadcast networks and media outlets. Its varied cultural institutions, which include numerous museums and galleries, festivals and public events, entertainment districts, national historic sites, and sports activities, attract over 43 million tourists each year. Toronto is known for its many skyscrapers and high-rise buildings, in particular the tallest free-standing structure on land outside of Asia, the CN Tower.The city is home to the Toronto Stock Exchange, the headquarters of Canada's five largest banks, and the headquarters of many large Canadian and multinational corporations. Its economy is highly diversified with strengths in technology, design, financial services, life sciences, education, arts, fashion, aerospace, environmental innovation, food services, and tourism. Toronto is the third-largest tech hub in North America after Silicon Valley and New York City, and the fastest growing.== Toponymy ==The word Toronto has been recorded with various spellings in French and English, including Tarento, Tarontha, Taronto, Toranto, Torento, Toronto, and Toronton. Taronto referred to "The Narrows", a channel of water through which Lake Simcoe discharges into Lake Couchiching where the Huron had planted tree saplings to corral fish. This narrows was called tkaronto by the Mohawk, meaning "where there are trees standing in the water," and was recorded as early as 1615 by Samuel de Champlain. The word "Toronto", meaning "plenty" also appears in a 1632 French lexicon of the Huron language, which is also an Iroquoian language. It also appears on French maps referring to various locations, including Georgian Bay, Lake Simcoe, and several rivers. A portage route from Lake Ontario to Lake Huron running through this point, known as the Toronto Carrying-Place Trail, led to widespread use of the name.The pronunciation of the city is broadly   tə-RON-toh, which locals realize as [təˈɹɒno] or [ˈtʃɹɒno], leaving the second 't' silent.== History ==
```

```
# use retriever as part of a query enginefrom llama\_index.query\_engine import RetrieverQueryEngine# configure response synthesizerresponse\_synthesizer = get\_response\_synthesizer(response\_mode="tree\_summarize")# assemble query enginequery\_engine = RetrieverQueryEngine(    retriever=retriever,    response\_synthesizer=response\_synthesizer,)# queryresponse = query\_engine.query("What are the sports teams in Toronto?")print(response)
```

```
The sports teams in Toronto include the Toronto Maple Leafs (NHL), Toronto Raptors (NBA), Toronto Blue Jays (MLB), Toronto FC (MLS), and Toronto Argonauts (CFL).
```
### Embedding-based Retrieval[](#embedding-based-retrieval "Permalink to this heading")


```
from llama\_index.indices.document\_summary import (    DocumentSummaryIndexEmbeddingRetriever,)
```

```
retriever = DocumentSummaryIndexEmbeddingRetriever(    doc\_summary\_index,    # similarity\_top\_k=1,)
```

```
retrieved\_nodes = retriever.retrieve("What are the sports teams in Toronto?")
```

```
len(retrieved\_nodes)
```

```
20
```

```
print(retrieved\_nodes[0].node.get\_text())
```

```
Toronto is the most populous city in Canada and the capital city of the Canadian province of Ontario. With a recorded population of 2,794,356 in 2021, it is the fourth-most populous city in North America. The city is the anchor of the Golden Horseshoe, an urban agglomeration of 9,765,188 people (as of 2021) surrounding the western end of Lake Ontario, while the Greater Toronto Area proper had a 2021 population of 6,712,341. Toronto is an international centre of business, finance, arts, sports and culture, and is recognized as one of the most multicultural and cosmopolitan cities in the world.Indigenous peoples have travelled through and inhabited the Toronto area, located on a broad sloping plateau interspersed with rivers, deep ravines, and urban forest, for more than 10,000 years. After the broadly disputed Toronto Purchase, when the Mississauga surrendered the area to the British Crown, the British established the town of York in 1793 and later designated it as the capital of Upper Canada. During the War of 1812, the town was the site of the Battle of York and suffered heavy damage by American troops. York was renamed and incorporated in 1834 as the city of Toronto. It was designated as the capital of the province of Ontario in 1867 during Canadian Confederation. The city proper has since expanded past its original limits through both annexation and amalgamation to its current area of 630.2 km2 (243.3 sq mi).The diverse population of Toronto reflects its current and historical role as an important destination for immigrants to Canada. More than half of residents were born outside of Canada, more than half of residents belong to a visible minority group, and over 200 distinct ethnic origins are represented among its inhabitants. While the majority of Torontonians speak English as their primary language, over 160 languages are spoken in the city. The mayor of Toronto is elected by direct popular vote to serve as the chief executive of the city. The Toronto City Council is a unicameral legislative body, comprising 25 councillors since the 2018 municipal election, representing geographical wards throughout the city.Toronto is a prominent centre for music, theatre, motion picture production, and television production, and is home to the headquarters of Canada's major national broadcast networks and media outlets. Its varied cultural institutions, which include numerous museums and galleries, festivals and public events, entertainment districts, national historic sites, and sports activities, attract over 43 million tourists each year. Toronto is known for its many skyscrapers and high-rise buildings, in particular the tallest free-standing structure on land outside of Asia, the CN Tower.The city is home to the Toronto Stock Exchange, the headquarters of Canada's five largest banks, and the headquarters of many large Canadian and multinational corporations. Its economy is highly diversified with strengths in technology, design, financial services, life sciences, education, arts, fashion, aerospace, environmental innovation, food services, and tourism. Toronto is the third-largest tech hub in North America after Silicon Valley and New York City, and the fastest growing.== Toponymy ==The word Toronto has been recorded with various spellings in French and English, including Tarento, Tarontha, Taronto, Toranto, Torento, Toronto, and Toronton. Taronto referred to "The Narrows", a channel of water through which Lake Simcoe discharges into Lake Couchiching where the Huron had planted tree saplings to corral fish. This narrows was called tkaronto by the Mohawk, meaning "where there are trees standing in the water," and was recorded as early as 1615 by Samuel de Champlain. The word "Toronto", meaning "plenty" also appears in a 1632 French lexicon of the Huron language, which is also an Iroquoian language. It also appears on French maps referring to various locations, including Georgian Bay, Lake Simcoe, and several rivers. A portage route from Lake Ontario to Lake Huron running through this point, known as the Toronto Carrying-Place Trail, led to widespread use of the name.The pronunciation of the city is broadly   tə-RON-toh, which locals realize as [təˈɹɒno] or [ˈtʃɹɒno], leaving the second 't' silent.== History ==
```

```
# use retriever as part of a query enginefrom llama\_index.query\_engine import RetrieverQueryEngine# configure response synthesizerresponse\_synthesizer = get\_response\_synthesizer(response\_mode="tree\_summarize")# assemble query enginequery\_engine = RetrieverQueryEngine(    retriever=retriever,    response\_synthesizer=response\_synthesizer,)# queryresponse = query\_engine.query("What are the sports teams in Toronto?")print(response)
```

```
The sports teams in Toronto include the Toronto Maple Leafs (NHL), Toronto Raptors (NBA), Toronto Blue Jays (MLB), Toronto FC (MLS), Toronto Argonauts (CFL), Toronto Rock (NLL), Toronto Wolfpack (Rugby Football League), Toronto Six (NWHL), and Toronto Rush (American Ultimate Disc League).
```
