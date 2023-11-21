[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/jinaai_embeddings.ipynb)

Jina Embeddings[](#jina-embeddings "Permalink to this heading")
================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
You may also need other packages that do not come direcly with llama-index


```
!pip install Pillow
```
For this example, you will need an API key which you can get from https://jina.ai/embeddings/


```
# Initilise with your api keyimport osjinaai\_api\_key = "YOUR\_JINAAI\_API\_KEY"os.environ["JINAAI\_API\_KEY"] = jinaai\_api\_key
```
Embed text and queries with Jina embedding models through JinaAI API[](#embed-text-and-queries-with-jina-embedding-models-through-jinaai-api "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

You can encode your text and your queries using the JinaEmbedding class


```
from llama\_index.embeddings.jinaai import JinaEmbeddingembed\_model = JinaEmbedding(    api\_key=jinaai\_api\_key,    model="jina-embeddings-v2-base-en",)embeddings = embed\_model.get\_text\_embedding("This is the text to embed")print(len(embeddings))print(embeddings[:5])embeddings = embed\_model.get\_query\_embedding("This is the query to embed")print(len(embeddings))print(embeddings[:5])
```
### Embed in batches[](#embed-in-batches "Permalink to this heading")

You can also embed text in batches, the batch size can be controlled by setting the `embed\_batch\_size` parameter (the default value will be 10 if not passed, and it should not be larger than 2048)


```
embed\_model = JinaEmbedding(    api\_key=jinaai\_api\_key,    model="jina-embeddings-v2-base-en",    embed\_batch\_size=16,)embeddings = embed\_model.get\_text\_embedding\_batch(    ["This is the text to embed", "More text can be provided in a batch"])print(len(embeddings))print(embeddings[0][:5])
```
Let’s build a RAG pipeline using Jina AI Embeddings[](#let-s-build-a-rag-pipeline-using-jina-ai-embeddings "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------

### Download Data[](#download-data "Permalink to this heading")


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
### Imports[](#imports "Permalink to this heading")


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,)from llama\_index.llms import OpenAIfrom llama\_index.response.notebook\_utils import display\_source\_nodefrom IPython.display import Markdown, display
```
### Load Data[](#load-data "Permalink to this heading")


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
### Build index[](#build-index "Permalink to this heading")


```
your\_openai\_key = "YOUR\_OPENAI\_KEY"llm = OpenAI(api\_key=your\_openai\_key)embed\_model = JinaEmbedding(    api\_key=jinaai\_api\_key,    model="jina-embeddings-v2-base-en",    embed\_batch\_size=16,)service\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents=documents, service\_context=service\_context)
```
### Build retriever[](#build-retriever "Permalink to this heading")


```
search\_query\_retriever = index.as\_retriever(service\_context=service\_context)search\_query\_retrieved\_nodes = search\_query\_retriever.retrieve(    "What happened after the thesis?")
```

```
for n in search\_query\_retrieved\_nodes:    display\_source\_node(n, source\_length=2000)
```
**Node ID:** d8db9dfe-ab7a-4709-9863-877b68d2210d  
**Similarity:** 0.7698250992788241  
**Text:** There were some surplus Xerox Dandelions floating around the computer lab at one point. Anyone who wanted one to play around with could have one. I was briefly tempted, but they were so slow by present standards; what was the point? No one else wanted one either, so off they went. That was what happened to systems work.

I wanted not just to build things, but to build things that would last.

In this dissatisfied state I went in 1988 to visit Rich Draves at CMU, where he was in grad school. One day I went to visit the Carnegie Institute, where I’d spent a lot of time as a kid. While looking at a painting there I realized something that might seem obvious, but was a big surprise to me. There, right on the wall, was something you could make that would last. Paintings didn’t become obsolete. Some of the best ones were hundreds of years old.

And moreover this was something you could make a living doing. Not as easily as you could by writing software, of course, but I thought if you were really industrious and lived really cheaply, it had to be possible to make enough to survive. And as an artist you could be truly independent. You wouldn’t have a boss, or even need to get research funding.

I had always liked looking at paintings. Could I make them? I had no idea. I’d never imagined it was even possible. I knew intellectually that people made art — that it didn’t just appear spontaneously — but it was as if the people who made it were a different species. They either lived long ago or were mysterious geniuses doing strange things in profiles in Life magazine. The idea of actually being able to make art, to put that verb before that noun, seemed almost miraculous.

That fall I started taking art classes at Harvard. Grad students could take classes in any department, and my advisor, Tom Cheatham, was very easy going. If he even knew about the strange classes I was taking, he never said anything.

So now I was in a PhD program in computer science, yet planning to be an…  


**Node ID:** 848bb0f8-629c-4491-b539-85f3ff5b77a2  
**Similarity:** 0.7679106002573213  
**Text:** Our teacher, professor Ulivi, was a nice guy. He could see I worked hard, and gave me a good grade, which he wrote down in a sort of passport each student had. But the Accademia wasn’t teaching me anything except Italian, and my money was running out, so at the end of the first year I went back to the US.

I wanted to go back to RISD, but I was now broke and RISD was very expensive, so I decided to get a job for a year and then return to RISD the next fall. I got one at a company called Interleaf, which made software for creating documents. You mean like Microsoft Word? Exactly. That was how I learned that low end software tends to eat high end software. But Interleaf still had a few years to live yet. [5]

Interleaf had done something pretty bold. Inspired by Emacs, they’d added a scripting language, and even made the scripting language a dialect of Lisp. Now they wanted a Lisp hacker to write things in it. This was the closest thing I’ve had to a normal job, and I hereby apologize to my boss and coworkers, because I was a bad employee. Their Lisp was the thinnest icing on a giant C cake, and since I didn’t know C and didn’t want to learn it, I never understood most of the software. Plus I was terribly irresponsible. This was back when a programming job meant showing up every day during certain working hours. That seemed unnatural to me, and on this point the rest of the world is coming around to my way of thinking, but at the time it caused a lot of friction. Toward the end of the year I spent much of my time surreptitiously working on On Lisp, which I had by this time gotten a contract to publish.

The good part was that I got paid huge amounts of money, especially by art student standards. In Florence, after paying my part of the rent, my budget for everything else had been $7 a day. Now I was getting paid more than 4 times that every hour, even when I was just sitting in a meeting. By living cheaply I not only managed to save enough to go back to RISD, but a…  


