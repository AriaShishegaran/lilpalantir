Evaluating and Tracking with TruLens[](#evaluating-and-tracking-with-trulens "Permalink to this heading")
==========================================================================================================

This page covers how to use [TruLens](https://trulens.org) to evaluate and track LLM apps built on Llama-Index.

What is TruLens?[](#what-is-trulens "Permalink to this heading")
-----------------------------------------------------------------

TruLens is an [opensource](https://github.com/truera/trulens) package that provides instrumentation and evaluation tools for large language model (LLM) based applications. This includes feedback function evaluations of relevance, sentiment and more, plus in-depth tracing including cost and latency.

![TruLens Architecture](https://www.trulens.org/Assets/image/TruLens_Architecture.png)

As you iterate on new versions of your LLM application, you can compare their performance across all of the different quality metrics you’ve set up. You’ll also be able to view evaluations at a record level, and explore the app metadata for each record.

### Installation and Setup[](#installation-and-setup "Permalink to this heading")

Adding TruLens is simple, just install it from pypi!


```
pip install trulens-eval
```

```
from trulens\_eval import TruLlama
```
Try it out![](#try-it-out "Permalink to this heading")
-------------------------------------------------------

[llama\_index\_quickstart.ipynb](https://github.com/truera/trulens/blob/releases/rc-trulens-eval-0.16.0/trulens_eval/examples/quickstart/llama_index_quickstart.ipynb)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/truera/trulens/blob/main/trulens_eval/examples/quickstart/llama_index_quickstart.ipynb)

Read more[](#read-more "Permalink to this heading")
----------------------------------------------------

* [Build and Evaluate LLM Apps with LlamaIndex and TruLens](https://medium.com/llamaindex-blog/build-and-evaluate-llm-apps-with-llamaindex-and-trulens-6749e030d83c)
* [More examples](https://github.com/truera/trulens/tree/main/trulens_eval/examples/frameworks/llama_index)
* [trulens.org](https://www.trulens.org/)
