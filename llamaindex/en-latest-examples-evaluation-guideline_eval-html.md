[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/guideline_eval.ipynb)

Guideline Evaluator[](#guideline-evaluator "Permalink to this heading")
========================================================================

This notebook shows how to use `GuidelineEvaluator` to evaluate a question answer system given user specified guidelines.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.evaluation import GuidelineEvaluatorfrom llama\_index import ServiceContextfrom llama\_index.llms import OpenAI# Needed for running async functions in Jupyter Notebookimport nest\_asyncionest\_asyncio.apply()
```

```
GUIDELINES = [    "The response should fully answer the query.",    "The response should avoid being vague or ambiguous.",    (        "The response should be specific and use statistics or numbers when"        " possible."    ),]
```

```
service\_context = ServiceContext.from\_defaults(llm=OpenAI(model="gpt-4"))evaluators = [    GuidelineEvaluator(service\_context=service\_context, guidelines=guideline)    for guideline in GUIDELINES]
```

```
sample\_data = {    "query": "Tell me about global warming.",    "contexts": [        (            "Global warming refers to the long-term increase in Earth's"            " average surface temperature due to human activities such as the"            " burning of fossil fuels and deforestation."        ),        (            "It is a major environmental issue with consequences such as"            " rising sea levels, extreme weather events, and disruptions to"            " ecosystems."        ),        (            "Efforts to combat global warming include reducing carbon"            " emissions, transitioning to renewable energy sources, and"            " promoting sustainable practices."        ),    ],    "response": (        "Global warming is a critical environmental issue caused by human"        " activities that lead to a rise in Earth's temperature. It has"        " various adverse effects on the planet."    ),}
```

```
for guideline, evaluator in zip(GUIDELINES, evaluators):    eval\_result = evaluator.evaluate(        query=sample\_data["query"],        contexts=sample\_data["contexts"],        response=sample\_data["response"],    )    print("=====")    print(f"Guideline: {guideline}")    print(f"Pass: {eval\_result.passing}")    print(f"Feedback: {eval\_result.feedback}")
```

```
=====Guideline: The response should fully answer the query.Pass: FalseFeedback: The response does not fully answer the query. While it does provide a brief overview of global warming, it does not delve into the specifics of the causes, effects, or potential solutions to the problem. The response should be more detailed and comprehensive to fully answer the query.=====Guideline: The response should avoid being vague or ambiguous.Pass: FalseFeedback: The response is too vague and does not provide specific details about global warming. It should include more information about the causes, effects, and potential solutions to global warming.=====Guideline: The response should be specific and use statistics or numbers when possible.Pass: FalseFeedback: The response is too general and lacks specific details or statistics about global warming. It would be more informative if it included data such as the rate at which the Earth's temperature is rising, the main human activities contributing to global warming, or the specific adverse effects on the planet.
```
