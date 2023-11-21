[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/retrievers/ensemble_retrieval.ipynb)

Ensemble Retrieval Guide[](#ensemble-retrieval-guide "Permalink to this heading")
==================================================================================

Oftentimes when building a RAG applications there are many retreival parameters/strategies to decide from (from chunk size to vector vs. keyword vs. hybrid search, for instance).

Thought: what if we could try a bunch of strategies at once, and have any AI/reranker/LLM prune the results?

This achieves two purposes:

* Better (albeit more costly) retrieved results by pooling results from multiple strategies, assuming the reranker is good
* A way to benchmark different retrieval strategies against each other (w.r.t reranker)

This guide showcases this over the Llama 2 paper. We do ensemble retrieval over different chunk sizes and also different indices.

**NOTE**: A closely related guide is our [Ensemble Query Engine Guide](https://gpt-index.readthedocs.io/en/stable/examples/query_engine/ensemble_qury_engine.html) - make sure to check it out!


```
%load\_ext autoreload%autoreload 2
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

Here we define the necessary imports.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# NOTE: This is ONLY necessary in jupyter notebook.# Details: Jupyter runs an event-loop behind the scenes.# This results in nested event-loops when we start an event-loop to make async queries.# This is normally not allowed, we use nest\_asyncio to allow it for convenience.import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().handlers = []logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SummaryIndex,    SimpleDirectoryReader,    ServiceContext,    StorageContext,)from llama\_index.response.notebook\_utils import display\_responsefrom llama\_index.llms import OpenAI
```

```
Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.NumExpr defaulting to 8 threads.
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

In this section we first load in the Llama 2 paper as a single document. We then chunk it multiple times, according to different chunk sizes. We build a separate vector index corresponding to each chunk size.


```
!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
--2023-09-28 12:56:38--  https://arxiv.org/pdf/2307.09288.pdfResolving arxiv.org (arxiv.org)... 128.84.21.199Connecting to arxiv.org (arxiv.org)|128.84.21.199|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 13661300 (13M) [application/pdf]Saving to: ‘data/llama2.pdf’data/llama2.pdf     100%[===================>]  13.03M   521KB/s    in 42s     2023-09-28 12:57:20 (320 KB/s) - ‘data/llama2.pdf’ saved [13661300/13661300]
```

```
from pathlib import Pathfrom llama\_index import Documentfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()docs0 = loader.load(file\_path=Path("./data/llama2.pdf"))doc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]
```
Here we try out different chunk sizes: 128, 256, 512, and 1024.


```
# initialize service context (set chunk size)llm = OpenAI(model="gpt-4")chunk\_sizes = [128, 256, 512, 1024]service\_contexts = []nodes\_list = []vector\_indices = []query\_engines = []for chunk\_size in chunk\_sizes:    print(f"Chunk Size: {chunk\_size}")    service\_context = ServiceContext.from\_defaults(        chunk\_size=chunk\_size, llm=llm    )    service\_contexts.append(service\_context)    nodes = service\_context.node\_parser.get\_nodes\_from\_documents(docs)    # add chunk size to nodes to track later    for node in nodes:        node.metadata["chunk\_size"] = chunk\_size        node.excluded\_embed\_metadata\_keys = ["chunk\_size"]        node.excluded\_llm\_metadata\_keys = ["chunk\_size"]    nodes\_list.append(nodes)    # build vector index    vector\_index = VectorStoreIndex(nodes)    vector\_indices.append(vector\_index)    # query engines    query\_engines.append(vector\_index.as\_query\_engine())
```

```
Chunk Size: 128Chunk Size: 256Chunk Size: 512Chunk Size: 1024
```
Define Ensemble Retriever[](#define-ensemble-retriever "Permalink to this heading")
------------------------------------------------------------------------------------

We setup an “ensemble” retriever primarily using our recursive retrieval abstraction. This works like the following:

* Define a separate `IndexNode` corresponding to the vector retriever for each chunk size (retriever for chunk size 128, retriever for chunk size 256, and more)
* Put all IndexNodes into a single `SummaryIndex` - when the corresponding retriever is called, *all* nodes are returned.
* Define a Recursive Retriever, with the root node being the summary index retriever. This will first fetch all nodes from the summary index retriever, and then recursively call the vector retriever for each chunk size.
* Rerank the final results.

The end result is that all vector retrievers are called when a query is run.


```
# try ensemble retrievalfrom llama\_index.tools import RetrieverToolfrom llama\_index.schema import IndexNode# retriever\_tools = []retriever\_dict = {}retriever\_nodes = []for chunk\_size, vector\_index in zip(chunk\_sizes, vector\_indices):    node\_id = f"chunk\_{chunk\_size}"    node = IndexNode(        text=(            "Retrieves relevant context from the Llama 2 paper (chunk size"            f" {chunk\_size})"        ),        index\_id=node\_id,    )    retriever\_nodes.append(node)    retriever\_dict[node\_id] = vector\_index.as\_retriever()
```
Define recursive retriever.


```
from llama\_index.selectors.pydantic\_selectors import PydanticMultiSelector# from llama\_index.retrievers import RouterRetrieverfrom llama\_index.retrievers import RecursiveRetrieverfrom llama\_index import SummaryIndex# the derived retriever will just retrieve all nodessummary\_index = SummaryIndex(retriever\_nodes)retriever = RecursiveRetriever(    root\_id="root",    retriever\_dict={"root": summary\_index.as\_retriever(), \*\*retriever\_dict},)
```
Let’s test the retriever on a sample query.


```
nodes = await retriever.aretrieve(    "Tell me about the main aspects of safety fine-tuning")
```

```
print(f"Number of nodes: {len(nodes)}")for node in nodes:    print(node.node.metadata["chunk\_size"])    print(node.node.get\_text())
```
Define reranker to process the final retrieved set of nodes.


```
# define rerankerfrom llama\_index.indices.postprocessor import (    LLMRerank,    SentenceTransformerRerank,    CohereRerank,)# reranker = LLMRerank()# reranker = SentenceTransformerRerank(top\_n=10)reranker = CohereRerank(top\_n=10)
```
Define retriever query engine to integrate the recursive retriever + reranker together.


```
# define RetrieverQueryEnginefrom llama\_index.query\_engine import RetrieverQueryEnginequery\_engine = RetrieverQueryEngine(retriever, node\_postprocessors=[reranker])
```

```
response = query\_engine.query(    "Tell me about the main aspects of safety fine-tuning")
```

```
display\_response(    response, show\_source=True, source\_length=500, show\_source\_metadata=True)
```
### Analyzing the Relative Importance of each Chunk[](#analyzing-the-relative-importance-of-each-chunk "Permalink to this heading")

One interesting property of ensemble-based retrieval is that through reranking, we can actually use the ordering of chunks in the final retrieved set to determine the importance of each chunk size. For instance, if certain chunk sizes are always ranked near the top, then those are probably more relevant to the query.


```
# compute the average precision for each chunk size based on positioning in combined rankingfrom collections import defaultdictimport pandas as pddef mrr\_all(metadata\_values, metadata\_key, source\_nodes):    # source nodes is a ranked list    # go through each value, find out positioning in source\_nodes    value\_to\_mrr\_dict = {}    for metadata\_value in metadata\_values:        mrr = 0        for idx, source\_node in enumerate(source\_nodes):            if source\_node.node.metadata[metadata\_key] == metadata\_value:                mrr = 1 / (idx + 1)                break            else:                continue        # normalize AP, set in dict        value\_to\_mrr\_dict[metadata\_value] = mrr    df = pd.DataFrame(value\_to\_mrr\_dict, index=["MRR"])    df.style.set\_caption("Mean Reciprocal Rank")    return df
```

```
# Compute the Mean Reciprocal Rank for each chunk size (higher is better)# we can see that chunk size of 256 has the highest ranked results.print("Mean Reciprocal Rank for each Chunk Size")mrr\_all(chunk\_sizes, "chunk\_size", response.source\_nodes)
```

```
Mean Reciprocal Rank for each Chunk Size
```


|  | 128 | 256 | 512 | 1024 |
| --- | --- | --- | --- | --- |
| MRR | 0.333333 | 1.0 | 0.5 | 0.25 |

Evaluation[](#evaluation "Permalink to this heading")
------------------------------------------------------

We more rigorously evaluate how well an ensemble retriever works compared to the “baseline” retriever.

We define/load an eval benchmark dataset and then run different evaluations over it.

**WARNING**: This can be *expensive*, especially with GPT-4. Use caution and tune the sample size to fit your budget.


```
from llama\_index.evaluation import (    DatasetGenerator,    QueryResponseDataset,)from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIimport nest\_asyncionest\_asyncio.apply()
```

```
# NOTE: run this if the dataset isn't already savedeval\_service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))# generate questions from the largest chunks (1024)dataset\_generator = DatasetGenerator(    nodes\_list[-1],    service\_context=eval\_service\_context,    show\_progress=True,    num\_questions\_per\_chunk=2,)
```

```
eval\_dataset = await dataset\_generator.agenerate\_dataset\_from\_nodes(num=60)
```

```
eval\_dataset.save\_json("data/llama2\_eval\_qr\_dataset.json")
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json(    "data/llama2\_eval\_qr\_dataset.json")
```
### Compare Results[](#compare-results "Permalink to this heading")


```
import asyncioimport nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.evaluation import (    CorrectnessEvaluator,    SemanticSimilarityEvaluator,    RelevancyEvaluator,    FaithfulnessEvaluator,    PairwiseComparisonEvaluator,)# NOTE: can uncomment other evaluatorsevaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_s = SemanticSimilarityEvaluator(service\_context=eval\_service\_context)evaluator\_r = RelevancyEvaluator(service\_context=eval\_service\_context)evaluator\_f = FaithfulnessEvaluator(service\_context=eval\_service\_context)pairwise\_evaluator = PairwiseComparisonEvaluator(    service\_context=eval\_service\_context)
```

```
from llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dffrom llama\_index.evaluation import BatchEvalRunnermax\_samples = 60eval\_qs = eval\_dataset.questionsqr\_pairs = eval\_dataset.qr\_pairsref\_response\_strs = [r for (\_, r) in qr\_pairs]# resetup base query engine and ensemble query engine# base query enginebase\_query\_engine = vector\_indices[-1].as\_query\_engine(similarity\_top\_k=2)# ensemble query enginereranker = CohereRerank(top\_n=4)query\_engine = RetrieverQueryEngine(retriever, node\_postprocessors=[reranker])
```

```
base\_pred\_responses = get\_responses(    eval\_qs[:max\_samples], base\_query\_engine, show\_progress=True)
```

```
pred\_responses = get\_responses(    eval\_qs[:max\_samples], query\_engine, show\_progress=True)
```

```
import numpy as nppred\_response\_strs = [str(p) for p in pred\_responses]base\_pred\_response\_strs = [str(p) for p in base\_pred\_responses]
```

```
evaluator\_dict = {    "correctness": evaluator\_c,    "faithfulness": evaluator\_f,    # "relevancy": evaluator\_r,    "semantic\_similarity": evaluator\_s,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=1, show\_progress=True)
```

```
eval\_results = await batch\_runner.aevaluate\_responses(    queries=eval\_qs[:max\_samples],    responses=pred\_responses[:max\_samples],    reference=ref\_response\_strs[:max\_samples],)
```

```
base\_eval\_results = await batch\_runner.aevaluate\_responses(    queries=eval\_qs[:max\_samples],    responses=base\_pred\_responses[:max\_samples],    reference=ref\_response\_strs[:max\_samples],)
```

```
results\_df = get\_results\_df(    [eval\_results, base\_eval\_results],    ["Ensemble Retriever", "Base Retriever"],    ["correctness", "faithfulness", "semantic\_similarity"],)display(results\_df)
```


|  | names | correctness | faithfulness | semantic\_similarity |
| --- | --- | --- | --- | --- |
| 0 | Ensemble Retriever | 4.375000 | 0.983333 | 0.964546 |
| 1 | Base Retriever | 4.066667 | 0.983333 | 0.956692 |


```
batch\_runner = BatchEvalRunner(    {"pairwise": pairwise\_evaluator}, workers=3, show\_progress=True)pairwise\_eval\_results = await batch\_runner.aevaluate\_response\_strs(    queries=eval\_qs[:max\_samples],    response\_strs=pred\_response\_strs[:max\_samples],    reference=base\_pred\_response\_strs[:max\_samples],)
```

```
results\_df = get\_results\_df(    [eval\_results, base\_eval\_results],    ["Ensemble Retriever", "Base Retriever"],    ["pairwise"],)display(results\_df)
```


|  | names | pairwise |
| --- | --- | --- |
| 0 | Pairwise Comparison | 0.5 |

