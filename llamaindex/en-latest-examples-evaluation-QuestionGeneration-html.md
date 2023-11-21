[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/evaluation/QuestionGeneration.ipynb)

QuestionGeneration[](#questiongeneration "Permalink to this heading")
======================================================================

This notebook walks through the process of generating a list of questions that could be asked about your data. This is useful for setting up an evaluation pipeline using the `FaithfulnessEvaluator` and `RelevancyEvaluator` evaluation tools.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysimport pandas as pdlogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index.evaluation import DatasetGenerator, RelevancyEvaluatorfrom llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    ServiceContext,    LLMPredictor,    Response,)from llama\_index.llms import OpenAI
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load Data


```
reader = SimpleDirectoryReader("./data/paul\_graham/")documents = reader.load\_data()
```

```
data\_generator = DatasetGenerator.from\_documents(documents)
```

```
WARNING:llama_index.indices.service_context:chunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size instead
```

```
eval\_questions = data\_generator.generate\_questions\_from\_nodes()
```

```
eval\_questions
```

```
['What were the two main things the author worked on before college?', 'How did the author describe their early attempts at writing short stories?', 'What type of computer did the author first work on for programming?', 'What language did the author use for programming on the IBM 1401?', "What was the author's experience with programming on the 1401?", 'What type of computer did the author eventually get for themselves?', "What was the author's initial plan for college?", 'What made the author change their mind about studying philosophy?', "What sparked the author's interest in AI?", 'What did the author realize about AI during their first year of grad school?', 'What were the two art schools that the author applied to?', 'How did the author end up at RISD?', 'What was the purpose of the foundation classes at RISD?', 'How did the author manage to pass the entrance exam for the Accademia di Belli Arti?', 'What was the arrangement between the students and faculty at the Accademia?', "What was the author's experience painting still lives in Florence?", 'What did the author learn about visual perception while painting still lives?', 'Why did the author decide to leave the Accademia and return to the US?', 'What did the author learn about technology companies while working at Interleaf?', 'What lesson did the author learn about the low end and high end in the software industry?', "What was the author's motivation for writing another book on Lisp?", 'How did the author come up with the idea for starting a company to put art galleries online?', 'What was the initial reaction of art galleries to the idea of being online?', 'How did the author and his team come up with the concept of a web app?', 'What were the three main parts of the software developed by the author and his team?', 'How did the author and his team learn about retail and improve their software based on user feedback?', 'Why did the author initially believe that the absolute number of users was the most important factor for a startup?', "What was the growth rate of the author's company and why was it significant?", "How did the author's decision to hire more people impact the financial stability of the company?", "What was the outcome of the company's acquisition by Yahoo in 1998?", "What was the author's initial reaction when Yahoo bought their startup?", "How did the author's lifestyle change after Yahoo bought their startup?", 'Why did the author leave Yahoo and what did they plan to do?', "What was the author's experience like when they returned to New York after becoming rich?", 'What idea did the author have in the spring of 2000 and why did they decide to start a new company?', "Why did the author decide to build a subset of the new company's vision as an open source project?", "How did the author's perception of publishing essays change with the advent of the internet?", "What is the author's perspective on working on things that are not prestigious?", 'What other projects did the author work on besides writing essays?', 'What type of building did the author buy in Cambridge?', "What was the concept behind the big party at the narrator's house in October 2003?", "How did Jessica Livingston's perception of startups change after meeting friends of the narrator?", 'What were some of the ideas that the narrator shared with Jessica about fixing venture capital?', 'How did the idea of starting their own investment firm come about for the narrator and Jessica?', 'What was the Summer Founders Program and how did it attract applicants?', "How did Y Combinator's batch model help solve the problem of isolation for startup founders?", "What advantages did YC's scale bring, both in terms of community and customer acquisition?", 'Why did the narrator consider Hacker News to be a source of stress?', "How did the narrator's role in YC differ from other types of work they had done?", 'What advice did Robert Morris offer the narrator during his visit in 2010?', 'What was the advice given to the author by Rtm regarding their involvement with Y Combinator?', 'Why did the author decide to hand over Y Combinator to someone else?', "What event in the author's personal life prompted them to reevaluate their priorities?", 'How did the author spend most of 2014?', 'What project did the author work on from March 2015 to October 2019?', 'How did the author manage to write an interpreter for Lisp in itself?', "What was the author's experience like living in England?", "When was the author's project, Bel, finally finished?", 'What did the author do during the fall of 2019?', "How would you describe the author's journey and decision-making process throughout the document?", "How did the author's experience with editing Lisp expressions differ from traditional app editing?", 'Why did the author receive negative comments when claiming that Lisp was better than other languages?', 'What is the difference between putting something online and publishing it online?', 'How did the customs of venture capital practice and essay writing reflect outdated constraints?', 'Why did Y Combinator change its name to avoid a regional association?', "What was the significance of the orange color chosen for Y Combinator's logo?", 'Why did Y Combinator become a fund for a couple of years before returning to self-funding?', 'What is the purpose of Y Combinator in relation to the concept of "deal flow"?', 'How did the combination of running a forum and writing essays lead to a problem for the author?', "What was the author's biggest regret about leaving Y Combinator?"]
```

```
# gpt-4gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)
```

```
evaluator\_gpt4 = RelevancyEvaluator(service\_context=service\_context\_gpt4)
```

```
# create vector indexvector\_index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context\_gpt4)
```

```
# define jupyter display functiondef display\_eval\_df(query: str, response: Response, eval\_result: str) -> None:    eval\_df = pd.DataFrame(        {            "Query": query,            "Response": str(response),            "Source": (                response.source\_nodes[0].node.get\_content()[:1000] + "..."            ),            "Evaluation Result": eval\_result,        },        index=[0],    )    eval\_df = eval\_df.style.set\_properties(        \*\*{            "inline-size": "600px",            "overflow-wrap": "break-word",        },        subset=["Response", "Source"]    )    display(eval\_df)
```

```
query\_engine = vector\_index.as\_query\_engine()response\_vector = query\_engine.query(eval\_questions[1])eval\_result = evaluator\_gpt4.evaluate\_response(    query=eval\_questions[1], response=response\_vector)
```

```
display\_eval\_df(eval\_questions[1], response\_vector, eval\_result)
```


|  | Query | Response | Source | Evaluation Result |
| --- | --- | --- | --- | --- |
| 0 | How did the author describe their early attempts at writing short stories? | The author described their early attempts at writing short stories as awful. They mentioned that their stories had hardly any plot and were mostly about characters with strong feelings, which they thought made the stories deep. | What I Worked OnFebruary 2021Before college the two main things I worked on, outside of school, were writing and programming. I didn't write essays. I wrote what beginning writers were supposed to write then, and probably still are: short stories. My stories were awful. They had hardly any plot, just characters with strong feelings, which I imagined made them deep.The first programs I tried writing were on the IBM 1401 that our school district used for what was then called "data processing." This was in 9th grade, so I was 13 or 14. The school district's 1401 happened to be in the basement of our junior high school, and my friend Rich Draves and I got permission to use it. It was like a mini Bond villain's lair down there, with all these alien-looking machines — CPU, disk drives, printer, card reader — sitting up on a raised floor under bright fluorescent lights.The language we used was an early version of Fortran. You had to type programs on punch cards, then stack them in the... | YES |

