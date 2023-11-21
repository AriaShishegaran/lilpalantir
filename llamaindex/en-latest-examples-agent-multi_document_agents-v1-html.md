[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/multi_document_agents-v1.ipynb)

Multi-Document Agents (V1)[](#multi-document-agents-v1 "Permalink to this heading")
====================================================================================

In this guide, you learn towards setting up a multi-document agent over the LlamaIndex documentation.

This is an extension of V0 multi-document agents with the additional features:

* Reranking during document (tool) retrieval
* Query planning tool that the agent can use to plan

We do this with the following architecture:

* setup a “document agent” over each Document: each doc agent can do QA/summarization within its doc
* setup a top-level agent over this set of document agents. Do tool retrieval and then do CoT over the set of tools to answer a question.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%load\_ext autoreload%autoreload 2
```
Setup and Download Data[](#setup-and-download-data "Permalink to this heading")
--------------------------------------------------------------------------------

In this section, we’ll load in the LlamaIndex documentation.


```
domain = "docs.llamaindex.ai"docs\_url = "https://docs.llamaindex.ai/en/latest/"!wget -e robots=off --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains {domain} --no-parent {docs_url}
```

```
from llama\_hub.file.unstructured.base import UnstructuredReaderfrom pathlib import Pathfrom llama\_index.llms import OpenAIfrom llama\_index import ServiceContext
```

```
reader = UnstructuredReader()
```

```
[nltk_data] Downloading package punkt to /Users/jerryliu/nltk_data...[nltk_data]   Package punkt is already up-to-date![nltk_data] Downloading package averaged_perceptron_tagger to[nltk_data]     /Users/jerryliu/nltk_data...[nltk_data]   Package averaged_perceptron_tagger is already up-to-[nltk_data]       date!
```

```
all\_files\_gen = Path("./docs.llamaindex.ai/").rglob("\*")all\_files = [f.resolve() for f in all\_files\_gen]
```

```
all\_html\_files = [f for f in all\_files if f.suffix.lower() == ".html"]
```

```
len(all\_html\_files)
```

```
418
```

```
from llama\_index import Document# TODO: set to higher value if you want more docsdoc\_limit = 100docs = []for idx, f in enumerate(all\_html\_files):    if idx > doc\_limit:        break    print(f"Idx {idx}/{len(all\_html\_files)}")    loaded\_docs = reader.load\_data(file=f, split\_documents=True)    # Hardcoded Index. Everything before this is ToC for all pages    start\_idx = 72    loaded\_doc = Document(        text="\n\n".join([d.get\_content() for d in loaded\_docs[72:]]),        metadata={"path": str(f)},    )    print(loaded\_doc.metadata["path"])    docs.append(loaded\_doc)
```
Define LLM + Service Context + Callback Manager


```
llm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm)
```
Building Multi-Document Agents[](#building-multi-document-agents "Permalink to this heading")
----------------------------------------------------------------------------------------------

In this section we show you how to construct the multi-document agent. We first build a document agent for each document, and then define the top-level parent agent with an object index.


```
from llama\_index import VectorStoreIndex, SummaryIndex
```

```
import nest\_asyncionest\_asyncio.apply()
```
### Build Document Agent for each Document[](#build-document-agent-for-each-document "Permalink to this heading")

In this section we define “document agents” for each document.

We define both a vector index (for semantic search) and summary index (for summarization) for each document. The two query engines are then converted into tools that are passed to an OpenAI function calling agent.

This document agent can dynamically choose to perform semantic search or summarization within a given document.

We create a separate document agent for each city.


```
from llama\_index.agent import OpenAIAgentfrom llama\_index import load\_index\_from\_storage, StorageContextfrom llama\_index.tools import QueryEngineTool, ToolMetadatafrom llama\_index.node\_parser import SimpleNodeParserimport osfrom tqdm.notebook import tqdmimport pickleasync def build\_agent\_per\_doc(nodes, file\_base):    print(file\_base)    vi\_out\_path = f"./data/llamaindex\_docs/{file\_base}"    summary\_out\_path = f"./data/llamaindex\_docs/{file\_base}\_summary.pkl"    if not os.path.exists(vi\_out\_path):        Path("./data/llamaindex\_docs/").mkdir(parents=True, exist\_ok=True)        # build vector index        vector\_index = VectorStoreIndex(nodes, service\_context=service\_context)        vector\_index.storage\_context.persist(persist\_dir=vi\_out\_path)    else:        vector\_index = load\_index\_from\_storage(            StorageContext.from\_defaults(persist\_dir=vi\_out\_path),            service\_context=service\_context,        )    # build summary index    summary\_index = SummaryIndex(nodes, service\_context=service\_context)    # define query engines    vector\_query\_engine = vector\_index.as\_query\_engine()    summary\_query\_engine = summary\_index.as\_query\_engine(        response\_mode="tree\_summarize"    )    # extract a summary    if not os.path.exists(summary\_out\_path):        Path(summary\_out\_path).parent.mkdir(parents=True, exist\_ok=True)        summary = str(            await summary\_query\_engine.aquery(                "Extract a concise 1-2 line summary of this document"            )        )        pickle.dump(summary, open(summary\_out\_path, "wb"))    else:        summary = pickle.load(open(summary\_out\_path, "rb"))    # define tools    query\_engine\_tools = [        QueryEngineTool(            query\_engine=vector\_query\_engine,            metadata=ToolMetadata(                name=f"vector\_tool\_{file\_base}",                description=f"Useful for questions related to specific facts",            ),        ),        QueryEngineTool(            query\_engine=summary\_query\_engine,            metadata=ToolMetadata(                name=f"summary\_tool\_{file\_base}",                description=f"Useful for summarization questions",            ),        ),    ]    # build agent    function\_llm = OpenAI(model="gpt-4")    agent = OpenAIAgent.from\_tools(        query\_engine\_tools,        llm=function\_llm,        verbose=True,        system\_prompt=f"""\You are a specialized agent designed to answer queries about the `{file\_base}.html` part of the LlamaIndex docs.You must ALWAYS use at least one of the tools provided when answering a question; do NOT rely on prior knowledge.\""",    )    return agent, summaryasync def build\_agents(docs):    node\_parser = SimpleNodeParser.from\_defaults()    # Build agents dictionary    agents\_dict = {}    extra\_info\_dict = {}    # # this is for the baseline    # all\_nodes = []    for idx, doc in enumerate(tqdm(docs)):        nodes = node\_parser.get\_nodes\_from\_documents([doc])        # all\_nodes.extend(nodes)        # ID will be base + parent        file\_path = Path(doc.metadata["path"])        file\_base = str(file\_path.parent.stem) + "\_" + str(file\_path.stem)        agent, summary = await build\_agent\_per\_doc(nodes, file\_base)        agents\_dict[file\_base] = agent        extra\_info\_dict[file\_base] = {"summary": summary, "nodes": nodes}    return agents\_dict, extra\_info\_dict
```

```
agents\_dict, extra\_info\_dict = await build\_agents(docs)
```
### Build Retriever-Enabled OpenAI Agent[](#build-retriever-enabled-openai-agent "Permalink to this heading")

We build a top-level agent that can orchestrate across the different document agents to answer any user query.

This `RetrieverOpenAIAgent` performs tool retrieval before tool use (unlike a default agent that tries to put all tools in the prompt).

**Improvements from V0**: We make the following improvements compared to the “base” version in V0.

* Adding in reranking: we use Cohere reranker to better filter the candidate set of documents.
* Adding in a query planning tool: we add an explicit query planning tool that’s dynamically created based on the set of retrieved tools.


```
# define tool for each document agentall\_tools = []for file\_base, agent in agents\_dict.items():    summary = extra\_info\_dict[file\_base]["summary"]    doc\_tool = QueryEngineTool(        query\_engine=agent,        metadata=ToolMetadata(            name=f"tool\_{file\_base}",            description=summary,        ),    )    all\_tools.append(doc\_tool)
```

```
print(all\_tools[0].metadata)
```

```
ToolMetadata(description='LlamaIndex is a data framework that allows LLM applications to ingest, structure, and access private or domain-specific data by providing tools such as data connectors, data indexes, engines, data agents, and application integrations. It is designed for beginners, advanced users, and everyone in between, and offers both high-level and lower-level APIs for customization. LlamaIndex can be installed using pip and has detailed documentation and tutorials available. It is available on GitHub and PyPi, and there is also a Typescript package available. The LlamaIndex community can be joined on Twitter and Discord.', name='tool_latest_index', fn_schema=<class 'llama_index.tools.types.DefaultToolFnSchema'>)
```

```
# define an "object" index and retriever over these toolsfrom llama\_index import VectorStoreIndexfrom llama\_index.objects import (    ObjectIndex,    SimpleToolNodeMapping,    ObjectRetriever,)from llama\_index.retrievers import BaseRetrieverfrom llama\_index.indices.postprocessor import CohereRerankfrom llama\_index.tools import QueryPlanToolfrom llama\_index.query\_engine import SubQuestionQueryEnginefrom llama\_index.llms import OpenAIllm = OpenAI(model\_name="gpt-4-0613")tool\_mapping = SimpleToolNodeMapping.from\_objects(all\_tools)obj\_index = ObjectIndex.from\_objects(    all\_tools,    tool\_mapping,    VectorStoreIndex,)vector\_node\_retriever = obj\_index.as\_node\_retriever(similarity\_top\_k=10)# define a custom retriever with rerankingclass CustomRetriever(BaseRetriever):    def \_\_init\_\_(self, vector\_retriever, postprocessor=None):        self.\_vector\_retriever = vector\_retriever        self.\_postprocessor = postprocessor or CohereRerank(top\_n=5)    def \_retrieve(self, query\_bundle):        retrieved\_nodes = self.\_vector\_retriever.retrieve(query\_bundle)        filtered\_nodes = self.\_postprocessor.postprocess\_nodes(            retrieved\_nodes, query\_bundle=query\_bundle        )        return filtered\_nodes# define a custom object retriever that adds in a query planning toolclass CustomObjectRetriever(ObjectRetriever):    def \_\_init\_\_(self, retriever, object\_node\_mapping, all\_tools, llm=None):        self.\_retriever = retriever        self.\_object\_node\_mapping = object\_node\_mapping        self.\_llm = llm or OpenAI("gpt-4-0613")    def retrieve(self, query\_bundle):        nodes = self.\_retriever.retrieve(query\_bundle)        tools = [self.\_object\_node\_mapping.from\_node(n.node) for n in nodes]        sub\_question\_sc = ServiceContext.from\_defaults(llm=self.\_llm)        sub\_question\_engine = SubQuestionQueryEngine.from\_defaults(            query\_engine\_tools=tools, service\_context=sub\_question\_sc        )        sub\_question\_description = f"""\Useful for any queries that involve comparing multiple documents. ALWAYS use this tool for comparison queries - make sure to call this \tool with the original query. Do NOT use the other tools for any queries involving multiple documents."""        sub\_question\_tool = QueryEngineTool(            query\_engine=sub\_question\_engine,            metadata=ToolMetadata(                name="compare\_tool", description=sub\_question\_description            ),        )        return tools + [sub\_question\_tool]
```

```
custom\_node\_retriever = CustomRetriever(vector\_node\_retriever)# wrap it with ObjectRetriever to return objectscustom\_obj\_retriever = CustomObjectRetriever(    custom\_node\_retriever, tool\_mapping, all\_tools, llm=llm)
```

```
tmps = custom\_obj\_retriever.retrieve("hello")print(len(tmps))
```

```
6
```

```
from llama\_index.agent import FnRetrieverOpenAIAgent, ReActAgenttop\_agent = FnRetrieverOpenAIAgent.from\_retriever(    custom\_obj\_retriever,    system\_prompt=""" \You are an agent designed to answer queries about the documentation.Please always use the tools provided to answer a question. Do not rely on prior knowledge.\""",    llm=llm,    verbose=True,)# top\_agent = ReActAgent.from\_tools(# tool\_retriever=custom\_obj\_retriever,# system\_prompt=""" \# You are an agent designed to answer queries about the documentation.# Please always use the tools provided to answer a question. Do not rely on prior knowledge.\# """,# llm=llm,# verbose=True,# )
```
### Define Baseline Vector Store Index[](#define-baseline-vector-store-index "Permalink to this heading")

As a point of comparison, we define a “naive” RAG pipeline which dumps all docs into a single vector index collection.

We set the top\_k = 4


```
all\_nodes = [    n for extra\_info in extra\_info\_dict.values() for n in extra\_info["nodes"]]
```

```
base\_index = VectorStoreIndex(all\_nodes)base\_query\_engine = base\_index.as\_query\_engine(similarity\_top\_k=4)
```
Running Example Queries[](#running-example-queries "Permalink to this heading")
--------------------------------------------------------------------------------

Let’s run some example queries, ranging from QA / summaries over a single document to QA / summarization over multiple documents.


```
response = top\_agent.query(    "Tell me about the different types of evaluation in LlamaIndex")
```

```
=== Calling Function ===Calling function: tool_api_reference_evaluation with args: {  "input": "types of evaluation"}=== Calling Function ===Calling function: vector_tool_api_reference_evaluation with args: {  "input": "types of evaluation"}Got output: The types of evaluation can include correctness evaluation, faithfulness evaluation, guideline evaluation, hit rate evaluation, MRR (Mean Reciprocal Rank) evaluation, pairwise comparison evaluation, relevancy evaluation, and response evaluation.========================Got output: The types of evaluation mentioned in the `api_reference_evaluation.html` part of the LlamaIndex docs include:1. Correctness Evaluation2. Faithfulness Evaluation3. Guideline Evaluation4. Hit Rate Evaluation5. MRR (Mean Reciprocal Rank) Evaluation6. Pairwise Comparison Evaluation7. Relevancy Evaluation8. Response Evaluation========================
```

```
print(response)
```

```
There are several types of evaluation in LlamaIndex:1. Correctness Evaluation: This type of evaluation measures the accuracy of the retrieval results. It checks if the retrieved documents are correct and relevant to the query.2. Faithfulness Evaluation: Faithfulness evaluation measures how faithfully the retrieved documents represent the original data. It checks if the retrieved documents accurately reflect the information in the original documents.3. Guideline Evaluation: Guideline evaluation involves comparing the retrieval results against a set of guidelines or ground truth. It checks if the retrieval results align with the expected or desired outcomes.4. Hit Rate Evaluation: Hit rate evaluation measures the percentage of queries that return at least one relevant document. It is a binary evaluation metric that indicates the effectiveness of the retrieval system in finding relevant documents.5. MRR (Mean Reciprocal Rank) Evaluation: MRR evaluation measures the average rank of the first relevant document in the retrieval results. It provides a single value that represents the effectiveness of the retrieval system in ranking relevant documents.6. Pairwise Comparison Evaluation: Pairwise comparison evaluation involves comparing the retrieval results of different systems or algorithms. It helps determine which system performs better in terms of retrieval accuracy and relevance.7. Relevancy Evaluation: Relevancy evaluation measures the relevance of the retrieved documents to the query. It can be done using various metrics such as precision, recall, and F1 score.8. Response Evaluation: Response evaluation measures the quality of the response generated by the retrieval system. It checks if the response is informative, accurate, and helpful to the user.These evaluation types help assess the performance and effectiveness of the retrieval system in LlamaIndex.
```

```
# baselineresponse = base\_query\_engine.query(    "Tell me about the different types of evaluation in LlamaIndex")print(str(response))
```

```
LlamaIndex utilizes various types of evaluation methods to assess its performance and effectiveness. These evaluation methods include RelevancyEvaluator, RetrieverEvaluator, SemanticSimilarityEvaluator, PairwiseComparisonEvaluator, CorrectnessEvaluator, FaithfulnessEvaluator, and GuidelineEvaluator. Each of these evaluators serves a specific purpose in evaluating different aspects of the LlamaIndex system.
```

```
response = top\_agent.query(    "Compare the content in the contributions page vs. index page.")
```

```
=== Calling Function ===Calling function: compare_tool with args: {  "input": "content in the contributions page vs. index page"}Generated 2 sub questions.[tool\_development\_contributing] Q: What is the content of the contributions page?[tool\_latest\_index] Q: What is the content of the index page?=== Calling Function ===Calling function: summary_tool_development_contributing with args: {  "input": "development_contributing.html"}=== Calling Function ===Calling function: vector_tool_latest_index with args: {  "input": "content of the index page"}Got output: The development_contributing.html file provides information on how to contribute to LlamaIndex. It includes guidelines on what to work on, such as extending core modules, fixing bugs, adding usage examples, adding experimental features, and improving code quality and documentation. The file also provides details on each module, including data loaders, node parsers, text splitters, document/index/KV stores, managed index, vector stores, retrievers, query engines, query transforms, token usage optimizers, node postprocessors, and output parsers. Additionally, the file includes a development guideline section that covers environment setup, validating changes, formatting/linting, testing, creating example notebooks, and creating a pull request.========================Got output: The content of the index page provides information about LlamaIndex, a data framework for LLM applications. It explains why LlamaIndex is useful for augmenting LLM models with private or domain-specific data that may be distributed across different applications and data stores. LlamaIndex offers tools such as data connectors, data indexes, engines, and data agents to ingest, structure, and access data. It is designed for beginners as well as advanced users who can customize and extend its modules. The page also provides installation instructions, tutorials, and links to the LlamaIndex ecosystem and associated projects.========================[tool\_latest\_index] A: The content of the `latest\_index.html` page provides comprehensive information about LlamaIndex, a data framework for LLM applications. It explains the utility of LlamaIndex in augmenting LLM models with private or domain-specific data that may be distributed across different applications and data stores. The page details the tools offered by LlamaIndex, such as data connectors, data indexes, engines, and data agents, which are used to ingest, structure, and access data. It is designed to cater to both beginners and advanced users, with the flexibility to customize and extend its modules.Additionally, the page provides installation instructions and tutorials for users. It also includes links to the LlamaIndex ecosystem and associated projects for further exploration and understanding.[tool\_development\_contributing] A: The `development\_contributing.html` page of the LlamaIndex docs provides comprehensive information on how to contribute to the project. It includes guidelines on the areas to focus on, such as extending core modules, fixing bugs, adding usage examples, adding experimental features, and improving code quality and documentation.The page also provides detailed information on each module, including data loaders, node parsers, text splitters, document/index/KV stores, managed index, vector stores, retrievers, query engines, query transforms, token usage optimizers, node postprocessors, and output parsers.In addition, there is a development guideline section that covers various aspects of the development process, including environment setup, validating changes, formatting/linting, testing, creating example notebooks, and creating a pull request.Got output: The content in the contributions page of the LlamaIndex documentation provides comprehensive information on how to contribute to the project, including guidelines on areas to focus on and detailed information on each module. It also covers various aspects of the development process. On the other hand, the content in the index page of the LlamaIndex documentation provides comprehensive information about LlamaIndex itself, explaining its utility in augmenting LLM models with private or domain-specific data. It details the tools offered by LlamaIndex and provides installation instructions, tutorials, and links to the LlamaIndex ecosystem and associated projects.========================
```

```
print(response)
```

```
The contributions page of the LlamaIndex documentation provides guidelines for contributing to LlamaIndex, including extending core modules, fixing bugs, adding usage examples, adding experimental features, and improving code quality and documentation. It also includes information on the environment setup, validating changes, formatting and linting, testing, creating example notebooks, and creating a pull request.On the other hand, the index page of the LlamaIndex documentation provides information about LlamaIndex itself. It explains that LlamaIndex is a data framework that allows LLM applications to ingest, structure, and access private or domain-specific data. It provides tools such as data connectors, data indexes, engines, data agents, and application integrations. The index page also mentions that LlamaIndex is designed for beginners, advanced users, and everyone in between, and offers both high-level and lower-level APIs for customization. It provides installation instructions, links to the GitHub and PyPi repositories, and information about the LlamaIndex community on Twitter and Discord.In summary, the contributions page focuses on contributing to LlamaIndex, while the index page provides an overview of LlamaIndex and its features.
```

```
response = top\_agent.query(    "Can you compare the tree index and list index at a very high-level?")
```

```
print(str(response))
```

```
At a high level, the Tree Index and List Index are two different types of indexes used in the system. The Tree Index is a tree-structured index that is built specifically for each query. It allows for the construction of a query-specific tree from leaf nodes to return a response. The Tree Index is designed to provide a more optimized and efficient way of retrieving nodes based on a query.On the other hand, the List Index is a keyword table index that supports operations such as inserting and deleting documents, retrieving nodes based on a query, and refreshing the index with updated documents. The List Index is a simpler index that uses a keyword table approach for retrieval.Both indexes have their own advantages and use cases. The choice between them depends on the specific requirements and constraints of the system.
```
