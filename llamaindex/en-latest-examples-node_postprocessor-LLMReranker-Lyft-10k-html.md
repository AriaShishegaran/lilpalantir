[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/node_postprocessor/LLMReranker-Lyft-10k.ipynb)

LLM Reranker Demonstration (2021 Lyft 10-k)[](#llm-reranker-demonstration-2021-lyft-10-k "Permalink to this heading")
======================================================================================================================

This tutorial showcases how to do a two-stage pass for retrieval. Use embedding-based retrieval with a high top-k valuein order to maximize recall and get a large set of candidate items. Then, use LLM-based retrievalto dynamically select the nodes that are actually relevant to the query.


```
import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    LLMPredictor,)from llama\_index.indices.postprocessor import LLMRerankfrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```
Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/10k/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/10k/lyft\_2021.pdf' -O 'data/10k/lyft\_2021.pdf'
```
Load Data, Build Index[](#load-data-build-index "Permalink to this heading")
-----------------------------------------------------------------------------


```
# LLM Predictor (gpt-3.5-turbo) + service contextllm = OpenAI(temperature=0, model="gpt-3.5-turbo")chunk\_overlap = 0chunk\_size = 128service\_context = ServiceContext.from\_defaults(    llm=llm,    chunk\_size=chunk\_size,    chunk\_overlap=chunk\_overlap,)
```

```
# load documentsdocuments = SimpleDirectoryReader(    input\_files=["./data/10k/lyft\_2021.pdf"]).load\_data()
```

```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 226241 tokens> [build_index_from_nodes] Total embedding token usage: 226241 tokens> [build_index_from_nodes] Total embedding token usage: 226241 tokens
```
Retrieval Comparisons[](#retrieval-comparisons "Permalink to this heading")
----------------------------------------------------------------------------


```
from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.indices.query.schema import QueryBundleimport pandas as pdfrom IPython.display import display, HTMLfrom copy import deepcopypd.set\_option("display.max\_colwidth", -1)def get\_retrieved\_nodes(    query\_str, vector\_top\_k=10, reranker\_top\_n=3, with\_reranker=False):    query\_bundle = QueryBundle(query\_str)    # configure retriever    retriever = VectorIndexRetriever(        index=index,        similarity\_top\_k=vector\_top\_k,    )    retrieved\_nodes = retriever.retrieve(query\_bundle)    if with\_reranker:        # configure reranker        reranker = LLMRerank(            choice\_batch\_size=5,            top\_n=reranker\_top\_n,            service\_context=service\_context,        )        retrieved\_nodes = reranker.postprocess\_nodes(            retrieved\_nodes, query\_bundle        )    return retrieved\_nodesdef pretty\_print(df):    return display(HTML(df.to\_html().replace("\\n", "<br>")))def visualize\_retrieved\_nodes(nodes) -> None:    result\_dicts = []    for node in nodes:        node = deepcopy(node)        node.node.metadata = None        node\_text = node.node.get\_text()        node\_text = node\_text.replace("\n", " ")        result\_dict = {"Score": node.score, "Text": node\_text}        result\_dicts.append(result\_dict)    pretty\_print(pd.DataFrame(result\_dicts))
```

```
/var/folders/1r/c3h91d9s49xblwfvz79s78_c0000gn/T/ipykernel_58458/2502541873.py:8: FutureWarning: Passing a negative integer is deprecated in version 1.0 and will not be supported in future version. Instead, use None to not limit the column width.  pd.set_option('display.max_colwidth', -1)
```

```
new\_nodes = get\_retrieved\_nodes(    "What is Lyft's response to COVID-19?", vector\_top\_k=5, with\_reranker=False)
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 0.863554 | Rentals. Further, COVID-19 has and may continue to negatively impact Lyft’s ability to conduct rental operationsthrough the Express Drive program and Lyft Rentals as a result of restrictions on travel, mandated closures, limited staffing availability, and other factors relatedto COVID-19. For example, in 2020, Lyft Rentals temporarily ceased operations, closing its rental locations, as a result of COVID-19. Further, while ExpressDrive rental periods |
| 1 | 0.854175 | pandemic, including sales, marketing and costs relating to our efforts to mitigate the impact of the COVID-19 pandemic. Furthermore, we have expanded overtime to include more asset-intensive offerings such as our network of Light Vehicles, Flexdrive, Lyft Rentals and Lyft Auto Care. We are also expanding the supportavailable to drivers at our Driver Hubs, our driver-centric service centers and community spaces, Driver Centers, our vehicle service centers, Mobile Services, |
| 2 | 0.852866 | requested to quarantine by a medical professional, which it continues to do at this time. Further, Lyft Rentals and Flexdrive have facedsignificantly higher cos ts in transporting, repossessing, cleaning, and17 |
| 3 | 0.847151 | the transport ation needs of customers, employees and other constituents.• Grow Active Riders. We see opportunities to continue to recoup and grow our rider base amid the continuing COVID-19 pandemic. We may make incrementalinvestments in our brand and in growth marketing to maintain and drive increasing consumer preference for Lyft. We may also offer discounts for first-time ridersto try Lyft or provide incentives to existing riders to encourage increased ride frequency. We |
| 4 | 0.841177 | day one, we have worked continuousl y to enhance the safety of our platform and the ridesharing industry by developing innovative products, policiesand processes. Business Lyft is evolving how businesses large and small take care of their people’s transportation needs across sectors including corporate, healthcare, auto, education andgovernment. Our comprehensive set of solutions allows clients to design, manage and pay for ground |


```
new\_nodes = get\_retrieved\_nodes(    "What is Lyft's response to COVID-19?",    vector\_top\_k=20,    reranker\_top\_n=5,    with\_reranker=True,)
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens> [retrieve] Total embedding token usage: 11 tokens
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 10.0 | inunrestricted cash and cash equivalents and short-term investments as of December 31, 2021, we believe we have sufficient liquidity to continue business operations and totake action we determine to be in the best interests of our employees, stockholders, stakeholders and of drivers and riders on the Lyft Platform. For more information onrisks associated with the COVID-19 pandem ic, see the section titled “Risk Factors” in Item 1A of Part I.Recent Developments Transaction |
| 1 | 10.0 | COVID-19, may continue to develop or persist over time and further contribute to thisadverse effect. • Changes in driver behavior during the COVID-19 pandemic have led to reduced levels of driver availability on our platform relative to rider demand in certainmarkets. This imbalance fluctuates for various reasons, and to the extent that driver availability is limited, our service levels have been and may be negativelyimpacted and we have increased prices or provided additional incentives and may need to continue to do so, which |
| 2 | 10.0 | estimated.In response to the COVID-19 pandemic, we have adopted multiple measures, including, but not limited, to establishing new health and safety requirements forridesharing and updating workplace policies. We also made adjustments to our expenses and cash flow to correlate with declines in revenues including headcountreductions in 2020. 56 |
| 3 | 10.0 | opportunities for drivers on our platform. Our business continues to be impacted by the COVID-19pandemic. Although we have seen some signs of demand improving, particularly compared to the demand levels at the start of the pandemic, demand levels continue to beaffected by the impact of variants and changes in case counts. The exact timing and pace of the recovery remain uncertain. The extent to which our operations will continueto be impacted by the pandemic will depend largely on future |
| 4 | 10.0 | does not perceive ridesharing or our other offerings as beneficial, or chooses not to adopt them as a result of concerns regarding public health or safety, affordability or forother reasons, whether as a result of incidents on our platform or on our competitors’ platforms, the COVID-19 pandemic, or otherwise, then the market for our offeringsmay not further develop, may develop more slowly than we expect or may not achieve the growth potential we expect. Additionally, |


```
new\_nodes = get\_retrieved\_nodes(    "What initiatives are the company focusing on independently of COVID-19?",    vector\_top\_k=5,    with\_reranker=False,)
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 0.819209 | businesses to contain the pandemic or respond to its impact and altered consumer behavior, amongother things. The Company has adopted a number of measures in response to the COVID-19 pandemic including, but not limited to, establishing new health and safetyrequirements for ridesharing and updating workplace policies. The Company also made adjustments to its expenses and cash flow to correlate with declines in revenuesincluding headcount reductions in 2020. Refer to Note 17 “Restructuring” to the |
| 1 | 0.813341 | business;• manage our platform and our business assets and expenses in light of the COVID-19 pandemic and related public health measures issued by various jurisdictions,including travel bans, travel restrictions and shelter-in-place orders, as well as maintain demand for and confidence in the safety of our platform during andfollowing the COVID-19 pandemic; • plan for and manage capital |
| 2 | 0.809412 | pandemic, including sales, marketing and costs relating to our efforts to mitigate the impact of the COVID-19 pandemic. Furthermore, we have expanded overtime to include more asset-intensive offerings such as our network of Light Vehicles, Flexdrive, Lyft Rentals and Lyft Auto Care. We are also expanding the supportavailable to drivers at our Driver Hubs, our driver-centric service centers and community spaces, Driver Centers, our vehicle service centers, Mobile Services, |
| 3 | 0.809215 | COVID-19 pandemic in March 2020. We have adoptedmultiple measures in response to the COVID-19 pandemic. We cannot be certain that these actions will mitigate some or all of the negative effects of the pandemic on ourbusiness. In light of the evolving and unpredictable effects of COVID-19, we are not currently in a position to forecast the expected impact of COVID-19 on our financialand operating results in fu ture periods.Revenue Recognition Revenue |
| 4 | 0.808421 | estimated.In response to the COVID-19 pandemic, we have adopted multiple measures, including, but not limited, to establishing new health and safety requirements forridesharing and updating workplace policies. We also made adjustments to our expenses and cash flow to correlate with declines in revenues including headcountreductions in 2020. 56 |


```
new\_nodes = get\_retrieved\_nodes(    "What initiatives are the company focusing on independently of COVID-19?",    vector\_top\_k=40,    reranker\_top\_n=5,    with\_reranker=True,)
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 10.0 | remotely, as well as permanent return to workarrangements and workplac e strategies;• the inability to achieve adherence to our internal policies and core values, including our diversity, equity and inclusion practices and initiatives;• competitive pressures to move in directions that may divert us from our mission, vision and values;• the continued challenges of a rapidly-evolving industry;• the increasing need to develop expertise in new areas of business that |
| 1 | 9.0 | platfor m and scaled user network.Notwithstanding the impact of COVID-19, we are continuing to invest in the future, both organically and through acquisitions of complementary businesses. Wealso continue to invest in the expansion of our network of Light Vehicles and Lyft Autonomous, which focuses on the deployment and scaling of third-party self-drivingtechnology on the Lyft network. Our strategy is to always be at the forefront of transportation innovation, and we believe that through these |
| 2 | 9.0 | the transport ation needs of customers, employees and other constituents.• Grow Active Riders. We see opportunities to continue to recoup and grow our rider base amid the continuing COVID-19 pandemic. We may make incrementalinvestments in our brand and in growth marketing to maintain and drive increasing consumer preference for Lyft. We may also offer discounts for first-time ridersto try Lyft or provide incentives to existing riders to encourage increased ride frequency. We |
| 3 | 8.0 | to grow our business and improve ourofferings, we will face challenges related to providing quality support services at scale. If we grow our international rider base and the number of international drivers onour platform, our support organization will face additional challenges, including those associated with delivering support in languages other than English. Furthermore, theCOVID-19 pandemic may impact our ability to provide effective and timely support, including as a result of a decrease in the availability of service providers and increasein |
| 4 | 6.0 | pandemic and responsive measures;• natural disasters, economic downturns, public health crises or political crises;• general macroeconomic conditions;Operational factors • our limited operating history;• our financial performance and any inability to achieve or maintain profitability in the future;• competition in our industries;• the unpredictability of our results of operations;• uncertainty regarding the growth of the ridesharing and other markets;• our ability to attract and |

