Evaluation[](#evaluation "Permalink to this heading")
======================================================

Setting the Stage[](#setting-the-stage "Permalink to this heading")
--------------------------------------------------------------------

LlamaIndex is meant to connect your data to your LLM applications.

Sometimes, even after diagnosing and fixing bugs by looking at traces, more fine-grained evaluation is required to systematically diagnose issues.

LlamaIndex aims to provide those tools to make identifying issues and receiving useful diagnostic signals easy.

Closely tied to evaluation are the concepts of experimentation and experiment tracking.

General Strategy[](#general-strategy "Permalink to this heading")
------------------------------------------------------------------

When developing your LLM application, it could help to first define an end-to-end evaluation workflow, and then once you’ve started collecting failure or corner cases and getting an intuition for what is or isn’t going well, you may dive deeper into evaluating and improving specific components.

The analogy with software testing is integration tests and unit tests. You should probably start writing unit tests once you start fiddling with individual components. Equally, your gold standard on whether things are working will together are integration tests. Both are equally important.

* [End-to-End Evaluation](e2e_evaluation.html)
* [Component Wise Evaluation](component_wise_evaluation.html)
Here is an overview of the existing modules for evaluation. We will be adding more modules and support over time.

* [Evaluating](../../module_guides/evaluating/root.html)
### E2E or Component-Wise - Which Do I Start With?[](#e2e-or-component-wise-which-do-i-start-with "Permalink to this heading")

If you want to get an overall idea of how your system is doing as you iterate upon it, it makes sense to start with centering your core development loop around the e2e eval - as an overall sanity/vibe check.

If you have an idea of what you’re doing and want to iterate step by step on each component, building it up as things go - you may want to start with a component-wise eval. However this may run the risk of premature optimization - making model selection or parameter choices without assessing the overall application needs. You may have to revisit these choices when creating your final application.

Diving Deeper into Evaluation[](#diving-deeper-into-evaluation "Permalink to this heading")
--------------------------------------------------------------------------------------------

Evaluation is a controversial topic, and as the field of NLP has evolved, so have the methods of evaluation.

In a world where powerful foundation models are now performing annotation tasks better than human annotators, the best practices around evaluation are constantly changing. Previous methods of evaluation which were used to bootstrap and evaluate today’s models such as BLEU or F1 have been shown to have poor correlation with human judgements, and need to be applied prudently.

Typically, generation-heavy, open-ended tasks and requiring judgement or opinion and harder to evaluate automatically than factual questions due to their subjective nature. We will aim to provide more guides and case-studies for which methods are appropriate in a given scenario.

### Standard Metrics[](#standard-metrics "Permalink to this heading")

Against annotated datasets, whether your own data or an academic benchmark, there are a number of standard metrics that it helps to be aware of:

1. **Exact Match (EM):** The percentage of queries that are answered exactly correctly.
2. **F1:** The percentage of queries that are answered exactly correctly or with a small edit distance (e.g. 1-2 words).
3. **Recall:** The percentage of queries that are answered correctly, regardless of the number of answers returned.
4. **Precision:** The percentage of queries that are answered correctly, divided by the number of answers returned.

This [towardsdatascience article](https://towardsdatascience.com/ranking-evaluation-metrics-for-recommender-systems-263d0a66ef54) covers more technical metrics like NDCG, MAP and MRR in greater depth.

Case Studies and Resources[](#case-studies-and-resources "Permalink to this heading")
--------------------------------------------------------------------------------------

1. (Course) [Data-Centric AI (MIT), 2023](https://www.youtube.com/playlist?list=PLnSYPjg2dHQKdig0vVbN-ZnEU0yNJ1mo5)
2. [Scale’s Approach to LLM Testing and Evaluation](https://scale.com/llm-test-evaluation)
3. [LLM Patterns by Eugene Yan](https://eugeneyan.com/writing/llm-patterns/)

* [Component Wise Evaluation](component_wise_evaluation.html)
	+ [Utilizing public benchmarks](component_wise_evaluation.html#utilizing-public-benchmarks)
	+ [Evaluating Retrieval](component_wise_evaluation.html#evaluating-retrieval)
		- [BEIR dataset](component_wise_evaluation.html#beir-dataset)
			* [BEIR Out of Domain Benchmark](../../examples/evaluation/BeirEvaluation.html)
	+ [Evaluating the Query Engine Components (e.g. Without Retrieval)](component_wise_evaluation.html#evaluating-the-query-engine-components-e-g-without-retrieval)
		- [HotpotQA Dataset](component_wise_evaluation.html#hotpotqa-dataset)
			* [HotpotQADistractor Demo](../../examples/evaluation/HotpotQADistractor.html)
* [End-to-End Evaluation](e2e_evaluation.html)
	+ [Setting up an Evaluation Set](e2e_evaluation.html#setting-up-an-evaluation-set)
		- [QuestionGeneration](../../examples/evaluation/QuestionGeneration.html)
	+ [The Spectrum of Evaluation Options](e2e_evaluation.html#the-spectrum-of-evaluation-options)
		- [BatchEvalRunner - Running Multiple Evaluations](../../examples/evaluation/batch_eval.html)
			* [Setup](../../examples/evaluation/batch_eval.html#setup)
			* [Question Generation](../../examples/evaluation/batch_eval.html#question-generation)
			* [Running Batch Evaluation](../../examples/evaluation/batch_eval.html#running-batch-evaluation)
			* [Inspecting Outputs](../../examples/evaluation/batch_eval.html#inspecting-outputs)
			* [Reporting Total Scores](../../examples/evaluation/batch_eval.html#reporting-total-scores)
		- [Correctness Evaluator](../../examples/evaluation/correctness_eval.html)
		- [Faithfulness Evaluator](../../examples/evaluation/faithfulness_eval.html)
			* [Benchmark on Generated Question](../../examples/evaluation/faithfulness_eval.html#benchmark-on-generated-question)
		- [Guideline Evaluator](../../examples/evaluation/guideline_eval.html)
		- [Pairwise Evaluator](../../examples/evaluation/pairwise_eval.html)
			* [Running on some more Queries](../../examples/evaluation/pairwise_eval.html#running-on-some-more-queries)
		- [Relevancy Evaluator](../../examples/evaluation/relevancy_eval.html)
			* [Evaluate Response](../../examples/evaluation/relevancy_eval.html#evaluate-response)
			* [Evaluate Source Nodes](../../examples/evaluation/relevancy_eval.html#evaluate-source-nodes)
		- [Embedding Similarity Evaluator](../../examples/evaluation/semantic_similarity_eval.html)
			* [Customization](../../examples/evaluation/semantic_similarity_eval.html#customization)
	+ [Discovery - Sensitivity Testing](e2e_evaluation.html#discovery-sensitivity-testing)
	+ [Metrics Ensembling](e2e_evaluation.html#metrics-ensembling)
