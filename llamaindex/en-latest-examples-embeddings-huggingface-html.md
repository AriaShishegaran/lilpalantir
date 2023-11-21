[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/huggingface.ipynb)

Local Embeddings with HuggingFace[](#local-embeddings-with-huggingface "Permalink to this heading")
====================================================================================================

LlamaIndex has support for HuggingFace embedding models, including BGE, Instructor, and more.

Furthermore, we provide utilties to create and use ONNX models using the [Optimum library](https://huggingface.co/docs/transformers/serialization#exporting-a-transformers-model-to-onnx-with-optimumonnxruntime) from HuggingFace.

HuggingFaceEmbedding[](#huggingfaceembedding "Permalink to this heading")
--------------------------------------------------------------------------

The base `HuggingFaceEmbedding` class is a generic wrapper around any HuggingFace model for embeddings. You can set either `pooling="cls"` or `pooling="mean"` – in most cases, you’ll want `cls` pooling. But the model card for your particular model may have other recommendations.

You can refer to the [embeddings leaderboard](https://huggingface.co/spaces/mteb/leaderboard) for more recommendations on embedding models.

This class depends on the transformers package, which you can install with `pip install transformers`.

NOTE: if you were previously using a `HuggingFaceEmbeddings` from LangChain, this should give equivilant results.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.embeddings import HuggingFaceEmbedding# loads BAAI/bge-small-en# embed\_model = HuggingFaceEmbedding()# loads BAAI/bge-small-en-v1.5embed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en-v1.5")
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/torch/cuda/__init__.py:546: UserWarning: Can't initialize NVML  warnings.warn("Can't initialize NVML")
```

```
embeddings = embed\_model.get\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```

```
Hello World!384[-0.030880315229296684, -0.11021008342504501, 0.3917851448059082, -0.35962796211242676, 0.22797748446464539]
```
InstructorEmbedding[](#instructorembedding "Permalink to this heading")
------------------------------------------------------------------------

Instructor Embeddings are a class of embeddings specifically trained to augment their embeddings according to an instruction. By default, queries are given `query\_instruction="Represent the question for retrieving supporting documents: "` and text is given `text\_instruction="Represent the document for retrieval: "`.

They rely on the `Instructor` pip package, which you can install with `pip install InstructorEmbedding`.


```
from llama\_index.embeddings import InstructorEmbeddingembed\_model = InstructorEmbedding(model\_name="hkunlp/instructor-base")
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/InstructorEmbedding/instructor.py:7: TqdmExperimentalWarning: Using `tqdm.autonotebook.tqdm` in notebook mode. Use `tqdm.tqdm` instead to force console mode (e.g. in jupyter console)  from tqdm.autonotebook import trange
```

```
load INSTRUCTOR_Transformer
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/torch/cuda/__init__.py:546: UserWarning: Can't initialize NVML  warnings.warn("Can't initialize NVML")
```

```
max_seq_length  512
```

```
embeddings = embed\_model.get\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```

```
768[ 0.02155361 -0.06098218  0.01796207  0.05490903  0.01526906]
```
OptimumEmbedding[](#optimumembedding "Permalink to this heading")
------------------------------------------------------------------

Optimum in a HuggingFace library for exporting and running HuggingFace models in the ONNX format.

You can install the dependencies with `pip install transformers optimum[exporters]`.

First, we need to create the ONNX model. ONNX models provide improved inference speeds, and can be used across platforms (i.e. in TransformersJS)


```
from llama\_index.embeddings import OptimumEmbeddingOptimumEmbedding.create\_and\_save\_optimum\_model(    "BAAI/bge-small-en-v1.5", "./bge\_onnx")
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/torch/cuda/__init__.py:546: UserWarning: Can't initialize NVML  warnings.warn("Can't initialize NVML")Framework not specified. Using pt to export to ONNX.Using the export variant default. Available variants are:	- default: The default ONNX variant.Using framework PyTorch: 2.0.1+cu117Overriding 1 configuration item(s)	- use_cache -> False
```

```
============= Diagnostic Run torch.onnx.export version 2.0.1+cu117 =============verbose: False, log level: Level.ERROR======================= 0 NONE 0 NOTE 0 WARNING 0 ERROR ========================Saved optimum model to ./bge_onnx. Use it with `embed_model = OptimumEmbedding(folder_name='./bge_onnx')`.
```

```
embed\_model = OptimumEmbedding(folder\_name="./bge\_onnx")
```

```
embeddings = embed\_model.get\_text\_embedding("Hello World!")print(len(embeddings))print(embeddings[:5])
```

```
384[-0.10364960134029388, -0.20998482406139374, -0.01883639395236969, -0.5241696834564209, 0.0335749015212059]
```
Benchmarking[](#benchmarking "Permalink to this heading")
----------------------------------------------------------

Let’s try comparing using a classic large document – the IPCC climate report, chapter 3.


```
!curl https://www.ipcc.ch/report/ar6/wg2/downloads/report/IPCC_AR6_WGII_Chapter03.pdf --output IPCC_AR6_WGII_Chapter03.pdf
```

```
huggingface/tokenizers: The current process just got forked, after parallelism has already been used. Disabling parallelism to avoid deadlocks...To disable this warning, you can either:	- Avoid using `tokenizers` before the fork if possible	- Explicitly set the environment variable TOKENIZERS_PARALLELISM=(true | false)  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current                                 Dload  Upload   Total   Spent    Left  Speed100 20.7M  100 20.7M    0     0  16.5M      0  0:00:01  0:00:01 --:--:-- 16.5M
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextdocuments = SimpleDirectoryReader(    input\_files=["IPCC\_AR6\_WGII\_Chapter03.pdf"]).load\_data()
```
### Base HuggingFace Embeddings[](#base-huggingface-embeddings "Permalink to this heading")


```
import osimport openai# needed to synthesize responses lateros.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index.embeddings import HuggingFaceEmbedding# loads BAAI/bge-small-en-v1.5embed\_model = HuggingFaceEmbedding(model\_name="BAAI/bge-small-en-v1.5")test\_emeds = embed\_model.get\_text\_embedding("Hello World!")service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)
```

```
%%timeit -r 1 -n 1index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context, show\_progress=True)
```

```
1min 27s ± 0 ns per loop (mean ± std. dev. of 1 run, 1 loop each)
```
### Optimum Embeddings[](#optimum-embeddings "Permalink to this heading")

We can use the onnx embeddings we created earlier


```
from llama\_index.embeddings import OptimumEmbeddingembed\_model = OptimumEmbedding(folder\_name="./bge\_onnx")test\_emeds = embed\_model.get\_text\_embedding("Hello World!")service\_context = ServiceContext.from\_defaults(embed\_model=embed\_model)
```

```
%%timeit -r 1 -n 1index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context, show\_progress=True)
```

```
1min 9s ± 0 ns per loop (mean ± std. dev. of 1 run, 1 loop each)
```
