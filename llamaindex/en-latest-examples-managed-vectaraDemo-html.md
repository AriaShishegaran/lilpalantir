[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/managed/vectaraDemo.ipynb)

Vectara Managed Index[](#vectara-managed-index "Permalink to this heading")
============================================================================

In this notebook we are going to show how to use [Vectara](https://vectara.com) with LlamaIndex.Vectara is the first example of a “Managed” Index, a new type of index in Llama-index which is managed via an API.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import SimpleDirectoryReaderfrom llama\_index.indices import VectaraIndeximport textwrap
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Loading documents[](#loading-documents "Permalink to this heading")
--------------------------------------------------------------------

Load the documents stored in the `paul\_graham\_essay` using the SimpleDirectoryReader


```
documents = SimpleDirectoryReader("../data/10q").load\_data()print("Document ID:", documents[0].doc\_id)
```

```
Document ID: fe81af94-f315-4e58-a7c6-2625292dc283
```
Add the content of the documents into a pre-created Vectara corpus[](#add-the-content-of-the-documents-into-a-pre-created-vectara-corpus "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Here we assume an empty corpus is created and the details are available as environment variables:

* VECTARA\_CORPUS\_ID
* VECTARA\_CUSTOMER\_ID
* VECTARA\_API\_KEY


```
index = VectaraIndex.from\_documents(documents)
```
Query the Vectara Index[](#query-the-vectara-index "Permalink to this heading")
--------------------------------------------------------------------------------

We can now ask questions using the VectaraIndex retriever.


```
query = "what are the main risks?"
```

```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=5, n\_sentences\_before=0, n\_sentences\_after=0)response = query\_engine.retrieve(query)texts = [t.node.text for t in response]print("\n--\n".join(texts))
```

```
Our ownership in these entities involves significant risks that are outside our control.--Our ownership in these entities involves significant risks that are outside our control.--Our ownership in these entities involves significant risks that are outside our control.--Autonomous vehicle technologies involve significant risks and liabilities.--We are unable to predict what global or U.S. tax reforms may be proposed or enacted in the future or what effects such future changes would have on ourbusiness.
```

```
response = query\_engine.query(query)print(response)
```

```
The main risks mentioned in the context are significant risks associated with ownership in certain entities that are outside the company's control, as well as significant risks and liabilities related to autonomous vehicle technologies. Additionally, there is a mention of uncertainty regarding future global or U.S. tax reforms and their potential effects on the company's business.
```
Vectara supports max-marginal-relevance natively in the backend, and this is available as a query moe.Let’s see an example of how to use MMR: We will run the same query “What is YC?” but this time we will use MMR where mmr\_diversity\_bias=1.0 which maximizes the focus on maximum diversity:


```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=5,    n\_sentences\_before=0,    n\_sentences\_after=0,    vectara\_query\_mode="mmr",    vectara\_kwargs={"mmr\_k": 100, "mmr\_diversity\_bias": 1.0},)response = query\_engine.retrieve(query)texts = [t.node.text for t in response]print("\n--\n".join(texts))
```

```
Our ownership in these entities involves significant risks that are outside our control.--We are unable to predict what global or U.S. tax reforms may be proposed or enacted in the future or what effects such future changes would have on ourbusiness.--We are subject to climate change risks, including physical and transitional risks, and if we are unable to manage such risks, our business may be adverselyimpacted.--Autonomous vehicle technologies involve significant risks and liabilities.--QUANTITATIVE AND QUALITATIVE DISCLOSURES ABOUT MARKET RISKWe are exposed to market risks in the ordinary course of our business.
```
As you can see, the results in this case are much more diverse, and for example do not contain the same text more than once.


```
response = query\_engine.query(query)print(response)
```

```
The main risks mentioned in the given context are:1. Risks associated with ownership in certain entities.2. Uncertainty regarding future global or U.S. tax reforms and their potential impact on the business.3. Risks related to climate change, including both physical and transitional risks.4. Risks and liabilities associated with autonomous vehicle technologies.5. Market risks that the company is exposed to in the ordinary course of its business.
```
The resposne is also better as it includes more risk factors mentioned in the original document

