Knowledge Distillation For Fine-Tuning A GPT-3.5 Judge (Pairwise)[](#knowledge-distillation-for-fine-tuning-a-gpt-3-5-judge-pairwise "Permalink to this heading")
==================================================================================================================================================================

There has been recent research that demonstrated GPT-4’s ability to closely align to human judges when evaluating LLM generated texts (e.g., see [[1]](https://arxiv.org/abs/2306.05685), [[2]](https://arxiv.org/abs/2303.16634)). In this notebook, we demonstrate how to use the `llama\_index` library to distill knowledge from GPT-4 to GPT-3.5 so that a smaller GPT-3.5 becomes closer to GPT-4 performance; and by proxy, closer to human judges.

To do so, we will perform the following high level steps:

1. Generate datasets: `train\_dataset` and `test\_dataset`
2. Perform knowledge distillation (using `train\_dataset`)
3. Evaluate the distilled model on `test\_dataset`


```
# NOTE: this notebook makes several API calls to generate text with OpenAI GPT# models as well as models hosted on HuggingFace. If you prefer not to wait for# these generations, then the data for this notebook can be obtained with the# `wget` command provided below.# !wget "https://www.dropbox.com/scl/fo/m7skpjdbpb0g3p76y6epe/h?rlkey=omh2ysgh9qqqztf81qvjlivu2&dl=1" -O pairwise.zip
```

```
import nest\_asyncionest\_asyncio.apply()
```

```
import os# we will be using models on HuggingFace as our LLM answer generatorsHUGGING\_FACE\_TOKEN = os.getenv("HUGGING\_FACE\_TOKEN")# we will use GPT-4 and GPT-3.5 + OpenAI Fine-TuningOPENAI\_API\_KEY = os.getenv("OPENAI\_API\_KEY")
```

```
import pandas as pd# define jupyter display functiondef display\_eval\_df(question, source, answer\_a, answer\_b, result) -> None: """Pretty print question/answer + gpt-4 judgement dataset."""    eval\_df = pd.DataFrame(        {            "Question": question,            "Source": source,            "Model A": answer\_a["model"],            "Answer A": answer\_a["text"],            "Model B": answer\_b["model"],            "Answer B": answer\_b["text"],            "Score": result.score,            "Judgement": result.feedback,        },        index=[0],    )    eval\_df = eval\_df.style.set\_properties(        \*\*{            "inline-size": "300px",            "overflow-wrap": "break-word",        },        subset=["Answer A", "Answer B"]    )    display(eval\_df)
```
Step 1 Generate datasets: `train\_dataset` and `test\_dataset`[](#step-1-generate-datasets-train-dataset-and-test-dataset "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------

For our dataset on which we will generate questions and prompt various LLMs to answer, we’re going to use the `WikipediaReader` to read “History of ” for several cities. We’re going to split up our cities into two lists: one to be used for `train\_dataset` and the other for `test\_dataset`.


```
!pip install wikipedia -q
```

```
[notice] A new release of pip is available: 23.2.1 -> 23.3.1[notice] To update, run: pip install --upgrade pip
```

```
# wikipedia pagesfrom llama\_index.readers import WikipediaReadertrain\_cities = [    "San Francisco",    "Toronto",    "New York",    "Vancouver",    "Montreal",    "Boston",]test\_cities = [    "Tokyo",    "Singapore",    "Paris",]train\_documents = WikipediaReader().load\_data(    pages=[f"History of {x}" for x in train\_cities])test\_documents = WikipediaReader().load\_data(    pages=[f"History of {x}" for x in test\_cities])
```
### Use a `DatasetGenerator` to build `train\_dataset` and `test\_dataset`[](#use-a-datasetgenerator-to-build-train-dataset-and-test-dataset "Permalink to this heading")

Now that we have our train and test set of `Document`’s, the next step is to generate the questions. For this we will use the `DatasetGenerator`, which uses an LLM to generate questions from given set of documents.

#### Generate Questions[](#generate-questions "Permalink to this heading")


```
QUESTION\_GEN\_PROMPT = (    "You are a Teacher/ Professor. Your task is to setup "    "a quiz/examination. Using the provided context, formulate "    "a single question that captures an important fact from the "    "context. Restrict the question to the context information provided.")
```
With all that out of the way, let’s spring into action. First, we will download the reference pdf document and create the set of questions against it.


```
# generate questions against chunksfrom llama\_index.evaluation import DatasetGeneratorfrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContext# set context for llm providergpt\_35\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.3))# instantiate DatasetGenerator's for train and testtrain\_dataset\_generator = DatasetGenerator.from\_documents(    train\_documents,    question\_gen\_query=QUESTION\_GEN\_PROMPT,    service\_context=gpt\_35\_context,    show\_progress=True,    num\_questions\_per\_chunk=25,)test\_dataset\_generator = DatasetGenerator.from\_documents(    test\_documents,    question\_gen\_query=QUESTION\_GEN\_PROMPT,    service\_context=gpt\_35\_context,    show\_progress=True,    num\_questions\_per\_chunk=25,)
```

```
# use DatasetGenerator to create questions from nodestrain\_questions = train\_dataset\_generator.generate\_questions\_from\_nodes(    num=200)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 75/75 [00:02<00:00, 36.34it/s]
```

```
test\_questions = test\_dataset\_generator.generate\_questions\_from\_nodes(num=150)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 64/64 [00:02<00:00, 29.98it/s]
```

```
len(train\_questions), len(test\_questions)
```

```
(75, 64)
```

```
# let's take a look at a few of thesetrain\_questions[:3]
```

```
['What event in 1906 caused significant damage to San Francisco but was followed by a quick rebuild?', 'What was the name of the first significant homestead established outside the immediate vicinity of Mission Dolores in San Francisco?', "What event in 1855 led to the establishment of San Francisco's first county hospital and the development of California's system of county hospitals for the poor?"]
```

```
test\_questions[:3]
```

```
['Question: What was the name of the oldest Buddhist temple in Tokyo, founded in 628?', 'What event marked the end of the samurai system and feudal class divisions in Tokyo?', 'Question: What role did the Tokyo Imperial University play in the Meiji Era?']
```
#### Generate Answers To The Questions[](#generate-answers-to-the-questions "Permalink to this heading")

The next step is to generate answers using LLMs. Just a reminder, that the point is to judge these generated answers. So later on, we will use GPT models to judge these answers.

But for the generation of the answers to the questions, we will use two other LLMs, namely: Llama-2 and Mistral. In order to do this, we first a create a vector store for our documents and an associated retriever, which both of the LLM answer-generators will use.


```
from llama\_index import VectorStoreIndexfrom llama\_index.indices.vector\_store.retrievers import VectorIndexRetriever# Create vector indextrain\_index = VectorStoreIndex.from\_documents(documents=train\_documents)# Create the retriver on this indextrain\_retriever = VectorIndexRetriever(    index=train\_index,    similarity\_top\_k=2,)# Create vector index for test to be used latertest\_index = VectorStoreIndex.from\_documents(documents=test\_documents)# Create the retriver for test to be used latertest\_retriever = VectorIndexRetriever(    index=test\_index,    similarity\_top\_k=2,)
```
From here we will build `RetrieverQueryEngine`’s that will take in our queries (i.e. questions) for processing. Note that we use `HuggingFaceInferenceAPI` for our LLM answer-generators, and that Llama-2 requires permissions. If you haven’t yet gain accessed to these models, then feel free to swap out Llama-2 with another model of your choosing.


```
from llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)from llama\_index.llms import HuggingFaceInferenceAPIfrom llama\_index.llm\_predictor import LLMPredictordef create\_query\_engine(    hf\_name: str, retriever: VectorIndexRetriever) -> RetrieverQueryEngine: """Create a RetrieverQueryEngine using the HuggingFaceInferenceAPI LLM"""    if hf\_name not in hf\_llm\_generators:        raise KeyError("model not listed in hf\_llm\_generators")    llm = HuggingFaceInferenceAPI(        model\_name=hf\_llm\_generators[hf\_name],        context\_window=2048,  # to use refine        token=HUGGING\_FACE\_TOKEN,    )    context = ServiceContext.from\_defaults(llm\_predictor=LLMPredictor(llm=llm))    return RetrieverQueryEngine.from\_args(        retriever=retriever, service\_context=context    )
```

```
# define our llm-generators (query\_engines)hf\_llm\_generators = {    "mistral-7b-instruct": "mistralai/Mistral-7B-Instruct-v0.1",    "llama2-7b-chat": "meta-llama/Llama-2-7b-chat-hf",}train\_query\_engines = {    mdl: create\_query\_engine(mdl, train\_retriever)    for mdl in hf\_llm\_generators.keys()}test\_query\_engines = {    mdl: create\_query\_engine(mdl, test\_retriever)    for mdl in hf\_llm\_generators.keys()}
```
We’re ready to now to produce the answers from the various LLMs. We’ll do this now for the `train\_dataset` and hold off on doing this for `test\_dataset` until the time comes for us to use it.

NOTE: this will take some time to generate. If you’d rather not wait, you have the option of loading the `train\_qa.jsonl` that contains Llama-2 and Mistral answers per question.


```
import tqdmimport randomtrain\_dataset = []for q in tqdm.tqdm(train\_questions):    # randomly select two LLMs to generate answers to this q    model\_versus = random.sample(list(train\_query\_engines.items()), 2)    # data for this q    data\_entry = {"question": q}    responses = []    source = None    # generate answers    for name, engine in model\_versus:        response = engine.query(q)        response\_struct = {}        response\_struct["model"] = name        response\_struct["text"] = str(response)        if source is not None:            assert source == response.source\_nodes[0].node.text[:1000] + "..."        else:            source = response.source\_nodes[0].node.text[:1000] + "..."        responses.append(response\_struct)    data\_entry["answers"] = responses    data\_entry["source"] = source    train\_dataset.append(data\_entry)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 75/75 [07:40<00:00,  6.14s/it]
```
### Get GPT-4 Evaluations On The Mistral and LLama-2 Answers[](#get-gpt-4-evaluations-on-the-mistral-and-llama-2-answers "Permalink to this heading")

As mentioned a couple of times before, the point of this guide is fine-tune an LLM judge from a GPT-4 judge. So, in order to complete our `train\_dataset` we now need to instantiate our GPT-4 judge and have it evaluate the answers that were provided by the other LLMs: Llama-2 and Mistral. To do this, we will use the `PairwiseComparisonEvaluator` class. What this judge will do then is it will compare the two answers and provide a verdict as to whether Llama-2’s answer is better, Mistral’s answer is better, or if it’s a tie.

There is a bit of added nuance here since with pairwise evaluations, we have to be mindful of the potential for “position-bias”. This is when the judge favours the first answer that was presented to it (within the prompt/context). To account for this position-bias, we invoke the GPT-4 judge to perform to evaluations per sample, where in the second evaluation, we switch the order of presentation of the two answers (i.e., first evaluation: Llama-2 then Mistral, second evaluation: Mistral then Llama-2).

Finally, we also use the `OpenAIFineTuningHandler` which will collect all the chat histories that we will eventually need to fine-tune GPT-3.5.

NOTE: this will take some time to generate the judgements. Again, you have the option to load the `train\_qa.jsonl` as `train\_dataset`. Moreover, we also stored the JSONL files that we passed to OpenAI to fine-tune GPT-3.5.


```
# instantiate the gpt-4 judgefrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContextfrom llama\_index.callbacks import OpenAIFineTuningHandlerfrom llama\_index.callbacks import CallbackManagerfrom llama\_index.evaluation import PairwiseComparisonEvaluator# NOTE: this finetuning\_handler will collect 2x chat\_histories for# each query: one for original, and another for flippedmain\_finetuning\_handler = OpenAIFineTuningHandler()callback\_manager = CallbackManager([main\_finetuning\_handler])gpt\_4\_context = ServiceContext.from\_defaults(    llm=OpenAI(temperature=0, model="gpt-4"),    callback\_manager=callback\_manager,)gpt4\_judge = PairwiseComparisonEvaluator(service\_context=gpt\_4\_context)
```

```
for data\_entry in tqdm.tqdm(train\_dataset):    final\_eval\_result = await gpt4\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["answers"][0]["text"],        second\_response=data\_entry["answers"][1]["text"],        reference=data\_entry["source"],    )    # save final result    judgement = {}    judgement["llm"] = "gpt\_4"    judgement["score"] = final\_eval\_result.score    judgement["text"] = final\_eval\_result.response    judgement["source"] = final\_eval\_result.pairwise\_source    data\_entry["evaluations"] = [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 75/75 [48:04<00:00, 38.46s/it]
```
Let’s see how one of these GPT-4 evaluations looks like.


```
# let's see the last onedisplay\_eval\_df(    question=data\_entry["question"],    source=data\_entry["source"],    answer\_a=data\_entry["answers"][0],    answer\_b=data\_entry["answers"][1],    result=final\_eval\_result,)
```


|  | Question | Source | Model A | Answer A | Model B | Answer B | Score | Judgement |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | What resources are available in Boston for studying and preserving historical artifacts and remains? | In 1963, Boston Mayor John F. Collins and Boston Redevelopment Authority (BRA) executive Edward J. Logue organized a consortium of savings banks, cooperatives, and federal and state savings and loan associations in the city called the Boston Banks Urban Renewal Group (B-BURG) that would reverse redline parts of Dorchester, Roxbury, and Mattapan along Blue Hill Avenue. Despite the passage of legislation by the 156th Massachusetts General Court banning racial discrimination or segregation in housing in 1950, as well as the issuance of Executive Order 11063 by President John F. Kennedy in 1962 requiring all federal agencies to prevent racial discrimination in all federally-funded subsidized housing in the United States, the Boston Housing Authority (BHA) Board actively segregated the public housing developments in the city during the Collins administration as well, with BHA departments engaging in bureaucratic resistance against integration through at least 1966 and the Board retaining co... | llama2-7b-chat | There are several resources available in Boston for studying and preserving historical artifacts and remains. Some of these include:1. The Boston Historical Society: This organization provides access to historical artifacts, photographs, and documents related to Boston's history.2. Boston Mapjunction: This website provides over 200 historical maps of Boston dating back to 1630, as well as aerial photos compared with maps of today.3. City of Boston Archaeology Program and Lab: The City of Boston has a City Archaeologist on staff to oversee any lots of land to be developed for historical artifacts and significance, and to manage the archaeological remains located on public land in Boston. The program also has an Archaeology Laboratory and Education and Curation Center.4. The Freedom House Photographs Collection: This collection contains over 2,000 images of Roxbury people, places, and events from 1950 to 1975.5. Vital Records of Boston: This resource provides access to historical records related to births, marriages, and deaths in Boston.6. Reading and Everyday Life in | mistral-7b-instruct | The City of Boston has a City Archaeologist on staff to oversee any lots of land to be developed for historical artifacts and significance, and to manage the archaeological remains located on public land in Boston, and also has a City Archaeology Program and an Archaeology Laboratory, Education and Curation Center. The Freedom House Photographs Collection contains over 2,000 images of Roxbury people, places and events, 1950–1975 (Archives and Special Collections of the Northeastern University Libraries in Boston, MA). | 1.000000 | Assistant A provides a more comprehensive answer, listing several resources available in Boston for studying and preserving historical artifacts and remains. These include the Boston Historical Society, Boston Mapjunction, the City of Boston Archaeology Program and Lab, the Freedom House Photographs Collection, and Vital Records of Boston. This answer is more detailed and provides a wider range of resources for the user to explore.Assistant B, on the other hand, only mentions the City of Boston Archaeology Program and Lab and the Freedom House Photographs Collection. While these are relevant resources, the answer lacks the depth and variety of Assistant A's response.Therefore, based on the depth, variety, and level of detail in the responses, Assistant A's answer is superior.Final Verdict: [[A]] |

#### Special Care To The Fine-Tuning JSONL[](#special-care-to-the-fine-tuning-jsonl "Permalink to this heading")

Since there are two evaluations (one for original order of presentation of the LLM answers and another for a flipped ordering), we need to be careful to choose the correct one to keep in our fine-tuning dataset. What this means is that we need to pick off the correct events that were collected by our `OpenAIFineTuningHandler` and then only use those to prepare the JSONL which we will pass to OpenAI’s fine-tuning API.


```
main\_finetuning\_handler.save\_finetuning\_events(    "pairwise\_finetuning\_events.jsonl")
```

```
Wrote 150 examples to pairwise_finetuning_events.jsonl
```

```
# Get the fine\_tuning\_examples master datasetwith open("pairwise\_finetuning\_events.jsonl") as f:    combined\_finetuning\_events = [json.loads(line) for line in f]
```

```
finetuning\_events = (    [])  # for storing events using original order of presentationflipped\_finetuning\_events = (    [])  # for storing events using flipped order of presentationfor ix, event in enumerate(combined\_finetuning\_events):    if ix % 2 == 0:  # we always do original ordering first        finetuning\_events += [event]    else:  # then we flip order and have GPT-4 make another judgement        flipped\_finetuning\_events += [event]
```

```
assert len(finetuning\_events) == len(flipped\_finetuning\_events)
```

```
# we need to pick which of the chat\_histories to keepresolved\_finetuning\_events = []for ix, data\_entry in enumerate(train\_dataset):    if data\_entry["evaluations"][0]["source"] == "original":        resolved\_finetuning\_events += [finetuning\_events[ix]]    elif data\_entry["evaluations"][0]["source"] == "flipped":        resolved\_finetuning\_events += [flipped\_finetuning\_events[ix]]    else:        continue
```

```
with open("resolved\_pairwise\_finetuning\_events.jsonl", "w") as outfile:    for entry in resolved\_finetuning\_events:        print(json.dumps(entry), file=outfile)
```
Step 2 Perform knowledge distillation[](#step-2-perform-knowledge-distillation "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

Okay, it’s now time to distill some knowledge from GPT-4 to GPT-3.5 To do this, we will make use of the `OpenAIFinetuneEngine` class as well as the `resolved\_pairwise\_finetuning\_events.jsonl` file that we just created.


```
from llama\_index.finetuning import OpenAIFinetuneEnginefinetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "resolved\_pairwise\_finetuning\_events.jsonl",)
```

```
finetune\_engine.finetune()
```

```
Num examples: 72First example:{'role': 'system', 'content': "Please act as an impartial judge and evaluate the quality of the responses provided by two AI question-answering assistants to the user question perhaps with added reference which are displayed below. You should choose the assistant that follows the user’s instructions and answers the user’s question better using the provided context. Your evaluation should consider factors such as the helpfulness, relevance, accuracy, depth, creativity, and level of detail of their responses. Begin your evaluation by comparing the two responses and provide a short explanation. Avoid any position biases and ensure that the order in which the responses were presented does not influence your decision. Do not allow the length of the responses to influence your evaluation. Do not favor certain names of the assistants. Be as objective as possible. After providing your explanation, output your final verdict by strictly following this format: '[[A]]' if assistant A is better, '[[B]]' if assistant B is better, and '[[C]]' for a tie.\n"}{'role': 'user', 'content': "[User Question]\nWhat event in 1906 caused significant damage to San Francisco but was followed by a quick rebuild?\n\n[The Start of Reference]\n=== Reconstruction ===\nAlmost immediately after the quake re-planning and reconstruction plans were hatched to quickly rebuild the city. One of the more famous and ambitious plans, proposed before the fire, came from famed urban planner, Daniel Burnham. His bold plan called for Haussmann style avenues, boulevards, and arterial thoroughfares that radiated across the city, a massive civic center complex with classical structures, what would have been the largest urban park in the world, stretching from Twin Peaks to Lake Merced with a large athenaeum at its peak, and various other proposals. This plan was dismissed by critics (both at the time and now), as impractical and unrealistic to municipal supply and demand. Property owners and the Real Estate industry were against the idea as well due to the amounts of their land the city would have to purchase to realize such proposals. While the original street grid was restored, many of Burnham's proposals eventually saw the light of day such ...\n[The End of Reference]\n\n[The Start of Assistant A’s Answer]\n\n\nThe 1906 earthquake and fire caused significant damage to San Francisco, with over 80% of the city destroyed, including almost all of the downtown core. The earthquake, which had a magnitude of 7.8 on the Richter scale, resulted from the rupture of over 270 miles of the San Andreas Fault, centered immediately offshore of San Francisco. Water mains ruptured throughout the city, and the fires that followed burned out of control for days, trapping many residents and causing widespread destruction. Despite the devastation, the city quickly rebuilt, with many of the buildings constructed after the disaster being more earthquake-resistant than those that had come before. The official death toll from this event was initially reported as 478, but was later revised to over 3,000.\n[The End of Assistant A’s Answer]\n\n[The Start of Assistant B’s Answer]\n1906 earthquake and fire.\n[The End of Assistant B’s Answer]"}{'role': 'assistant', 'content': "Assistant A provides a detailed and comprehensive response to the user's question, explaining the event that caused significant damage to San Francisco in 1906, which was the earthquake and fire. It also provides additional information about the earthquake's magnitude, the extent of the damage, and the city's quick rebuilding efforts. On the other hand, Assistant B's response is very brief and only mentions the earthquake and fire, without providing any additional information or context. Therefore, Assistant A's response is more helpful, relevant, accurate, and detailed. \n\nFinal Verdict: [[A]]"}No errors foundNum examples missing system message: 0Num examples missing user message: 0#### Distribution of num_messages_per_example:min / max: 3, 3mean / median: 3.0, 3.0p5 / p95: 3.0, 3.0#### Distribution of num_total_tokens_per_example:min / max: 579, 1198mean / median: 818.9305555555555, 772.0p5 / p95: 625.9, 1076.0#### Distribution of num_assistant_tokens_per_example:min / max: 66, 248mean / median: 129.26388888888889, 117.5p5 / p95: 81.0, 193.90 examples may be over the 4096 token limit, they will be truncated during fine-tuningDataset has ~58963 tokens that will be charged for during trainingBy default, you'll train for 3 epochs on this datasetBy default, you'll be charged for ~176889 tokensAs of August 22, 2023, fine-tuning gpt-3.5-turbo is $0.008 / 1K Tokens.This means your total cost for training will be $0.471704 per epoch.
```

```
# We can check the status of our current job as follows# This may take some time ...finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-jLxZggQbHz2F98IlhQEI9KIw at 0x2e6b91170> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-jLxZggQbHz2F98IlhQEI9KIw",  "model": "gpt-3.5-turbo-0613",  "created_at": 1698817329,  "finished_at": 1698817949,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::8FyRSSOl",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-qLTnxGSZX2rHP0Q7wJIDDNWX"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-xsAaOBjQ949ti0qk1xHHLOiF",  "hyperparameters": {    "n_epochs": 3  },  "trained_tokens": 176457,  "error": null}
```
3 Evaluate The Fine-Tuned GPT-3.5 Judge On The Test Dataset[](#evaluate-the-fine-tuned-gpt-3-5-judge-on-the-test-dataset "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------

Now that we have our fine-tuned GPT-3.5, let’s see how well it performs on a test set. But first, remember that we said we’d hold off on creating the `test\_dataset` until the time comes that we need it? Well, that time is now. So we will repeat the process of creating the `train\_dataset` here but instead now for the `test\_dataset`.

NOTE: generating these answers and evaluations will take some time. You have the option of loading `test\_qa\_complete.jsonl` which has all the evaluations from the three considered LLM judges. You can load that as `test\_dataset` and run the code found in the Metrics subsection below.


```
import random# Use Llama-2 and Mistral LLMs to generate the answers to the test queriestest\_dataset = []for q in tqdm.tqdm(test\_questions):    # randomly select two LLMs to generate answers to this q    model\_versus = random.sample(list(test\_query\_engines.items()), 2)    # data for this q    data\_entry = {"question": q}    responses = []    source = None    # generate answers    for name, engine in model\_versus:        response = engine.query(q)        response\_struct = {}        response\_struct["model"] = name        response\_struct["text"] = str(response)        if source is not None:            assert source == response.source\_nodes[0].node.text[:1000] + "..."        else:            source = response.source\_nodes[0].node.text[:1000] + "..."        responses.append(response\_struct)    data\_entry["answers"] = responses    data\_entry["source"] = source    test\_dataset.append(data\_entry)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 64/64 [28:23<00:00, 26.62s/it]
```

```
# get the gpt-4 judgments on the Mistal and Llama-2 answersfor data\_entry in tqdm.tqdm(test\_dataset):    final\_eval\_result = await gpt4\_judge.aevaluate(        query=data\_entry["question"],        response=data\_entry["answers"][0]["text"],        second\_response=data\_entry["answers"][1]["text"],        reference=data\_entry["source"],    )    # save final result    judgement = {}    judgement["llm"] = "gpt\_4"    judgement["score"] = final\_eval\_result.score    judgement["text"] = final\_eval\_result.response    judgement["source"] = final\_eval\_result.pairwise\_source    data\_entry["evaluations"] = [judgement]
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 64/64 [43:21<00:00, 40.66s/it]
```

```
from llama\_index.evaluation import EvaluationResult# use our fine-tuned GPT-3.5 to evaluate the answersft\_llm = finetune\_engine.get\_finetuned\_model()ft\_context = ServiceContext.from\_defaults(    llm=ft\_llm,)ft\_gpt\_3p5\_judge = PairwiseComparisonEvaluator(service\_context=ft\_context)for data\_entry in tqdm.tqdm(test\_dataset):    try:        final\_eval\_result = await ft\_gpt\_3p5\_judge.aevaluate(            query=data\_entry["question"],            response=data\_entry["answers"][0]["text"],            second\_response=data\_entry["answers"][1]["text"],            reference=data\_entry["source"],        )    except:        final\_eval\_result = EvaluationResult(            query=eval\_result.query,            response="",            passing=None,            score=0.5,            feedback="",            pairwise\_source="output-cannot-be-parsed",        )    # save final result    judgement = {}    judgement["llm"] = "ft\_gpt\_3p5"    judgement["score"] = final\_eval\_result.score    judgement["text"] = final\_eval\_result.response    judgement["source"] = final\_eval\_result.pairwise\_source    data\_entry["evaluations"] += [judgement]
```

```
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 64/64 [04:08<00:00,  3.88s/it]
```

```
# Similarly, use a non-fine-tuned judge to evaluate the answersgpt\_3p5\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo"))gpt\_3p5\_judge = PairwiseComparisonEvaluator(service\_context=gpt\_3p5\_context)for data\_entry in tqdm.tqdm(test\_dataset):    try:        final\_eval\_result = await gpt\_3p5\_judge.aevaluate(            query=data\_entry["question"],            response=data\_entry["answers"][0]["text"],            second\_response=data\_entry["answers"][1]["text"],            reference=data\_entry["source"],        )    except:        final\_eval\_result = EvaluationResult(            query=data\_entry["question"],            response="",            passing=None,            score=0.5,            feedback="",            pairwise\_source="output-cannot-be-parsed",        )    # save final result    judgement = {}    judgement["llm"] = "gpt\_3p5"    judgement["score"] = final\_eval\_result.score    judgement["text"] = final\_eval\_result.response    judgement["source"] = final\_eval\_result.pairwise\_source    data\_entry["evaluations"] += [judgement]
```

```
100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 64/64 [09:32<00:00,  8.95s/it]
```
### The Metrics[](#the-metrics "Permalink to this heading")

Phew! Now that we have generated all of the LLM judges evaluations of the Llama-2/Mistral answers on the test queries. Let’s now get a quantitative view on how close fine-tuned GPT-3.5 is to GPT-4.

For this, we report several metrics, namely:

* Agreement Rate with GPT-4 evaluations
* Correlation to GPT-4 evaluations
* Jaccard Similarity to GPT-4 evaluations

We also report the “inconclusive” counts, which is when the LLM judge switches its decision after being presented with the flipped order of presentation of Llama-2 and Mistral answers. Higher inconclusive counts is an indication of the LLM judge being susceptible to position bias, which is no good!


```
!pip install scikit-learn -q
```

```
[notice] A new release of pip is available: 23.2.1 -> 23.3.1[notice] To update, run: pip install --upgrade pip
```

```
import numpy as np# store the scores and inconclusive booleans for each sample per LLM judgescores = {"gpt\_4": [], "gpt\_3p5": [], "ft\_gpt\_3p5": []}inconclusives = {"gpt\_4": [], "gpt\_3p5": [], "ft\_gpt\_3p5": []}for ix, d in enumerate(test\_dataset):    for e in d["evaluations"]:        scores[e["llm"]].append(e["score"])        inconclusives[e["llm"]].append(            e["source"] not in ["original", "flipped"]        )
```

```
REPORT\_FMT\_STR = (    "{model}\n"    "-----------------\n"    "Number of inconclusives: {inconclusive}\n"    "Number of agreements with GPT-4: {agreement} out of {total}\n"    "Agreement rate: {agreement\_rate}\n"    "Correlation: {corr}\n"    "Jaccard: {jacc}\n\n")
```

```
from sklearn.metrics import jaccard\_score# numpy conversionnp\_scores\_gpt\_4 = np.array(scores["gpt\_4"])np\_scores\_gpt\_3p5 = np.array(scores["gpt\_3p5"])np\_scores\_ft\_gpt\_3p5 = np.array(scores["ft\_gpt\_3p5"])# can only compare when both judges have non inconclusive resultsft\_mask = ~np.array(inconclusives["gpt\_4"]) \* ~np.array(    inconclusives["ft\_gpt\_3p5"])no\_ft\_mask = ~np.array(inconclusives["gpt\_4"]) \* ~np.array(    inconclusives["gpt\_3p5"])# agreement ratesagreement\_ft = sum(np\_scores\_gpt\_4[ft\_mask] == np\_scores\_ft\_gpt\_3p5[ft\_mask])agreement\_rate\_ft = agreement\_ft / sum(ft\_mask)agreement\_no\_ft = sum(    np\_scores\_gpt\_4[no\_ft\_mask] == np\_scores\_gpt\_3p5[no\_ft\_mask])agreement\_rate\_no\_ft = agreement\_no\_ft / sum(no\_ft\_mask)# correlationscorr\_ft = np.corrcoef(np\_scores\_gpt\_4[ft\_mask], np\_scores\_ft\_gpt\_3p5[ft\_mask])[    0, 1]corr\_no\_ft = np.corrcoef(    np\_scores\_gpt\_4[no\_ft\_mask], np\_scores\_gpt\_3p5[no\_ft\_mask])[0, 1]# jaccardjaccard\_ft = jaccard\_score(    np\_scores\_gpt\_4[ft\_mask].astype(str),    np\_scores\_ft\_gpt\_3p5[ft\_mask].astype(str),    average="weighted",)jaccard\_no\_ft = jaccard\_score(    np\_scores\_gpt\_4[no\_ft\_mask].astype(str),    np\_scores\_gpt\_3p5[no\_ft\_mask].astype(str),    average="weighted",)print(    REPORT\_FMT\_STR.format(        model="GPT-3.5 w/ fine-tuning",        inconclusive=sum(inconclusives["ft\_gpt\_3p5"]),        agreement=agreement\_ft,        total=sum(ft\_mask),        agreement\_rate=agreement\_rate\_ft,        corr=corr\_ft,        jacc=jaccard\_ft,    ))print(    REPORT\_FMT\_STR.format(        model="GPT-3.5 w/out fine-tuning",        inconclusive=sum(inconclusives["gpt\_3p5"]),        agreement=agreement\_no\_ft,        total=sum(no\_ft\_mask),        agreement\_rate=agreement\_rate\_no\_ft,        corr=corr\_no\_ft,        jacc=jaccard\_no\_ft,    ))print(    f"GPT-4\n-----------------\nInconclusive Count: {sum(inconclusives['gpt\_4'])}")
```

```
GPT-3.5 w/ fine-tuning-----------------Number of inconclusives: 15Number of agreements with GPT-4: 41 out of 47Agreement rate: 0.8723404255319149Correlation: 0.765365523658036Jaccard: 0.773126734505088GPT-3.5 w/out fine-tuning-----------------Number of inconclusives: 24Number of agreements with GPT-4: 32 out of 38Agreement rate: 0.8421052631578947Correlation: 0.671929323262293Jaccard: 0.7308712958867757GPT-4-----------------Inconclusive Count: 4
```
Conclusion[](#conclusion "Permalink to this heading")
------------------------------------------------------

From the above numbers we see that fine-tuning a GPT-3.5 judge yields higher agreement scores, correlation, and jaccard similarity than a non-fine-tuned GPT-3.5 judge. What’s more is that we see the inconclusive counts go down after fine-tuning as well. Overall, we see that fine-tuning here has helped us to get a GPT-3.5 judge that is closer to a GPT-4 judge (and thus by proxy, closer to human judgements) and at the same time helped remedy the position bias that a non-fine-tuned GPT-3.5 would have otherwise.

