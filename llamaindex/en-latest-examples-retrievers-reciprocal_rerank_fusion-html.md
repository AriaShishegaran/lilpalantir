[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/retrievers/reciprocal_rerank_fusion.ipynb)

Reciprocal Rerank Fusion Retriever[](#reciprocal-rerank-fusion-retriever "Permalink to this heading")
======================================================================================================

In this example, we walk through how you can combine retireval results from multiple queries and multiple indexes.

The retrieved nodes will be reranked according to the `Reciprocal Rerank Fusion` algorithm demonstrated in this [paper](https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf). It provides an effecient method for rerranking retrieval results without excessive computation or reliance on external models.

Full credits go to @Raduaschl on github for their [example implementation here](https://github.com/Raudaschl/rag-fusion).


```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.

Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
Next, we will setup a vector index over the documentation.


```
from llama\_index import VectorStoreIndex, ServiceContextservice\_context = ServiceContext.from\_defaults(chunk\_size=256)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
Create a Hybrid Fusion Retriever[](#create-a-hybrid-fusion-retriever "Permalink to this heading")
--------------------------------------------------------------------------------------------------

In this step, we fuse our index with a BM25 based retriever. This will enable us to capture both semantic relations and keywords in our input queries.

Since both of these retrievers calculate a score, we can use the reciprocal rerank algorithm to re-sort our nodes without using an additional models or excessive computation.

This setup will also query 4 times, once with your original query, and generate 3 more queries.

By default, it uses the following prompt to generate extra queries:


```
QUERY\_GEN\_PROMPT = (    "You are a helpful assistant that generates multiple search queries based on a "    "single input query. Generate {num\_queries} search queries, one on each line, "    "related to the following input query:\n"    "Query: {query}\n"    "Queries:\n")
```
First, we create our retrievers. Each will retrieve the top-2 most similar nodes:


```
from llama\_index.retrievers import BM25Retrievervector\_retriever = index.as\_retriever(similarity\_top\_k=2)bm25\_retriever = BM25Retriever.from\_defaults(    docstore=index.docstore, similarity\_top\_k=2)
```
Next, we can create our fusion retriever, which well return the top-2 most similar nodes from the 4 returned nodes from the retrievers:


```
from llama\_index.retrievers import QueryFusionRetrieverretriever = QueryFusionRetriever(    [vector\_retriever, bm25\_retriever],    similarity\_top\_k=2,    num\_queries=4,  # set this to 1 to disable query generation    mode="reciprocal\_rerank",    use\_async=True,    verbose=True,    # query\_gen\_prompt="...", # we could override the query generation prompt here)
```

```
# apply nested async to run in a notebookimport nest\_asyncionest\_asyncio.apply()
```

```
nodes\_with\_scores = retriever.retrieve(    "What happened at Interleafe and Viaweb?")
```

```
Generated queries:1. What were the major events or milestones in the history of Interleafe and Viaweb?2. Can you provide a timeline of the key developments and achievements of Interleafe and Viaweb?3. What were the successes and failures of Interleafe and Viaweb as companies?
```

```
for node in nodes\_with\_scores:    print(f"Score: {node.score:.2f} - {node.text}...\n-----\n")
```

```
Score: 0.05 - Now you could just update the software right on the server.We started a new company we called Viaweb, after the fact that our software worked via the web, and we got $10,000 in seed funding from Idelle's husband Julian. In return for that and doing the initial legal work and giving us business advice, we gave him 10% of the company. Ten years later this deal became the model for Y Combinator's. We knew founders needed something like this, because we'd needed it ourselves.At this stage I had a negative net worth, because the thousand dollars or so I had in the bank was more than counterbalanced by what I owed the government in taxes. (Had I diligently set aside the proper proportion of the money I'd made consulting for Interleaf? No, I had not.) So although Robert had his graduate student stipend, I needed that seed funding to live on.We originally hoped to launch in September, but we got more ambitious about the software as we worked on it....-----Score: 0.03 - [8]There were three main parts to the software: the editor, which people used to build sites and which I wrote, the shopping cart, which Robert wrote, and the manager, which kept track of orders and statistics, and which Trevor wrote. In its time, the editor was one of the best general-purpose site builders. I kept the code tight and didn't have to integrate with any other software except Robert's and Trevor's, so it was quite fun to work on. If all I'd had to do was work on this software, the next 3 years would have been the easiest of my life. Unfortunately I had to do a lot more, all of it stuff I was worse at than programming, and the next 3 years were instead the most stressful.There were a lot of startups making ecommerce software in the second half of the 90s. We were determined to be the Microsoft Word, not the Interleaf. Which meant being easy to use and inexpensive. It was lucky for us that we were poor, because that caused us to make Viaweb even more inexpensive than we realized. We charged $100 a month for a small store and $300 a month for a big one....-----
```
As we can see, both retruned nodes correctly mention Viaweb and Interleaf!

Use in a Query Engine![](#use-in-a-query-engine "Permalink to this heading")
-----------------------------------------------------------------------------

Now, we can plug our retriever into a query engine to synthesize natural language responses.


```
from llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine.from\_args(retriever)
```

```
response = query\_engine.query("What happened at Interleafe and Viaweb?")
```

```
Generated queries:1. What were the major events or milestones in the history of Interleafe and Viaweb?2. Can you provide a timeline of the key developments and achievements of Interleafe and Viaweb?3. What were the successes and failures of Interleafe and Viaweb as companies?
```

```
from llama\_index.response.notebook\_utils import display\_responsedisplay\_response(response)
```
**`Final Response:`** At Interleaf, the author had worked as a consultant and had made some money. However, they did not set aside the proper proportion of the money to pay taxes, resulting in a negative net worth.

At Viaweb, the author and their team started a new company that developed software for building websites and managing online stores. They received $10,000 in seed funding from Julian, who was the husband of Idelle. In return for the funding and business advice, Julian received a 10% stake in the company. The software developed by Viaweb was designed to be easy to use and inexpensive, with prices ranging from $100 to $300 per month.

