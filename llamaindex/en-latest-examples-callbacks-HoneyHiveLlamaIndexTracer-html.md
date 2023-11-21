[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/callbacks/HoneyHiveLlamaIndexTracer.ipynb)

HoneyHive LlamaIndex Tracer[](#honeyhive-llamaindex-tracer "Permalink to this heading")
========================================================================================

[HoneyHive](https://honeyhive.ai) is a platform that helps developers monitor, evaluate and continuously improve their LLM-powered applications.

The `HoneyHiveLlamaIndexTracer` is integrated with HoneyHive to help developers debug and analyze the execution flow of your LLM pipeline, or to let developers customize feedback on specific trace events to create evaluation or fine-tuning datasets from production.


```
import osfrom getpass import getpassif os.getenv("OPENAI\_API\_KEY") is None:    os.environ["OPENAI\_API\_KEY"] = getpass(        "Paste your OpenAI key from:"        " https://platform.openai.com/account/api-keys\n"    )assert os.getenv("OPENAI\_API\_KEY", "").startswith(    "sk-"), "This doesn't look like a valid OpenAI API key"print("OpenAI API key configured")
```

```
Paste your OpenAI key from: https://platform.openai.com/account/api-keys ········
```

```
OpenAI API key configured
```

```
import osfrom getpass import getpassif os.getenv("HONEYHIVE\_API\_KEY") is None:    os.environ["HONEYHIVE\_API\_KEY"] = getpass(        "Paste your HoneyHive key from:"        " https://app.honeyhive.ai/settings/account\n"    )print("HoneyHive API key configured")
```

```
Paste your HoneyHive key from: https://app.honeyhive.ai/settings/account ········
```

```
HoneyHive API key configured
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.callbacks import CallbackManager, CBEventTypefrom llama\_index.callbacks import LlamaDebugHandler, WandbCallbackHandlerfrom llama\_index import (    SummaryIndex,    GPTTreeIndex,    GPTVectorStoreIndex,    ServiceContext,    SimpleDirectoryReader,    LLMPredictor,    GPTSimpleKeywordTableIndex,    StorageContext,)from llama\_index.indices.composability import ComposableGraphfrom llama\_index import load\_index\_from\_storage, load\_graph\_from\_storagefrom llama\_index.llms import OpenAIfrom honeyhive.sdk.llamaindex\_tracer import HoneyHiveLlamaIndexTracer
```
Setup LLM[](#setup-llm "Permalink to this heading")
----------------------------------------------------


```
llm = OpenAI(model="gpt-4", temperature=0)
```
HoneyHive Callback Manager Setup[](#honeyhive-callback-manager-setup "Permalink to this heading")
--------------------------------------------------------------------------------------------------

**Option 1**: Set Global Evaluation Handler


```
from llama\_index import set\_global\_handlerset\_global\_handler(    "honeyhive",    project="My LlamaIndex Project",    name="My LlamaIndex Pipeline",    api\_key=os.environ["HONEYHIVE\_API\_KEY"],)hh\_tracer = llama\_index.global\_handler
```

```
service\_context = ServiceContext.from\_defaults(llm=llm)
```
**Option 2**: Manually Configure Callback Handler

Also configure a debugger handler for extra notebook visibility.


```
llama\_debug = LlamaDebugHandler(print\_trace\_on\_end=True)hh\_tracer = HoneyHiveLlamaIndexTracer(    project="My LlamaIndex Project",    name="My LlamaIndex Pipeline",    api\_key=os.environ["HONEYHIVE\_API\_KEY"],)callback\_manager = CallbackManager([llama\_debug, hh\_tracer])service\_context = ServiceContext.from\_defaults(    callback\_manager=callback\_manager, llm=llm)
```
1. Indexing[](#indexing "Permalink to this heading")
-----------------------------------------------------

Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
docs = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = GPTVectorStoreIndex.from\_documents(    docs, service\_context=service\_context)
```

```
**********Trace: index_construction    |_node_parsing ->  0.080298 seconds      |_chunking ->  0.078948 seconds    |_embedding ->  1.117244 seconds    |_embedding ->  0.382624 seconds**********
```
2. Query Over Index[](#query-over-index "Permalink to this heading")
---------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response, sep="\n")
```

```
**********Trace: query    |_query ->  11.334982 seconds      |_retrieve ->  0.255016 seconds        |_embedding ->  0.247083 seconds      |_synthesize ->  11.079581 seconds        |_templating ->  5.7e-05 seconds        |_llm ->  11.065533 seconds**********Growing up, the author was involved in writing and programming. They wrote short stories and tried their hand at programming on an IBM 1401, using an early version of Fortran. Later, they started programming on a TRS-80 microcomputer that their father bought, creating simple games, a program to predict the flight of their model rockets, and a word processor. Despite their interest in programming, they initially planned to study philosophy in college, but eventually switched to AI.
```
3. Build Complex Indices[](#build-complex-indices "Permalink to this heading")
-------------------------------------------------------------------------------


```
# fetch "New York City" page from Wikipediafrom pathlib import Pathimport requestsresponse = requests.get(    "https://en.wikipedia.org/w/api.php",    params={        "action": "query",        "format": "json",        "titles": "New York City",        "prop": "extracts",        "explaintext": True,    },).json()page = next(iter(response["query"]["pages"].values()))nyc\_text = page["extract"]data\_path = Path("data")if not data\_path.exists():    Path.mkdir(data\_path)with open("data/nyc\_text.txt", "w") as fp:    fp.write(nyc\_text)
```

```
# load NYC datasetnyc\_documents = SimpleDirectoryReader("data/").load\_data()# load PG's essayessay\_documents = SimpleDirectoryReader("../data/paul\_graham").load\_data()
```

```
# While building a composable index, to correctly save the index,# the same `storage\_context` needs to be passed to every index.storage\_context = StorageContext.from\_defaults()
```

```
# build NYC indexnyc\_index = GPTVectorStoreIndex.from\_documents(    nyc\_documents,    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
**********Trace: index_construction    |_node_parsing ->  0.069026 seconds      |_chunking ->  0.066652 seconds    |_embedding ->  1.216197 seconds    |_embedding ->  0.413493 seconds    |_embedding ->  0.405327 seconds    |_embedding ->  0.191452 seconds**********
```

```
# build essay indexessay\_index = GPTVectorStoreIndex.from\_documents(    essay\_documents,    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
**********Trace: index_construction    |_node_parsing ->  0.09018 seconds      |_chunking ->  0.088916 seconds    |_embedding ->  0.403542 seconds    |_embedding ->  0.378775 seconds**********
```
### 3.1. Query Over Graph Index[](#query-over-graph-index "Permalink to this heading")


```
nyc\_index\_summary = """ New York, often called New York City or NYC,  is the most populous city in the United States.  With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2),  New York City is also the most densely populated major city in the United States,  and is more than twice as populous as second-place Los Angeles.  New York City lies at the southern tip of New York State, and  constitutes the geographical and demographic center of both the  Northeast megalopolis and the New York metropolitan area, the  largest metropolitan area in the world by urban landmass.[8] With over  20.1 million people in its metropolitan statistical area and 23.5 million  in its combined statistical area as of 2020, New York is one of the world's  most populous megacities, and over 58 million people live within 250 mi (400 km) of  the city. New York City is a global cultural, financial, and media center with  a significant influence on commerce, health care and life sciences, entertainment,  research, technology, education, politics, tourism, dining, art, fashion, and sports.  Home to the headquarters of the United Nations,  New York is an important center for international diplomacy, an established safe haven for global investors, and is sometimes described as the capital of the world."""essay\_index\_summary = """ Author: Paul Graham.  The author grew up painting and writing essays.  He wrote a book on Lisp and did freelance Lisp hacking work to support himself.  He also became the de facto studio assistant for Idelle Weber, an early photorealist painter.  He eventually had the idea to start a company to put art galleries online, but the idea was unsuccessful.  He then had the idea to write software to build online stores, which became the basis for his successful company, Viaweb.  After Viaweb was acquired by Yahoo!, the author returned to painting and started writing essays online.  He wrote a book of essays, Hackers & Painters, and worked on spam filters.  He also bought a building in Cambridge to use as an office.  He then had the idea to start Y Combinator, an investment firm that would  make a larger number of smaller investments and help founders remain as CEO.  He and his partner Jessica Livingston ran Y Combinator and funded a batch of startups twice a year.  He also continued to write essays, cook for groups of friends, and explore the concept of invented vs discovered in software. """
```

```
from llama\_index import StorageContext, load\_graph\_from\_storagegraph = ComposableGraph.from\_indices(    GPTSimpleKeywordTableIndex,    [nyc\_index, essay\_index],    index\_summaries=[nyc\_index\_summary, essay\_index\_summary],    max\_keywords\_per\_chunk=50,    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
**********Trace: graph_construction**********
```
### 3.2 Query[](#query "Permalink to this heading")


```
query\_engine = graph.as\_query\_engine()response = query\_engine.query(    "What is the climate of New York City like? How cold is it during the"    " winter?",)print(response, sep="\n")
```

```
**********Trace: query    |_query ->  28.480834 seconds      |_retrieve ->  0.002333 seconds      |_query ->  15.367174 seconds        |_retrieve ->  0.171675 seconds          |_embedding ->  0.162042 seconds        |_synthesize ->  15.194969 seconds          |_templating ->  4.8e-05 seconds          |_llm ->  15.179017 seconds      |_synthesize ->  13.110327 seconds        |_templating ->  8.2e-05 seconds        |_llm ->  13.103851 seconds**********New York City has a humid subtropical climate, which makes it unique as the northernmost major city in North America with this type of climate. The city enjoys an average of 234 days of sunshine each year. During winter, the city is chilly and damp, with influences from the Atlantic Ocean and the Appalachian Mountains helping to keep it warmer than other inland cities at similar latitudes. The average daily temperature in January, which is the coldest month, is 33.3 °F (0.7 °C). However, temperatures can fluctuate significantly, dropping to 10 °F (−12 °C) on some days, and reaching up to 60 °F (16 °C) on others, even in the coldest winter month.
```
View HoneyHive Traces[](#view-honeyhive-traces "Permalink to this heading")
----------------------------------------------------------------------------

When we are done tracing our events we can view them via [the HoneyHive platform](https://app.honeyhive.ai). Simply login to HoneyHive, go to your `My LlamaIndex Project` project, click the `Data Store` tab and view your `Sessions`.

