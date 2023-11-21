Time-Weighted Rerank[](#time-weighted-rerank "Permalink to this heading")
==========================================================================

Showcase capabilities of time-weighted node postprocessor


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.indices.postprocessor import (    TimeWeightedPostprocessor,)from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.storage.docstore import SimpleDocumentStorefrom llama\_index.response.notebook\_utils import display\_responsefrom datetime import datetime, timedelta
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Parse Documents into Nodes, add to Docstore[](#parse-documents-into-nodes-add-to-docstore "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------

In this example, there are 3 different versions of PG’s essay. They are largely identical **except**for one specific section, which details the amount of funding they raised for Viaweb.

V1: 50k, V2: 30k, V3: 10K

V1: -1 day, V2: -2 days, V3: -3 days

The idea is to encourage index to fetch the most recent info (which is V3)


```
# load documentsfrom llama\_index.storage.storage\_context import StorageContextnow = datetime.now()key = "\_\_last\_accessed\_\_"doc1 = SimpleDirectoryReader(    input\_files=["./test\_versioned\_data/paul\_graham\_essay\_v1.txt"]).load\_data()[0]doc2 = SimpleDirectoryReader(    input\_files=["./test\_versioned\_data/paul\_graham\_essay\_v2.txt"]).load\_data()[0]doc3 = SimpleDirectoryReader(    input\_files=["./test\_versioned\_data/paul\_graham\_essay\_v3.txt"]).load\_data()[0]# define service context (wrapper container around current classes)service\_context = ServiceContext.from\_defaults(chunk\_size=512)node\_parser = service\_context.node\_parser# use node parser in service context to parse docs into nodesnodes1 = node\_parser.get\_nodes\_from\_documents([doc1])nodes2 = node\_parser.get\_nodes\_from\_documents([doc2])nodes3 = node\_parser.get\_nodes\_from\_documents([doc3])# fetch the modified chunk from each document, set metadata# also exclude the date from being read by the LLMnodes1[14].metadata[key] = (now - timedelta(hours=3)).timestamp()nodes1[14].excluded\_llm\_metadata\_keys = [key]nodes2[14].metadata[key] = (now - timedelta(hours=2)).timestamp()nodes2[14].excluded\_llm\_metadata\_keys = [key]nodes3[14].metadata[key] = (now - timedelta(hours=1)).timestamp()nodes2[14].excluded\_llm\_metadata\_keys = [key]# add to docstoredocstore = SimpleDocumentStore()nodes = [nodes1[14], nodes2[14], nodes3[14]]docstore.add\_documents(nodes)storage\_context = StorageContext.from\_defaults(docstore=docstore)
```
Build Index[](#build-index "Permalink to this heading")
--------------------------------------------------------


```
# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)
```
Define Recency Postprocessors[](#define-recency-postprocessors "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
node\_postprocessor = TimeWeightedPostprocessor(    time\_decay=0.5, time\_access\_refresh=False, top\_k=1)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# naive queryquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3,)response = query\_engine.query(    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?",)
```

```
display\_response(response)
```
**`Final Response:`** $50,000


```
# query using time weighted node postprocessorquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3, node\_postprocessors=[node\_postprocessor])response = query\_engine.query(    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?",)
```

```
display\_response(response)
```
**`Final Response:`** The author raised $10,000 in seed funding from Idelle’s husband (Julian) for Viaweb.

Query Index (Lower-Level Usage)[](#query-index-lower-level-usage "Permalink to this heading")
----------------------------------------------------------------------------------------------

In this example we first get the full set of nodes from a query call, and then send to node postprocessor, and thenfinally synthesize response through a summary index.


```
from llama\_index import SummaryIndex
```

```
query\_str = (    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?")
```

```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=3, response\_mode="no\_text")init\_response = query\_engine.query(    query\_str,)resp\_nodes = [n for n in init\_response.source\_nodes]
```

```
# get the post-processed nodes -- which should be the top-1 sorted by datenew\_resp\_nodes = node\_postprocessor.postprocess\_nodes(resp\_nodes)summary\_index = SummaryIndex([n.node for n in new\_resp\_nodes])query\_engine = summary\_index.as\_query\_engine()response = query\_engine.query(query\_str)
```

```
display\_response(response)
```
**`Final Response:`** The author raised $10,000 in seed funding from Idelle’s husband (Julian) for Viaweb.

