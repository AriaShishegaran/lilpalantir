[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/BeirEvaluation.ipynb)

BEIR Out of Domain Benchmark[](#beir-out-of-domain-benchmark "Permalink to this heading")
==========================================================================================

About [BEIR](https://github.com/beir-cellar/beir):

BEIR is a heterogeneous benchmark containing diverse IR tasks. It also provides a common and easy framework for evaluation of your retrieval methods within the benchmark.

Refer to the repo via the link for a full list of supported datasets.

Here, we test the `all-MiniLM-L6-v2` sentence-transformer embedding, which is one of the fastest for the given accuracy range. We set the top\_k value for the retriever to 30. We also use the nfcorpus dataset.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.embeddings import HuggingFaceEmbeddingfrom llama\_index.evaluation.benchmarks import BeirEvaluatorfrom llama\_index import ServiceContext, VectorStoreIndexdef create\_retriever(documents):    embed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en-v1.5")    service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)    index = VectorStoreIndex.from\_documents(        documents, service\_context=service\_context, show\_progress=True    )    return index.as\_retriever(similarity\_top\_k=30)BeirEvaluator().run(    create\_retriever, datasets=["nfcorpus"], metrics\_k\_values=[3, 10, 30])
```

```
/home/jonch/.pyenv/versions/3.10.6/lib/python3.10/site-packages/beir/datasets/data_loader.py:2: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from tqdm.autonotebook import tqdm
```

```
Dataset: nfcorpus downloaded at: /home/jonch/.cache/llama_index/datasets/BeIR__nfcorpusEvaluating on dataset: nfcorpus-------------------------------------
```

```
100%|███████████████████████████████████| 3633/3633 [00:00<00:00, 141316.79it/s]Parsing documents into nodes: 100%|████████| 3633/3633 [00:06<00:00, 569.35it/s]Generating embeddings: 100%|████████████████| 3649/3649 [04:22<00:00, 13.92it/s]
```

```
Retriever created for:  nfcorpusEvaluating retriever on questions against qrels
```

```
100%|█████████████████████████████████████████| 323/323 [01:26<00:00,  3.74it/s]
```

```
Results for: nfcorpus{'NDCG@3': 0.35476, 'MAP@3': 0.07489, 'Recall@3': 0.08583, 'precision@3': 0.33746}{'NDCG@10': 0.31403, 'MAP@10': 0.11003, 'Recall@10': 0.15885, 'precision@10': 0.23994}{'NDCG@30': 0.28636, 'MAP@30': 0.12794, 'Recall@30': 0.21653, 'precision@30': 0.14716}-------------------------------------
```
Higher is better for all the evaluation metrics.

This [towardsdatascience article](https://towardsdatascience.com/ranking-evaluation-metrics-for-recommender-systems-263d0a66ef54) covers NDCG, MAP and MRR in greater depth.

