[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/cohereai.ipynb)

CohereAI Embeddings[](#cohereai-embeddings "Permalink to this heading")
========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Initilise with your api keyimport oscohere\_api\_key = "YOUR\_API\_KEY"os.environ["COHERE\_API\_KEY"] = cohere\_api\_key
```
With latest `embed-english-v3.0` embeddings.[](#with-latest-embed-english-v3-0-embeddings "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------

* input\_type=”search\_document”: Use this for texts (documents) you want to store in your vector database
* input\_type=”search\_query”: Use this for search queries to find the most relevant documents in your vector database


```
from llama\_index.embeddings.cohereai import CohereEmbedding# with input\_typ='search\_query'embed\_model = CohereEmbedding(    cohere\_api\_key=cohere\_api\_key,    model\_name="embed-english-v3.0",    input\_type="search\_query",)embeddings = embed\_model.get\_text\_embedding("Hello CohereAI!")print(len(embeddings))print(embeddings[:5])
```

```
1024[-0.041931152, -0.022384644, -0.07067871, -0.011886597, -0.019210815]
```

```
# with input\_type = 'search\_document'embed\_model = CohereEmbedding(    cohere\_api\_key=cohere\_api\_key,    model\_name="embed-english-v3.0",    input\_type="search\_document",)embeddings = embed\_model.get\_text\_embedding("Hello CohereAI!")print(len(embeddings))print(embeddings[:5])
```

```
1024[-0.03074646, -0.0029201508, -0.058044434, -0.015457153, -0.02331543]
```
With old `embed-english-v2.0` embeddings.[](#with-old-embed-english-v2-0-embeddings "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------


```
embed\_model = CohereEmbedding(    cohere\_api\_key=cohere\_api\_key, model\_name="embed-english-v2.0")embeddings = embed\_model.get\_text\_embedding("Hello CohereAI!")print(len(embeddings))print(embeddings[:5])
```

```
4096[0.65771484, 0.7998047, 2.3769531, -2.3105469, -1.6044922]
```
Now with latest `embed-english-v3.0` embeddings,[](#now-with-latest-embed-english-v3-0-embeddings "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------

let’s use

1. input\_type=`search\_document` to build index
2. input\_type=`search\_query` to retrive relevant context.


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,)from llama\_index.llms import LiteLLMfrom llama\_index.response.notebook\_utils import display\_source\_nodefrom IPython.display import Markdown, display
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
--2023-11-03 03:14:50--  https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/paul_graham/paul_graham_essay.txtResolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.111.133, 185.199.110.133, ...Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 75042 (73K) [text/plain]Saving to: 'data/paul_graham/paul_graham_essay.txt'data/paul_graham/pa 100%[===================>]  73.28K  --.-KB/s    in 0.006s  2023-11-03 03:14:50 (11.3 MB/s) - 'data/paul_graham/paul_graham_essay.txt' saved [75042/75042]
```
Load Data[](#load-data "Permalink to this heading")
----------------------------------------------------


```
documents = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```
Build index with input\_type = ‘search\_document’[](#build-index-with-input-type-search-document "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------


```
llm = LiteLLM("command-nightly")embed\_model = CohereEmbedding(    cohere\_api\_key=cohere\_api\_key,    model\_name="embed-english-v3.0",    input\_type="search\_document",)service\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)index = VectorStoreIndex.from\_documents(    documents=documents, service\_context=service\_context)
```
Build retriever with input\_type = ‘search\_query’[](#build-retriever-with-input-type-search-query "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------


```
embed\_model = CohereEmbedding(    cohere\_api\_key=cohere\_api\_key,    model\_name="embed-english-v3.0",    input\_type="search\_query",)service\_context = ServiceContext.from\_defaults(    llm=llm, embed\_model=embed\_model)search\_query\_retriever = index.as\_retriever(service\_context=service\_context)search\_query\_retrieved\_nodes = search\_query\_retriever.retrieve(    "What happened in the summer of 1995?")
```

```
for n in search\_query\_retrieved\_nodes:    display\_source\_node(n, source\_length=2000)
```
**Node ID:** 1b0759b6-e6a1-4749-aeaa-1eafe14db055  
**Similarity:** 0.3253174706260866  
**Text:** That’s not how they sell. I wrote some software to generate web sites for galleries, and Robert wrote some to resize images and set up an http server to serve the pages. Then we tried to sign up galleries. To call this a difficult sale would be an understatement. It was difficult to give away. A few galleries let us make sites for them for free, but none paid us.

Then some online stores started to appear, and I realized that except for the order buttons they were identical to the sites we’d been generating for galleries. This impressive-sounding thing called an “internet storefront” was something we already knew how to build.

So in the summer of 1995, after I submitted the camera-ready copy of ANSI Common Lisp to the publishers, we started trying to write software to build online stores. At first this was going to be normal desktop software, which in those days meant Windows software. That was an alarming prospect, because neither of us knew how to write Windows software or wanted to learn. We lived in the Unix world. But we decided we’d at least try writing a prototype store builder on Unix. Robert wrote a shopping cart, and I wrote a new site generator for stores — in Lisp, of course.

We were working out of Robert’s apartment in Cambridge. His roommate was away for big chunks of time, during which I got to sleep in his room. For some reason there was no bed frame or sheets, just a mattress on the floor. One morning as I was lying on this mattress I had an idea that made me sit up like a capital L. What if we ran the software on the server, and let users control it by clicking on links? Then we’d never have to write anything to run on users’ computers. We could generate the sites on the same server we’d serve them from. Users wouldn’t need anything more than a browser.

This kind of software, known as a web app, is common now, but at the time it wasn’t clear that it was even possible. To find out, we decided to try making a version of our store builder that y…  


**Node ID:** ab6c138d-a509-4894-9131-da145eb7a4b4  
**Similarity:** 0.28713538838359537  
**Text:** But once again, this was not due to any particular insight on our part. We didn’t know how VC firms were organized. It never occurred to us to try to raise a fund, and if it had, we wouldn’t have known where to start. [14]

The most distinctive thing about YC is the batch model: to fund a bunch of startups all at once, twice a year, and then to spend three months focusing intensively on trying to help them. That part we discovered by accident, not merely implicitly but explicitly due to our ignorance about investing. We needed to get experience as investors. What better way, we thought, than to fund a whole bunch of startups at once? We knew undergrads got temporary jobs at tech companies during the summer. Why not organize a summer program where they’d start startups instead? We wouldn’t feel guilty for being in a sense fake investors, because they would in a similar sense be fake founders. So while we probably wouldn’t make much money out of it, we’d at least get to practice being investors on them, and they for their part would probably have a more interesting summer than they would working at Microsoft.

We’d use the building I owned in Cambridge as our headquarters. We’d all have dinner there once a week — on tuesdays, since I was already cooking for the thursday diners on thursdays — and after dinner we’d bring in experts on startups to give talks.

We knew undergrads were deciding then about summer jobs, so in a matter of days we cooked up something we called the Summer Founders Program, and I posted an announcement on my site, inviting undergrads to apply. I had never imagined that writing essays would be a way to get “deal flow,” as investors call it, but it turned out to be the perfect source. [15] We got 225 applications for the Summer Founders Program, and we were surprised to find that a lot of them were from people who’d already graduated, or were about to that spring. Already this SFP thing was starting to feel more serious than we’d intended.

We …  


