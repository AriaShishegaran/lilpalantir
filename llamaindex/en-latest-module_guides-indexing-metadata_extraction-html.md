Metadata Extraction[](#metadata-extraction "Permalink to this heading")
========================================================================

Introduction[](#introduction "Permalink to this heading")
----------------------------------------------------------

In many cases, especially with long documents, a chunk of text may lack the context necessary to disambiguate the chunk from other similar chunks of text.

To combat this, we use LLMs to extract certain contextual information relevant to the document to better help the retrieval and language models disambiguate similar-looking passages.

We show this in an [example notebook](https://github.com/jerryjliu/llama_index/blob/main/docs/examples/metadata_extraction/MetadataExtractionSEC.ipynb) and demonstrate its effectiveness in processing long documents.

Usage[](#usage "Permalink to this heading")
--------------------------------------------

First, we define a metadata extractor that takes in a list of feature extractors that will be processed in sequence.

We then feed this to the node parser, which will add the additional metadata to each node.


```
from llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.node\_parser.extractors import (    MetadataExtractor,    SummaryExtractor,    QuestionsAnsweredExtractor,    TitleExtractor,    KeywordExtractor,    EntityExtractor,)metadata\_extractor = MetadataExtractor(    extractors=[        TitleExtractor(nodes=5),        QuestionsAnsweredExtractor(questions=3),        SummaryExtractor(summaries=["prev", "self"]),        KeywordExtractor(keywords=10),        EntityExtractor(prediction\_threshold=0.5),    ],)node\_parser = SimpleNodeParser.from\_defaults(    metadata\_extractor=metadata\_extractor,)
```
Here is an sample of extracted metadata:


```
{'page\_label': '2', 'file\_name': '10k-132.pdf', 'document\_title': 'Uber Technologies, Inc. 2019 Annual Report: Revolutionizing Mobility and Logistics Across 69 Countries and 111 Million MAPCs with $65 Billion in Gross Bookings', 'questions\_this\_excerpt\_can\_answer': '\n\n1. How many countries does Uber Technologies, Inc. operate in?\n2. What is the total number of MAPCs served by Uber Technologies, Inc.?\n3. How much gross bookings did Uber Technologies, Inc. generate in 2019?', 'prev\_section\_summary': "\n\nThe 2019 Annual Report provides an overview of the key topics and entities that have been important to the organization over the past year. These include financial performance, operational highlights, customer satisfaction, employee engagement, and sustainability initiatives. It also provides an overview of the organization's strategic objectives and goals for the upcoming year.", 'section\_summary': '\nThis section discusses a global tech platform that serves multiple multi-trillion dollar markets with products leveraging core technology and infrastructure. It enables consumers and drivers to tap a button and get a ride or work. The platform has revolutionized personal mobility with ridesharing and is now leveraging its platform to redefine the massive meal delivery and logistics industries. The foundation of the platform is its massive network, leading technology, operational excellence, and product expertise.', 'excerpt\_keywords': '\nRidesharing, Mobility, Meal Delivery, Logistics, Network, Technology, Operational Excellence, Product Expertise, Point A, Point B'}
```
Custom Extractors[](#custom-extractors "Permalink to this heading")
--------------------------------------------------------------------

If the provided extractors do not fit your needs, you can also define a custom extractor like so:


```
from llama\_index.node\_parser.extractors import MetadataFeatureExtractorclass CustomExtractor(MetadataFeatureExtractor):    def extract(self, nodes) -> List[Dict]:        metadata\_list = [            {                "custom": node.metadata["document\_title"]                + "\n"                + node.metadata["excerpt\_keywords"]            }            for node in nodes        ]        return metadata\_list
```
In a more advanced example, it can also make use of an `llm` to extract features from the node content and the existing metadata. Refer to the [source code of the provided metadata extractors](https://github.com/jerryjliu/llama_index/blob/main/llama_index/node_parser/extractors/metadata_extractors.py) for more details.

