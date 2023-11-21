[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/cross_encoder_finetuning/cross_encoder_finetuning.ipynb)

How to Finetune a cross-encoder using LLamaIndex[](#how-to-finetune-a-cross-encoder-using-llamaindex "Permalink to this heading")
==================================================================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Download Requirements!pip install datasets --quiet!pip install sentence-transformers --quiet!pip install openai --quiet
```

```
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 519.6/519.6 kB 7.7 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 115.3/115.3 kB 11.6 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 194.1/194.1 kB 19.2 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 134.8/134.8 kB 13.0 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 302.0/302.0 kB 25.5 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 86.0/86.0 kB 1.9 MB/s eta 0:00:00?25h  Preparing metadata (setup.py) ... ?25l?25hdone     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 7.7/7.7 MB 42.3 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.3/1.3 MB 43.9 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.8/3.8 MB 52.1 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.3/1.3 MB 58.6 MB/s eta 0:00:00     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 295.0/295.0 kB 27.1 MB/s eta 0:00:00?25h  Building wheel for sentence-transformers (setup.py) ... ?25l?25hdone     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 77.0/77.0 kB 1.8 MB/s eta 0:00:00?25h
```
Process[](#process "Permalink to this heading")
------------------------------------------------

* Download the QASPER Dataset from HuggingFace Hub using Datasets Library (https://huggingface.co/datasets/allenai/qasper)
* From the train and test splits of the dataset extract 800 and 80 samples respectively
* Use the 800 samples collected from train data which have the respective questions framed on a research paper to generate a dataset in the respective format required for CrossEncoder finetuning. Currently the format we use is that a single sample of fine tune data consists of two sentences(question and context) and a score either 0 or 1 where 1 shows that the question and context are relevant to each other and 0 shows they are not relevant to each other.
* Use the 100 samples of test set to extract two kinds of evaluation datasets


	+ Rag Eval Dataset:-One dataset consists of samples where a single sample consists of a research paper content, list of questions on the research paper, answers of the list of questions on the research paper. While forming this dataset we keep only questions which have long answers/ free-form answers for better comparision with RAG generated answers.
	+ Reranking Eval Dataset:- The other datasets consists of samples where a single sample consists of the research paper content, list of questions on the research paper, list of contexts from the research paper contents relevant to each question
* We finetuned the cross-encoder using helper utilities written in llamaindex and push it to HuggingFace Hub using the huggingface cli tokens login which can be found here:- https://huggingface.co/settings/tokens
* We evaluate on both datasets using two metrics and three cases


	1. Just OpenAI embeddings without any reranker
	2. OpenAI embeddings combined with cross-encoder/ms-marco-MiniLM-L-12-v2 as reranker
	3. OpenAI embeddings combined with our fine-tuned cross encoder model as reranker
* Evaluation Criteria for each Eval Dataset


	+ Hits metric:- For evaluating the Reranking Eval Dataset we just simply use the retriever+ post-processor functionalities of LLamaIndex to see in the different cases how many times does the relevant context gets retrieved and call it the hits metric.
	+ Pairwise Comparision Evaluator:- We use the Pairwise Comparision Evaluator provided by LLamaIndex (https://github.com/run-llama/llama\_index/blob/main/llama\_index/evaluation/pairwise.py) to compare the responses of the respective query engines created in each case with the reference free-form answers provided.
Load the Dataset[](#load-the-dataset "Permalink to this heading")
------------------------------------------------------------------


```
from datasets import load\_datasetimport random# Download QASPER dataset from HuggingFace https://huggingface.co/datasets/allenai/qasperdataset = load\_dataset("allenai/qasper")# Split the dataset into train, validation, and test splitstrain\_dataset = dataset["train"]validation\_dataset = dataset["validation"]test\_dataset = dataset["test"]random.seed(42)  # Set a random seed for reproducibility# Randomly sample 800 rows from the training splittrain\_sampled\_indices = random.sample(range(len(train\_dataset)), 800)train\_samples = [train\_dataset[i] for i in train\_sampled\_indices]# Randomly sample 100 rows from the test splittest\_sampled\_indices = random.sample(range(len(test\_dataset)), 80)test\_samples = [test\_dataset[i] for i in test\_sampled\_indices]# Now we have 800 research papers for training and 80 research papers to evaluate on
```
QASPER Dataset[](#qasper-dataset "Permalink to this heading")
--------------------------------------------------------------

* Each row has the below 6 columns


	+ id: Unique identifier of the research paper
	+ title: Title of the Research paper
	+ abstract: Abstract of the research paper
	+ full\_text: full text of the research paper
	+ qas: Questions and answers pertaining to each research paper
	+ figures\_and\_tables: figures and tables of each research paper


```
# Get full text paper data , questions on the paper from training samples of QASPER to generate training dataset for cross-encoder finetuningfrom typing import List# Utility function to get full-text of the research papers from the datasetdef get\_full\_text(sample: dict) -> str: """ :param dict sample: the row sample from QASPER """    title = sample["title"]    abstract = sample["abstract"]    sections\_list = sample["full\_text"]["section\_name"]    paragraph\_list = sample["full\_text"]["paragraphs"]    combined\_sections\_with\_paras = ""    if len(sections\_list) == len(paragraph\_list):        combined\_sections\_with\_paras += title + "\t"        combined\_sections\_with\_paras += abstract + "\t"        for index in range(0, len(sections\_list)):            combined\_sections\_with\_paras += str(sections\_list[index]) + "\t"            combined\_sections\_with\_paras += "".join(paragraph\_list[index])        return combined\_sections\_with\_paras    else:        print("Not the same number of sections as paragraphs list")# utility function to extract list of questions from the datasetdef get\_questions(sample: dict) -> List[str]: """ :param dict sample: the row sample from QASPER """    questions\_list = sample["qas"]["question"]    return questions\_listdoc\_qa\_dict\_list = []for train\_sample in train\_samples:    full\_text = get\_full\_text(train\_sample)    questions\_list = get\_questions(train\_sample)    local\_dict = {"paper": full\_text, "questions": questions\_list}    doc\_qa\_dict\_list.append(local\_dict)
```

```
len(doc\_qa\_dict\_list)
```

```
800
```

```
# Save training data as a csvimport pandas as pddf\_train = pd.DataFrame(doc\_qa\_dict\_list)df\_train.to\_csv("train.csv")
```
### Generate RAG Eval test data[](#generate-rag-eval-test-data "Permalink to this heading")


```
# Get evaluation data papers , questions and answers"""The Answers field in the dataset follow the below format:-Unanswerable answers have "unanswerable" set to true.The remaining answers have exactly one of the following fields being non-empty."extractive\_spans" are spans in the paper which serve as the answer."free\_form\_answer" is a written out answer."yes\_no" is true iff the answer is Yes, and false iff the answer is No.We accept only free-form answers and for all the other kind of answers we set their value to 'Unacceptable',to better evaluate the performance of the query engine using pairwise comparision evaluator as it uses GPT-4 which is biased towards preferring long answers more.https://www.anyscale.com/blog/a-comprehensive-guide-for-building-rag-based-llm-applications-part-1So in the case of 'yes\_no' answers it can favour Query Engine answers more than reference answers.Also in the case of extracted spans it can favour reference answers more than Query engine generated answers."""eval\_doc\_qa\_answer\_list = []# Utility function to extract answers from the datasetdef get\_answers(sample: dict) -> List[str]: """ :param dict sample: the row sample from the train split of QASPER """    final\_answers\_list = []    answers = sample["qas"]["answers"]    for answer in answers:        local\_answer = ""        types\_of\_answers = answer["answer"][0]        if types\_of\_answers["unanswerable"] == False:            if types\_of\_answers["free\_form\_answer"] != "":                local\_answer = types\_of\_answers["free\_form\_answer"]            else:                local\_answer = "Unacceptable"        else:            local\_answer = "Unacceptable"        final\_answers\_list.append(local\_answer)    return final\_answers\_listfor test\_sample in test\_samples:    full\_text = get\_full\_text(test\_sample)    questions\_list = get\_questions(test\_sample)    answers\_list = get\_answers(test\_sample)    local\_dict = {        "paper": full\_text,        "questions": questions\_list,        "answers": answers\_list,    }    eval\_doc\_qa\_answer\_list.append(local\_dict)
```

```
len(eval\_doc\_qa\_answer\_list)
```

```
80
```

```
# Save eval data as a csvimport pandas as pddf\_test = pd.DataFrame(eval\_doc\_qa\_answer\_list)df\_test.to\_csv("test.csv")# The Rag Eval test data can be found at the below dropbox link# https://www.dropbox.com/scl/fi/3lmzn6714oy358mq0vawm/test.csv?rlkey=yz16080te4van7fvnksi9kaed&dl=0
```
### Generate Finetuning Dataset[](#generate-finetuning-dataset "Permalink to this heading")


```
# Download the latest version of llama-index!pip install llama-index --quiet
```

```
# Generate the respective training dataset from the intial train data collected from QASPER in the format required byimport osfrom llama\_index import SimpleDirectoryReaderimport openaifrom llama\_index.finetuning.cross\_encoders.dataset\_gen import (    generate\_ce\_fine\_tuning\_dataset,    generate\_synthetic\_queries\_over\_documents,)from llama\_index.finetuning.cross\_encoders.cross\_encoder import (    CrossEncoderFinetuneEngine,)os.environ["OPENAI\_API\_KEY"] = "sk-"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import Documentfinal\_finetuning\_data\_list = []for paper in doc\_qa\_dict\_list:    questions\_list = paper["questions"]    documents = [Document(text=paper["paper"])]    local\_finetuning\_dataset = generate\_ce\_fine\_tuning\_dataset(        documents=documents,        questions\_list=questions\_list,        max\_chunk\_length=256,        top\_k=5,    )    final\_finetuning\_data\_list.extend(local\_finetuning\_dataset)
```

```
# Total samples in the final fine-tuning datasetlen(final\_finetuning\_data\_list)
```

```
11674
```

```
# Save final fine-tuning datasetimport pandas as pddf\_finetuning\_dataset = pd.DataFrame(final\_finetuning\_data\_list)df\_finetuning\_dataset.to\_csv("fine\_tuning.csv")# The finetuning dataset can be found at the below dropbox link:-# https://www.dropbox.com/scl/fi/zu6vtisp1j3wg2hbje5xv/fine\_tuning.csv?rlkey=0jr6fud8sqk342agfjbzvwr9x&dl=0
```

```
# Load fine-tuning datasetfinetuning\_dataset = final\_finetuning\_data\_list
```

```
finetuning\_dataset[0]
```

```
CrossEncoderFinetuningDatasetSample(query='Do they repot results only on English data?', context='addition to precision, recall, and F1 scores for both tasks, we show the average of the F1 scores across both tasks. On the ADE dataset, we achieve SOTA results for both the NER and RE tasks. On the CoNLL04 dataset, we achieve SOTA results on the NER task, while our performance on the RE task is competitive with other recent models. On both datasets, we achieve SOTA results when considering the average F1 score across both tasks. The largest gain relative to the previous SOTA performance is on the RE task of the ADE dataset, where we see an absolute improvement of 4.5 on the macro-average F1 score.While the model of Eberts and Ulges eberts2019span outperforms our proposed architecture on the CoNLL04 RE task, their results come at the cost of greater model complexity. As mentioned above, Eberts and Ulges fine-tune the BERTBASE model, which has 110 million trainable parameters. In contrast, given the hyperparameters used for final training on the CoNLL04 dataset, our proposed architecture has approximately 6 million trainable parameters.The fact that the optimal number of task-specific layers differed between the two datasets demonstrates the', score=0)
```
### Generate Reranking Eval test data[](#generate-reranking-eval-test-data "Permalink to this heading")


```
# Download RAG Eval test data!wget -O test.csv https://www.dropbox.com/scl/fi/3lmzn6714oy358mq0vawm/test.csv?rlkey=yz16080te4van7fvnksi9kaed&dl=0
```

```
# Generate Reranking Eval Dataset from the Eval dataimport pandas as pdimport ast  # Used to safely evaluate the string as a list# Load Eval Datadf\_test = pd.read\_csv("/content/test.csv", index\_col=0)df\_test["questions"] = df\_test["questions"].apply(ast.literal\_eval)df\_test["answers"] = df\_test["answers"].apply(ast.literal\_eval)print(f"Number of papers in the test sample:- {len(df\_test)}")
```

```
Number of papers in the test sample:- 80
```

```
from llama\_index import Documentfinal\_eval\_data\_list = []for index, row in df\_test.iterrows():    documents = [Document(text=row["paper"])]    query\_list = row["questions"]    local\_eval\_dataset = generate\_ce\_fine\_tuning\_dataset(        documents=documents,        questions\_list=query\_list,        max\_chunk\_length=256,        top\_k=5,    )    relevant\_query\_list = []    relevant\_context\_list = []    for item in local\_eval\_dataset:        if item.score == 1:            relevant\_query\_list.append(item.query)            relevant\_context\_list.append(item.context)    if len(relevant\_query\_list) > 0:        final\_eval\_data\_list.append(            {                "paper": row["paper"],                "questions": relevant\_query\_list,                "context": relevant\_context\_list,            }        )
```

```
# Length of Reranking Eval Datasetlen(final\_eval\_data\_list)
```

```
38
```

```
# Save Reranking eval datasetimport pandas as pddf\_finetuning\_dataset = pd.DataFrame(final\_eval\_data\_list)df\_finetuning\_dataset.to\_csv("reranking\_test.csv")# The reranking dataset can be found at the below dropbox link# https://www.dropbox.com/scl/fi/mruo5rm46k1acm1xnecev/reranking\_test.csv?rlkey=hkniwowq0xrc3m0ywjhb2gf26&dl=0
```
Finetune Cross-Encoder[](#finetune-cross-encoder "Permalink to this heading")
------------------------------------------------------------------------------


```
!pip install huggingface_hub --quiet
```

```
from huggingface\_hub import notebook\_loginnotebook\_login()
```

```
from sentence\_transformers import SentenceTransformer# Initialise the cross-encoder fine-tuning enginefinetuning\_engine = CrossEncoderFinetuneEngine(    dataset=finetuning\_dataset, epochs=2, batch\_size=8)# Finetune the cross-encoder modelfinetuning\_engine.finetune()
```

```
# Push model to HuggingFace Hubfinetuning\_engine.push\_to\_hub(    repo\_id="bpHigh/Cross-Encoder-LLamaIndex-Demo-v2")
```
Reranking Evaluation[](#reranking-evaluation "Permalink to this heading")
--------------------------------------------------------------------------


```
!pip install nest-asyncio --quiet
```

```
# attach to the same event-loopimport nest\_asyncionest\_asyncio.apply()
```

```
# Download Reranking test data!wget -O reranking_test.csv https://www.dropbox.com/scl/fi/mruo5rm46k1acm1xnecev/reranking_test.csv?rlkey=hkniwowq0xrc3m0ywjhb2gf26&dl=0
```

```
--2023-10-12 04:47:18--  https://www.dropbox.com/scl/fi/mruo5rm46k1acm1xnecev/reranking_test.csv?rlkey=hkniwowq0xrc3m0ywjhb2gf26Resolving www.dropbox.com (www.dropbox.com)... 162.125.85.18, 2620:100:6035:18::a27d:5512Connecting to www.dropbox.com (www.dropbox.com)|162.125.85.18|:443... connected.HTTP request sent, awaiting response... 302 FoundLocation: https://uc414efe80c7598407c86166866d.dl.dropboxusercontent.com/cd/0/inline/CFcxAwrNZkpcZLmEipK-DxnJF6BKMu8rKmoRp-FUoqRF83K1t0kG0OzBliY-8E7EmbRqkkRZENO4ayEUPgul8lzY7iyARc7kauQ4iHdGps9_Y4jHyuLstzxbVT1TDQyhotVUYWZ9uHNmDHI9UFWAKBVm/file# [following]--2023-10-12 04:47:18--  https://uc414efe80c7598407c86166866d.dl.dropboxusercontent.com/cd/0/inline/CFcxAwrNZkpcZLmEipK-DxnJF6BKMu8rKmoRp-FUoqRF83K1t0kG0OzBliY-8E7EmbRqkkRZENO4ayEUPgul8lzY7iyARc7kauQ4iHdGps9_Y4jHyuLstzxbVT1TDQyhotVUYWZ9uHNmDHI9UFWAKBVm/fileResolving uc414efe80c7598407c86166866d.dl.dropboxusercontent.com (uc414efe80c7598407c86166866d.dl.dropboxusercontent.com)... 162.125.80.15, 2620:100:6035:15::a27d:550fConnecting to uc414efe80c7598407c86166866d.dl.dropboxusercontent.com (uc414efe80c7598407c86166866d.dl.dropboxusercontent.com)|162.125.80.15|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 967072 (944K) [text/plain]Saving to: ‘reranking_test.csv’reranking_test.csv  100%[===================>] 944.41K  3.55MB/s    in 0.3s    2023-10-12 04:47:19 (3.55 MB/s) - ‘reranking_test.csv’ saved [967072/967072]
```

```
# Load Reranking Datasetimport pandas as pdimport astdf\_reranking = pd.read\_csv("/content/reranking\_test.csv", index\_col=0)df\_reranking["questions"] = df\_reranking["questions"].apply(ast.literal\_eval)df\_reranking["context"] = df\_reranking["context"].apply(ast.literal\_eval)print(f"Number of papers in the reranking eval dataset:- {len(df\_reranking)}")
```

```
Number of papers in the reranking eval dataset:- 38
```

```
df\_reranking.head(1)
```


|  | paper | questions | context |
| --- | --- | --- | --- |
| 0 | Identifying Condition-Action Statements in Med... | [What supervised machine learning models do th... | [Identifying Condition-Action Statements in Me... |


```
# We evaluate by calculating hits for each (question, context) pair,# we retrieve top-k documents with the question, and# it’s a hit if the results contain the contextfrom llama\_index.indices.postprocessor import SentenceTransformerRerankfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.llms import OpenAIfrom llama\_index import Documentimport osimport openaiimport pandas as pdos.environ["OPENAI\_API\_KEY"] = "sk-"openai.api\_key = os.environ["OPENAI\_API\_KEY"]service\_context\_reranker\_eval = ServiceContext.from\_defaults(chunk\_size=256)rerank\_base = SentenceTransformerRerank(    model="cross-encoder/ms-marco-MiniLM-L-12-v2", top\_n=3)rerank\_finetuned = SentenceTransformerRerank(    model="bpHigh/Cross-Encoder-LLamaIndex-Demo-v2", top\_n=3)
```

```
without\_reranker\_hits = 0base\_reranker\_hits = 0finetuned\_reranker\_hits = 0total\_number\_of\_context = 0for index, row in df\_reranking.iterrows():    documents = [Document(text=row["paper"])]    query\_list = row["questions"]    context\_list = row["context"]    assert len(query\_list) == len(context\_list)    vector\_index = VectorStoreIndex.from\_documents(        documents, service\_context=service\_context\_reranker\_eval    )    retriever\_without\_reranker = vector\_index.as\_query\_engine(        similarity\_top\_k=3, response\_mode="no\_text"    )    retriever\_with\_base\_reranker = vector\_index.as\_query\_engine(        similarity\_top\_k=8,        response\_mode="no\_text",        node\_postprocessors=[rerank\_base],    )    retriever\_with\_finetuned\_reranker = vector\_index.as\_query\_engine(        similarity\_top\_k=8,        response\_mode="no\_text",        node\_postprocessors=[rerank\_finetuned],    )    for index in range(0, len(query\_list)):        query = query\_list[index]        context = context\_list[index]        total\_number\_of\_context += 1        response\_without\_reranker = retriever\_without\_reranker.query(query)        without\_reranker\_nodes = response\_without\_reranker.source\_nodes        for node in without\_reranker\_nodes:            if context in node.node.text or node.node.text in context:                without\_reranker\_hits += 1        response\_with\_base\_reranker = retriever\_with\_base\_reranker.query(query)        with\_base\_reranker\_nodes = response\_with\_base\_reranker.source\_nodes        for node in with\_base\_reranker\_nodes:            if context in node.node.text or node.node.text in context:                base\_reranker\_hits += 1        response\_with\_finetuned\_reranker = (            retriever\_with\_finetuned\_reranker.query(query)        )        with\_finetuned\_reranker\_nodes = (            response\_with\_finetuned\_reranker.source\_nodes        )        for node in with\_finetuned\_reranker\_nodes:            if context in node.node.text or node.node.text in context:                finetuned\_reranker\_hits += 1        assert (            len(with\_finetuned\_reranker\_nodes)            == len(with\_base\_reranker\_nodes)            == len(without\_reranker\_nodes)            == 3        )
```
### Results[](#results "Permalink to this heading")

As we can see below we get more hits with finetuned\_cross\_encoder compared to other options.


```
without\_reranker\_scores = [without\_reranker\_hits]base\_reranker\_scores = [base\_reranker\_hits]finetuned\_reranker\_scores = [finetuned\_reranker\_hits]reranker\_eval\_dict = {    "Metric": "Hits",    "OpenAI\_Embeddings": without\_reranker\_scores,    "Base\_cross\_encoder": base\_reranker\_scores,    "Finetuned\_cross\_encoder": finetuned\_reranker\_hits,    "Total Relevant Context": total\_number\_of\_context,}df\_reranker\_eval\_results = pd.DataFrame(reranker\_eval\_dict)display(df\_reranker\_eval\_results)
```


|  | Metric | OpenAI\_Embeddings | Base\_cross\_encoder | Finetuned\_cross\_encoder | Total Relevant Context |
| --- | --- | --- | --- | --- | --- |
| 0 | Hits | 30 | 34 | 37 | 85 |

RAG Evaluation[](#rag-evaluation "Permalink to this heading")
--------------------------------------------------------------


```
# Download RAG Eval test data!wget -O test.csv https://www.dropbox.com/scl/fi/3lmzn6714oy358mq0vawm/test.csv?rlkey=yz16080te4van7fvnksi9kaed&dl=0
```

```
--2023-10-12 04:47:36--  https://www.dropbox.com/scl/fi/3lmzn6714oy358mq0vawm/test.csv?rlkey=yz16080te4van7fvnksi9kaedResolving www.dropbox.com (www.dropbox.com)... 162.125.85.18, 2620:100:6035:18::a27d:5512Connecting to www.dropbox.com (www.dropbox.com)|162.125.85.18|:443... connected.HTTP request sent, awaiting response... 302 FoundLocation: https://ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com/cd/0/inline/CFfI9UezsVwFpN4CHgYrSFveuNE01DfczDaeFGZO-Ud5VdDRff1LNG7hEhkBZwVljuRde-EZU336ASpnZs32qVePvpQEFnKB2SeplFpMt50G0m5IZepyV6pYPbNAhm0muYE_rjhlolHxRUQP_iaJBX9z/file# [following]--2023-10-12 04:47:38--  https://ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com/cd/0/inline/CFfI9UezsVwFpN4CHgYrSFveuNE01DfczDaeFGZO-Ud5VdDRff1LNG7hEhkBZwVljuRde-EZU336ASpnZs32qVePvpQEFnKB2SeplFpMt50G0m5IZepyV6pYPbNAhm0muYE_rjhlolHxRUQP_iaJBX9z/fileResolving ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com (ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com)... 162.125.80.15, 2620:100:6035:15::a27d:550fConnecting to ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com (ucb6087b1b853dad24e8201987fc.dl.dropboxusercontent.com)|162.125.80.15|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 1821706 (1.7M) [text/plain]Saving to: ‘test.csv’test.csv            100%[===================>]   1.74M  6.37MB/s    in 0.3s    2023-10-12 04:47:38 (6.37 MB/s) - ‘test.csv’ saved [1821706/1821706]
```

```
import pandas as pdimport ast  # Used to safely evaluate the string as a list# Load Eval Datadf\_test = pd.read\_csv("/content/test.csv", index\_col=0)df\_test["questions"] = df\_test["questions"].apply(ast.literal\_eval)df\_test["answers"] = df\_test["answers"].apply(ast.literal\_eval)print(f"Number of papers in the test sample:- {len(df\_test)}")
```

```
Number of papers in the test sample:- 80
```

```
# Look at one sample of eval data which has a research paper questions on it and the respective reference answersdf\_test.head(1)
```


|  | paper | questions | answers |
| --- | --- | --- | --- |
| 0 | Identifying Condition-Action Statements in Med... | [What supervised machine learning models do th... | [Unacceptable, Unacceptable, 1470 sentences, U... |

### Baseline Evaluation[](#baseline-evaluation "Permalink to this heading")

Just using OpenAI Embeddings for retrieval without any re-ranker

#### Eval Method:-[](#eval-method "Permalink to this heading")

1. Iterate over each row of the test dataset:-


	1. For the current row being iterated, create a vector index using the paper document provided in the paper column of the dataset
	2. Query the vector index with a top\_k value of top 3 nodes without any reranker
	3. Compare the generated answers with the reference answers of the respective sample using Pairwise Comparison Evaluator and add the scores to a list
2. Repeat 1 untill all the rows have been iterated
3. Calculate avg scores over all samples/ rows


```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index import Documentfrom llama\_index.evaluation import PairwiseComparisonEvaluatorfrom llama\_index.evaluation.eval\_utils import get\_responses, get\_results\_dfimport osimport openaiimport pandas as pdos.environ["OPENAI\_API\_KEY"] = "sk-"openai.api\_key = os.environ["OPENAI\_API\_KEY"]gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4\_pairwise = PairwiseComparisonEvaluator(    service\_context=service\_context\_gpt4)
```

```
pairwise\_scores\_list = []no\_reranker\_dict\_list = []# Iterate over the rows of the datasetfor index, row in df\_test.iterrows():    documents = [Document(text=row["paper"])]    query\_list = row["questions"]    reference\_answers\_list = row["answers"]    number\_of\_accepted\_queries = 0    # Create vector index for the current row being iterated    vector\_index = VectorStoreIndex.from\_documents(documents)    # Query the vector index with a top\_k value of top 3 documents without any reranker    query\_engine = vector\_index.as\_query\_engine(similarity\_top\_k=3)    assert len(query\_list) == len(reference\_answers\_list)    pairwise\_local\_score = 0    for index in range(0, len(query\_list)):        query = query\_list[index]        reference = reference\_answers\_list[index]        if reference != "Unacceptable":            number\_of\_accepted\_queries += 1            response = str(query\_engine.query(query))            no\_reranker\_dict = {                "query": query,                "response": response,                "reference": reference,            }            no\_reranker\_dict\_list.append(no\_reranker\_dict)            # Compare the generated answers with the reference answers of the respective sample using            # Pairwise Comparison Evaluator and add the scores to a list            pairwise\_eval\_result = await evaluator\_gpt4\_pairwise.aevaluate(                query, response=response, reference=reference            )            pairwise\_score = pairwise\_eval\_result.score            pairwise\_local\_score += pairwise\_score        else:            pass    if number\_of\_accepted\_queries > 0:        avg\_pairwise\_local\_score = (            pairwise\_local\_score / number\_of\_accepted\_queries        )        pairwise\_scores\_list.append(avg\_pairwise\_local\_score)overal\_pairwise\_average\_score = sum(pairwise\_scores\_list) / len(    pairwise\_scores\_list)df\_responses = pd.DataFrame(no\_reranker\_dict\_list)df\_responses.to\_csv("No\_Reranker\_Responses.csv")
```

```
results\_dict = {    "name": ["Without Reranker"],    "pairwise score": [overal\_pairwise\_average\_score],}results\_df = pd.DataFrame(results\_dict)display(results\_df)
```


|  | name | pairwise score |
| --- | --- | --- |
| 0 | Without Reranker | 0.553788 |

### Evaluate with base reranker[](#evaluate-with-base-reranker "Permalink to this heading")

OpenAI Embeddings + `cross-encoder/ms-marco-MiniLM-L-12-v2` as reranker

#### Eval Method:-[](#id1 "Permalink to this heading")

1. Iterate over each row of the test dataset:-


	1. For the current row being iterated, create a vector index using the paper document provided in the paper column of the dataset
	2. Query the vector index with a top\_k value of top 5 nodes.
	3. Use cross-encoder/ms-marco-MiniLM-L-12-v2 as a reranker as a NodePostprocessor to get top\_k value of top 3 nodes out of the 8 nodes
	4. Compare the generated answers with the reference answers of the respective sample using Pairwise Comparison Evaluator and add the scores to a list
2. Repeat 1 untill all the rows have been iterated
3. Calculate avg scores over all samples/ rows


```
from llama\_index.indices.postprocessor import SentenceTransformerRerankfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index import Documentfrom llama\_index.evaluation import PairwiseComparisonEvaluatorimport osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-"openai.api\_key = os.environ["OPENAI\_API\_KEY"]rerank = SentenceTransformerRerank(    model="cross-encoder/ms-marco-MiniLM-L-12-v2", top\_n=3)gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4\_pairwise = PairwiseComparisonEvaluator(    service\_context=service\_context\_gpt4)
```

```
pairwise\_scores\_list = []base\_reranker\_dict\_list = []# Iterate over the rows of the datasetfor index, row in df\_test.iterrows():    documents = [Document(text=row["paper"])]    query\_list = row["questions"]    reference\_answers\_list = row["answers"]    number\_of\_accepted\_queries = 0    # Create vector index for the current row being iterated    vector\_index = VectorStoreIndex.from\_documents(documents)    # Query the vector index with a top\_k value of top 8 nodes with reranker    # as cross-encoder/ms-marco-MiniLM-L-12-v2    query\_engine = vector\_index.as\_query\_engine(        similarity\_top\_k=8, node\_postprocessors=[rerank]    )    assert len(query\_list) == len(reference\_answers\_list)    pairwise\_local\_score = 0    for index in range(0, len(query\_list)):        query = query\_list[index]        reference = reference\_answers\_list[index]        if reference != "Unacceptable":            number\_of\_accepted\_queries += 1            response = str(query\_engine.query(query))            base\_reranker\_dict = {                "query": query,                "response": response,                "reference": reference,            }            base\_reranker\_dict\_list.append(base\_reranker\_dict)            # Compare the generated answers with the reference answers of the respective sample using            # Pairwise Comparison Evaluator and add the scores to a list            pairwise\_eval\_result = await evaluator\_gpt4\_pairwise.aevaluate(                query=query, response=response, reference=reference            )            pairwise\_score = pairwise\_eval\_result.score            pairwise\_local\_score += pairwise\_score        else:            pass    if number\_of\_accepted\_queries > 0:        avg\_pairwise\_local\_score = (            pairwise\_local\_score / number\_of\_accepted\_queries        )        pairwise\_scores\_list.append(avg\_pairwise\_local\_score)overal\_pairwise\_average\_score = sum(pairwise\_scores\_list) / len(    pairwise\_scores\_list)df\_responses = pd.DataFrame(base\_reranker\_dict\_list)df\_responses.to\_csv("Base\_Reranker\_Responses.csv")
```

```
results\_dict = {    "name": ["With base cross-encoder/ms-marco-MiniLM-L-12-v2 as Reranker"],    "pairwise score": [overal\_pairwise\_average\_score],}results\_df = pd.DataFrame(results\_dict)display(results\_df)
```


|  | name | pairwise score |
| --- | --- | --- |
| 0 | With base cross-encoder/ms-marco-MiniLM-L-12-v... | 0.556818 |

### Evaluate with Fine-Tuned re-ranker[](#evaluate-with-fine-tuned-re-ranker "Permalink to this heading")

OpenAI Embeddings + `bpHigh/Cross-Encoder-LLamaIndex-Demo-v2` as reranker

#### Eval Method:-[](#id2 "Permalink to this heading")

1. Iterate over each row of the test dataset:-


	1. For the current row being iterated, create a vector index using the paper document provided in the paper column of the dataset
	2. Query the vector index with a top\_k value of top 5 nodes.
	3. Use finetuned version of cross-encoder/ms-marco-MiniLM-L-12-v2 saved as bpHigh/Cross-Encoder-LLamaIndex-Demo as a reranker as a NodePostprocessor to get top\_k value of top 3 nodes out of the 8 nodes
	4. Compare the generated answers with the reference answers of the respective sample using Pairwise Comparison Evaluator and add the scores to a list
2. Repeat 1 untill all the rows have been iterated
3. Calculate avg scores over all samples/ rows


```
from llama\_index.indices.postprocessor import SentenceTransformerRerankfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index import Documentfrom llama\_index.evaluation import PairwiseComparisonEvaluatorimport osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-"openai.api\_key = os.environ["OPENAI\_API\_KEY"]rerank = SentenceTransformerRerank(    model="bpHigh/Cross-Encoder-LLamaIndex-Demo-v2", top\_n=3)gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4\_pairwise = PairwiseComparisonEvaluator(    service\_context=service\_context\_gpt4)
```

```
pairwise\_scores\_list = []finetuned\_reranker\_dict\_list = []# Iterate over the rows of the datasetfor index, row in df\_test.iterrows():    documents = [Document(text=row["paper"])]    query\_list = row["questions"]    reference\_answers\_list = row["answers"]    number\_of\_accepted\_queries = 0    # Create vector index for the current row being iterated    vector\_index = VectorStoreIndex.from\_documents(documents)    # Query the vector index with a top\_k value of top 8 nodes with reranker    # as cross-encoder/ms-marco-MiniLM-L-12-v2    query\_engine = vector\_index.as\_query\_engine(        similarity\_top\_k=8, node\_postprocessors=[rerank]    )    assert len(query\_list) == len(reference\_answers\_list)    pairwise\_local\_score = 0    for index in range(0, len(query\_list)):        query = query\_list[index]        reference = reference\_answers\_list[index]        if reference != "Unacceptable":            number\_of\_accepted\_queries += 1            response = str(query\_engine.query(query))            finetuned\_reranker\_dict = {                "query": query,                "response": response,                "reference": reference,            }            finetuned\_reranker\_dict\_list.append(finetuned\_reranker\_dict)            # Compare the generated answers with the reference answers of the respective sample using            # Pairwise Comparison Evaluator and add the scores to a list            pairwise\_eval\_result = await evaluator\_gpt4\_pairwise.aevaluate(                query, response=response, reference=reference            )            pairwise\_score = pairwise\_eval\_result.score            pairwise\_local\_score += pairwise\_score        else:            pass    if number\_of\_accepted\_queries > 0:        avg\_pairwise\_local\_score = (            pairwise\_local\_score / number\_of\_accepted\_queries        )        pairwise\_scores\_list.append(avg\_pairwise\_local\_score)overal\_pairwise\_average\_score = sum(pairwise\_scores\_list) / len(    pairwise\_scores\_list)df\_responses = pd.DataFrame(finetuned\_reranker\_dict\_list)df\_responses.to\_csv("Finetuned\_Reranker\_Responses.csv")
```

```
results\_dict = {    "name": ["With fine-tuned cross-encoder/ms-marco-MiniLM-L-12-v2"],    "pairwise score": [overal\_pairwise\_average\_score],}results\_df = pd.DataFrame(results\_dict)display(results\_df)
```


|  | name | pairwise score |
| --- | --- | --- |
| 0 | With fine-tuned cross-encoder/ms-marco-MiniLM-... | 0.6 |

### Results[](#id3 "Permalink to this heading")

As we can see we get the highest pairwise score with finetuned cross-encoder.

Although I would like to point that the reranking eval based on hits is a more robust metric compared to pairwise comparision evaluator as I have seen inconsistencies with the scores and there are also many inherent biases present when evaluating using GPT-4

