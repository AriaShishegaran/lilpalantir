[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/callbacks/AimCallback.ipynb)

Aim Callback[](#aim-callback "Permalink to this heading")
==========================================================

Aim is an easy-to-use & supercharged open-source AI metadata tracker it logs all your AI metadata (experiments, prompts, etc) enables a UI to compare & observe them and SDK to query them programmatically. For more please see the [Github page](https://github.com/aimhubio/aim).

In this demo, we show the capabilities of Aim for logging events while running queries within LlamaIndex. We use the AimCallback to store the outputs and showing how to explore them using Aim Text Explorer.

**NOTE**: This is a beta feature. The usage within different classes and the API interface for the CallbackManager and AimCallback may change!

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.callbacks import CallbackManager, AimCallbackfrom llama\_index import SummaryIndex, ServiceContext, SimpleDirectoryReader
```
Let’s read the documents using `SimpleDirectoryReader` from ‘examples/data/paul\_graham’.

### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
docs = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```
Now lets initialize an AimCallback instance, and add it to the list of callback managers.


```
aim\_callback = AimCallback(repo="./")callback\_manager = CallbackManager([aim\_callback])
```
In this snippet, we initialize a service context by providing the callback manager.Next, we create an instance of `SummaryIndex` class, by passing in the document reader and the service context. After which we create a query engine which we will use to run queries on the index and retrieve relevant results.


```
service\_context = ServiceContext.from\_defaults(    callback\_manager=callback\_manager)index = SummaryIndex.from\_documents(docs, service\_context=service\_context)query\_engine = index.as\_query\_engine()
```
Finally let’s ask a question to the LM based on our provided document


```
response = query\_engine.query("What did the author do growing up?")
```
The callback manager will log the `CBEventType.LLM` type of events as an Aim.Text, and we can explore the LM given prompt and the output in the Text Explorer. By first doing `aim up` and navigating by the given url.

