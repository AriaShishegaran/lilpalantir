[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/customization/llms/SimpleIndexDemo-Huggingface_camel.ipynb)

HuggingFace LLM - Camel-5b[](#huggingface-llm-camel-5b "Permalink to this heading")
====================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import HuggingFaceLLM
```

```
INFO:numexpr.utils:Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```

```
/home/loganm/miniconda3/envs/gpt_index/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
# setup prompts - specific to StableLMfrom llama\_index.prompts import PromptTemplate# This will wrap the default prompts that are internal to llama-index# taken from https://huggingface.co/Writer/camel-5b-hfquery\_wrapper\_prompt = PromptTemplate(    "Below is an instruction that describes a task. "    "Write a response that appropriately completes the request.\n\n"    "### Instruction:\n{query\_str}\n\n### Response:")
```

```
import torchllm = HuggingFaceLLM(    context\_window=2048,    max\_new\_tokens=256,    generate\_kwargs={"temperature": 0.25, "do\_sample": False},    query\_wrapper\_prompt=query\_wrapper\_prompt,    tokenizer\_name="Writer/camel-5b-hf",    model\_name="Writer/camel-5b-hf",    device\_map="auto",    tokenizer\_kwargs={"max\_length": 2048},    # uncomment this if using CUDA to reduce memory usage    # model\_kwargs={"torch\_dtype": torch.float16})service\_context = ServiceContext.from\_defaults(chunk\_size=512, llm=llm)
```

```
Loading checkpoint shards: 100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 3/3 [00:43<00:00, 14.34s/it]
```

```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 27212 tokens> [build_index_from_nodes] Total embedding token usage: 27212 tokens
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokens
```

```
Token indices sequence length is longer than the specified maximum sequence length for this model (954 > 512). Running this sequence through the model will result in indexing errorsSetting `pad_token_id` to `eos_token_id`:50256 for open-end generation.
```

```
INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1026 tokens> [get_response] Total LLM token usage: 1026 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(response)
```

```
The author grew up in a small town in England, attended a prestigious private school, and then went to Cambridge University, where he studied computer science. Afterward, he worked on web infrastructure, wrote essays, and then realized he could write about startups. He then started giving talks, wrote a book, and started interviewing founders for a book on startups.
```
Query Index - Streaming[](#query-index-streaming "Permalink to this heading")
------------------------------------------------------------------------------


```
query\_engine = index.as\_query\_engine(streaming=True)
```

```
# set Logging to DEBUG for more detailed outputsresponse\_stream = query\_engine.query("What did the author do growing up?")
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokens
```

```
Setting `pad_token_id` to `eos_token_id`:50256 for open-end generation.
```

```
INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 0 tokens> [get_response] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
# can be slower to start streaming since llama-index often involves many LLM callsresponse\_stream.print\_response\_stream()
```

```
The author grew up in a small town in England, attended a prestigious private school, and then went to Cambridge University, where he studied computer science. Afterward, he worked on web infrastructure, wrote essays, and then realized he could write about startups. He then started giving talks, wrote a book, and started interviewing founders for a book on startups.<|endoftext|>
```

```
# can also get a normal response objectresponse = response\_stream.get\_response()print(response)
```

```
# can also iterate over the generator yourselfgenerated\_text = ""for text in response.response\_gen:    generated\_text += text
```
