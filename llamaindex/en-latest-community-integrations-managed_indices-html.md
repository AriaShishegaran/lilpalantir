Using Managed Indices[](#using-managed-indices "Permalink to this heading")
============================================================================

LlamaIndex offers multiple integration points with Managed Indices. A managed index is a special type of index that is not managed locally as part of LlamaIndex but instead is managed via an API, such as [Vectara](https://vectara.com).

Using a Managed Index[](#using-a-managed-index "Permalink to this heading")
----------------------------------------------------------------------------

Similar to any other index within LlamaIndex (tree, keyword table, list), any `ManagedIndex` can be constructed with a collectionof documents. Once constructed, the index can be used for querying.

If the Index has been previously populated with documents - it can also be used directly for querying.

`VectaraIndex` is currently the only supported managed index, although we expect more to be available soon.Below we show how to use it.

**Vectara Index Construction/Querying**

First, [sign up](https://vectara.com/integrations/llama_index) and use the Vectara Console to create a corpus (aka Index), and add an API key for access.Then put the customer id, corpus id, and API key in your environment.

Then construct the Vectara Index and query it as follows:


```
from llama\_index import ManagedIndex, SimpleDirectoryReadefrom llama\_index.indices import VectaraIndex# Load documents and build indexvectara\_customer\_id = os.environ.get("VECTARA\_CUSTOMER\_ID")vectara\_corpus\_id = os.environ.get("VECTARA\_CORPUS\_ID")vectara\_api\_key = os.environ.get("VECTARA\_API\_KEY")documents = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectaraIndex.from\_documents(    documents,    vectara\_customer\_id=vectara\_customer\_id,    vectara\_corpus\_id=vectara\_corpus\_id,    vectara\_api\_key=vectara\_api\_key,)# Query indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```
Note that if the environment variables `VECTARA\_CUSTOMER\_ID`, `VECTARA\_CORPUS\_ID` and `VECTARA\_API\_KEY` are in the environment already, you do not have to explicitly specifying them in your call and the VectaraIndex class will read them from the environment. For example this should be equivalent to the above, if these variables are in the environment already:


```
from llama\_index import ManagedIndex, SimpleDirectoryReadefrom llama\_index.indices import VectaraIndex# Load documents and build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectaraIndex.from\_documents(documents)# Query indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```
Examples

* [Vectara Managed Index](../../examples/managed/vectaraDemo.html)
