BatchEvalRunner - Running Multiple Evaluations[](#batchevalrunner-running-multiple-evaluations "Permalink to this heading")
============================================================================================================================

The `BatchEvalRunner` class can be used to run a series of evaluations asynchronously. The async jobs are limited to a defined size of `num\_workers`.

Setup[](#setup "Permalink to this heading")
--------------------------------------------


```
# attach to the same event-loopimport nest\_asyncionest\_asyncio.apply()
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "YOUR\_API\_KEY"openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index.evaluation import (    FaithfulnessEvaluator,    RelevancyEvaluator,    CorrectnessEvaluator,)import pandas as pdpd.set\_option("display.max\_colwidth", 0)
```
Using GPT-4 here for evaluation


```
# gpt-4gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)faithfulness\_gpt4 = FaithfulnessEvaluator(service\_context=service\_context\_gpt4)relevancy\_gpt4 = RelevancyEvaluator(service\_context=service\_context\_gpt4)correctness\_gpt4 = CorrectnessEvaluator(service\_context=service\_context\_gpt4)
```

```
documents = SimpleDirectoryReader("./test\_wiki\_data/").load\_data()
```

```
# create vector indexllm = OpenAI(temperature=0.3, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)vector\_index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
Question Generation[](#question-generation "Permalink to this heading")
------------------------------------------------------------------------

To run evaluations in batch, you can create the runner and then call the `.aevaluate\_queries()` function on a list of queries.

First, we can generate some questions and then run evaluation on them.


```
from llama\_index.evaluation import DatasetGeneratordataset\_generator = DatasetGenerator.from\_documents(    documents, service\_context=service\_context)questions = dataset\_generator.generate\_questions\_from\_nodes(num=25)
```
Running Batch Evaluation[](#running-batch-evaluation "Permalink to this heading")
----------------------------------------------------------------------------------

Now, we can run our batch evaluation!


```
from llama\_index.evaluation import BatchEvalRunnerrunner = BatchEvalRunner(    {"faithfulness": faithfulness\_gpt4, "relevancy": relevancy\_gpt4},    workers=8,)eval\_results = await runner.aevaluate\_queries(    vector\_index.as\_query\_engine(), queries=questions)# If we had ground-truth answers, we could also include the correctness evaluator like below.# The correctness evaluator depends on additional kwargs, which are passed in as a dictionary.# Each question is mapped to a set of kwargs## runner = BatchEvalRunner(# {'faithfulness': faithfulness\_gpt4, 'relevancy': relevancy\_gpt4, 'correctness': correctness\_gpt4},# workers=8,# )## eval\_results = await runner.aevaluate\_queries(# vector\_index.as\_query\_engine(),# queries=questions,# query\_kwargs={'question': {'reference': 'ground-truth answer', ...}}# )
```
Inspecting Outputs[](#inspecting-outputs "Permalink to this heading")
----------------------------------------------------------------------


```
print(eval\_results.keys())print(eval\_results["faithfulness"][0].dict().keys())print(eval\_results["faithfulness"][0].passing)print(eval\_results["faithfulness"][0].response)print(eval\_results["faithfulness"][0].contexts)
```

```
dict_keys(['faithfulness', 'relevancy'])dict_keys(['query', 'contexts', 'response', 'passing', 'feedback', 'score'])TrueThe population of New York City as of 2020 is 8,804,190.["== Demographics ==\n\nNew York City is the most populous city in the United States, with 8,804,190 residents incorporating more immigration into the city than outmigration since the 2010 United States census. More than twice as many people live in New York City as compared to Los Angeles, the second-most populous U.S. city; and New York has more than three times the population of Chicago, the third-most populous U.S. city. New York City gained more residents between 2010 and 2020 (629,000) than any other U.S. city, and a greater amount than the total sum of the gains over the same decade of the next four largest U.S. cities, Los Angeles, Chicago, Houston, and Phoenix, Arizona combined. New York City's population is about 44% of New York State's population, and about 39% of the population of the New York metropolitan area. The majority of New York City residents in 2020 (5,141,538, or 58.4%) were living on Long Island, in Brooklyn, or in Queens. The New York City metropolitan statistical area, has the largest foreign-born population of any metropolitan region in the world. The New York region continues to be by far the leading metropolitan gateway for legal immigrants admitted into the United States, substantially exceeding the combined totals of Los Angeles and Miami.\n\n\n=== Population density ===\n\nIn 2020, the city had an estimated population density of 29,302.37 inhabitants per square mile (11,313.71/km2), rendering it the nation's most densely populated of all larger municipalities (those with more than 100,000 residents), with several small cities (of fewer than 100,000) in adjacent Hudson County, New Jersey having greater density, as per the 2010 census. Geographically co-extensive with New York County, the borough of Manhattan's 2017 population density of 72,918 inhabitants per square mile (28,154/km2) makes it the highest of any county in the United States and higher than the density of any individual American city. The next three densest counties in the United States, placing second through fourth, are also New York boroughs: Brooklyn, the Bronx, and Queens respectively.", "New York, often called New York City or NYC, is the most populous city in the United States. With a 2020 population of 8,804,190 distributed over 300.46 square miles (778.2 km2), New York City is the most densely populated major city in the United States and more than twice as populous as Los Angeles, the nation's second-largest city. New York City is located at the southern tip of New York State. It constitutes the geographical and demographic center of both the Northeast megalopolis and the New York metropolitan area, the largest metropolitan area in the U.S. by both population and urban area. With over 20.1 million people in its metropolitan statistical area and 23.5 million in its combined statistical area as of 2020, New York is one of the world's most populous megacities, and over 58 million people live within 250 mi (400 km) of the city. New York City is a global cultural, financial, entertainment, and media center with a significant influence on commerce, health care and life sciences, research, technology, education, politics, tourism, dining, art, fashion, and sports. Home to the headquarters of the United Nations, New York is an important center for international diplomacy, and is sometimes described as the capital of the world.Situated on one of the world's largest natural harbors and extending into the Atlantic Ocean, New York City comprises five boroughs, each of which is coextensive with a respective county of the state of New York. The five boroughs, which were created in 1898 when local governments were consolidated into a single municipal entity, are: Brooklyn (in Kings County), Queens (in Queens County), Manhattan (in New York County), The Bronx (in Bronx County), and Staten Island (in Richmond County).As of 2021, the New York metropolitan area is the largest metropolitan economy in the world with a gross metropolitan product of over $2.4 trillion. If the New York metropolitan area were a sovereign state, it would have the eighth-largest economy in the world. New York City is an established safe haven for global investors. New York is home to the highest number of billionaires, individuals of ultra-high net worth (greater than US$30 million), and millionaires of any city in the world.\nThe city and its metropolitan area constitute the premier gateway for legal immigration to the United States."]
```
Reporting Total Scores[](#reporting-total-scores "Permalink to this heading")
------------------------------------------------------------------------------


```
def get\_eval\_results(key, eval\_results):    results = eval\_results[key]    correct = 0    for result in results:        if result.passing:            correct += 1    score = correct / len(results)    print(f"{key} Score: {score}")    return score
```

```
score = get\_eval\_results("faithfulness", eval\_results)
```

```
faithfulness Score: 1.0
```

```
score = get\_eval\_results("relevancy", eval\_results)
```

```
relevancy Score: 0.96
```
