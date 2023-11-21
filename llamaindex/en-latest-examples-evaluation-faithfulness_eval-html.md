Faithfulness Evaluator[](#faithfulness-evaluator "Permalink to this heading")
==============================================================================

This notebook uses the `FaithfulnessEvaluator` module to measure if the response from a query engine matches any source nodes.  
This is useful for measuring if the response was hallucinated.  
The data is extracted from the [New York City](https://en.wikipedia.org/wiki/New_York_City) wikipedia page.


```
# attach to the same event-loopimport nest\_asyncionest\_asyncio.apply()
```

```
# configuring logger to INFO levelimport loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import (    TreeIndex,    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index.evaluation import FaithfulnessEvaluatorimport pandas as pdpd.set\_option("display.max\_colwidth", 0)
```
Using GPT-4 here for evaluation


```
# gpt-4gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4 = FaithfulnessEvaluator(service\_context=service\_context\_gpt4)
```

```
documents = SimpleDirectoryReader("./test\_wiki\_data/").load\_data()
```

```
# create vector indexservice\_context = ServiceContext.from\_defaults(chunk\_size=512)vector\_index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
# define jupyter display functiondef display\_eval\_df(response: Response, eval\_result: str) -> None:    if response.source\_nodes == []:        print("no response!")        return    eval\_df = pd.DataFrame(        {            "Response": str(response),            "Source": response.source\_nodes[0].node.text[:1000] + "...",            "Evaluation Result": "Pass" if eval\_result.passing else "Fail",        },        index=[0],    )    eval\_df = eval\_df.style.set\_properties(        \*\*{            "inline-size": "600px",            "overflow-wrap": "break-word",        },        subset=["Response", "Source"]    )    display(eval\_df)
```
To run evaluations you can call the `.evaluate\_response()` function on the `Response` object return from the query to run the evaluations. Lets evaluate the outputs of the vector\_index.


```
query\_engine = vector\_index.as\_query\_engine()response\_vector = query\_engine.query("How did New York City get its name?")eval\_result = evaluator\_gpt4.evaluate\_response(response=response\_vector)
```

```
display\_eval\_df(response\_vector, eval\_result)
```


|  | Response | Source | Evaluation Result |
| --- | --- | --- | --- |
| 0 | New York City got its name from the English explorer Henry Hudson, who rediscovered New York Harbor in 1609 while searching for the Northwest Passage. He named the area New York after the Duke of York, who later became King James II of England. | He claimed the area for France and named it Nouvelle Angoulême (New Angoulême).A Spanish expedition, led by the Portuguese captain Estêvão Gomes sailing for Emperor Charles V, arrived in New York Harbor in January 1525 and charted the mouth of the Hudson River, which he named Río de San Antonio ('Saint Anthony's River').The Padrón Real of 1527, the first scientific map to show the East Coast of North America continuously, was informed by Gomes' expedition and labeled the northeastern United States as Tierra de Esteban Gómez in his honor.In 1609, the English explorer Henry Hudson rediscovered New York Harbor while searching for the Northwest Passage to the Orient for the Dutch East India Company.He proceeded to sail up what the Dutch would name the North River (now the Hudson River), named first by Hudson as the Mauritius after Maurice, Prince of Orange.Hudson's first mate described the harbor as "a very good Harbour for all windes" and the river as "a mile broad" and "full of fish".Hud... | Fail |

Benchmark on Generated Question[](#benchmark-on-generated-question "Permalink to this heading")
------------------------------------------------------------------------------------------------

Now lets generate a few more questions so that we have more to evaluate with and run a small benchmark.


```
from llama\_index.evaluation import DatasetGeneratorquestion\_generator = DatasetGenerator.from\_documents(documents)eval\_questions = question\_generator.generate\_questions\_from\_nodes(5)eval\_questions
```

```
WARNING:llama_index.indices.service_context:chunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size insteadchunk_size_limit is deprecated, please specify chunk_size instead
```

```
['What is the population of New York City as of 2020?', 'Which borough of New York City is home to the headquarters of the United Nations?', 'How many languages are spoken in New York City, making it the most linguistically diverse city in the world?', 'Who founded the trading post on Manhattan Island that would later become New York City?', 'What was New York City named after in 1664?']
```

```
import asynciodef evaluate\_query\_engine(query\_engine, questions):    c = [query\_engine.aquery(q) for q in questions]    results = asyncio.run(asyncio.gather(\*c))    print("finished query")    total\_correct = 0    for r in results:        # evaluate with gpt 4        eval\_result = (            1 if evaluator\_gpt4.evaluate\_response(response=r).passing else 0        )        total\_correct += eval\_result    return total\_correct, len(results)
```

```
vector\_query\_engine = vector\_index.as\_query\_engine()correct, total = evaluate\_query\_engine(vector\_query\_engine, eval\_questions[:5])print(f"score: {correct}/{total}")
```

```
INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=b36e17a843c31e827f0b7034e603cf28 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=b36e17a843c31e827f0b7034e603cf28 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=b36e17a843c31e827f0b7034e603cf28 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=5acb726518065db9312da9f23beef411 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=5acb726518065db9312da9f23beef411 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=35 request_id=5acb726518065db9312da9f23beef411 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=46 request_id=4af43bfbe4e24fdae0ec33312ee7491e response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=46 request_id=4af43bfbe4e24fdae0ec33312ee7491e response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=46 request_id=4af43bfbe4e24fdae0ec33312ee7491e response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=37 request_id=e30413546fe5f96d3890606767f2ec53 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=37 request_id=e30413546fe5f96d3890606767f2ec53 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=37 request_id=e30413546fe5f96d3890606767f2ec53 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=33 request_id=01f0a8dada4dae80c97a9a412f03b84f response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=33 request_id=01f0a8dada4dae80c97a9a412f03b84f response_code=200message='OpenAI API response' path=https://api.openai.com/v1/embeddings processing_ms=33 request_id=01f0a8dada4dae80c97a9a412f03b84f response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=282 request_id=ed7b1f8ba68ae32b1d8e24e0d0764e86 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=282 request_id=ed7b1f8ba68ae32b1d8e24e0d0764e86 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=282 request_id=ed7b1f8ba68ae32b1d8e24e0d0764e86 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=820 request_id=b4532c6d665b6cfd644861ed69819cb9 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=820 request_id=b4532c6d665b6cfd644861ed69819cb9 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=820 request_id=b4532c6d665b6cfd644861ed69819cb9 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=847 request_id=4d9bbc71a95b7e0bb69a048e251772c8 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=847 request_id=4d9bbc71a95b7e0bb69a048e251772c8 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=847 request_id=4d9bbc71a95b7e0bb69a048e251772c8 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=952 request_id=d1657940d881929d500b1fddc46b5866 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=952 request_id=d1657940d881929d500b1fddc46b5866 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=952 request_id=d1657940d881929d500b1fddc46b5866 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=1482 request_id=c4456f75580d227f846d3a044e5eef1b response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=1482 request_id=c4456f75580d227f846d3a044e5eef1b response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=1482 request_id=c4456f75580d227f846d3a044e5eef1b response_code=200finished queryscore: 5/5
```
