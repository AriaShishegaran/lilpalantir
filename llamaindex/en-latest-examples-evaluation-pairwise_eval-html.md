Pairwise Evaluator[](#pairwise-evaluator "Permalink to this heading")
======================================================================

This notebook uses the `PairwiseEvaluator` module to see if an evaluation LLM would prefer one query engine over another.


```
# attach to the same event-loopimport nest\_asyncionest\_asyncio.apply()
```

```
# configuring logger to INFO levelimport loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    Response,)from llama\_index.llms import OpenAIfrom llama\_index.evaluation import PairwiseComparisonEvaluatorimport pandas as pdpd.set\_option("display.max\_colwidth", 0)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.NumExpr defaulting to 8 threads.
```
Using GPT-4 here for evaluation


```
# gpt-4gpt4 = OpenAI(temperature=0, model="gpt-4")service\_context\_gpt4 = ServiceContext.from\_defaults(llm=gpt4)evaluator\_gpt4 = PairwiseComparisonEvaluator(    service\_context=service\_context\_gpt4)
```

```
documents = SimpleDirectoryReader("./test\_wiki\_data/").load\_data()
```

```
# create vector indexservice\_context1 = ServiceContext.from\_defaults(chunk\_size=512)vector\_index1 = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context1)service\_context2 = ServiceContext.from\_defaults(chunk\_size=128)vector\_index2 = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context2)
```

```
query\_engine1 = vector\_index1.as\_query\_engine(similarity\_top\_k=2)query\_engine2 = vector\_index2.as\_query\_engine(similarity\_top\_k=8)
```

```
# define jupyter display functiondef display\_eval\_df(query, response1, response2, eval\_result) -> None:    eval\_df = pd.DataFrame(        {            "Query": query,            "Reference Response (Answer 1)": response2,            "Current Response (Answer 2)": response1,            "Score": eval\_result.score,            "Reason": eval\_result.feedback,        },        index=[0],    )    eval\_df = eval\_df.style.set\_properties(        \*\*{            "inline-size": "300px",            "overflow-wrap": "break-word",        },        subset=["Current Response (Answer 2)", "Reference Response (Answer 1)"]    )    display(eval\_df)
```
To run evaluations you can call the `.evaluate\_response()` function on the `Response` object return from the query to run the evaluations. Lets evaluate the outputs of the vector\_index.


```
# query\_str = "How did New York City get its name?"query\_str = "What was the role of NYC during the American Revolution?"# query\_str = "Tell me about the arts and culture of NYC"response1 = str(query\_engine1.query(query\_str))response2 = str(query\_engine2.query(query\_str))
```
By default, we enforce “consistency” in the pairwise comparison.

We try feeding in the candidate, reference pair, and then swap the order of the two, and make sure that the results are still consistent (or return a TIE if not).


```
eval\_result = await evaluator\_gpt4.aevaluate(    query\_str, response=response1, reference=response2)
```

```
INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=5536 request_id=8a8f154ee676b2e86ea24b7046e9b80b response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=5536 request_id=8a8f154ee676b2e86ea24b7046e9b80b response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=9766 request_id=dfee84227112b1311b4411492f4c8764 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=9766 request_id=dfee84227112b1311b4411492f4c8764 response_code=200
```

```
display\_eval\_df(query\_str, response1, response2, eval\_result)
```


|  | Query | Reference Response (Answer 1) | Current Response (Answer 2) | Score | Reason |
| --- | --- | --- | --- | --- | --- |
| 0 | What was the role of NYC during the American Revolution? | During the American Revolution, New York City served as a significant military and political base of operations for the British forces. After the Battle of Long Island in 1776, in which the Americans were defeated, the British made the city their center of operations in North America. The city was regained by the Dutch in 1673 but was renamed New York in 1674. It became the capital of the United States from 1785 to 1790. Additionally, New York City was a haven for Loyalist refugees and escaped slaves who joined the British lines for freedom. The British forces transported thousands of freedmen for resettlement in Nova Scotia and other locations, including England and the Caribbean. | During the American Revolution, New York City served as the military and political base of operations for the British in North America. It was also a haven for Loyalist refugees and escaped slaves who joined the British lines in search of freedom. The city played a significant role in the war, with the Battle of Long Island being the largest battle of the American Revolutionary War fought within its modern-day borough of Brooklyn. After the war, when the British forces evacuated, they transported freedmen to Nova Scotia, England, and the Caribbean for resettlement. | 0.500000 | It is not clear which answer is better. |

**NOTE**: By default, we enforce consensus by flipping the order of response/reference and making sure that the answers are opposites.

We can disable this - which can lead to more inconsistencies!


```
evaluator\_gpt4\_nc = PairwiseComparisonEvaluator(    service\_context=service\_context\_gpt4, enforce\_consensus=False)
```

```
eval\_result = await evaluator\_gpt4\_nc.aevaluate(    query\_str, response=response1, reference=response2)
```

```
INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6714 request_id=472a1f0829846adc1b4347ba4b99c0dd response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6714 request_id=472a1f0829846adc1b4347ba4b99c0dd response_code=200
```

```
display\_eval\_df(query\_str, response1, response2, eval\_result)
```


|  | Query | Reference Response (Answer 1) | Current Response (Answer 2) | Score | Reason |
| --- | --- | --- | --- | --- | --- |
| 0 | What was the role of NYC during the American Revolution? | During the American Revolution, New York City served as a significant military and political base of operations for the British forces. After the Battle of Long Island in 1776, in which the Americans were defeated, the British made the city their center of operations in North America. The city was regained by the Dutch in 1673 but was renamed New York in 1674. It became the capital of the United States from 1785 to 1790. Additionally, New York City was a haven for Loyalist refugees and escaped slaves who joined the British lines for freedom. The British forces transported thousands of freedmen for resettlement in Nova Scotia and other locations, including England and the Caribbean. | During the American Revolution, New York City served as the military and political base of operations for the British in North America. It was also a haven for Loyalist refugees and escaped slaves who joined the British lines in search of freedom. The city played a significant role in the war, with the Battle of Long Island being the largest battle of the American Revolutionary War fought within its modern-day borough of Brooklyn. After the war, when the British forces evacuated, they transported freedmen to Nova Scotia, England, and the Caribbean for resettlement. | 0.000000 | 1Answer 1 is better because it provides more detailed information about the role of New York City during the American Revolution. It not only mentions the city's role as a British base and a haven for Loyalist refugees and escaped slaves, but also provides additional historical context such as the city being renamed and becoming the capital of the United States. |


```
eval\_result = await evaluator\_gpt4\_nc.aevaluate(    query\_str, response=response2, reference=response1)
```

```
INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=9252 request_id=b73bbe6b10d878ed8138785638232866 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=9252 request_id=b73bbe6b10d878ed8138785638232866 response_code=200
```

```
display\_eval\_df(query\_str, response2, response1, eval\_result)
```


|  | Query | Reference Response (Answer 1) | Current Response (Answer 2) | Score | Reason |
| --- | --- | --- | --- | --- | --- |
| 0 | What was the role of NYC during the American Revolution? | During the American Revolution, New York City served as the military and political base of operations for the British in North America. It was also a haven for Loyalist refugees and escaped slaves who joined the British lines in search of freedom. The city played a significant role in the war, with the Battle of Long Island being the largest battle of the American Revolutionary War fought within its modern-day borough of Brooklyn. After the war, when the British forces evacuated, they transported freedmen to Nova Scotia, England, and the Caribbean for resettlement. | During the American Revolution, New York City served as a significant military and political base of operations for the British forces. After the Battle of Long Island in 1776, in which the Americans were defeated, the British made the city their center of operations in North America. The city was regained by the Dutch in 1673 but was renamed New York in 1674. It became the capital of the United States from 1785 to 1790. Additionally, New York City was a haven for Loyalist refugees and escaped slaves who joined the British lines for freedom. The British forces transported thousands of freedmen for resettlement in Nova Scotia and other locations, including England and the Caribbean. | 0.000000 | 1Answer 1 is better because it directly addresses the user's query about the role of NYC during the American Revolution. It provides a more detailed and accurate account of the city's role, including its status as a British base, a haven for Loyalist refugees and escaped slaves, and the site of the Battle of Long Island. Answer 2 includes some irrelevant information about the city being regained by the Dutch and renamed, which occurred before the American Revolution, and its status as the capital of the United States, which happened after the Revolution. |

Running on some more Queries[](#running-on-some-more-queries "Permalink to this heading")
------------------------------------------------------------------------------------------


```
query\_str = "Tell me about the arts and culture of NYC"response1 = str(query\_engine1.query(query\_str))response2 = str(query\_engine2.query(query\_str))
```

```
eval\_result = await evaluator\_gpt4.aevaluate(    query\_str, response=response1, reference=response2)
```

```
INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6053 request_id=749fdbde59bf8d1056a8be6e211d20d9 response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=6053 request_id=749fdbde59bf8d1056a8be6e211d20d9 response_code=200INFO:openai:message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=7309 request_id=ba09bb38320b60cf09dbebb1df2c732b response_code=200message='OpenAI API response' path=https://api.openai.com/v1/chat/completions processing_ms=7309 request_id=ba09bb38320b60cf09dbebb1df2c732b response_code=200
```

```
display\_eval\_df(query\_str, response1, response2, eval\_result)
```


|  | Query | Reference Response (Answer 1) | Current Response (Answer 2) | Score | Reason |
| --- | --- | --- | --- | --- | --- |
| 0 | Tell me about the arts and culture of NYC | New York City is known for its vibrant arts and culture scene. It is home to over 2,000 arts and cultural organizations, as well as more than 500 art galleries. The city has a rich history of cultural institutions, such as Carnegie Hall and the Metropolitan Museum of Art, which are internationally renowned. The Broadway musical, a popular stage form, originated in New York City in the 1880s. The city has also been a hub for Jewish American literature and has been the birthplace of various cultural movements, including the Harlem Renaissance, abstract expressionism, and hip-hop. New York City is considered the dance capital of the world and has a thriving theater scene. The city is also known for its museums, including the Guggenheim and the Metropolitan Museum of Art, which participate in the annual Museum Mile Festival. Additionally, New York City hosts some of the world's most lucrative art auctions. Lincoln Center for the Performing Arts is a major cultural hub, housing influential arts organizations such as the Metropolitan Opera and the New York Philharmonic. Overall, New York City is often regarded as the cultural capital of the world. | New York City is known for its vibrant arts and culture scene. It is home to numerous influential arts organizations, including the Metropolitan Opera, New York City Opera, New York Philharmonic, and New York City Ballet. The city also has a thriving theater district, with Broadway shows selling billions of dollars worth of tickets each season. Additionally, there are over 2,000 arts and cultural organizations and more than 500 art galleries in the city. New York City has a rich history of cultural institutions, such as Carnegie Hall and the Metropolitan Museum of Art, which are internationally renowned. The city's arts and culture have been strongly influenced by its diverse immigrant population, and many plays and musicals are set in or inspired by New York City itself. | 0.000000 | 1Answer 1 provides a more comprehensive and detailed response to the user's query about the arts and culture of NYC. It not only mentions the city's major cultural institutions and organizations, but also discusses the city's role in various cultural movements, its status as the dance capital of the world, its museums, and its art auctions. It also mentions the annual Museum Mile Festival, which Answer 2 does not. |

