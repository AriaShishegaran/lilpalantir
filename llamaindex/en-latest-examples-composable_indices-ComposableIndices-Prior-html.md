[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/composable_indices/ComposableIndices-Prior.ipynb)

Composable Graph Basic[](#composable-graph-basic "Permalink to this heading")
==============================================================================


```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import (    VectorStoreIndex,    EmptyIndex,    TreeIndex,    SummaryIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,)
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Datasets[](#load-datasets "Permalink to this heading")
------------------------------------------------------------

Load PG’s essay


```
# load PG's essayessay\_documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
Building the document indices[](#building-the-document-indices "Permalink to this heading")
--------------------------------------------------------------------------------------------

* Build a vector index for PG’s essay
* Also build an empty index (to store prior knowledge)


```
# configureservice\_context = ServiceContext.from\_defaults(chunk\_size=512)storage\_context = StorageContext.from\_defaults()# build essay indexessay\_index = VectorStoreIndex.from\_documents(    essay\_documents,    service\_context=service\_context,    storage\_context=storage\_context,)empty\_index = EmptyIndex(    service\_context=service\_context, storage\_context=storage\_context)
```
Query Indices[](#query-indices "Permalink to this heading")
------------------------------------------------------------

See the response of querying each index


```
query\_engine = essay\_index.as\_query\_engine(    similarity\_top\_k=3,    response\_mode="tree\_summarize",)response = query\_engine.query(    "Tell me about what Sam Altman did during his time in YC",)
```

```
print(str(response))
```

```
query\_engine = empty\_index.as\_query\_engine(response\_mode="generation")response = query\_engine.query(    "Tell me about what Sam Altman did during his time in YC",)
```

```
print(str(response))
```
Define summary for each index.


```
essay\_index\_summary = (    "This document describes Paul Graham's life, from early adulthood to the"    " present day.")empty\_index\_summary = "This can be used for general knowledge purposes."
```
Define Graph (Summary Index as Parent Index)[](#define-graph-summary-index-as-parent-index "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------

This allows us to synthesize responses both using a knowledge corpus as well as prior knowledge.


```
from llama\_index.indices.composability import ComposableGraph
```

```
graph = ComposableGraph.from\_indices(    SummaryIndex,    [essay\_index, empty\_index],    index\_summaries=[essay\_index\_summary, empty\_index\_summary],    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
# [optional] persist to diskstorage\_context.persist()root\_id = graph.root\_id
```

```
# [optional] load from diskfrom llama\_index.indices.loading import load\_graph\_from\_storagegraph = load\_graph\_from\_storage(storage\_context, root\_id=root\_id)
```

```
# configure query enginescustom\_query\_engines = {    essay\_index.index\_id: essay\_index.as\_query\_engine(        similarity\_top\_k=3,        response\_mode="tree\_summarize",    )}
```

```
# set Logging to DEBUG for more detailed outputs# ask it a question about Sam Altmanquery\_engine = graph.as\_query\_engine(custom\_query\_engines=custom\_query\_engines)response = query\_engine.query(    "Tell me about what Sam Altman did during his time in YC",)
```

```
print(str(response))
```

```
# Get source of responseprint(response.get\_formatted\_sources())
```
Define Graph (Tree Index as Parent Index)[](#define-graph-tree-index-as-parent-index "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

This allows us to “route” a query to either a knowledge-augmented index, or to the LLM itself.


```
from llama\_index.indices.composability import ComposableGraph
```

```
# configure retrievercustom\_query\_engines = {    essay\_index.index\_id: essay\_index.as\_query\_engine(        similarity\_top\_k=3,        response\_mode="tree\_summarize",    )}
```

```
graph2 = ComposableGraph.from\_indices(    TreeIndex,    [essay\_index, empty\_index],    index\_summaries=[essay\_index\_summary, empty\_index\_summary],)
```

```
# set Logging to DEBUG for more detailed outputs# ask it a question about NYCquery\_engine = graph2.as\_query\_engine(    custom\_query\_engines=custom\_query\_engines)response = query\_engine.query(    "Tell me about what Paul Graham did growing up?",)
```

```
str(response)
```

```
print(response.get\_formatted\_sources())
```

```
response = query\_engine.query(    "Tell me about Barack Obama",)
```

```
str(response)
```

```
response.get\_formatted\_sources()
```
