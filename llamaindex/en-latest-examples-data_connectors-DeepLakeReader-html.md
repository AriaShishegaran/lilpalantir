[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/DeepLakeReader.ipynb)

DeepLake Reader[](#deeplake-reader "Permalink to this heading")
================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import getpassimport osimport randomimport textwrapfrom llama\_index import VectorStoreIndexfrom llama\_index.readers.deeplake import DeepLakeReaderos.environ["OPENAI\_API\_KEY"] = getpass.getpass("open ai api key: ")
```

```
reader = DeepLakeReader()query\_vector = [random.random() for \_ in range(1536)]documents = reader.load\_data(    query\_vector=query\_vector,    dataset\_path="hub://activeloop/paul\_graham\_essay",    limit=5,)
```

```
/Users/adilkhansarsen/Documents/work/LlamaIndex/llama_index/GPTIndex/lib/python3.9/site-packages/deeplake/util/warnings.py:7: UserWarning: Checking out dataset in read only mode as another machine has locked this version for writing.  warnings.warn(*args, **kwargs)-
```

```
This dataset can be visualized in Jupyter Notebook by ds.visualize() or at https://app.activeloop.ai/activeloop/paul_graham_essay
```

```
\
```

```
hub://activeloop/paul_graham_essay loaded successfully.
```

```
 
```

```
index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 14220 tokensINFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 3975 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 9 tokens
```

```
 A hard moment for the author was when he realized that the AI programs of the time were not goingto be able to understand natural language and bridge the gap between what they could do and actuallyunderstanding natural language. He had expected college to help him understand the ultimate truths,but instead he found that the other fields took up so much of the space of ideas that there wasn'tmuch left for these supposed ultimate truths. He also found himself in a situation where thestudents and faculty had an arrangement that didn't require either to learn or teach anything, andhe was the only one painting the nude model. He was also painting still lives in his bedroom atnight on scraps of canvas due to his financial situation.
```
