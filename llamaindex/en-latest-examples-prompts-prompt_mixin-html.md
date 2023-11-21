[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/prompts/prompt_mixin.ipynb)

Accessing/Customizing Prompts within Higher-Level Modules[](#accessing-customizing-prompts-within-higher-level-modules "Permalink to this heading")
====================================================================================================================================================

LlamaIndex contains a variety of higher-level modules (query engines, response synthesizers, retrievers, etc.), many of which make LLM calls + use prompt templates.

This guide shows how you can 1) access the set of prompts for any module (including nested) with `get\_prompts`, and 2) update these prompts easily with `update\_prompts`.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    load\_index\_from\_storage,    StorageContext,)from IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Setup: Load Data, Build Index, and Get Query Engine[](#setup-load-data-build-index-and-get-query-engine "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------

Here we build a vector index over a toy dataset (PG’s essay), and access the query engine.

The query engine is a simple RAG pipeline consisting of top-k retrieval + LLM synthesis.

Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(response\_mode="tree\_summarize")
```

```
# define prompt viewing functiondef display\_prompt\_dict(prompts\_dict):    for k, p in prompts\_dict.items():        text\_md = f"\*\*Prompt Key\*\*: {k}<br>" f"\*\*Text:\*\* <br>"        display(Markdown(text\_md))        print(p.get\_template())        display(Markdown("<br><br>"))
```
Accessing Prompts[](#accessing-prompts "Permalink to this heading")
--------------------------------------------------------------------

Here we get the prompts from the query engine. Note that *all* prompts are returned, including ones used in sub-modules in the query engine. This allows you to centralize a view of these prompts!


```
prompts\_dict = query\_engine.get\_prompts()
```

```
display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: response\_synthesizer:summary\_template  
**Text:**   



```
Context information from multiple sources is below.---------------------{context_str}---------------------Given the information from multiple sources and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


### Checking `get\_prompts` on Response Synthesizer[](#checking-get-prompts-on-response-synthesizer "Permalink to this heading")

You can also call `get\_prompts` on the underlying response synthesizer, where you’ll see the same list.


```
prompts\_dict = query\_engine.response\_synthesizer.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: summary\_template  
**Text:**   



```
Context information from multiple sources is below.---------------------{context_str}---------------------Given the information from multiple sources and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


### Checking `get\_prompts` with a different response synthesis strategy[](#checking-get-prompts-with-a-different-response-synthesis-strategy "Permalink to this heading")

Here we try the default `compact` method.

We’ll see that the set of templates used are different; a QA template and a refine template.


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(response\_mode="compact")
```

```
prompts\_dict = query\_engine.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: response\_synthesizer:text\_qa\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


**Prompt Key**: response\_synthesizer:refine\_template  
**Text:**   



```
The original query is as follows: {query_str}We have provided an existing answer: {existing_answer}We have the opportunity to refine the existing answer (only if needed) with some more context below.------------{context_msg}------------Given the new context, refine the original answer to better answer the query. If the context isn't useful, return the original answer.Refined Answer: 
```
  
  


### Put into query engine, get response[](#put-into-query-engine-get-response "Permalink to this heading")


```
response = query\_engine.query("What did the author do growing up?")print(str(response))
```

```
The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer and started programming on it, writing simple games and a word processor. They also mentioned their interest in philosophy and AI.
```
Customize the prompt[](#customize-the-prompt "Permalink to this heading")
--------------------------------------------------------------------------

You can also update/customize the prompts with the `update\_prompts` function. Pass in arg values with the keys equal to the keys you see in the prompt dictionary.

Here we’ll change the summary prompt to use Shakespeare.


```
from llama\_index.prompts import PromptTemplate# resetquery\_engine = index.as\_query\_engine(response\_mode="tree\_summarize")# shakespeare!new\_summary\_tmpl\_str = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query in the style of a Shakespeare play.\n"    "Query: {query\_str}\n"    "Answer: ")new\_summary\_tmpl = PromptTemplate(new\_summary\_tmpl\_str)
```

```
query\_engine.update\_prompts(    {"response\_synthesizer:summary\_template": new\_summary\_tmpl})
```

```
prompts\_dict = query\_engine.get\_prompts()
```

```
display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: response\_synthesizer:summary\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query in the style of a Shakespeare play.Query: {query_str}Answer: 
```
  
  



```
response = query\_engine.query("What did the author do growing up?")print(str(response))
```
Accessing Prompts from Other Modules[](#accessing-prompts-from-other-modules "Permalink to this heading")
----------------------------------------------------------------------------------------------------------

Here we take a look at some other modules: query engines, routers/selectors, evaluators, and others.


```
from llama\_index.query\_engine import (    RouterQueryEngine,    FLAREInstructQueryEngine,)from llama\_index.selectors import LLMMultiSelectorfrom llama\_index.evaluation import FaithfulnessEvaluator, DatasetGeneratorfrom llama\_index.indices.postprocessor import LLMRerank
```
### Analyze Prompts: Router Query Engine[](#analyze-prompts-router-query-engine "Permalink to this heading")


```
# setup sample router query enginefrom llama\_index.tools.query\_engine import QueryEngineToolquery\_tool = QueryEngineTool.from\_defaults(    query\_engine=query\_engine, description="test description")router\_query\_engine = RouterQueryEngine.from\_defaults([query\_tool])
```

```
prompts\_dict = router\_query\_engine.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: summarizer:summary\_template  
**Text:**   



```
Context information from multiple sources is below.---------------------{context_str}---------------------Given the information from multiple sources and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


### Analyze Prompts: FLARE Query Engine[](#analyze-prompts-flare-query-engine "Permalink to this heading")


```
flare\_query\_engine = FLAREInstructQueryEngine(query\_engine)
```

```
prompts\_dict = flare\_query\_engine.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: instruct\_prompt  
**Text:**   



```
Skill 1. Use the Search API to look up relevant information by writing     "[Search(query)]" where "query" is the search query you want to look up.     For example:Query: But what are the risks during production of nanomaterials?Answer: [Search(What are some nanomaterial production risks?)]Query: The colors on the flag of Ghana have the following meanings.Answer: Red is for [Search(What is the meaning of Ghana's flag being red?)],     green for forests, and gold for mineral wealth.Query: What did the author do during his time in college?Answer: The author took classes in [Search(What classes did the author take in     college?)].Skill 2. Solve more complex generation tasks by thinking step by step. For example:Query: Give a summary of the author's life and career.Answer: The author was born in 1990. Growing up, he [Search(What did the     author do during his childhood?)].Query: Can you write a summary of the Great Gatsby.Answer: The Great Gatsby is a novel written by F. Scott Fitzgerald. It is about     [Search(What is the Great Gatsby about?)].Now given the following task, and the stub of an existing answer, generate the next portion of the answer. You may use the Search API "[Search(query)]" whenever possible.If the answer is complete and no longer contains any "[Search(query)]" tags, write     "done" to finish the task.Do not write "done" if the answer still contains "[Search(query)]" tags.Do not make up answers. It is better to generate one "[Search(query)]" tag and stop generationthan to fill in the answer with made up information with no "[Search(query)]" tagsor multiple "[Search(query)]" tags that assume a structure in the answer.Try to limit generation to one sentence if possible.Query: {query_str}Existing Answer: {existing_answer}Answer: 
```
  
  


**Prompt Key**: query\_engine:response\_synthesizer:summary\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query in the style of a Shakespeare play.Query: {query_str}Answer: 
```
  
  


**Prompt Key**: lookahead\_answer\_inserter:answer\_insert\_prompt  
**Text:**   



```
An existing 'lookahead response' is given below. The lookahead responsecontains `[Search(query)]` tags. Some queries have been executed and theresponse retrieved. The queries and answers are also given below.Also the previous response (the response before the lookahead response)is given below.Given the lookahead template, previous response, and also queries and answers,please 'fill in' the lookahead template with the appropriate answers.NOTE: Please make sure that the final response grammatically followsthe previous response + lookahead template. For example, if the previousresponse is "New York City has a population of " and the lookaheadtemplate is "[Search(What is the population of New York City?)]", thenthe final response should be "8.4 million".NOTE: the lookahead template may not be a complete sentence and maycontain trailing/leading commas, etc. Please preserve the originalformatting of the lookahead template if possible.NOTE:NOTE: the exception to the above rule is if the answer to a queryis equivalent to "I don't know" or "I don't have an answer". In this case,modify the lookahead template to indicate that the answer is not known.NOTE: the lookahead template may contain multiple `[Search(query)]` tags    and only a subset of these queries have been executed.    Do not replace the `[Search(query)]` tags that have not been executed.Previous Response:Lookahead Template:Red is for [Search(What is the meaning of Ghana's     flag being red?)], green for forests, and gold for mineral wealth.Query-Answer Pairs:Query: What is the meaning of Ghana's flag being red?Answer: The red represents the blood of those who died in the country's struggle     for independenceFilled in Answers:Red is for the blood of those who died in the country's struggle for independence,     green for forests, and gold for mineral wealth.Previous Response:One of the largest cities in the worldLookahead Template:, the city contains a population of [Search(What is the population     of New York City?)]Query-Answer Pairs:Query: What is the population of New York City?Answer: The population of New York City is 8.4 millionSynthesized Response:, the city contains a population of 8.4 millionPrevious Response:the city contains a population ofLookahead Template:[Search(What is the population of New York City?)]Query-Answer Pairs:Query: What is the population of New York City?Answer: The population of New York City is 8.4 millionSynthesized Response:8.4 millionPrevious Response:{prev_response}Lookahead Template:{lookahead_response}Query-Answer Pairs:{query_answer_pairs}Synthesized Response:
```
  
  


### Analyze Prompts: LLMMultiSelector[](#analyze-prompts-llmmultiselector "Permalink to this heading")


```
from llama\_index.selectors.llm\_selectors import LLMSingleSelectorselector = LLMSingleSelector.from\_defaults()
```

```
prompts\_dict = selector.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: prompt  
**Text:**   



```
Some choices are given below. It is provided in a numbered list (1 to {num_choices}), where each item in the list corresponds to a summary.---------------------{context_list}---------------------Using only the choices above and not prior knowledge, return the choice that is most relevant to the question: '{query_str}'
```
  
  


### Analyze Prompts: FaithfulnessEvaluator[](#analyze-prompts-faithfulnessevaluator "Permalink to this heading")


```
evaluator = FaithfulnessEvaluator()
```

```
prompts\_dict = evaluator.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: eval\_template  
**Text:**   



```
Please tell if a given piece of information is supported by the context.You need to answer with either YES or NO.Answer YES if any of the context supports the information, even if most of the context is unrelated. Some examples are provided below. Information: Apple pie is generally double-crusted.Context: An apple pie is a fruit pie in which the principal filling ingredient is apples. Apple pie is often served with whipped cream, ice cream ('apple pie à la mode'), custard or cheddar cheese.It is generally double-crusted, with pastry both above and below the filling; the upper crust may be solid or latticed (woven of crosswise strips).Answer: YESInformation: Apple pies tastes bad.Context: An apple pie is a fruit pie in which the principal filling ingredient is apples. Apple pie is often served with whipped cream, ice cream ('apple pie à la mode'), custard or cheddar cheese.It is generally double-crusted, with pastry both above and below the filling; the upper crust may be solid or latticed (woven of crosswise strips).Answer: NOInformation: {query_str}Context: {context_str}Answer: 
```
  
  


**Prompt Key**: refine\_template  
**Text:**   



```
We want to understand if the following information is present in the context information: {query_str}We have provided an existing YES/NO answer: {existing_answer}We have the opportunity to refine the existing answer (only if needed) with some more context below.------------{context_msg}------------If the existing answer was already YES, still answer YES. If the information is present in the new context, answer YES. Otherwise answer NO.
```
  
  


### Analyze Prompts: DatasetGenerator[](#analyze-prompts-datasetgenerator "Permalink to this heading")


```
dataset\_generator = DatasetGenerator.from\_documents(documents)
```

```
prompts\_dict = dataset\_generator.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: text\_question\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge.generate only questions based on the below query.{query_str}
```
  
  


**Prompt Key**: text\_qa\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


### Analyze Prompts: LLMRerank[](#analyze-prompts-llmrerank "Permalink to this heading")


```
llm\_rerank = LLMRerank()
```

```
prompts\_dict = dataset\_generator.get\_prompts()display\_prompt\_dict(prompts\_dict)
```
**Prompt Key**: text\_question\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge.generate only questions based on the below query.{query_str}
```
  
  


**Prompt Key**: text\_qa\_template  
**Text:**   



```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query_str}Answer: 
```
  
  


