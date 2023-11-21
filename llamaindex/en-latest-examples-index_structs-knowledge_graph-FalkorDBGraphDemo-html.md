[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/index_structs/knowledge_graph/FalkorDBGraphDemo.ipynb)

FalkorDB Graph Store[](#falkordb-graph-store "Permalink to this heading")
==========================================================================

This notebook walks through configuring `FalkorDB` to be the backend for graph storage in LlamaIndex.


```
# My OpenAI Keyimport osos.environ["OPENAI\_API\_KEY"] = "API\_KEY\_HERE"
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)
```
Using Knowledge Graph with FalkorDBGraphStore[](#using-knowledge-graph-with-falkordbgraphstore "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

### Start FalkorDB[](#start-falkordb "Permalink to this heading")

The easiest way to start FalkorDB as a Graph database is using the [falkordb](https://hub.docker.com/r/falkordb/falkordb:edge) docker image.

To follow every step of this tutorial, launch the image as follows:


```
docker run -p 6379:6379 -it --rm falkordb/falkordb:edge
```

```
from llama\_index.graph\_stores import FalkorDBGraphStoregraph\_store = FalkorDBGraphStore(    "redis://localhost:6379", decode\_responses=True)
```

```
INFO:numexpr.utils:NumExpr defaulting to 8 threads.
```
#### Building the Knowledge Graph[](#building-the-knowledge-graph "Permalink to this heading")


```
from llama\_index import (    SimpleDirectoryReader,    ServiceContext,    KnowledgeGraphIndex,)from llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```

```
documents = SimpleDirectoryReader(    "../../../../examples/paul\_graham\_essay/data").load\_data()
```

```
# define LLMllm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
from llama\_index.storage.storage\_context import StorageContextstorage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    max\_triplets\_per\_chunk=2,    storage\_context=storage\_context,    service\_context=service\_context,)
```
#### Querying the Knowledge Graph[](#querying-the-knowledge-graph "Permalink to this heading")

First, we can query and send only the triplets to the LLM.


```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf is a software company that was founded in 1981. It specialized in developing and selling desktop publishing software. The company’s flagship product was called Interleaf, which was a powerful tool for creating and publishing complex documents. Interleaf’s software was widely used in industries such as aerospace, defense, and government, where there was a need for creating technical documentation and manuals. The company was acquired by BroadVision in 2000.**

For more detailed answers, we can also send the text from where the retrieved tripets were extracted.


```
query\_engine = index.as\_query\_engine(    include\_text=True, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf was a company that had smart people and built impressive technology. However, it faced challenges and eventually got crushed by Moore’s Law. The exponential growth in the power of commodity processors, particularly Intel processors, in the 1990s led to the consolidation of high-end, special-purpose hardware and software companies. Interleaf was one of the casualties of this trend. While the company had talented individuals and advanced technology, it was unable to compete with the rapid advancements in processor power.**

#### Visualizing the Graph[](#visualizing-the-graph "Permalink to this heading")


```
%pip install pyvis
```

```
## create graphfrom pyvis.network import Networkg = index.get\_networkx\_graph()net = Network(notebook=True, cdn\_resources="in\_line", directed=True)net.from\_nx(g)net.show("falkordbgraph\_draw.html")
```
