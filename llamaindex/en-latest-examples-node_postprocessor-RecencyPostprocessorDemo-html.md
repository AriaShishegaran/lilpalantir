Recency Filtering[](#recency-filtering "Permalink to this heading")
====================================================================

Showcase capabilities of recency-weighted node postprocessor


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.indices.postprocessor import (    FixedRecencyPostprocessor,    EmbeddingRecencyPostprocessor,)from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.storage.docstore import SimpleDocumentStorefrom llama\_index.response.notebook\_utils import display\_response
```

```
/Users/jerryliu/Programming/llama_index/.venv/lib/python3.10/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Parse Documents into Nodes, add to Docstore[](#parse-documents-into-nodes-add-to-docstore "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------

In this example, there are 3 different versions of PG’s essay. They are largely identical **except**for one specific section, which details the amount of funding they raised for Viaweb.

V1: 50k, V2: 30k, V3: 10K

V1: 2020-01-01, V2: 2020-02-03, V3: 2022-04-12

The idea is to encourage index to fetch the most recent info (which is V3)


```
# load documentsfrom llama\_index.storage.storage\_context import StorageContextdef get\_file\_metadata(file\_name: str): """Get file metadata."""    if "v1" in file\_name:        return {"date": "2020-01-01"}    elif "v2" in file\_name:        return {"date": "2020-02-03"}    elif "v3" in file\_name:        return {"date": "2022-04-12"}    else:        raise ValueError("invalid file")documents = SimpleDirectoryReader(    input\_files=[        "test\_versioned\_data/paul\_graham\_essay\_v1.txt",        "test\_versioned\_data/paul\_graham\_essay\_v2.txt",        "test\_versioned\_data/paul\_graham\_essay\_v3.txt",    ],    file\_metadata=get\_file\_metadata,).load\_data()# define service context (wrapper container around current classes)service\_context = ServiceContext.from\_defaults(chunk\_size=512)# use node parser in service context to parse into nodesnodes = service\_context.node\_parser.get\_nodes\_from\_documents(documents)# add to docstoredocstore = SimpleDocumentStore()docstore.add\_documents(nodes)storage\_context = StorageContext.from\_defaults(docstore=docstore)
```

```
print(documents[2].get\_text())
```
Build Index[](#build-index "Permalink to this heading")
--------------------------------------------------------


```
# build indexindex = VectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 84471 tokens
```
Define Recency Postprocessors[](#define-recency-postprocessors "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
node\_postprocessor = FixedRecencyPostprocessor(service\_context=service\_context)
```

```
node\_postprocessor\_emb = EmbeddingRecencyPostprocessor(    service\_context=service\_context)
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# naive queryquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3,)response = query\_engine.query(    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?",)
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 1813 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 22 tokens
```

```
# query using fixed recency node postprocessorquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3, node\_postprocessors=[node\_postprocessor])response = query\_engine.query(    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?",)
```

```
# query using embedding-based node postprocessorquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3, node\_postprocessors=[node\_postprocessor\_emb])response = query\_engine.query(    "How much did the author raise in seed funding from Idelle's husband"    " (Julian) for Viaweb?",)
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 541 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 22 tokens
```
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
query\_engine = index.as\_query\_engine(    similarity\_top\_k=3, response\_mode="no\_text")init\_response = query\_engine.query(    query\_str,)resp\_nodes = [n.node for n in init\_response.source\_nodes]
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 22 tokens
```

```
summary\_index = SummaryIndex(resp\_nodes)query\_engine = summary\_index.as\_query\_engine(    node\_postprocessors=[node\_postprocessor])response = query\_engine.query(query\_str)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 541 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 0 tokens
```
