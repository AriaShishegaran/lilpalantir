[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/SimpleIndexDemo.ipynb)

Simple Vector Store[](#simple-vector-store "Permalink to this heading")
========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    load\_index\_from\_storage,    StorageContext,)from IPython.display import Markdown, display
```

```
INFO:numexpr.utils:Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 16 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents)
```

```
# save index to diskindex.set\_index\_id("vector\_index")index.storage\_context.persist("./storage")
```

```
# rebuild storage contextstorage\_context = StorageContext.from\_defaults(persist\_dir="storage")# load indexindex = load\_index\_from\_storage(storage\_context, index\_id="vector\_index")
```

```
INFO:llama_index.indices.loading:Loading indices with ids: ['vector_index']Loading indices with ids: ['vector_index']
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
# set Logging to DEBUG for more detailed outputsquery\_engine = index.as\_query\_engine(response\_mode="tree\_summarize")response = query\_engine.query("What did the author do growing up?")
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming outside of school before college. They wrote short stories and tried writing programs on an IBM 1401 computer using an early version of Fortran. They later got a microcomputer, a TRS-80, and started programming more extensively, including writing simple games and a word processor. They initially planned to study philosophy in college but switched to AI. They also started publishing essays online and eventually wrote a book called “Hackers & Painters.”**

**Query Index with SVM/Linear Regression**

