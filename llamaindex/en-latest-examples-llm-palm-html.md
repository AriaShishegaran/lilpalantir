[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/palm.ipynb)

PaLM[](#palm "Permalink to this heading")
==========================================

In this short notebook, we show how to use the PaLM LLM from Google in LlamaIndex: https://ai.google/discover/palm2/.

We use the `text-bison-001` model by default.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
!pip install -q google-generativeai
```

```
[notice] A new release of pip available: 22.3.1 -> 23.1.2[notice] To update, run: pip install --upgrade pip
```

```
import pprintimport google.generativeai as palm
```

```
palm\_api\_key = ""
```

```
palm.configure(api\_key=palm\_api\_key)
```
Define Model[](#define-model "Permalink to this heading")
----------------------------------------------------------


```
models = [    m    for m in palm.list\_models()    if "generateText" in m.supported\_generation\_methods]model = models[0].nameprint(model)
```

```
models/text-bison-001
```
Start using our `PaLM` LLM abstraction![](#start-using-our-palm-llm-abstraction "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------


```
from llama\_index.llms.palm import PaLMmodel = PaLM(api\_key=palm\_api\_key)
```

```
model.complete(prompt)
```

```
CompletionResponse(text='1 house has 3 cats * 4 mittens / cat = 12 mittens.\n3 houses have 12 mittens / house * 3 houses = 36 mittens.\n1 hat needs 4m of yarn. 36 hats need 4m / hat * 36 hats = 144m of yarn.\n1 mitten needs 7m of yarn. 36 mittens need 7m / mitten * 36 mittens = 252m of yarn.\nIn total 144m of yarn was needed for hats and 252m of yarn was needed for mittens, so 144m + 252m = 396m of yarn was needed.\n\nThe answer: 396', additional_kwargs={}, raw={'output': '1 house has 3 cats * 4 mittens / cat = 12 mittens.\n3 houses have 12 mittens / house * 3 houses = 36 mittens.\n1 hat needs 4m of yarn. 36 hats need 4m / hat * 36 hats = 144m of yarn.\n1 mitten needs 7m of yarn. 36 mittens need 7m / mitten * 36 mittens = 252m of yarn.\nIn total 144m of yarn was needed for hats and 252m of yarn was needed for mittens, so 144m + 252m = 396m of yarn was needed.\n\nThe answer: 396', 'safety_ratings': [{'category': <HarmCategory.HARM_CATEGORY_DEROGATORY: 1>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}, {'category': <HarmCategory.HARM_CATEGORY_TOXICITY: 2>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}, {'category': <HarmCategory.HARM_CATEGORY_VIOLENCE: 3>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}, {'category': <HarmCategory.HARM_CATEGORY_SEXUAL: 4>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}, {'category': <HarmCategory.HARM_CATEGORY_MEDICAL: 5>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}, {'category': <HarmCategory.HARM_CATEGORY_DANGEROUS: 6>, 'probability': <HarmProbability.NEGLIGIBLE: 1>}]}, delta=None)
```
