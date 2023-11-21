[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/router/router_finetune.ipynb)

Router Fine-tuning[](#router-fine-tuning "Permalink to this heading")
======================================================================

In this notebook, we experiment with fine-tuning an LLM-powered router. We try a few different approaches, with query + ground-truth “choice” as the training signal.

1. Fine-tuning embeddings
2. Fine-tuning a cross-encoder

Our dataset will be Wikipedia articles of different cities.

We will generate a synthetic dataset for each approach to fine-tune over. We will also run some basic evaluations.


```
import nest\_asyncionest\_asyncio.apply()
```
If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
!pip install spacy
```
Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
wiki\_titles = [    "Toronto",    "Seattle",    "Chicago",    "Boston",    "Houston",    "Tokyo",    "Berlin",    "Lisbon",]
```

```
from pathlib import Pathimport requestsfor title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```

```
from llama\_index import SimpleDirectoryReader# Load all wiki documentscity\_docs = {}for wiki\_title in wiki\_titles:    city\_docs[wiki\_title] = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()
```

```
from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIgpt\_35\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo", temperature=0.3))
```

```
# define descriptions/choices for toolscity\_descs\_dict = {}# these choices will be passed to the router selectorchoices = []choice\_to\_id\_dict = {}for idx, wiki\_title in enumerate(wiki\_titles):    vector\_desc = (        "Useful for questions related to specific aspects of"        f" {wiki\_title} (e.g. the history, arts and culture,"        " sports, demographics, or more)."    )    summary\_desc = (        "Useful for any requests that require a holistic summary"        f" of EVERYTHING about {wiki\_title}. For questions about"        " more specific sections, please use the vector\_tool."    )    doc\_id\_vector = f"{wiki\_title}\_vector"    doc\_id\_summary = f"{wiki\_title}\_summary"    city\_descs\_dict[doc\_id\_vector] = vector\_desc    city\_descs\_dict[doc\_id\_summary] = summary\_desc    choices.extend([vector\_desc, summary\_desc])    choice\_to\_id\_dict[idx \* 2] = f"{wiki\_title}\_vector"    choice\_to\_id\_dict[idx \* 2 + 1] = f"{wiki\_title}\_summary"
```

```
from llama\_index.llms import OpenAIfrom llama\_index.prompts import PromptTemplatellm = OpenAI(model\_name="gpt-3.5-turbo")summary\_q\_tmpl = """\You are a summary question generator. Given an existing question which asks for a summary of a given topic, \generate {num\_vary} related queries that also ask for a summary of the topic.For example, assuming we're generating 3 related questions:Base Question: Can you tell me more about Boston?Question Variations:Give me an overview of Boston as a city.Can you describe different aspects of Boston, from the history to the sports scene to the food?Write a concise summary of Boston; I've never been.Now let's give it a shot! Base Question: {base\_question}Question Variations:"""summary\_q\_prompt = PromptTemplate(summary\_q\_tmpl)
```

```
from collections import defaultdictfrom llama\_index.evaluation import DatasetGeneratorfrom llama\_index.finetuning import EmbeddingQAFinetuneDatasetfrom llama\_index.node\_parser import SimpleNodeParserfrom tqdm.notebook import tqdmdef generate\_dataset(    wiki\_titles,    city\_descs\_dict,    llm,    summary\_q\_prompt,    num\_vector\_qs\_per\_node=2,    num\_summary\_qs=4,):    # generate dataset from each wikipedia page    queries = {}    corpus = {}    relevant\_docs = defaultdict(list)    for idx, wiki\_title in enumerate(tqdm(wiki\_titles)):        doc\_id\_vector = f"{wiki\_title}\_vector"        doc\_id\_summary = f"{wiki\_title}\_summary"        corpus[doc\_id\_vector] = city\_descs\_dict[doc\_id\_vector]        corpus[doc\_id\_summary] = city\_descs\_dict[doc\_id\_summary]        # generate questions for semantic search        node\_parser = SimpleNodeParser.from\_defaults()        nodes = node\_parser.get\_nodes\_from\_documents(city\_docs[wiki\_title])        dataset\_generator = DatasetGenerator(            nodes,            service\_context=gpt\_35\_context,            num\_questions\_per\_chunk=num\_vector\_qs\_per\_node,        )        doc\_questions = dataset\_generator.generate\_questions\_from\_nodes(            num=len(nodes) \* num\_vector\_qs\_per\_node        )        for query\_idx, doc\_question in enumerate(doc\_questions):            query\_id = f"{wiki\_title}\_{query\_idx}"            relevant\_docs[query\_id] = [doc\_id\_vector]            queries[query\_id] = doc\_question        # generate questions for summarization        base\_q = f"Give me a summary of {wiki\_title}"        fmt\_prompt = summary\_q\_prompt.format(            num\_vary=num\_summary\_qs,            base\_question=base\_q,        )        raw\_response = llm.complete(fmt\_prompt)        raw\_lines = str(raw\_response).split("\n")        doc\_summary\_questions = [l for l in raw\_lines if l != ""]        print(f"[{idx}] Original Question: {base\_q}")        print(            f"[{idx}] Generated Question Variations: {doc\_summary\_questions}"        )        for query\_idx, doc\_summary\_question in enumerate(            doc\_summary\_questions        ):            query\_id = f"{wiki\_title}\_{query\_idx}"            relevant\_docs[query\_id] = [doc\_id\_summary]            queries[query\_id] = doc\_summary\_question    return EmbeddingQAFinetuneDataset(        queries=queries, corpus=corpus, relevant\_docs=relevant\_docs    )
```

```
dataset = generate\_dataset(    wiki\_titles,    city\_descs\_dict,    llm,    summary\_q\_prompt,    num\_vector\_qs\_per\_node=4,    num\_summary\_qs=5,)
```

```
# dataset.queries
```

```
# [optional] savedataset.save\_json("dataset.json")
```

```
# [optional] loaddataset = EmbeddingQAFinetuneDataset.from\_json("dataset.json")
```

```
import randomdef split\_train\_val\_by\_query(dataset, split=0.7): """Split dataset by queries."""    query\_ids = list(dataset.queries.keys())    query\_ids\_shuffled = random.sample(query\_ids, len(query\_ids))    split\_idx = int(len(query\_ids) \* split)    train\_query\_ids = query\_ids\_shuffled[:split\_idx]    eval\_query\_ids = query\_ids\_shuffled[split\_idx:]    train\_queries = {qid: dataset.queries[qid] for qid in train\_query\_ids}    eval\_queries = {qid: dataset.queries[qid] for qid in eval\_query\_ids}    train\_rel\_docs = {        qid: dataset.relevant\_docs[qid] for qid in train\_query\_ids    }    eval\_rel\_docs = {qid: dataset.relevant\_docs[qid] for qid in eval\_query\_ids}    train\_dataset = EmbeddingQAFinetuneDataset(        queries=train\_queries,        corpus=dataset.corpus,        relevant\_docs=train\_rel\_docs,    )    eval\_dataset = EmbeddingQAFinetuneDataset(        queries=eval\_queries,        corpus=dataset.corpus,        relevant\_docs=eval\_rel\_docs,    )    return train\_dataset, eval\_dataset
```

```
train\_dataset, eval\_dataset = split\_train\_val\_by\_query(dataset, split=0.7)
```
Fine-tuning Embeddings[](#fine-tuning-embeddings "Permalink to this heading")
------------------------------------------------------------------------------

In this section we try to fine-tune embeddings.


```
# generate embeddings datasetfrom llama\_index.finetuning import SentenceTransformersFinetuneEngine
```

```
finetune\_engine = SentenceTransformersFinetuneEngine(    train\_dataset,    model\_id="BAAI/bge-small-en",    model\_output\_path="test\_model3",    val\_dataset=eval\_dataset,    epochs=30,  # can set to higher (haven't tested))
```

```
finetune\_engine.finetune()
```

```
ft\_embed\_model = finetune\_engine.get\_finetuned\_model()
```

```
ft\_embed\_model
```

```
HuggingFaceEmbedding(model_name='test_model3', embed_batch_size=10, callback_manager=<llama_index.callbacks.base.CallbackManager object at 0x2f5ccd210>, tokenizer_name='test_model3', max_length=512, pooling='cls', normalize='True', query_instruction=None, text_instruction=None, cache_folder=None)
```
Run Evaluations[](#run-evaluations "Permalink to this heading")
----------------------------------------------------------------

In this section we evaluate the quality of our fine-tuned embedding model vs. our base model in selecting the right choice.

We plug both into our `EmbeddingSelector` abstraction.

We also compare against a base `LLMSingleSelector` using GPT-4.


```
# define baseline embedding modelfrom llama\_index.embeddings import resolve\_embed\_modelbase\_embed\_model = resolve\_embed\_model("local:BAAI/bge-small-en")
```

```
from llama\_index.selectors import EmbeddingSingleSelector, LLMSingleSelectorft\_selector = EmbeddingSingleSelector.from\_defaults(embed\_model=ft\_embed\_model)base\_selector = EmbeddingSingleSelector.from\_defaults(    embed\_model=base\_embed\_model)
```

```
import numpy as npdef run\_evals(eval\_dataset, selector, choices, choice\_to\_id\_dict):    # we just measure accuracy    eval\_pairs = eval\_dataset.query\_docid\_pairs    matches = []    for query, relevant\_doc\_ids in tqdm(eval\_pairs):        result = selector.select(choices, query)        # assume single selection for now        pred\_doc\_id = choice\_to\_id\_dict[result.inds[0]]        gt\_doc\_id = relevant\_doc\_ids[0]        matches.append(gt\_doc\_id == pred\_doc\_id)    return np.array(matches)
```

```
ft\_matches = run\_evals(eval\_dataset, ft\_selector, choices, choice\_to\_id\_dict)
```

```
np.mean(ft\_matches)
```

```
0.994413407821229
```

```
base\_matches = run\_evals(    eval\_dataset, base\_selector, choices, choice\_to\_id\_dict)
```

```
np.mean(base\_matches)
```

```
0.12849162011173185
```

```
# also try LLMfrom llama\_index.llms import OpenAIeval\_llm = OpenAI(model="gpt-3.5-turbo")llm\_selector = LLMSingleSelector.from\_defaults(    service\_context=ServiceContext.from\_defaults(llm=eval\_llm))
```

```
llm\_matches = run\_evals(eval\_dataset, llm\_selector, choices, choice\_to\_id\_dict)
```

```
np.mean(llm\_matches)
```

```
0.659217877094972
```

```
import pandas as pdeval\_df = pd.DataFrame(    {        "Base embedding model": np.mean(base\_matches),        "GPT-3.5": np.mean(llm\_matches),        "Fine-tuned embedding model": np.mean(ft\_matches),    },    index=["Match Rate"],)display(eval\_df)
```


|  | Base embedding model | GPT-3.5 | Fine-tuned embedding model |
| --- | --- | --- | --- |
| Match Rate | 0.128492 | 0.659218 | 0.994413 |

Plug into Router[](#plug-into-router "Permalink to this heading")
------------------------------------------------------------------

We plug this into our `RouterQueryEngine` as an `EmbeddingSelector` (by default, an `LLMSingleSelector` is used in our router query engine).


```
from llama\_index.query\_engine import RouterQueryEnginefrom llama\_index import SummaryIndex, VectorStoreIndexfrom llama\_index.tools.query\_engine import QueryEngineTool# define indexes/tools for wikipedia entriestools = []for idx, wiki\_title in enumerate(tqdm(wiki\_titles)):    doc\_id\_vector = f"{wiki\_title}\_vector"    doc\_id\_summary = f"{wiki\_title}\_summary"    vector\_index = VectorStoreIndex.from\_documents(city\_docs[wiki\_title])    summary\_index = SummaryIndex.from\_documents(city\_docs[wiki\_title])    vector\_tool = QueryEngineTool.from\_defaults(        query\_engine=vector\_index.as\_query\_engine(),        description=city\_descs\_dict[doc\_id\_vector],    )    summary\_tool = QueryEngineTool.from\_defaults(        query\_engine=summary\_index.as\_query\_engine(),        description=city\_descs\_dict[doc\_id\_summary],    )    tools.extend([vector\_tool, summary\_tool])
```

```
router\_query\_engine = RouterQueryEngine.from\_defaults(    selector=ft\_selector.from\_defaults(), query\_engine\_tools=tools)
```

```
response = router\_query\_engine.query(    "Tell me more about the sports teams in Toronto")
```

```
print(str(response))
```

```
Toronto is home to several professional sports teams. In hockey, there is the Toronto Maple Leafs, one of the NHL's Original Six clubs, and the Toronto Marlies of the American Hockey League. The city also has a rich history of hockey championships, with the Maple Leafs winning 13 Stanley Cup titles and the Toronto Marlboros and St. Michael's College School-based Ontario Hockey League teams winning a combined 12 Memorial Cup titles.In baseball, Toronto is represented by the Toronto Blue Jays, who have won two World Series titles. The Blue Jays play their home games at the Rogers Centre. In basketball, there is the Toronto Raptors, who entered the NBA in 1995 and have achieved success in recent years, including winning their first NBA title in 2019. The Raptors play their home games at Scotiabank Arena.In Canadian football, there is the Toronto Argonauts, which was founded in 1873 and has won 18 Grey Cup Canadian championship titles. The Argonauts play their home games at BMO Field.In soccer, there is the Toronto FC, who have won seven Canadian Championship titles and the MLS Cup in 2017. They share BMO Field with the Toronto Argonauts.Other sports teams in Toronto include the Toronto Rock in the National Lacrosse League, the Toronto Wolfpack in rugby league, the Toronto Rush in ultimate disc, and the Toronto Six in the National Women's Hockey League.Toronto has also hosted various sporting events, such as the Canadian Open tennis tournament, the Toronto Waterfront Marathon, the Grand Prix of Toronto car race, and the Pan American Games in 2015. Additionally, Toronto was named as one of the host cities for the 2026 FIFA World Cup.
```

```
response.source\_nodes[0].get\_content()
```

```
"=== Professional sports ===\nToronto is home to the Toronto Maple Leafs, one of the NHL's Original Six clubs, and has also served as home to the Hockey Hall of Fame since 1958. The city had a rich history of hockey championships. Along with the Maple Leafs' 13 Stanley Cup titles, the Toronto Marlboros and St. Michael's College School-based Ontario Hockey League teams, combined, have won a record 12 Memorial Cup titles. The Toronto Marlies of the American Hockey League also play in Toronto at Coca-Cola Coliseum and are the farm team for the Maple Leafs. The Toronto Six, the first Canadian franchise in the National Women's Hockey League, began play with the 2020–21 season.\nThe city is home to the Toronto Blue Jays MLB baseball team. The team has won two World Series titles (1992, 1993). The Blue Jays play their home games at the Rogers Centre in the downtown core. Toronto has a long history of minor-league professional baseball dating back to the 1800s, culminating in the Toronto Maple Leafs baseball team, whose owner first proposed an MLB team for Toronto.The Toronto Raptors basketball team entered the NBA in 1995, and have since earned eleven playoff spots and five Atlantic Division titles in 24 seasons. They won their first NBA title in 2019. The Raptors are the only NBA team with their own television channel, NBA TV Canada. They play their home games at Scotiabank Arena, which is shared with the Maple Leafs. In 2016, Toronto hosted the 65th NBA All-Star game, the first to be held outside the United States.\nThe city is represented in Canadian football by the CFL's Toronto Argonauts, which was founded in 1873. The club has won 18 Grey Cup Canadian championship titles. The club's home games are played at BMO Field.\n\nToronto is represented in soccer by the Toronto FC MLS team, who have won seven Canadian Championship titles, as well as the MLS Cup in 2017 and the Supporters' Shield for best regular season record, also in 2017. They share BMO Field with the Toronto Argonauts. Toronto has a high level of participation in soccer across the city at several smaller stadiums and fields. Toronto FC had entered the league as an expansion team in 2007.The Toronto Rock is the city's National Lacrosse League team. They won five National Lacrosse League Cup titles in seven years in the late 1990s and the first decade of the 21st century, appearing in an NLL-record five straight championship games from 1999 to 2003, and are first all-time in the number of Champion's Cups won. The Rock formerly shared the Scotiabank Arena with the Maple Leafs and the Raptors, However, the Toronto Rock moved to the nearby city of Hamilton while retaining its Toronto name.\nThe Toronto Wolfpack became Canada's first professional rugby league team and the world's first transatlantic professional sports team when they began play in the Rugby Football League's League One competition in 2017. Due to COVID-19 restrictions on international travel the team withdrew from the Super League in 2020 with its future uncertain. The rugby club's ownership changed in 2021, now 'Team Wolfpack' will play in the newly formed North American Rugby League tournament.Toronto is home to the Toronto Rush, a semi-professional ultimate team that competes in the American Ultimate Disc League (AUDL). Ultimate (disc), in Canada, has its beginning roots in Toronto, with 3300 players competing annually in the Toronto Ultimate Club (League).Toronto has hosted several National Football League (NFL) exhibition games at the Rogers Centre. Ted Rogers leased the Buffalo Bills from Ralph Wilson for the purposes of having the Bills play eight home games in the city between 2008 and 2013.\n\n\n=== Collegiate sports ===\nThe University of Toronto in downtown Toronto was where the first recorded college football game was held in November 1861. Many post-secondary institutions in Toronto are members of U Sports or the Canadian Collegiate Athletic Association, the former for universities and the latter for colleges.\nToronto was home to the International Bowl, an NCAA sanctioned post-season college football game that pitted a Mid-American Conference team against a Big East Conference team. From 2007 to 2010, the game was played at Rogers Centre annually in January."
```