Use Karpathy’s [SVM-based](https://twitter.com/karpathy/status/1647025230546886658?s=20) approach. Set query as positive example, all other datapoints as negative examples, and then fit a hyperplane.


```
query\_modes = [    "svm",    "linear\_regression",    "logistic\_regression",]for query\_mode in query\_modes:    # set Logging to DEBUG for more detailed outputs    query\_engine = index.as\_query\_engine(vector\_store\_query\_mode=query\_mode)    response = query\_engine.query("What did the author do growing up?")    print(f"Query mode: {query\_mode}")    display(Markdown(f"<b>{response}</b>"))
```

```
Query mode: svm
```
**The author wrote short stories and also started programming on an IBM 1401 computer in 9th grade. They later got their own microcomputer, a TRS-80, and wrote simple games, a rocket prediction program, and a word processor.**


```
Query mode: linear_regression
```
**The author worked on writing and programming growing up. They wrote short stories and also started programming on an IBM 1401 computer in 9th grade using an early version of Fortran. Later, they got a microcomputer and wrote simple games, a rocket prediction program, and a word processor.**


```
Query mode: logistic_regression
```
**The author worked on writing and programming growing up. They wrote short stories and also started programming on an IBM 1401 computer in 9th grade using an early version of Fortran. Later, they got a microcomputer and wrote simple games, a rocket prediction program, and a word processor.**


```
display(Markdown(f"<b>{response}</b>"))
```
**The author worked on writing and programming growing up. They wrote short stories and also started programming on an IBM 1401 computer in 9th grade using an early version of Fortran. Later, they got a microcomputer and wrote simple games, a rocket prediction program, and a word processor.**


```
print(response.source\_nodes[0].text)
```

```
Now all I had to do was learn Italian.Only stranieri (foreigners) had to take this entrance exam. In retrospect it may well have been a way of excluding them, because there were so many stranieri attracted by the idea of studying art in Florence that the Italian students would otherwise have been outnumbered. I was in decent shape at painting and drawing from the RISD foundation that summer, but I still don't know how I managed to pass the written exam. I remember that I answered the essay question by writing about Cezanne, and that I cranked up the intellectual level as high as I could to make the most of my limited vocabulary. [2]I'm only up to age 25 and already there are such conspicuous patterns. Here I was, yet again about to attend some august institution in the hopes of learning about some prestigious subject, and yet again about to be disappointed. The students and faculty in the painting department at the Accademia were the nicest people you could imagine, but they had long since arrived at an arrangement whereby the students wouldn't require the faculty to teach anything, and in return the faculty wouldn't require the students to learn anything. And at the same time all involved would adhere outwardly to the conventions of a 19th century atelier. We actually had one of those little stoves, fed with kindling, that you see in 19th century studio paintings, and a nude model sitting as close to it as possible without getting burned. Except hardly anyone else painted her besides me. The rest of the students spent their time chatting or occasionally trying to imitate things they'd seen in American art magazines.Our model turned out to live just down the street from me. She made a living from a combination of modelling and making fakes for a local antique dealer. She'd copy an obscure old painting out of a book, and then he'd take the copy and maltreat it to make it look old. [3]While I was a student at the Accademia I started painting still lives in my bedroom at night. These paintings were tiny, because the room was, and because I painted them on leftover scraps of canvas, which was all I could afford at the time. Painting still lives is different from painting people, because the subject, as its name suggests, can't move. People can't sit for more than about 15 minutes at a time, and when they do they don't sit very still. So the traditional m.o. for painting people is to know how to paint a generic person, which you then modify to match the specific person you're painting. Whereas a still life you can, if you want, copy pixel by pixel from what you're seeing. You don't want to stop there, of course, or you get merely photographic accuracy, and what makes a still life interesting is that it's been through a head. You want to emphasize the visual cues that tell you, for example, that the reason the color changes suddenly at a certain point is that it's the edge of an object. By subtly emphasizing such things you can make paintings that are more realistic than photographs not just in some metaphorical sense, but in the strict information-theoretic sense. [4]I liked painting still lives because I was curious about what I was seeing. In everyday life, we aren't consciously aware of much we're seeing. Most visual perception is handled by low-level processes that merely tell your brain "that's a water droplet" without telling you details like where the lightest and darkest points are, or "that's a bush" without telling you the shape and position of every leaf. This is a feature of brains, not a bug. In everyday life it would be distracting to notice every leaf on every bush. But when you have to paint something, you have to look more closely, and when you do there's a lot to see. You can still be noticing new things after days of trying to paint something people usually take for granted, just as you can after days of trying to write an essay about something people usually take for granted.This is not the only way to paint. I'm not 100% sure it's even a good way to paint. But it seemed a good enough bet to be worth trying.Our teacher, professor Ulivi, was a nice guy. He could see I worked hard, and gave me a good grade, which he wrote down in a sort of passport each student had. But the Accademia wasn't teaching me anything except Italian, and my money was running out, so at the end of the first year I went back to the US.
```
**Query Index with custom embedding string**


```
from llama\_index.indices.query.schema import QueryBundle
```

```
query\_bundle = QueryBundle(    query\_str="What did the author do growing up?",    custom\_embedding\_strs=["The author grew up painting."],)query\_engine = index.as\_query\_engine()response = query\_engine.query(query\_bundle)
```

```
display(Markdown(f"<b>{response}</b>"))
```
**The context does not provide information about what the author did growing up.**

**Use maximum marginal relevance**

Instead of ranking vectors purely by similarity, adds diversity to the documents by penalizing documents similar to ones that have already been found based on [MMR](https://www.cs.cmu.edu/~jgc/publication/The_Use_MMR_Diversity_Based_LTMIR_1998.pdf) . A lower mmr\_treshold increases diversity.


```
query\_engine = index.as\_query\_engine(    vector\_store\_query\_mode="mmr", vector\_store\_kwargs={"mmr\_threshold": 0.2})response = query\_engine.query("What did the author do growing up?")
```
Get Sources[](#get-sources "Permalink to this heading")
--------------------------------------------------------


```
print(response.get\_formatted\_sources())
```

```
> Source (Doc id: fa51aa2a-af68-450f-bb00-786df71f2cdc): What I Worked OnFebruary 2021Before college the two main things I worked on, outside of schoo...> Source (Doc id: 4636483a-a416-4971-804f-abfb80a44378): Now all I had to do was learn Italian.Only stranieri (foreigners) had to take this entrance exa...
```
Query Index with Filters[](#query-index-with-filters "Permalink to this heading")
----------------------------------------------------------------------------------

We can also filter our queries using metadata


```
from llama\_index import Documentdoc = Document(text="target", metadata={"tag": "target"})index.insert(doc)
```

```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersfilters = MetadataFilters(    filters=[ExactMatchFilter(key="tag", value="target")])retriever = index.as\_retriever(    similarity\_top\_k=20,    filters=filters,)source\_nodes = retriever.retrieve("What did the author do growing up?")
```

```
# retrieves only our target node, even though we set the top k to 20print(len(source\_nodes))
```

```
1
```

```
print(source\_nodes[0].text)print(source\_nodes[0].metadata)
```

```
target{'tag': 'target'}
```
