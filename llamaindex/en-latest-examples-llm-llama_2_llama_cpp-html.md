[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/llama_2_llama_cpp.ipynb)

LlamaCPP[](#llamacpp "Permalink to this heading")
==================================================

In this short notebook, we show how to use the [llama-cpp-python](https://github.com/abetlen/llama-cpp-python) library with LlamaIndex.

In this notebook, we use the [`llama-2-chat-13b-ggml`](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML) model, along with the proper prompt formatting.

Note that if you’re using a version of `llama-cpp-python` after version `0.1.79`, the model format has changed from `ggmlv3` to `gguf`. Old model files like the used in this notebook can be converted using scripts in the [`llama.cpp`](https://github.com/ggerganov/llama.cpp) repo. Alternatively, you can download the GGUF version of the model above from [huggingface](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF).

By default, if model\_path and model\_url are blank, the `LlamaCPP` module will load llama2-chat-13B in either format depending on your version.

Installation[](#installation "Permalink to this heading")
----------------------------------------------------------

To get the best performance out of `LlamaCPP`, it is recomended to install the package so that it is compilied with GPU support. A full guide for installing this way is [here](https://github.com/abetlen/llama-cpp-python#installation-with-openblas--cublas--clblast--metal).

Full MACOS instructions are also [here](https://llama-cpp-python.readthedocs.io/en/latest/install/macos/).

In general:

* Use `CuBLAS` if you have CUDA and an NVidia GPU
* Use `METAL` if you are running on an M1/M2 MacBook
* Use `CLBLAST` if you are running on an AMD/Intel GPU


```
from llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    ServiceContext,)from llama\_index.llms import LlamaCPPfrom llama\_index.llms.llama\_utils import (    messages\_to\_prompt,    completion\_to\_prompt,)
```
Setup LLM[](#setup-llm "Permalink to this heading")
----------------------------------------------------

The LlamaCPP llm is highly configurable. Depending on the model being used, you’ll want to pass in `messages\_to\_prompt` and `completion\_to\_prompt` functions to help format the model inputs.

Since the default model is llama2-chat, we use the util functions found in [`llama\_index.llms.llama\_utils`](https://github.com/jerryjliu/llama_index/blob/main/llama_index/llms/llama_utils.py).

For any kwargs that need to be passed in during initialization, set them in `model\_kwargs`. A full list of available model kwargs is available in the [LlamaCPP docs](https://llama-cpp-python.readthedocs.io/en/latest/api-reference/#llama_cpp.llama.Llama.__init__).

For any kwargs that need to be passed in during inference, you can set them in `generate\_kwargs`. See the full list of [generate kwargs here](https://llama-cpp-python.readthedocs.io/en/latest/api-reference/#llama_cpp.llama.Llama.__call__).

In general, the defaults are a great starting point. The example below shows configuration with all defaults.

As noted above, we’re using the [`llama-2-chat-13b-ggml`](https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML) model in this notebook which uses the `ggmlv3` model format. If you are running a version of `llama-cpp-python` greater than `0.1.79`, you can replace the `model\_url` below with `"https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q4\_0.gguf"`.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
model\_url = "https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML/resolve/main/llama-2-13b-chat.ggmlv3.q4\_0.bin"
```

```
llm = LlamaCPP(    # You can pass in the URL to a GGML model to download it automatically    model\_url=model\_url,    # optionally, you can set the path to a pre-downloaded model instead of model\_url    model\_path=None,    temperature=0.1,    max\_new\_tokens=256,    # llama2 has a context window of 4096 tokens, but we set it lower to allow for some wiggle room    context\_window=3900,    # kwargs to pass to \_\_call\_\_()    generate\_kwargs={},    # kwargs to pass to \_\_init\_\_()    # set to at least 1 to use GPU    model\_kwargs={"n\_gpu\_layers": 1},    # transform inputs into Llama2 format    messages\_to\_prompt=messages\_to\_prompt,    completion\_to\_prompt=completion\_to\_prompt,    verbose=True,)
```

```
llama.cpp: loading model from /Users/rchan/Library/Caches/llama_index/models/llama-2-13b-chat.ggmlv3.q4_0.binllama_model_load_internal: format     = ggjt v3 (latest)llama_model_load_internal: n_vocab    = 32000llama_model_load_internal: n_ctx      = 3900llama_model_load_internal: n_embd     = 5120llama_model_load_internal: n_mult     = 256llama_model_load_internal: n_head     = 40llama_model_load_internal: n_head_kv  = 40llama_model_load_internal: n_layer    = 40llama_model_load_internal: n_rot      = 128llama_model_load_internal: n_gqa      = 1llama_model_load_internal: rnorm_eps  = 5.0e-06llama_model_load_internal: n_ff       = 13824llama_model_load_internal: freq_base  = 10000.0llama_model_load_internal: freq_scale = 1llama_model_load_internal: ftype      = 2 (mostly Q4_0)llama_model_load_internal: model size = 13Bllama_model_load_internal: ggml ctx size =    0.11 MBllama_model_load_internal: mem required  = 6983.72 MB (+ 3046.88 MB per state)llama_new_context_with_model: kv self size  = 3046.88 MBggml_metal_init: allocatingggml_metal_init: loading '/Users/rchan/opt/miniconda3/envs/llama-index/lib/python3.10/site-packages/llama_cpp/ggml-metal.metal'ggml_metal_init: loaded kernel_add                            0x14ff4f060ggml_metal_init: loaded kernel_add_row                        0x14ff4f2c0ggml_metal_init: loaded kernel_mul                            0x14ff4f520ggml_metal_init: loaded kernel_mul_row                        0x14ff4f780ggml_metal_init: loaded kernel_scale                          0x14ff4f9e0ggml_metal_init: loaded kernel_silu                           0x14ff4fc40ggml_metal_init: loaded kernel_relu                           0x14ff4fea0ggml_metal_init: loaded kernel_gelu                           0x11f7aef50ggml_metal_init: loaded kernel_soft_max                       0x11f7af380ggml_metal_init: loaded kernel_diag_mask_inf                  0x11f7af5e0ggml_metal_init: loaded kernel_get_rows_f16                   0x11f7af840ggml_metal_init: loaded kernel_get_rows_q4_0                  0x11f7afaa0ggml_metal_init: loaded kernel_get_rows_q4_1                  0x13ffba0c0ggml_metal_init: loaded kernel_get_rows_q2_K                  0x13ffba320ggml_metal_init: loaded kernel_get_rows_q3_K                  0x13ffba580ggml_metal_init: loaded kernel_get_rows_q4_K                  0x13ffbaab0ggml_metal_init: loaded kernel_get_rows_q5_K                  0x13ffbaea0ggml_metal_init: loaded kernel_get_rows_q6_K                  0x13ffbb290ggml_metal_init: loaded kernel_rms_norm                       0x13ffbb690ggml_metal_init: loaded kernel_norm                           0x13ffbba80ggml_metal_init: loaded kernel_mul_mat_f16_f32                0x13ffbc070ggml_metal_init: loaded kernel_mul_mat_q4_0_f32               0x13ffbc510ggml_metal_init: loaded kernel_mul_mat_q4_1_f32               0x11f7aff40ggml_metal_init: loaded kernel_mul_mat_q2_K_f32               0x11f7b03e0ggml_metal_init: loaded kernel_mul_mat_q3_K_f32               0x11f7b0880ggml_metal_init: loaded kernel_mul_mat_q4_K_f32               0x11f7b0d20ggml_metal_init: loaded kernel_mul_mat_q5_K_f32               0x11f7b11c0ggml_metal_init: loaded kernel_mul_mat_q6_K_f32               0x11f7b1860ggml_metal_init: loaded kernel_mul_mm_f16_f32                 0x11f7b1d40ggml_metal_init: loaded kernel_mul_mm_q4_0_f32                0x11f7b2220ggml_metal_init: loaded kernel_mul_mm_q4_1_f32                0x11f7b2700ggml_metal_init: loaded kernel_mul_mm_q2_K_f32                0x11f7b2be0ggml_metal_init: loaded kernel_mul_mm_q3_K_f32                0x11f7b30c0ggml_metal_init: loaded kernel_mul_mm_q4_K_f32                0x11f7b35a0ggml_metal_init: loaded kernel_mul_mm_q5_K_f32                0x11f7b3a80ggml_metal_init: loaded kernel_mul_mm_q6_K_f32                0x11f7b3f60ggml_metal_init: loaded kernel_rope                           0x11f7b41c0ggml_metal_init: loaded kernel_alibi_f32                      0x11f7b47c0ggml_metal_init: loaded kernel_cpy_f32_f16                    0x11f7b4d90ggml_metal_init: loaded kernel_cpy_f32_f32                    0x11f7b5360ggml_metal_init: loaded kernel_cpy_f16_f16                    0x11f7b5930ggml_metal_init: recommendedMaxWorkingSetSize = 21845.34 MBggml_metal_init: hasUnifiedMemory             = trueggml_metal_init: maxTransferRate              = built-in GPUllama_new_context_with_model: compute buffer total size =  356.03 MBllama_new_context_with_model: max tensor size =    87.89 MBggml_metal_add_buffer: allocated 'data            ' buffer, size =  6984.06 MB, ( 6984.50 / 21845.34)ggml_metal_add_buffer: allocated 'eval            ' buffer, size =     1.36 MB, ( 6985.86 / 21845.34)ggml_metal_add_buffer: allocated 'kv              ' buffer, size =  3048.88 MB, (10034.73 / 21845.34)ggml_metal_add_buffer: allocated 'alloc           ' buffer, size =   354.70 MB, (10389.44 / 21845.34)AVX = 0 | AVX2 = 0 | AVX512 = 0 | AVX512_VBMI = 0 | AVX512_VNNI = 0 | FMA = 0 | NEON = 1 | ARM_FMA = 1 | F16C = 0 | FP16_VA = 1 | WASM_SIMD = 0 | BLAS = 1 | SSE3 = 0 | VSX = 0 | 
```
We can tell that the model is using `metal` due to the logging!

Start using our `LlamaCPP` LLM abstraction![](#start-using-our-llamacpp-llm-abstraction "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------

We can simply use the `complete` method of our `LlamaCPP` LLM abstraction to generate completions given a prompt.


```
response = llm.complete("Hello! Can you tell me a poem about cats and dogs?")print(response.text)
```

```
  Of course, I'd be happy to help! Here's a short poem about cats and dogs:Cats and dogs, so different yet the same,Both furry friends, with their own special game.Cats purr and curl up tight,Dogs wag their tails with delight.Cats hunt mice with stealthy grace,Dogs chase after balls with joyful pace.But despite their differences, they share,A love for play and a love so fair.So here's to our feline and canine friends,Both equally dear, and both equally grand.
```

```
llama_print_timings:        load time =  1204.19 msllama_print_timings:      sample time =   106.79 ms /   146 runs   (    0.73 ms per token,  1367.14 tokens per second)llama_print_timings: prompt eval time =  1204.14 ms /    81 tokens (   14.87 ms per token,    67.27 tokens per second)llama_print_timings:        eval time =  7468.88 ms /   145 runs   (   51.51 ms per token,    19.41 tokens per second)llama_print_timings:       total time =  8993.90 ms
```
We can use the `stream\_complete` endpoint to stream the response as it’s being generated rather than waiting for the entire response to be generated.


```
response\_iter = llm.stream\_complete("Can you write me a poem about fast cars?")for response in response\_iter:    print(response.delta, end="", flush=True)
```

```
Llama.generate: prefix-match hit
```

```
  Sure! Here's a poem about fast cars:Fast cars, sleek and strongRacing down the highway all day longTheir engines purring smooth and sweetAs they speed through the streetsTheir wheels grip the road with mightAs they take off like a shot in flightThe wind rushes past with a roarAs they leave all else behindWith paint that shines like the sunAnd lines that curve like a dreamThey're a sight to behold, my sonThese fast cars, so sleek and sereneSo if you ever see one passDon't be afraid to give a cheerFor these machines of speed and graceAre truly something to admire and revere.
```

```
llama_print_timings:        load time =  1204.19 msllama_print_timings:      sample time =   123.72 ms /   169 runs   (    0.73 ms per token,  1365.97 tokens per second)llama_print_timings: prompt eval time =   267.03 ms /    14 tokens (   19.07 ms per token,    52.43 tokens per second)llama_print_timings:        eval time =  8794.21 ms /   168 runs   (   52.35 ms per token,    19.10 tokens per second)llama_print_timings:       total time =  9485.38 ms
```
Query engine set up with LlamaCPP[](#query-engine-set-up-with-llamacpp "Permalink to this heading")
----------------------------------------------------------------------------------------------------

We can simply pass in the `LlamaCPP` LLM abstraction to the `LlamaIndex` query engine as usual:


```
# use Huggingface embeddingsfrom llama\_index.embeddings import HuggingFaceEmbeddingembed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en-v1.5")
```

```
# create a service contextservice\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embed\_model,)
```

```
# load documentsdocuments = SimpleDirectoryReader(    "../../../examples/paul\_graham\_essay/data").load\_data()
```

```
# create vector store indexindex = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
# set up query enginequery\_engine = index.as\_query\_engine()
```

```
response = query\_engine.query("What did the author do growing up?")print(response)
```

```
Llama.generate: prefix-match hit
```

```
  Based on the given context information, the author's childhood activities were writing short stories and programming. They wrote programs on punch cards using an early version of Fortran and later used a TRS-80 microcomputer to write simple games, a program to predict the height of model rockets, and a word processor that their father used to write at least one book.
```

```
llama_print_timings:        load time =  1204.19 msllama_print_timings:      sample time =    56.13 ms /    80 runs   (    0.70 ms per token,  1425.21 tokens per second)llama_print_timings: prompt eval time = 65280.71 ms /  2272 tokens (   28.73 ms per token,    34.80 tokens per second)llama_print_timings:        eval time =  6877.38 ms /    79 runs   (   87.06 ms per token,    11.49 tokens per second)llama_print_timings:       total time = 72315.85 ms
```
