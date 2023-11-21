Kùzu Graph Store[](#kuzu-graph-store "Permalink to this heading")
==================================================================

This notebook walks through configuring `Kùzu` to be the backend for graph storage in LlamaIndex.


```
# My OpenAI Keyimport osos.environ["OPENAI\_API\_KEY"] = "API\_KEY\_HERE"
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)
```
Prepare for Kùzu[](#prepare-for-kuzu "Permalink to this heading")
------------------------------------------------------------------


```
# Clean up all the directories used in this notebookimport shutilshutil.rmtree("./test1", ignore\_errors=True)shutil.rmtree("./test2", ignore\_errors=True)shutil.rmtree("./test3", ignore\_errors=True)
```

```
%pip install kuzuimport kuzudb = kuzu.Database("test1")
```

```
Collecting kuzu  Downloading kuzu-0.0.6-cp39-cp39-macosx_11_0_arm64.whl (5.5 MB)     |████████████████████████████████| 5.5 MB 4.8 MB/s eta 0:00:01?25hInstalling collected packages: kuzuSuccessfully installed kuzu-0.0.6WARNING: You are using pip version 21.2.4; however, version 23.2.1 is available.You should consider upgrading via the '/Users/loganmarkewich/llama\_index/llama-index/bin/python -m pip install --upgrade pip' command.Note: you may need to restart the kernel to use updated packages.
```
Using Knowledge Graph with KuzuGraphStore[](#using-knowledge-graph-with-kuzugraphstore "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------


```
from llama\_index.graph\_stores import KuzuGraphStoregraph\_store = KuzuGraphStore(db)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.
```
### Building the Knowledge Graph[](#building-the-knowledge-graph "Permalink to this heading")


```
from llama\_index import (    SimpleDirectoryReader,    ServiceContext,    KnowledgeGraphIndex,)from llama\_index.llms import OpenAIfrom IPython.display import Markdown, displayimport kuzu
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
### Querying the Knowledge Graph[](#querying-the-knowledge-graph "Permalink to this heading")

First, we can query and send only the triplets to the LLM.


```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about Interleaf
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['made', 'software for creating documents']Interleaf ['added', 'scripting language']Interleaf ['taught', 'what not to do']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf is a company that made software for creating documents. They also added a scripting language to their software. Additionally, they taught what not to do.**

For more detailed answers, we can also send the text from where the retrieved tripets were extracted.


```
query\_engine = index.as\_query\_engine(    include\_text=True, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 144f784c-d052-4fed-86f8-c895da6e13df: each student had. But the Accademia wasn't teaching me anything except Italia...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 7c877dd3-3375-4ab7-8745-e0dfbabfe5bd: learned some useful things at Interleaf, though they were mostly about what n...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['made', 'software for creating documents']Interleaf ['added', 'scripting language']Interleaf ['taught', 'what not to do']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf was a company that made software for creating documents. They were inspired by Emacs and added a scripting language to their software, which was a dialect of Lisp. The company hired a Lisp hacker to write things in this scripting language. The narrator worked at Interleaf for a year but admits to being a bad employee. They found it difficult to understand most of the software because it was primarily written in C, a language they did not know or want to learn. Despite this, they were paid well and managed to save enough money to go back to RISD and pay off their college loans. The narrator also learned some valuable lessons at Interleaf, such as the importance of having product people rather than sales people running technology companies, the drawbacks of having too many people edit code, the impact of office space on productivity, the value of corridor conversations over planned meetings, the challenges of dealing with big bureaucratic customers, and the importance of being the “entry level” option in a market.**

### Query with embeddings[](#query-with-embeddings "Permalink to this heading")


```
# NOTE: can take a while!db = kuzu.Database("test2")graph\_store = KuzuGraphStore(db)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)new\_index = KnowledgeGraphIndex.from\_documents(    documents,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,    storage\_context=storage\_context,    include\_embeddings=True,)
```

```
WARNING:llama_index.llms.openai_utils:Retrying llama_index.llms.openai_utils.completion_with_retry.<locals>._completion_with_retry in 4.0 seconds as it raised ServiceUnavailableError: The server is overloaded or not ready yet..
```

```
rel\_map = graph\_store.get\_rel\_map()
```

```
# query using top 3 triplets plus keywords (duplicate triplets are removed)query\_engine = index.as\_query\_engine(    include\_text=True,    response\_mode="tree\_summarize",    embedding\_mode="hybrid",    similarity\_top\_k=5,)response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf', 'author', 'worked']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 144f784c-d052-4fed-86f8-c895da6e13df: each student had. But the Accademia wasn't teaching me anything except Italia...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 7c877dd3-3375-4ab7-8745-e0dfbabfe5bd: learned some useful things at Interleaf, though they were mostly about what n...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['made', 'software for creating documents']Interleaf ['added', 'scripting language']Interleaf ['taught', 'what not to do']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**At Interleaf, the author worked on creating software for creating documents. They also worked on adding a scripting language, which was inspired by Emacs and was a dialect of Lisp. However, the author admits to being a bad employee and not fully understanding the software, as it was primarily written in C. They also mention that they spent a lot of time working on their book “On Lisp” during their time at Interleaf. Overall, the author learned some useful things at Interleaf, particularly about what not to do in technology companies.**

### Visualizing the Graph[](#visualizing-the-graph "Permalink to this heading")


```
%pip install pyvis
```

```
Collecting pyvis  Downloading pyvis-0.3.2-py3-none-any.whl (756 kB)     |████████████████████████████████| 756 kB 2.0 MB/s eta 0:00:01?25hCollecting jsonpickle>=1.4.1  Downloading jsonpickle-3.0.1-py2.py3-none-any.whl (40 kB)     |████████████████████████████████| 40 kB 4.1 MB/s eta 0:00:01?25hRequirement already satisfied: networkx>=1.11 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pyvis) (3.1)Requirement already satisfied: ipython>=5.3.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pyvis) (8.10.0)Requirement already satisfied: jinja2>=2.9.6 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pyvis) (3.1.2)Requirement already satisfied: pexpect>4.3 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (4.8.0)Requirement already satisfied: backcall in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.2.0)Requirement already satisfied: decorator in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (5.1.1)Requirement already satisfied: pickleshare in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.7.5)Requirement already satisfied: prompt-toolkit<3.1.0,>=3.0.30 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (3.0.39)Requirement already satisfied: appnope in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.1.3)Requirement already satisfied: pygments>=2.4.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (2.15.1)Requirement already satisfied: traitlets>=5 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (5.9.0)Requirement already satisfied: jedi>=0.16 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.18.2)Requirement already satisfied: matplotlib-inline in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.1.6)Requirement already satisfied: stack-data in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.6.2)Requirement already satisfied: parso<0.9.0,>=0.8.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from jedi>=0.16->ipython>=5.3.0->pyvis) (0.8.3)Requirement already satisfied: MarkupSafe>=2.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from jinja2>=2.9.6->pyvis) (2.1.3)Requirement already satisfied: ptyprocess>=0.5 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pexpect>4.3->ipython>=5.3.0->pyvis) (0.7.0)Requirement already satisfied: wcwidth in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from prompt-toolkit<3.1.0,>=3.0.30->ipython>=5.3.0->pyvis) (0.2.6)Requirement already satisfied: executing>=1.2.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (1.2.0)Requirement already satisfied: asttokens>=2.1.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (2.2.1)Requirement already satisfied: pure-eval in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (0.2.2)Requirement already satisfied: six in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from asttokens>=2.1.0->stack-data->ipython>=5.3.0->pyvis) (1.16.0)Installing collected packages: jsonpickle, pyvisSuccessfully installed jsonpickle-3.0.1 pyvis-0.3.2WARNING: You are using pip version 21.2.4; however, version 23.2.1 is available.You should consider upgrading via the '/Users/loganmarkewich/llama\_index/llama-index/bin/python -m pip install --upgrade pip' command.Note: you may need to restart the kernel to use updated packages.
```

```
## create graphfrom pyvis.network import Networkg = index.get\_networkx\_graph()net = Network(notebook=True, cdn\_resources="in\_line", directed=True)net.from\_nx(g)net.show("kuzugraph\_draw.html")
```

```
kuzugraph_draw.html
```
### [Optional] Try building the graph and manually add triplets![](#optional-try-building-the-graph-and-manually-add-triplets "Permalink to this heading")


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
# initialize an empty databasedb = kuzu.Database("test3")graph\_store = KuzuGraphStore(db)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)index = KnowledgeGraphIndex(    [],    service\_context=service\_context,    storage\_context=storage\_context,)
```

```
# add keyword mappings and nodes manually# add triplets (subject, relationship, object)# for node 0node\_0\_tups = [    ("author", "worked on", "writing"),    ("author", "worked on", "programming"),]for tup in node\_0\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[0])# for node 1node\_1\_tups = [    ("Interleaf", "made software for", "creating documents"),    ("Interleaf", "added", "scripting language"),    ("software", "generate", "web sites"),]for tup in node\_1\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[1])
```

```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about Interleaf",)
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['made software for', 'creating documents']Interleaf ['added', 'scripting language']
```

```
str(response)
```

```
'Interleaf is a software company that specializes in creating documents. They have also added a scripting language to their software.'
```
