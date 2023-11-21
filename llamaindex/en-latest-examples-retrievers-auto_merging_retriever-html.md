[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/retrievers/auto_merging_retriever.ipynb)

Auto Merging Retriever[](#auto-merging-retriever "Permalink to this heading")
==============================================================================

In this notebook, we showcase our `AutoMergingRetriever`, which looks at a set of leaf nodes and recursively “merges” subsets of leaf nodes that reference a parent node beyond a given threshold. This allows us to consolidate potentially disparate, smaller contexts into a larger context that might help synthesis.

You can define this hierarchy yourself over a set of documents, or you can make use of our brand-new text parser: a HierarchicalNodeParser that takes in a candidate set of documents and outputs an entire hierarchy of nodes, from “coarse-to-fine”.


```
%load\_ext autoreload%autoreload 2
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------

Let’s first load the Llama 2 paper: https://arxiv.org/pdf/2307.09288.pdf. This will be our test data.


```
!mkdir -p 'data/'!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Path# from llama\_hub.file.pdf.base import PDFReaderfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()# docs0 = loader.load\_data(file=Path("./data/llama2.pdf"))docs0 = loader.load(file\_path=Path("./data/llama2.pdf"))
```
By default, the PDF reader creates a separate doc for each page.For the sake of this notebook, we stitch docs together into one doc.This will help us better highlight auto-merging capabilities that “stitch” chunks together later on.


```
from llama\_index import Documentdoc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]
```
Parse Chunk Hierarchy from Text, Load into Storage[](#parse-chunk-hierarchy-from-text-load-into-storage "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------

In this section we make use of the `HierarchicalNodeParser`. This will output a hierarchy of nodes, from top-level nodes with bigger chunk sizes to child nodes with smaller chunk sizes, where each child node has a parent node with a bigger chunk size.

By default, the hierarchy is:

* 1st level: chunk size 2048
* 2nd level: chunk size 512
* 3rd level: chunk size 128

We then load these nodes into storage. The leaf nodes are indexed and retrieved via a vector store - these are the nodes that will first be directly retrieved via similarity search. The other nodes will be retrieved from a docstore.


```
from llama\_index.node\_parser import HierarchicalNodeParser, SimpleNodeParser
```

```
node\_parser = HierarchicalNodeParser.from\_defaults()
```

```
nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
len(nodes)
```

```
1029
```
Here we import a simple helper function for fetching “leaf” nodes within a node list.These are nodes that don’t have children of their own.


```
from llama\_index.node\_parser import get\_leaf\_nodes, get\_root\_nodes
```

```
leaf\_nodes = get\_leaf\_nodes(nodes)
```

```
len(leaf\_nodes)
```

```
795
```

```
root\_nodes = get\_root\_nodes(nodes)
```
### Load into Storage[](#load-into-storage "Permalink to this heading")

We define a docstore, which we load all nodes into.

We then define a `VectorStoreIndex` containing just the leaf-level nodes.


```
# define storage contextfrom llama\_index.storage.docstore import SimpleDocumentStorefrom llama\_index.storage import StorageContextfrom llama\_index import ServiceContextfrom llama\_index.llms import OpenAIdocstore = SimpleDocumentStore()# insert nodes into docstoredocstore.add\_documents(nodes)# define storage context (will include vector store by default too)storage\_context = StorageContext.from\_defaults(docstore=docstore)service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo"))
```

```
## Load index into vector indexfrom llama\_index import VectorStoreIndexbase\_index = VectorStoreIndex(    leaf\_nodes,    storage\_context=storage\_context,    service\_context=service\_context,)
```
Define Retriever[](#define-retriever "Permalink to this heading")
------------------------------------------------------------------


```
from llama\_index.retrievers.auto\_merging\_retriever import AutoMergingRetriever
```

```
base\_retriever = base\_index.as\_retriever(similarity\_top\_k=6)retriever = AutoMergingRetriever(base\_retriever, storage\_context, verbose=True)
```

```
# query\_str = "What were some lessons learned from red-teaming?"# query\_str = "Can you tell me about the key concepts for safety finetuning"query\_str = (    "What could be the potential outcomes of adjusting the amount of safety"    " data used in the RLHF stage?")nodes = retriever.retrieve(query\_str)base\_nodes = base\_retriever.retrieve(query\_str)
```

```
> Merging 4 nodes into parent node.> Parent node id: caf5f81c-842f-46a4-b679-6be584bd6aff.> Parent node text: We conduct RLHF by first collecting human preference data for safety similar to Section 3.2.2: an...
```

```
len(nodes)
```

```
3
```

```
len(base\_nodes)
```

```
6
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefor node in nodes:    display\_source\_node(node, source\_length=10000)
```
**Node ID:** d4d67180-71c8-4328-b3f1-1e98fa42ab69  
**Similarity:** 0.8694979150607424  
**Text:** We also list twoqualitative examples where safety and helpfulness reward models don’t agree with each other in Table 35.A.4.2Qualitative Results on Safety Data ScalingIn Section 4.2.3, we study the impact of adding more safety data into model RLHF in a quantitative manner.Here we showcase a few samples to qualitatively examine the evolution of model behavior when we scalesafety data in Tables 36, 37, and 38. In general, we are observing that Llama 2-Chat becomes safer respondingto unsafe prompts with more safety data used.  


**Node ID:** caf5f81c-842f-46a4-b679-6be584bd6aff  
**Similarity:** 0.86168727941324  
**Text:** We conduct RLHF by first collecting human preference data for safety similar to Section 3.2.2: annotatorswrite a prompt that they believe can elicit unsafe behavior, and then compare multiple model responses tothe prompts, selecting the response that is safest according to a set of guidelines. We then use the humanpreference data to train a safety reward model (see Section 3.2.2), and also reuse the adversarial prompts tosample from the model during the RLHF stage.Better Long-Tail Safety Robustness without Hurting HelpfulnessSafety is inherently a long-tail problem,where the challenge comes from a small number of very specific cases. We investigate the impact of SafetyRLHF by taking two intermediate Llama 2-Chat checkpoints—one without adversarial prompts in the RLHFstage and one with them—and score their responses on our test sets using our safety and helpfulness rewardmodels. In Figure 14, we plot the score distribution shift of the safety RM on the safety test set (left) and thatof the helpfulness RM on the helpfulness test set (right). In the left hand side of the figure, we observe thatthe distribution of safety RM scores on the safety set shifts to higher reward scores after safety tuning withRLHF, and that the long tail of the distribution near zero thins out. A clear cluster appears on the top-leftcorner suggesting the improvements of model safety. On the right side, we do not observe any gatheringpattern below the y = x line on the right hand side of Figure 14, which indicates that the helpfulness scoredistribution is preserved after safety tuning with RLHF. Put another way, given sufficient helpfulness trainingdata, the addition of an additional stage of safety mitigation does not negatively impact model performanceon helpfulness to any notable degradation. A qualitative example is shown in Table 12.Impact of Safety Data Scaling.A tension between helpfulness and safety of LLMs has been observed inprevious studies (Bai et al., 2022a). To better understand how the addition of safety training data affectsgeneral model performance, especially helpfulness, we investigate the trends in safety data scaling byadjusting the amount of safety data used in the RLHF stage.  


**Node ID:** d9893bef-a5a7-4248-a0a1-d7c28800ae59  
**Similarity:** 0.8546977459150967  
**Text:** 00.20.40.60.81.0Helpfulness RM Score before Safety RLHF0.00.20.40.60.81.0Helpfulness RM Score after Safety RLHF0100001000Figure 14: Impact of safety RLHF measured by reward model score distributions. Left: safety rewardmodel scores of generations on the Meta Safety test set. The clustering of samples in the top left cornersuggests the improvements of model safety.  



```
for node in base\_nodes:    display\_source\_node(node, source\_length=10000)
```
**Node ID:** 16328561-9ff7-4307-8d31-adf6bb74b71b  
**Similarity:** 0.8770715326726375  
**Text:** A qualitative example is shown in Table 12.Impact of Safety Data Scaling.A tension between helpfulness and safety of LLMs has been observed inprevious studies (Bai et al., 2022a). To better understand how the addition of safety training data affectsgeneral model performance, especially helpfulness, we investigate the trends in safety data scaling byadjusting the amount of safety data used in the RLHF stage.  


**Node ID:** e756d327-1a28-4228-ac38-f8a831b1bf77  
**Similarity:** 0.8728111844788112  
**Text:** A clear cluster appears on the top-leftcorner suggesting the improvements of model safety. On the right side, we do not observe any gatheringpattern below the y = x line on the right hand side of Figure 14, which indicates that the helpfulness scoredistribution is preserved after safety tuning with RLHF. Put another way, given sufficient helpfulness trainingdata, the addition of an additional stage of safety mitigation does not negatively impact model performanceon helpfulness to any notable degradation. A qualitative example is shown in Table 12.Impact of Safety Data Scaling.  


**Node ID:** d4d67180-71c8-4328-b3f1-1e98fa42ab69  
**Similarity:** 0.8697379697028405  
**Text:** We also list twoqualitative examples where safety and helpfulness reward models don’t agree with each other in Table 35.A.4.2Qualitative Results on Safety Data ScalingIn Section 4.2.3, we study the impact of adding more safety data into model RLHF in a quantitative manner.Here we showcase a few samples to qualitatively examine the evolution of model behavior when we scalesafety data in Tables 36, 37, and 38. In general, we are observing that Llama 2-Chat becomes safer respondingto unsafe prompts with more safety data used.  


**Node ID:** d9893bef-a5a7-4248-a0a1-d7c28800ae59  
**Similarity:** 0.855087365309258  
**Text:** 00.20.40.60.81.0Helpfulness RM Score before Safety RLHF0.00.20.40.60.81.0Helpfulness RM Score after Safety RLHF0100001000Figure 14: Impact of safety RLHF measured by reward model score distributions. Left: safety rewardmodel scores of generations on the Meta Safety test set. The clustering of samples in the top left cornersuggests the improvements of model safety.  


**Node ID:** d62ee107-9841-44b5-8b70-bc6487ad6315  
**Similarity:** 0.8492541852986794  
**Text:** Better Long-Tail Safety Robustness without Hurting HelpfulnessSafety is inherently a long-tail problem,where the challenge comes from a small number of very specific cases. We investigate the impact of SafetyRLHF by taking two intermediate Llama 2-Chat checkpoints—one without adversarial prompts in the RLHFstage and one with them—and score their responses on our test sets using our safety and helpfulness rewardmodels.  


**Node ID:** 312a63b3-5e28-4fbf-a3e1-4e8dc0c026ea  
**Similarity:** 0.8488371951811564  
**Text:** We conduct RLHF by first collecting human preference data for safety similar to Section 3.2.2: annotatorswrite a prompt that they believe can elicit unsafe behavior, and then compare multiple model responses tothe prompts, selecting the response that is safest according to a set of guidelines. We then use the humanpreference data to train a safety reward model (see Section 3.2.2), and also reuse the adversarial prompts tosample from the model during the RLHF stage.  


Plug it into Query Engine[](#plug-it-into-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------


```
from llama\_index.query\_engine import RetrieverQueryEngine
```

```
query\_engine = RetrieverQueryEngine.from\_args(retriever)base\_query\_engine = RetrieverQueryEngine.from\_args(base\_retriever)
```

```
response = query\_engine.query(query\_str)
```

```
> Merging 4 nodes into parent node.> Parent node id: 3671b20d-ea5e-4afc-983e-02be6ee8302d.> Parent node text: We conduct RLHF by first collecting human preference data for safety similar to Section 3.2.2: an...
```

```
print(str(response))
```

```
Adjusting the amount of safety data used in the RLHF stage could potentially have the following outcomes:1. Improved model safety: Increasing the amount of safety data used in RLHF may lead to improvements in model safety. This means that the model becomes better at responding to unsafe prompts and avoids generating unsafe or harmful outputs.2. Thinning out of the long tail of safety RM scores: Increasing the amount of safety data may result in a shift in the distribution of safety reward model (RM) scores towards higher reward scores. This means that the model becomes more consistent in generating safe responses and reduces the occurrence of low safety scores.3. Preservation of helpfulness performance: Adjusting the amount of safety data used in RLHF is not expected to negatively impact model performance on helpfulness. This means that the model's ability to generate helpful responses is maintained even after incorporating additional safety training.4. Gathering pattern in helpfulness RM scores: There is no observed gathering pattern below the y = x line in the distribution of helpfulness RM scores after safety tuning with RLHF. This suggests that the helpfulness score distribution is preserved, indicating that the model's helpfulness performance is not significantly degraded by the addition of safety mitigation measures.Overall, adjusting the amount of safety data used in the RLHF stage aims to strike a balance between improving model safety without compromising its helpfulness performance.
```

```
base\_response = base\_query\_engine.query(query\_str)
```

```
print(str(base\_response))
```

```
Adjusting the amount of safety data used in the RLHF stage could potentially lead to improvements in model safety. This can be observed by a clear cluster appearing on the top-left corner, suggesting enhanced model safety. Additionally, it is indicated that the helpfulness score distribution is preserved after safety tuning with RLHF, indicating that the addition of safety data does not negatively impact model performance on helpfulness.
```
Evaluation[](#evaluation "Permalink to this heading")
------------------------------------------------------

We evaluate how well the hierarchical retriever works compared to the baseline retriever in a more quantitative manner.

**WARNING**: This can be *expensive*, especially with GPT-4. Use caution and tune the sample size to fit your budget.


```
from llama\_index.evaluation import (    DatasetGenerator,    QueryResponseDataset,)from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIimport nest\_asyncionest\_asyncio.apply()
```

```
# NOTE: run this if the dataset isn't already saved# Note: we only generate from the first 20 nodes, since the rest are referenceseval\_service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))dataset\_generator = DatasetGenerator(    root\_nodes[:20],    service\_context=eval\_service\_context,    show\_progress=True,    num\_questions\_per\_chunk=3,)
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

