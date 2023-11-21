[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/sec_tables/tesla_10q_table.ipynb)

Joint Tabular/Semantic QA over Tesla 10K[](#joint-tabular-semantic-qa-over-tesla-10k "Permalink to this heading")
==================================================================================================================

In this example, we show how to ask questions over 10K with understanding of both the unstructured text as well as embedded tables.

We use Unstructured to parse out the tables, and use LlamaIndex recursive retrieval to index/retrieve tables if necessary given the user question.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%load\_ext autoreload%autoreload 2
```

```
from pydantic import BaseModelfrom unstructured.partition.html import partition\_htmlimport pandas as pdpd.set\_option("display.max\_rows", None)pd.set\_option("display.max\_columns", None)pd.set\_option("display.width", None)pd.set\_option("display.max\_colwidth", None)
```
Perform Data Extraction[](#perform-data-extraction "Permalink to this heading")
--------------------------------------------------------------------------------

In these sections we use Unstructured to parse out the table and non-table elements.

### Extract Elements[](#extract-elements "Permalink to this heading")

We use Unstructured to extract table and non-table elements from the 10-K filing.


```
!wget "https://www.dropbox.com/scl/fi/mlaymdy1ni1ovyeykhhuk/tesla\_2021\_10k.htm?rlkey=qf9k4zn0ejrbm716j0gg7r802&dl=1" -O tesla_2021_10k.htm!wget "https://www.dropbox.com/scl/fi/rkw0u959yb4w8vlzz76sa/tesla\_2020\_10k.htm?rlkey=tfkdshswpoupav5tqigwz1mp7&dl=1" -O tesla_2020_10k.htm
```

```
from llama\_index.readers.file.flat\_reader import FlatReaderfrom pathlib import Pathreader = FlatReader()docs\_2021 = reader.load\_data(Path("tesla\_2021\_10k.htm"))docs\_2020 = reader.load\_data(Path("tesla\_2020\_10k.htm"))
```

```
from llama\_index.node\_parser import (    UnstructuredElementNodeParser,)node\_parser = UnstructuredElementNodeParser()
```

```
import osimport pickleif not os.path.exists("2021\_nodes.pkl"):    raw\_nodes\_2021 = node\_parser.get\_nodes\_from\_documents(docs\_2021)    pickle.dump(raw\_nodes\_2021, open("2021\_nodes.pkl", "wb"))else:    raw\_nodes\_2021 = pickle.load(open("2021\_nodes.pkl", "rb"))
```

```
100%|██████████████████████████████████████████████████████████████████| 105/105 [14:59<00:00,  8.56s/it]
```

```
base\_nodes\_2021, node\_mappings\_2021 = node\_parser.get\_base\_nodes\_and\_mappings(    raw\_nodes\_2021)
```

```
example\_index\_node = [b for b in base\_nodes\_2021 if isinstance(b, IndexNode)][    20]# Index Nodeprint(    f"\n--------\n{example\_index\_node.get\_content(metadata\_mode='all')}\n--------\n")# Index Node IDprint(f"\n--------\nIndex ID: {example\_index\_node.index\_id}\n--------\n")# Referenceed Tableprint(    f"\n--------\n{node\_mappings\_2021[example\_index\_node.index\_id].get\_content()}\n--------\n")
```

```
--------col_schema: Column: TypeType: stringSummary: Type of net income (loss) per share calculation (basic or diluted)Column: AmountType: stringSummary: Net income (loss) per share amountColumn: Weighted Average SharesType: stringSummary: Number of shares used in calculating net income (loss) per shareSummary of net income (loss) per share of common stock attributable to common stockholders----------------Index ID: id_617_table----------------                                                                                                                                                                                                                                             0                                                                                                                       Year Ended December 31,                                                                                              1                                                                                                                                          2021                      2020                      2019                                          2                                                    Revenues                                                                                                                                                                                3                                            Automotive sales                                                                                 $    44,125                    $    24,604                     $    19,358                     4                               Automotive regulatory credits                                                                                       1,465                          1,580                             594                     5                                          Automotive leasing                                                                                       1,642                          1,052                             869                     6                                   Total automotive revenues                                                                                      47,232                         27,236                          20,821                     7                               Energy generation and storage                                                                                       2,789                          1,994                           1,531                     8                                          Services and other                                                                                       3,802                          2,306                           2,226                     9                                              Total revenues                                                                                      53,823                         31,536                          24,578                     10                                           Cost of revenues                                                                                                                                                                                11                                           Automotive sales                                                                                      32,415                         19,696                          15,939                     12                                         Automotive leasing                                                                                         978                            563                             459                     13                          Total automotive cost of revenues                                                                                      33,393                         20,259                          16,398                     14                              Energy generation and storage                                                                                       2,918                          1,976                           1,341                     15                                         Services and other                                                                                       3,906                          2,671                           2,770                     16                                     Total cost of revenues                                                                                      40,217                         24,906                          20,509                     17                                               Gross profit                                                                                      13,606                          6,630                           4,069                     18                                         Operating expenses                                                                                                                                                                                19                                   Research and development                                                                                       2,593                          1,491                           1,343                     20                        Selling, general and administrative                                                                                       4,517                          3,145                           2,646                     21                                    Restructuring and other                                                                                           (   27    )                         —                              149               22                                   Total operating expenses                                                                                       7,083                          4,636                           4,138                     23                              Income (loss) from operations                                                                                       6,523                          1,994                               (    69       )       24                                            Interest income                                                                                          56                             30                              44                     25                                           Interest expense                                                                                           (  371    )                         (   748     )                       (  685    )  26                                Other income (expense), net                                                                                         135                              (  122        )                      45               27                          Income (loss) before income taxes                                                                                       6,343                          1,154                               (   665       )       28                                 Provision for income taxes                                                                                         699                            292                             110                     29                                          Net income (loss)                                                                                       5,644                            862                               (   775       )       30    Net income attributable to noncontrolling interests and  redeemable noncontrolling interests in subsidiaries                                         125                            141                               87               31      Net income (loss) attributable to common stockholders                                                                                 $     5,519                    $       721                     $         (   862       )       32                                                                                                                                                                                                                                           33                Net income (loss) per share of common stock                  attributable to common stockholders                                                                                                                           34                                                      Basic                                                                                 $      5.60                    $      0.74                     $         (  0.98       )       35                                                    Diluted                                                                                 $      4.90                    $      0.64                     $         (  0.98       )       36              Weighted average shares used in computing net              income (loss) per share of common stock                                                                                                                           37                                                      Basic                                                                                         986                            933                             887                     38                                                    Diluted                                                                                       1,129                          1,083                             887                     --------
```
Setup Recursive Retriever[](#setup-recursive-retriever "Permalink to this heading")
------------------------------------------------------------------------------------

Now that we’ve extracted tables and their summaries, we can setup a recursive retriever in LlamaIndex to query these tables.

### Construct Retrievers[](#construct-retrievers "Permalink to this heading")


```
from llama\_index.retrievers import RecursiveRetrieverfrom llama\_index.query\_engine import RetrieverQueryEnginefrom llama\_index import VectorStoreIndex
```

```
# construct top-level vector index + query enginevector\_index = VectorStoreIndex(base\_nodes\_2021)vector\_retriever = vector\_index.as\_retriever(similarity\_top\_k=1)vector\_query\_engine = vector\_index.as\_query\_engine(similarity\_top\_k=1)
```

```
from llama\_index.retrievers import RecursiveRetrieverrecursive\_retriever = RecursiveRetriever(    "vector",    retriever\_dict={"vector": vector\_retriever},    node\_dict=node\_mappings\_2021,    verbose=True,)query\_engine = RetrieverQueryEngine.from\_args(recursive\_retriever)
```
### Run some Queries[](#run-some-queries "Permalink to this heading")


```
response = query\_engine.query("What was the revenue in 2020?")print(str(response))
```

```
Retrieving with query id None: What was the revenue in 2020?Retrieved node with id, entering: id\_478\_tableRetrieving with query id id\_478\_table: What was the revenue in 2020?The revenue in 2020 was $31,536 million.
```

```
# compare against the baseline retrieverresponse = vector\_query\_engine.query("What was the revenue in 2020?")print(str(response))
```

```
The revenue in 2020 was a number.
```

```
response = query\_engine.query("What were the total cash flows in 2021?")
```

```
Retrieving with query id None: What were the total cash flows in 2021?Retrieved node with id, entering: id\_558\_tableRetrieving with query id id\_558\_table: What were the total cash flows in 2021?
```

```
print(str(response))
```

```
The total cash flows in 2021 were $11,497 million.
```

```
response = vector\_query\_engine.query("What were the total cash flows in 2021?")print(str(response))
```

```
The total cash flows in 2021 cannot be determined based on the given context information.
```

```
response = query\_engine.query("What are the risk factors for Tesla?")print(str(response))
```

```
Retrieving with query id None: What are the risk factors for Tesla?Retrieving text node: Employees may leave Tesla or choose other employers over Tesla due to various factors, such as a very competitive labor market for talented individuals with automotive or technology experience, or any negative publicity related to us. In regions where we19have or will have operations, particularly significant engineering and manufacturing centers, there is strong competition for individuals with skillsets needed for our business, including specialized knowledge of electric vehicles, engineering and electrical and building construction expertise. Moreover, we may be impacted by perceptions relating to reductions in force that we have conducted in the past in order to optimize our organizational structure and reduce costs and the departure of certain senior personnel for various reasons. Likewise, as a result of our temporary suspension of various U.S. manufacturing operations in the first half of 2020, in April 2020, we temporarily furloughed certain hourly employees and reduced most salaried employees’ base salaries. We also compete with both mature and prosperous companies that have far greater financial resources than we do and start-ups and emerging companies that promise short-term growth opportunities.Finally, our compensation philosophy for all of our personnel reflects our startup origins, with an emphasis on equity-based awards and benefits in order to closely align their incentives with the long-term interests of our stockholders. We periodically seek and obtain approval from our stockholders for future increases to the number of awards available under our equity incentive and employee stock purchase plans. If we are unable to obtain the requisite stockholder approvals for such future increases, we may have to expend additional cash to compensate our employees and our ability to retain and hire qualified personnel may be harmed.We are highly dependent on the services of Elon Musk, Technoking of Tesla and our Chief Executive Officer.We are highly dependent on the services of Elon Musk, Technoking of Tesla and our Chief Executive Officer. Although Mr. Musk spends significant time with Tesla and is highly active in our management, he does not devote his full time and attention to Tesla. Mr. Musk also currently serves as Chief Executive Officer and Chief Technical Officer of Space Exploration Technologies Corp., a developer and manufacturer of space launch vehicles, and is involved in other emerging technology ventures.Our information technology systems or data, or those of our service providers or customers or users could be subject to cyber-attacks or other security incidents, which could result in data breaches, intellectual property theft, claims, litigation, regulatory investigations, significant liability, reputational damage and other adverse consequences.We continue to expand our information technology systems as our operations grow, such as product data management, procurement, inventory management, production planning and execution, sales, service and logistics, dealer management, financial, tax and regulatory compliance systems. This includes the implementation of new internally developed systems and the deployment of such systems in the U.S. and abroad. While, we maintain information technology measures designed to protect us against intellectual property theft, data breaches, sabotage and other external or internal cyber-attacks or misappropriation, our systems and those of our service providers are potentially vulnerable to malware, ransomware, viruses, denial-of-service attacks, phishing attacks, social engineering, computer hacking, unauthorized access, exploitation of bugs, defects and vulnerabilities, breakdowns, damage, interruptions, system malfunctions, power outages, terrorism, acts of vandalism, security breaches, security incidents, inadvertent or intentional actions by employees or other third parties, and other cyber-attacks.To the extent any security incident results in unauthorized access or damage to or acquisition, use, corruption, loss, destruction, alteration or dissemination of our data, including intellectual property and personal information, or our products or vehicles, or for it to be believed or reported that any of these occurred, it could disrupt our business, harm our reputation, compel us to comply with applicable data breach notification laws, subject us to time consuming, distracting and expensive litigation, regulatory investigation and oversight, mandatory corrective action, require us to verify the correctness of database contents, or otherwise subject us to liability under laws, regulations and contractual obligations, including those that protect the privacy and security of personal information. This could result in increased costs to us and result in significant legal and financial exposure and/or reputational harm.We also rely on service providers, and similar incidents relating to their information technology systems could also have a material adverse effect on our business. There have been and may continue to be significant supply chain attacks. Our service providers, including our workforce management software provider, have been subject to ransomware and other security incidents, and we cannot guarantee that our or our service providers’ systems have not been breached or that they do not contain exploitable defects, bugs, or vulnerabilities that could result in a security incident, or other disruption to, our or our service providers’ systems. Our ability to monitor our service providers’ security measures is limited, and, in any event, malicious third parties may be able to circumvent those security measures.The risk factors for Tesla include a highly competitive labor market for skilled individuals in the automotive and technology sectors, negative publicity, competition for individuals with specialized knowledge in electric vehicles and engineering, perceptions related to past reductions in force and departure of senior personnel, competition from companies with greater financial resources, dependence on the services of Elon Musk as CEO, potential cyber-attacks or security incidents leading to data breaches and reputational damage, and reliance on service providers who may be vulnerable to security incidents.
```

```
response = vector\_query\_engine.query("What are the risk factors for Tesla?")print(str(response))
```

```
The risk factors for Tesla include strong competition for skilled individuals in the labor market, negative publicity, potential impacts from reductions in force and departure of senior personnel, competition from companies with greater financial resources, dependence on the services of Elon Musk, potential cyber-attacks or security incidents, and reliance on service providers who may be vulnerable to security breaches. These factors could disrupt Tesla's business, harm its reputation, result in legal and financial exposure, and impact its ability to retain and hire qualified personnel.
```
Try Table Comparisons[](#try-table-comparisons "Permalink to this heading")
----------------------------------------------------------------------------

In this setting we load in both the 2021 and 2020 10K filings, parse each into a hierarchy of tables/text objects, define a recursive retriever over each, and then compose both with a SubQuestionQueryEngine.

This allows us to execute document comparisons against both.

### Define E2E Recursive Retriever Function[](#define-e2e-recursive-retriever-function "Permalink to this heading")


```
import pickleimport osdef create\_recursive\_retriever\_over\_doc(docs, nodes\_save\_path=None): """Big function to go from document path -> recursive retriever."""    node\_parser = UnstructuredElementNodeParser()    if nodes\_save\_path is not None and os.path.exists(nodes\_save\_path):        raw\_nodes = pickle.load(open(nodes\_save\_path, "rb"))    else:        raw\_nodes = node\_parser.get\_nodes\_from\_documents(docs)        if nodes\_save\_path is not None:            pickle.dump(raw\_nodes, open(nodes\_save\_path, "wb"))    base\_nodes, node\_mappings = node\_parser.get\_base\_nodes\_and\_mappings(        raw\_nodes    )    ### Construct Retrievers    # construct top-level vector index + query engine    vector\_index = VectorStoreIndex(base\_nodes)    vector\_retriever = vector\_index.as\_retriever(similarity\_top\_k=2)    recursive\_retriever = RecursiveRetriever(        "vector",        retriever\_dict={"vector": vector\_retriever},        node\_dict=node\_mappings,        verbose=True,    )    query\_engine = RetrieverQueryEngine.from\_args(recursive\_retriever)    return query\_engine, base\_nodes
```
### Create Sub Question Query Engine[](#create-sub-question-query-engine "Permalink to this heading")


```
import nest\_asyncionest\_asyncio.apply()
```

```
from llama\_index.tools import QueryEngineTool, ToolMetadatafrom llama\_index.query\_engine import SubQuestionQueryEngine
```

```
from llama\_index import ServiceContextfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)
```

```
query\_engine\_2021, nodes\_2021 = create\_recursive\_retriever\_over\_doc(    docs\_2021, nodes\_save\_path="2021\_nodes.pkl")query\_engine\_2020, nodes\_2020 = create\_recursive\_retriever\_over\_doc(    docs\_2020, nodes\_save\_path="2020\_nodes.pkl")
```

```
100%|████████████████████████████████████████████████████████████████████| 89/89 [06:29<00:00,  4.38s/it]
```

```
# setup base query engine as toolquery\_engine\_tools = [    QueryEngineTool(        query\_engine=query\_engine\_2021,        metadata=ToolMetadata(            name="tesla\_2021\_10k",            description=(                "Provides information about Tesla financials for year 2021"            ),        ),    ),    QueryEngineTool(        query\_engine=query\_engine\_2020,        metadata=ToolMetadata(            name="tesla\_2020\_10k",            description=(                "Provides information about Tesla financials for year 2020"            ),        ),    ),]sub\_query\_engine = SubQuestionQueryEngine.from\_defaults(    query\_engine\_tools=query\_engine\_tools,    service\_context=service\_context,    use\_async=True,)
```
### Try out some Comparisons[](#try-out-some-comparisons "Permalink to this heading")


```
response = sub\_query\_engine.query(    "Can you compare and contrast the cash flow in 2021 with 2020?")
```

```
print(str(response))
```

```
In 2021, Tesla's cash flow was $11,497 million, which was significantly higher than in 2020, when it was $5.94 billion. This indicates a substantial increase in cash flow from one year to the next.
```

```
response = sub\_query\_engine.query(    "Can you compare and contrast the R&D expenditures in 2021 vs. 2020?")
```

```
print(str(response))
```

```
In 2021, Tesla spent $2.593 billion on research and development (R&D), which was significantly higher than the $1.491 billion they spent in 2020. This indicates an increase in R&D expenditure from 2020 to 2021.
```

```
response = sub\_query\_engine.query(    "Can you compare and contrast the risk factors in 2021 vs. 2020?")
```

```
print(str(response))
```

```
In 2021, Tesla faced risks such as competition for skilled labor, negative publicity, potential impacts from staff reductions and the departure of senior personnel, competition from financially stronger companies, dependence on Elon Musk, potential cyber-attacks or security incidents, competition in the energy generation and storage business, potential issues with components manufactured at their Gigafactories, risks associated with international operations, and the potential for product defects or delays in functionality.In contrast, the risks in 2020 were largely influenced by the global COVID-19 pandemic, which affected macroeconomic conditions, government regulations, and social behaviors. This led to temporary suspensions of operations at manufacturing facilities, temporary employee furloughs and compensation reductions, and challenges in new vehicle deliveries, used vehicle sales, and energy product deployments. Global trade conditions and consumer trends, such as port congestion and microchip supply shortages, also posed risks to Tesla's business.While both years presented unique challenges, the risks in 2021 were more related to competition, personnel, and manufacturing issues, whereas in 2020, the risks were largely driven by external factors such as the pandemic and global trade conditions.
```
#### Try Comparing against Baseline[](#try-comparing-against-baseline "Permalink to this heading")


```
vector\_index\_2021 = VectorStoreIndex(nodes\_2021)vector\_query\_engine\_2021 = vector\_index\_2021.as\_query\_engine(    similarity\_top\_k=2)vector\_index\_2020 = VectorStoreIndex(nodes\_2020)vector\_query\_engine\_2020 = vector\_index\_2020.as\_query\_engine(    similarity\_top\_k=2)# setup base query engine as toolquery\_engine\_tools = [    QueryEngineTool(        query\_engine=vector\_query\_engine\_2021,        metadata=ToolMetadata(            name="tesla\_2021\_10k",            description=(                "Provides information about Tesla financials for year 2021"            ),        ),    ),    QueryEngineTool(        query\_engine=vector\_query\_engine\_2020,        metadata=ToolMetadata(            name="tesla\_2020\_10k",            description=(                "Provides information about Tesla financials for year 2020"            ),        ),    ),]base\_sub\_query\_engine = SubQuestionQueryEngine.from\_defaults(    query\_engine\_tools=query\_engine\_tools,    service\_context=service\_context,    use\_async=True,)
```

```
response = base\_sub\_query\_engine.query(    "Can you compare and contrast the cash flow in 2021 with 2020?")print(str(response))
```

```
Generated 2 sub questions.[tesla\_2021\_10k] Q: What was the cash flow of Tesla in 2021?[tesla\_2020\_10k] Q: What was the cash flow of Tesla in 2020?[tesla\_2020\_10k] A: Tesla had a cash flow of $5.94 billion in 2020.[tesla\_2021\_10k] A: The cash flow of Tesla in 2021 cannot be determined based on the given context information.I'm sorry, but the cash flow of Tesla in 2021 is not specified, so a comparison with the 2020 cash flow of $5.94 billion cannot be made.
```
