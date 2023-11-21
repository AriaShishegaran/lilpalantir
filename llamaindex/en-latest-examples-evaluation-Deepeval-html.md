[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/Deepeval.ipynb)

LlamaIndex + DeepEval Integration[](#llamaindex-deepeval-integration "Permalink to this heading")
==================================================================================================

This code tutorial shows how you can easily integrate LlamaIndex with DeepEval. DeepEval makes it easy to unit-test your LLMs.

You can read more about the DeepEval framework here: https://docs.confident-ai.com/docs/framework

Feel free to check out our repository here: https://github.com/confident-ai/deepeval

![Framework](https://docs.confident-ai.com/assets/images/llm-evaluation-framework-example-b02144720026b6d49b1e04d8a99d3d33.png)

Set-up and Installation[](#set-up-and-installation "Permalink to this heading")
--------------------------------------------------------------------------------

We recommend setting up and installing via pip!


```
!pip install -q -q llama-index!pip install -U -q deepeval
```
This step is optional and only if you want a server-hosted dashboard! (Psst I think you should!)


```
!deepeval login
```
Testing for factual consistency[](#testing-for-factual-consistency "Permalink to this heading")
------------------------------------------------------------------------------------------------


```
from llama\_index.response.schema import Responsefrom typing import Listfrom llama\_index.schema import Documentfrom deepeval.metrics.factual\_consistency import FactualConsistencyMetric
```
Setting Up The Evaluator[](#setting-up-the-evaluator "Permalink to this heading")
----------------------------------------------------------------------------------

Setting up the evaluator.


```
from llama\_index import (    TreeIndex,    VectorStoreIndex,    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index.evaluation import FaithfulnessEvaluator
```

```
import osimport openaiapi\_key = "sk-XXX"openai.api\_key = api\_key
```

```
gpt4 = OpenAI(temperature=0, model="gpt-4", api\_key=api\_key)service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4 = FaithfulnessEvaluator(service\_context=service\_context\_gpt4)
```
### Getting a LlamaHub Loader[](#getting-a-llamahub-loader "Permalink to this heading")


```
from llama\_index import download\_loaderWikipediaReader = download\_loader("WikipediaReader")loader = WikipediaReader()documents = loader.load\_data(pages=["Tokyo"])
```

```
tree\_index = TreeIndex.from\_documents(documents=documents)vector\_index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context\_gpt4)
```
We then build an evaluator based on the `BaseEvaluator` class that requires an `evaluate` method.

In this example, we show you how to write a factual consistency check.


```
from typing import Any, Optional, Sequencefrom llama\_index.evaluation.base import BaseEvaluator, EvaluationResultclass FactualConsistencyEvaluator(BaseEvaluator):    def evaluate(        self,        query: Optional[str] = None,        contexts: Optional[Sequence[str]] = None,        response: Optional[str] = None,        \*\*kwargs: Any,    ) -> EvaluationResult: """Evaluate factual consistency metrics"""        if response is None or contexts is None:            raise ValueError('Please provide "response" and "contexts".')        metric = FactualConsistencyMetric()        context = " ".join([d for d in contexts])        score = metric.measure(output=response, context=context)        return EvaluationResult(            response=response,            contexts=contexts,            passing=metric.is\_successful(),            score=score,        )evaluator = FactualConsistencyEvaluator()
```

```
query\_engine = tree\_index.as\_query\_engine()response = query\_engine.query("How did Tokyo get its name?")eval\_result = evaluator.evaluate\_response(response=response)
```

```
/usr/local/lib/python3.10/dist-packages/transformers/convert_slow_tokenizer.py:470: UserWarning: The sentencepiece tokenizer that you are converting to a fast tokenizer uses the byte fallback option which is not implemented in the fast tokenizers. In practice this means that the fast version of the tokenizer can produce unknown tokens whereas the sentencepiece version would have converted these unknown tokens into a sequence of byte tokens matching the original piece of text.  warnings.warn(
```

```
{'success': True, 'score': 0.97732705}
```

```
/usr/local/lib/python3.10/dist-packages/deepeval/metrics/metric.py:42: UserWarning: API key is not set. Please set it by visiting https://app.confident-ai.com  warnings.warn(
```
Other Metrics[](#other-metrics "Permalink to this heading")
------------------------------------------------------------

We recommend using other metrics to help give more confidence to various prompt iterations, LLM outputs etc. We think ML-assisted approaches are required to give performance for these models.

* Overall Score: https://docs.confident-ai.com/docs/measuring\_llm\_performance/overall\_score
* Answer Relevancy: https://docs.confident-ai.com/docs/measuring\_llm\_performance/answer\_relevancy
* Bias: https://docs.confident-ai.com/docs/measuring\_llm\_performance/debias