We run evaluations on each of the retrievers: correctness, semantic similarity, relevance, and faithfulness.


```
import asyncioimport nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.evaluation import (    CorrectnessEvaluator,    SemanticSimilarityEvaluator,    RelevancyEvaluator,    FaithfulnessEvaluator,    PairwiseComparisonEvaluator,)from collections import defaultdictimport pandas as pd# NOTE: can uncomment other evaluatorsevaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_s = SemanticSimilarityEvaluator(service\_context=eval\_service\_context)evaluator\_r = RelevancyEvaluator(service\_context=eval\_service\_context)evaluator\_f = FaithfulnessEvaluator(service\_context=eval\_service\_context)# pairwise\_evaluator = PairwiseComparisonEvaluator(service\_context=eval\_service\_context)
```

```
from llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dffrom llama\_index.evaluation import BatchEvalRunner
```

```
eval\_qs = eval\_dataset.questionsqr\_pairs = eval\_dataset.qr\_pairsref\_response\_strs = [r for (\_, r) in qr\_pairs]
```

```
pred\_responses = get\_responses(eval\_qs, query\_engine, show\_progress=True)
```

```
base\_pred\_responses = get\_responses(    eval\_qs, base\_query\_engine, show\_progress=True)
```

```
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [00:07<00:00,  8.17it/s]
```

