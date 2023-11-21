[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/output_parsing/guidance_sub_question.ipynb)

Guidance for Sub-Question Query Engine[](#guidance-for-sub-question-query-engine "Permalink to this heading")
==============================================================================================================

In this notebook, we showcase how to use [**guidance**](https://github.com/microsoft/guidance) to improve the robustness of our sub-question query engine.

The sub-question query engine is designed to accept swappable question generators that implement the `BaseQuestionGenerator` interface.  
To leverage the power of [**guidance**](https://github.com/microsoft/guidance), we implemented a new `GuidanceQuestionGenerator` (powered by our `GuidancePydanticProgram`)

Guidance Question Generator[](#guidance-question-generator "Permalink to this heading")
----------------------------------------------------------------------------------------

Unlike the default `LLMQuestionGenerator`, guidance guarantees that we will get the desired structured output, and eliminate output parsing errors.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.question\_gen.guidance\_generator import (    GuidanceQuestionGenerator,)from guidance.llms import OpenAI as GuidanceOpenAI
```

```
question\_gen = GuidanceQuestionGenerator.from\_defaults(    guidance\_llm=GuidanceOpenAI("text-davinci-003"), verbose=False)
```
Let’s test it out!


```
from llama\_index.tools import ToolMetadatafrom llama\_index import QueryBundle
```

```
tools = [    ToolMetadata(        name="lyft\_10k",        description="Provides information about Lyft financials for year 2021",    ),    ToolMetadata(        name="uber\_10k",        description="Provides information about Uber financials for year 2021",    ),]
```

```
sub\_questions = question\_gen.generate(    tools=tools,    query=QueryBundle("Compare and contrast Uber and Lyft financial in 2021"),)
```

```
sub\_questions
```

```
[SubQuestion(sub_question='What is the revenue of Uber', tool_name='uber_10k'), SubQuestion(sub_question='What is the EBITDA of Uber', tool_name='uber_10k'), SubQuestion(sub_question='What is the net income of Uber', tool_name='uber_10k'), SubQuestion(sub_question='What is the revenue of Lyft', tool_name='lyft_10k'), SubQuestion(sub_question='What is the EBITDA of Lyft', tool_name='lyft_10k'), SubQuestion(sub_question='What is the net income of Lyft', tool_name='lyft_10k')]
```
Using Guidance Question Generator with Sub-Question Query Engine[](#using-guidance-question-generator-with-sub-question-query-engine "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Prepare data and base query engines[](#prepare-data-and-base-query-engines "Permalink to this heading")


```
from llama\_index import (    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,    VectorStoreIndex,)from llama\_index.response.pprint\_utils import pprint\_responsefrom llama\_index.tools import QueryEngineTool, ToolMetadatafrom llama\_index.query\_engine import SubQuestionQueryEngine
```
Download Data


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/uber\_2021.pdf' -O 'data/10k/uber\_2021.pdf'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```

```
lyft\_docs = SimpleDirectoryReader(    input\_files=["./data/10k/lyft\_2021.pdf"]).load\_data()uber\_docs = SimpleDirectoryReader(    input\_files=["./data/10k/uber\_2021.pdf"]).load\_data()
```

```
lyft\_index = VectorStoreIndex.from\_documents(lyft\_docs)uber\_index = VectorStoreIndex.from\_documents(uber\_docs)
```

```
lyft\_engine = lyft\_index.as\_query\_engine(similarity\_top\_k=3)uber\_engine = uber\_index.as\_query\_engine(similarity\_top\_k=3)
```
### Construct sub-question query engine and run some queries![](#construct-sub-question-query-engine-and-run-some-queries "Permalink to this heading")


```
query\_engine\_tools = [    QueryEngineTool(        query\_engine=lyft\_engine,        metadata=ToolMetadata(            name="lyft\_10k",            description=(                "Provides information about Lyft financials for year 2021"            ),        ),    ),    QueryEngineTool(        query\_engine=uber\_engine,        metadata=ToolMetadata(            name="uber\_10k",            description=(                "Provides information about Uber financials for year 2021"            ),        ),    ),]s\_engine = SubQuestionQueryEngine.from\_defaults(    question\_gen=question\_gen,  # use guidance based question\_gen defined above    query\_engine\_tools=query\_engine\_tools,)
```

```
response = s\_engine.query(    "Compare and contrast the customer segments and geographies that grew the"    " fastest")
```

```
Generated 4 sub questions.[uber\_10k] Q: What customer segments grew the fastest for Uber[uber\_10k] A: in 2021?The customer segments that grew the fastest for Uber in 2021 were its Mobility Drivers, Couriers, Riders, and Eaters. These segments experienced growth due to the continued stay-at-home order demand related to COVID-19, as well as Uber's membership programs, such as Uber One, Uber Pass, Eats Pass, and Rides Pass. Additionally, Uber's marketplace-centric advertising helped to connect merchants and brands with its platform network, further driving growth.[uber\_10k] Q: What geographies grew the fastest for Uber[uber\_10k] A: Based on the context information, it appears that Uber experienced the most growth in large metropolitan areas, such as Chicago, Miami, New York City, Sao Paulo, and London. Additionally, Uber experienced growth in suburban and rural areas, as well as in countries such as Argentina, Germany, Italy, Japan, South Korea, and Spain.[lyft\_10k] Q: What customer segments grew the fastest for Lyft[lyft\_10k] A: The customer segments that grew the fastest for Lyft were ridesharing, light vehicles, and public transit. Ridesharing grew as Lyft was able to predict demand and proactively incentivize drivers to be available for rides in the right place at the right time. Light vehicles grew as users were looking for options that were more active, usually lower-priced, and often more efficient for short trips during heavy traffic. Public transit grew as Lyft integrated third-party public transit data into the Lyft App to offer users a robust view of transportation options around them.[lyft\_10k] Q: What geographies grew the fastest for Lyft[lyft\_10k] A: It is not possible to answer this question with the given context information.
```

```
print(response)
```

```
The customer segments that grew the fastest for Uber in 2021 were its Mobility Drivers, Couriers, Riders, and Eaters. These segments experienced growth due to the continued stay-at-home order demand related to COVID-19, as well as Uber's membership programs, such as Uber One, Uber Pass, Eats Pass, and Rides Pass. Additionally, Uber's marketplace-centric advertising helped to connect merchants and brands with its platform network, further driving growth. Uber experienced the most growth in large metropolitan areas, such as Chicago, Miami, New York City, Sao Paulo, and London. Additionally, Uber experienced growth in suburban and rural areas, as well as in countries such as Argentina, Germany, Italy, Japan, South Korea, and Spain.The customer segments that grew the fastest for Lyft were ridesharing, light vehicles, and public transit. Ridesharing grew as Lyft was able to predict demand and proactively incentivize drivers to be available for rides in the right place at the right time. Light vehicles grew as users were looking for options that were more active, usually lower-priced, and often more efficient for short trips during heavy traffic. Public transit grew as Lyft integrated third-party public transit data into the Lyft App to offer users a robust view of transportation options around them. It is not possible to answer the question of which geographies grew the fastest for Lyft with the given context information.In summary, Uber and Lyft both experienced growth in customer segments related to their respective services, such as Mobility Drivers, Couriers, Riders, and Eaters for Uber, and ridesharing, light vehicles, and public transit for Lyft. Uber experienced the most growth in large metropolitan areas, as well as in suburban and rural areas, and in countries such as Argentina, Germany, Italy, Japan, South Korea, and Spain. It is not possible to answer the question of which geographies grew the fastest for Lyft with the given context information.
```
