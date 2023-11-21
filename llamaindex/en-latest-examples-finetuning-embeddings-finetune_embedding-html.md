[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/embeddings/finetune_embedding.ipynb)

Finetune Embeddings[](#finetune-embeddings "Permalink to this heading")
========================================================================

In this notebook, we show users how to finetune their own embedding models.

We go through three main sections:

1. Preparing the data (our `generate\_qa\_embedding\_pairs` function makes this easy)
2. Finetuning the model (using our `SentenceTransformersFinetuneEngine`)
3. Evaluating the model on a validation knowledge corpus

Generate Corpus[](#generate-corpus "Permalink to this heading")
----------------------------------------------------------------

First, we create the corpus of text chunks by leveraging LlamaIndex to load some financial PDFs, and parsing/chunking into plain text chunks.


```
import jsonfrom llama\_index import SimpleDirectoryReaderfrom llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.schema import MetadataMode
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
TRAIN\_FILES = ["./data/10k/lyft\_2021.pdf"]VAL\_FILES = ["./data/10k/uber\_2021.pdf"]TRAIN\_CORPUS\_FPATH = "./data/train\_corpus.json"VAL\_CORPUS\_FPATH = "./data/val\_corpus.json"
```

```
def load\_corpus(files, verbose=False):    if verbose:        print(f"Loading files {files}")    reader = SimpleDirectoryReader(input\_files=files)    docs = reader.load\_data()    if verbose:        print(f"Loaded {len(docs)} docs")    parser = SimpleNodeParser.from\_defaults()    nodes = parser.get\_nodes\_from\_documents(docs, show\_progress=verbose)    if verbose:        print(f"Parsed {len(nodes)} nodes")    return nodes
```
We do a very naive train/val split by having the Lyft corpus as the train dataset, and the Uber corpus as the val dataset.


```
train\_nodes = load\_corpus(TRAIN\_FILES, verbose=True)val\_nodes = load\_corpus(VAL\_FILES, verbose=True)
```
### Generate synthetic queries[](#generate-synthetic-queries "Permalink to this heading")

Now, we use an LLM (gpt-3.5-turbo) to generate questions using each text chunk in the corpus as context.

Each pair of (generated question, text chunk used as context) becomes a datapoint in the finetuning dataset (either for training or evaluation).


```
from llama\_index.finetuning import (    generate\_qa\_embedding\_pairs,    EmbeddingQAFinetuneDataset,)
```

```
train\_dataset = generate\_qa\_embedding\_pairs(train\_nodes)val\_dataset = generate\_qa\_embedding\_pairs(val\_nodes)train\_dataset.save\_json("train\_dataset.json")val\_dataset.save\_json("val\_dataset.json")
```

```
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 349/349 [11:24<00:00,  1.96s/it]100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 418/418 [14:54<00:00,  2.14s/it]
```

```
# [Optional] Loadtrain\_dataset = EmbeddingQAFinetuneDataset.from\_json("train\_dataset.json")val\_dataset = EmbeddingQAFinetuneDataset.from\_json("val\_dataset.json")
```
Run Embedding Finetuning[](#run-embedding-finetuning "Permalink to this heading")
----------------------------------------------------------------------------------


```
from llama\_index.finetuning import SentenceTransformersFinetuneEngine
```

```
finetune\_engine = SentenceTransformersFinetuneEngine(    train\_dataset,    model\_id="BAAI/bge-small-en",    model\_output\_path="test\_model",    val\_dataset=val\_dataset,)
```

```
finetune\_engine.finetune()
```

```
embed\_model = finetune\_engine.get\_finetuned\_model()
```

```
embed\_model
```

```
LangchainEmbedding(model_name='test_model', embed_batch_size=10, callback_manager=<llama_index.callbacks.base.CallbackManager object at 0x17743fd60>)
```
Evaluate Finetuned Model[](#evaluate-finetuned-model "Permalink to this heading")
----------------------------------------------------------------------------------

In this section, we evaluate 3 different embedding models:

1. proprietary OpenAI embedding,
2. open source `BAAI/bge-small-en`, and
3. our finetuned embedding model.

We consider 2 evaluation approaches:

1. a simple custom **hit rate** metric
2. using `InformationRetrievalEvaluator` from sentence\_transformers

We show that finetuning on synthetic (LLM-generated) dataset significantly improve upon an opensource embedding model.


```
from llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.schema import TextNodefrom tqdm.notebook import tqdmimport pandas as pd
```
### Define eval function[](#define-eval-function "Permalink to this heading")

**Option 1**: We use a simple **hit rate** metric for evaluation:

* for each (query, relevant\_doc) pair,
* we retrieve top-k documents with the query, and
* it’s a **hit** if the results contain the relevant\_doc.

This approach is very simple and intuitive, and we can apply it to both the proprietary OpenAI embedding as well as our open source and fine-tuned embedding models.


```
def evaluate(    dataset,    embed\_model,    top\_k=5,    verbose=False,):    corpus = dataset.corpus    queries = dataset.queries    relevant\_docs = dataset.relevant\_docs    service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)    nodes = [TextNode(id\_=id\_, text=text) for id\_, text in corpus.items()]    index = VectorStoreIndex(        nodes, service\_context=service\_context, show\_progress=True    )    retriever = index.as\_retriever(similarity\_top\_k=top\_k)    eval\_results = []    for query\_id, query in tqdm(queries.items()):        retrieved\_nodes = retriever.retrieve(query)        retrieved\_ids = [node.node.node\_id for node in retrieved\_nodes]        expected\_id = relevant\_docs[query\_id][0]        is\_hit = expected\_id in retrieved\_ids  # assume 1 relevant doc        eval\_result = {            "is\_hit": is\_hit,            "retrieved": retrieved\_ids,            "expected": expected\_id,            "query": query\_id,        }        eval\_results.append(eval\_result)    return eval\_results
```
**Option 2**: We use the `InformationRetrievalEvaluator` from sentence\_transformers.

This provides a more comprehensive suite of metrics, but we can only run it against the sentencetransformers compatible models (open source and our finetuned model, *not* the OpenAI embedding model).


```
from sentence\_transformers.evaluation import InformationRetrievalEvaluatorfrom sentence\_transformers import SentenceTransformerfrom pathlib import Pathdef evaluate\_st(    dataset,    model\_id,    name,):    corpus = dataset.corpus    queries = dataset.queries    relevant\_docs = dataset.relevant\_docs    evaluator = InformationRetrievalEvaluator(        queries, corpus, relevant\_docs, name=name    )    model = SentenceTransformer(model\_id)    output\_path = "results/"    Path(output\_path).mkdir(exist\_ok=True, parents=True)    return evaluator(model, output\_path=output\_path)
```
### Run Evals[](#run-evals "Permalink to this heading")

#### OpenAI[](#openai "Permalink to this heading")

Note: this might take a few minutes to run since we have to embed the corpus and queries


```
ada = OpenAIEmbedding()ada\_val\_results = evaluate(val\_dataset, ada)
```

```
df\_ada = pd.DataFrame(ada\_val\_results)
```

```
hit\_rate\_ada = df\_ada["is\_hit"].mean()hit\_rate\_ada
```

```
0.8779904306220095
```
### BAAI/bge-small-en[](#baai-bge-small-en "Permalink to this heading")


```
bge = "local:BAAI/bge-small-en"bge\_val\_results = evaluate(val\_dataset, bge)
```

```
df\_bge = pd.DataFrame(bge\_val\_results)
```

```
hit\_rate\_bge = df\_bge["is\_hit"].mean()hit\_rate\_bge
```

```
0.7930622009569378
```

```
evaluate\_st(val\_dataset, "BAAI/bge-small-en", name="bge")
```

```
---------------------------------------------------------------------------FileNotFoundError Traceback (most recent call last)Cell In[59], line 1----> 1 evaluate\_st(val\_dataset, "BAAI/bge-small-en", name='bge')Cell In[49], line 15, in evaluate\_st(dataset, model\_id, name) 13 evaluator = InformationRetrievalEvaluator(queries, corpus, relevant\_docs, name=name) 14 model = SentenceTransformer(model\_id)---> 15 return evaluator(model, output\_path='results/')File ~/Programming/gpt\_index/.venv/lib/python3.10/site-packages/sentence\_transformers/evaluation/InformationRetrievalEvaluator.py:104, in InformationRetrievalEvaluator.\_\_call\_\_(self, model, output\_path, epoch, steps, \*args, \*\*kwargs) 102 csv\_path = os.path.join(output\_path, self.csv\_file) 103 if not os.path.isfile(csv\_path):--> 104     fOut = open(csv\_path, mode="w", encoding="utf-8") 105     fOut.write(",".join(self.csv\_headers)) 106     fOut.write("\n")FileNotFoundError: [Errno 2] No such file or directory: 'results/Information-Retrieval_evaluation_bge_results.csv'
```
### Finetuned[](#finetuned "Permalink to this heading")


```
finetuned = "local:test\_model"val\_results\_finetuned = evaluate(val\_dataset, finetuned)
```

```
df\_finetuned = pd.DataFrame(val\_results\_finetuned)
```

```
hit\_rate\_finetuned = df\_finetuned["is\_hit"].mean()hit\_rate\_finetuned
```

```
evaluate\_st(val\_dataset, "test\_model", name="finetuned")
```
### Summary of Results[](#summary-of-results "Permalink to this heading")

#### Hit rate[](#hit-rate "Permalink to this heading")


```
df\_ada["model"] = "ada"df\_bge["model"] = "bge"df\_finetuned["model"] = "fine\_tuned"
```
We can see that fine-tuning our small open-source embedding model drastically improve its retrieval quality (even approaching the quality of the proprietary OpenAI embedding)!


```
df\_all = pd.concat([df\_ada, df\_bge, df\_finetuned])df\_all.groupby("model").mean("is\_hit")
```
#### InformationRetrievalEvaluator[](#informationretrievalevaluator "Permalink to this heading")


```
df\_st\_bge = pd.read\_csv(    "results/Information-Retrieval\_evaluation\_bge\_results.csv")df\_st\_finetuned = pd.read\_csv(    "results/Information-Retrieval\_evaluation\_finetuned\_results.csv")
```
We can see that embedding finetuning improves metrics consistently across the suite of eval metrics


```
df\_st\_bge["model"] = "bge"df\_st\_finetuned["model"] = "fine\_tuned"df\_st\_all = pd.concat([df\_st\_bge, df\_st\_finetuned])df\_st\_all = df\_st\_all.set\_index("model")df\_st\_all
```
