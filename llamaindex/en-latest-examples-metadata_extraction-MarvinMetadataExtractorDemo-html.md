Metadata Extraction and Augmentation w/ Marvin[](#metadata-extraction-and-augmentation-w-marvin "Permalink to this heading")
=============================================================================================================================

This notebook walks through using [`Marvin`](https://github.com/PrefectHQ/marvin) to extract and augment metadata from text. Marvin uses the LLM to identify and extract metadata. Metadata can be anything from additional and enhanced questions and answers to business object identification and elaboration. This notebook will demonstrate pulling out and elaborating on Sports Supplement information in a csv document.

Note: You will need to supply a valid open ai key below to run this notebook.

Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
# !pip install marvin
```

```
from llama\_index import SimpleDirectoryReaderfrom llama\_index.indices.service\_context import ServiceContextfrom llama\_index.llms import OpenAIfrom llama\_index.node\_parser import SimpleNodeParserfrom llama\_index.node\_parser.extractors import (    MetadataExtractor,)from llama\_index.text\_splitter import TokenTextSplitterfrom llama\_index.node\_parser.extractors.marvin\_metadata\_extractor import (    MarvinMetadataExtractor,)
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
documents = SimpleDirectoryReader("data").load\_data()# limit document text lengthdocuments[0].text = documents[0].text[:10000]
```

```
import marvinfrom marvin import ai\_modelfrom llama\_index.bridge.pydantic import BaseModel, Fieldmarvin.settings.openai.api\_key = os.environ["OPENAI\_API\_KEY"]@ai\_modelclass SportsSupplement(BaseModel):    name: str = Field(..., description="The name of the sports supplement")    description: str = Field(        ..., description="A description of the sports supplement"    )    pros\_cons: str = Field(        ..., description="The pros and cons of the sports supplement"    )
```

```
llm\_model = "gpt-3.5-turbo"llm = OpenAI(temperature=0.1, model\_name=llm\_model, max\_tokens=512)service\_context = ServiceContext.from\_defaults(llm=llm)# construct text splitter to split texts into chunks for processing# this takes a while to process, you can increase processing time by using larger chunk\_size# file size is a factor too of coursetext\_splitter = TokenTextSplitter(    separator=" ", chunk\_size=512, chunk\_overlap=128)# set the global service context object, avoiding passing service\_context when building the indexfrom llama\_index import set\_global\_service\_contextset\_global\_service\_context(service\_context)# create metadata extractormetadata\_extractor = MetadataExtractor(    extractors=[        MarvinMetadataExtractor(            marvin\_model=SportsSupplement, llm\_model\_string=llm\_model        ),  # let's extract custom entities for each node.    ],)# create node parser to parse nodes from documentnode\_parser = SimpleNodeParser(    text\_splitter=text\_splitter,    metadata\_extractor=metadata\_extractor,)# use node\_parser to get nodes from the documentsnodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
from pprint import pprintfor i in range(5):    pprint(nodes[i].metadata)
```

```
{'marvin_metadata': {'description': 'L-arginine alpha-ketoglutarate',                     'name': 'AAKG',                     'pros_cons': '1.0, peak power output, strength–power, '                                  'weight training, OTW, 242, 1, 20, nan, A '                                  '2006 study found AAKG supplementation '                                  'improved maximum effort 1-repetition bench '                                  'press and Wingate peak power performance.'}}{'marvin_metadata': {'description': 'Gulping down baking soda (sodium '                                    'bicarbonate) makes the blood more '                                    'alkaline, improving performance in '                                    'lactic-acid-fueled events like the 800m '                                    'sprint.',                     'name': 'Baking soda',                     'pros_cons': 'Downside: a badly upset stomach.'}}{'marvin_metadata': {'description': 'Branched-chain amino acids (BCAAs) are a '                                    'group of essential amino acids that '                                    'include leucine, isoleucine, and valine. '                                    'They are commonly used as a sports '                                    'supplement to improve fatigue resistance '                                    'and aerobic endurance during activities '                                    'such as cycling and circuit training.',                     'name': 'BCAAs',                     'pros_cons': 'Pros: BCAAs can improve fatigue resistance '                                  'and enhance aerobic endurance. Cons: '                                  'Limited evidence on their effectiveness and '                                  'potential side effects.'}}{'marvin_metadata': {'description': 'Branched-chain amino acids (BCAAs) are a '                                    'group of three essential amino acids: '                                    'leucine, isoleucine, and valine. They are '                                    'commonly used as a sports supplement to '                                    'improve aerobic performance, endurance, '                                    'power, and strength. BCAAs can be '                                    'beneficial for both aerobic-endurance and '                                    'strength-power activities, such as '                                    'cycling and circuit training.',                     'name': 'Branched-chain amino acids',                     'pros_cons': 'Pros: BCAAs have been shown to improve '                                  'aerobic performance, reduce muscle '                                  'soreness, and enhance muscle protein '                                  'synthesis. Cons: BCAAs may not be effective '                                  'for everyone, and excessive intake can lead '                                  'to an imbalance in amino acids.'}}{'marvin_metadata': {'description': 'Branched-chain amino acids (BCAAs) are a '                                    'group of three essential amino acids: '                                    'leucine, isoleucine, and valine. They are '                                    'commonly used as a sports supplement to '                                    'improve immune defenses in athletes and '                                    'promote general fitness. BCAAs are often '                                    'used by runners and athletes in other '                                    'sports.',                     'name': 'BCAAs',                     'pros_cons': 'Pros: - Can enhance immune defenses in '                                  'athletes\n'                                  '- May improve general fitness\n'                                  'Cons: - Limited evidence for their '                                  'effectiveness\n'                                  '- Potential side effects'}}
```
