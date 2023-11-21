[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/customization/llms/SimpleIndexDemo-Huggingface_stablelm.ipynb)

HuggingFace LLM - StableLM[](#huggingface-llm-stablelm "Permalink to this heading")
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
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```

```
# setup prompts - specific to StableLMfrom llama\_index.prompts import PromptTemplatesystem\_prompt = """<|SYSTEM|># StableLM Tuned (Alpha version)- StableLM is a helpful and harmless open-source AI language model developed by StabilityAI.- StableLM is excited to be able to help the user, but will refuse to do anything that could be considered harmful to the user.- StableLM is more than just an information source, StableLM is also able to write poetry, short stories, and make jokes.- StableLM will refuse to participate in anything that could harm a human."""# This will wrap the default prompts that are internal to llama-indexquery\_wrapper\_prompt = PromptTemplate("<|USER|>{query\_str}<|ASSISTANT|>")
```

```
import torchllm = HuggingFaceLLM(    context\_window=4096,    max\_new\_tokens=256,    generate\_kwargs={"temperature": 0.7, "do\_sample": False},    system\_prompt=system\_prompt,    query\_wrapper\_prompt=query\_wrapper\_prompt,    tokenizer\_name="StabilityAI/stablelm-tuned-alpha-3b",    model\_name="StabilityAI/stablelm-tuned-alpha-3b",    device\_map="auto",    stopping\_ids=[50278, 50279, 50277, 1, 0],    tokenizer\_kwargs={"max\_length": 4096},    # uncomment this if using CUDA to reduce memory usage    # model\_kwargs={"torch\_dtype": torch.float16})service\_context = ServiceContext.from\_defaults(chunk\_size=1024, llm=llm)
```

```
Loading checkpoint shards: 100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 2/2 [00:24<00:00, 12.21s/it]
```

```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 20729 tokens> [build_index_from_nodes] Total embedding token usage: 20729 tokens
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
Setting `pad_token_id` to `eos_token_id`:0 for open-end generation.
```

```
INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2126 tokens> [get_response] Total LLM token usage: 2126 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(response)
```

```
The author is a computer scientist who has written several books on programming languages and software development. He worked on the IBM 1401 and wrote a program to calculate pi. He also wrote a program to predict how high a rocket ship would fly. The program was written in Fortran and used a TRS-80 microcomputer. The author is a PhD student and has been working on multiple projects, including a novel and a PBS documentary. He is envious of the author's work and feels that he has made significant contributions to the field of computer science. He is working on multiple projects and is envious of the author's work. He is also interested in learning Italian and is considering taking the entrance exam in Florence. The author is not aware of how he managed to pass the written exam and is not sure how he will manage to do so.
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
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 8 tokens> [retrieve] Total embedding token usage: 8 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 0 tokens
```

```
Setting `pad_token_id` to `eos_token_id`:0 for open-end generation.
```

```
> [get_response] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
# can be slower to start streaming since llama-index often involves many LLM callsresponse\_stream.print\_response\_stream()
```

```
The author is a computer scientist who has written several books on programming languages and software development. He worked on the IBM 1401 and wrote a program to calculate pi. He also wrote a program to predict how high a rocket ship would fly. The program was written in Fortran and used a TRS-80 microcomputer. The author is a PhD student and has been working on multiple projects, including a novel and a PBS documentary. He is envious of the author's work and feels that he has made significant contributions to the field of computer science. He is working on multiple projects and is envious of the author's work. He is also interested in learning Italian and is considering taking the entrance exam in Florence. The author is not aware of how he managed to pass the written exam and is not sure how he will manage to do so.<|USER|>
```

```
# can also get a normal response objectresponse = response\_stream.get\_response()print(response)
```

```
# can also iterate over the generator yourselfgenerated\_text = ""for text in response.response\_gen:    generated\_text += text
```
