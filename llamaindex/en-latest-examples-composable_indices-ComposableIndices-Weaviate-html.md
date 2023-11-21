[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/ComposableIndices-Weaviate.ipynb)

Composable Graph with Weaviate[](#composable-graph-with-weaviate "Permalink to this heading")
==============================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysimport weaviatefrom pprint import pprintlogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleKeywordTableIndex,    SummaryIndex,    VectorStoreIndex,    SimpleDirectoryReader,)from llama\_index.vector\_stores import WeaviateVectorStore
```

```
resource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)
```

```
client = weaviate.Client(    "https://test-weaviate-cluster.semi.network/",    auth\_client\_secret=resource\_owner\_config,)
```

```
# [optional] set batchclient.batch.configure(batch\_size=10)
```
Load Datasets[](#load-datasets "Permalink to this heading")
------------------------------------------------------------

Load both the NYC Wikipedia page as well as Paul Graham’s “What I Worked On” essay


```
# fetch "New York City" page from Wikipediafrom pathlib import Pathimport requestsresponse = requests.get(    "https://en.wikipedia.org/w/api.php",    params={        "action": "query",        "format": "json",        "titles": "New York City",        "prop": "extracts",        # 'exintro': True,        "explaintext": True,    },).json()page = next(iter(response["query"]["pages"].values()))nyc\_text = page["extract"]data\_path = Path("data/test\_wiki")if not data\_path.exists():    Path.mkdir(data\_path)with open("./data/test\_wiki/nyc\_text.txt", "w") as fp:    fp.write(nyc\_text)
```

```
# load NYC datasetnyc\_documents = SimpleDirectoryReader("./data/test\_wiki").load\_data()
```
Download Paul Graham Essay data


```
!mkdir -p 'data/paul\_graham\_essay/'!wget 'https://github.com/jerryjliu/llama\_index/blob/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham\_essay/paul\_graham\_essay.txt'
```

```
# load PG's essayessay\_documents = SimpleDirectoryReader("./data/paul\_graham\_essay").load\_data()
```
Building the document indices[](#building-the-document-indices "Permalink to this heading")
--------------------------------------------------------------------------------------------

Build a tree index for the NYC wiki page and PG essay


```
# build NYC indexfrom llama\_index.storage.storage\_context import StorageContextvector\_store = WeaviateVectorStore(    weaviate\_client=client, index\_name="Nyc\_docs")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)nyc\_index = VectorStoreIndex.from\_documents(    nyc\_documents, storage\_context=storage\_context)
```

```
# build essay indexvector\_store = WeaviateVectorStore(    weaviate\_client=client, index\_name="Essay\_docs")storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)essay\_index = VectorStoreIndex.from\_documents(    essay\_documents, storage\_context=storage\_context)
```
Set summaries for the indices[](#set-summaries-for-the-indices "Permalink to this heading")
--------------------------------------------------------------------------------------------

Add text summaries to indices, so we can compose other indices on top of it


```
nyc\_index\_summary = """ New York, often called New York City or NYC,  is the most populous city in the United States.  With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2),  New York City is also the most densely populated major city in the United States,  and is more than twice as populous as second-place Los Angeles.  New York City lies at the southern tip of New York State, and  constitutes the geographical and demographic center of both the  Northeast megalopolis and the New York metropolitan area, the  largest metropolitan area in the world by urban landmass.[8] With over  20.1 million people in its metropolitan statistical area and 23.5 million  in its combined statistical area as of 2020, New York is one of the world's  most populous megacities, and over 58 million people live within 250 mi (400 km) of  the city. New York City is a global cultural, financial, and media center with  a significant influence on commerce, health care and life sciences, entertainment,  research, technology, education, politics, tourism, dining, art, fashion, and sports.  Home to the headquarters of the United Nations,  New York is an important center for international diplomacy, an established safe haven for global investors, and is sometimes described as the capital of the world."""essay\_index\_summary = """ Author: Paul Graham.  The author grew up painting and writing essays.  He wrote a book on Lisp and did freelance Lisp hacking work to support himself.  He also became the de facto studio assistant for Idelle Weber, an early photorealist painter.  He eventually had the idea to start a company to put art galleries online, but the idea was unsuccessful.  He then had the idea to write software to build online stores, which became the basis for his successful company, Viaweb.  After Viaweb was acquired by Yahoo!, the author returned to painting and started writing essays online.  He wrote a book of essays, Hackers & Painters, and worked on spam filters.  He also bought a building in Cambridge to use as an office.  He then had the idea to start Y Combinator, an investment firm that would  make a larger number of smaller investments and help founders remain as CEO.  He and his partner Jessica Livingston ran Y Combinator and funded a batch of startups twice a year.  He also continued to write essays, cook for groups of friends, and explore the concept of invented vs discovered in software. """index\_summaries = [nyc\_index\_summary, essay\_index\_summary]nyc\_index.set\_index\_id("nyc\_index")essay\_index.set\_index\_id("essay\_index")
```
Build Keyword Table Index on top of vector indices![](#build-keyword-table-index-on-top-of-vector-indices "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------

We set summaries for each of the NYC and essay indices, and then compose a keyword index on top of it.

Define Graph[](#define-graph "Permalink to this heading")
----------------------------------------------------------


```
from llama\_index.indices.composability import ComposableGraph
```

```
graph = ComposableGraph.from\_indices(    SimpleKeywordTableIndex,    [nyc\_index, essay\_index],    index\_summaries=index\_summaries,    max\_keywords\_per\_chunk=50,)
```

```
custom\_query\_engines = {    graph.root\_id: graph.root\_index.as\_query\_engine(retriever\_mode="simple")}query\_engine = graph.as\_query\_engine(    custom\_query\_engines=custom\_query\_engines,)
```

```
# set Logging to DEBUG for more detailed outputs# ask it a question about NYCresponse = query\_engine.query(    "What is the weather of New York City like? How cold is it during the"    " winter?",)
```

```
print(str(response))
```

```
# Get source of responseprint(response.get\_formatted\_sources())
```

```
# ask it a question about PG's essayresponse = query\_engine.query(    "What did the author do growing up, before his time at Y Combinator?",)
```

```
print(str(response))
```

```
# Get source of responseprint(response.get\_formatted\_sources())
```
