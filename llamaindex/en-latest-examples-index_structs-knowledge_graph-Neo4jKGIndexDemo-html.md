Neo4j Graph Store[](#neo4j-graph-store "Permalink to this heading")
====================================================================


```
# For OpenAIimport osos.environ["OPENAI\_API\_KEY"] = "API\_KEY\_HERE"import loggingimport sysfrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContextlogging.basicConfig(stream=sys.stdout, level=logging.INFO)# define LLMllm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
# For Azure OpenAIimport osimport jsonimport openaifrom llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,)import loggingimport sysfrom IPython.display import Markdown, displaylogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputlogging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))openai.api\_type = "azure"openai.api\_base = "https://<foo-bar>.openai.azure.com"openai.api\_version = "2022-12-01"os.environ["OPENAI\_API\_KEY"] = "<your-openai-key>"openai.api\_key = os.getenv("OPENAI\_API\_KEY")llm = AzureOpenAI(    deployment\_name="<foo-bar-deployment>",    temperature=0,    openai\_api\_version=openai.api\_version,    model\_kwargs={        "api\_key": openai.api\_key,        "api\_base": openai.api\_base,        "api\_type": openai.api\_type,        "api\_version": openai.api\_version,    },)llm\_predictor = LLMPredictor(llm=llm)# You need to deploy your own embedding model as well as your own chat completion modelembedding\_llm = OpenAIEmbedding(    model="text-embedding-ada-002",    deployment\_name="<foo-bar-deployment>",    api\_key=openai.api\_key,    api\_base=openai.api\_base,    api\_type=openai.api\_type,    api\_version=openai.api\_version,)service\_context = ServiceContext.from\_defaults(    llm\_predictor=llm\_predictor,    embed\_model=embedding\_llm,)
```
Using Knowledge Graph with Neo4jGraphStore[](#using-knowledge-graph-with-neo4jgraphstore "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------

### Building the Knowledge Graph[](#building-the-knowledge-graph "Permalink to this heading")


```
from llama\_index import (    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,    SimpleDirectoryReader,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import Neo4jGraphStorefrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```

```
documents = SimpleDirectoryReader(    "../../../../examples/paul\_graham\_essay/data").load\_data()
```

```
# define LLMllm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```
Prepare for Neo4j[](#prepare-for-neo4j "Permalink to this heading")
--------------------------------------------------------------------


```
%pip install neo4jusername = "neo4j"password = "retractor-knot-thermocouples"url = "bolt://44.211.44.239:7687"database = "neo4j"
```

```
Requirement already satisfied: neo4j in /home/tomaz/anaconda3/envs/snakes/lib/python3.9/site-packages (5.11.0)Requirement already satisfied: pytz in /home/tomaz/anaconda3/envs/snakes/lib/python3.9/site-packages (from neo4j) (2023.3)Note: you may need to restart the kernel to use updated packages.
```
Instantiate Neo4jGraph KG Indexes[](#instantiate-neo4jgraph-kg-indexes "Permalink to this heading")
----------------------------------------------------------------------------------------------------


```
graph\_store = Neo4jGraphStore(    username=username,    password=password,    url=url,    database=database,)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,)
```
### Querying the Knowledge Graph[](#querying-the-knowledge-graph "Permalink to this heading")

First, we can query and send only the triplets to the LLM.


```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query("Tell me more about Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['IS_ABOUT', 'what not to do']Interleaf ['ADDED', 'scripting language']Interleaf ['MADE', 'software for creating documents']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf is a subject that is related to “what not to do” and “scripting language”. It is also associated with the predicates “ADDED” and “MADE”, with the objects being “scripting language” and “software for creating documents” respectively.**

For more detailed answers, we can also send the text from where the retrieved tripets were extracted.


```
query\_engine = index.as\_query\_engine(    include\_text=True, response\_mode="tree\_summarize")response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf', 'worked', 'author']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: c3fd9444-6c20-4cdc-9598-8f0e9ed0b85d: each student had. But the Accademia wasn't teaching me anything except Italia...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: f4bfad23-0cde-4425-99f9-9229ca0a5cc5: learned some useful things at Interleaf, though they were mostly about what n...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['IS_ABOUT', 'what not to do']Interleaf ['ADDED', 'scripting language']Interleaf ['MADE', 'software for creating documents']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**At Interleaf, the author worked on software for creating documents. The company had added a scripting language, inspired by Emacs, and the author was hired as a Lisp hacker to write things in it. However, the author admits to being a bad employee and not fully understanding the software, as it was primarily written in C. Despite this, the author was paid well and managed to save enough money to go back to RISD and pay off their college loans. The author also learned some valuable lessons at Interleaf, particularly about what not to do in technology companies.**

### Query with embeddings[](#query-with-embeddings "Permalink to this heading")


```
# Clean dataset firstgraph\_store.query( """MATCH (n) DETACH DELETE n""")# NOTE: can take a while!index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=2,    service\_context=service\_context,    include\_embeddings=True,)query\_engine = index.as\_query\_engine(    include\_text=True,    response\_mode="tree\_summarize",    embedding\_mode="hybrid",    similarity\_top\_k=5,)
```

```
# query using top 3 triplets plus keywords (duplicate triplets are removed)response = query\_engine.query(    "Tell me more about what the author worked on at Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about what the author worked on at InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Interleaf', 'worked', 'author']INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: e0067958-8b62-4186-b78c-a07281531e40: each student had. But the Accademia wasn't teaching me anything except Italia...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 38459cd5-bc20-428d-a2db-9dc2e716bd15: learned some useful things at Interleaf, though they were mostly about what n...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 6be24830-85d5-49d1-8caa-d297cd0e8b14: It had been so long since I'd painted anything that I'd half forgotten why I ...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 2ec81827-d6d5-470d-8851-b97b8d8d80b4: Robert Morris showed it to me when I visited him in Cambridge, where he was n...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 46b8b977-4176-4622-8d4d-ee3ab16132b4: in decent shape at painting and drawing from the RISD foundation that summer,...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 71363c09-ec6b-47c8-86ac-e18be46f1cc2: as scare-quotes. At the time this bothered me, but now it seems amusingly acc...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 2dded283-d876-4014-8352-056fccace896: of my old life. Idelle was in New York at least, and there were other people ...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: de937aec-ebee-4348-9f23-c94d0a5d7436: and I had a lot of time to think on those flights. On one of them I realized ...INFO:llama_index.indices.knowledge_graph.retriever:> Querying with idx: 33936f7a-0f89-48c7-af9a-171372b4b4b0: What I Worked OnFebruary 2021Before college the two main things I worked ...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`('Interleaf', 'made', 'software for creating documents')Interleaf ['MADE', 'software for creating documents']('Interleaf', 'added', 'scripting language')('Interleaf', 'is about', 'what not to do')Interleaf ['ADDED', 'scripting language']Interleaf ['IS_ABOUT', 'what not to do']('I', 'worked on', 'programming')('I', 'worked on', 'writing')
```

```
display(Markdown(f"<b>{response}</b>"))
```
**At Interleaf, the author worked on writing scripts in a Lisp dialect for the company’s software, which was used for creating documents.**

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
# initialize an empty index for nowindex = KnowledgeGraphIndex.from\_documents([], storage\_context=storage\_context)
```

```
# add keyword mappings and nodes manually# add triplets (subject, relationship, object)# for node 0node\_0\_tups = [    ("author", "worked on", "writing"),    ("author", "worked on", "programming"),]for tup in node\_0\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[0])# for node 1node\_1\_tups = [    ("Interleaf", "made software for", "creating documents"),    ("Interleaf", "added", "scripting language"),    ("software", "generate", "web sites"),]for tup in node\_1\_tups:    index.upsert\_triplet\_and\_node(tup, nodes[1])
```

```
query\_engine = index.as\_query\_engine(    include\_text=False, response\_mode="tree\_summarize")response = query\_engine.query("Tell me more about Interleaf")
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me more about InterleafINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['Solutions', 'Interleaf', 'Software', 'Information', 'Technology']ERROR:llama_index.indices.knowledge_graph.retriever:Index was not constructed with embeddings, skipping embedding usage...INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge sequence in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`Interleaf ['MADE_SOFTWARE_FOR', 'creating documents']Interleaf ['IS_ABOUT', 'what not to do']Interleaf ['ADDED', 'scripting language']Interleaf ['MADE', 'software for creating documents']
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Interleaf is a software company that specializes in creating documents. It has added a scripting language to its software to make it easier for users to create documents. It also provides advice on what not to do when creating documents.**