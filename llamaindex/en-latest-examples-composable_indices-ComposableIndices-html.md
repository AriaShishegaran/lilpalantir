[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/composable_indices/ComposableIndices.ipynb)

Composable Graph[](#composable-graph "Permalink to this heading")
==================================================================


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import (    VectorStoreIndex,    SimpleKeywordTableIndex,    SimpleDirectoryReader,)
```
Load Datasets[](#load-datasets "Permalink to this heading")
------------------------------------------------------------

Load both the NYC Wikipedia page as well as Paul Graham’s “What I Worked On” essay


```
# fetch "New York City" page from Wikipediafrom pathlib import Pathimport requestsresponse = requests.get(    "https://en.wikipedia.org/w/api.php",    params={        "action": "query",        "format": "json",        "titles": "New York City",        "prop": "extracts",        # 'exintro': True,        "explaintext": True,    },).json()page = next(iter(response["query"]["pages"].values()))nyc\_text = page["extract"]data\_path = Path("data/test\_wiki")if not data\_path.exists():    Path.mkdir(data\_path)with open("./data/test\_wiki/nyc\_text.txt", "w") as fp:    fp.write(nyc\_text)
```

```
# load NYC datasetnyc\_documents = SimpleDirectoryReader("./data/test\_wiki").load\_data()
```
Download Paul Graham Essay data


```
!mkdir -p 'data/paul\_graham\_essay/'!wget 'https://github.com/jerryjliu/llama\_index/blob/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham\_essay/paul\_graham\_essay.txt'
```

```
# load PG's essayessay\_documents = SimpleDirectoryReader("./data/paul\_graham\_essay").load\_data()
```
Building the document indices[](#building-the-document-indices "Permalink to this heading")
--------------------------------------------------------------------------------------------

Build a tree index for the NYC wiki page and PG essay


```
# build NYC indexnyc\_index = VectorStoreIndex.from\_documents(nyc\_documents)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 28492 tokens> [build_index_from_nodes] Total embedding token usage: 28492 tokens
```

```
# build essay indexessay\_index = VectorStoreIndex.from\_documents(essay\_documents)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 17617 tokens> [build_index_from_nodes] Total embedding token usage: 17617 tokens
```
Set summaries for the indices[](#set-summaries-for-the-indices "Permalink to this heading")
--------------------------------------------------------------------------------------------

Add text summaries to indices, so we can compose other indices on top of it


```
nyc\_index\_summary = """ New York, often called New York City or NYC,  is the most populous city in the United States.  With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2),  New York City is also the most densely populated major city in the United States,  and is more than twice as populous as second-place Los Angeles.  New York City lies at the southern tip of New York State, and  constitutes the geographical and demographic center of both the  Northeast megalopolis and the New York metropolitan area, the  largest metropolitan area in the world by urban landmass.[8] With over  20.1 million people in its metropolitan statistical area and 23.5 million  in its combined statistical area as of 2020, New York is one of the world's  most populous megacities, and over 58 million people live within 250 mi (400 km) of  the city. New York City is a global cultural, financial, and media center with  a significant influence on commerce, health care and life sciences, entertainment,  research, technology, education, politics, tourism, dining, art, fashion, and sports.  Home to the headquarters of the United Nations,  New York is an important center for international diplomacy, an established safe haven for global investors, and is sometimes described as the capital of the world."""essay\_index\_summary = """ Author: Paul Graham.  The author grew up painting and writing essays.  He wrote a book on Lisp and did freelance Lisp hacking work to support himself.  He also became the de facto studio assistant for Idelle Weber, an early photorealist painter.  He eventually had the idea to start a company to put art galleries online, but the idea was unsuccessful.  He then had the idea to write software to build online stores, which became the basis for his successful company, Viaweb.  After Viaweb was acquired by Yahoo!, the author returned to painting and started writing essays online.  He wrote a book of essays, Hackers & Painters, and worked on spam filters.  He also bought a building in Cambridge to use as an office.  He then had the idea to start Y Combinator, an investment firm that would  make a larger number of smaller investments and help founders remain as CEO.  He and his partner Jessica Livingston ran Y Combinator and funded a batch of startups twice a year.  He also continued to write essays, cook for groups of friends, and explore the concept of invented vs discovered in software. """
```
Build Keyword Table Index on top of tree indices![](#build-keyword-table-index-on-top-of-tree-indices "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------

We set summaries for each of the NYC and essay indices, and then compose a keyword index on top of it.


```
from llama\_index.indices.composability import ComposableGraph
```

```
graph = ComposableGraph.from\_indices(    SimpleKeywordTableIndex,    [nyc\_index, essay\_index],    index\_summaries=[nyc\_index\_summary, essay\_index\_summary],    max\_keywords\_per\_chunk=50,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens
```

```
# set Logging to DEBUG for more detailed outputs# ask it a question about NYCquery\_engine = graph.as\_query\_engine()response = query\_engine.query(    "What is the climate of New York City like? How cold is it during the"    " winter?",)
```

```
INFO:llama_index.indices.keyword_table.retrievers:> Starting query: What is the climate of New York City like? How cold is it during the winter?> Starting query: What is the climate of New York City like? How cold is it during the winter?INFO:llama_index.indices.keyword_table.retrievers:query keywords: ['cold', 'new york city', 'winter', 'new', 'city', 'climate', 'york']query keywords: ['cold', 'new york city', 'winter', 'new', 'city', 'climate', 'york']INFO:llama_index.indices.keyword_table.retrievers:> Extracted keywords: ['new', 'city', 'york']> Extracted keywords: ['new', 'city', 'york']INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 18 tokens> [retrieve] Total embedding token usage: 18 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 3834 tokens> [get_response] Total LLM token usage: 3834 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 282 tokens> [get_response] Total LLM token usage: 282 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))
```

```
The climate of New York City is humid subtropical, with hot and humid summers and cold, wet winters. The average temperature in the winter is around 32°F (0°C), but temperatures can drop below freezing. Snowfall is common in the winter months, with an average of 25 inches (63 cm) of snow per year.
```

```
# Get source of responseprint(response.get\_formatted\_sources())
```

```
> Source (Doc id: b58b74a6-c0c8-4020-8076-fdcd265dc7a3): The climate of New York City is humid subtropical, with hot and humid summers and cold, wet win...> Source (Doc id: e92aafcf-08c2-4a8c-897b-930ad420179a): one of the world's highest. New York City real estate is a safe haven for global investors.===...
```

```
# ask it a question about PG's essayresponse = query\_engine.query(    "What did the author do growing up, before his time at Y Combinator?",)
```

```
INFO:llama_index.indices.keyword_table.retrievers:> Starting query: What did the author do growing up, before his time at Y Combinator?> Starting query: What did the author do growing up, before his time at Y Combinator?INFO:llama_index.indices.keyword_table.retrievers:query keywords: ['growing up', 'y combinator', 'time', 'growing', 'author', 'combinator']query keywords: ['growing up', 'y combinator', 'time', 'growing', 'author', 'combinator']INFO:llama_index.indices.keyword_table.retrievers:> Extracted keywords: ['author', 'combinator']> Extracted keywords: ['author', 'combinator']INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 17 tokens> [retrieve] Total embedding token usage: 17 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 3947 tokens> [get_response] Total LLM token usage: 3947 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 218 tokens> [get_response] Total LLM token usage: 218 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```

```
print(str(response))
```

```
The author likely grew up doing a variety of activities, such as writing essays, painting, cooking, writing software, and hosting dinners for friends. He may have also been involved in giving talks and was likely driven by the idea of working hard to set the upper bound for everyone else.
```

```
# Get source of responseprint(response.get\_formatted\_sources())
```

```
> Source (Doc id: 92bc5ce3-3a76-4570-9726-f7e0405ec6cc): Before his time at Y Combinator, the author worked on building the infrastructure of the web, wr...> Source (Doc id: ed37130a-3138-42d4-9e77-1c792fe22f4e): write something and put it on the web, anyone can read it. That may seem obvious now, but it was ...
```
