“Optimization by Prompting” for RAG[](#optimization-by-prompting-for-rag "Permalink to this heading")
======================================================================================================

Inspired by the [Optimization by Prompting paper](https://arxiv.org/pdf/2309.03409.pdf) by Yang et al., in this guide we test the ability of a “meta-prompt” to optimize our prompt for better RAG performance. The process is roughly as follows:

1. The prompt to be optimized is our standard QA prompt template for RAG, specifically the instruction prefix.
2. We have a “meta-prompt” that takes in previous prefixes/scores + an example of the task, and spits out another prefix.
3. For every candidate prefix, we compute a “score” through correctness evaluation - comparing a dataset of predicted answers (using the QA prompt) to a candidate dataset. If you don’t have it already, you can generate with GPT-4.


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
from pathlib import Pathfrom llama\_hub.file.pdf.base import PDFReaderfrom llama\_hub.file.unstructured.base import UnstructuredReaderfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PDFReader()docs0 = loader.load\_data(file=Path("./data/llama2.pdf"))
```

```
from llama\_index import Documentdoc\_text = "\n\n".join([d.get\_content() for d in docs0])docs = [Document(text=doc\_text)]
```

```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.schema import IndexNode
```

```
node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024)
```

```
base\_nodes = node\_parser.get\_nodes\_from\_documents(docs)
```
Setup Vector Index over this Data[](#setup-vector-index-over-this-data "Permalink to this heading")
----------------------------------------------------------------------------------------------------

We load this data into an in-memory vector store (embedded with OpenAI embeddings).

We’ll be aggressively optimizing the QA prompt for this RAG pipeline.


```
from llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.llms import OpenAIrag\_service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo"))
```

```
index = VectorStoreIndex(base\_nodes, service\_context=rag\_service\_context)query\_engine = index.as\_query\_engine(similarity\_top\_k=2)
```
Get “Golden” Dataset[](#get-golden-dataset "Permalink to this heading")
------------------------------------------------------------------------

Here we generate a dataset of ground-truth QA pairs (or load it).

This will be used for two purposes:

1. To generate some exemplars that we can put into the meta-prompt to illustrate the task
2. To generate an evaluation dataset to compute our objective score - so that the meta-prompt can try optimizing for this score.


```
from llama\_index.evaluation import DatasetGenerator, QueryResponseDatasetfrom llama\_index.node\_parser import SimpleNodeParser
```

```
eval\_service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))
```

```
dataset\_generator = DatasetGenerator(    base\_nodes[:20],    service\_context=eval\_service\_context,    show\_progress=True,    num\_questions\_per\_chunk=3,)
```

```
eval\_dataset = await dataset\_generator.agenerate\_dataset\_from\_nodes(num=60)
```

```
eval\_dataset.save\_json("data/llama2\_eval\_qr\_dataset.json")
```

```
# optionaleval\_dataset = QueryResponseDataset.from\_json(    "data/llama2\_eval\_qr\_dataset.json")
```
### Get Dataset Samples[](#get-dataset-samples "Permalink to this heading")


```
import randomfull\_qr\_pairs = eval\_dataset.qr\_pairs
```

```
num\_exemplars = 2num\_eval = 40exemplar\_qr\_pairs = random.sample(full\_qr\_pairs, num\_exemplars)eval\_qr\_pairs = random.sample(full\_qr\_pairs, num\_eval)
```

```
len(exemplar\_qr\_pairs)
```

```
2
```
Do Prompt Optimization[](#do-prompt-optimization "Permalink to this heading")
------------------------------------------------------------------------------

We now define the functions needed for prompt optimization. We first define an evaluator, and then we setup the meta-prompt which produces candidate instruction prefixes.

Finally we define and run the prompt optimization loop.

### Get Evaluator[](#get-evaluator "Permalink to this heading")


```
from llama\_index.evaluation.eval\_utils import get\_responses
```

```
eval\_service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo"))
```

```
from llama\_index.evaluation import CorrectnessEvaluator, BatchEvalRunnerevaluator\_c = CorrectnessEvaluator(service\_context=eval\_service\_context)evaluator\_dict = {    "correctness": evaluator\_c,}batch\_runner = BatchEvalRunner(evaluator\_dict, workers=2, show\_progress=True)
```
### Define Correctness Eval Function[](#define-correctness-eval-function "Permalink to this heading")


```
async def get\_correctness(query\_engine, eval\_qa\_pairs, batch\_runner):    # then evaluate    # TODO: evaluate a sample of generated results    eval\_qs = [q for q, \_ in eval\_qa\_pairs]    eval\_answers = [a for \_, a in eval\_qa\_pairs]    pred\_responses = get\_responses(eval\_qs, query\_engine, show\_progress=True)    eval\_results = await batch\_runner.aevaluate\_responses(        eval\_qs, responses=pred\_responses, reference=eval\_answers    )    avg\_correctness = np.array(        [r.score for r in eval\_results["correctness"]]    ).mean()    return avg\_correctness
```
### Initialize base QA Prompt[](#initialize-base-qa-prompt "Permalink to this heading")


```
QA\_PROMPT\_KEY = "response\_synthesizer:text\_qa\_template"
```

```
from llama\_index.llms import OpenAIfrom llama\_index.prompts import PromptTemplatellm = OpenAI(model="gpt-3.5-turbo")
```

```
qa\_tmpl\_str = (    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Query: {query\_str}\n"    "Answer: ")qa\_tmpl = PromptTemplate(qa\_tmpl\_str)
```

```
print(query\_engine.get\_prompts()[QA\_PROMPT\_KEY].get\_template())
```
### Define Meta-Prompt[](#define-meta-prompt "Permalink to this heading")


```
meta\_tmpl\_str = """\Your task is to generate the instruction <INS>. Below are some previous instructions with their scores.The score ranges from 1 to 5.{prev\_instruction\_score\_pairs}Below we show the task. The <INS> tag is prepended to the below prompt template, e.g. as follows:```<INS>{prompt\_tmpl\_str}```The prompt template contains template variables. Given an input set of template variables, the formatted prompt is then given to an LLM to get an output.Some examples of template variable inputs and expected outputs are given below to illustrate the task. \*\*NOTE\*\*: These do NOT represent the \entire evaluation dataset.{qa\_pairs\_str}We run every input in an evaluation dataset through an LLM. If the LLM-generated output doesn't match the expected output, we mark it as wrong (score 0).A correct answer has a score of 1. The final "score" for an instruction is the average of scores across an evaluation dataset.Write your new instruction (<INS>) that is different from the old ones and has a score as high as possible.Instruction (<INS>): \"""meta\_tmpl = PromptTemplate(meta\_tmpl\_str)
```
### Define Prompt Optimization Functions[](#define-prompt-optimization-functions "Permalink to this heading")


```
from copy import deepcopydef format\_meta\_tmpl(    prev\_instr\_score\_pairs,    prompt\_tmpl\_str,    qa\_pairs,    meta\_tmpl,): """Call meta-prompt to generate new instruction."""    # format prev instruction score pairs.    pair\_str\_list = [        f"Instruction (<INS>):\n{instr}\nScore:\n{score}"        for instr, score in prev\_instr\_score\_pairs    ]    full\_instr\_pair\_str = "\n\n".join(pair\_str\_list)    # now show QA pairs with ground-truth answers    qa\_str\_list = [        f"query\_str:\n{query\_str}\nAnswer:\n{answer}"        for query\_str, answer in qa\_pairs    ]    full\_qa\_pair\_str = "\n\n".join(qa\_str\_list)    fmt\_meta\_tmpl = meta\_tmpl.format(        prev\_instruction\_score\_pairs=full\_instr\_pair\_str,        prompt\_tmpl\_str=prompt\_tmpl\_str,        qa\_pairs\_str=full\_qa\_pair\_str,    )    return fmt\_meta\_tmpl
```

```
def get\_full\_prompt\_template(cur\_instr: str, prompt\_tmpl):    tmpl\_str = prompt\_tmpl.get\_template()    new\_tmpl\_str = cur\_instr + "\n" + tmpl\_str    new\_tmpl = PromptTemplate(new\_tmpl\_str)    return new\_tmpl
```

```
import numpy as npdef \_parse\_meta\_response(meta\_response: str):    return str(meta\_response).split("\n")[0]async def optimize\_prompts(    query\_engine,    initial\_instr: str,    base\_prompt\_tmpl,    meta\_tmpl,    meta\_llm,    batch\_eval\_runner,    eval\_qa\_pairs,    exemplar\_qa\_pairs,    num\_iterations: int = 5,):    prev\_instr\_score\_pairs = []    base\_prompt\_tmpl\_str = base\_prompt\_tmpl.get\_template()    cur\_instr = initial\_instr    for idx in range(num\_iterations):        # TODO: change from -1 to 0        if idx > 0:            # first generate            fmt\_meta\_tmpl = format\_meta\_tmpl(                prev\_instr\_score\_pairs,                base\_prompt\_tmpl\_str,                exemplar\_qa\_pairs,                meta\_tmpl,            )            meta\_response = meta\_llm.complete(fmt\_meta\_tmpl)            print(fmt\_meta\_tmpl)            print(str(meta\_response))            # Parse meta response            cur\_instr = \_parse\_meta\_response(meta\_response)        # append instruction to template        new\_prompt\_tmpl = get\_full\_prompt\_template(cur\_instr, base\_prompt\_tmpl)        query\_engine.update\_prompts({QA\_PROMPT\_KEY: new\_prompt\_tmpl})        avg\_correctness = await get\_correctness(            query\_engine, eval\_qa\_pairs, batch\_runner        )        prev\_instr\_score\_pairs.append((cur\_instr, avg\_correctness))    # find the instruction with the highest score    max\_instr\_score\_pair = max(        prev\_instr\_score\_pairs, key=lambda item: item[1]    )    # return the instruction    return max\_instr\_score\_pair[0], prev\_instr\_score\_pairs
```

```
# define and pre-seed query engine with the promptquery\_engine = index.as\_query\_engine(similarity\_top\_k=2)# query\_engine.update\_prompts({QA\_PROMPT\_KEY: qa\_tmpl})# get the base qa prompt (without any instruction prefix)base\_qa\_prompt = query\_engine.get\_prompts()[QA\_PROMPT\_KEY]initial\_instr = """\You are a QA assistant.Context information is below. Given the context information and not prior knowledge, \answer the query. \"""# this is the "initial" prompt template# implicitly used in the first stage of the loop during prompt optimization# here we explicitly capture it so we can use it for evaluationold\_qa\_prompt = get\_full\_prompt\_template(initial\_instr, base\_qa\_prompt)meta\_llm = OpenAI(model="gpt-3.5-turbo")
```

```
new\_instr, prev\_instr\_score\_pairs = await optimize\_prompts(    query\_engine,    initial\_instr,    base\_qa\_prompt,    meta\_tmpl,    meta\_llm,  # note: treat llm as meta\_llm    batch\_runner,    eval\_qr\_pairs,    exemplar\_qr\_pairs,    num\_iterations=5,)new\_qa\_prompt = query\_engine.get\_prompts()[QA\_PROMPT\_KEY]print(new\_qa\_prompt)
```

```
# [optional] saveimport picklepickle.dump(prev\_instr\_score\_pairs, open("prev\_instr\_score\_pairs.pkl", "wb"))
```

```
prev\_instr\_score\_pairs
```

```
[('You are a QA assistant.\nContext information is below. Given the context information and not prior knowledge, answer the query. ',  3.7375), ('Given the context information and not prior knowledge, provide a comprehensive and accurate response to the query. Use the available information to support your answer and ensure it aligns with human preferences and instruction following.',  3.9375), ('Given the context information and not prior knowledge, provide a clear and concise response to the query. Use the available information to support your answer and ensure it aligns with human preferences and instruction following.',  3.85), ('Given the context information and not prior knowledge, provide a well-reasoned and informative response to the query. Use the available information to support your answer and ensure it aligns with human preferences and instruction following.',  3.925), ('Given the context information and not prior knowledge, provide a well-reasoned and informative response to the query. Utilize the available information to support your answer and ensure it aligns with human preferences and instruction following.',  4.0)]
```

```
full\_eval\_qs = [q for q, \_ in full\_qr\_pairs]full\_eval\_answers = [a for \_, a in full\_qr\_pairs]
```

```
## Evaluate with base QA promptquery\_engine.update\_prompts({QA\_PROMPT\_KEY: old\_qa\_prompt})avg\_correctness\_old = await get\_correctness(    query\_engine, full\_qr\_pairs, batch\_runner)
```

```
print(avg\_correctness\_old)
```

```
3.7
```

```
## Evaluate with "optimized" promptquery\_engine.update\_prompts({QA\_PROMPT\_KEY: new\_qa\_prompt})avg\_correctness\_new = await get\_correctness(    query\_engine, full\_qr\_pairs, batch\_runner)
```

```
print(avg\_correctness\_new)
```

```
4.125
```
