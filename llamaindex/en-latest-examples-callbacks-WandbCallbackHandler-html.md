[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/callbacks/WandbCallbackHandler.ipynb)

Wandb Callback Handler[](#wandb-callback-handler "Permalink to this heading")
==============================================================================

[Weights & Biases Prompts](https://docs.wandb.ai/guides/prompts) is a suite of LLMOps tools built for the development of LLM-powered applications.

The `WandbCallbackHandler` is integrated with W&B Prompts to visualize and inspect the execution flow of your index construction, or querying over your index and more. You can use this handler to persist your created indices as W&B Artifacts allowing you to version control your indices.


```
import osfrom getpass import getpassif os.getenv("OPENAI\_API\_KEY") is None:    os.environ["OPENAI\_API\_KEY"] = getpass(        "Paste your OpenAI key from:"        " https://platform.openai.com/account/api-keys\n"    )assert os.getenv("OPENAI\_API\_KEY", "").startswith(    "sk-"), "This doesn't look like a valid OpenAI API key"print("OpenAI API key configured")
```

```
OpenAI API key configured
```

```
from llama\_index.callbacks import CallbackManager, CBEventTypefrom llama\_index.callbacks import LlamaDebugHandler, WandbCallbackHandlerfrom llama\_index import (    SummaryIndex,    GPTTreeIndex,    GPTVectorStoreIndex,    ServiceContext,    SimpleDirectoryReader,    LLMPredictor,    GPTSimpleKeywordTableIndex,    StorageContext,)from llama\_index.indices.composability import ComposableGraphfrom llama\_index import load\_index\_from\_storage, load\_graph\_from\_storagefrom llama\_index.llms import OpenAI
```
Setup LLM[](#setup-llm "Permalink to this heading")
----------------------------------------------------


```
llm = OpenAI(model="gpt-4", temperature=0)
```
W&B Callback Manager Setup[](#w-b-callback-manager-setup "Permalink to this heading")
--------------------------------------------------------------------------------------

**Option 1**: Set Global Evaluation Handler


```
from llama\_index import set\_global\_handlerset\_global\_handler("wandb", run\_args={"project": "llamaindex"})wandb\_callback = llama\_index.global\_handler
```

```
service\_context = ServiceContext.from\_defaults(llm=llm)
```
**Option 2**: Manually Configure Callback Handler

Also configure a debugger handler for extra notebook visibility.


```
llama\_debug = LlamaDebugHandler(print\_trace\_on\_end=True)# wandb.init argsrun\_args = dict(    project="llamaindex",)wandb\_callback = WandbCallbackHandler(run\_args=run\_args)callback\_manager = CallbackManager([llama\_debug, wandb\_callback])service\_context = ServiceContext.from\_defaults(    callback\_manager=callback\_manager, llm=llm)
```

> After running the above cell, you will get the W&B run page URL. Here you will find a trace table with all the events tracked using [Weights and Biases’ Prompts](https://docs.wandb.ai/guides/prompts) feature.
> 
> 

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
**********Trace: index_construction    |_node_parsing ->  0.295179 seconds      |_chunking ->  0.293976 seconds    |_embedding ->  0.494492 seconds    |_embedding ->  0.346162 seconds**********
```

```
wandb: Logged trace tree to W&B.
```
### 1.1 Persist Index as W&B Artifacts[](#persist-index-as-w-b-artifacts "Permalink to this heading")


```
wandb\_callback.persist\_index(index, index\_name="simple\_vector\_store")
```

```
wandb: Adding directory to artifact (/Users/loganmarkewich/llama_index/docs/examples/callbacks/wandb/run-20230801_152955-ds93prxa/files/storage)... Done. 0.0s
```
### 1.2 Download Index from W&B Artifacts[](#download-index-from-w-b-artifacts "Permalink to this heading")


```
storage\_context = wandb\_callback.load\_storage\_context(    artifact\_url="ayut/llamaindex/simple\_vector\_store:v0")# Load the index and initialize a query engineindex = load\_index\_from\_storage(    storage\_context, service\_context=service\_context)
```

```
wandb:   3 of 3 files downloaded.  
```

```
**********Trace: index_construction**********
```
2. Query Over Index[](#query-over-index "Permalink to this heading")
---------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response, sep="\n")
```

```
**********Trace: query    |_query ->  2.695958 seconds      |_retrieve ->  0.806379 seconds        |_embedding ->  0.802871 seconds      |_synthesize ->  1.8893 seconds        |_llm ->  1.842434 seconds**********
```

```
wandb: Logged trace tree to W&B.
```

```
The text does not provide information on what the author did growing up.
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
**********Trace: index_construction    |_node_parsing ->  0.491078 seconds      |_chunking ->  0.48921 seconds    |_embedding ->  0.314621 seconds    |_embedding ->  0.65393 seconds    |_embedding ->  0.452587 seconds    |_embedding ->  0.510454 seconds**********
```

```
wandb: Logged trace tree to W&B.
```

```
# build essay indexessay\_index = GPTVectorStoreIndex.from\_documents(    essay\_documents,    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
**********Trace: index_construction    |_node_parsing ->  0.340749 seconds      |_chunking ->  0.339598 seconds    |_embedding ->  0.280761 seconds    |_embedding ->  0.315542 seconds**********
```

```
wandb: Logged trace tree to W&B.
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
### 3.1.1 Persist Composable Index as W&B Artifacts[](#persist-composable-index-as-w-b-artifacts "Permalink to this heading")


```
wandb\_callback.persist\_index(graph, index\_name="composable\_graph")
```

```
wandb: Adding directory to artifact (/Users/ayushthakur/integrations/llamaindex/llama_index/docs/examples/callbacks/wandb/run-20230607_012558-js7j48l9/files/storage)... Done. 0.0s
```
### 3.1.2 Download Index from W&B Artifacts[](#id1 "Permalink to this heading")


```
storage\_context = wandb\_callback.load\_storage\_context(    artifact\_url="ayut/llamaindex/composable\_graph:v0")# Load the graph and initialize a query enginegraph = load\_graph\_from\_storage(    storage\_context, root\_id=graph.root\_id, service\_context=service\_context)query\_engine = index.as\_query\_engine()
```

```
wandb:   3 of 3 files downloaded.  
```

```
**********Trace: index_construction********************Trace: index_construction********************Trace: index_construction**********
```
### 3.1.3 Query[](#query "Permalink to this heading")


```
query\_engine = graph.as\_query\_engine()response = query\_engine.query(    "What is the climate of New York City like? How cold is it during the"    " winter?",)print(response, sep="\n")
```

```
**********Trace: query    |_query ->  58.207419 seconds      |_retrieve ->  2.672269 seconds        |_llm ->  2.671922 seconds      |_query ->  39.630366 seconds        |_retrieve ->  0.165883 seconds          |_embedding ->  0.158699 seconds        |_synthesize ->  39.46435 seconds          |_llm ->  39.410054 seconds      |_synthesize ->  15.904373 seconds        |_llm ->  15.900012 seconds**********
```

```
wandb: Logged trace tree to W&B.
```

```
New York City has a humid subtropical climate, making it the northernmost major city in North America with this type of climate. During the winter, the city is chilly and damp. The average daily temperature in January, the coldest month, is 33.3 °F (0.7 °C). Temperatures can drop to 10 °F (−12 °C) several times each winter, but can also reach 60 °F (16 °C) for several days even in the coldest winter month. The city also experiences the urban heat island effect, which can increase nighttime temperatures. The most extreme temperatures have ranged from −15 °F (−26 °C) to 106 °F (41 °C).
```
Close W&B Callback Handler[](#close-w-b-callback-handler "Permalink to this heading")
--------------------------------------------------------------------------------------

When we are done tracking our events we can close the wandb run.


```
wandb\_callback.finish()
```
