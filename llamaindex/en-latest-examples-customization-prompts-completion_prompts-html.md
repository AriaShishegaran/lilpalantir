[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/customization/prompts/completion_prompts.ipynb)

Completion Prompts Customization[](#completion-prompts-customization "Permalink to this heading")
==================================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Prompt Setup[](#prompt-setup "Permalink to this heading")
----------------------------------------------------------

Below, we take the default prompts and customize them to always answer, even if the context is not helpful.


```
from llama\_index.prompts import PromptTemplatetext\_qa\_template\_str = (    "Context information is"    " below.\n---------------------\n{context\_str}\n---------------------\nUsing"    " both the context information and also using your own knowledge, answer"    " the question: {query\_str}\nIf the context isn't helpful, you can also"    " answer the question on your own.\n")text\_qa\_template = PromptTemplate(text\_qa\_template\_str)refine\_template\_str = (    "The original question is as follows: {query\_str}\nWe have provided an"    " existing answer: {existing\_answer}\nWe have the opportunity to refine"    " the existing answer (only if needed) with some more context"    " below.\n------------\n{context\_msg}\n------------\nUsing both the new"    " context and your own knowledge, update or repeat the existing answer.\n")refine\_template = PromptTemplate(refine\_template\_str)
```
Using the Prompts[](#using-the-prompts "Permalink to this heading")
--------------------------------------------------------------------

Now, we use the prompts in an index query!


```
import openaiimport osos.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContextfrom llama\_index.llms import OpenAIservice\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="text-davinci-003"))documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
### Before Adding Templates[](#before-adding-templates "Permalink to this heading")


```
print(index.as\_query\_engine().query("Who is Joe Biden?"))
```

```
 Joe Biden is not mentioned in the context information.
```
### After Adding Templates[](#after-adding-templates "Permalink to this heading")


```
print(    index.as\_query\_engine(        text\_qa\_template=text\_qa\_template, refine\_template=refine\_template    ).query("Who is Joe Biden?"))
```

```
Joe Biden is the 46th President of the United States. He was elected in 2020 and is the first Democratic president since Barack Obama. He previously served as Vice President under Obama from 2009 to 2017.
```
