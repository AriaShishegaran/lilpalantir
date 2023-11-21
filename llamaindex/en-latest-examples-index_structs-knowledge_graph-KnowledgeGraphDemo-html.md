Knowledge Graph Index[](#knowledge-graph-index "Permalink to this heading")
============================================================================

This tutorial gives a basic overview of how to use our `KnowledgeGraphIndex`, which handlesautomated knowledge graph construction from unstructured text as well as entity-based querying.

If you would like to query knowledge graphs in more flexible ways, including pre-existing ones, pleasecheck out our `KnowledgeGraphQueryEngine` and other constructs.


```
# My OpenAI Keyimport osos.environ["OPENAI\_API\_KEY"] = "INSERT OPENAI KEY"
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)
```
Using Knowledge Graph[](#using-knowledge-graph "Permalink to this heading")
----------------------------------------------------------------------------

### Building the Knowledge Graph[](#building-the-knowledge-graph "Permalink to this heading")


```
from llama\_index import (    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,    KnowledgeGraphIndex,)from llama\_index.graph\_stores import SimpleGraphStorefrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```

```
INFO:numexpr.utils:NumExpr defaulting to 8 threads.
```

```
documents = SimpleDirectoryReader(    "../../../../examples/paul\_graham\_essay/data").load\_data()
```

```
# define LLM# NOTE: at the time of demo, text-davinci-002 did not have rate-limit errorsllm = OpenAI(temperature=0, model="text-davinci-002")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
from llama\_index.storage.storage\_context import StorageContextgraph\_store = SimpleGraphStore()storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    max\_triplets\_per\_chunk=2,    storage\_context=storage\_context,    service\_context=service\_context,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens
```
### [Optional] Try building the graph and manually add triplets![](#optional-try-building-the-graph-and-manually-add-triplets "Permalink to this heading")

### Querying the Knowledge Graph[](#querying-the-knowledge-graph "Permalink to this heading")


```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['Interleaf', 'company', 'software', 'history']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 116 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 116 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf was a software company that developed and published document preparation and desktop publishing software. It was founded in 1986 and was headquartered in Waltham, Massachusetts. The company was acquired by Quark, Inc. in 2000.**
```
query\_engine = index.as\_query\_engine(    include\_text=True, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['author', 'Interleaf', 'work']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 104 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 104 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on a number of projects at Interleaf, including the development of the company's flagship product, the Interleaf Publisher.**### Query with embeddings[](#query-with-embeddings "Permalink to this heading")


```
# NOTE: can take a while!new\_index = KnowledgeGraphIndex.from\_documents(    documents,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,    include\_embeddings=True,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens
```

```
# query using top 3 triplets plus keywords (duplicate triplets are removed)query\_engine = index.as\_query\_engine(    include\_text=True,    response\_mode="tree\_summarize",    embedding\_mode="hybrid",    similarity\_top\_k=5,)response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['author', 'Interleaf', 'work']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 104 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 104 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on a number of projects at Interleaf, including the development of the company's flagship product, the Interleaf Publisher.**### Visualizing the Graph[](#visualizing-the-graph "Permalink to this heading")


```
## create graphfrom pyvis.network import Networkg = index.get\_networkx\_graph()net = Network(notebook=True, cdn\_resources="in\_line", directed=True)net.from\_nx(g)net.show("example.html")
```

```
example.html
```
### [Optional] Try building the graph and manually add triplets![](#id1 "Permalink to this heading")


```
from llama\_index.node\_parser import SimpleNodeParser
```

```
node\_parser = SimpleNodeParser.from\_defaults()
```

```
nodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
# initialize an empty index for nowindex = KnowledgeGraphIndex(    [],    service\_context=service\_context,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens
```

```
# add keyword mappings and nodes manually# add triplets (subject, relationship, object)# for node 0node\_0\_tups = [    ("author", "worked on", "writing"),    ("author", "worked on", "programming"),]for tup in node\_0\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[0])# for node 1node\_1\_tups = [    ("Interleaf", "made software for", "creating documents"),    ("Interleaf", "added", "scripting language"),    ("software", "generate", "web sites"),]for tup in node\_1\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[1])
```

```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['Interleaf', 'company', 'software', 'history']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 116 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 116 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
str(response)
```

```
'\nInterleaf was a software company that developed and published document preparation and desktop publishing software. It was founded in 1986 and was headquartered in Waltham, Massachusetts. The company was acquired by Quark, Inc. in 2000.'
```
