[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/WeaviateDemo.ipynb)

Weaviate Reader[](#weaviate-reader "Permalink to this heading")
================================================================


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import weaviatefrom llama\_index.readers.weaviate import WeaviateReader
```

```
# See https://weaviate.io/developers/weaviate/current/client-libraries/python.html# for more details on authenticationresource\_owner\_config = weaviate.AuthClientPassword(    username="<username>",    password="<password>",)# initialize readerreader = WeaviateReader(    "https://<cluster-id>.semi.network/",    auth\_client\_secret=resource\_owner\_config,)
```
You have two options for the Weaviate reader: 1) directly specify the class\_name and properties, or 2) input the raw graphql\_query. Examples are shown below.


```
# 1) load data using class\_name and properties# docs = reader.load\_data(# class\_name="Author", properties=["name", "description"], separate\_documents=True# )documents = reader.load\_data(    class\_name="<class\_name>",    properties=["property1", "property2", "..."],    separate\_documents=True,)
```

```
# 2) example GraphQL query# query = """# {# Get {# Author {# name# description# }# }# }# """# docs = reader.load\_data(graphql\_query=query, separate\_documents=True)query = """{ Get { <class\_name> { <property1> <property2> ... } }}"""documents = reader.load\_data(graphql\_query=query, separate\_documents=True)
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
