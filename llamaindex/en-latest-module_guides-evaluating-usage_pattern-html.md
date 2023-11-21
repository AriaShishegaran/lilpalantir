Usage Pattern (Response Evaluation)[](#usage-pattern-response-evaluation "Permalink to this heading")
======================================================================================================

Using `BaseEvaluator`[](#using-baseevaluator "Permalink to this heading")
--------------------------------------------------------------------------

All of the evaluation modules in LlamaIndex implement the `BaseEvaluator` class, with two main methods:

1. The `evaluate` method takes in `query`, `contexts`, `response`, and additional keyword arguments.


```
    def evaluate(        self,        query: Optional[str] = None,        contexts: Optional[Sequence[str]] = None,        response: Optional[str] = None,        \*\*kwargs: Any,    ) -> EvaluationResult:
```
2. The `evaluate\_response` method provide an alternative interface that takes in a llamaindex `Response` object (which contains response string and source nodes) instead of separate `contexts` and `response`.


```
def evaluate\_response(    self,    query: Optional[str] = None,    response: Optional[Response] = None,    \*\*kwargs: Any,) -> EvaluationResult:
```
It’s functionally the same as `evaluate`, just simpler to use when working with llamaindex objects directly.

Using `EvaluationResult`[](#using-evaluationresult "Permalink to this heading")
--------------------------------------------------------------------------------

Each evaluator outputs a `EvaluationResult` when executed:


```
eval\_result = evaluator.evaluate(query=..., contexts=..., response=...)eval\_result.passing  # binary pass/faileval\_result.score  # numerical scoreeval\_result.feedback  # string feedback
```
Different evaluators may populate a subset of the result fields.

Evaluating Response Faithfulness (i.e. Hallucination)[](#evaluating-response-faithfulness-i-e-hallucination "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------

The `FaithfulnessEvaluator` evaluates if the answer is faithful to the retrieved contexts (in other words, whether if there’s hallucination).


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.evaluation import FaithfulnessEvaluator# build service contextllm = OpenAI(model="gpt-4", temperature=0.0)service\_context = ServiceContext.from\_defaults(llm=llm)# build index...# define evaluatorevaluator = FaithfulnessEvaluator(service\_context=service\_context)# query indexquery\_engine = vector\_index.as\_query\_engine()response = query\_engine.query(    "What battles took place in New York City in the American Revolution?")eval\_result = evaluator.evaluate\_response(response=response)print(str(eval\_result.passing))
```
![](../../_images/eval_response_context.png)

You can also choose to evaluate each source context individually:


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.evaluation import FaithfulnessEvaluator# build service contextllm = OpenAI(model="gpt-4", temperature=0.0)service\_context = ServiceContext.from\_defaults(llm=llm)# build index...# define evaluatorevaluator = FaithfulnessEvaluator(service\_context=service\_context)# query indexquery\_engine = vector\_index.as\_query\_engine()response = query\_engine.query(    "What battles took place in New York City in the American Revolution?")response\_str = response.responsefor source\_node in response.source\_nodes:    eval\_result = evaluator.evaluate(        response=response\_str, contexts=[source\_node.get\_content()]    )    print(str(eval\_result.passing))
```
You’ll get back a list of results, corresponding to each source node in `response.source\_nodes`.

Evaluating Query + Response Relevancy[](#evaluating-query-response-relevancy "Permalink to this heading")
----------------------------------------------------------------------------------------------------------

The `RelevancyEvaluator` evaluates if the retrieved context and the answer is relevant and consistent for the given query.

Note that this evaluator requires the `query` to be passed in, in addition to the `Response` object.


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.evaluation import RelevancyEvaluator# build service contextllm = OpenAI(model="gpt-4", temperature=0.0)service\_context = ServiceContext.from\_defaults(llm=llm)# build index...# define evaluatorevaluator = RelevancyEvaluator(service\_context=service\_context)# query indexquery\_engine = vector\_index.as\_query\_engine()query = "What battles took place in New York City in the American Revolution?"response = query\_engine.query(query)eval\_result = evaluator.evaluate\_response(query=query, response=response)print(str(eval\_result))
```
![](../../_images/eval_query_response_context.png)

Similarly, you can also evaluate on a specific source node.


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.evaluation import RelevancyEvaluator# build service contextllm = OpenAI(model="gpt-4", temperature=0.0)service\_context = ServiceContext.from\_defaults(llm=llm)# build index...# define evaluatorevaluator = RelevancyEvaluator(service\_context=service\_context)# query indexquery\_engine = vector\_index.as\_query\_engine()query = "What battles took place in New York City in the American Revolution?"response = query\_engine.query(query)response\_str = response.responsefor source\_node in response.source\_nodes:    eval\_result = evaluator.evaluate(        query=query,        response=response\_str,        contexts=[source\_node.get\_content()],    )    print(str(eval\_result.passing))
```
![](../../_images/eval_query_sources.png)

Question Generation[](#question-generation "Permalink to this heading")
------------------------------------------------------------------------

LlamaIndex can also generate questions to answer using your data. Using in combination with the above evaluators, you can create a fully automated evaluation pipeline over your data.


```
from llama\_index import SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.evaluation import DatasetGenerator# build service contextllm = OpenAI(model="gpt-4", temperature=0.0)service\_context = ServiceContext.from\_defaults(llm=llm)# build documentsdocuments = SimpleDirectoryReader("./data").load\_data()# define generator, generate questionsdata\_generator = DatasetGenerator.from\_documents(documents)eval\_questions = data\_generator.generate\_questions\_from\_nodes()
```
Batch Evaluation[](#batch-evaluation "Permalink to this heading")
------------------------------------------------------------------

We also provide a batch evaluation runner for running a set of evaluators across many questions.


```
from llama\_index.evaluation import BatchEvalRunnerrunner = BatchEvalRunner(    {"faithfulness": faithfulness\_evaluator, "relevancy": relevancy\_evaluator},    workers=8,)eval\_results = await runner.aevaluate\_queries(    vector\_index.as\_query\_engine(), queries=questions)
```
Integrations[](#integrations "Permalink to this heading")
----------------------------------------------------------

We also integrate with community evaluation tools.

* [DeepEval](#../../../community/integrations/deepeval.md)
* [Ragas](https://github.com/explodinggradients/ragas/blob/main/docs/howtos/integrations/llamaindex.ipynb)
