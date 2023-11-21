OpenAI Assistant Agent[](#openai-assistant-agent "Permalink to this heading")
==============================================================================

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_assistant_agent.ipynb)

This shows you how to use our agent abstractions built on top of the [OpenAI Assistant API](https://platform.openai.com/docs/assistants/overview).


```
!pip install llama-index
```
Simple Agent (no external tools)[](#simple-agent-no-external-tools "Permalink to this heading")
------------------------------------------------------------------------------------------------

Here we show a simple example with the built-in code interpreter.

Let’s start by importing some simple building blocks.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
from llama\_index.agent import OpenAIAssistantAgent
```

```
agent = OpenAIAssistantAgent.from\_new(    name="Math Tutor",    instructions="You are a personal math tutor. Write and run code to answer math questions.",    openai\_tools=[{"type": "code\_interpreter"}],    instructions\_prefix="Please address the user as Jane Doe. The user has a premium account.",)
```

```
agent.thread\_id
```

```
'thread_ctzN0ZY3JUWETHhYxI3DiFSo'
```

```
response = agent.chat(    "I need to solve the equation `3x + 11 = 14`. Can you help me?")
```

```
print(str(response))
```

```
The solution to the equation \(3x + 11 = 14\) is \(x = 1\).
```
Assistant with Built-In Retrieval[](#assistant-with-built-in-retrieval "Permalink to this heading")
----------------------------------------------------------------------------------------------------

Let’s test the assistant by having it use the built-in OpenAI Retrieval tool over a user-uploaded file.

Here, we upload and pass in the file during assistant-creation time.

The other option is you can upload/pass the file-id in for a message in a given thread with `upload\_files` and `add\_message`.


```
from llama\_index.agent import OpenAIAssistantAgent
```

```
agent = OpenAIAssistantAgent.from\_new(    name="SEC Analyst",    instructions="You are a QA assistant designed to analyze sec filings.",    openai\_tools=[{"type": "retrieval"}],    instructions\_prefix="Please address the user as Jerry.",    files=["data/10k/lyft\_2021.pdf"],    verbose=True,)
```

```
response = agent.chat("What was Lyft's revenue growth in 2021?")
```

```
print(str(response))
```

```
Lyft's revenue increased by $843.6 million or 36% in 2021 as compared to the previous year【7†source】.
```
Assistant with Query Engine Tools[](#assistant-with-query-engine-tools "Permalink to this heading")
----------------------------------------------------------------------------------------------------

Here we showcase the function calling capabilities of the OpenAIAssistantAgent by integrating it with our query engine tools over different documents.

### 1. Setup: Load Data[](#setup-load-data "Permalink to this heading")


```
from llama\_index.agent import OpenAIAssistantAgentfrom llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    StorageContext,    load\_index\_from\_storage,)from llama\_index.tools import QueryEngineTool, ToolMetadata
```

```
try:    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/lyft"    )    lyft\_index = load\_index\_from\_storage(storage\_context)    storage\_context = StorageContext.from\_defaults(        persist\_dir="./storage/uber"    )    uber\_index = load\_index\_from\_storage(storage\_context)    index\_loaded = Trueexcept:    index\_loaded = False
```

```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
--2023-11-07 00:20:08--  https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/10k/uber_2021.pdfResolving raw.githubusercontent.com (raw.githubusercontent.com)... 2606:50c0:8000::154, 2606:50c0:8001::154, 2606:50c0:8002::154, ...Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|2606:50c0:8000::154|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 1880483 (1.8M) [application/octet-stream]Saving to: ‘data/10k/uber_2021.pdf’data/10k/uber_2021. 100%[===================>]   1.79M  --.-KB/s    in 0.07s   2023-11-07 00:20:08 (24.3 MB/s) - ‘data/10k/uber_2021.pdf’ saved [1880483/1880483]--2023-11-07 00:20:08--  https://raw.githubusercontent.com/run-llama/llama_index/main/docs/examples/data/10k/lyft_2021.pdfResolving raw.githubusercontent.com (raw.githubusercontent.com)... 2606:50c0:8000::154, 2606:50c0:8001::154, 2606:50c0:8002::154, ...Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|2606:50c0:8000::154|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 1440303 (1.4M) [application/octet-stream]Saving to: ‘data/10k/lyft_2021.pdf’data/10k/lyft_2021. 100%[===================>]   1.37M  --.-KB/s    in 0.06s   2023-11-07 00:20:09 (22.2 MB/s) - ‘data/10k/lyft_2021.pdf’ saved [1440303/1440303]
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
### 2. Let’s Try it Out[](#let-s-try-it-out "Permalink to this heading")


```
agent = OpenAIAssistantAgent.from\_new(    name="SEC Analyst",    instructions="You are a QA assistant designed to analyze sec filings.",    tools=query\_engine\_tools,    instructions\_prefix="Please address the user as Jerry.",    verbose=True,    run\_retrieve\_sleep\_time=1.0,)
```

```
response = agent.chat("What was Lyft's revenue growth in 2021?")
```

```
=== Calling Function ===Calling function: lyft_10k with args: {"input":"What was Lyft's revenue growth in 2021?"}Got output: Lyft's revenue growth in 2021 was 36%.========================
```
Assistant Agent with your own Vector Store / Retrieval API[](#assistant-agent-with-your-own-vector-store-retrieval-api "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------

LlamaIndex has 35+ vector database integrations. Instead of using the in-house Retrieval API, you can use our assistant agent over any vector store.

Here is our full [list of vector store integrations](https://docs.llamaindex.ai/en/stable/module_guides/storing/vector_stores.html). We picked one vector store (Supabase) using a random number generator.


```
from llama\_index.agent import OpenAIAssistantAgentfrom llama\_index import (    SimpleDirectoryReader,    VectorStoreIndex,    StorageContext,)from llama\_index.vector\_stores import SupabaseVectorStorefrom llama\_index.tools import QueryEngineTool, ToolMetadata
```

```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
# load datareader = SimpleDirectoryReader(input\_files=["./data/10k/lyft\_2021.pdf"])docs = reader.load\_data()for doc in docs:    doc.id\_ = "lyft\_docs"
```

```
vector\_store = SupabaseVectorStore(    postgres\_connection\_string=(        "postgresql://<user>:<password>@<host>:<port>/<db\_name>"    ),    collection\_name="base\_demo",)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(docs, storage\_context=storage\_context)
```

```
# sanity check that the docs are in the vector storenum\_docs = vector\_store.get\_by\_id("lyft\_docs", limit=1000)print(len(num\_docs))
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/vecs/collection.py:445: UserWarning: Query does not have a covering index for cosine_distance. See Collection.create_index  warnings.warn(
```

```
357
```

```
lyft\_tool = QueryEngineTool(    query\_engine=index.as\_query\_engine(similarity\_top\_k=3),    metadata=ToolMetadata(        name="lyft\_10k",        description=(            "Provides information about Lyft financials for year 2021. "            "Use a detailed plain text question as input to the tool."        ),    ),)
```

```
agent = OpenAIAssistantAgent.from\_new(    name="SEC Analyst",    instructions="You are a QA assistant designed to analyze SEC filings.",    tools=[lyft\_tool],    verbose=True,    run\_retrieve\_sleep\_time=1.0,)
```

```
response = agent.chat(    "Tell me about Lyft's risk factors, as well as response to COVID-19")
```

```
=== Calling Function ===Calling function: lyft_10k with args: {"input": "What are Lyft's risk factors?"}
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/vecs/collection.py:445: UserWarning: Query does not have a covering index for cosine_distance. See Collection.create_index  warnings.warn(
```

```
Got output: Lyft's risk factors include general economic factors, such as the impact of the COVID-19 pandemic and responsive measures, natural disasters, economic downturns, public health crises, or political crises. Operational factors, such as their limited operating history, financial performance, competition, unpredictability of results, uncertainty regarding market growth, ability to attract and retain qualified drivers and riders, insurance coverage, autonomous vehicle technology, reputation and brand, illegal or improper activity on the platform, accuracy of background checks, changes to pricing practices, growth and development of their network, ability to manage growth, security or privacy breaches, reliance on third parties, and ability to operate various programs and services.=========================== Calling Function ===Calling function: lyft_10k with args: {"input": "How did Lyft respond to COVID-19?"}
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/vecs/collection.py:445: UserWarning: Query does not have a covering index for cosine_distance. See Collection.create_index  warnings.warn(
```

```
Got output: Lyft responded to COVID-19 by adopting multiple measures, including establishing new health and safety requirements for ridesharing and updating workplace policies. They also made adjustments to their expenses and cash flow to correlate with declines in revenues, which included headcount reductions in 2020. Additionally, Lyft temporarily reduced pricing for Flexdrive rentals in cities most affected by COVID-19 and waived rental fees for drivers who tested positive for COVID-19 or were requested to quarantine by a medical professional. These measures were implemented to mitigate the negative effects of the pandemic on their business.========================
```

```
print(str(response))
```

```
Lyft's 2021 10-K filing outlines a multifaceted risk landscape for the company, encapsulating both operational and environmental challenges that could impact its business model:- **Economic Factors**: Risks include the ramifications of the COVID-19 pandemic, susceptibility to natural disasters, the volatility of economic downturns, and geopolitical tensions.- **Operational Dynamics**: The company is cognizant of its limited operating history, the uncertainties surrounding its financial performance, the intense competition in the ridesharing sector, the unpredictability in financial results, and the ambiguity tied to the expansion potential of the rideshare market.- **Human Capital**: A critical concern is the ability of Lyft to attract and maintain a robust network of both drivers and riders, which is essential for the platform's vitality.- **Insurance and Safety**: Ensuring adequate insurance coverage for stakeholders and addressing autonomous vehicle technology risks are pivotal.- **Reputation and Brand**: Lyft is attentive to the influence that illegal or unseemly activities on its platform can have on its public image.- **Pricing Structure**: Changing pricing models pose a risk to Lyft's revenue streams, considering how essential pricing dynamics are to maintaining competitive service offerings.- **Systemic Integrity**: Lyft also acknowledges risks emanating from potential system failures which could disrupt service continuity.Furthermore, Lyft is vigilant about regulatory and legal risks that could lead to litigation and is conscious of the broader implications of climate change on its operations.In terms of its response to COVID-19, Lyft has adopted strategic measures to secure the welfare of both its workforce and customer base:1. **Health and Safety Protocols**: Lyft has instituted health and safety mandates tailored specifically to the ridesharing experience in view of the pandemic.2. **Workplace Adjustments**: The company revised its workplace policies to accommodate the shifts in the work environment precipitated by the pandemic.3. **Financial Adaptations**: To synchronize with the revenue contraction experienced during the pandemic, Lyft executed monetary realignments, which necessitated workforce reductions in 2020.These initiatives reflect Lyft's calculated approach to navigating the operational and financial hurdles enacted by the COVID-19 pandemic. By prioritizing health and safety, nimbly altering corporate practices, and recalibrating fiscal management, Lyft aimed to buttress its business against the storm of the pandemic while setting a foundation for post-pandemic recovery.
```
