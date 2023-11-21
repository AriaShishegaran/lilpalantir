[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/LongContextReorder.ipynb)

LongContextReorder[](#longcontextreorder "Permalink to this heading")
======================================================================

Models struggle to access significant details found in the center of extended contexts. [A study](https://arxiv.org/abs/2307.03172) observed that the best performance typically arises when crucial data is positioned at the start or conclusion of the input context. Additionally, as the input context lengthens, performance drops notably, even in models designed for long contexts.

This module will re-order the retrieved nodes, which can be helpful in cases where a large top-k is needed.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo-instruct", temperature=0.1)ctx = ServiceContext.from\_defaults(    llm=llm, embed\_model="local:BAAI/bge-base-en-v1.5")
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/torch/cuda/__init__.py:546: UserWarning: Can't initialize NVML  warnings.warn("Can't initialize NVML")
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex.from\_documents(documents, service\_context=ctx)
```
Run Query[](#run-query "Permalink to this heading")
----------------------------------------------------


```
from llama\_index.indices.postprocessor import LongContextReorderreorder = LongContextReorder()reorder\_engine = index.as\_query\_engine(    node\_postprocessors=[reorder], similarity\_top\_k=5)base\_engine = index.as\_query\_engine(similarity\_top\_k=5)
```

```
from llama\_index.response.notebook\_utils import display\_responsebase\_response = base\_engine.query("Did the author meet Sam Altman?")display\_response(base\_response)
```
**`Final Response:`** Yes, the author met Sam Altman when they asked him to be the president of Y Combinator. This was during the time when the author was in a PhD program in computer science and also pursuing their passion for art. They were applying to art schools and eventually ended up attending RISD.


```
reorder\_response = reorder\_engine.query("Did the author meet Sam Altman?")display\_response(reorder\_response)
```
**`Final Response:`** Yes, the author met Sam Altman when they asked him to be the president of Y Combinator. This meeting occurred at a party at the author’s house, where they were introduced by a mutual friend, Jessica Livingston. Jessica later went on to compile a book of interviews with startup founders, and the author shared their thoughts on the flaws of venture capital with her during her job search at a Boston VC firm.

Inspect Order Diffrences[](#inspect-order-diffrences "Permalink to this heading")
----------------------------------------------------------------------------------


```
print(base\_response.get\_formatted\_sources())
```

```
> Source (Doc id: 81bc66bb-2c45-4697-9f08-9f848bd78b12): [17]As well as HN, I wrote all of YC's internal software in Arc. But while I continued to work ...> Source (Doc id: bd660905-e4e0-4d02-a113-e3810b59c5d1): [19] One way to get more precise about the concept of invented vs discovered is to talk about spa...> Source (Doc id: 3932e4a4-f17e-4dd2-9d25-5f0e65910dc5): Not so much because it was badly written as because the problem is so convoluted. When you're wor...> Source (Doc id: 0d801f0a-4a99-475d-aa7c-ad5d601947ea): [10]Wow, I thought, there's an audience. If I write something and put it on the web, anyone can...> Source (Doc id: bf726802-4d0d-4ee5-ab2e-ffa8a5461bc4): I was briefly tempted, but they were so slow by present standards; what was the point? No one els...
```

```
print(reorder\_response.get\_formatted\_sources())
```

```
> Source (Doc id: 81bc66bb-2c45-4697-9f08-9f848bd78b12): [17]As well as HN, I wrote all of YC's internal software in Arc. But while I continued to work ...> Source (Doc id: 3932e4a4-f17e-4dd2-9d25-5f0e65910dc5): Not so much because it was badly written as because the problem is so convoluted. When you're wor...> Source (Doc id: bf726802-4d0d-4ee5-ab2e-ffa8a5461bc4): I was briefly tempted, but they were so slow by present standards; what was the point? No one els...> Source (Doc id: 0d801f0a-4a99-475d-aa7c-ad5d601947ea): [10]Wow, I thought, there's an audience. If I write something and put it on the web, anyone can...> Source (Doc id: bd660905-e4e0-4d02-a113-e3810b59c5d1): [19] One way to get more precise about the concept of invented vs discovered is to talk about spa...
```
