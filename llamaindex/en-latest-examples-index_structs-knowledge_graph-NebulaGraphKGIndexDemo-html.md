Nebula Graph Store[](#nebula-graph-store "Permalink to this heading")
======================================================================


```
# For OpenAIimport osos.environ["OPENAI\_API\_KEY"] = "INSERT OPENAI KEY"import loggingimport sysfrom llama\_index.llms import OpenAIlogging.basicConfig(stream=sys.stdout, level=logging.INFO)# define LLM# NOTE: at the time of demo, text-davinci-002 did not have rate-limit errorsllm = OpenAI(temperature=0, model="text-davinci-002")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
# For Azure OpenAIimport osimport jsonimport openaifrom llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStoreimport loggingimport sysfrom IPython.display import Markdown, displaylogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputlogging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))openai.api\_type = "azure"openai.api\_base = "https://<foo-bar>.openai.azure.com"openai.api\_version = "2022-12-01"os.environ["OPENAI\_API\_KEY"] = "<your-openai-key>"openai.api\_key = os.getenv("OPENAI\_API\_KEY")llm = AzureOpenAI(    model="<foo-bar-model>",    engine="<foo-bar-deployment>",    temperature=0,    api\_key=openai.api\_key,    api\_type=openai.api\_type,    api\_base=openai.api\_base,    api\_version=openai.api\_version,)llm\_predictor = LLMPredictor(llm=llm)# You need to deploy your own embedding model as well as your own chat completion modelembedding\_model = OpenAIEmbedding(    model="text-embedding-ada-002",    deployment\_name="<foo-bar-deployment>",    api\_key=openai.api\_key,    api\_base=openai.api\_base,    api\_type=openai.api\_type,    api\_version=openai.api\_version,)service\_context = ServiceContext.from\_defaults(    llm\_predictor=llm\_predictor,    embed\_model=embedding\_model,)
```
Using Knowledge Graph with NebulaGraphStore[](#using-knowledge-graph-with-nebulagraphstore "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------

### Building the Knowledge Graph[](#building-the-knowledge-graph "Permalink to this heading")


```
from llama\_index import (    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,    SimpleDirectoryReader,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStorefrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```

```
documents = SimpleDirectoryReader(    "../../../../examples/paul\_graham\_essay/data").load\_data()
```

```
# define LLM# NOTE: at the time of demo, text-davinci-002 did not have rate-limit errorsllm = OpenAI(temperature=0, model="text-davinci-002")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size\_limit=512)
```
Prepare for NebulaGraph[](#prepare-for-nebulagraph "Permalink to this heading")
--------------------------------------------------------------------------------


```
%pip install nebula3-pythonos.environ["NEBULA\_USER"] = "root"os.environ[    "NEBULA\_PASSWORD"] = "<password>"  # replace with your password, by default it is "nebula"os.environ[    "NEBULA\_ADDRESS"] = "127.0.0.1:9669"  # assumed we have NebulaGraph 3.5.0 or newer installed locally# Assume that the graph has already been created# Create a NebulaGraph cluster with:# Option 0: `curl -fsSL nebula-up.siwei.io/install.sh | bash`# Option 1: NebulaGraph Docker Extension https://hub.docker.com/extensions/weygu/nebulagraph-dd-ext# and that the graph space is called "paul\_graham\_essay"# If not, create it with the following commands from NebulaGraph's console:# CREATE SPACE paul\_graham\_essay(vid\_type=FIXED\_STRING(256), partition\_num=1, replica\_factor=1);# :sleep 10;# USE paul\_graham\_essay;# CREATE TAG entity(name string);# CREATE EDGE relationship(relationship string);# CREATE TAG INDEX entity\_index ON entity(name(256));space\_name = "paul\_graham\_essay"edge\_types, rel\_prop\_names = ["relationship"], [    "relationship"]  # default, could be omit if create from an empty kgtags = ["entity"]  # default, could be omit if create from an empty kg
```
Instantiate GPTNebulaGraph KG Indexes[](#instantiate-gptnebulagraph-kg-indexes "Permalink to this heading")
------------------------------------------------------------------------------------------------------------


```
graph\_store = NebulaGraphStore(    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,)
```
### Querying the Knowledge Graph[](#querying-the-knowledge-graph "Permalink to this heading")


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("Tell me more about Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['Interleaf', 'history', 'software', 'company']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 6aa6a716-7390-4783-955b-8169fab25bb1: worth trying.Our teacher, professor Ulivi, was a nice guy. He could see I w...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 79f2a1b4-80bb-416f-a259-ebfc3136b2fe: on a map of New York City: if you zoom in on the Upper East Side, there's a t...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 1e707b8c-b62a-4c1a-a908-c79e77b9692b: buyers pay a lot for such work. [6]There were plenty of earnest students to...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 31c2f53c-928a-4ed0-88fc-df92dba47c33: for example, that the reason the color changes suddenly at a certain point is...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: f51d8a1c-06bc-45aa-bed1-1714ae4e5fb9: the software is an online store builder and you're hosting the stores, if you...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 008052a0-a64b-4e3c-a2af-4963896bfc19: Engineering that seemed to be at least as big as the group that actually wrot...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: b1f5a610-9e0a-4e3e-ba96-514ae7d63a84: closures stored in a hash table on the server.It helped to have studied art...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: f7cc82a7-76e0-4a06-9f50-d681404c5bce: of Robert's apartment in Cambridge. His roommate was away for big chunks of t...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: db626325-035a-4f67-87c0-1e770b80f4a6: want to be online, and still don't, not the fancy ones. That's not how they s...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 73e76f4b-0ebe-4af6-9c2d-6affae81373b: But in the long term the growth rate takes care of the absolute number. If we...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`software ['is', 'web app', 'common', 'now']software ['is', 'web app', "wasn't clear", 'it was possible']software ['generate', 'web sites']software ['worked', 'via web']software ['is', 'web app']software ['has', 'three main parts']software ['is', 'online store builder']Lisp ['has dialects', 'because']Lisp ['rare', 'C++']Lisp ['is', 'language']Lisp ['has dialects', '']Lisp ['has dialects', 'because one of the distinctive features of the language is that it has dialects']Lisp ['was regarded as', 'language of AI']Lisp ['defined by', 'writing an interpreter']Lisp ['was meant to be', 'formal model of computation']Interleaf ['added', 'scripting language']Interleaf ['made software for', 'creating documents']Interleaf ['was how I learned that', 'low end software tends to eat high end software']Interleaf ['was', 'on the way down']Interleaf ['on the way down', '1993']RISD ['was', 'art school']RISD ['counted me as', 'transfer sophomore']RISD ['was', 'supposed to be the best art school in the country']RISD ['was', 'the best art school in the country']Robert ['wrote', 'shopping cart', 'written by', 'robert']Robert ['wrote', 'shopping cart', 'written by', 'Robert']Robert ['wrote', 'shopping cart']Robert Morris ['offered', 'unsolicited advice']Yorkville ['is', 'tiny corner']Yorkville ["wasn't", 'rich']online ['is not', 'publishing online']online ['is not', 'publishing online', 'means', 'you treat the online version as the primary version']web app ['common', 'now']web app ["wasn't clear", 'it was possible']editor ['written by', 'author']shopping cart ['written by', 'Robert', 'wrote', 'shopping cart']shopping cart ['written by', 'Robert']shopping cart ['written by', 'robert', 'wrote', 'shopping cart']shopping cart ['written by', 'robert']Robert ['wrote', 'shopping cart', 'written by', 'Robert']Robert ['wrote', 'shopping cart', 'written by', 'robert']Robert ['wrote', 'shopping cart']Lisp ['defined by', 'writing an interpreter']Lisp ['has dialects', 'because']Lisp ['was meant to be', 'formal model of computation']Lisp ['rare', 'C++']Lisp ['is', 'language']Lisp ['has dialects', '']Lisp ['has dialects', 'because one of the distinctive features of the language is that it has dialects']Lisp ['was regarded as', 'language of AI']Y Combinator ['would have said', 'Stop being so stressed out']Y Combinator ['helps', 'founders']Y Combinator ['is', 'investment firm']company ['reaches breakeven', 'when yahoo buys it']company ['gave', 'business advice']company ['reaches breakeven', 'when Yahoo buys it']software ['worked', 'via web']software ['is', 'web app', "wasn't clear", 'it was possible']software ['generate', 'web sites']software ['has', 'three main parts']software ['is', 'online store builder']software ['is', 'web app']software ['is', 'web app', 'common', 'now']Y Combinator ['would have said', 'Stop being so stressed out']Y Combinator ['is', 'investment firm']Y Combinator ['helps', 'founders']company ['gave', 'business advice']company ['reaches breakeven', 'when Yahoo buys it']company ['reaches breakeven', 'when yahoo buys it']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 5916 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf was a software company that made software for creating documents. Their software was inspired by Emacs, and included a scripting language that was a dialect of Lisp. The company was started in the 1990s, and eventually went out of business.**
```
response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retrievers:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retrievers:> Query keywords: ['Interleaf', 'author', 'work']ERROR:llama_index.indices.knowledge_graph.retrievers:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 6aa6a716-7390-4783-955b-8169fab25bb1: worth trying.Our teacher, professor Ulivi, was a nice guy. He could see I w...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 79f2a1b4-80bb-416f-a259-ebfc3136b2fe: on a map of New York City: if you zoom in on the Upper East Side, there's a t...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 1e707b8c-b62a-4c1a-a908-c79e77b9692b: buyers pay a lot for such work. [6]There were plenty of earnest students to...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 31c2f53c-928a-4ed0-88fc-df92dba47c33: for example, that the reason the color changes suddenly at a certain point is...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: b1f5a610-9e0a-4e3e-ba96-514ae7d63a84: closures stored in a hash table on the server.It helped to have studied art...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: 6cda9196-dcdb-4441-8f27-ff3f18779c4c: so easy. And that implies that HN was a mistake. Surely the biggest source of...INFO:llama_index.indices.knowledge_graph.retrievers:> Querying with idx: a467cf4c-19cf-490f-92ad-ce03c8d91231: I've noticed in my life is how well it has worked, for me at least, to work o...INFO:llama_index.indices.knowledge_graph.retrievers:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`software ['is', 'web app', 'common', 'now']software ['is', 'web app', "wasn't clear", 'it was possible']software ['generate', 'web sites']software ['worked', 'via web']software ['is', 'web app']software ['has', 'three main parts']software ['is', 'online store builder']Lisp ['has dialects', 'because']Lisp ['rare', 'C++']Lisp ['is', 'language']Lisp ['has dialects', '']Lisp ['has dialects', 'because one of the distinctive features of the language is that it has dialects']Lisp ['was regarded as', 'language of AI']Lisp ['defined by', 'writing an interpreter']Lisp ['was meant to be', 'formal model of computation']Interleaf ['added', 'scripting language']Interleaf ['made software for', 'creating documents']Interleaf ['was how I learned that', 'low end software tends to eat high end software']Interleaf ['was', 'on the way down']Interleaf ['on the way down', '1993']RISD ['was', 'art school']RISD ['counted me as', 'transfer sophomore']RISD ['was', 'supposed to be the best art school in the country']RISD ['was', 'the best art school in the country']Robert ['wrote', 'shopping cart', 'written by', 'robert']Robert ['wrote', 'shopping cart', 'written by', 'Robert']Robert ['wrote', 'shopping cart']Robert Morris ['offered', 'unsolicited advice']Yorkville ['is', 'tiny corner']Yorkville ["wasn't", 'rich']shopping cart ['written by', 'Robert', 'wrote', 'shopping cart']shopping cart ['written by', 'robert', 'wrote', 'shopping cart']shopping cart ['written by', 'Robert']shopping cart ['written by', 'robert']online ['is not', 'publishing online', 'means', 'you treat the online version as the primary version']online ['is not', 'publishing online']software ['has', 'three main parts']software ['generate', 'web sites']software ['is', 'web app', 'common', 'now']software ['is', 'online store builder']software ['is', 'web app']software ['is', 'web app', "wasn't clear", 'it was possible']software ['worked', 'via web']editor ['written by', 'author']YC ['is', 'work', 'is unprestigious', '']YC ['grew', 'more exciting']YC ['founded in', 'Berkeley']YC ['founded in', '2005']YC ['founded in', '1982']YC ['is', 'full-time job']YC ['is', 'engaging work']YC ['is', 'batch model']YC ['is', 'Summer Founders Program']YC ['was', 'coffee shop']YC ['invests in', 'startups']YC ['is', 'fund']YC ['started to notice', 'other advantages']YC ['grew', 'quickly']YC ['controlled by', 'founders']YC ['is', 'work']YC ['became', 'full-time job']YC ['is self-funded', 'by Heroku']YC ['is', 'hard work']YC ['funds', 'startups']YC ['controlled by', 'LLC']Robert ['wrote', 'shopping cart']Robert ['wrote', 'shopping cart', 'written by', 'Robert']Robert ['wrote', 'shopping cart', 'written by', 'robert']Lisp ['was meant to be', 'formal model of computation']Lisp ['defined by', 'writing an interpreter']Lisp ['was regarded as', 'language of AI']Lisp ['has dialects', 'because']Lisp ['has dialects', '']Lisp ['has dialects', 'because one of the distinctive features of the language is that it has dialects']Lisp ['rare', 'C++']Lisp ['is', 'language']party ['was', 'clever idea']Y Combinator ['would have said', 'Stop being so stressed out']Y Combinator ['is', 'investment firm']Y Combinator ['helps', 'founders']Robert Morris ['offered', 'unsolicited advice']work ['is unprestigious', '']Jessica Livingston ['is', 'woman']Jessica Livingston ['decided', 'compile book']HN ['edge case', 'bizarre']HN ['edge case', 'when you both write essays and run a forum']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 4651 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on a software that allowed users to create documents, which was inspired by Emacs. The software had a scripting language that was a dialect of Lisp, and the author was responsible for writing things in this language.

The author also worked on a software that allowed users to generate web sites. This software was a web app and was written in a dialect of Lisp. The author was also responsible for writing things in this language.**Visualizing the Graph RAG[](#visualizing-the-graph-rag "Permalink to this heading")
------------------------------------------------------------------------------------

If we visualize the Graph based RAG, starting from the term `['Interleaf', 'history', 'Software', 'Company']` , we could see how those connected context looks like, and it’s a different form of Info./Knowledge:

* Refined and Concise Form
* Fine-grained Segmentation
* Interconnected-sturcutred nature


```
%pip install ipython-ngql networkx pyvis%load\_ext ngql
```

```
%ngql --address 127.0.0.1 --port 9669 --user root --password <password>
```

```
Connection Pool CreatedINFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)Get connection to ('127.0.0.1', 9669)
```


|  | Name |
| --- | --- |
| 0 | Apple\_Vision\_Pro |
| 1 | basketballplayer |
| 2 | demo\_ai\_ops |
| 3 | demo\_basketballplayer |
| 4 | demo\_data\_lineage |
| 5 | demo\_fifa\_2022 |
| 6 | demo\_fraud\_detection |
| 7 | demo\_identity\_resolution |
| 8 | demo\_movie\_recommendation |
| 9 | demo\_sns |
| 10 | guardians |
| 11 | k8s |
| 12 | langchain |
| 13 | llamaindex |
| 14 | paul\_graham\_essay |
| 15 | squid\_game |
| 16 | test |


```
%%ngqlUSE paul_graham_essay;MATCH p=(n)-[*1..2]-()  WHERE id(n) IN ['Interleaf', 'history', 'Software', 'Company'] RETURN p LIMIT 100;
```

```
INFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)Get connection to ('127.0.0.1', 9669)
```


|  | p |
| --- | --- |
| 0 | ("Interleaf" :entity{name: "Interleaf"})-[:rel... |
| 1 | ("Interleaf" :entity{name: "Interleaf"})-[:rel... |
| 2 | ("Interleaf" :entity{name: "Interleaf"})-[:rel... |
| 3 | ("Interleaf" :entity{name: "Interleaf"})-[:rel... |


```
%ng\_draw
```

```
nebulagraph_draw.html
```
### Query with embeddings[](#query-with-embeddings "Permalink to this heading")


```
# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,    include\_embeddings=True,)query\_engine = index.as\_query\_engine(    include\_text=True,    response\_mode="tree\_summarize",    embedding\_mode="hybrid",    similarity\_top\_k=5,)
```

```
# query using top 3 triplets plus keywords (duplicate triplets are removed)response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf")
```

```
display(Markdown(f"<b>{response}</b>"))
```
### Query with more global(cross node) context[](#query-with-more-global-cross-node-context "Permalink to this heading")


```
query\_engine = index.as\_query\_engine(    include\_text=True,    response\_mode="tree\_summarize",    embedding\_mode="hybrid",    similarity\_top\_k=5,    explore\_global\_knowledge=True,)response = query\_engine.query("Tell me more about what the author and Lisp")
```
### Visualizing the Graph[](#visualizing-the-graph "Permalink to this heading")


```
## create graphfrom pyvis.network import Networkg = index.get\_networkx\_graph()net = Network(notebook=True, cdn\_resources="in\_line", directed=True)net.from\_nx(g)net.show("example.html")
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
# not yet implemented# initialize an empty index for nowindex = KnowledgeGraphIndex.from\_documents([], storage\_context=storage\_context)
```

```
# add keyword mappings and nodes manually# add triplets (subject, relationship, object)# for node 0node\_0\_tups = [    ("author", "worked on", "writing"),    ("author", "worked on", "programming"),]for tup in node\_0\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[0])# for node 1node\_1\_tups = [    ("Interleaf", "made software for", "creating documents"),    ("Interleaf", "added", "scripting language"),    ("software", "generate", "web sites"),]for tup in node\_1\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[1])
```

```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query("Tell me more about Interleaf")
```

```
str(response)
```
