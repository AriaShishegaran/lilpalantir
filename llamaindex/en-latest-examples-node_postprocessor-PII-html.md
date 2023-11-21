[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/PII.ipynb)

PII Masking[](#pii-masking "Permalink to this heading")
========================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index.indices.postprocessor import (    PIINodePostprocessor,    NERPIINodePostprocessor,)from llama\_index.llms import HuggingFaceLLMfrom llama\_index import ServiceContext, Document, VectorStoreIndexfrom llama\_index.schema import TextNode
```

```
INFO:numexpr.utils:Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```

```
# load documentstext = """Hello Paulo Santos. The latest statement for your credit card account \1111-0000-1111-0000 was mailed to 123 Any Street, Seattle, WA 98109."""node = TextNode(text=text)
```
Option 1: Use NER Model for PII Masking[](#option-1-use-ner-model-for-pii-masking "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------

Use a Hugging Face NER model for PII Masking


```
service\_context = ServiceContext.from\_defaults()processor = NERPIINodePostprocessor(service\_context=service\_context)
```

```
from llama\_index.schema import NodeWithScorenew\_nodes = processor.postprocess\_nodes([NodeWithScore(node=node)])
```

```
No model was supplied, defaulted to dbmdz/bert-large-cased-finetuned-conll03-english and revision f2482bf (https://huggingface.co/dbmdz/bert-large-cased-finetuned-conll03-english).Using a pipeline without specifying a model name and revision in production is not recommended./home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/transformers/pipelines/token_classification.py:169: UserWarning: `grouped_entities` is deprecated and will be removed in version v5.0.0, defaulted to `aggregation_strategy="AggregationStrategy.SIMPLE"` instead.  warnings.warn(
```

```
# view redacted textnew\_nodes[0].node.get\_text()
```

```
'Hello [ORG_6]. The latest statement for your credit card account 1111-0000-1111-0000 was mailed to 123 [ORG_108] [LOC_112], [LOC_120], [LOC_129] 98109.'
```

```
# get mapping in metadata# NOTE: this is not sent to the LLM!new\_nodes[0].node.metadata["\_\_pii\_node\_info\_\_"]
```

```
{'[ORG_6]': 'Paulo Santos', '[ORG_108]': 'Any', '[LOC_112]': 'Street', '[LOC_120]': 'Seattle', '[LOC_129]': 'WA'}
```
Option 2: Use LLM for PII Masking[](#option-2-use-llm-for-pii-masking "Permalink to this heading")
---------------------------------------------------------------------------------------------------

NOTE: You should be using a *local* LLM model for PII masking. The example shown is using OpenAI, but normally you’d use an LLM running locally, possibly from huggingface. Examples for local LLMs are [here](https://gpt-index.readthedocs.io/en/latest/how_to/customization/custom_llms.html#example-using-a-huggingface-llm).


```
service\_context = ServiceContext.from\_defaults()processor = PIINodePostprocessor(service\_context=service\_context)
```

```
from llama\_index.schema import NodeWithScorenew\_nodes = processor.postprocess\_nodes([NodeWithScore(node=node)])
```

```
# view redacted textnew\_nodes[0].node.get\_text()
```

```
'Hello [NAME]. The latest statement for your credit card account [CREDIT_CARD_NUMBER] was mailed to [ADDRESS].'
```

```
# get mapping in metadata# NOTE: this is not sent to the LLM!new\_nodes[0].node.metadata["\_\_pii\_node\_info\_\_"]
```

```
{'NAME': 'Paulo Santos', 'CREDIT_CARD_NUMBER': '1111-0000-1111-0000', 'ADDRESS': '123 Any Street, Seattle, WA 98109'}
```
Feed Nodes to Index[](#feed-nodes-to-index "Permalink to this heading")
------------------------------------------------------------------------


```
# feed into indexindex = VectorStoreIndex([n.node for n in new\_nodes])
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 30 tokens> [build_index_from_nodes] Total embedding token usage: 30 tokens
```

```
response = index.as\_query\_engine().query(    "What address was the statement mailed to?")print(str(response))
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 71 tokens> [get_response] Total LLM token usage: 71 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens[ADDRESS]
```
