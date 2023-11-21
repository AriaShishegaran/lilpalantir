[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/metadata_extraction/PydanticExtractor.ipynb)

Pydantic Extractor[](#pydantic-extractor "Permalink to this heading")
======================================================================

Here we test out the capabilities of our `PydanticProgramExtractor` - being able to extract out an entire Pydantic object using an LLM (either a standard text completion LLM or a function calling LLM).

The advantage of this over using a “single” metadata extractor is that we can extract multiple entities with a single LLM call.

Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
import nest\_asyncionest\_asyncio.apply()import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY"openai.api\_key = os.getenv("OPENAI\_API\_KEY")
```
### Setup the Pydantic Model[](#setup-the-pydantic-model "Permalink to this heading")

Here we define a basic structured schema that we want to extract. It contains:

* entities: unique entities in a text chunk
* summary: a concise summary of the text chunk
* contains\_number: whether the chunk contains numbers

This is obviously a toy schema. We’d encourage you to be creative about the type of metadata you’d want to extract!


```
from pydantic import BaseModel, Fieldfrom typing import List
```

```
class NodeMetadata(BaseModel): """Node metadata."""    entities: List[str] = Field(        ..., description="Unique entities in this text chunk."    )    summary: str = Field(        ..., description="A concise summary of this text chunk."    )    contains\_number: bool = Field(        ...,        description=(            "Whether the text chunk contains any numbers (ints, floats, etc.)"        ),    )
```
### Setup the Extractor[](#setup-the-extractor "Permalink to this heading")

Here we setup the metadata extractor. Note that we provide the prompt template for visibility into what’s going on.


```
from llama\_index.program.openai\_program import OpenAIPydanticProgramfrom llama\_index.node\_parser.extractors import (    PydanticProgramExtractor,    MetadataExtractor,)EXTRACT\_TEMPLATE\_STR = """\Here is the content of the section:----------------{context\_str}----------------Given the contextual information, extract out a {class\_name} object.\"""openai\_program = OpenAIPydanticProgram.from\_defaults(    output\_cls=NodeMetadata,    prompt\_template\_str="{input}",    # extract\_template\_str=EXTRACT\_TEMPLATE\_STR)program\_extractor = PydanticProgramExtractor(    program=openai\_program, input\_key="input", show\_progress=True)metadata\_extractor = MetadataExtractor(extractors=[program\_extractor])
```
### Load in Data[](#load-in-data "Permalink to this heading")

We load in Eugene’s essay (https://eugeneyan.com/writing/llm-patterns/) using our LlamaHub SimpleWebPageReader.


```
# load in blogfrom llama\_hub.web.simple\_web.base import SimpleWebPageReaderfrom llama\_index.node\_parser import SimpleNodeParserreader = SimpleWebPageReader(html\_to\_text=True)docs = reader.load\_data(urls=["https://eugeneyan.com/writing/llm-patterns/"])
```

```
node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024)orig\_nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
orig\_nodes
```
Extract Metadata[](#extract-metadata "Permalink to this heading")
------------------------------------------------------------------

Now that we’ve setup the metadata extractor and the data, we’re ready to extract some metadata!

We see that the pydantic feature extractor is able to extract *all* metadata from a given chunk in a single LLM call.


```
sample\_entry = program\_extractor.extract(orig\_nodes[0:1])[0]
```

```
display(sample\_entry)
```

```
{'entities': ['eugeneyan', 'HackerNews', 'Karpathy'], 'summary': 'This section discusses practical patterns for integrating large language models (LLMs) into systems & products. It introduces seven key patterns and provides information on evaluations and benchmarks in the field of language modeling.', 'contains_number': True}
```

```
new\_nodes = metadata\_extractor.process\_nodes(orig\_nodes)
```

```
display(new\_nodes[5:7])
```
