[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/finetuning/knowledge/finetune_knowledge.ipynb)

Fine-tuning to Memorize Knowledge[](#fine-tuning-to-memorize-knowledge "Permalink to this heading")
====================================================================================================

In this tutorial we experiment with some basic approaches of “baking in knowledge with fine-tuning.”

* Synthesizing questions from existing context
* Trying text completion

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaifrom llama\_index import ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index import VectorStoreIndex
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------


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
Generate Dataset[](#generate-dataset "Permalink to this heading")
------------------------------------------------------------------


```
from llama\_index.evaluation import DatasetGeneratorfrom llama\_index.node\_parser import SimpleNodeParser# try evaluation modulesfrom llama\_index.evaluation import RelevancyEvaluator, FaithfulnessEvaluatorfrom llama\_index import PromptTemplate
```

```
node\_parser = SimpleNodeParser.from\_defaults()nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
from tqdm.notebook import tqdmimport jsonnum\_questions\_per\_chunk = 10question\_gen\_query = (    "You are a Teacher/ Professor. Your task is to setup a quiz/examination."    f" Using the provided context, formulate {num\_questions\_per\_chunk} that"    " captures an important fact from the context. \nYou MUST obey the"    " following criteria:\n- Restrict the question to the context information"    " provided.\n- Do NOT create a question that cannot be answered from the"    " context.\n- Phrase the question so that it does NOT refer to specific"    ' context. For instance, do NOT put phrases like "given provided context"'    ' or "in this work" in the question, because if the question is asked'    " elsewhere it wouldn't be provided specific context. Replace these"    " terms with specific details.\nBAD questions:\nWhat did the author do in"    " his childhood\nWhat were the main findings in this report\n\nGOOD"    " questions:\nWhat did Barack Obama do in his childhood\nWhat were the"    " main findings in the original Transformers paper by Vaswani et"    " al.\n\nGenerate the questions below:\n")# go through each node one at a time -# generate questions, filter using eval modules, and dump to filefp = open("data/qa\_pairs.jsonl", "w")for idx, node in enumerate(nodes):    dataset\_generator = DatasetGenerator(        [node],        question\_gen\_query=question\_gen\_query,        service\_context=gpt\_4\_context,        metadata\_mode="all",    )    node\_questions\_0 = dataset\_generator.generate\_questions\_from\_nodes(num=10)    print(f"[Node {idx}] Generated questions:\n {node\_questions\_0}")    # for each question, get a response    for question in tqdm(node\_questions\_0):        index = SummaryIndex([node], service\_context=gpt\_35\_context)        query\_engine = index.as\_query\_engine()        response = query\_engine.query(question)        out\_dict = {"query": question, "response": str(response)}        print(f"[Node {idx}] Outputs: {out\_dict}")        fp.write(json.dumps(out\_dict) + "\n")fp.close()
```
### Filter out questions using RelevancyEvaluator[](#filter-out-questions-using-relevancyevaluator "Permalink to this heading")

Do a second pass to make sure only questions that can be answerd by context make it into the training set.


```
# try evaluation modulesfrom llama\_index.evaluation import RelevancyEvaluator, FaithfulnessEvaluatorfrom llama\_index import PromptTemplatefrom llama\_index.llms import OpenAI
```

```
query\_eval\_tmpl = PromptTemplate(    "Your task is to evaluate the following: If the response for the query"    " isn't able to answer the question provided.\nIf query isn't able to"    " answer the question, answer NO.\nOtherwise answer YES.\nTo elaborate,"    " you might get an answer like the following: 'The context does not"    " contain the answer to this question.'Please return NO in that case. You"    " be given the query and response. Return YES or NO as the answer.\nQuery:"    " \n {query\_str}\nResponse: \n {response\_str}\nAnswer: ")eval\_llm = OpenAI(model="gpt-4-0613")
```

```
def filter\_data(path: str, out\_path: str):    fp = open(path, "r")    out\_fp = open(out\_path, "w")    new\_lines = []    for idx, line in enumerate(fp):        qa\_pair = json.loads(line)        eval = eval\_llm.complete(            query\_eval\_tmpl.format(                query\_str=qa\_pair["query"], response\_str=qa\_pair["response"]            )        )        print(f"[{idx}] QA Pair: {qa\_pair} \n Eval: {eval}")        if "NO" in str(eval):            continue        else:            # new\_lines.append(line)            out\_fp.write(line)
```

```
filter\_data("data/qa\_pairs.jsonl", "data/qa\_pairs\_2.jsonl")
```
### Split into Training and Validation Sets[](#split-into-training-and-validation-sets "Permalink to this heading")

We split into training and validation sets.

**NOTE**: We shuffle the data before splitting. This helps ensure that the training data has coverage throughout the document.


```
from copy import deepcopyimport randomdef split\_train\_val(    path: str, out\_train\_path: str, out\_val\_path: str, train\_split=0.7):    with open(path, "r") as fp:        lines = fp.readlines()        # shuffle the lines to make sure that the "train questions" cover most fo the context        shuffled\_lines = deepcopy(lines)        random.shuffle(shuffled\_lines)        split\_idx = int(train\_split \* len(shuffled\_lines))        train\_lines = shuffled\_lines[:split\_idx]        val\_lines = shuffled\_lines[split\_idx:]        with open(out\_train\_path, "w") as out\_fp:            out\_fp.write("".join(train\_lines))        with open(out\_val\_path, "w") as out\_fp:            out\_fp.write("".join(val\_lines))
```

```
split\_train\_val(    "data/qa\_pairs\_2.jsonl",    "data/qa\_pairs\_train.jsonl",    "data/qa\_pairs\_val.jsonl",)
```
### Format into Training Data[](#format-into-training-data "Permalink to this heading")

Format into training data for OpenAI’s finetuning endpoints.

**NOTE**: We don’t use our `OpenAIFinetuningHandler` because that logs the full input prompt including context as the user message. Here we just want to log the query as the user message, because we want to fine-tune gpt-3.5-turbo to “bake in knowledge” into the fine-tuned model.


```
fp = open("data/qa\_pairs\_train.jsonl", "r")out\_fp = open("data/qa\_pairs\_openai.jsonl", "w")# TODO: try with different system promptssystem\_prompt = {    "role": "system",    "content": (        "You are a helpful assistant helping to answer questions about the"        " Llama 2 paper."    ),}for line in fp:    qa\_pair = json.loads(line)    user\_prompt = {"role": "user", "content": qa\_pair["query"]}    assistant\_prompt = {"role": "assistant", "content": qa\_pair["response"]}    out\_dict = {        "messages": [system\_prompt, user\_prompt, assistant\_prompt],    }    out\_fp.write(json.dumps(out\_dict) + "\n")
```
Fine-tune the Model[](#fine-tune-the-model "Permalink to this heading")
------------------------------------------------------------------------


```
from llama\_index.finetuning import OpenAIFinetuneEngine
```

```
finetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "data/qa\_pairs\_openai.jsonl",    # start\_job\_id="<start-job-id>" # if you have an existing job, can specify id here)
```

```
finetune\_engine.finetune()
```

```
Num examples: 597First example:{'role': 'system', 'content': 'You are a helpful assistant helping to answer questions about the Llama 2 paper.'}{'role': 'user', 'content': 'Who were the early reviewers of the paper on "Llama 2: Open Foundation and Fine-Tuned Chat Models" who helped improve its quality?'}{'role': 'assistant', 'content': 'Mike Lewis, Joelle Pineau, Laurens van der Maaten, Jason Weston, and Omer Levy were the early reviewers of the paper on "Llama 2: Open Foundation and Fine-Tuned Chat Models" who helped improve its quality.'}No errors foundNum examples missing system message: 0Num examples missing user message: 0#### Distribution of num_messages_per_example:min / max: 3, 3mean / median: 3.0, 3.0p5 / p95: 3.0, 3.0#### Distribution of num_total_tokens_per_example:min / max: 50, 637mean / median: 102.51256281407035, 90.0p5 / p95: 66.0, 155.0#### Distribution of num_assistant_tokens_per_example:min / max: 2, 588mean / median: 50.45728643216081, 35.0p5 / p95: 18.0, 102.00 examples may be over the 4096 token limit, they will be truncated during fine-tuningDataset has ~61200 tokens that will be charged for during trainingBy default, you'll train for 3 epochs on this datasetBy default, you'll be charged for ~183600 tokensAs of Augest 22, 2023, fine-tuning gpt-3.5-turbo is $0.008 / 1K Tokens.This means your total cost for training will be $0.48960000000000004 per epoch.Waiting for file to be ready...
```

```
finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-fk0428lntJCRh6x1GKeccv8E at 0x2b95fd6c0> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-fk0428lntJCRh6x1GKeccv8E",  "model": "gpt-3.5-turbo-0613",  "created_at": 1694406904,  "finished_at": 1694409009,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::7xTTW0hT",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-Ao1r7cGnYJbHqCG79zAQo6lP"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-9ndBjJX0pZ3Do4mPhADcTOef",  "hyperparameters": {    "n_epochs": 3  },  "trained_tokens": 180006,  "error": null}
```

```
ft\_model = finetune\_engine.get\_finetuned\_model()
```

```
ft\_model
```

```
OpenAI(callback_manager=<llama_index.callbacks.base.CallbackManager object at 0x2bdaba2f0>, model='ft:gpt-3.5-turbo-0613:llamaindex::7xTTW0hT', temperature=0.1, max_tokens=None, additional_kwargs={}, max_retries=10, class_type='openai')
```

```
# [Optional] use fine-tuned model in RAG system toofrom llama\_index import ServiceContextft\_context = ServiceContext.from\_defaults(    llm=ft\_model,    callback\_manager=callback\_manager,)# baseline RAG systemft\_index = VectorStoreIndex(nodes, service\_context=ft\_context)ft\_query\_engine = ft\_index.as\_query\_engine()
```
Evaluate Results[](#evaluate-results "Permalink to this heading")
------------------------------------------------------------------

We run evaluations, over both the validation set but also the training set.

**Wait, isn’t evaluating over the training set cheating?**

* It’s a sanity check of how much the model was able to memorize information it’s trained on.
* The training data contains quite a bit of content about the paper, so by answering the training set well the model would at least be well-equipped to answer some questions.


```
from llama\_index.llms import ChatMessage
```

```
def load\_data(path: str):    fp = open(path, "r")    data\_dicts = []    for line in fp:        d = json.loads(line)        data\_dicts.append(d)    return data\_dicts
```

```
train\_dicts = load\_data("data/qa\_pairs\_train.jsonl")eval\_dicts = load\_data("data/qa\_pairs\_val.jsonl")
```

```
def query\_model(model, d):    # print(d)    msgs = [        ChatMessage(            role="system",            content=(                "You are a helpful assistant helping to answer questions about"                " the Llama 2 paper."            ),        ),        ChatMessage(role="user", content=d["query"]),    ]    # try ft-model    response = model.chat(msgs)    return str(response)
```

```
response = query\_model(ft\_model, eval\_dicts[7])print(eval\_dicts[7])print(response)
```

```
{'query': 'What is the title of the paper discussed in the context?', 'response': 'The title of the paper discussed in the context is "Llama 2: Open Foundation and Fine-Tuned Chat Models".'}
```

```
'assistant: The title of the paper discussed in the context is "Llama 2: Open Foundation and Fine-Tuned Chat Models".'
```

```
query\_model(ft\_model, train\_dicts[7])print(train\_dicts[7])print(response)
```

```
{'query': 'How is the decision made whether to use safety context distillation or not?', 'response': 'The decision to use safety context distillation is made based on the reward model score. The safety reward model is leveraged to determine whether the context-distilled output receives a better reward model score than the original answer. If the context-distilled output gets a better reward model score, it is kept. This approach helps limit the negative impact of context distillation while still utilizing it in cases where it improves the reward model score.'}
```

```
'assistant: The decision to use safety context distillation is made based on the reward model score. If the reward model score is below a certain threshold, safety context distillation is used.'
```
### Setup Baseline RAG system to benchmark[](#setup-baseline-rag-system-to-benchmark "Permalink to this heading")

We setup a baseline RAG system powered by gpt-3.5-turbo to help benchmark the quality of results.


```
# baseline RAG systembase\_index = VectorStoreIndex(nodes, service\_context=gpt\_35\_context)base\_query\_engine = base\_index.as\_query\_engine()
```

```
# baseline modelbase\_model = OpenAI(model="gpt-4", temperature=0.3)
```

```
query\_model(base\_model, eval\_dicts[80])
```

```
{'query': 'How does Llama 2-Chat address the issue of spreading misinformation or conspiracy theories?', 'response': "Llama 2-Chat addresses the issue of spreading misinformation or conspiracy theories by refuting any misinformation in the prompt immediately. It emphasizes the importance of relying on scientific evidence and credible sources when evaluating historical events. The model does not promote or encourage the spread of false information and instead focuses on sharing accurate and helpful information. It also highlights the importance of fact-checking and critical thinking when assessing the validity of a claim. Llama 2-Chat's programming rules prioritize respect for truth and accuracy in all forms of communication and discourage the spread of misinformation or conspiracy theories."}
```

```
"assistant: The Llama 2 paper does not specifically address the issue of spreading misinformation or conspiracy theories. However, it does mention that the model is designed to refuse outputs that are inappropriate or harmful. This could potentially include misinformation or conspiracy theories. It also states that the model's responses are based on a mixture of licensed data, data created by human trainers, and publicly available data. The developers have also used reinforcement learning from human feedback to fine-tune the model, which can help in reducing the spread of false information. However, the specifics of how misinformation or conspiracy theories are handled are not detailed in the paper."
```
### Run Evaluations[](#run-evaluations "Permalink to this heading")

We log the responses from the fine-tuned model, the baseline RAG system, and the baseline model.

We then run all responses through a GPT-4 prompt, comparing each against the ground-truth to measure validity of the result.


```
import pandas as pdfrom tqdm.notebook import tqdmEVAL\_PROMPT\_TMPL = PromptTemplate( """\We provide a question and the 'ground-truth' answer. We also provide \the predicted answer.Evaluate whether the predicted answer is correct, given its similarity \to the ground-truth. If details provided in predicted answer are reflected \in the ground-truth answer, return "YES". To return "YES", the details don't \need to exactly match. Be lenient in evaluation if the predicted answer \is missing a few details. Try to make sure that there are no blatant mistakes. \Otherwise, return "NO".Question: {question}Ground-truth Answer: {gt\_answer}Predicted Answer: {pred\_answer}Evaluation Result: \""")def eval\_match\_gt(query, gt\_response, pred\_response):    llm = OpenAI(model="gpt-4", temperature=0.0)    fmt\_prompt = EVAL\_PROMPT\_TMPL.format(        question=query,        gt\_answer=gt\_response,        pred\_answer=pred\_response,    )    result = llm.complete(fmt\_prompt)    if "yes" in str(result).lower():        return 1    else:        return 0def run\_evals(eval\_dicts): """Run evals - fine-tuned model, RAG system, and base model."""    raw\_responses = []    for eval\_dict in tqdm(eval\_dicts):        gt\_response = eval\_dict["response"]        ft\_rag\_response = str(ft\_query\_engine.query(eval\_dict["query"]))        ft\_response = str(query\_model(ft\_model, eval\_dict))        rag\_response = str(base\_query\_engine.query(eval\_dict["query"]))        base\_response = str(query\_model(base\_model, eval\_dict))        # try evaluations        ft\_rag\_eval = eval\_match\_gt(            eval\_dict["query"], gt\_response, ft\_rag\_response        )        ft\_eval = eval\_match\_gt(eval\_dict["query"], gt\_response, ft\_response)        rag\_eval = eval\_match\_gt(eval\_dict["query"], gt\_response, rag\_response)        base\_eval = eval\_match\_gt(            eval\_dict["query"], gt\_response, base\_response        )        response\_dict = {            "query": eval\_dict["query"],            "gt\_response": gt\_response,            "ft\_rag\_response": ft\_rag\_response,            "ft\_response": ft\_response,            "rag\_response": rag\_response,            "base\_response": base\_response,            "ft\_rag\_eval": ft\_rag\_eval,            "ft\_eval": ft\_eval,            "rag\_eval": rag\_eval,            "base\_eval": base\_eval,        }        raw\_responses.append(response\_dict)    raw\_responses\_df = pd.DataFrame(raw\_responses)    eval\_dict = {        "ft\_rag\_score": raw\_responses\_df["ft\_rag\_eval"].mean(),        "ft\_score": raw\_responses\_df["ft\_eval"].mean(),        "rag\_score": raw\_responses\_df["rag\_eval"].mean(),        "base\_score": raw\_responses\_df["base\_eval"].mean(),    }    sub\_responses\_df = raw\_responses\_df[        [            "query",            "gt\_response",            "ft\_rag\_response",            "ft\_response",            "rag\_response",            "base\_response",        ]    ]    return eval\_dict, raw\_responses\_df, sub\_responses\_df
```

```
pd.set\_option("display.max\_colwidth", None)
```
#### Qualitative Evaluations[](#qualitative-evaluations "Permalink to this heading")

Here we show some qualitative output examples over both the training and validation sets.


```
eval\_dict, raw\_response\_df, sub\_responses\_df = run\_evals(train\_dicts[7:8])display(eval\_dict)display(sub\_responses\_df)
```

```
{'ft_rag_score': 1.0, 'ft_score': 1.0, 'rag_score': 1.0, 'base_score': 0.0}
```


|  | query | gt\_response | ft\_rag\_response | ft\_response | rag\_response | base\_response |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | How is the decision made whether to use safety context distillation or not? | The decision to use safety context distillation is made based on the reward model score. The safety reward model is leveraged to determine whether the context-distilled output receives a better reward model score than the original answer. If the context-distilled output gets a better reward model score, it is kept. This approach helps limit the negative impact of context distillation while still utilizing it in cases where it improves the reward model score. | The decision on whether to use safety context distillation or not is made based on the reward model score. The safety reward model is leveraged to determine whether the context-distilled output is preferred over the original answer. Safety context distillation is only kept on examples where it receives a better reward model score. This approach helps to limit the negative impact of context distillation while still improving the model's responses on prompts that it is not good at. | assistant: The decision to use safety context distillation is made based on the reward model score. If the reward model score is higher than a certain threshold, safety context distillation is used. | The decision to use safety context distillation is made based on the reward model score. The safety reward model is used to evaluate whether the context-distilled output gets a better reward model score than the original answer. If the context-distilled output receives a better reward model score, it is kept. This approach helps limit the negative impact of context distillation while still improving the safety of the model's responses. | assistant: The decision to use safety context distillation in the Llama 2 paper is based on the nature of the situation and the need for safety. If the model is in a situation where it needs to generate safe responses, then safety context distillation is used. This is particularly important when the model is interacting with users in real-time, where there's a need to ensure that the outputs are safe and appropriate. The decision is not explicitly mentioned in the paper but is inferred from the context and the purpose of safety context distillation. |


```
eval\_dict, raw\_response\_df, sub\_responses\_df = run\_evals(eval\_dicts[6:7])display(eval\_dict)display(sub\_responses\_df)
```

```
{'ft_rag_score': 1.0, 'ft_score': 0.0, 'rag_score': 1.0, 'base_score': 0.0}
```


|  | query | gt\_response | ft\_rag\_response | ft\_response | rag\_response | base\_response |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | What model is used to predict the truthfulness and informativeness of the generated outputs from LLMs? | A fine-tuned GPT-3 model, referred to as "GPT-judge," is used to predict the truthfulness and informativeness of the generated outputs from LLMs. | A fine-tuned GPT-3 model, also known as a "GPT-judge," is used to predict the truthfulness and informativeness of the generated outputs from LLMs. | assistant: The model used to predict the truthfulness and informativeness of the generated outputs from LLMs is called TruthfulQA. | A fine-tuned GPT-3 model, referred to as a "GPT-judge," is used to predict the truthfulness and informativeness of the generated outputs from LLMs. | assistant: The Llama 2 paper does not specify a particular model used to predict the truthfulness and informativeness of the generated outputs from Language Models. The paper primarily focuses on the limitations and risks of large language models and does not delve into specific methods or models for evaluating truthfulness or informativeness. |

#### Quantitative Evaluations[](#quantitative-evaluations "Permalink to this heading")

Here we show quantitative metrics over both the training and eval set.


```
import randomk = 40train\_dicts\_sample = random.sample(train\_dicts, k)eval\_dicts\_sample = random.sample(eval\_dicts, k)
```

```
result\_train, raw\_response\_df, sub\_responses\_df = run\_evals(train\_dicts\_sample)display(result\_train)# display(raw\_response\_df)
```

```
{'ft_rag_score': 0.75, 'ft_score': 0.45, 'rag_score': 0.7, 'base_score': 0.3}
```

```
# look at where ft\_rag\_score did well but rag didn'td = raw\_response\_dfd[(d["ft\_rag\_eval"] == 1) & (d["rag\_eval"] == 0)]
```


|  | query | gt\_response | ft\_rag\_response | ft\_response | rag\_response | base\_response | ft\_rag\_eval | ft\_eval | rag\_eval | base\_eval |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 11 | What is the five-shot performance of Llama 2 with a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark? | The five-shot performance of Llama 2 with a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark is 78.5. | The five-shot performance of Llama 2 with a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark is 78.5. | assistant: The five-shot performance of Llama 2 with a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark is 82.7. | The five-shot performance of Llama 2 with a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark is 85.0. | assistant: The Llama 2 paper does not provide specific information on the five-shot performance of a 70B model on the Massive Multitask Language Understanding (MMLU) benchmark. Please refer to the original paper or contact the authors for the most accurate information. | 1 | 0 | 0 | 0 |
| 22 | What is the role of third-party SFT data in the fine-tuning process of the Llama 2 model? | The role of third-party SFT data in the fine-tuning process of the Llama 2 model is to provide additional examples for aligning the model towards dialogue-style instructions. However, the context does not provide specific details about how the third-party SFT data is utilized in the fine-tuning process. | The role of third-party SFT data in the fine-tuning process of the Llama 2 model is to align LLMs (Language Model Models) towards dialogue-style instructions. However, it has been found that many of these third-party SFT datasets have insufficient diversity and quality. As a result, the focus was shifted to collecting several thousand examples of high-quality SFT data. By using fewer but higher-quality examples from vendor-based annotation efforts, the results notably improved. The findings are similar to previous research that suggests a limited set of clean instruction-tuning data can be sufficient to achieve a high level of quality. It was found that tens of thousands of SFT annotations were enough to achieve a high-quality result in the fine-tuning process of the Llama 2 model. | assistant: The role of third-party SFT data in the fine-tuning process of the Llama 2 model is to provide additional training data for certain categories. This data is used to improve the performance of the model in those specific categories. | The context does not provide information about the role of third-party SFT data in the fine-tuning process of the Llama 2 model. | assistant: I'm sorry for any confusion, but as of my current knowledge, there is no specific model called "Llama 2". Therefore, I can't provide information about the role of third-party SFT data in its fine-tuning process. However, I can tell you that in general, third-party SFT (Supervised Fine-Tuning) data is often used in machine learning to improve the performance of a model by training it on a specific task. If you have any more details or if there's a specific context, I'd be happy to help further! | 1 | 1 | 0 | 0 |
| 35 | What measures have been taken to mitigate the generation of harmful, offensive, or biased content by Llama 2? | Efforts have been made to mitigate the generation of harmful, offensive, or biased content by Llama 2. The model has undergone fine-tuning to address these issues, although some issues may still remain, especially for languages other than English where publicly available datasets were not available. OpenAI acknowledges the potential for harmful, offensive, or biased content due to the training on publicly available online datasets. They have attempted to balance safety with helpfulness, but in some instances, the safety tuning may go too far, resulting in an overly cautious approach. OpenAI encourages users of Llama 2 to be cautious and take extra steps in tuning and deployment as described in their Responsible Use Guide. | Instruction fine-tuning has been used to mitigate the generation of harmful, offensive, or biased content by Llama 2. This process has shown to effectively reduce the percentage of toxic model generations, resulting in an effectively zero percentage of toxic generations for the fine-tuned Llama 2-Chat models of all sizes. The results of the toxicity analysis for the fine-tuned models are not presented in Table 45 because of this significant reduction in toxic content generation. | assistant: Llama 2 has been trained on a filtered and curated dataset to mitigate the generation of harmful, offensive, or biased content. Additionally, a reward model has been used to fine-tune Llama 2-Chat to further align the model with human preferences and to reduce the generation of harmful and untruthful outputs. The reward model is based on the comparison of model responses, where human annotators rank the responses according to their quality. This iterative process of training and evaluation has helped in mitigating the generation of harmful, offensive, or biased content by Llama 2. | Llama 2 has taken measures to mitigate the generation of harmful, offensive, or biased content. One of the measures is the use of the ToxiGen dataset, which contains implicitly toxic and benign sentences mentioning minority groups. Llama 2 uses a revised version of this dataset to reduce noise and filter out prompts for which annotators disagree on the target demographic group. Additionally, Llama 2 employs a default ToxiGen classifier tuned on RoBERTa to measure the toxicity of its generations. Furthermore, Llama 2 conducts a sentiment analysis using the Valence Aware Dictionary and Sentiment Reasoner (VADER) to evaluate the sentiments conveyed by the combination of prompt prefix and model generation. These measures help in analyzing and addressing the potential biases and toxicity in the generated content. | assistant: The Llama 2 paper does not provide specific details on measures taken to mitigate the generation of harmful, offensive, or biased content. However, it's common for AI models like Llama 2 to incorporate various strategies to ensure responsible use. These may include the use of reinforcement learning from human feedback to reduce harmful and untruthful outputs, and the use of guidelines for human reviewers during the fine-tuning process to avoid potential biases. Additionally, efforts are often made to improve the default behavior of the system, and provide users with customization options to define the AI's values within broad bounds. Please refer to the original source or the organization behind Llama 2 for more specific information. | 1 | 1 | 0 | 0 |


```
result\_eval, raw\_response\_df, sub\_responses\_df = run\_evals(eval\_dicts\_sample)display(result\_eval)# display(raw\_response\_df)
```

```
{'ft_rag_score': 0.825, 'ft_score': 0.375, 'rag_score': 0.775, 'base_score': 0.225}
```
