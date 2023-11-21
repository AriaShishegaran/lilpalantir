[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/OptimizerDemo.ipynb)

Sentence Embedding Optimizer[](#sentence-embedding-optimizer "Permalink to this heading")
==========================================================================================


```
# My OpenAI Keyimport osos.environ["OPENAI\_API\_KEY"] = "INSERT OPENAI KEY"
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import download\_loaderWikipediaReader = download\_loader("WikipediaReader")loader = WikipediaReader()documents = loader.load\_data(pages=["Berlin"])
```

```
from llama\_index import VectorStoreIndexindex = VectorStoreIndex.from\_documents(documents)
```

```
<class 'llama_index.readers.schema.base.Document'>
```

```
INFO:root:> [build_index_from_documents] Total LLM token usage: 0 tokensINFO:root:> [build_index_from_documents] Total embedding token usage: 18390 tokens
```
Compare query with and without optimization for LLM token usage, Embedding Model usage on query, Embedding model usage for optimizer, and total time.


```
import timefrom llama\_index import VectorStoreIndexfrom llama\_index.indices.postprocessor import SentenceEmbeddingOptimizerprint("Without optimization")start\_time = time.time()query\_engine = index.as\_query\_engine()res = query\_engine.query("What is the population of Berlin?")end\_time = time.time()print("Total time elapsed: {}".format(end\_time - start\_time))print("Answer: {}".format(res))print("With optimization")start\_time = time.time()query\_engine = index.as\_query\_engine(    node\_postprocessors=[SentenceEmbeddingOptimizer(percentile\_cutoff=0.5)])res = query\_engine.query("What is the population of Berlin?")end\_time = time.time()print("Total time elapsed: {}".format(end\_time - start\_time))print("Answer: {}".format(res))print("Alternate optimization cutoff")start\_time = time.time()query\_engine = index.as\_query\_engine(    node\_postprocessors=[SentenceEmbeddingOptimizer(threshold\_cutoff=0.7)])res = query\_engine.query("What is the population of Berlin?")end\_time = time.time()print("Total time elapsed: {}".format(end\_time - start\_time))print("Answer: {}".format(res))
```

```
Without optimization
```

```
INFO:root:> [query] Total LLM token usage: 3545 tokensINFO:root:> [query] Total embedding token usage: 7 tokens
```

```
Total time elapsed: 2.8928110599517822Answer: The population of Berlin in 1949 was approximately 2.2 million inhabitants. After the fall of the Berlin Wall in 1989, the population of Berlin increased to approximately 3.7 million inhabitants.With optimization
```

```
INFO:root:> [optimize] Total embedding token usage: 7 tokensINFO:root:> [query] Total LLM token usage: 1779 tokensINFO:root:> [query] Total embedding token usage: 7 tokens
```

```
Total time elapsed: 2.346346139907837Answer: The population of Berlin is around 4.5 million.Alternate optimization cutoff
```

```
INFO:root:> [optimize] Total embedding token usage: 7 tokensINFO:root:> [query] Total LLM token usage: 3215 tokensINFO:root:> [query] Total embedding token usage: 7 tokens
```

```
Total time elapsed: 2.101111888885498Answer: The population of Berlin is around 4.5 million.
```
