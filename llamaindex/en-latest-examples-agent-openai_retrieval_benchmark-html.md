Benchmarking OpenAI Retrieval API (through Assistant Agent)[](#benchmarking-openai-retrieval-api-through-assistant-agent "Permalink to this heading")
======================================================================================================================================================

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_retrieval_benchmark.ipynb)

This guide benchmarks the Retrieval Tool from the [OpenAI Assistant API](https://platform.openai.com/docs/assistants/overview), by using our `OpenAIAssistantAgent`. We run over the Llama 2 paper, and compare generation quality against a naive RAG pipeline.


```
!pip install llama-index
```

```
import nest\_asyncionest\_asyncio.apply()
```
Setup Data[](#setup-data "Permalink to this heading")
------------------------------------------------------

Here we load the Llama 2 paper and chunk it.


```
!mkdir -p 'data/'!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
--2023-11-08 21:53:52--  https://arxiv.org/pdf/2307.09288.pdfResolving arxiv.org (arxiv.org)... 128.84.21.199Connecting to arxiv.org (arxiv.org)|128.84.21.199|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 13661300 (13M) [application/pdf]Saving to: ‘data/llama2.pdf’data/llama2.pdf     100%[===================>]  13.03M   141KB/s    in 1m 48s  2023-11-08 21:55:42 (123 KB/s) - ‘data/llama2.pdf’ saved [13661300/13661300]
```

```
from pathlib import Pathfrom llama\_index import Document, ServiceContext, VectorStoreIndexfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderfrom llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.llms import OpenAI
```

```
loader = PyMuPDFReader()docs0 = loader.load(file\_path=Path("./data/llama2.pdf"))doc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]
```

```
node\_parser = SimpleNodeParser.from\_defaults()nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
len(nodes)
```

```
89
```
Define Eval Modules[](#define-eval-modules "Permalink to this heading")
------------------------------------------------------------------------

We setup evaluation modules, including the dataset and evaluators.

### Setup “Golden Dataset”[](#setup-golden-dataset "Permalink to this heading")

Here we load in a “golden” dataset.

#### Option 1: Pull Existing Dataset[](#option-1-pull-existing-dataset "Permalink to this heading")

**NOTE**: We pull this in from Dropbox. For details on how to generate a dataset please see our `DatasetGenerator` module.


```
!wget "https://www.dropbox.com/scl/fi/fh9vsmmm8vu0j50l3ss38/llama2\_eval\_qr\_dataset.json?rlkey=kkoaez7aqeb4z25gzc06ak6kb&dl=1" -O data/llama2_eval_qr_dataset.json
```

```
--2023-11-08 22:20:10--  https://www.dropbox.com/scl/fi/fh9vsmmm8vu0j50l3ss38/llama2_eval_qr_dataset.json?rlkey=kkoaez7aqeb4z25gzc06ak6kb&dl=1Resolving www.dropbox.com (www.dropbox.com)... 2620:100:6057:18::a27d:d12, 162.125.13.18Connecting to www.dropbox.com (www.dropbox.com)|2620:100:6057:18::a27d:d12|:443... connected.HTTP request sent, awaiting response... 302 FoundLocation: https://uc63170224c66fda29da619e304b.dl.dropboxusercontent.com/cd/0/inline/CHOj1FEf2Dd6npmREaKmwUEIJ4S5QcrgeISKh55BE27i9tqrcE94Oym_0_z0EL9mBTmF9udNCxWwnFSHlio3ib6G_f_j3xiUzn5AVvQsKDPROYjazkJz_ChUVv3xkT-Pzuk/file?dl=1# [following]--2023-11-08 22:20:11--  https://uc63170224c66fda29da619e304b.dl.dropboxusercontent.com/cd/0/inline/CHOj1FEf2Dd6npmREaKmwUEIJ4S5QcrgeISKh55BE27i9tqrcE94Oym_0_z0EL9mBTmF9udNCxWwnFSHlio3ib6G_f_j3xiUzn5AVvQsKDPROYjazkJz_ChUVv3xkT-Pzuk/file?dl=1Resolving uc63170224c66fda29da619e304b.dl.dropboxusercontent.com (uc63170224c66fda29da619e304b.dl.dropboxusercontent.com)... 2620:100:6057:15::a27d:d0f, 162.125.13.15Connecting to uc63170224c66fda29da619e304b.dl.dropboxusercontent.com (uc63170224c66fda29da619e304b.dl.dropboxusercontent.com)|2620:100:6057:15::a27d:d0f|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 60656 (59K) [application/binary]Saving to: ‘data/llama2_eval_qr_dataset.json’data/llama2_eval_qr 100%[===================>]  59.23K  --.-KB/s    in 0.02s   2023-11-08 22:20:12 (2.87 MB/s) - ‘data/llama2_eval_qr_dataset.json’ saved [60656/60656]
```

```
from llama\_index.evaluation import QueryResponseDataset# optionaleval\_dataset = QueryResponseDataset.from\_json(    "data/llama2\_eval\_qr\_dataset.json")
```
#### Option 2: Generate New Dataset[](#option-2-generate-new-dataset "Permalink to this heading")

If you choose this option, you can choose to generate a new dataset from scratch. This allows you to play around with our `DatasetGenerator` settings to make sure it suits your needs.


```
from llama\_index.evaluation import (    DatasetGenerator,    QueryResponseDataset,)from llama\_index import ServiceContextfrom llama\_index.llms import OpenAI
```

```
# NOTE: run this if the dataset isn't already saved# Note: we only generate from the first 20 nodes, since the rest are referenceseval\_service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-1106-preview"))dataset\_generator = DatasetGenerator(    nodes[:20],    service\_context=eval\_service\_context,    show\_progress=True,    num\_questions\_per\_chunk=3,)eval\_dataset = await dataset\_generator.agenerate\_dataset\_from\_nodes(num=60)eval\_dataset.save\_json("data/llama2\_eval\_qr\_dataset.json")
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json(    "data/llama2\_eval\_qr\_dataset.json")
```
### Eval Modules[](#eval-modules "Permalink to this heading")

We define two evaluation modules: correctness and semantic similarity - both comparing quality of predicted response with actual response.


```
from llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dffrom llama\_index.evaluation import (    CorrectnessEvaluator,    SemanticSimilarityEvaluator,    BatchEvalRunner,)from llama\_index.llms import OpenAI
```

```
eval\_llm = OpenAI(model="gpt-4-1106-preview")eval\_service\_context = ServiceContext.from\_defaults(llm=eval\_llm)evaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_s = SemanticSimilarityEvaluator(service\_context=eval\_service\_context)evaluator\_dict = {    "correctness": evaluator\_c,    "semantic\_similarity": evaluator\_s,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```

```
import numpy as npimport timeimport osimport picklefrom tqdm import tqdmdef get\_responses\_sync(    eval\_qs, query\_engine, show\_progress=True, save\_path=None):    if show\_progress:        eval\_qs\_iter = tqdm(eval\_qs)    else:        eval\_qs\_iter = eval\_qs    pred\_responses = []    start\_time = time.time()    for eval\_q in eval\_qs\_iter:        print(f"eval q: {eval\_q}")        pred\_response = agent.query(eval\_q)        print(f"predicted response: {pred\_response}")        pred\_responses.append(pred\_response)        if save\_path is not None:            # save intermediate responses (to cache in case something breaks)            avg\_time = (time.time() - start\_time) / len(pred\_responses)            pickle.dump(                {"pred\_responses": pred\_responses, "avg\_time": avg\_time},                open(save\_path, "wb"),            )    return pred\_responsesasync def run\_evals(    query\_engine,    eval\_qa\_pairs,    batch\_runner,    disable\_async\_for\_preds=False,    save\_path=None,):    # then evaluate    # TODO: evaluate a sample of generated results    eval\_qs = [q for q, \_ in eval\_qa\_pairs]    eval\_answers = [a for \_, a in eval\_qa\_pairs]    if save\_path is not None:        if not os.path.exists(save\_path):            start\_time = time.time()            if disable\_async\_for\_preds:                pred\_responses = get\_responses\_sync(                    eval\_qs,                    query\_engine,                    show\_progress=True,                    save\_path=save\_path,                )            else:                pred\_responses = get\_responses(                    eval\_qs, query\_engine, show\_progress=True                )            avg\_time = (time.time() - start\_time) / len(eval\_qs)            pickle.dump(                {"pred\_responses": pred\_responses, "avg\_time": avg\_time},                open(save\_path, "wb"),            )        else:            # [optional] load            pickled\_dict = pickle.load(open(save\_path, "rb"))            pred\_responses = pickled\_dict["pred\_responses"]            avg\_time = pickled\_dict["avg\_time"]    else:        start\_time = time.time()        pred\_responses = get\_responses(            eval\_qs, query\_engine, show\_progress=True        )        avg\_time = (time.time() - start\_time) / len(eval\_qs)    eval\_results = await batch\_runner.aevaluate\_responses(        eval\_qs, responses=pred\_responses, reference=eval\_answers    )    return eval\_results, {"avg\_time": avg\_time}
```
Construct Assistant with Built-In Retrieval[](#construct-assistant-with-built-in-retrieval "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------

Let’s construct the assistant by also passing it the built-in OpenAI Retrieval tool.

Here, we upload and pass in the file during assistant-creation time.


```
from llama\_index.agent import OpenAIAssistantAgent
```

```
agent = OpenAIAssistantAgent.from\_new(    name="SEC Analyst",    instructions="You are a QA assistant designed to analyze sec filings.",    openai\_tools=[{"type": "retrieval"}],    instructions\_prefix="Please address the user as Jerry.",    files=["data/llama2.pdf"],    verbose=True,)
```

```
response = agent.query(    "What are the key differences between Llama 2 and Llama 2-Chat?")
```

```
print(str(response))
```

```
The key differences between Llama 2 and Llama 2-Chat, as indicated by the document, focus on their performance in safety evaluations, particularly when tested with adversarial prompts. Here are some of the differences highlighted within the safety evaluation section of Llama 2-Chat:1. Safety Human Evaluation: Llama 2-Chat was assessed with roughly 2000 adversarial prompts, among which 1351 were single-turn and 623 were multi-turn. The responses were judged for safety violations on a five-point Likert scale, where a rating of 1 or 2 indicated a violation. The evaluation aimed to gauge the model’s safety by its rate of generating responses with safety violations and its helpfulness to users.2. Violation Percentage and Mean Rating: Llama 2-Chat exhibited a low overall violation percentage across different model sizes and a high mean rating for safety and helpfulness, which suggests a strong performance in safety evaluations.3. Inter-Rater Reliability: The reliability of the safety assessments was measured using Gwet’s AC1/2 statistic, showing a high degree of agreement among annotators with an average inter-rater reliability score of 0.92 for Llama 2-Chat annotations.4. Single-turn and Multi-turn Conversations: The evaluation revealed that multi-turn conversations generally lead to more safety violations across models, but Llama 2-Chat performed well compared to baselines, particularly in multi-turn scenarios.5. Violation Percentage Per Risk Category: Llama 2-Chat had a relatively higher number of violations in the unqualified advice category, possibly due to a lack of appropriate disclaimers in its responses.6. Improvements in Fine-Tuned Llama 2-Chat: The document also mentions that the fine-tuned Llama 2-Chat showed significant improvement over the pre-trained Llama 2 in terms of truthfulness and toxicity. The percentage of toxic generations dropped to effectively 0% for Llama 2-Chat of all sizes, which was the lowest among all compared models, indicating a notable enhancement in safety.These points detail the evaluations and improvements emphasizing safety that distinguish Llama 2-Chat from Llama 2【9†source】.
```
Benchmark[](#benchmark "Permalink to this heading")
----------------------------------------------------

We run the agent over our evaluation dataset. We benchmark against a standard top-k RAG pipeline (k=2) with gpt-4-turbo.

**NOTE**: During our time of testing (November 2023), the Assistant API is heavily rate-limited, and can take ~1-2 hours to generate responses over 60 datapoints.

### Define Baseline Index + RAG Pipeline[](#define-baseline-index-rag-pipeline "Permalink to this heading")


```
base\_sc = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4-1106-preview"))base\_index = VectorStoreIndex(nodes, service\_context=base\_sc)base\_query\_engine = base\_index.as\_query\_engine(similarity\_top\_k=2)
```
### Run Evals over Baseline[](#run-evals-over-baseline "Permalink to this heading")


```
base\_eval\_results, base\_extra\_info = await run\_evals(    base\_query\_engine,    eval\_dataset.qr\_pairs,    batch\_runner,    save\_path="data/llama2\_preds\_base.pkl",)
```

```
results\_df = get\_results\_df(    [base\_eval\_results],    ["Base Query Engine"],    ["correctness", "semantic\_similarity"],)display(results\_df)
```


|  | names | correctness | semantic\_similarity |
| --- | --- | --- | --- |
| 0 | Base Query Engine | 4.05 | 0.964245 |

### Run Evals over Assistant API[](#run-evals-over-assistant-api "Permalink to this heading")


```
assistant\_eval\_results, assistant\_extra\_info = await run\_evals(    agent,    eval\_dataset.qr\_pairs[:55],    batch\_runner,    save\_path="data/llama2\_preds\_assistant.pkl",    disable\_async\_for\_preds=True,)
```
### Get Results[](#get-results "Permalink to this heading")

Here we see…that our basic RAG pipeline does better.

Take these numbers with a grain of salt. The goal here is to give you a script so you can run this on your own data.

That said it’s surprising the Retrieval API doesn’t give immediately better out of the box performance.


```
results\_df = get\_results\_df(    [assistant\_eval\_results, base\_eval\_results],    ["Retrieval API", "Base Query Engine"],    ["correctness", "semantic\_similarity"],)display(results\_df)print(f"Base Avg Time: {base\_extra\_info['avg\_time']}")print(f"Assistant Avg Time: {assistant\_extra\_info['avg\_time']}")
```


|  | names | correctness | semantic\_similarity |
| --- | --- | --- | --- |
| 0 | Retrieval API | 3.536364 | 0.952647 |
| 1 | Base Query Engine | 4.050000 | 0.964245 |


```
Base Avg Time: 0.25683316787083943Assistant Avg Time: 75.43605598536405
```
