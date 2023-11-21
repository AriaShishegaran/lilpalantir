[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/HotpotQADistractor.ipynb)

HotpotQADistractor Demo[](#hotpotqadistractor-demo "Permalink to this heading")
================================================================================

This notebook walks through evaluating a query engine using the HotpotQA dataset. In this task, the LLM must answer a question given a pre-configured context. The answer usually has to be concise, and accuracy is measured by calculating the overlap (measured by F1) and exact match.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.evaluation.benchmarks import HotpotQAEvaluatorfrom llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.schema import Documentfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(    embed\_model="local:sentence-transformers/all-MiniLM-L6-v2",    llm=llm,)index = VectorStoreIndex.from\_documents(    [Document.example()], service\_context=service\_context, show\_progress=True)
```

```
Parsing documents into nodes: 100%|██████████| 1/1 [00:00<00:00, 129.13it/s]Generating embeddings: 100%|██████████| 1/1 [00:00<00:00, 36.62it/s]
```
First we try with a very simple engine. In this particular benchmark, the retriever and hence index is actually ignored, as the documents retrieved for each query is provided in the dataset. This is known as the “distractor” setting in HotpotQA.


```
engine = index.as\_query\_engine(service\_context=service\_context)HotpotQAEvaluator().run(engine, queries=5, show\_result=True)
```

```
Dataset: hotpot_dev_distractor downloaded at: /Users/loganmarkewich/Library/Caches/llama_index/datasets/HotpotQAEvaluating on dataset: hotpot_dev_distractor-------------------------------------Loading 5 queries out of 7405 (fraction: 0.00068)Question:  Were Scott Derrickson and Ed Wood of the same nationality?Response: No.Correct answer:  yesEM: 0 F1: 0-------------------------------------Question:  What government position was held by the woman who portrayed Corliss Archer in the film Kiss and Tell?Response: UnknownCorrect answer:  Chief of ProtocolEM: 0 F1: 0-------------------------------------Question:  What science fantasy young adult series, told in first person, has a set of companion books narrating the stories of enslaved worlds and alien species?Response: AnimorphsCorrect answer:  AnimorphsEM: 1 F1: 1.0-------------------------------------Question:  Are the Laleli Mosque and Esma Sultan Mansion located in the same neighborhood?Response: Yes.Correct answer:  noEM: 0 F1: 0-------------------------------------Question:  The director of the romantic comedy "Big Stone Gap" is based in what New York city?Response: Greenwich VillageCorrect answer:  Greenwich Village, New York CityEM: 0 F1: 0.5714285714285715-------------------------------------Scores:  {'exact_match': 0.2, 'f1': 0.31428571428571433}
```
Now we try with a sentence transformer reranker, which selects 3 out of the 10 nodes proposed by the retriever


```
from llama\_index.indices.postprocessor import SentenceTransformerRerankrerank = SentenceTransformerRerank(top\_n=3)engine = index.as\_query\_engine(    service\_context=service\_context,    node\_postprocessors=[rerank],)HotpotQAEvaluator().run(engine, queries=5, show\_result=True)
```

```
Dataset: hotpot_dev_distractor downloaded at: /Users/loganmarkewich/Library/Caches/llama_index/datasets/HotpotQAEvaluating on dataset: hotpot_dev_distractor-------------------------------------Loading 5 queries out of 7405 (fraction: 0.00068)Question:  Were Scott Derrickson and Ed Wood of the same nationality?Response: No.Correct answer:  yesEM: 0 F1: 0-------------------------------------Question:  What government position was held by the woman who portrayed Corliss Archer in the film Kiss and Tell?Response: No government position.Correct answer:  Chief of ProtocolEM: 0 F1: 0-------------------------------------Question:  What science fantasy young adult series, told in first person, has a set of companion books narrating the stories of enslaved worlds and alien species?Response: AnimorphsCorrect answer:  AnimorphsEM: 1 F1: 1.0-------------------------------------Question:  Are the Laleli Mosque and Esma Sultan Mansion located in the same neighborhood?Response: No.Correct answer:  noEM: 1 F1: 1.0-------------------------------------Question:  The director of the romantic comedy "Big Stone Gap" is based in what New York city?Response: New York City.Correct answer:  Greenwich Village, New York CityEM: 0 F1: 0.7499999999999999-------------------------------------Scores:  {'exact_match': 0.4, 'f1': 0.55}
```
The F1 and exact match scores appear to improve slightly.

Note that the benchmark optimizes for producing short factoid answers without explanations, although it is known that CoT prompting can sometimes help in output quality.

The scores used are also not a perfect measure of correctness, but can be a quick way to identify how changes in your query engine change the output.

