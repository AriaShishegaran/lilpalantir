Automated Metadata Extraction for Nodes[](#automated-metadata-extraction-for-nodes "Permalink to this heading")
================================================================================================================

You can use LLMs to automate metadata extraction with our `MetadataExtractor` modules.

Our metadata extractor modules include the following “feature extractors”:

* `SummaryExtractor` - automatically extracts a summary over a set of Nodes
* `QuestionsAnsweredExtractor` - extracts a set of questions that each Node can answer
* `TitleExtractor` - extracts a title over the context of each Node
* `EntityExtractor` - extracts entities (i.e. names of places, people, things) mentioned in the content of each Node

You can use these feature extractors within our overall `MetadataExtractor` class. Then you can plug in the `MetadataExtractor` into our node parser:


```
from llama\_index.node\_parser.extractors import (    MetadataExtractor,    TitleExtractor,    QuestionsAnsweredExtractor,)from llama\_index.text\_splitter import TokenTextSplittertext\_splitter = TokenTextSplitter(    separator=" ", chunk\_size=512, chunk\_overlap=128)metadata\_extractor = MetadataExtractor(    extractors=[        TitleExtractor(nodes=5),        QuestionsAnsweredExtractor(questions=3),    ],)node\_parser = SimpleNodeParser.from\_defaults(    text\_splitter=text\_splitter,    metadata\_extractor=metadata\_extractor,)# assume documents are defined -> extract nodesnodes = node\_parser.get\_nodes\_from\_documents(documents)
```
Metadata Extraction Guides

* [Extracting Metadata for Better Document Indexing and Understanding](../../../examples/metadata_extraction/MetadataExtractionSEC.html)
* [Automated Metadata Extraction for Better Retrieval + Synthesis](../../../examples/metadata_extraction/MetadataExtraction_LLMSurvey.html)
* [Entity Metadata Extraction](../../../examples/metadata_extraction/EntityExtractionClimate.html)
* [Metadata Extraction and Augmentation w/ Marvin](../../../examples/metadata_extraction/MarvinMetadataExtractorDemo.html)
* [Pydantic Extractor](../../../examples/metadata_extraction/PydanticExtractor.html)
