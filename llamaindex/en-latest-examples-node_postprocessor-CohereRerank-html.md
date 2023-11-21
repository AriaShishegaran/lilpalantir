[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/CohereRerank.ipynb)

Cohere Rerank[](#cohere-rerank "Permalink to this heading")
============================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    pprint\_response,)
```

```
/Users/suo/miniconda3/envs/llama/lib/python3.9/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()# build indexindex = VectorStoreIndex.from\_documents(documents=documents)
```
Retrieve top 10 most relevant nodes, then filter with Cohere Rerank[](#retrieve-top-10-most-relevant-nodes-then-filter-with-cohere-rerank "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


```
import osfrom llama\_index.indices.postprocessor.cohere\_rerank import CohereRerankapi\_key = os.environ["COHERE\_API\_KEY"]cohere\_rerank = CohereRerank(api\_key=api\_key, top\_n=2)
```

```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=10,    node\_postprocessors=[cohere\_rerank],)response = query\_engine.query(    "What did Sam Altman do in this essay?",)
```

```
pprint\_response(response)
```

```
Final Response: Sam Altman agreed to become the president of YCombinator in October 2013. He took over starting with the winter 2014batch, and worked with the founders to help them get through Demo Dayin March 2014. He then reorganised Y Combinator to be controlled bysomeone other than the founders, so that it could last for a longtime.______________________________________________________________________Source Node 1/2Document ID: c1baaa76-acba-453b-a8d1-fdffbde1f424Similarity: 0.845305Text: day in 2010, when he was visiting California for interviews,Robert Morris did something astonishing: he offered me unsolicitedadvice. I can only remember him doing that once before. One day atViaweb, when I was bent over double from a kidney stone, he suggestedthat it would be a good idea for him to take me to the hospital. Thatwas what it ...______________________________________________________________________Source Node 2/2Document ID: abc0f1aa-464a-4ae1-9a7b-2d47a9dc967eSimilarity: 0.6486889Text: due to our ignorance about investing. We needed to getexperience as investors. What better way, we thought, than to fund awhole bunch of startups at once? We knew undergrads got temporary jobsat tech companies during the summer. Why not organize a summer programwhere they'd start startups instead? We wouldn't feel guilty for beingin a sense...
```
Directly retrieve top 2 most similar nodes[](#directly-retrieve-top-2-most-similar-nodes "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=2,)response = query\_engine.query(    "What did Sam Altman do in this essay?",)
```
Retrieved context is irrelevant and response is hallucinated.


```
pprint\_response(response)
```

```
Final Response: Sam Altman was one of the founders of Y Combinator, astartup accelerator. He was part of the first batch of startups fundedby Y Combinator, which included Reddit, Justin Kan and Emmett Shear'sTwitch, and Aaron Swartz. He was also involved in the Summer FoundersProgram, which was a summer program where undergrads could start theirown startups instead of taking a summer job at a tech company. He alsohelped to develop a new version of Arc, a programming language, andwrote a book on Lisp.______________________________________________________________________Source Node 1/2Document ID: abc0f1aa-464a-4ae1-9a7b-2d47a9dc967eSimilarity: 0.7940524933077708Text: due to our ignorance about investing. We needed to getexperience as investors. What better way, we thought, than to fund awhole bunch of startups at once? We knew undergrads got temporary jobsat tech companies during the summer. Why not organize a summer programwhere they'd start startups instead? We wouldn't feel guilty for beingin a sense...______________________________________________________________________Source Node 2/2Document ID: 5d696e20-b496-47f0-9262-7aa2667c1d96Similarity: 0.7899270712205545Text: at RISD, but otherwise I was basically teaching myself to paint,and I could do that for free. So in 1993 I dropped out. I hung aroundProvidence for a bit, and then my college friend Nancy Parmet did me abig favor. A rent-controlled apartment in a building her mother ownedin New York was becoming vacant. Did I want it? It wasn't much moretha...
```
