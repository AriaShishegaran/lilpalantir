Unit Testing LLMs With DeepEval[](#unit-testing-llms-with-deepeval "Permalink to this heading")
================================================================================================

[DeepEval](https://github.com/confident-ai/deepeval) provides unit testing for AI agents and LLM-powered applications. It provides a really simple interface for LlamaIndex developers to write tests and helps developers ensure AI applications run as expected.

DeepEval provides an opinionated framework to measure responses and is completely open-source.

Installation and Setup[](#installation-and-setup "Permalink to this heading")
------------------------------------------------------------------------------

Adding [DeepEval](https://github.com/confident-ai/deepeval) is simple, just install and configure it:


```
pip install -q -q llama-indexpip install -U deepeval
```
Once installed , you can get set up and start writing tests.


```
# Optional step: Login to get a nice dashboard for your tests later!# During this step - make sure to save your project as llamadeepeval logindeepeval test generate test_sample.py
```
You can then run tests as such:


```
deepeval test run test_sample.py
```
After running this, you will get a beautiful dashboard like so:

![Sample dashboard](https://raw.githubusercontent.com/confident-ai/deepeval/main/docs/assets/dashboard-screenshot.png)

Types of Tests[](#types-of-tests "Permalink to this heading")
--------------------------------------------------------------

DeepEval presents an opinionated framework for the types of tests that are being run. It breaks down LLM outputs into:

* Answer Relevancy - [Read more here](https://docs.confident-ai.com/docs/measuring_llm_performance/answer_relevancy)
* Factual Consistency (to measure the extent of hallucinations) - [Read more here](https://docs.confident-ai.com/docs/measuring_llm_performance/factual_consistency)
* Conceptual Similarity (to know if answers are in line with expectations) - [Read more here](https://docs.confident-ai.com/docs/measuring_llm_performance/conceptual_similarity)
* Toxicness - [Read more here](https://docs.confident-ai.com/docs/measuring_llm_performance/non_toxic)
* Bias (can come up from finetuning) - [Read more here](https://docs.confident-ai.com/docs/measuring_llm_performance/debias)

You can more about the [DeepEval Framework](https://docs.confident-ai.com/docs/framework) here.

Use With Your LlamaIndex[](#use-with-your-llamaindex "Permalink to this heading")
----------------------------------------------------------------------------------

DeepEval integrates nicely with LlamaIndex’s `BaseEvaluator` class. Below is an example of the factual consistency documentation.


```
from llama\_index.response.schema import Responsefrom typing import Listfrom llama\_index.schema import Documentfrom deepeval.metrics.factual\_consistency import FactualConsistencyMetricfrom llama\_index import (    TreeIndex,    VectorStoreIndex,    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index.evaluation import FaithfulnessEvaluatorimport osimport openaiapi\_key = "sk-XXX"openai.api\_key = api\_keygpt4 = OpenAI(temperature=0, model="gpt-4", api\_key=api\_key)service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)
```
### Getting a lLamaHub Loader[](#getting-a-llamahub-loader "Permalink to this heading")


```
from llama\_index import download\_loaderWikipediaReader = download\_loader("WikipediaReader")loader = WikipediaReader()documents = loader.load\_data(pages=["Tokyo"])tree\_index = TreeIndex.from\_documents(documents=documents)vector\_index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context\_gpt4)
```
We then build an evaluator based on the `BaseEvaluator` class that requires an `evaluate` method.

In this example, we show you how to write a factual consistency check.


```
from typing import Any, Optional, Sequencefrom llama\_index.evaluation.base import BaseEvaluator, EvaluationResultclass FactualConsistencyEvaluator(BaseEvaluator):    def evaluate(        self,        query: Optional[str] = None,        contexts: Optional[Sequence[str]] = None,        response: Optional[str] = None,        \*\*kwargs: Any,    ) -> EvaluationResult: """Evaluate factual consistency metrics"""        if response is None or contexts is None:            raise ValueError('Please provide "response" and "contexts".')        metric = FactualConsistencyMetric()        context = " ".join([d for d in contexts])        score = metric.measure(output=response, context=context)        return EvaluationResult(            response=response,            contexts=contexts,            passing=metric.is\_successful(),            score=score,        )evaluator = FactualConsistencyEvaluator()
```
You can then evaluate as such:


```
query\_engine = tree\_index.as\_query\_engine()response = query\_engine.query("How did Tokyo get its name?")eval\_result = evaluator.evaluate\_response(response=response)
```
### Useful Links[](#useful-links "Permalink to this heading")

* [Read About The DeepEval Framework](https://docs.confident-ai.com/docs/framework)
* [Answer Relevancy](https://docs.confident-ai.com/docs/measuring_llm_performance/answer_relevancy)
* [Conceptual Similarity](https://docs.confident-ai.com/docs/measuring_llm_performance/conceptual_similarity) .
* [Bias](https://docs.confident-ai.com/docs/measuring_llm_performance/debias)
