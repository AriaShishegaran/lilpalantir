[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/embeddings/finetune_embedding_adapter.ipynb)

Finetuning an Adapter on Top of any Black-Box Embedding Model[](#finetuning-an-adapter-on-top-of-any-black-box-embedding-model "Permalink to this heading")
============================================================================================================================================================

We have capabilities in LlamaIndex allowing you to fine-tune an adapter on top of embeddings produced from any model (sentence\_transformers, OpenAI, and more).

This allows you to transform your embedding representations into a new latent space that’s optimized for retrieval over your specific data and queries. This can lead to small increases in retrieval performance that in turn translate to better performing RAG systems.

We do this via our `EmbeddingAdapterFinetuneEngine` abstraction. We fine-tune three types of adapters:

* Linear
* 2-Layer NN
* Custom NN

Generate Corpus[](#generate-corpus "Permalink to this heading")
----------------------------------------------------------------

We use our helper abstractions, `generate\_qa\_embedding\_pairs`, to generate our training and evaluation dataset. This function takes in any set of text nodes (chunks) and generates a structured dataset containing (question, context) pairs.


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

```
Loading files ['../../../examples/data/10k/lyft_2021.pdf']Loaded 238 docs
```

```
Parsed 349 nodesLoading files ['../../../examples/data/10k/uber_2021.pdf']Loaded 307 docs
```

```
Parsed 418 nodes
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
# [Optional] Loadtrain\_dataset = EmbeddingQAFinetuneDataset.from\_json("train\_dataset.json")val\_dataset = EmbeddingQAFinetuneDataset.from\_json("val\_dataset.json")
```
Run Embedding Finetuning[](#run-embedding-finetuning "Permalink to this heading")
----------------------------------------------------------------------------------

We then fine-tune our linear adapter on top of an existing embedding model. We import our new `EmbeddingAdapterFinetuneEngine` abstraction, which takes in an existing embedding model and a set of training parameters.

### Fine-tune bge-small-en (default)[](#fine-tune-bge-small-en-default "Permalink to this heading")


```
from llama\_index.finetuning import EmbeddingAdapterFinetuneEnginefrom llama\_index.embeddings import resolve\_embed\_modelimport torchbase\_embed\_model = resolve\_embed\_model("local:BAAI/bge-small-en")finetune\_engine = EmbeddingAdapterFinetuneEngine(    train\_dataset,    base\_embed\_model,    model\_output\_path="model\_output\_test",    # bias=True,    epochs=4,    verbose=True,    # optimizer\_class=torch.optim.SGD,    # optimizer\_params={"lr": 0.01})
```

```
finetune\_engine.finetune()
```

```
embed\_model = finetune\_engine.get\_finetuned\_model()# alternatively import model# from llama\_index.embeddings import LinearAdapterEmbeddingModel# embed\_model = LinearAdapterEmbeddingModel(base\_embed\_model, "model\_output\_test")
```
Evaluate Finetuned Model[](#evaluate-finetuned-model "Permalink to this heading")
----------------------------------------------------------------------------------

We compare the fine-tuned model against the base model, as well as against text-embedding-ada-002.

We evaluate with two ranking metrics:

* **Hit-rate metric**: For each (query, context) pair, we retrieve the top-k documents with the query. It’s a hit if the results contain the ground-truth context.
* **Mean Reciprocal Rank**: A slightly more granular ranking metric that looks at the “reciprocal rank” of the ground-truth context in the top-k retrieved set. The reciprocal rank is defined as 1/rank. Of course, if the results don’t contain the context, then the reciprocal rank is 0.


```
from llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.schema import TextNodefrom tqdm.notebook import tqdmimport pandas as pdfrom eval\_utils import evaluate, display\_results
```

```
ada = OpenAIEmbedding()ada\_val\_results = evaluate(val\_dataset, ada)
```

```
100%|████████████████████████████████████████████████████████████████| 790/790 [03:03<00:00,  4.30it/s]
```

```
display\_results(["ada"], [ada\_val\_results])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ada | 0.870886 | 0.72884 |


```
bge = "local:BAAI/bge-small-en"bge\_val\_results = evaluate(val\_dataset, bge)
```

```
100%|████████████████████████████████████████████████████████████████| 790/790 [00:23<00:00, 33.76it/s]
```

```
display\_results(["bge"], [bge\_val\_results])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | bge | 0.787342 | 0.643038 |


```
ft\_val\_results = evaluate(val\_dataset, embed\_model)
```

```
100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 790/790 [00:21<00:00, 36.95it/s]
```

```
display\_results(["ft"], [ft\_val\_results])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ft | 0.798734 | 0.662152 |

Here we show all the results concatenated together.


```
display\_results(    ["ada", "bge", "ft"], [ada\_val\_results, bge\_val\_results, ft\_val\_results])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ada | 0.870886 | 0.730105 |
| 1 | bge | 0.787342 | 0.643038 |
| 2 | ft | 0.798734 | 0.662152 |

Fine-tune a Two-Layer Adapter[](#fine-tune-a-two-layer-adapter "Permalink to this heading")
--------------------------------------------------------------------------------------------

Let’s try fine-tuning a two-layer NN as well!

It’s a simple two-layer NN with a ReLU activation and a residual layer at the end.

We train for 25 epochs - longer than the linear adapter - and preserve checkpoints eveyr 100 steps.


```
# requires torch dependencyfrom llama\_index.embeddings.adapter\_utils import TwoLayerNNfrom llama\_index.finetuning import EmbeddingAdapterFinetuneEnginefrom llama\_index.embeddings import resolve\_embed\_modelfrom llama\_index.embeddings import AdapterEmbeddingModel
```

```
base\_embed\_model = resolve\_embed\_model("local:BAAI/bge-small-en")adapter\_model = TwoLayerNN(    384,  # input dimension    1024,  # hidden dimension    384,  # output dimension    bias=True,    add\_residual=True,)finetune\_engine = EmbeddingAdapterFinetuneEngine(    train\_dataset,    base\_embed\_model,    model\_output\_path="model5\_output\_test",    model\_checkpoint\_path="model5\_ck",    adapter\_model=adapter\_model,    epochs=25,    verbose=True,)
```

```
finetune\_engine.finetune()
```

```
embed\_model\_2layer = finetune\_engine.get\_finetuned\_model(    adapter\_cls=TwoLayerNN)
```
### Evaluation Results[](#evaluation-results "Permalink to this heading")

Run the same evaluation script used in the previous section to measure hit-rate/MRR within the two-layer model.


```
# load model from checkpoint in the middeembed\_model\_2layer = AdapterEmbeddingModel(    base\_embed\_model,    "model5\_output\_test",    TwoLayerNN,)
```

```
from eval\_utils import evaluate, display\_results
```

```
ft\_val\_results\_2layer = evaluate(val\_dataset, embed\_model\_2layer)
```

```
100%|████████████████████████████████████████████████████████████████| 790/790 [00:21<00:00, 36.93it/s]
```

```
# comment out if you haven't run ada/bge yetdisplay\_results(    ["ada", "bge", "ft\_2layer"],    [ada\_val\_results, bge\_val\_results, ft\_val\_results\_2layer],)# uncomment if you just want to display the fine-tuned model's results# display\_results(["ft\_2layer"], [ft\_val\_results\_2layer])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ada | 0.870886 | 0.728840 |
| 1 | bge | 0.787342 | 0.643038 |
| 2 | ft\_2layer | 0.798734 | 0.662848 |


```
# load model from checkpoint in the middeembed\_model\_2layer\_s900 = AdapterEmbeddingModel(    base\_embed\_model,    "model5\_ck/step\_900",    TwoLayerNN,)
```

```
ft\_val\_results\_2layer\_s900 = evaluate(val\_dataset, embed\_model\_2layer\_s900)
```

```
100%|████████████████████████████████████████████████████████████████| 790/790 [00:19<00:00, 40.57it/s]
```

```
# comment out if you haven't run ada/bge yetdisplay\_results(    ["ada", "bge", "ft\_2layer\_s900"],    [ada\_val\_results, bge\_val\_results, ft\_val\_results\_2layer\_s900],)# uncomment if you just want to display the fine-tuned model's results# display\_results(["ft\_2layer\_s900"], [ft\_val\_results\_2layer\_s900])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ada | 0.870886 | 0.728840 |
| 1 | bge | 0.787342 | 0.643038 |
| 2 | ft\_2layer\_s900 | 0.803797 | 0.667426 |

Try Your Own Custom Model[](#try-your-own-custom-model "Permalink to this heading")
------------------------------------------------------------------------------------

You can define your own custom adapter here! Simply subclass `BaseAdapter`, which is a light wrapper around the `nn.Module` class.

You just need to subclass `forward` and `get\_config\_dict`.

Just make sure you’re familiar with writing `PyTorch` code :)


```
from llama\_index.embeddings.adapter\_utils import BaseAdapterimport torch.nn.functional as Ffrom torch import nn, Tensorfrom typing import Dict
```

```
class CustomNN(BaseAdapter): """Custom NN transformation. Is a copy of our TwoLayerNN, showing it here for notebook purposes. Args: in\_features (int): Input dimension. hidden\_features (int): Hidden dimension. out\_features (int): Output dimension. bias (bool): Whether to use bias. Defaults to False. activation\_fn\_str (str): Name of activation function. Defaults to "relu". """    def \_\_init\_\_(        self,        in\_features: int,        hidden\_features: int,        out\_features: int,        bias: bool = False,        add\_residual: bool = False,    ) -> None:        super(CustomNN, self).\_\_init\_\_()        self.in\_features = in\_features        self.hidden\_features = hidden\_features        self.out\_features = out\_features        self.bias = bias        self.linear1 = nn.Linear(in\_features, hidden\_features, bias=True)        self.linear2 = nn.Linear(hidden\_features, out\_features, bias=True)        self.\_add\_residual = add\_residual        # if add\_residual, then add residual\_weight (init to 0)        self.residual\_weight = nn.Parameter(torch.zeros(1))    def forward(self, embed: Tensor) -> Tensor: """Forward pass (Wv). Args: embed (Tensor): Input tensor. """        output1 = self.linear1(embed)        output1 = F.relu(output1)        output2 = self.linear2(output1)        if self.\_add\_residual:            output2 = self.residual\_weight \* output2 + embed        return output2    def get\_config\_dict(self) -> Dict: """Get config dict."""        return {            "in\_features": self.in\_features,            "hidden\_features": self.hidden\_features,            "out\_features": self.out\_features,            "bias": self.bias,            "add\_residual": self.\_add\_residual,        }
```

```
custom\_adapter = CustomNN(    384,  # input dimension    1024,  # hidden dimension    384,  # output dimension    bias=True,    add\_residual=True,)finetune\_engine = EmbeddingAdapterFinetuneEngine(    train\_dataset,    base\_embed\_model,    model\_output\_path="custom\_model\_output",    model\_checkpoint\_path="custom\_model\_ck",    adapter\_model=custom\_adapter,    epochs=25,    verbose=True,)
```

```
finetune\_engine.finetune()
```

```
embed\_model\_custom = finetune\_engine.get\_finetuned\_model(    adapter\_cls=CustomAdapter)
```
### Evaluation Results[](#id1 "Permalink to this heading")

Run the same evaluation script used in the previous section to measure hit-rate/MRR.


```
# [optional] load model manually# embed\_model\_custom = AdapterEmbeddingModel(# base\_embed\_model,# "custom\_model\_ck/step\_300",# TwoLayerNN,# )
```

```
from eval\_utils import evaluate, display\_results
```

```
ft\_val\_results\_custom = evaluate(val\_dataset, embed\_model\_custom)
```

```
100%|████████████████████████████████████████████████████████████████| 790/790 [00:20<00:00, 37.77it/s]
```

```
display\_results(["ft\_custom"]x, [ft\_val\_results\_custom])
```


|  | retrievers | hit\_rate | mrr |
| --- | --- | --- | --- |
| 0 | ft\_custom | 0.789873 | 0.645127 |

