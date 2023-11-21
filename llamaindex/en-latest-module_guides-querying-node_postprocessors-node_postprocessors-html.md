Node Postprocessor Modules[](#node-postprocessor-modules "Permalink to this heading")
======================================================================================

SimilarityPostprocessor[](#similaritypostprocessor "Permalink to this heading")
--------------------------------------------------------------------------------

Used to remove nodes that are below a similarity score threshold.


```
from llama\_index.indices.postprocessor import SimilarityPostprocessorpostprocessor = SimilarityPostprocessor(similarity\_cutoff=0.7)postprocessor.postprocess\_nodes(nodes)
```
KeywordNodePostprocessor[](#keywordnodepostprocessor "Permalink to this heading")
----------------------------------------------------------------------------------

Used to ensure certain keywords are either excluded or included.


```
from llama\_index.indices.postprocessor import KeywordNodePostprocessorpostprocessor = KeywordNodePostprocessor(    required\_keywords=["word1", "word2"], exclude\_keywords=["word3", "word4"])postprocessor.postprocess\_nodes(nodes)
```
MetadataReplacementPostProcessor[](#metadatareplacementpostprocessor "Permalink to this heading")
--------------------------------------------------------------------------------------------------

Used to replace the node content with a field from the node metadata. If the field is not present in the metadata, then the node text remains unchanged. Most useful when used in combination with the `SentenceWindowNodeParser`.


```
from llama\_index.indices.postprocessor import MetadataReplacementPostProcessorpostprocessor = MetadataReplacementPostProcessor(    target\_metadata\_key="window",)postprocessor.postprocess\_nodes(nodes)
```
LongContextReorder[](#longcontextreorder "Permalink to this heading")
----------------------------------------------------------------------

Models struggle to access significant details found in the center of extended contexts. [A study](https://arxiv.org/abs/2307.03172) observed that the best performance typically arises when crucial data is positioned at the start or conclusion of the input context. Additionally, as the input context lengthens, performance drops notably, even in models designed for long contexts.

This module will re-order the retrieved nodes, which can be helpful in cases where a large top-k is needed.


```
from llama\_index.indices.postprocessor import LongContextReorderpostprocessor = LongContextReorder()postprocessor.postprocess\_nodes(nodes)
```
SentenceEmbeddingOptimizer[](#sentenceembeddingoptimizer "Permalink to this heading")
--------------------------------------------------------------------------------------

This postprocessor optimizes token usage by removing sentences that are not relevant to the query (this is done using embeddings).

The percentile cutoff is a measure for using the top percentage of relevant sentences.

The threshold cutoff can be specified instead, which uses a raw similarity cutoff for picking which sentences to keep.


```
from llama\_index.indices.postprocessor import SentenceEmbeddingOptimizerpostprocessor = SentenceEmbeddingOptimizer(    embed\_model=service\_context.embed\_model,    percentile\_cutoff=0.5,    # threshold\_cutoff=0.7)postprocessor.postprocess\_nodes(nodes)
```
A full notebook guide can be found [here](../../../examples/node_postprocessor/OptimizerDemo.html)

CohereRerank[](#coherererank "Permalink to this heading")
----------------------------------------------------------

Uses the “Cohere ReRank” functionality to re-order nodes, and returns the top N nodes.


```
from llama\_index.indices import CohereRerankpostprocessor = CohereRerank(    top\_n=2, model="rerank-english-v2.0", api\_key="YOUR COHERE API KEY")postprocessor.postprocess\_nodes(nodes)
```
Full notebook guide is available [here](../../../examples/node_postprocessor/CohereRerank.html).

SentenceTransformerRerank[](#sentencetransformerrerank "Permalink to this heading")
------------------------------------------------------------------------------------

Uses the cross-encoders from the `sentence-transformer` package to re-order nodes, and returns the top N nodes.


```
from llama\_index.indices.postprocessor import SentenceTransformerRerank# We choose a model with relatively high speed and decent accuracy.postprocessor = SentenceTransformerRerank(    model="cross-encoder/ms-marco-MiniLM-L-2-v2", top\_n=3)postprocessor.postprocess\_nodes(nodes)
```
Full notebook guide is available [here](../../../examples/node_postprocessor/SentenceTransformerRerank.html).

Please also refer to the [`sentence-transformer` docs](https://www.sbert.net/docs/pretrained-models/ce-msmarco.html) for a more complete list of models (and also shows tradeoffs in speed/accuracy). The default model is `cross-encoder/ms-marco-TinyBERT-L-2-v2`, which provides the most speed.

LLM Rerank[](#llm-rerank "Permalink to this heading")
------------------------------------------------------

Uses a LLM to re-order nodes by asking the LLM to return the relevant documents and a score of how relevant they are. Returns the top N ranked nodes.


```
from llama\_index.indices.postprocessor import LLMRerankpostprocessor = LLMRerank(top\_n=2, service\_context=service\_context)postprocessor.postprocess\_nodes(nodes)
```
Full notebook guide is available [her for Gatsby](../../../examples/node_postprocessor/LLMReranker-Gatsby.html) and [here for Lyft 10K documents](../../../examples/node_postprocessor/LLMReranker-Lyft-10k.html).

FixedRecencyPostprocessor[](#fixedrecencypostprocessor "Permalink to this heading")
------------------------------------------------------------------------------------

This postproccesor returns the top K nodes sorted by date. This assumes there is a `date` field to parse in the metadata of each node.


```
from llama\_index.indices.postprocessor import FixedRecencyPostprocessorpostprocessor = FixedRecencyPostprocessor(    tok\_k=1, date\_key="date"  # the key in the metadata to find the date)postprocessor.postprocess\_nodes(nodes)
```
![](../../../_images/recency.png)

A full notebook guide is available [here](../../../examples/node_postprocessor/RecencyPostprocessorDemo.html).

EmbeddingRecencyPostprocessor[](#embeddingrecencypostprocessor "Permalink to this heading")
--------------------------------------------------------------------------------------------

This postproccesor returns the top K nodes after sorting by date and removing older nodes that are too similar after measuring embedding similarity.


```
from llama\_index.indices.postprocessor import EmbeddingRecencyPostprocessorpostprocessor = EmbeddingRecencyPostprocessor(    service\_context=service\_context, date\_key="date", similarity\_cutoff=0.7)postprocessor.postprocess\_nodes(nodes)
```
A full notebook guide is available [here](../../../examples/node_postprocessor/RecencyPostprocessorDemo.html).

TimeWeightedPostprocessor[](#timeweightedpostprocessor "Permalink to this heading")
------------------------------------------------------------------------------------

This postproccesor returns the top K nodes applying a time-weighted rerank to each node. Each time a node is retrieved, the time it was retrieved is recorded. This biases search to favor information that has not be returned in a query yet.


```
from llama\_index.indices.postprocessor import TimeWeightedPostprocessorpostprocessor = TimeWeightedPostprocessor(time\_decay=0.99, top\_k=1)postprocessor.postprocess\_nodes(nodes)
```
A full notebook guide is available [here](../../../examples/node_postprocessor/TimeWeightedPostprocessorDemo.html).

(Beta) PIINodePostprocessor[](#beta-piinodepostprocessor "Permalink to this heading")
--------------------------------------------------------------------------------------

The PII (Personal Identifiable Information) postprocssor removes information that might be a security risk. It does this by using NER (either with a dedicated NER model, or with a local LLM model).

### LLM Version[](#llm-version "Permalink to this heading")


```
from llama\_index.indices.postprocessor import PIINodePostprocessorpostprocessor = PIINodePostprocessor(    service\_context=service\_context  # this should be setup with an LLM you trust)postprocessor.postprocess\_nodes(nodes)
```
### NER Version[](#ner-version "Permalink to this heading")

This version uses the default local model from Hugging Face that is loaded when you run `pipeline("ner")`.


```
from llama\_index.indices.postprocessor import NERPIINodePostprocessorpostprocessor = NERPIINodePostprocessor()postprocessor.postprocess\_nodes(nodes)
```
A full notebook guide for both can be found [here](../../../examples/node_postprocessor/PII.html).

(Beta) PrevNextNodePostprocessor[](#beta-prevnextnodepostprocessor "Permalink to this heading")
------------------------------------------------------------------------------------------------

Uses pre-defined settings to read the `Node` relationships and fetch either all nodes that come previously, next, or both.

This is useful when you know the relationships point to important data (either before, after, or both) that should be sent to the LLM if that node is retrieved.


```
from llama\_index.indices.postprocessor import PrevNextNodePostprocessorpostprocessor = PrevNextNodePostprocessor(    docstore=index.docstore,    num\_nodes=1,  # number of nodes to fetch when looking forawrds or backwards    mode="next",  # can be either 'next', 'previous', or 'both')postprocessor.postprocess\_nodes(nodes)
```
![](../../../_images/prev_next.png)

(Beta) AutoPrevNextNodePostprocessor[](#beta-autoprevnextnodepostprocessor "Permalink to this heading")
--------------------------------------------------------------------------------------------------------

The same as PrevNextNodePostprocessor, but lets the LLM decide the mode (next, previous, or both).


```
from llama\_index.indices.postprocessor import AutoPrevNextNodePostprocessorpostprocessor = AutoPrevNextNodePostprocessor(    docstore=index.docstore,    service\_context=service\_context,    num\_nodes=1,  # number of nodes to fetch when looking forawrds or backwards))postprocessor.postprocess\_nodes(nodes)
```
A full example notebook is available [here](../../../examples/node_postprocessor/PrevNextPostprocessorDemo.html).

All Notebooks[](#all-notebooks "Permalink to this heading")
------------------------------------------------------------

* [Sentence Embedding Optimizer](../../../examples/node_postprocessor/OptimizerDemo.html)
* [Cohere Rerank](../../../examples/node_postprocessor/CohereRerank.html)
* [LLM Reranker Demonstration (2021 Lyft 10-k)](../../../examples/node_postprocessor/LLMReranker-Lyft-10k.html)
* [LLM Reranker Demonstration (Great Gatsby)](../../../examples/node_postprocessor/LLMReranker-Gatsby.html)
* [Recency Filtering](../../../examples/node_postprocessor/RecencyPostprocessorDemo.html)
* [Time-Weighted Rerank](../../../examples/node_postprocessor/TimeWeightedPostprocessorDemo.html)
* [PII Masking](../../../examples/node_postprocessor/PII.html)
* [Forward/Backward Augmentation](../../../examples/node_postprocessor/PrevNextPostprocessorDemo.html)
* [Metadata Replacement + Node Sentence Window](../../../examples/node_postprocessor/MetadataReplacementDemo.html)
* [LongContextReorder](../../../examples/node_postprocessor/LongContextReorder.html)
