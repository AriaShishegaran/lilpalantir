[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/react_agent_with_query_engine.ipynb)

ReAct Agent with Query Engine Tools[](#react-agent-with-query-engine-tools "Permalink to this heading")
========================================================================================================

In this section, we show how to setup an agent powered by the ReAct loop for financial analysis.

The agent has access to two “tools”: one to query the 2021 Lyft 10-K and the other to query the 2021 Uber 10-K.

We try two different LLMs:

* gpt-3.5-turbo
* gpt-3.5-turbo-instruct

Note that you can plug in any LLM that exposes a text completion endpoint.

Build Query Engine Tools[](#build-query-engine-tools "Permalink to this heading")
----------------------------------------------------------------------------------


```
from llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    StorageContext,    load\_index\_from\_storage,)from llama\_index.tools import QueryEngineTool, ToolMetadata
```

```
try:    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/lyft"    )    lyft\_index = load\_index\_from\_storage(storage\_context)    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/uber"    )    uber\_index = load\_index\_from\_storage(storage\_context)    index\_loaded = Trueexcept:    index\_loaded = False
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
if not index\_loaded:    # load data    lyft\_docs = SimpleDirectoryReader(        input\_files=["./data/10k/lyft\_2021.pdf"]    ).load\_data()    uber\_docs = SimpleDirectoryReader(        input\_files=["./data/10k/uber\_2021.pdf"]    ).load\_data()    # build index    lyft\_index = VectorStoreIndex.from\_documents(lyft\_docs)    uber\_index = VectorStoreIndex.from\_documents(uber\_docs)    # persist index    lyft\_index.storage\_context.persist(persist\_dir="./storage/lyft")    uber\_index.storage\_context.persist(persist\_dir="./storage/uber")
```

```
lyft\_engine = lyft\_index.as\_query\_engine(similarity\_top\_k=3)uber\_engine = uber\_index.as\_query\_engine(similarity\_top\_k=3)
```

```
query\_engine\_tools = [    QueryEngineTool(        query\_engine=lyft\_engine,        metadata=ToolMetadata(            name="lyft\_10k",            description=(                "Provides information about Lyft financials for year 2021. "                "Use a detailed plain text question as input to the tool."            ),        ),    ),    QueryEngineTool(        query\_engine=uber\_engine,        metadata=ToolMetadata(            name="uber\_10k",            description=(                "Provides information about Uber financials for year 2021. "                "Use a detailed plain text question as input to the tool."            ),        ),    ),]
```
Setup ReAct Agent[](#setup-react-agent "Permalink to this heading")
--------------------------------------------------------------------

Here we setup two ReAct agents: one powered by standard gpt-3.5-turbo, and the other powered by gpt-3.5-turbo-instruct.


```
from llama\_index.agent import ReActAgentfrom llama\_index.llms import OpenAI
```

```
llm = OpenAI(model="gpt-3.5-turbo-0613")agent = ReActAgent.from\_tools(query\_engine\_tools, llm=llm, verbose=True)
```

```
response = agent.chat("What was Lyft's revenue growth in 2021?")print(str(response))
```

```
Thought: I need to use a tool to help me answer the question.Action: lyft\_10kAction Input: {'input': "What was Lyft's revenue growth in 2021?"}Observation: Lyft's revenue growth in 2021 was 36%.Response: Lyft's revenue growth in 2021 was 36%.Lyft's revenue growth in 2021 was 36%.
```
Run Some Example Queries[](#run-some-example-queries "Permalink to this heading")
----------------------------------------------------------------------------------

We run some example queries using the agent, showcasing some of the agent’s abilities to do chain-of-thought-reasoning and tool use to synthesize the right answer.

We also show queries.


```
response = agent.chat(    "Compare and contrast the revenue growth of Uber and Lyft in 2021, then"    " give an analysis")print(str(response))
```

```
Thought: I need to use a tool to help me compare the revenue growth of Uber and Lyft in 2021.Action: lyft\_10kAction Input: {'input': "What was Lyft's revenue growth in 2021?"}Observation: Lyft's revenue growth in 2021 was 36%.Thought: I need to use a tool to help me compare the revenue growth of Uber and Lyft in 2021.Action: uber\_10kAction Input: {'input': "What was Uber's revenue growth in 2021?"}Observation: Uber's revenue growth in 2021 was 57%.Response: In 2021, Lyft's revenue growth was 36% while Uber's revenue growth was 57%. This indicates that Uber experienced a higher revenue growth compared to Lyft in 2021.In 2021, Lyft's revenue growth was 36% while Uber's revenue growth was 57%. This indicates that Uber experienced a higher revenue growth compared to Lyft in 2021.
```
**Async execution**: Here we try another query with async execution


```
# Try another query with async executionimport nest\_asyncionest\_asyncio.apply()response = await agent.achat(    "Compare and contrast the risks of Uber and Lyft in 2021, then give an"    " analysis")print(str(response))
```
### Compare gpt-3.5-turbo vs. gpt-3.5-turbo-instruct[](#compare-gpt-3-5-turbo-vs-gpt-3-5-turbo-instruct "Permalink to this heading")

We compare the performance of the two agents in being able to answer some complex queries.

#### Taking a look at a turbo-instruct agent[](#taking-a-look-at-a-turbo-instruct-agent "Permalink to this heading")


```
llm\_instruct = OpenAI(model="gpt-3.5-turbo-instruct")agent\_instruct = ReActAgent.from\_tools(    query\_engine\_tools, llm=llm\_instruct, verbose=True)
```

```
response = agent\_instruct.chat("What was Lyft's revenue growth in 2021?")print(str(response))
```

```
Thought: I need to use a tool to help me answer the question.Action: lyft\_10kAction Input: {'input': "What was Lyft's revenue growth in 2021?"}Observation: Lyft's revenue growth in 2021 was 36%.Response: Lyft's revenue growth in 2021 was 36%.Lyft's revenue growth in 2021 was 36%.
```
#### Try more complex queries[](#try-more-complex-queries "Permalink to this heading")

We compare gpt-3.5-turbo with gpt-3.5-turbo-instruct agents on more complex queries.


```
response = agent.chat(    "Compare and contrast the revenue growth of Uber and Lyft in 2021, then"    " give an analysis")print(str(response))
```

```
Thought: I need to use a tool to help me compare the revenue growth of Uber and Lyft in 2021.Action: uber\_10kAction Input: {'input': "Please provide information about Uber's revenue growth in 2021."}Observation: Uber's revenue grew by 57% in 2021 compared to the previous year. This growth was primarily driven by an increase in Gross Bookings, with Delivery Gross Bookings increasing by 71% and Mobility Gross Bookings growing by 38%. The increase in Delivery Gross Bookings was due to higher demand for food delivery orders and expansion across U.S. and international markets. The growth in Mobility Gross Bookings was a result of increased Trip volumes as the business recovered from the impacts of COVID-19.Thought: I have information about Uber's revenue growth in 2021. Now I need to use a tool to get information about Lyft's revenue growth in 2021.Action: lyft\_10kAction Input: {'input': "Please provide information about Lyft's revenue growth in 2021."}Observation: Lyft's revenue increased by 36% in 2021 compared to the prior year.Response: In 2021, Uber experienced a higher revenue growth rate of 57% compared to Lyft's growth rate of 36%. This indicates that Uber had a stronger performance in terms of revenue growth during that period. The growth in Uber's revenue was primarily driven by an increase in Gross Bookings, with both Delivery and Mobility segments contributing to the growth. The increase in Delivery Gross Bookings was due to higher demand for food delivery services, while the growth in Mobility Gross Bookings was a result of increased trip volumes as the business recovered from the impacts of COVID-19.In 2021, Uber experienced a higher revenue growth rate of 57% compared to Lyft's growth rate of 36%. This indicates that Uber had a stronger performance in terms of revenue growth during that period. The growth in Uber's revenue was primarily driven by an increase in Gross Bookings, with both Delivery and Mobility segments contributing to the growth. The increase in Delivery Gross Bookings was due to higher demand for food delivery services, while the growth in Mobility Gross Bookings was a result of increased trip volumes as the business recovered from the impacts of COVID-19.
```

```
response = agent\_instruct.chat(    "Compare and contrast the revenue growth of Uber and Lyft in 2021, then"    " give an analysis")print(str(response))
```

```
Response: The revenue growth of Uber was higher than Lyft in 2021, with Uber experiencing a 74% growth compared to Lyft's 48%. This indicates that Uber may have had a stronger financial performance in 2021. However, further analysis is needed to fully understand the factors contributing to this difference.The revenue growth of Uber was higher than Lyft in 2021, with Uber experiencing a 74% growth compared to Lyft's 48%. This indicates that Uber may have had a stronger financial performance in 2021. However, further analysis is needed to fully understand the factors contributing to this difference.
```

```
response = agent.chat(    "Can you tell me about the risk factors of the company with the higher"    " revenue?")print(str(response))
```

```
Thought: I need to find out which company has higher revenue before I can provide information about its risk factors.Action: lyft\_10kAction Input: {'input': 'What is the revenue of Lyft in 2021?'}Observation: The revenue of Lyft in 2021 is $3,208,323,000.Thought: Now that I know Lyft has higher revenue, I can find information about its risk factors.Action: lyft\_10kAction Input: {'input': 'What are the risk factors of Lyft?'}Observation: Lyft faces numerous risk factors that could potentially harm its business, financial condition, and results of operations. These risk factors include general economic factors such as the impact of the COVID-19 pandemic, natural disasters, economic downturns, and political crises. Operational factors such as limited operating history, financial performance, competition, unpredictability of results, uncertainty regarding market growth, ability to attract and retain drivers and riders, insurance coverage, autonomous vehicle technology, reputation and brand, illegal or improper activity on the platform, accuracy of background checks, changes to pricing practices, growth management, security and privacy breaches, reliance on third parties, and ability to operate various programs and services. Additionally, Lyft faces risks related to its evolving business, including forecasting revenue and managing expenses, complying with laws and regulations, managing assets and expenses during the COVID-19 pandemic, capital expenditures, asset development and utilization, macroeconomic changes, reputation and brand management, growth and business operations, geographic expansion, talent acquisition and retention, platform development, and real estate portfolio management. Furthermore, Lyft's financial performance in recent periods may not be indicative of future performance, and achieving or maintaining profitability in the future is not guaranteed. The Express Drive program and Lyft Rentals program also expose Lyft to risks related to vehicle rental partners, residual value of vehicles, and payment processing.Response: Lyft faces numerous risk factors that could potentially harm its business, financial condition, and results of operations. These risk factors include general economic factors such as the impact of the COVID-19 pandemic, natural disasters, economic downturns, and political crises. Operational factors such as limited operating history, financial performance, competition, unpredictability of results, uncertainty regarding market growth, ability to attract and retain drivers and riders, insurance coverage, autonomous vehicle technology, reputation and brand, illegal or improper activity on the platform, accuracy of background checks, changes to pricing practices, growth management, security and privacy breaches, reliance on third parties, and ability to operate various programs and services. Additionally, Lyft faces risks related to its evolving business, including forecasting revenue and managing expenses, complying with laws and regulations, managing assets and expenses during the COVID-19 pandemic, capital expenditures, asset development and utilization, macroeconomic changes, reputation and brand management, growth and business operations, geographic expansion, talent acquisition and retention, platform development, and real estate portfolio management. Furthermore, Lyft's financial performance in recent periods may not be indicative of future performance, and achieving or maintaining profitability in the future is not guaranteed. The Express Drive program and Lyft Rentals program also expose Lyft to risks related to vehicle rental partners, residual value of vehicles, and payment processing.Lyft faces numerous risk factors that could potentially harm its business, financial condition, and results of operations. These risk factors include general economic factors such as the impact of the COVID-19 pandemic, natural disasters, economic downturns, and political crises. Operational factors such as limited operating history, financial performance, competition, unpredictability of results, uncertainty regarding market growth, ability to attract and retain drivers and riders, insurance coverage, autonomous vehicle technology, reputation and brand, illegal or improper activity on the platform, accuracy of background checks, changes to pricing practices, growth management, security and privacy breaches, reliance on third parties, and ability to operate various programs and services. Additionally, Lyft faces risks related to its evolving business, including forecasting revenue and managing expenses, complying with laws and regulations, managing assets and expenses during the COVID-19 pandemic, capital expenditures, asset development and utilization, macroeconomic changes, reputation and brand management, growth and business operations, geographic expansion, talent acquisition and retention, platform development, and real estate portfolio management. Furthermore, Lyft's financial performance in recent periods may not be indicative of future performance, and achieving or maintaining profitability in the future is not guaranteed. The Express Drive program and Lyft Rentals program also expose Lyft to risks related to vehicle rental partners, residual value of vehicles, and payment processing.
```

```
response = agent\_instruct.query(    "Can you tell me about the risk factors of the company with the higher"    " revenue?")print(str(response))
```

```
Response: The risk factors for the company with the higher revenue include competition, regulatory changes, and dependence on drivers.The risk factors for the company with the higher revenue include competition, regulatory changes, and dependence on drivers.
```
**Observation**: The turbo-instruct agent seems to do worse on agent reasoning compared to the regular turbo model. Of course, this is subject to further observation!

