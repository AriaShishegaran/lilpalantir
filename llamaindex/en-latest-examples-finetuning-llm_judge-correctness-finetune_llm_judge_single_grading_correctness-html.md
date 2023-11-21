Knowledge Distillation For Fine-Tuning A GPT-3.5 Judge (Correctness)[](#knowledge-distillation-for-fine-tuning-a-gpt-3-5-judge-correctness "Permalink to this heading")
========================================================================================================================================================================

This notebook has to do with fine-tuning an LLM Judge that evaluates the responses of another LLM to a user query. More specifically, we demonstrate how to use the `llama\_index` library to distill knowledge from a GPT-4 Judge to a GPT-3.5 Judge. To do so, we will take the following steps:

1. Generate datasets: `train` and `test`
2. Perform knowledge distillation (using `train`)
3. Evaluate the distilled model on `test`

More specifically, we will use `CorrectnessEvaluator` as our LLM Judge.


```
# NOTE: this notebook makes several API calls to generate text with OpenAI GPT# models as well as models hosted on HuggingFace. If you prefer not to wait for# these generations, then the data for this notebook can be obtained with the# `wget` command provided below.# !wget "https://www.dropbox.com/scl/fo/3kkm8v6qvhxnu449xwp3d/h?rlkey=fxom1yixru1nags9mmao1hkg2&dl=1" -O correctness.zip
```

```
import nest\_asyncionest\_asyncio.apply()
```

```
import os# we will be using models on HuggingFace as our LLM answer generatorsHUGGING\_FACE\_TOKEN = os.getenv("HUGGING\_FACE\_TOKEN")# we will use GPT-4 and GPT-3.5 + OpenAI Fine-TuningOPENAI\_API\_KEY = os.getenv("OPENAI\_API\_KEY")
```
Step 1 Generate datasets: `train\_dataset` and `test\_dataset`[](#step-1-generate-datasets-train-dataset-and-test-dataset "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------

For our dataset on which we will generate questions and prompt various LLMs to answer, we’re going to use the `WikipediaReader` to read “History of ” for several cities.


```
!pip install wikipedia -q
```

```
[notice] A new release of pip is available: 23.2.1 -> 23.3.1[notice] To update, run: pip install --upgrade pip
```

```
# wikipedia pagesfrom llama\_index.readers import WikipediaReadercities = [    "San Francisco",    "Toronto",    "New York",    "Vancouver",    "Montreal",    "Tokyo",    "Singapore",    "Paris",]documents = WikipediaReader().load\_data(    pages=[f"History of {x}" for x in cities])
```
### Use a `DatasetGenerator` to build `train\_dataset` and `test\_dataset`[](#use-a-datasetgenerator-to-build-train-dataset-and-test-dataset "Permalink to this heading")

Now that we have our train and test set of `Document`’s, the next step is to generate the questions. For this we will use the `DatasetGenerator`, which uses an LLM to generate questions from given set of documents.

#### Generate Questions[](#generate-questions "Permalink to this heading")


```
QUESTION\_GEN\_PROMPT = (    "You are a Teacher/ Professor. Your task is to setup "    "a quiz/examination. Using the provided context, formulate "    "a single question that captures an important fact from the "    "context. Restrict the question to the context information provided.")
```

```
# generate questions against chunksfrom llama\_index.evaluation import DatasetGeneratorfrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContext# set context for llm providergpt\_35\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.3))# instantiate a DatasetGeneratordataset\_generator = DatasetGenerator.from\_documents(    documents,    question\_gen\_query=QUESTION\_GEN\_PROMPT,    service\_context=gpt\_35\_context,    num\_questions\_per\_chunk=25,)
```

```
qrd = dataset\_generator.generate\_dataset\_from\_nodes(num=350)
```

```
# If you want to save it for future use# qrd.save\_json("qrd.json")
```
#### Generate Answers To The Questions[](#generate-answers-to-the-questions "Permalink to this heading")

The next step is to generate answers using an LLM. Just a reminder, that the point is to judge these generated answers. So later on, we will use GPT models to judge these answers.

For the generation of the answers to the questions, we will use another LLM, namely: Llama-2. In order to do this, we first a create a vector store for our documents and an associated retriever, which this LLM answer-generator will use.


```
from llama\_index import VectorStoreIndexfrom llama\_index.indices.vector\_store.retrievers import VectorIndexRetriever# Create vector indexthe\_index = VectorStoreIndex.from\_documents(documents=documents)# Create the retriver on this indexthe\_retriever = VectorIndexRetriever(    index=the\_index,    similarity\_top\_k=2,)
```
From here we will build `RetrieverQueryEngine`’s that will take in our queries (i.e. questions) for processing. Note that we use `HuggingFaceInferenceAPI` for our LLM answer-generators, and that Llama-2 requires permissions. If you haven’t yet gain accessed to these models, then feel free to swap out Llama-2 with another model of your choosing.

At this point we will break off the generated questions into two sets: one for building `train\_dataset` and another for `test\_dataset` that we will build in the next section.


```
from llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)from llama\_index.llms import HuggingFaceInferenceAPIfrom llama\_index.llm\_predictor import LLMPredictorllm = HuggingFaceInferenceAPI(    model\_name="meta-llama/Llama-2-7b-chat-hf",    context\_window=2048,  # to use refine    token=HUGGING\_FACE\_TOKEN,)context = ServiceContext.from\_defaults(llm\_predictor=LLMPredictor(llm=llm))query\_engine = RetrieverQueryEngine.from\_args(    retriever=the\_retriever, service\_context=context)
```

```
/Users/nerdai/Library/Caches/pypoetry/virtualenvs/llama-index-e6cjsBOJ-py3.10/lib/python3.10/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```

```
import tqdm# we will use 65% of the generated questions for trainingtrain\_dataset = []num\_train\_questions = int(0.65 \* len(qrd.qr\_pairs))for q, a in tqdm.tqdm(qrd.qr\_pairs[:num\_train\_questions]):    # data for this q    data\_entry = {"question": q, "reference": a}    response = query\_engine.query(q)    response\_struct = {}    response\_struct["model"] = "llama-2"    response\_struct["text"] = str(response)    response\_struct["context"] = (        response.source\_nodes[0].node.text[:1000] + "..."    )    data\_entry["response\_data"] = response\_struct    train\_dataset.append(data\_entry)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 79/79 [08:30<00:00,  6.46s/it]
```
### Get GPT-4 Evaluations On The Mistral and LLama-2 Answers[](#get-gpt-4-evaluations-on-the-mistral-and-llama-2-answers "Permalink to this heading")

As mentioned a couple of times before, the point of this guide is fine-tune an LLM judge from a GPT-4 judge. So, in order to complete our `train\_dataset` we now need to instantiate our GPT-4 judge and have it evaluate the answers that were provided by Llama-2. To do this, we will use the `CorrectnessEvaluator` class. What this judge will do then is it will compare the answer to a reference answer and provide a score between 1 and 5 (higher is better) on how close the provided answer aligns to the reference one.

Note also that we use the `OpenAIFineTuningHandler` which will collect all the chat histories that we will eventually need to fine-tune GPT-3.5.


```
# instantiate the gpt-4 judgefrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContextfrom llama\_index.callbacks import OpenAIFineTuningHandlerfrom llama\_index.callbacks import CallbackManagerfrom llama\_index.evaluation import CorrectnessEvaluatorfinetuning\_handler = OpenAIFineTuningHandler()callback\_manager = CallbackManager([finetuning\_handler])gpt\_4\_context = ServiceContext.from\_defaults(    llm=OpenAI(temperature=0, model="gpt-4"),    callback\_manager=callback\_manager,)gpt4\_judge = CorrectnessEvaluator(service\_context=gpt\_4\_context)
```

```
import tqdm# for `training`for data\_entry in tqdm.tqdm(train\_dataset):    eval\_result = await gpt4\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["response\_data"]["text"],        context=data\_entry["response\_data"]["context"],        reference=data\_entry["reference"],    )    # save final result    judgement = {}    judgement["llm"] = "gpt\_4"    judgement["score"] = eval\_result.score    judgement["text"] = eval\_result.response    data\_entry["evaluations"] = [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 79/79 [12:31<00:00,  9.51s/it]
```

```
finetuning\_handler.save\_finetuning\_events("correction\_finetuning\_events.jsonl")
```

```
Wrote 79 examples to correction_finetuning_events.jsonl
```
Step 2 Perform knowledge distillation[](#step-2-perform-knowledge-distillation "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

Okay, it’s now time to distill some knowledge from GPT-4 to GPT-3.5 To do this, we will make use of the `OpenAIFinetuneEngine` class as well as the `correction\_finetuning\_events.jsonl` file that we just created.


```
from llama\_index.finetuning import OpenAIFinetuneEnginefinetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "correction\_finetuning\_events.jsonl",)
```

```
# We can check the status of our current job as follows# This may take some time ...finetune\_engine.finetune()
```

```
Num examples: 79First example:{'role': 'system', 'content': '\nYou are an expert evaluation system for a question answering chatbot.\n\nYou are given the following information:\n- a user query,\n- a reference answer, and\n- a generated answer.\n\nYour job is to judge the relevance and correctness of the generated answer.\nOutput a single score that represents a holistic evaluation.\nYou must return your response in a line with only the score.\nDo not return answers in any other format.\nOn a separate line provide your reasoning for the score as well.\n\nFollow these guidelines for scoring:\n- Your score has to be between 1 and 5, where 1 is the worst and 5 is the best.\n- If the generated answer is not relevant to the user query, you should give a score of 1.\n- If the generated answer is relevant but contains mistakes, you should give a score between 2 and 3.\n- If the generated answer is relevant and fully correct, you should give a score between 4 and 5.\n\nExample Response:\n4.0\nThe generated answer has the exact same metrics as the reference answer,     but it is not as concise.\n\n'}{'role': 'user', 'content': '\n## User Query\nWhat event in 1906 caused significant damage to San Francisco but was followed by a quick rebuild?\n\n## Reference Answer\nThe great earthquake and fire in 1906 caused significant damage to San Francisco but was followed by a quick rebuild.\n\n## Generated Answer\n1906 earthquake and fire.\n'}{'role': 'assistant', 'content': '4.0\nThe generated answer is relevant and correct, but it lacks the detail and context provided in the reference answer.'}No errors foundNum examples missing system message: 0Num examples missing user message: 0#### Distribution of num_messages_per_example:min / max: 3, 3mean / median: 3.0, 3.0p5 / p95: 3.0, 3.0#### Distribution of num_total_tokens_per_example:min / max: 315, 782mean / median: 479.49367088607596, 465.0p5 / p95: 355.6, 634.6#### Distribution of num_assistant_tokens_per_example:min / max: 19, 110mean / median: 57.63291139240506, 56.0p5 / p95: 29.6, 83.20 examples may be over the 4096 token limit, they will be truncated during fine-tuningDataset has ~37880 tokens that will be charged for during trainingBy default, you'll train for 3 epochs on this datasetBy default, you'll be charged for ~113640 tokensAs of August 22, 2023, fine-tuning gpt-3.5-turbo is $0.008 / 1K Tokens.This means your total cost for training will be $0.30304000000000003 per epoch.
```

```
finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-9y8G7rzbCkzPjsKtPMsfwRSu at 0x1778d6a70> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-9y8G7rzbCkzPjsKtPMsfwRSu",  "model": "gpt-3.5-turbo-0613",  "created_at": 1698851177,  "finished_at": 1698851823,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::8G7FovVj",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-bx2ObrpVPq7Q2pmv743W1eFQ"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-xAwZ2NSzbck3p8u24kznzySX",  "hyperparameters": {    "n_epochs": 3  },  "trained_tokens": 113166,  "error": null}
```
3 Evaluate The Fine-Tuned GPT-3.5 Judge On The Test Dataset[](#evaluate-the-fine-tuned-gpt-3-5-judge-on-the-test-dataset "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------

Now that we have our fine-tuned GPT-3.5, let’s see how well it performs on a test set. But first, remember that we said we’d hold off on creating the `test\_dataset` until the time comes that we need it? Well, that time is now. So we will repeat the process of creating the `train\_dataset` here but instead now for the `test\_dataset`.

NOTE: generating these answers and evaluations will take some time.


```
# Use Llama-2 to generate answers to the test questionstest\_dataset = []for q, a in tqdm.tqdm(qrd.qr\_pairs[num\_train\_questions:]):    # data for this q    data\_entry = {"question": q, "reference": a}    response = query\_engine.query(q)    response\_struct = {}    response\_struct["model"] = "llama-2"    response\_struct["text"] = str(response)    response\_struct["context"] = (        response.source\_nodes[0].node.text[:1000] + "..."    )    data\_entry["response\_data"] = response\_struct    test\_dataset.append(data\_entry)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 44/44 [05:07<00:00,  6.99s/it]
```

```
# get the gpt-4 judgements on the Llama-2 answersfor data\_entry in tqdm.tqdm(test\_dataset):    eval\_result = await gpt4\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["response\_data"]["text"],        context=data\_entry["response\_data"]["context"],        reference=data\_entry["reference"],    )    # save final result    judgement = {}    judgement["llm"] = "gpt\_4"    judgement["score"] = eval\_result.score    judgement["text"] = eval\_result.response    data\_entry["evaluations"] = [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 44/44 [06:52<00:00,  9.37s/it]
```

```
from llama\_index.evaluation import EvaluationResult# use our fine-tuned GPT-3.5 to evaluate the answersft\_llm = finetune\_engine.get\_finetuned\_model()ft\_context = ServiceContext.from\_defaults(    llm=ft\_llm,)ft\_gpt\_3p5\_judge = CorrectnessEvaluator(service\_context=ft\_context)for data\_entry in tqdm.tqdm(test\_dataset):    eval\_result = await ft\_gpt\_3p5\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["response\_data"]["text"],        context=data\_entry["response\_data"]["context"],        reference=data\_entry["reference"],    )    # save final result    judgement = {}    judgement["llm"] = "ft\_gpt\_3p5"    judgement["score"] = eval\_result.score    judgement["text"] = eval\_result.response    data\_entry["evaluations"] += [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 44/44 [00:44<00:00,  1.02s/it]
```

```
# Similarly, use a non-fine-tuned judge to evaluate the answersgpt\_3p5\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo"))gpt\_3p5\_judge = CorrectnessEvaluator(service\_context=gpt\_3p5\_context)for data\_entry in tqdm.tqdm(test\_dataset):    eval\_result = await gpt\_3p5\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["response\_data"]["text"],        context=data\_entry["response\_data"]["context"],        reference=data\_entry["reference"],    )    # save final result    judgement = {}    judgement["llm"] = "gpt\_3p5"    judgement["score"] = eval\_result.score    judgement["text"] = eval\_result.response    data\_entry["evaluations"] += [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 44/44 [01:36<00:00,  2.19s/it]
```
### The Metrics[](#the-metrics "Permalink to this heading")

Phew! Now that we have generated all of the LLM judges evaluations of the Llama-2/Mistral answers on the test queries. Let’s now get a quantitative view on how close fine-tuned GPT-3.5 is to GPT-4.

For this, we report the Correlation between the scores of the fine-tuned (and, not-fine-tuned) GPT-3.5 to that of the GPT-4 judge.


```
REPORT\_FMT\_STR = (    "{model}\n"    "-----------------\n"    "Number of obs.: {total\_obs}\n"    "Correlation with GPT-4: {corr}\n")
```

```
import numpy as npscores = {"gpt\_4": [], "gpt\_3p5": [], "ft\_gpt\_3p5": []}for ix, d in enumerate(test\_dataset):    for e in d["evaluations"]:        scores[e["llm"]].append(e["score"])
```

```
# numpy conversionnp\_scores\_gpt\_4 = np.array(scores["gpt\_4"])np\_scores\_gpt\_3p5 = np.array(scores["gpt\_3p5"])np\_scores\_ft\_gpt\_3p5 = np.array(scores["ft\_gpt\_3p5"])# correlationscorr\_ft = np.corrcoef(np\_scores\_gpt\_4, np\_scores\_ft\_gpt\_3p5)[0, 1]corr\_no\_ft = np.corrcoef(np\_scores\_gpt\_4, np\_scores\_gpt\_3p5)[0, 1]print(    REPORT\_FMT\_STR.format(        model="GPT-3.5 w/ fine-tuning",        total\_obs=np\_scores\_gpt\_4.shape[0],        corr=corr\_ft,    ))print("\n")print(    REPORT\_FMT\_STR.format(        model="GPT-3.5 w/out fine-tuning",        total\_obs=np\_scores\_gpt\_4.shape[0],        corr=corr\_no\_ft,    ))
```

```
GPT-3.5 w/ fine-tuning-----------------Number of obs.: 44Correlation with GPT-4: 0.9279850303778618GPT-3.5 w/out fine-tuning-----------------Number of obs.: 44Correlation with GPT-4: 0.8737418723878325
```
Conclusion[](#conclusion "Permalink to this heading")
------------------------------------------------------

From the above numbers we see that fine-tuning a GPT-3.5 judge yields higher correlation to GPT-4 that does its non-fine-tuned counterpart. Thus, for this case, we see that fine-tuning has helped us to obtain a GPT-3.5 judge that is closer to a GPT-4 judge (and thus by proxy, closer to human judgements).

