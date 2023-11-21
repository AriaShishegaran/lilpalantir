[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/PineconeDemo.ipynb)

Pinecone Reader[](#pinecone-reader "Permalink to this heading")
================================================================


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
api\_key = "<api\_key>"
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.readers.pinecone import PineconeReader
```

```
reader = PineconeReader(api\_key=api\_key, environment="us-west1-gcp")
```

```
# the id\_to\_text\_map specifies a mapping from the ID specified in Pinecone to your text.id\_to\_text\_map = {    "id1": "text blob 1",    "id2": "text blob 2",}# the query\_vector is an embedding representation of your query\_vector# Example query vector:# query\_vector=[0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]query\_vector = [n1, n2, n3, ...]
```

```
# NOTE: Required args are index\_name, id\_to\_text\_map, vector.# In addition, we pass-through all kwargs that can be passed into the the `Query` operation in Pinecone.# See the API reference: https://docs.pinecone.io/reference/query# and also the Python client: https://github.com/pinecone-io/pinecone-python-client# for more details.documents = reader.load\_data(    index\_name="quickstart",    id\_to\_text\_map=id\_to\_text\_map,    top\_k=3,    vector=query\_vector,    separate\_documents=True,)
```
Create index[](#create-index "Permalink to this heading")
----------------------------------------------------------


```
index = SummaryIndex.from\_documents(documents)
```

```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")
```

```
display(Markdown(f"<b>{response}</b>"))
```
