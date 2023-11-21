[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/MetadataReplacementDemo.ipynb)

Metadata Replacement + Node Sentence Window[](#metadata-replacement-node-sentence-window "Permalink to this heading")
======================================================================================================================

In this notebook, we use the `SentenceWindowNodeParser` to parse documents into single sentences per node. Each node also contains a “window” with the sentences on either side of the node sentence.

Then, during retrieval, before passing the retrieved sentences to the LLM, the single sentences are replaced with a window containing the surrounding sentences using the `MetadataReplacementNodePostProcessor`.

This is most useful for large documents/indexes, as it helps to retrieve more fine-grained details.

By default, the sentence window is 5 sentences on either side of the original sentence.

In this case, chunk size settings are not used, in favor of following the window settings.


```
%load\_ext autoreload%autoreload 2
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import ServiceContext, set\_global\_service\_contextfrom llama\_index.llms import OpenAIfrom llama\_index.embeddings import OpenAIEmbedding, HuggingFaceEmbeddingfrom llama\_index.node\_parser import SentenceWindowNodeParser, SimpleNodeParser# create the sentence window node parser w/ default settingsnode\_parser = SentenceWindowNodeParser.from\_defaults(    window\_size=3,    window\_metadata\_key="window",    original\_text\_metadata\_key="original\_text",)simple\_node\_parser = SimpleNodeParser.from\_defaults()llm = OpenAI(model="gpt-3.5-turbo", temperature=0.1)embed\_model = HuggingFaceEmbedding(    model\_name="sentence-transformers/all-mpnet-base-v2", max\_length=512)ctx = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embed\_model,    # node\_parser=node\_parser,)# if you wanted to use OpenAIEmbedding, we should also increase the batch size,# since it involves many more calls to the API# ctx = ServiceContext.from\_defaults(llm=llm, embed\_model=OpenAIEmbedding(embed\_batch\_size=50)), node\_parser=node\_parser)
```
Load Data, Build the Index[](#load-data-build-the-index "Permalink to this heading")
-------------------------------------------------------------------------------------

In this section, we load data and build the vector index.

### Load Data[](#load-data "Permalink to this heading")

Here, we build an index using chapter 3 of the recent IPCC climate report.


```
!curl https://www..ch/report/ar6/wg2/downloads/report/IPCC_AR6_WGII_Chapter03.pdf --output IPCC_AR6_WGII_Chapter03.pdf
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current                                 Dload  Upload   Total   Spent    Left  Speed  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: www..ch
```

```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader(    input\_files=["./IPCC\_AR6\_WGII\_Chapter03.pdf"]).load\_data()
```
### Extract Nodes[](#extract-nodes "Permalink to this heading")

We extract out the set of nodes that will be stored in the VectorIndex. This includes both the nodes with the sentence window parser, as well as the “base” nodes extracted using the standard parser.


```
nodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
base\_nodes = simple\_node\_parser.get\_nodes\_from\_documents(documents)
```
### Build the Indexes[](#build-the-indexes "Permalink to this heading")

We build both the sentence index, as well as the “base” index (with default chunk sizes).


```
from llama\_index import VectorStoreIndexsentence\_index = VectorStoreIndex(nodes, service\_context=ctx)
```

```
base\_index = VectorStoreIndex(base\_nodes, service\_context=ctx)
```
Querying[](#querying "Permalink to this heading")
--------------------------------------------------

### With MetadataReplacementPostProcessor[](#with-metadatareplacementpostprocessor "Permalink to this heading")

Here, we now use the `MetadataReplacementPostProcessor` to replace the sentence in each node with it’s surrounding context.


```
from llama\_index.indices.postprocessor import MetadataReplacementPostProcessorquery\_engine = sentence\_index.as\_query\_engine(    similarity\_top\_k=2,    # the target key defaults to `window` to match the node\_parser's default    node\_postprocessors=[        MetadataReplacementPostProcessor(target\_metadata\_key="window")    ],)window\_response = query\_engine.query(    "What are the concerns surrounding the AMOC?")print(window\_response)
```

```
There is low confidence in the quantification of Atlantic Meridional Overturning Circulation (AMOC) changes in the 20th century due to low agreement in quantitative reconstructed and simulated trends. Additionally, direct observational records since the mid-2000s remain too short to determine the relative contributions of internal variability, natural forcing, and anthropogenic forcing to AMOC change. However, it is very likely that AMOC will decline for all SSP scenarios over the 21st century, but it will not involve an abrupt collapse before 2100.
```
We can also check the original sentence that was retrieved for each node, as well as the actual window of sentences that was sent to the LLM.


```
window = window\_response.source\_nodes[0].node.metadata["window"]sentence = window\_response.source\_nodes[0].node.metadata["original\_text"]print(f"Window: {window}")print("------------------")print(f"Original Sentence: {sentence}")
```

```
Window: Nevertheless, projected future annual cumulative upwelling wind changes at most locations and seasons remain within ±10–20% of present-day values (medium confidence) (WGI AR6 Section  9.2.3.5; Fox-Kemper et al., 2021). Continuous observation of the Atlantic meridional overturning circulation (AMOC) has improved the understanding of its variability (Frajka-Williams et  al., 2019), but there is low confidence in the quantification of AMOC changes in the 20th century because of low agreement in quantitative reconstructed and simulated trends (WGI AR6 Sections 2.3.3, 9.2.3.1; Fox-Kemper et al., 2021; Gulev et al., 2021).  Direct observational records since the mid-2000s remain too short to determine the relative contributions of internal variability, natural forcing and anthropogenic forcing to AMOC change (high confidence) (WGI AR6 Sections 2.3.3, 9.2.3.1; Fox-Kemper et al., 2021; Gulev et al., 2021).  Over the 21st century, AMOC will very likely decline for all SSP scenarios but will not involve an abrupt collapse before 2100 (WGI AR6 Sections 4.3.2, 9.2.3.1; Fox-Kemper et al., 2021; Lee et al., 2021). 3.2.2.4 Sea Ice ChangesSea ice is a key driver of polar marine life, hosting unique ecosystems and affecting diverse marine organisms and food webs through its impact on light penetration and supplies of nutrients and organic matter (Arrigo, 2014).  Since the late 1970s, Arctic sea ice area has decreased for all months, with an estimated decrease of 2 million km2 (or 25%) for summer sea ice (averaged for August, September and October) in 2010–2019 as compared with 1979–1988 (WGI AR6 Section 9.3.1.1; Fox-Kemper et al., 2021). ------------------Original Sentence: Over the 21st century, AMOC will very likely decline for all SSP scenarios but will not involve an abrupt collapse before 2100 (WGI AR6 Sections 4.3.2, 9.2.3.1; Fox-Kemper et al., 2021; Lee et al., 2021).
```
### Contrast with normal VectorStoreIndex[](#contrast-with-normal-vectorstoreindex "Permalink to this heading")


```
query\_engine = base\_index.as\_query\_engine(similarity\_top\_k=2)vector\_response = query\_engine.query(    "What are the concerns surrounding the AMOC?")print(vector\_response)
```

```
The concerns surrounding the AMOC are not provided in the given context information.
```
Well, that didn’t work. Let’s bump up the top k! This will be slower and use more tokens compared to the sentence window index.


```
query\_engine = base\_index.as\_query\_engine(similarity\_top\_k=5)vector\_response = query\_engine.query(    "What are the concerns surrounding the AMOC?")print(vector\_response)
```

```
There are concerns surrounding the AMOC (Atlantic Meridional Overturning Circulation). The context information mentions that the AMOC will decline over the 21st century, with high confidence but low confidence for quantitative projections.
```
Analysis[](#analysis "Permalink to this heading")
--------------------------------------------------

So the `SentenceWindowNodeParser` + `MetadataReplacementNodePostProcessor` combo is the clear winner here. But why?

Embeddings at a sentence level seem to capture more fine-grained details, like the word `AMOC`.

We can also compare the retrieved chunks for each index!


```
for source\_node in window\_response.source\_nodes:    print(source\_node.node.metadata["original\_text"])    print("--------")
```

```
Over the 21st century, AMOC will very likely decline for all SSP scenarios but will not involve an abrupt collapse before 2100 (WGI AR6 Sections 4.3.2, 9.2.3.1; Fox-Kemper et al., 2021; Lee et al., 2021).--------Direct observational records since the mid-2000s remain too short to determine the relative contributions of internal variability, natural forcing and anthropogenic forcing to AMOC change (high confidence) (WGI AR6 Sections 2.3.3, 9.2.3.1; Fox-Kemper et al., 2021; Gulev et al., 2021). --------
```
Here, we can see that the sentence window index easily retrieved two nodes that talk about AMOC. Remember, the embeddings are based purely on the original sentence here, but the LLM actually ends up reading the surrounding context as well!

Now, let’s try and disect why the naive vector index failed.


```
for node in vector\_response.source\_nodes:    print("AMOC mentioned?", "AMOC" in node.node.text)    print("--------")
```

```
AMOC mentioned? False--------AMOC mentioned? False--------AMOC mentioned? True--------AMOC mentioned? False--------AMOC mentioned? False--------
```
So source node at index [2] mentions AMOC, but what did this text actually look like?


```
print(vector\_response.source\_nodes[2].node.text)
```

```
2021; Gulev et al. 2021)The AMOC will decline over the 21st century (high confidence, but low confidence for quantitative projections).4.3.2.3, 9.2.3 (Fox-Kemper et al. 2021; Lee et al. 2021)Sea iceArctic sea ice changes‘Current Arctic sea ice coverage levels are the lowest since at least 1850 for both annual mean and late-summer values (high confidence).’2.3.2.1, 9.3.1 (Fox-Kemper et al. 2021; Gulev et al. 2021)‘The Arctic will become practically ice-free in September by the end of the 21st century under SSP2-4.5, SSP3-7.0 and SSP5-8.5[…](high confidence).’4.3.2.1, 9.3.1 (Fox-Kemper et al. 2021; Lee et al. 2021)Antarctic sea ice changesThere is no global significant trend in Antarctic sea ice area from 1979 to 2020 (high confidence).2.3.2.1, 9.3.2 (Fox-Kemper et al. 2021; Gulev et al. 2021)There is low confidence in model simulations of future Antarctic sea ice.9.3.2 (Fox-Kemper et al. 2021)Ocean chemistryChanges in salinityThe ‘large-scale, near-surface salinity contrasts have intensified since at least 1950 […] (virtually certain).’2.3.3.2, 9.2.2.2 (Fox-Kemper et al. 2021; Gulev et al. 2021)‘Fresh ocean regions will continue to get fresher and salty ocean regions will continue to get saltier in the 21st century (medium confidence).’9.2.2.2 (Fox-Kemper et al. 2021)Ocean acidificationOcean surface pH has declined globally over the past four decades (virtually certain).2.3.3.5, 5.3.2.2 (Canadell et al. 2021; Gulev et al. 2021)Ocean surface pH will continue to decrease ‘through the 21st century, except for the lower-emission scenarios SSP1-1.9 and SSP1-2.6 […] (high confidence).’4.3.2.5, 4.5.2.2, 5.3.4.1 (Lee et al. 2021; Canadell et al. 2021)Ocean deoxygenationDeoxygenation has occurred in most open ocean regions since the mid-20th century (high confidence).2.3.3.6, 5.3.3.2 (Canadell et al. 2021; Gulev et al. 2021)Subsurface oxygen content ‘is projected to transition to historically unprecedented condition with decline over the 21st century (medium confidence).’5.3.3.2 (Canadell et al. 2021)Changes in nutrient concentrationsNot assessed in WGI Not assessed in WGI
```
So AMOC is disuccsed, but sadly it is in the middle chunk. With LLMs, it is often observed that text in the middle of retrieved context is often ignored or less useful. A recent paper [“Lost in the Middle” discusses this here](https://arxiv.org/abs/2307.03172).

[Optional] Evaluation[](#optional-evaluation "Permalink to this heading")
--------------------------------------------------------------------------

We more rigorously evaluate how well the sentence window retriever works compared to the base retriever.

We define/load an eval benchmark dataset and then run different evaluations over it.

**WARNING**: This can be *expensive*, especially with GPT-4. Use caution and tune the sample size to fit your budget.


```
from llama\_index.evaluation import (    DatasetGenerator,    QueryResponseDataset,)from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIimport nest\_asyncioimport randomnest\_asyncio.apply()
```

```
len(base\_nodes)
```

```
428
```

```
num\_nodes\_eval = 30# there are 428 nodes total. Take the first 200 to generate questions (the back half of the doc is all references)sample\_eval\_nodes = random.sample(base\_nodes[:200], num\_nodes\_eval)# NOTE: run this if the dataset isn't already savedeval\_service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))# generate questions from the largest chunks (1024)dataset\_generator = DatasetGenerator(    sample\_eval\_nodes,    service\_context=eval\_service\_context,    show\_progress=True,    num\_questions\_per\_chunk=2,)
```

```
eval\_dataset = await dataset\_generator.agenerate\_dataset\_from\_nodes()
```

```
eval\_dataset.save\_json("data/ipcc\_eval\_qr\_dataset.json")
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json("data/ipcc\_eval\_qr\_dataset.json")
```
### Compare Results[](#compare-results "Permalink to this heading")


```
import asyncioimport nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.evaluation import (    CorrectnessEvaluator,    SemanticSimilarityEvaluator,    RelevancyEvaluator,    FaithfulnessEvaluator,    PairwiseComparisonEvaluator,)from collections import defaultdictimport pandas as pd# NOTE: can uncomment other evaluatorsevaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_s = SemanticSimilarityEvaluator(service\_context=eval\_service\_context)evaluator\_r = RelevancyEvaluator(service\_context=eval\_service\_context)evaluator\_f = FaithfulnessEvaluator(service\_context=eval\_service\_context)# pairwise\_evaluator = PairwiseComparisonEvaluator(service\_context=eval\_service\_context)
```

```
from llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dffrom llama\_index.evaluation import BatchEvalRunnermax\_samples = 30eval\_qs = eval\_dataset.questionsref\_response\_strs = [r for (\_, r) in eval\_dataset.qr\_pairs]# resetup base query engine and sentence window query engine# base query enginebase\_query\_engine = base\_index.as\_query\_engine(similarity\_top\_k=2)# sentence window query enginequery\_engine = sentence\_index.as\_query\_engine(    similarity\_top\_k=2,    # the target key defaults to `window` to match the node\_parser's default    node\_postprocessors=[        MetadataReplacementPostProcessor(target\_metadata\_key="window")    ],)
```

```
import numpy as npbase\_pred\_responses = get\_responses(    eval\_qs[:max\_samples], base\_query\_engine, show\_progress=True)pred\_responses = get\_responses(    eval\_qs[:max\_samples], query\_engine, show\_progress=True)pred\_response\_strs = [str(p) for p in pred\_responses]base\_pred\_response\_strs = [str(p) for p in base\_pred\_responses]
```

```
evaluator\_dict = {    "correctness": evaluator\_c,    "faithfulness": evaluator\_f,    "relevancy": evaluator\_r,    "semantic\_similarity": evaluator\_s,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```
Run evaluations over faithfulness/semantic similarity.


```
eval\_results = await batch\_runner.aevaluate\_responses(    queries=eval\_qs[:max\_samples],    responses=pred\_responses[:max\_samples],    reference=ref\_response\_strs[:max\_samples],)
```

```
base\_eval\_results = await batch\_runner.aevaluate\_responses(    queries=eval\_qs[:max\_samples],    responses=base\_pred\_responses[:max\_samples],    reference=ref\_response\_strs[:max\_samples],)
```

```
results\_df = get\_results\_df(    [eval\_results, base\_eval\_results],    ["Sentence Window Retriever", "Base Retriever"],    ["correctness", "relevancy", "faithfulness", "semantic\_similarity"],)display(results\_df)
```


|  | names | correctness | relevancy | faithfulness | semantic\_similarity |
| --- | --- | --- | --- | --- | --- |
| 0 | Sentence Window Retriever | 4.366667 | 0.933333 | 0.933333 | 0.959583 |
| 1 | Base Retriever | 4.216667 | 0.900000 | 0.933333 | 0.958664 |

