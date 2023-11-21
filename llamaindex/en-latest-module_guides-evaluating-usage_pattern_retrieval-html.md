Usage Pattern (Retrieval)[](#usage-pattern-retrieval "Permalink to this heading")
==================================================================================

Using `RetrieverEvaluator`[](#using-retrieverevaluator "Permalink to this heading")
------------------------------------------------------------------------------------

This runs evaluation over a single query + ground-truth document set given a retriever.

The standard practice is to specify a set of valid metrics with `from\_metrics`.


```
from llama\_index.evaluation import RetrieverEvaluator# define retriever somewhere (e.g. from index)# retriever = index.as\_retriever(similarity\_top\_k=2)retriever = ...retriever\_evaluator = RetrieverEvaluator.from\_metric\_names(    ["mrr", "hit\_rate"], retriever=retriever)retriever\_evaluator.evaluate(    query="query", expected\_ids=["node\_id1", "node\_id2"])
```
Building an Evaluation Dataset[](#building-an-evaluation-dataset "Permalink to this heading")
----------------------------------------------------------------------------------------------

You can manually curate a retrieval evaluation dataset of questions + node id’s. We also offer synthetic dataset generation over an existing text corpus with our `generate\_question\_context\_pairs` function:


```
from llama\_index.evaluation import generate\_question\_context\_pairsqa\_dataset = generate\_question\_context\_pairs(    nodes, llm=llm, num\_questions\_per\_chunk=2)
```
The returned result is a `EmbeddingQAFinetuneDataset` object (containing `queries`, `relevant\_docs`, and `corpus`).

### Plugging it into `RetrieverEvaluator`[](#plugging-it-into-retrieverevaluator "Permalink to this heading")

We offer a convenience function to run a `RetrieverEvaluator` over a dataset in batch mode.


```
eval\_results = await retriever\_evaluator.aevaluate\_dataset(qa\_dataset)
```
This should run much faster than you trying to call `.evaluate` on each query separately.

