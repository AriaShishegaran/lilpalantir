Observability[](#observability "Permalink to this heading")
============================================================

LlamaIndex provides **one-click observability** 🔭 to allow you to build principled LLM applications in a production setting.

A key requirement for principled development of LLM applications over your data (RAG systems, agents) is being able to observe, debug, and evaluateyour system - both as a whole and for each component.

This feature allows you to seamlessly integrate the LlamaIndex library with powerful observability/evaluation tools offered by our partners.Configure a variable once, and you’ll be able to do things like the following:

* View LLM/prompt inputs/outputs
* Ensure that the outputs of any component (LLMs, embeddings) are performing as expected
* View call traces for both indexing and querying

Each provider has similarities and differences. Take a look below for the full set of guides for each one!

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

To toggle, you will generally just need to do the following:


```
from llama\_index import set\_global\_handler# general usageset\_global\_handler("<handler\_name>", \*\*kwargs)# W&B example# set\_global\_handler("wandb", run\_args={"project": "llamaindex"})
```
Note that all `kwargs` to `set\_global\_handler` are passed to the underlying callback handler.

And that’s it! Executions will get seamlessly piped to downstream service (e.g. W&B Prompts) and you’ll be able to access features such as viewing execution traces of your application.

**NOTE**: TruLens (by TruEra) uses a different “one-click” experience. See below for details.

Simple (LLM Inputs/Outputs)[](#simple-llm-inputs-outputs "Permalink to this heading")
--------------------------------------------------------------------------------------

This simple observability tool prints every LLM input/output pair to the terminal. Most useful for when you need to quickly enable debug logging on your LLM application.

### Usage Pattern[](#id1 "Permalink to this heading")


```
import llama\_indexllama\_index.set\_global\_handler("simple")
```
Partner `One-Click` Integrations[](#partner-one-click-integrations "Permalink to this heading")
------------------------------------------------------------------------------------------------

We offer a rich set of integrations with our partners. A short description + usage pattern, and guide is provided for each partner.

### Weights and Biases Prompts[](#weights-and-biases-prompts "Permalink to this heading")

Prompts allows users to log/trace/inspect the execution flow of LlamaIndex during index construction and querying. It also allows users to version-control their indices.

#### Usage Pattern[](#id2 "Permalink to this heading")


```
from llama\_index import set\_global\_handlerset\_global\_handler("wandb", run\_args={"project": "llamaindex"})# NOTE: No need to do the following# from llama\_index.callbacks import WandbCallbackHandler, CallbackManager# wandb\_callback = WandbCallbackHandler(run\_args={"project": "llamaindex"})# callback\_manager = CallbackManager([wandb\_callback])# service\_context = ServiceContext.from\_defaults(# callback\_manager=callback\_manager# )# access additional methods on handler to persist index + load indeximport llama\_index# persist indexllama\_index.global\_handler.persist\_index(graph, index\_name="composable\_graph")# load storage contextstorage\_context = llama\_index.global\_handler.load\_storage\_context(    artifact\_url="ayut/llamaindex/composable\_graph:v0")
```
![](../../_images/wandb.png)

#### Guides[](#guides "Permalink to this heading")

* [Wandb Callback Handler](../../examples/callbacks/WandbCallbackHandler.html)
### OpenLLMetry[](#openllmetry "Permalink to this heading")

[OpenLLMetry](https://github.com/traceloop/openllmetry) is an open-source project based on OpenTelemetry for tracing and monitoringLLM applications. It connects to [all major observability platforms](https://www.traceloop.com/docs/openllmetry/integrations/introduction) and installs in minutes.

#### Usage Pattern[](#id3 "Permalink to this heading")


```
from traceloop.sdk import TraceloopTraceloop.init()
```
![](../../_images/openllmetry.png)

### Arize Phoenix[](#arize-phoenix "Permalink to this heading")

Arize [Phoenix](https://github.com/Arize-ai/phoenix): LLMOps insights at lightning speed with zero-config observability. Phoenix provides a notebook-first experience for monitoring your models and LLM Applications by providing:

* LLM Traces - Trace through the execution of your LLM Application to understand the internals of your LLM Application and to troubleshoot problems related to things like retrieval and tool execution.
* LLM Evals - Leverage the power of large language models to evaluate your generative model or application’s relevance, toxicity, and more.

#### Usage Pattern[](#id4 "Permalink to this heading")


```
# Phoenix can display in real time the traces automatically# collected from your LlamaIndex application.import phoenix as px# Look for a URL in the output to open the App in a browser.px.launch\_app()# The App is initially empty, but as you proceed with the steps below,# traces will appear automatically as your LlamaIndex application runs.import llama\_indexllama\_index.set\_global\_handler("arize\_phoenix")# Run all of your LlamaIndex applications as usual and traces# will be collected and displayed in Phoenix....
```
![](../../_images/arize_phoenix.png)

#### Guides[](#id5 "Permalink to this heading")

* [Arize Phoenix Tracing Tutorial](https://colab.research.google.com/github/Arize-ai/phoenix/blob/main/tutorials/tracing/llama_index_tracing_tutorial.ipynb)
### OpenInference[](#openinference "Permalink to this heading")

[OpenInference](https://github.com/Arize-ai/open-inference-spec) is an open standard for capturing and storing AI model inferences. It enables experimentation, visualization, and evaluation of LLM applications using LLM observability solutions such as [Phoenix](https://github.com/Arize-ai/phoenix).

#### Usage Pattern[](#id6 "Permalink to this heading")


```
import llama\_indexllama\_index.set\_global\_handler("openinference")# NOTE: No need to do the following# from llama\_index.callbacks import OpenInferenceCallbackHandler, CallbackManager# callback\_handler = OpenInferenceCallbackHandler()# callback\_manager = CallbackManager([callback\_handler])# service\_context = ServiceContext.from\_defaults(# callback\_manager=callback\_manager# )# Run your LlamaIndex application here...for query in queries:    query\_engine.query(query)# View your LLM app data as a dataframe in OpenInference format.from llama\_index.callbacks.open\_inference\_callback import as\_dataframequery\_data\_buffer = llama\_index.global\_handler.flush\_query\_data\_buffer()query\_dataframe = as\_dataframe(query\_data\_buffer)
```
**NOTE**: To unlock capabilities of Phoenix, you will need to define additional steps to feed in query/ context dataframes. See below!

#### Guides[](#id7 "Permalink to this heading")

* [OpenInference Callback Handler + Arize Phoenix](../../examples/callbacks/OpenInferenceCallback.html)
* [Evaluating Search and Retrieval with Arize Phoenix](https://colab.research.google.com/github/Arize-ai/phoenix/blob/main/tutorials/llama_index_search_and_retrieval_tutorial.ipynb)
### TruEra TruLens[](#truera-trulens "Permalink to this heading")

TruLens allows users to instrument/evaluate LlamaIndex applications, through features such as feedback functions and tracing.

#### Usage Pattern + Guides[](#usage-pattern-guides "Permalink to this heading")


```
# use trulensfrom trulens\_eval import TruLlamatru\_query\_engine = TruLlama(query\_engine)# querytru\_query\_engine.query("What did the author do growing up?")
```
![](../../_images/trulens.png)

#### Guides[](#id8 "Permalink to this heading")

* [Evaluating and Tracking with TruLens](../../community/integrations/trulens.html)
* [Quickstart Guide with LlamaIndex + TruLens](https://github.com/truera/trulens/blob/main/trulens_eval/examples/frameworks/llama_index/llama_index_quickstart.ipynb)
* [Colab](https://colab.research.google.com/github/truera/trulens/blob/main/trulens_eval/examples/frameworks/llama_index/llama_index_quickstart.ipynb)
### HoneyHive[](#honeyhive "Permalink to this heading")

HoneyHive allows users to trace the execution flow of any LLM pipeline. Users can then debug and analyze their traces, or customize feedback on specific trace events to create evaluation or fine-tuning datasets from production.

#### Usage Pattern[](#id9 "Permalink to this heading")


```
from llama\_index import set\_global\_handlerset\_global\_handler(    "honeyhive",    project="My HoneyHive Project",    name="My LLM Pipeline Name",    api\_key="MY HONEYHIVE API KEY",)# NOTE: No need to do the following# from llama\_index import ServiceContext# from llama\_index.callbacks import CallbackManager# from honeyhive.sdk.llamaindex\_tracer import HoneyHiveLlamaIndexTracer# hh\_tracer = HoneyHiveLlamaIndexTracer(# project="My HoneyHive Project",# name="My LLM Pipeline Name",# api\_key="MY HONEYHIVE API KEY",# )# callback\_manager = CallbackManager([hh\_tracer])# service\_context = ServiceContext.from\_defaults(# callback\_manager=callback\_manager# )
```
![](../../_images/honeyhive.png)![](../../_images/perfetto.png)*Use Perfetto to debug and analyze your HoneyHive traces*

#### Guides[](#id10 "Permalink to this heading")

* [HoneyHive LlamaIndex Tracer](../../examples/callbacks/HoneyHiveLlamaIndexTracer.html)
More observability[](#more-observability "Permalink to this heading")
----------------------------------------------------------------------

* [Callbacks](callbacks/root.html)
