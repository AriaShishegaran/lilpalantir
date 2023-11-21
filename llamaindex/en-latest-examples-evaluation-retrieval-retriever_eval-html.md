[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/evaluation/retrieval/retriever_eval.ipynb)

Retrieval Evaluation[](#retrieval-evaluation "Permalink to this heading")
==========================================================================

This notebook uses our `RetrieverEvaluator` to evaluate the quality of any Retriever module defined in LlamaIndex.

We specify a set of different evaluation metrics: this includes hit-rate and MRR. For any given question, these will compare the quality of retrieved results from the ground-truth context.

To ease the burden of creating the eval dataset in the first place, we can rely on synthetic data generation.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

Here we load in data (PG essay), parse into Nodes. We then index this data using our simple vector index and get a retriever.


```
import nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.evaluation import generate\_question\_context\_pairsfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.llms import OpenAI
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=512)nodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
# by default, the node ids are set to random uuids. To ensure same id's per run, we manually set them.for idx, node in enumerate(nodes):    node.id\_ = f"node\_{idx}"
```

```
llm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)
```

```
vector\_index = VectorStoreIndex(nodes, service\_context=service\_context)retriever = vector\_index.as\_retriever(similarity\_top\_k=2)
```
### Try out Retrieval[](#try-out-retrieval "Permalink to this heading")

We’ll try out retrieval over a simple dataset.


```
retrieved\_nodes = retriever.retrieve("What did the author do growing up?")
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor node in retrieved\_nodes:    display\_source\_node(node, source\_length=1000)
```
**Node ID:** 749c5544-13ae-4632-b8dd-c6367b718a73  
**Similarity:** 0.8203777233851344  
**Text:** What I Worked On

February 2021

Before college the two main things I worked on, outside of school, were writing and programming. I didn’t write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined made them deep.

The first programs I tried writing were on the IBM 1401 that our school district used for what was then called “data processing.” This was in 9th grade, so I was 13 or 14. The school district’s 1401 happened to be in the basement of our junior high school, and my friend Rich Draves and I got permission to use it. It was like a mini Bond villain’s lair down there, with all these alien-looking machines — CPU, disk drives, printer, card reader — sitting up on a raised floor under bright fluorescent lights.

The language we used was an early version of Fortran. You had to type programs on punch cards, then stack them in …  


**Node ID:** 6e5d20a0-0c93-4465-9496-5e8318640067  
**Similarity:** 0.8143566621554992  
**Text:** [10]

Wow, I thought, there’s an audience. If I write something and put it on the web, anyone can read it. That may seem obvious now, but it was surprising then. In the print era there was a narrow channel to readers, guarded by fierce monsters known as editors. The only way to get an audience for anything you wrote was to get it published as a book, or in a newspaper or magazine. Now anyone could publish anything.

This had been possible in principle since 1993, but not many people had realized it yet. I had been intimately involved with building the infrastructure of the web for most of that time, and a writer as well, and it had taken me 8 years to realize it. Even then it took me several years to understand the implications. It meant there would be a whole new generation of essays. [11]

In the print era, the channel for publishing essays had been vanishingly small. Except for a few officially anointed thinkers who went to the right parties in New York, the only people allowed t…  


Build an Evaluation dataset of (query, context) pairs[](#build-an-evaluation-dataset-of-query-context-pairs "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------

Here we build a simple evaluation dataset over the existing text corpus.

We use our `generate\_question\_context\_pairs` to generate a set of (question, context) pairs over a given unstructured text corpus. This uses the LLM to auto-generate questions from each context chunk.

We get back a `EmbeddingQAFinetuneDataset` object. At a high-level this contains a set of ids mapping to queries and relevant doc chunks, as well as the corpus itself.


```
from llama\_index.evaluation import (    generate\_question\_context\_pairs,    EmbeddingQAFinetuneDataset,)
```

```
qa\_dataset = generate\_question\_context\_pairs(    nodes, llm=llm, num\_questions\_per\_chunk=2)
```

```
queries = qa\_dataset.queries.values()print(list(queries)[2])
```

```
In the context, the author mentions his first experience with programming on a TRS-80. Describe the limitations he faced with this early computer and how he used it to write programs, including a word processor.
```

```
# [optional] saveqa\_dataset.save\_json("pg\_eval\_dataset.json")
```

```
# [optional] loadqa\_dataset = EmbeddingQAFinetuneDataset.from\_json("pg\_eval\_dataset.json")
```
Use `RetrieverEvaluator` for Retrieval Evaluation[](#use-retrieverevaluator-for-retrieval-evaluation "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------

We’re now ready to run our retrieval evals. We’ll run our `RetrieverEvaluator` over the eval dataset that we generated.

We define two functions: `get\_eval\_results` and also `display\_results` that run our retriever over the dataset.


```
from llama\_index.evaluation import RetrieverEvaluatorretriever\_evaluator = RetrieverEvaluator.from\_metric\_names(    ["mrr", "hit\_rate"], retriever=retriever)
```

```
# try it out on a sample querysample\_id, sample\_query = list(qa\_dataset.queries.items())[0]sample\_expected = qa\_dataset.relevant\_docs[sample\_id]eval\_result = retriever\_evaluator.evaluate(sample\_query, sample\_expected)print(eval\_result)
```

```
Query: In the context, the author mentions his early experiences with programming on an IBM 1401. Describe the process he used to run a program on this machine and explain why he found it challenging to create meaningful programs on it.Metrics: {'mrr': 1.0, 'hit_rate': 1.0}
```

```
# try it out on an entire dataseteval\_results = await retriever\_evaluator.aevaluate\_dataset(qa\_dataset)
```

```
import pandas as pddef display\_results(name, eval\_results): """Display results from evaluate."""    metric\_dicts = []    for eval\_result in eval\_results:        metric\_dict = eval\_result.metric\_vals\_dict        metric\_dicts.append(metric\_dict)    full\_df = pd.DataFrame(metric\_dicts)    hit\_rate = full\_df["hit\_rate"].mean()    mrr = full\_df["mrr"].mean()    metric\_df = pd.DataFrame(        {"retrievers": [name], "hit\_rate": [hit\_rate], "mrr": [mrr]}    )    return metric\_df
```

```
display\_results("top-2 eval", eval\_results)
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | top-2 eval | 0.833333 | 0.784722 |

