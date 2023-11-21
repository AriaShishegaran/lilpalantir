EmotionPrompt in RAG[](#emotionprompt-in-rag "Permalink to this heading")
==========================================================================

Inspired by the “[Large Language Models Understand and Can Be Enhanced byEmotional Stimuli](https://arxiv.org/pdf/2307.11760.pdf)” by Li et al., in this guide we show you how to evaluate the effects of emotional stimuli on your RAG pipeline:

1. Setup the RAG pipeline with a basic vector index with the core QA template.
2. Create some candidate stimuli (inspired by Fig. 2 of the paper)
3. For each candidate stimulit, prepend to QA prompt and evaluate.


```
import nest\_asyncionest\_asyncio.apply()
```
Setup Data[](#setup-data "Permalink to this heading")
------------------------------------------------------

We use the Llama 2 paper as the input data source for our RAG pipeline.


```
!mkdir data && wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
mkdir: data: File exists
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderfrom llama\_index import Documentfrom llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.schema import IndexNode
```

```
docs0 = PyMuPDFReader().load(file\_path=Path("./data/llama2.pdf"))doc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024)base\_nodes = node\_parser.get\_nodes\_from\_documents(docs)
```
Setup Vector Index over this Data[](#setup-vector-index-over-this-data "Permalink to this heading")
----------------------------------------------------------------------------------------------------

We load this data into an in-memory vector store (embedded with OpenAI embeddings).

We’ll be aggressively optimizing the QA prompt for this RAG pipeline.


```
from llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo")rag\_service\_context = ServiceContext.from\_defaults(llm=llm)
```

```
index = VectorStoreIndex(base\_nodes, service\_context=rag\_service\_context)query\_engine = index.as\_query\_engine(similarity\_top\_k=2)
```
Evaluation Setup[](#evaluation-setup "Permalink to this heading")
------------------------------------------------------------------

### Golden Dataset[](#golden-dataset "Permalink to this heading")

Here we load in a “golden” dataset.

**NOTE**: We pull this in from Dropbox. For details on how to generate a dataset please see our `DatasetGenerator` module.


```
!wget "https://www.dropbox.com/scl/fi/fh9vsmmm8vu0j50l3ss38/llama2\_eval\_qr\_dataset.json?rlkey=kkoaez7aqeb4z25gzc06ak6kb&dl=1" -O data/llama2_eval_qr_dataset.json
```

```
--2023-11-04 00:34:09--  https://www.dropbox.com/scl/fi/fh9vsmmm8vu0j50l3ss38/llama2_eval_qr_dataset.json?rlkey=kkoaez7aqeb4z25gzc06ak6kb&dl=1Resolving www.dropbox.com (www.dropbox.com)... 2620:100:6017:18::a27d:212, 162.125.2.18Connecting to www.dropbox.com (www.dropbox.com)|2620:100:6017:18::a27d:212|:443... connected.HTTP request sent, awaiting response... 302 FoundLocation: https://uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com/cd/0/inline/CG4XGYSusXrgPle6I3vucuwf-NIN10QWldJ7wlc3wdzYWbv9OQey0tvB4qGxJ5W0BxL7cX-zn7Kxj5QReEbi1RNYOx1XMT9qwgMm2xWjW5a9seqV4AI8V7C0M2plvH5U1Yw/file?dl=1# [following]--2023-11-04 00:34:09--  https://uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com/cd/0/inline/CG4XGYSusXrgPle6I3vucuwf-NIN10QWldJ7wlc3wdzYWbv9OQey0tvB4qGxJ5W0BxL7cX-zn7Kxj5QReEbi1RNYOx1XMT9qwgMm2xWjW5a9seqV4AI8V7C0M2plvH5U1Yw/file?dl=1Resolving uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com (uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com)... 2620:100:6017:15::a27d:20f, 162.125.2.15Connecting to uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com (uc68b925272ee59de768b72ea323.dl.dropboxusercontent.com)|2620:100:6017:15::a27d:20f|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 60656 (59K) [application/binary]Saving to: ‘data/llama2_eval_qr_dataset.json’data/llama2_eval_qr 100%[===================>]  59.23K  --.-KB/s    in 0.04s   2023-11-04 00:34:10 (1.48 MB/s) - ‘data/llama2_eval_qr_dataset.json’ saved [60656/60656]
```

```
from llama\_index.evaluation import QueryResponseDataset
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json(    "data/llama2\_eval\_qr\_dataset.json")
```
### Get Evaluator[](#get-evaluator "Permalink to this heading")


```
from llama\_index.evaluation.eval\_utils import get\_responses
```

```
from llama\_index.evaluation import CorrectnessEvaluator, BatchEvalRunnereval\_service\_context = ServiceContext.from\_defaults(llm=llm)evaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_dict = {"correctness": evaluator\_c}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```
### Define Correctness Eval Function[](#define-correctness-eval-function "Permalink to this heading")


```
import numpy as npasync def get\_correctness(query\_engine, eval\_qa\_pairs, batch\_runner):    # then evaluate    # TODO: evaluate a sample of generated results    eval\_qs = [q for q, \_ in eval\_qa\_pairs]    eval\_answers = [a for \_, a in eval\_qa\_pairs]    pred\_responses = get\_responses(eval\_qs, query\_engine, show\_progress=True)    eval\_results = await batch\_runner.aevaluate\_responses(        eval\_qs, responses=pred\_responses, reference=eval\_answers    )    avg\_correctness = np.array(        [r.score for r in eval\_results["correctness"]]    ).mean()    return avg\_correctness
```
Try Out Emotion Prompts[](#try-out-emotion-prompts "Permalink to this heading")
--------------------------------------------------------------------------------

We pul some emotion stimuli from the paper to try out.


```
emotion\_stimuli\_dict = {    "ep01": "Write your answer and give me a confidence score between 0-1 for your answer. ",    "ep02": "This is very important to my career. ",    "ep03": "You'd better be sure.",    # add more from the paper here!!}# NOTE: ep06 is the combination of ep01, ep02, ep03emotion\_stimuli\_dict["ep06"] = (    emotion\_stimuli\_dict["ep01"]    + emotion\_stimuli\_dict["ep02"]    + emotion\_stimuli\_dict["ep03"])
```
### Initialize base QA Prompt[](#initialize-base-qa-prompt "Permalink to this heading")


```
QA\_PROMPT\_KEY = "response\_synthesizer:text\_qa\_template"
```

```
from llama\_index.prompts import PromptTemplate
```

```
qa\_tmpl\_str = """\Context information is below. ---------------------{context\_str}---------------------Given the context information and not prior knowledge, \answer the query.{emotion\_str}Query: {query\_str}Answer: \"""qa\_tmpl = PromptTemplate(qa\_tmpl\_str)
```
### Prepend emotions[](#prepend-emotions "Permalink to this heading")


```
async def run\_and\_evaluate(    query\_engine, eval\_qa\_pairs, batch\_runner, emotion\_stimuli\_str, qa\_tmpl): """Run and evaluate."""    new\_qa\_tmpl = qa\_tmpl.partial\_format(emotion\_str=emotion\_stimuli\_str)    old\_qa\_tmpl = query\_engine.get\_prompts()[QA\_PROMPT\_KEY]    query\_engine.update\_prompts({QA\_PROMPT\_KEY: new\_qa\_tmpl})    avg\_correctness = await get\_correctness(        query\_engine, eval\_qa\_pairs, batch\_runner    )    query\_engine.update\_prompts({QA\_PROMPT\_KEY: old\_qa\_tmpl})    return avg\_correctness
```

```
# try out ep01correctness\_ep01 = await run\_and\_evaluate(    query\_engine,    eval\_dataset.qr\_pairs,    batch\_runner,    emotion\_stimuli\_dict["ep01"],    qa\_tmpl,)
```

```
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [00:10<00:00,  5.48it/s]100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [01:23<00:00,  1.39s/it]
```

```
print(correctness\_ep01)
```

```
3.7916666666666665
```

```
# try out ep02correctness\_ep02 = await run\_and\_evaluate(    query\_engine,    eval\_dataset.qr\_pairs,    batch\_runner,    emotion\_stimuli\_dict["ep02"],    qa\_tmpl,)
```

```
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [00:10<00:00,  5.62it/s]100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [01:21<00:00,  1.36s/it]/var/folders/1r/c3h91d9s49xblwfvz79s78_c0000gn/T/ipykernel_80474/3350915737.py:2: RuntimeWarning: coroutine 'run_and_evaluate' was never awaited  correctness_ep02 = await run_and_evaluate(RuntimeWarning: Enable tracemalloc to get the object allocation traceback
```

```
print(correctness\_ep02)
```

```
3.941666666666667
```

```
# try nonecorrectness\_base = await run\_and\_evaluate(    query\_engine, eval\_dataset.qr\_pairs, batch\_runner, "", qa\_tmpl)
```

```
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [00:12<00:00,  4.92it/s]100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 60/60 [01:59<00:00,  2.00s/it]/var/folders/1r/c3h91d9s49xblwfvz79s78_c0000gn/T/ipykernel_80474/997505056.py:2: RuntimeWarning: coroutine 'run_and_evaluate' was never awaited  correctness_base = await run_and_evaluate(RuntimeWarning: Enable tracemalloc to get the object allocation traceback
```

```
print(correctness\_base)
```

```
3.8916666666666666
```