```
import numpy as nppred\_response\_strs = [str(p) for p in pred\_responses]base\_pred\_response\_strs = [str(p) for p in base\_pred\_responses]
```

```
evaluator\_dict = {    "correctness": evaluator\_c,    "faithfulness": evaluator\_f,    "relevancy": evaluator\_r,    "semantic\_similarity": evaluator\_s,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```

```
eval\_results = await batch\_runner.aevaluate\_responses(    eval\_qs, responses=pred\_responses, reference=ref\_response\_strs)
```

```
base\_eval\_results = await batch\_runner.aevaluate\_responses(    eval\_qs, responses=base\_pred\_responses, reference=ref\_response\_strs)
```

```
results\_df = get\_results\_df(    [eval\_results, base\_eval\_results],    ["Auto Merging Retriever", "Base Retriever"],    ["correctness", "relevancy", "faithfulness", "semantic\_similarity"],)display(results\_df)
```


|  | names | correctness | relevancy | faithfulness | semantic\_similarity |
| --- | --- | --- | --- | --- | --- |
| 0 | Auto Merging Retriever | 4.266667 | 0.916667 | 0.95 | 0.962196 |
| 1 | Base Retriever | 4.208333 | 0.916667 | 0.95 | 0.960602 |

**Analysis**: The results are roughly the same.

Let’s also try to see which answer GPT-4 prefers with our pairwise evals.


```
batch\_runner = BatchEvalRunner(    {"pairwise": pairwise\_evaluator}, workers=10, show\_progress=True)
```

```
pairwise\_eval\_results = await batch\_runner.aevaluate\_response\_strs(    eval\_qs,    response\_strs=pred\_response\_strs,    reference=base\_pred\_response\_strs,)pairwise\_score = np.array(    [r.score for r in pairwise\_eval\_results["pairwise"]]).mean()
```

```
pairwise\_score
```

```
0.525
```
**Analysis**: The pairwise comparison score is a measure of the percentage of time the candidate answer (using auto-merging retriever) is preferred vs. the base answer (using the base retriever). Here we see that it’s roughly even.

