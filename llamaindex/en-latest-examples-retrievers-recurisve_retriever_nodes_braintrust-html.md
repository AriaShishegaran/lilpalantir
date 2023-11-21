[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/retrievers/recurisve_retriever_nodes_braintrust.ipynb)

Recursive Retriever + Node References + Braintrust[](#recursive-retriever-node-references-braintrust "Permalink to this heading")
==================================================================================================================================

This guide shows how you can use recursive retrieval to traverse node relationships and fetch nodes based on “references”.

Node references are a powerful concept. When you first perform retrieval, you may want to retrieve the reference as opposed to the raw text. You can have multiple references point to the same node.

In this guide we explore some different usages of node references:

* **Chunk references**: Different chunk sizes referring to a bigger chunk
* **Metadata references**: Summaries + Generated Questions referring to a bigger chunk

We evaluate how well our recursive retrieval + node reference methods work using [Braintrust](https://www.braintrustdata.com/). Braintrust is the enterprise-grade stack for building AI products. From evaluations, to prompt playground, to data management, we take uncertainty and tedium out of incorporating AI into your business.

You can see example evaluation dashboards here for the:

* [base retriever](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/baseRetriever)
* [recursive metadata retreiver](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/recursiveMetadataRetriever)
* [recursive chunk retriever](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/recursiveChunkRetriever)


```
%load\_ext autoreload%autoreload 2# NOTE: Replace YOUR\_OPENAI\_API\_KEY with your OpenAI API Key and YOUR\_BRAINTRUST\_API\_KEY with your BrainTrust API key. Do not put it in quotes.# Signup for Braintrust at https://braintrustdata.com/ and get your API key at https://www.braintrustdata.com/app/braintrustdata.com/settings/api-keys# NOTE: Replace YOUR\_OPENAI\_KEY with your OpenAI API Key and YOUR\_BRAINTRUST\_API\_KEY with your BrainTrust API key. Do not put it in quotes.%env OPENAI_API_KEY=%env BRAINTRUST_API_KEY=%env TOKENIZERS_PARALLELISM=true # This is needed to avoid a warning message from Chroma
```

```
%pip install -U llama_hub llama_index braintrust autoevals pypdf pillow transformers torch torchvision
```
Load Data + Setup[](#load-data-setup "Permalink to this heading")
------------------------------------------------------------------

In this section we download the Llama 2 paper and create an initial set of nodes (chunk size 1024).


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Pathfrom llama\_hub.file.pdf.base import PDFReaderfrom llama\_index.response.notebook\_utils import display\_source\_nodefrom llama\_index.retrievers import RecursiveRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIimport json
```

```
loader = PDFReader()docs0 = loader.load\_data(file=Path("./data/llama2.pdf"))
```

```
from llama\_index import Documentdoc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]
```

```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.schema import IndexNode
```

```
node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024)
```

```
base\_nodes = node\_parser.get\_nodes\_from\_documents(docs)# set node ids to be a constantfor idx, node in enumerate(base\_nodes):    node.id\_ = f"node-{idx}"
```

```
from llama\_index.embeddings import resolve\_embed\_modelembed\_model = resolve\_embed\_model("local:BAAI/bge-small-en")llm = OpenAI(model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)
```
Baseline Retriever[](#baseline-retriever "Permalink to this heading")
----------------------------------------------------------------------

Define a baseline retriever that simply fetches the top-k raw text nodes by embedding similarity.


```
base\_index = VectorStoreIndex(base\_nodes, service\_context=service\_context)base\_retriever = base\_index.as\_retriever(similarity\_top\_k=2)
```

```
retrievals = base\_retriever.retrieve(    "Can you tell me about the key concepts for safety finetuning")
```

```
for n in retrievals:    display\_source\_node(n, source\_length=1500)
```

```
query\_engine\_base = RetrieverQueryEngine.from\_args(    base\_retriever, service\_context=service\_context)
```

```
response = query\_engine\_base.query(    "Can you tell me about the key concepts for safety finetuning")print(str(response))
```
Chunk References: Smaller Child Chunks Referring to Bigger Parent Chunk[](#chunk-references-smaller-child-chunks-referring-to-bigger-parent-chunk "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

In this usage example, we show how to build a graph of smaller chunks pointing to bigger parent chunks.

During query-time, we retrieve smaller chunks, but we follow references to bigger chunks. This allows us to have more context for synthesis.


```
sub\_chunk\_sizes = [128, 256, 512]sub\_node\_parsers = [    SimpleNodeParser.from\_defaults(chunk\_size=c) for c in sub\_chunk\_sizes]all\_nodes = []for base\_node in base\_nodes:    for n in sub\_node\_parsers:        sub\_nodes = n.get\_nodes\_from\_documents([base\_node])        sub\_inodes = [            IndexNode.from\_text\_node(sn, base\_node.node\_id) for sn in sub\_nodes        ]        all\_nodes.extend(sub\_inodes)    # also add original node to node    original\_node = IndexNode.from\_text\_node(base\_node, base\_node.node\_id)    all\_nodes.append(original\_node)
```

```
all\_nodes\_dict = {n.node\_id: n for n in all\_nodes}
```

```
vector\_index\_chunk = VectorStoreIndex(    all\_nodes, service\_context=service\_context)
```

```
vector\_retriever\_chunk = vector\_index\_chunk.as\_retriever(similarity\_top\_k=2)
```

```
retriever\_chunk = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever\_chunk},    node\_dict=all\_nodes\_dict,    verbose=True,)
```

```
nodes = retriever\_chunk.retrieve(    "Can you tell me about the key concepts for safety finetuning")for node in nodes:    display\_source\_node(node, source\_length=2000)
```

```
query\_engine\_chunk = RetrieverQueryEngine.from\_args(    retriever\_chunk, service\_context=service\_context)
```

```
response = query\_engine\_chunk.query(    "Can you tell me about the key concepts for safety finetuning")print(str(response))
```
Metadata References: Summaries + Generated Questions referring to a bigger chunk[](#metadata-references-summaries-generated-questions-referring-to-a-bigger-chunk "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

In this usage example, we show how to define additional context that references the source node.

This additional context includes summaries as well as generated questions.

During query-time, we retrieve smaller chunks, but we follow references to bigger chunks. This allows us to have more context for synthesis.


```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.schema import IndexNodefrom llama\_index.node\_parser.extractors import (    SummaryExtractor,    QuestionsAnsweredExtractor,    MetadataExtractor,)
```

```
metadata\_extractor = MetadataExtractor(    extractors=[        SummaryExtractor(summaries=["self"], show\_progress=True),        QuestionsAnsweredExtractor(questions=5, show\_progress=True),    ],)
```

```
# run metadata extractor across base nodes, get back dictionariesmetadata\_dicts = metadata\_extractor.extract(base\_nodes)
```

```
# cache metadata dictsdef save\_metadata\_dicts(path):    with open(path, "w") as fp:        for m in metadata\_dicts:            fp.write(json.dumps(m) + "\n")def load\_metadata\_dicts(path):    with open(path, "r") as fp:        metadata\_dicts = [json.loads(l) for l in fp.readlines()]        return metadata\_dicts
```

```
save\_metadata\_dicts("data/llama2\_metadata\_dicts.jsonl")
```

```
metadata\_dicts = load\_metadata\_dicts("data/llama2\_metadata\_dicts.jsonl")
```

```
# all nodes consists of source nodes, along with metadataimport copyall\_nodes = copy.deepcopy(base\_nodes)for idx, d in enumerate(metadata\_dicts):    inode\_q = IndexNode(        text=d["questions\_this\_excerpt\_can\_answer"],        index\_id=base\_nodes[idx].node\_id,    )    inode\_s = IndexNode(        text=d["section\_summary"], index\_id=base\_nodes[idx].node\_id    )    all\_nodes.extend([inode\_q, inode\_s])
```

```
all\_nodes\_dict = {n.node\_id: n for n in all\_nodes}
```

```
## Load index into vector indexfrom llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm)vector\_index\_metadata = VectorStoreIndex(    all\_nodes, service\_context=service\_context)
```

```
vector\_retriever\_metadata = vector\_index\_metadata.as\_retriever(    similarity\_top\_k=2)
```

```
retriever\_metadata = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever\_metadata},    node\_dict=all\_nodes\_dict,    verbose=True,)
```

```
nodes = retriever\_metadata.retrieve(    "Can you tell me about the key concepts for safety finetuning")for node in nodes:    display\_source\_node(node, source\_length=2000)
```

```
query\_engine\_metadata = RetrieverQueryEngine.from\_args(    retriever\_metadata, service\_context=service\_context)
```

```
response = query\_engine\_metadata.query(    "Can you tell me about the key concepts for safety finetuning")print(str(response))
```
Evaluation[](#evaluation "Permalink to this heading")
------------------------------------------------------

We evaluate how well our recursive retrieval + node reference methods work using [Braintrust](https://www.braintrustdata.com/). Braintrust is the enterprise-grade stack for building AI products. From evaluations, to prompt playground, to data management, we take uncertainty and tedium out of incorporating AI into your business.

We evaluate both chunk references as well as metadata references. We use embedding similarity lookup to retrieve the reference nodes. We compare both methods against a baseline retriever where we fetch the raw nodes directly. In terms of metrics, we evaluate using both hit-rate and MRR.

You can see example evaluation dashboards here for the:

* [base retriever](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/baseRetriever)
* [recursive metadata retreiver](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/recursiveMetadataRetriever)
* [recursive chunk retriever](https://www.braintrustdata.com/app/braintrustdata.com/p/llamaindex-recurisve-retrievers/recursiveChunkRetriever)

### Dataset Generation[](#dataset-generation "Permalink to this heading")

We first generate a dataset of questions from the set of text chunks.


```
from llama\_index.evaluation import (    generate\_question\_context\_pairs,    EmbeddingQAFinetuneDataset,)import nest\_asyncionest\_asyncio.apply()
```

```
eval\_dataset = generate\_question\_context\_pairs(base\_nodes)
```

```
eval\_dataset.save\_json("data/llama2\_eval\_dataset.json")
```

```
# optionaleval\_dataset = EmbeddingQAFinetuneDataset.from\_json(    "data/llama2\_eval\_dataset.json")
```
### Compare Results[](#compare-results "Permalink to this heading")

We run evaluations on each of the retrievers to measure hit rate and MRR.

We find that retrievers with node references (either chunk or metadata) tend to perform better than retrieving the raw chunks.


```
import pandas as pd# set vector retriever similarity top k to highertop\_k = 10def display\_results(names, results\_arr): """Display results from evaluate."""    hit\_rates = []    mrrs = []    for name, eval\_results in zip(names, results\_arr):        metric\_dicts = []        for eval\_result in eval\_results:            metric\_dict = eval\_result.metric\_vals\_dict            metric\_dicts.append(metric\_dict)        results\_df = pd.DataFrame(metric\_dicts)        hit\_rate = results\_df["hit\_rate"].mean()        mrr = results\_df["mrr"].mean()        hit\_rates.append(hit\_rate)        mrrs.append(mrr)    final\_df = pd.DataFrame(        {"retrievers": names, "hit\_rate": hit\_rates, "mrr": mrrs}    )    display(final\_df)
```
Let’s define some scoring functions and define our dataset data variable.


```
queries = eval\_dataset.queriesrelevant\_docs = eval\_dataset.relevant\_docsdata = [    ({"input": queries[query], "expected": relevant\_docs[query]})    for query in queries.keys()]def hitRateScorer(input, expected, output=None):    is\_hit = any([id in expected for id in output])    return 1 if is\_hit else 0def mrrScorer(input, expected, output=None):    for i, id in enumerate(output):        if id in expected:            return 1 / (i + 1)    return 0
```

```
import braintrust# Evaluate the chunk retrievervector\_retriever\_chunk = vector\_index\_chunk.as\_retriever(similarity\_top\_k=10)retriever\_chunk = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever\_chunk},    node\_dict=all\_nodes\_dict,    verbose=False,)def runChunkRetriever(input, hooks):    retrieved\_nodes = retriever\_chunk.retrieve(input)    retrieved\_ids = [node.node.node\_id for node in retrieved\_nodes]    return retrieved\_idschunkEval = await braintrust.Eval(    name="llamaindex-recurisve-retrievers",    data=data,    task=runChunkRetriever,    scores=[hitRateScorer, mrrScorer],)
```

```
# Evaluate the metadata retrievervector\_retriever\_metadata = vector\_index\_metadata.as\_retriever(    similarity\_top\_k=10)retriever\_metadata = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever\_metadata},    node\_dict=all\_nodes\_dict,    verbose=False,)def runMetaDataRetriever(input, hooks):    retrieved\_nodes = retriever\_metadata.retrieve(input)    retrieved\_ids = [node.node.node\_id for node in retrieved\_nodes]    return retrieved\_idsmetadataEval = await braintrust.Eval(    name="llamaindex-recurisve-retrievers",    data=data,    task=runMetaDataRetriever,    scores=[hitRateScorer, mrrScorer],)
```

```
# Evaluate the base retrieverbase\_retriever = base\_index.as\_retriever(similarity\_top\_k=10)def runBaseRetriever(input, hooks):    retrieved\_nodes = base\_retriever.retrieve(input)    retrieved\_ids = [node.node.node\_id for node in retrieved\_nodes]    return retrieved\_idsbaseEval = await braintrust.Eval(    name="llamaindex-recurisve-retrievers",    data=data,    task=runBaseRetriever,    scores=[hitRateScorer, mrrScorer],)
```
