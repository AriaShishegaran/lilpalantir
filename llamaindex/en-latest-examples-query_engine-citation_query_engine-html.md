[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/citation_query_engine.ipynb)

CitationQueryEngine[](#citationqueryengine "Permalink to this heading")
========================================================================

This notebook walks through how to use the CitationQueryEngine

The CitationQueryEngine can be used with any existing index.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
import osfrom llama\_index.llms import OpenAIfrom llama\_index.query\_engine import CitationQueryEnginefrom llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    StorageContext,    load\_index\_from\_storage,    LLMPredictor,    ServiceContext,)
```

```
/home/loganm/miniconda3/envs/llama-index/lib/python3.11/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```

```
service\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0))
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
if not os.path.exists("./citation"):    documents = SimpleDirectoryReader("./data/paul\_graham").load\_data()    index = VectorStoreIndex.from\_documents(        documents, service\_context=service\_context    )    index.storage\_context.persist(persist\_dir="./citation")else:    index = load\_index\_from\_storage(        StorageContext.from\_defaults(persist\_dir="./citation"),        service\_context=service\_context,    )
```
Create the CitationQueryEngine w/ Default Arguments[](#create-the-citationqueryengine-w-default-arguments "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------


```
query\_engine = CitationQueryEngine.from\_args(    index,    similarity\_top\_k=3,    # here we can control how granular citation sources are, the default is 512    citation\_chunk\_size=512,)
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(response)
```

```
Before college, the author worked on writing short stories and programming on an IBM 1401 using an early version of Fortran [1]. They later got a TRS-80 computer and wrote simple games, a program to predict rocket heights, and a word processor [2].
```

```
# source nodes are 6, because the original chunks of 1024-sized nodes were broken into more granular nodesprint(len(response.source\_nodes))
```

```
6
```
### Inspecting the Actual Source[](#inspecting-the-actual-source "Permalink to this heading")

Sources start counting at 1, but python arrays start counting at zero!

Let’s confirm the source makes sense.


```
print(response.source\_nodes[0].node.get\_text())
```

```
Source 1:What I Worked OnFebruary 2021Before college the two main things I worked on, outside of school, were writing and programming. I didn't write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined made them deep.The first programs I tried writing were on the IBM 1401 that our school district used for what was then called "data processing." This was in 9th grade, so I was 13 or 14. The school district's 1401 happened to be in the basement of our junior high school, and my friend Rich Draves and I got permission to use it. It was like a mini Bond villain's lair down there, with all these alien-looking machines — CPU, disk drives, printer, card reader — sitting up on a raised floor under bright fluorescent lights.The language we used was an early version of Fortran. You had to type programs on punch cards, then stack them in the card reader and press a button to load the program into memory and run it. The result would ordinarily be to print something on the spectacularly loud printer.I was puzzled by the 1401. I couldn't figure out what to do with it. And in retrospect there's not much I could have done with it. The only form of input to programs was data stored on punched cards, and I didn't have any data stored on punched cards. The only other option was to do things that didn't rely on any input, like calculate approximations of pi, but I didn't know enough math to do anything interesting of that type. So I'm not surprised I can't remember any programs I wrote, because they can't have done much. My clearest memory is of the moment I learned it was possible for programs not to terminate, when one of mine didn't. On a machine without time-sharing, this was a social as well as a technical error, as the data center manager's expression made clear.With microcomputers, everything changed. Now you could have a computer sitting right in front of you, on a desk, that could respond to your keystrokes as it was running instead of just churning through a stack of punch cards and then stopping.
```

```
print(response.source\_nodes[1].node.get\_text())
```

```
Source 2:[1]The first of my friends to get a microcomputer built it himself. It was sold as a kit by Heathkit. I remember vividly how impressed and envious I felt watching him sitting in front of it, typing programs right into the computer.Computers were expensive in those days and it took me years of nagging before I convinced my father to buy one, a TRS-80, in about 1980. The gold standard then was the Apple II, but a TRS-80 was good enough. This was when I really started programming. I wrote simple games, a program to predict how high my model rockets would fly, and a word processor that my father used to write at least one book. There was only room in memory for about 2 pages of text, so he'd write 2 pages at a time and then print them out, but it was a lot better than a typewriter.Though I liked programming, I didn't plan to study it in college. In college I was going to study philosophy, which sounded much more powerful. It seemed, to my naive high school self, to be the study of the ultimate truths, compared to which the things studied in other fields would be mere domain knowledge. What I discovered when I got to college was that the other fields took up so much of the space of ideas that there wasn't much left for these supposed ultimate truths. All that seemed left for philosophy were edge cases that people in other fields felt could safely be ignored.I couldn't have put this into words when I was 18. All I knew at the time was that I kept taking philosophy courses and they kept being boring. So I decided to switch to AI.AI was in the air in the mid 1980s, but there were two things especially that made me want to work on it: a novel by Heinlein called The Moon is a Harsh Mistress, which featured an intelligent computer called Mike, and a PBS documentary that showed Terry Winograd using SHRDLU. I haven't tried rereading The
```
Adjusting Settings[](#adjusting-settings "Permalink to this heading")
----------------------------------------------------------------------

Note that setting the chunk size larger than the original chunk size of the nodes will have no effect.

The default node chunk size is 1024, so here, we are not making our citation nodes any more granular.


```
query\_engine = CitationQueryEngine.from\_args(    index,    # increase the citation chunk size!    citation\_chunk\_size=1024,    similarity\_top\_k=3,)
```

```
response = query\_engine.query("What did the author do growing up?")
```

```
print(response)
```

```
Before college, the author worked on writing short stories and programming on an IBM 1401 using an early version of Fortran [1].
```

```
# should be less source nodes now!print(len(response.source\_nodes))
```

```
3
```
### Inspecting the Actual Source[](#id1 "Permalink to this heading")

Sources start counting at 1, but python arrays start counting at zero!

Let’s confirm the source makes sense.


```
print(response.source\_nodes[0].node.get\_text())
```

```
Source 1:What I Worked OnFebruary 2021Before college the two main things I worked on, outside of school, were writing and programming. I didn't write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined made them deep.The first programs I tried writing were on the IBM 1401 that our school district used for what was then called "data processing." This was in 9th grade, so I was 13 or 14. The school district's 1401 happened to be in the basement of our junior high school, and my friend Rich Draves and I got permission to use it. It was like a mini Bond villain's lair down there, with all these alien-looking machines — CPU, disk drives, printer, card reader — sitting up on a raised floor under bright fluorescent lights.The language we used was an early version of Fortran. You had to type programs on punch cards, then stack them in the card reader and press a button to load the program into memory and run it. The result would ordinarily be to print something on the spectacularly loud printer.I was puzzled by the 1401. I couldn't figure out what to do with it. And in retrospect there's not much I could have done with it. The only form of input to programs was data stored on punched cards, and I didn't have any data stored on punched cards. The only other option was to do things that didn't rely on any input, like calculate approximations of pi, but I didn't know enough math to do anything interesting of that type. So I'm not surprised I can't remember any programs I wrote, because they can't have done much. My clearest memory is of the moment I learned it was possible for programs not to terminate, when one of mine didn't. On a machine without time-sharing, this was a social as well as a technical error, as the data center manager's expression made clear.With microcomputers, everything changed. Now you could have a computer sitting right in front of you, on a desk, that could respond to your keystrokes as it was running instead of just churning through a stack of punch cards and then stopping. [1]The first of my friends to get a microcomputer built it himself. It was sold as a kit by Heathkit. I remember vividly how impressed and envious I felt watching him sitting in front of it, typing programs right into the computer.Computers were expensive in those days and it took me years of nagging before I convinced my father to buy one, a TRS-80, in about 1980. The gold standard then was the Apple II, but a TRS-80 was good enough. This was when I really started programming. I wrote simple games, a program to predict how high my model rockets would fly, and a word processor that my father used to write at least one book. There was only room in memory for about 2 pages of text, so he'd write 2 pages at a time and then print them out, but it was a lot better than a typewriter.Though I liked programming, I didn't plan to study it in college. In college I was going to study philosophy, which sounded much more powerful. It seemed, to my naive high school self, to be the study of the ultimate truths, compared to which the things studied in other fields would be mere domain knowledge. What I discovered when I got to college was that the other fields took up so much of the space of ideas that there wasn't much left for these supposed ultimate truths. All that seemed left for philosophy were edge cases that people in other fields felt could safely be ignored.I couldn't have put this into words when I was 18. All I knew at the time was that I kept taking philosophy courses and they kept being boring. So I decided to switch to AI.AI was in the air in the mid 1980s, but there were two things especially that made me want to work on it: a novel by Heinlein called The Moon is a Harsh Mistress, which featured an intelligent computer called Mike, and a PBS documentary that showed Terry Winograd using SHRDLU. I haven't tried rereading The
```
