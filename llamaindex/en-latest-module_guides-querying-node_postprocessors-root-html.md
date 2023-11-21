Node Postprocessor[](#node-postprocessor "Permalink to this heading")
======================================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Node postprocessors are a set of modules that take a set of nodes, and apply some kind of transformation or filtering before returning them.

In LlamaIndex, node postprocessors are most commonly applied within a query engine, after the node retrieval step and before the response synthesis step.

LlamaIndex offers several node postprocessors for immediate use, while also providing a simple API for adding your own custom postprocessors.

Tip

Confused about where node postprocessor fits in the pipeline? Read about [high-level concepts](../../../getting_started/concepts.html)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

An example of using a node postprocessors is below:


```
from llama\_index.indices.postprocessor import (    SimilarityPostprocessor,    CohereRerank,)from llama\_index.schema import Node, NodeWithScorenodes = [    NodeWithScore(node=Node(text="text1"), score=0.7),    NodeWithScore(node=Node(text="text2"), score=0.8),]# similarity postprocessor: filter nodes below 0.75 similarity scoreprocessor = SimilarityPostprocessor(similarity\_cutoff=0.75)filtered\_nodes = processor.postprocess\_nodes(nodes)# cohere rerank: rerank nodes given query using trained modelreranker = CohereRerank(api\_key="<COHERE\_API\_KEY>", top\_n=2)reranker.postprocess\_nodes(nodes, query\_str="<user\_query>")
```
Note that `postprocess\_nodes` can take in either a `query\_str` or `query\_bundle` (`QueryBundle`), though not both.

Usage Pattern[](#id1 "Permalink to this heading")
--------------------------------------------------

Most commonly, node-postprocessors will be used in a query engine, where they are applied to the nodes returned from a retriever, and before the response synthesis step.

Using with a Query Engine[](#using-with-a-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.indices.postprocessor import TimeWeightedPostprocessordocuments = SimpleDirectoryReader("./data").load\_data()index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine(    node\_postprocessors=[        TimeWeightedPostprocessor(            time\_decay=0.5, time\_access\_refresh=False, top\_k=1        )    ])# all node post-processors will be applied during each queryresponse = query\_engine.query("query string")
```
Using with Retrieved Nodes[](#using-with-retrieved-nodes "Permalink to this heading")
--------------------------------------------------------------------------------------

Or used as a standalone object for filtering retrieved nodes:


```
from llama\_index.indices.postprocessor import SimilarityPostprocessornodes = index.as\_retriever().retrieve("test query str")# filter nodes below 0.75 similarity scoreprocessor = SimilarityPostprocessor(similarity\_cutoff=0.75)filtered\_nodes = processor.postprocess\_nodes(nodes)
```
Using with your own nodes[](#using-with-your-own-nodes "Permalink to this heading")
------------------------------------------------------------------------------------

As you may have noticed, the postprocessors take `NodeWithScore` objects as inputs, which is just a wrapper class with a `Node` and a `score` value.


```
from llama\_index.indices.postprocessor import SimilarityPostprocessorfrom llama\_index.schema import Node, NodeWithScorenodes = [    NodeWithScore(node=Node(text="text"), score=0.7),    NodeWithScore(node=Node(text="text"), score=0.8),]# filter nodes below 0.75 similarity scoreprocessor = SimilarityPostprocessor(similarity\_cutoff=0.75)filtered\_nodes = processor.postprocess\_nodes(nodes)
```
Custom Node PostProcessor[](#custom-node-postprocessor "Permalink to this heading")
------------------------------------------------------------------------------------

The base class is `BaseNodePostprocessor`, and the API interface is very simple:


```
class BaseNodePostprocessor: """Node postprocessor."""    @abstractmethod    def \_postprocess\_nodes(        self, nodes: List[NodeWithScore], query\_bundle: Optional[QueryBundle]    ) -> List[NodeWithScore]: """Postprocess nodes."""
```
A dummy node-postprocessor can be implemented in just a few lines of code:


```
from llama\_index import QueryBundlefrom llama\_index.indices.postprocessor.base import BaseNodePostprocessorfrom llama\_index.schema import NodeWithScoreclass DummyNodePostprocessor:    def \_postprocess\_nodes(        self, nodes: List[NodeWithScore], query\_bundle: Optional[QueryBundle]    ) -> List[NodeWithScore]:        # subtracts 1 from the score        for n in nodes:            n.score -= 1        return nodes
```
Modules[](#modules "Permalink to this heading")
------------------------------------------------

* [Node Postprocessor Modules](node_postprocessors.html)
	+ [SimilarityPostprocessor](node_postprocessors.html#similaritypostprocessor)
	+ [KeywordNodePostprocessor](node_postprocessors.html#keywordnodepostprocessor)
	+ [MetadataReplacementPostProcessor](node_postprocessors.html#metadatareplacementpostprocessor)
	+ [LongContextReorder](node_postprocessors.html#longcontextreorder)
	+ [SentenceEmbeddingOptimizer](node_postprocessors.html#sentenceembeddingoptimizer)
	+ [CohereRerank](node_postprocessors.html#coherererank)
	+ [SentenceTransformerRerank](node_postprocessors.html#sentencetransformerrerank)
	+ [LLM Rerank](node_postprocessors.html#llm-rerank)
	+ [FixedRecencyPostprocessor](node_postprocessors.html#fixedrecencypostprocessor)
	+ [EmbeddingRecencyPostprocessor](node_postprocessors.html#embeddingrecencypostprocessor)
	+ [TimeWeightedPostprocessor](node_postprocessors.html#timeweightedpostprocessor)
	+ [(Beta) PIINodePostprocessor](node_postprocessors.html#beta-piinodepostprocessor)
	+ [(Beta) PrevNextNodePostprocessor](node_postprocessors.html#beta-prevnextnodepostprocessor)
	+ [(Beta) AutoPrevNextNodePostprocessor](node_postprocessors.html#beta-autoprevnextnodepostprocessor)
	+ [All Notebooks](node_postprocessors.html#all-notebooks)
