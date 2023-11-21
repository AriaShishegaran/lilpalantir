[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/metadata_extraction/EntityExtractionClimate.ipynb)

Entity Metadata Extraction[](#entity-metadata-extraction "Permalink to this heading")
======================================================================================

In this demo, we use the new `EntityExtractor` to extract entities from each node, stored in metadata. The default model is `tomaarsen/span-marker-mbert-base-multinerd`, which is downloaded an run locally from [HuggingFace](https://huggingface.co/tomaarsen/span-marker-mbert-base-multinerd).

For more information on metadata extraction in LlamaIndex, see our [documentation](https://gpt-index.readthedocs.io/en/stable/core_modules/data_modules/documents_and_nodes/usage_metadata_extractor.html).

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Needed to run the entity extractor# !pip install span\_markerimport osimport openaios.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY"openai.api\_key = os.getenv("OPENAI\_API\_KEY")
```
Setup the Extractor and Parser[](#setup-the-extractor-and-parser "Permalink to this heading")
----------------------------------------------------------------------------------------------


```
from llama\_index.node\_parser.extractors.metadata\_extractors import (    MetadataExtractor,    EntityExtractor,)from llama\_index.node\_parser.simple import SimpleNodeParserentity\_extractor = EntityExtractor(    prediction\_threshold=0.5,    label\_entities=False,  # include the entity label in the metadata (can be erroneous)    device="cpu",  # set to "cuda" if you have a GPU)metadata\_extractor = MetadataExtractor(extractors=[entity\_extractor])node\_parser = SimpleNodeParser.from\_defaults(    metadata\_extractor=metadata\_extractor)
```

```
/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/tqdm/auto.py:22: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm/Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages/bitsandbytes/cextension.py:34: UserWarning: The installed version of bitsandbytes was compiled without GPU support. 8-bit optimizers, 8-bit multiplication, and GPU quantization are unavailable.  warn("The installed version of bitsandbytes was compiled without GPU support. "
```

```
'NoneType' object has no attribute 'cadam32bit_grad_fp32'
```
Load the data[](#load-the-data "Permalink to this heading")
------------------------------------------------------------

Here, we will download the 2023 IPPC Climate Report - Chapter 3 on Oceans and Coastal Ecosystems (172 Pages)


```
!curl https://www.ipcc.ch/report/ar6/wg2/downloads/report/IPCC_AR6_WGII_Chapter03.pdf --output IPCC_AR6_WGII_Chapter03.pdf
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current                                 Dload  Upload   Total   Spent    Left  Speed100 20.7M  100 20.7M    0     0  22.1M      0 --:--:-- --:--:-- --:--:-- 22.1M
```
Next, load the documents.


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader(    input\_files=["./IPCC\_AR6\_WGII\_Chapter03.pdf"]).load\_data()
```
Extracting Metadata[](#extracting-metadata "Permalink to this heading")
------------------------------------------------------------------------

Now, this is a pretty long document. Since we are not running on CPU, for now, we will only run on a subset of documents. Feel free to run it on all documents on your own though!


```
import randomrandom.seed(42)# comment out to run on all documents# 100 documents takes about 5 minutes on CPUdocuments = random.sample(documents, 100)nodes = node\_parser.get\_nodes\_from\_documents(documents)
```

```
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...To disable this warning, you can either:	- Avoid using `tokenizers` before the fork if possible	- Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)
```
### Examine the outputs[](#examine-the-outputs "Permalink to this heading")


```
samples = random.sample(nodes, 5)for node in samples:    print(node.metadata)
```

```
{'page_label': '387', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf'}{'page_label': '410', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf', 'entities': {'Parmesan', 'Boyd', 'Riebesell', 'Gattuso'}}{'page_label': '391', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf', 'entities': {'Gulev', 'Fox-Kemper'}}{'page_label': '430', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf', 'entities': {'Kessouri', 'van der Sleen', 'Brodeur', 'Siedlecki', 'Fiechter', 'Ramajo', 'Carozza'}}{'page_label': '388', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf'}
```
Try a Query![](#try-a-query "Permalink to this heading")
---------------------------------------------------------


```
from llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.llms import OpenAIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.2))index = VectorStoreIndex(nodes, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What is said by Fox-Kemper?")print(response)
```

```
According to the provided context information, Fox-Kemper is mentioned in relation to the observed and projected trends of ocean warming and marine heatwaves. It is stated that Fox-Kemper et al. (2021) reported that ocean warming has increased on average by 0.88°C from 1850-1900 to 2011-2020. Additionally, it is mentioned that Fox-Kemper et al. (2021) projected that ocean warming will continue throughout the 21st century, with the rate of global ocean warming becoming scenario-dependent from the mid-21st century. Fox-Kemper is also cited as a source for the information on the increasing frequency, intensity, and duration of marine heatwaves over the 20th and early 21st centuries, as well as the projected increase in frequency of marine heatwaves in the future.
```
### Contrast without metadata[](#contrast-without-metadata "Permalink to this heading")

Here, we re-construct the index, but without metadata


```
for node in nodes:    node.metadata.pop("entities", None)print(nodes[0].metadata)
```

```
{'page_label': '542', 'file_name': 'IPCC_AR6_WGII_Chapter03.pdf'}
```

```
from llama\_index import ServiceContext, VectorStoreIndexfrom llama\_index.llms import OpenAIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.2))index = VectorStoreIndex(nodes, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What is said by Fox-Kemper?")print(response)
```

```
According to the provided context information, Fox-Kemper is mentioned in relation to the decline of the AMOC (Atlantic Meridional Overturning Circulation) over the 21st century. The statement mentions that there is high confidence in the decline of the AMOC, but low confidence for quantitative projections.
```
As we can see, our metadata-enriched index is able to fetch more relevant information.

