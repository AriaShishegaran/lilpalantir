[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/metadata_extraction/MetadataExtraction_LLMSurvey.ipynb)

Automated Metadata Extraction for Better Retrieval + Synthesis[](#automated-metadata-extraction-for-better-retrieval-synthesis "Permalink to this heading")
============================================================================================================================================================

In this tutorial, we show you how to perform automated metadata extraction for better retrieval results.We use two extractors: a QuestionAnsweredExtractor which generates question/answer pairs from a piece of text, and also a SummaryExtractor which extracts summaries, not only within the current text, but also within adjacent texts.

We show that this allows for “chunk dreaming” - each individual chunk can have more “holistic” details, leading to higher answer quality given retrieved results.

Our data source is taken from Eugene Yan’s popular article on LLM Patterns: https://eugeneyan.com/writing/llm-patterns/

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import nest\_asyncionest\_asyncio.apply()import osimport openai
```

```
# OPTIONAL: setup W&B callback handling for tracingfrom llama\_index import set\_global\_handlerset\_global\_handler("wandb", run\_args={"project": "llamaindex"})
```

```
os.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY\_HERE"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Define Metadata Extractors[](#define-metadata-extractors "Permalink to this heading")
--------------------------------------------------------------------------------------

Here we define metadata extractors. We define two variants:

* metadata\_extractor\_1 only contains the QuestionsAnsweredExtractor
* metadata\_extractor\_2 contains both the QuestionsAnsweredExtractor as well as the SummaryExtractor


```
from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.schema import MetadataMode
```

```
llm = OpenAI(temperature=0.1, model="gpt-3.5-turbo", max\_tokens=512)
```
We also show how to instantiate the `SummaryExtractor` and `QuestionsAnsweredExtractor`.


```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.node\_parser.extractors import (    MetadataExtractor,    SummaryExtractor,    QuestionsAnsweredExtractor,)from llama\_index.text\_splitter import TokenTextSplittertext\_splitter = TokenTextSplitter(    separator=" ", chunk\_size=256, chunk\_overlap=128)metadata\_extractor\_1 = MetadataExtractor(    extractors=[        QuestionsAnsweredExtractor(questions=3, llm=llm),    ],    in\_place=False,)metadata\_extractor = MetadataExtractor(    extractors=[        SummaryExtractor(summaries=["prev", "self", "next"], llm=llm),        QuestionsAnsweredExtractor(questions=3, llm=llm),    ],    in\_place=False,)node\_parser = SimpleNodeParser.from\_defaults(    text\_splitter=text\_splitter,    # metadata\_extractor=metadata\_extractor,)
```
Load in Data, Run Extractors[](#load-in-data-run-extractors "Permalink to this heading")
-----------------------------------------------------------------------------------------

We load in Eugene’s essay (https://eugeneyan.com/writing/llm-patterns/) using our LlamaHub SimpleWebPageReader.

We then run our extractors.


```
from llama\_index import SimpleDirectoryReader
```

```
# load in blogfrom llama\_hub.web.simple\_web.base import SimpleWebPageReaderreader = SimpleWebPageReader(html\_to\_text=True)docs = reader.load\_data(urls=["https://eugeneyan.com/writing/llm-patterns/"])
```

```
print(docs[0].get\_content())
```

```
orig\_nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
# take just the first 8 nodes for testingnodes = orig\_nodes[20:28]
```

```
print(nodes[3].get\_content(metadata\_mode="all"))
```

```
is to measure the distance that words wouldhave to move to convert one sequence to another.However, there are several pitfalls to using these conventional benchmarks andmetrics.First, there’s **poor correlation between these metrics and human judgments.**BLEU, ROUGE, and others have had [negative correlation with how humansevaluate fluency](https://arxiv.org/abs/2008.12009). They also showed moderateto less correlation with human adequacy scores. In particular, BLEU and ROUGEhave [low correlation with tasks that require creativity anddiversity](https://arxiv.org/abs/2303.16634).Second, these metrics often have **poor adaptability to a wider variety oftasks**. Adopting a metric proposed for one task to another is not alwaysprudent. For example, exact match metrics such as BLEU and ROUGE are a poorfit for tasks like abstractive summarization or dialogue. Since they’re basedon n-gram overlap between output and reference, they don’t make sense for adialogue task where a wide variety
```
### Run metadata extractors[](#run-metadata-extractors "Permalink to this heading")


```
# process nodes with metadata extractornodes\_1 = metadata\_extractor\_1.process\_nodes(nodes)
```

```
print(nodes\_1[3].get\_content(metadata\_mode="all"))
```

```
[Excerpt from document]questions_this_excerpt_can_answer: 1. What is the correlation between conventional metrics like BLEU and ROUGE and human judgments of fluency and adequacy in natural language processing tasks?2. How well do metrics like BLEU and ROUGE perform in tasks that require creativity and diversity?3. Why are exact match metrics like BLEU and ROUGE not suitable for tasks like abstractive summarization or dialogue?Excerpt:-----is to measure the distance that words wouldhave to move to convert one sequence to another.However, there are several pitfalls to using these conventional benchmarks andmetrics.First, there’s **poor correlation between these metrics and human judgments.**BLEU, ROUGE, and others have had [negative correlation with how humansevaluate fluency](https://arxiv.org/abs/2008.12009). They also showed moderateto less correlation with human adequacy scores. In particular, BLEU and ROUGEhave [low correlation with tasks that require creativity anddiversity](https://arxiv.org/abs/2303.16634).Second, these metrics often have **poor adaptability to a wider variety oftasks**. Adopting a metric proposed for one task to another is not alwaysprudent. For example, exact match metrics such as BLEU and ROUGE are a poorfit for tasks like abstractive summarization or dialogue. Since they’re basedon n-gram overlap between output and reference, they don’t make sense for adialogue task where a wide variety-----
```

```
# 2nd pass: run summaries, and then metadata extractor# process nodes with metadata extractornodes\_2 = metadata\_extractor.process\_nodes(nodes)
```
### Visualize some sample data[](#visualize-some-sample-data "Permalink to this heading")


```
print(nodes\_2[3].get\_content(metadata\_mode="all"))
```

```
[Excerpt from document]prev_section_summary: The section discusses the comparison between BERTScore and MoverScore, two metrics used to evaluate the quality of text generation models. MoverScore is described as a metric that measures the effort required to transform one text sequence into another by mapping semantically related words. The section also highlights the limitations of conventional benchmarks and metrics, such as poor correlation with human judgments and low correlation with tasks requiring creativity.next_section_summary: The section discusses the limitations of current evaluation metrics in natural language processing tasks. It highlights three main issues: lack of creativity and diversity in metrics, poor adaptability to different tasks, and poor reproducibility. The section mentions specific metrics like BLEU and ROUGE, and also references studies that have reported high variance in metric scores.section_summary: The section discusses the limitations of conventional benchmarks and metrics used to measure the distance between word sequences. It highlights two main issues: poor correlation with human judgments and poor adaptability to different tasks. The metrics like BLEU and ROUGE have been found to have low correlation with human evaluations of fluency and adequacy, as well as tasks requiring creativity and diversity. Additionally, these metrics are not suitable for tasks like abstractive summarization or dialogue due to their reliance on n-gram overlap.questions_this_excerpt_can_answer: 1. What are the limitations of conventional benchmarks and metrics in measuring the distance between word sequences?2. How do metrics like BLEU and ROUGE correlate with human judgments of fluency and adequacy?3. Why are metrics like BLEU and ROUGE not suitable for tasks like abstractive summarization or dialogue?Excerpt:-----is to measure the distance that words wouldhave to move to convert one sequence to another.However, there are several pitfalls to using these conventional benchmarks andmetrics.First, there’s **poor correlation between these metrics and human judgments.**BLEU, ROUGE, and others have had [negative correlation with how humansevaluate fluency](https://arxiv.org/abs/2008.12009). They also showed moderateto less correlation with human adequacy scores. In particular, BLEU and ROUGEhave [low correlation with tasks that require creativity anddiversity](https://arxiv.org/abs/2303.16634).Second, these metrics often have **poor adaptability to a wider variety oftasks**. Adopting a metric proposed for one task to another is not alwaysprudent. For example, exact match metrics such as BLEU and ROUGE are a poorfit for tasks like abstractive summarization or dialogue. Since they’re basedon n-gram overlap between output and reference, they don’t make sense for adialogue task where a wide variety-----
```

```
print(nodes\_2[1].get\_content(metadata\_mode="all"))
```

```
[Excerpt from document]prev_section_summary: The section discusses the F_{BERT} formula used in BERTScore and highlights the advantages of BERTScore over simpler metrics like BLEU and ROUGE. It also introduces MoverScore, another metric that uses contextualized embeddings but allows for many-to-one matching. The key topics are BERTScore, MoverScore, and the differences between them.next_section_summary: The section discusses the comparison between BERTScore and MoverScore, two metrics used to evaluate the quality of text generation models. MoverScore is described as a metric that measures the effort required to transform one text sequence into another by mapping semantically related words. The section also highlights the limitations of conventional benchmarks and metrics, such as poor correlation with human judgments and low correlation with tasks requiring creativity.section_summary: The key topics of this section are BERTScore and MoverScore, which are methods used to compute the similarity between generated output and reference in tasks like image captioning and machine translation. BERTScore uses one-to-one matching of tokens, while MoverScore allows for many-to-one matching. MoverScore solves an optimization problem to measure the distance that words would have to move to convert one sequence to another.questions_this_excerpt_can_answer: 1. What is the main difference between BERTScore and MoverScore?2. How does MoverScore allow for many-to-one matching of tokens?3. What problem does MoverScore solve to measure the distance between two sequences?Excerpt:-----to have better correlation for taskssuch as image captioning and machine translation.**[MoverScore](https://arxiv.org/abs/1909.02622)** also uses contextualizedembeddings to compute the distance between tokens in the generated output andreference. But unlike BERTScore, which is based on one-to-one matching (or“hard alignment”) of tokens, MoverScore allows for many-to-one matching (or“soft alignment”).![BERTScore \(left\) vs. MoverScore \(right\)](/assets/mover-score.jpg)BERTScore (left) vs. MoverScore (right;[source](https://arxiv.org/abs/1909.02622))MoverScore enables the mapping of semantically related words in one sequenceto their counterparts in another sequence. It does this by solving aconstrained optimization problem that finds the minimum effort to transformone text into another. The idea is to measure the distance that words wouldhave to move to convert one sequence to another.However, there-----
```
Setup RAG Query Engines, Compare Results![](#setup-rag-query-engines-compare-results "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

We setup 3 indexes/query engines on top of the three node variants.


```
from llama\_index import VectorStoreIndexfrom llama\_index.response.notebook\_utils import (    display\_source\_node,    display\_response,)
```

```
# try out different query engines# index0 = VectorStoreIndex(orig\_nodes)# index1 = VectorStoreIndex(nodes\_1 + orig\_nodes[8:])# index2 = VectorStoreIndex(nodes\_2 + orig\_nodes[8:])index0 = VectorStoreIndex(orig\_nodes)index1 = VectorStoreIndex(orig\_nodes[:20] + nodes\_1 + orig\_nodes[28:])index2 = VectorStoreIndex(orig\_nodes[:20] + nodes\_2 + orig\_nodes[28:])
```

```
wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.
```

```
query\_engine0 = index0.as\_query\_engine(similarity\_top\_k=1)query\_engine1 = index1.as\_query\_engine(similarity\_top\_k=1)query\_engine2 = index2.as\_query\_engine(similarity\_top\_k=1)
```
### Try out some questions[](#try-out-some-questions "Permalink to this heading")

In this question, we see that the naive response `response0` only mentions BLEU and ROUGE, and lacks context about other metrics.

`response2` on the other hand has all metrics within its context.


```
# query\_str = "In the original RAG paper, can you describe the two main approaches for generation and compare them?"query\_str = (    "Can you describe metrics for evaluating text generation quality, compare"    " them, and tell me about their downsides")response0 = query\_engine0.query(query\_str)response1 = query\_engine1.query(query\_str)response2 = query\_engine2.query(query\_str)
```

```
wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.
```

```
display\_response(    response0, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```

```
print(response0.source\_nodes[0].node.get\_content())
```

```
require creativity anddiversity](https://arxiv.org/abs/2303.16634).Second, these metrics often have **poor adaptability to a wider variety oftasks**. Adopting a metric proposed for one task to another is not alwaysprudent. For example, exact match metrics such as BLEU and ROUGE are a poorfit for tasks like abstractive summarization or dialogue. Since they’re basedon n-gram overlap between output and reference, they don’t make sense for adialogue task where a wide variety of responses are possible. An output canhave zero n-gram overlap with the reference but yet be a good response.Third, these metrics have **poor reproducibility**. Even for the same metric,[high variance is reported across differentstudies](https://arxiv.org/abs/2008.12009), possibly due to variations inhuman judgment collection or metric parameter settings. Another study of[ROUGE scores](https://aclanthology.org/2023.acl-long.107/) across 2,000studies found that scores were hard
```

```
display\_response(    response1, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```

```
display\_response(    response2, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```
In this next question, we ask about BERTScore/MoverScore.

The responses are similar. But `response2` gives slightly more detail than `response0` since it has more information about MoverScore contained in the Metadata.


```
# query\_str = "What are some reproducibility issues with the ROUGE metric? Give some details related to benchmarks and also describe other ROUGE issues. "query\_str = (    "Can you give a high-level overview of BERTScore/MoverScore + formulas if"    " available?")response0 = query\_engine0.query(query\_str)response1 = query\_engine1.query(query\_str)response2 = query\_engine2.query(query\_str)
```

```
wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.wandb: Logged trace tree to W&B.
```

```
display\_response(    response0, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```

```
display\_response(    response1, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```

```
display\_response(    response2, source\_length=1000, show\_source=True, show\_source\_metadata=True)
```

```
response1.source\_nodes[0].node.metadata
```

```
{}
```
