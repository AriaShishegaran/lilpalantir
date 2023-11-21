[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/finetuning/knowledge/finetune_retrieval_aug.ipynb)

Fine-tuning with Retrieval Augmentation[](#fine-tuning-with-retrieval-augmentation "Permalink to this heading")
================================================================================================================

Here we try fine-tuning an LLM with retrieval augmentation, as referenced from the RA-DIT paper: https://arxiv.org/abs/2310.01352.

For a given (query, response) input/output example, we retrieve the k text chunks with a retriever (the quality of the retriever doesn’t have to be perfect, and in fact can be primitive). We then format each query with individually retrieved context, to create k examples (query + context\_i, response) for fine-tuning.

The idea is to allow the LLM to better use background knowledge to synthesize a correct answer, or to synthesize a correct answer even in the absence of good background knowledge. This will enable the LLM to reason from its priors a bit better.


```
import osimport openaifrom llama\_index import ServiceContextfrom llama\_index.llms import OpenAI
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Setup + Load Data[](#setup-load-data "Permalink to this heading")
------------------------------------------------------------------


```
!mkdir data && wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
mkdir: data: File exists
```

```
from pathlib import Pathfrom llama\_hub.file.pdf.base import PDFReaderfrom llama\_hub.file.unstructured.base import UnstructuredReaderfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()docs0 = loader.load(file\_path=Path("./data/llama2.pdf"))
```

```
from llama\_index import Documentdoc\_text = "\n\n".join([d.get\_content() for d in docs0])metadata = {    "paper\_title": "Llama 2: Open Foundation and Fine-Tuned Chat Models"}docs = [Document(text=doc\_text, metadata=metadata)]
```

```
print(docs[0].get\_content())
```

```
from llama\_index.callbacks import CallbackManagercallback\_manager = CallbackManager([])gpt\_35\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo-0613", temperature=0.3),    callback\_manager=callback\_manager,)gpt\_4\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-0613", temperature=0.3),    callback\_manager=callback\_manager,)
```
### Get Nodes, Setup Vector Index[](#get-nodes-setup-vector-index "Permalink to this heading")


```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index import VectorStoreIndex
```

```
node\_parser = SimpleNodeParser.from\_defaults()nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
vector\_index = VectorStoreIndex(nodes)
```
Generate Dataset[](#generate-dataset "Permalink to this heading")
------------------------------------------------------------------


```
from llama\_index.evaluation import (    DatasetGenerator,    QueryResponseDataset,)
```

```
eval\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4", temperature=0), callback\_manager=callback\_manager)dataset\_generator = DatasetGenerator(    nodes[:39],    service\_context=eval\_context,    show\_progress=True,    num\_questions\_per\_chunk=20,)
```

```
eval\_dataset = await dataset\_generator.agenerate\_dataset\_from\_nodes(num=60)
```

```
eval\_dataset.save\_json("data\_rag/qa\_pairs.json")
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs.json")
```
### Option 2: Load from existing data[](#option-2-load-from-existing-data "Permalink to this heading")

If you were already using the fine-tuning knowledge notebook, you can use that instead.


```
import json# load data in from .jsonl formatdef load\_dataset\_from\_other\_nb(path):    fp = open(path, "r")    qr\_pairs = []    for line in fp:        qa\_pair = json.loads(line)        query\_str = qa\_pair["query"]        response\_str = qa\_pair["response"]        qr\_pairs.append((query\_str, response\_str))    return qr\_pairs
```

```
qr\_pairs = load\_dataset\_from\_other\_nb("data/qa\_pairs\_2.jsonl")eval\_dataset = QueryResponseDataset.from\_qr\_pairs(qr\_pairs)
```

```
eval\_dataset
```
### For each Datapoint, Fetch Retrieved Context with a Retriever[](#for-each-datapoint-fetch-retrieved-context-with-a-retriever "Permalink to this heading")

For each (question, response) pair, fetch the top-k context with a retriever.

For each pair, we create k (question + context\_i, response) new pairs, where we format each input with the QA prompt.


```
from llama\_index import VectorStoreIndexfrom llama\_index.prompts import PromptTemplateqa\_prompt\_tmpl\_str = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query.\n"    "Query: {query\_str}\n"    "Answer: ")qa\_prompt\_tmpl = PromptTemplate(qa\_prompt\_tmpl\_str)vector\_retriever = vector\_index.as\_retriever(similarity\_top\_k=1)
```

```
from tqdm.notebook import tqdmdef augment\_data\_with\_retrieval(dataset, retriever, separate\_context=False):    data\_list = dataset.qr\_pairs    new\_data\_list = []    for query\_str, response in tqdm(data\_list):        retrieved\_nodes = retriever.retrieve(query\_str)        retrieved\_txts = [n.get\_content() for n in retrieved\_nodes]        if separate\_context:            for retrieved\_txt in retrieved\_txts:                fmt\_query\_str = qa\_prompt\_tmpl.format(                    query\_str=query\_str, context\_str=retrieved\_txt                )                new\_data\_list.append((fmt\_query\_str, response))        else:            context\_str = "\n\n".join(retrieved\_txts)            fmt\_query\_str = qa\_prompt\_tmpl.format(                query\_str=query\_str, context\_str=context\_str            )            new\_data\_list.append((fmt\_query\_str, response))    return new\_data\_list
```

```
new\_qr\_pairs = augment\_data\_with\_retrieval(    eval\_dataset, vector\_retriever, separate\_context=False)new\_eval\_dataset = QueryResponseDataset.from\_qr\_pairs(new\_qr\_pairs)
```

```
new\_eval\_dataset.save\_json("data\_rag/qa\_pairs\_ra.json")
```

```
new\_eval\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs\_ra.json")
```
### Split into Training and Validation Sets[](#split-into-training-and-validation-sets "Permalink to this heading")

We split into training and validation sets.

**NOTE**: We shuffle the data before splitting. This helps ensure that the training data has coverage throughout the document.


```
from copy import deepcopyimport randomdef split\_train\_val(dataset, train\_split=0.7):    lines = dataset.qr\_pairs    # shuffle the lines to make sure that the "train questions" cover most fo the context    shuffled\_lines = deepcopy(lines)    random.shuffle(shuffled\_lines)    split\_idx = int(train\_split \* len(shuffled\_lines))    train\_lines = shuffled\_lines[:split\_idx]    val\_lines = shuffled\_lines[split\_idx:]    return train\_lines, val\_lines
```

```
train\_lines, val\_lines = split\_train\_val(new\_eval\_dataset, train\_split=0.7)
```

```
train\_dataset = QueryResponseDataset.from\_qr\_pairs(train\_lines)val\_dataset = QueryResponseDataset.from\_qr\_pairs(val\_lines)
```

```
train\_dataset.save\_json("data\_rag/qa\_pairs\_train.json")val\_dataset.save\_json("data\_rag/qa\_pairs\_val.json")
```

```
train\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs\_train.json")val\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs\_val.json")
```
### Format into Training Data[](#format-into-training-data "Permalink to this heading")

Format into training data for OpenAI’s finetuning endpoints.

**NOTE**: We don’t use our `OpenAIFinetuningHandler` because that logs the full input prompt including context as the user message. Here we just want to log the query as the user message, because we want to fine-tune gpt-3.5-turbo to “bake in knowledge” into the fine-tuned model.


```
def save\_openai\_data(dataset, out\_path):    # out\_fp = open("data\_rag/qa\_pairs\_openai.jsonl", "w")    out\_fp = open(out\_path, "w")    # TODO: try with different system prompts    system\_prompt = {        "role": "system",        "content": (            "You are a helpful assistant helping to answer questions about the"            " Llama 2 paper."        ),    }    train\_qr\_pairs = dataset.qr\_pairs    for line in train\_qr\_pairs:        query, response = line        user\_prompt = {"role": "user", "content": query}        assistant\_prompt = {"role": "assistant", "content": response}        out\_dict = {            "messages": [system\_prompt, user\_prompt, assistant\_prompt],        }        out\_fp.write(json.dumps(out\_dict) + "\n")
```

```
save\_openai\_data(train\_dataset, "data\_rag/qa\_pairs\_openai.jsonl")
```
Fine-tune the Model[](#fine-tune-the-model "Permalink to this heading")
------------------------------------------------------------------------


```
from llama\_index.finetuning import OpenAIFinetuneEngine
```

```
finetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "data\_rag/qa\_pairs\_openai.jsonl",    # start\_job\_id="<start-job-id>" # if you have an existing job, can specify id here)
```

```
finetune\_engine.finetune()
```

```
finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-Rue4Yti7XpddPFYB6CnZadGo at 0x2cf346750> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-Rue4Yti7XpddPFYB6CnZadGo",  "model": "gpt-3.5-turbo-0613",  "created_at": 1696407754,  "finished_at": 1696411978,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::85sXTAx1",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-9EY2Wj1Gb2lzcZi1PMqVnIpt"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-0iLbjiXwv33i1eZQYNXjE4np",  "hyperparameters": {    "n_epochs": 3  },  "trained_tokens": 1754577,  "error": null}
```

```
ft\_model = finetune\_engine.get\_finetuned\_model()
```

```
ft\_model
```

```
OpenAI(callback_manager=<llama_index.callbacks.base.CallbackManager object at 0x176cfca90>, model='ft:gpt-3.5-turbo-0613:llamaindex::85sXTAx1', temperature=0.1, max_tokens=None, additional_kwargs={}, max_retries=10, api_key='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', api_type='open_ai', api_base='https://api.openai.com/v1', api_version='', class_type='openai')
```

```
# Use fine-tuned model in RAG systemfrom llama\_index import ServiceContextft\_context = ServiceContext.from\_defaults(    llm=ft\_model,    callback\_manager=callback\_manager,    system\_prompt=(        "You are a helpful assistant helping to answer questions about the"        " Llama 2 paper."    ),)# fine-tuned RAG systemft\_query\_engine = vector\_index.as\_query\_engine(    similarity\_top\_k=1, service\_context=ft\_context)
```

```
response = ft\_query\_engine.query(    "How is the margin component added in the loss of the reward model in"    " Llama 2?")print(str(response))
```

```
The margin component is added in the loss of the reward model in Llama 2 by subtracting the reward score of the worse sample from the reward score of the better sample. This difference is then compared to a margin threshold. If the difference is greater than the margin threshold, it is considered a positive example and the loss is set to zero. If the difference is smaller than the margin threshold, it is considered a negative example and the loss is set to the margin threshold minus the difference. This margin component helps to separate the reward scores of the better and worse samples, making the reward model more accurate in distinguishing between them.
```

```
base\_query\_engine = vector\_index.as\_query\_engine(similarity\_top\_k=1)base\_response = base\_query\_engine.query(    "How is the margin component added in the loss of the reward model in"    " Llama 2?")print(str(base\_response))
```

```
The margin component is added in the loss of the reward model in Llama 2 by using a preference rating-based margin term. This margin term is used in Equation 2 and helps to separate comparison pairs more effectively. The magnitude of the margin term can be adjusted to achieve better performance on separable pairs, but it may regress performance on similar samples.
```
Evaluate Results[](#evaluate-results "Permalink to this heading")
------------------------------------------------------------------

We run evaluations, over both the validation set but also the training set (as a sanity check)


```
import nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.llms import ChatMessagefrom llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dffrom llama\_index.evaluation import BatchEvalRunner
```

```
# train\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs\_train.json")# val\_dataset = QueryResponseDataset.from\_json("data\_rag/qa\_pairs\_val.json")
```

```
# Load dataset# NOTE: we need to run over the original questions, not the retrieval-augmented questions.# Since our query engines will perform retrieval augmentation under the hood!# TODO: have better code hereqr\_pairs = load\_dataset\_from\_other\_nb("data/qa\_pairs\_2.jsonl")eval\_dataset = QueryResponseDataset.from\_qr\_pairs(qr\_pairs)
```

```
# evaluate over training dataset for nowsample\_size = 50eval\_qs = eval\_dataset.questions[:sample\_size]ref\_response\_strs = [r for (\_, r) in eval\_dataset.qr\_pairs[:sample\_size]]
```

```
pred\_responses = get\_responses(eval\_qs, ft\_query\_engine, show\_progress=True)
```

```
base\_pred\_responses = get\_responses(    eval\_qs, base\_query\_engine, show\_progress=True)
```

```
import numpy as nppred\_response\_strs = [str(p) for p in pred\_responses]base\_pred\_response\_strs = [str(p) for p in base\_pred\_responses]
```

```
from llama\_index.evaluation import (    CorrectnessEvaluator,    SemanticSimilarityEvaluator,)eval\_service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))# NOTE: can uncomment other evaluatorsevaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_s = SemanticSimilarityEvaluator(service\_context=eval\_service\_context)
```

```
evaluator\_dict = {    "correctness": evaluator\_c,    "semantic\_similarity": evaluator\_s,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```

```
eval\_results = await batch\_runner.aevaluate\_responses(    eval\_qs, responses=pred\_responses, reference=ref\_response\_strs)
```

```
base\_eval\_results = await batch\_runner.aevaluate\_responses(    eval\_qs, responses=base\_pred\_responses, reference=ref\_response\_strs)
```

```
results\_df = get\_results\_df(    [eval\_results, base\_eval\_results],    ["RAG Fine-tuned LLM", "Base LLM"],    ["correctness", "semantic\_similarity"],)display(results\_df)
```


|  | names | correctness | semantic\_similarity |
| --- | --- | --- | --- |
| 0 | RAG Fine-tuned LLM | 3.65 | 0.941940 |
| 1 | Base LLM | 3.25 | 0.917662 |

