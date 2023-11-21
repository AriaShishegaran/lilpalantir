[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/knowledge_graph_query_engine.ipynb)

Knowledge Graph Query Engine[](#knowledge-graph-query-engine "Permalink to this heading")
==========================================================================================

Creating a Knowledge Graph usually involves specialized and complex tasks. However, by utilizing the Llama Index (LLM), the KnowledgeGraphIndex, and the GraphStore, we can facilitate the creation of a relatively effective Knowledge Graph from any data source supported by [Llama Hub](https://llamahub.ai/).

Furthermore, querying a Knowledge Graph often requires domain-specific knowledge related to the storage system, such as Cypher. But, with the assistance of the LLM and the LlamaIndex KnowledgeGraphQueryEngine, this can be accomplished using Natural Language!

In this demonstration, we will guide you through the steps to:

* Extract and Set Up a Knowledge Graph using the Llama Index
* Query a Knowledge Graph using Cypher
* Query a Knowledge Graph using Natural Language

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Let’s first get ready for basic preparation of Llama Index.


```
# For OpenAIimport osos.environ["OPENAI\_API\_KEY"] = "sk-..."import loggingimport syslogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputfrom llama\_index import (    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,    SimpleDirectoryReader,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStorefrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display# define LLM# NOTE: at the time of demo, text-davinci-002 did not have rate-limit errorsllm = OpenAI(temperature=0, model="text-davinci-002")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size\_limit=512)
```

```
INFO:numexpr.utils:Note: NumExpr detected 12 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.INFO:numexpr.utils:NumExpr defaulting to 8 threads.WARNING:llama_index.indices.service_context:chunk_size_limit is deprecated, please specify chunk_size instead
```

```
# For Azure OpenAIimport osimport jsonimport openaifrom llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    KnowledgeGraphIndex,    LLMPredictor,    ServiceContext,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStorefrom llama\_index.llms import LangChainLLMimport loggingimport sysfrom IPython.display import Markdown, displaylogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputlogging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))openai.api\_type = "azure"openai.api\_base = "INSERT AZURE API BASE"openai.api\_version = "2022-12-01"os.environ["OPENAI\_API\_KEY"] = "INSERT OPENAI KEY"openai.api\_key = os.getenv("OPENAI\_API\_KEY")lc\_llm = AzureOpenAI(    deployment\_name="INSERT DEPLOYMENT NAME",    temperature=0,    openai\_api\_version=openai.api\_version,    model\_kwargs={        "api\_key": openai.api\_key,        "api\_base": openai.api\_base,        "api\_type": openai.api\_type,        "api\_version": openai.api\_version,    },)llm = LangChainLLM(lc\_llm)# You need to deploy your own embedding model as well as your own chat completion modelembedding\_llm = OpenAIEmbedding(    model="text-embedding-ada-002",    deployment\_name="INSERT DEPLOYMENT NAME",    api\_key=openai.api\_key,    api\_base=openai.api\_base,    api\_type=openai.api\_type,    api\_version=openai.api\_version,)service\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embedding\_llm,)
```
Prepare for NebulaGraph[](#prepare-for-nebulagraph "Permalink to this heading")
--------------------------------------------------------------------------------

Before next step to creating the Knowledge Graph, let’s ensure we have a running NebulaGraph with defined data schema.


```
# Create a NebulaGraph (version 3.5.0 or newer) cluster with:# Option 0 for machines with Docker: `curl -fsSL nebula-up.siwei.io/install.sh | bash`# Option 1 for Desktop: NebulaGraph Docker Extension https://hub.docker.com/extensions/weygu/nebulagraph-dd-ext# If not, create it with the following commands from NebulaGraph's console:# CREATE SPACE llamaindex(vid\_type=FIXED\_STRING(256), partition\_num=1, replica\_factor=1);# :sleep 10;# USE llamaindex;# CREATE TAG entity(name string);# CREATE EDGE relationship(relationship string);# :sleep 10;# CREATE TAG INDEX entity\_index ON entity(name(256));%pip install ipython-ngql nebula3-pythonos.environ["NEBULA\_USER"] = "root"os.environ["NEBULA\_PASSWORD"] = "nebula"  # default is "nebula"os.environ[    "NEBULA\_ADDRESS"] = "127.0.0.1:9669"  # assumed we have NebulaGraph installed locallyspace\_name = "llamaindex"edge\_types, rel\_prop\_names = ["relationship"], [    "relationship"]  # default, could be omit if create from an empty kgtags = ["entity"]  # default, could be omit if create from an empty kg
```

```
Requirement already satisfied: ipython-ngql in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (0.5)Requirement already satisfied: nebula3-python in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (3.4.0)Requirement already satisfied: pandas in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython-ngql) (2.0.3)Requirement already satisfied: Jinja2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython-ngql) (3.1.2)Requirement already satisfied: pytz>=2021.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python) (2023.3)Requirement already satisfied: future>=0.18.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python) (0.18.3)Requirement already satisfied: httplib2>=0.20.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python) (0.22.0)Requirement already satisfied: six>=1.16.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python) (1.16.0)Requirement already satisfied: pyparsing!=3.0.0,!=3.0.1,!=3.0.2,!=3.0.3,<4,>=2.4.2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from httplib2>=0.20.0->nebula3-python) (3.0.9)Requirement already satisfied: MarkupSafe>=2.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from Jinja2->ipython-ngql) (2.1.3)Requirement already satisfied: tzdata>=2022.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (2023.3)Requirement already satisfied: numpy>=1.20.3 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (1.25.2)Requirement already satisfied: python-dateutil>=2.8.2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (2.8.2)WARNING: You are using pip version 21.2.4; however, version 23.2.1 is available.You should consider upgrading via the '/Users/loganmarkewich/llama\_index/llama-index/bin/python -m pip install --upgrade pip' command.Note: you may need to restart the kernel to use updated packages.
```
Prepare for StorageContext with graph\_store as NebulaGraphStore


```
graph\_store = NebulaGraphStore(    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)
```
(Optional)Build the Knowledge Graph with LlamaIndex[](#optional-build-the-knowledge-graph-with-llamaindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------

With the help of Llama Index and LLM defined, we could build Knowledge Graph from given documents.

If we have a Knowledge Graph on NebulaGraphStore already, this step could be skipped

### Step 1, load data from Wikipedia for “Guardians of the Galaxy Vol. 3”[](#step-1-load-data-from-wikipedia-for-guardians-of-the-galaxy-vol-3 "Permalink to this heading")


```
from llama\_index import download\_loaderWikipediaReader = download\_loader("WikipediaReader")loader = WikipediaReader()documents = loader.load\_data(    pages=["Guardians of the Galaxy Vol. 3"], auto\_suggest=False)
```
### Step 2, Generate a KnowledgeGraphIndex with NebulaGraph as graph\_store[](#step-2-generate-a-knowledgegraphindex-with-nebulagraph-as-graph-store "Permalink to this heading")

Then, we will create a KnowledgeGraphIndex to enable Graph based RAG, see [here](https://gpt-index.readthedocs.io/en/latest/examples/index_structs/knowledge_graph/KnowledgeGraphIndex_vs_VectorStoreIndex_vs_CustomIndex_combined.html) for deails, apart from that, we have a Knowledge Graph up and running for other purposes, too!


```
kg\_index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=10,    service\_context=service\_context,    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,    include\_embeddings=True,)
```
Now we have a Knowledge Graph on NebulaGraph cluster under space named `llamaindex` about the ‘Guardians of the Galaxy Vol. 3’ movie, let’s play with it a little bit.


```
# install related packages, password is nebula by default%pip install ipython-ngql networkx pyvis%load\_ext ngql%ngql --address 127.0.0.1 --port 9669 --user root --password <password>
```

```
Requirement already satisfied: ipython-ngql in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (0.5)Requirement already satisfied: networkx in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (3.1)Requirement already satisfied: pyvis in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (0.3.2)Requirement already satisfied: Jinja2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython-ngql) (3.1.2)Requirement already satisfied: pandas in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython-ngql) (2.0.3)Requirement already satisfied: nebula3-python in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython-ngql) (3.4.0)Requirement already satisfied: jsonpickle>=1.4.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pyvis) (3.0.1)Requirement already satisfied: ipython>=5.3.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pyvis) (8.10.0)Requirement already satisfied: backcall in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.2.0)Requirement already satisfied: pickleshare in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.7.5)Requirement already satisfied: prompt-toolkit<3.1.0,>=3.0.30 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (3.0.39)Requirement already satisfied: appnope in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.1.3)Requirement already satisfied: pygments>=2.4.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (2.15.1)Requirement already satisfied: traitlets>=5 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (5.9.0)Requirement already satisfied: pexpect>4.3 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (4.8.0)Requirement already satisfied: stack-data in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.6.2)Requirement already satisfied: decorator in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (5.1.1)Requirement already satisfied: jedi>=0.16 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.18.2)Requirement already satisfied: matplotlib-inline in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from ipython>=5.3.0->pyvis) (0.1.6)Requirement already satisfied: parso<0.9.0,>=0.8.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from jedi>=0.16->ipython>=5.3.0->pyvis) (0.8.3)Requirement already satisfied: MarkupSafe>=2.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from Jinja2->ipython-ngql) (2.1.3)Requirement already satisfied: ptyprocess>=0.5 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pexpect>4.3->ipython>=5.3.0->pyvis) (0.7.0)Requirement already satisfied: wcwidth in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from prompt-toolkit<3.1.0,>=3.0.30->ipython>=5.3.0->pyvis) (0.2.6)Requirement already satisfied: six>=1.16.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python->ipython-ngql) (1.16.0)Requirement already satisfied: pytz>=2021.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python->ipython-ngql) (2023.3)Requirement already satisfied: future>=0.18.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python->ipython-ngql) (0.18.3)Requirement already satisfied: httplib2>=0.20.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from nebula3-python->ipython-ngql) (0.22.0)Requirement already satisfied: pyparsing!=3.0.0,!=3.0.1,!=3.0.2,!=3.0.3,<4,>=2.4.2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from httplib2>=0.20.0->nebula3-python->ipython-ngql) (3.0.9)Requirement already satisfied: python-dateutil>=2.8.2 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (2.8.2)Requirement already satisfied: numpy>=1.20.3 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (1.25.2)Requirement already satisfied: tzdata>=2022.1 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from pandas->ipython-ngql) (2023.3)Requirement already satisfied: executing>=1.2.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (1.2.0)Requirement already satisfied: pure-eval in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (0.2.2)Requirement already satisfied: asttokens>=2.1.0 in /Users/loganmarkewich/llama_index/llama-index/lib/python3.9/site-packages (from stack-data->ipython>=5.3.0->pyvis) (2.2.1)WARNING: You are using pip version 21.2.4; however, version 23.2.1 is available.You should consider upgrading via the '/Users/loganmarkewich/llama\_index/llama-index/bin/python -m pip install --upgrade pip' command.Note: you may need to restart the kernel to use updated packages.Connection Pool CreatedINFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)[ERROR]: 'IPythonNGQL' object has no attribute '_decode_value'
```


|  | Name |
| --- | --- |
| 0 | llamaindex |


```
# Query some random Relationships with Cypher%ngql USE llamaindex;%ngql MATCH ()-[e]->() RETURN e LIMIT 10
```

```
INFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)INFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)
```


|  | e |
| --- | --- |
| 0 | ("A second trailer for the film")-[:relationsh... |
| 1 | ("Adam McKay")-[:relationship@-442854342936029... |
| 2 | ("Adam McKay")-[:relationship@8513344855738553... |
| 3 | ("Asim Chaudhry")-[:relationship@-803614038978... |
| 4 | ("Bakalova")-[:relationship@-25325064520311626... |
| 5 | ("Bautista")-[:relationship@-90386029986457371... |
| 6 | ("Bautista")-[:relationship@-90386029986457371... |
| 7 | ("Beth Mickle")-[:relationship@716197657641767... |
| 8 | ("Bradley Cooper")-[:relationship@138630731832... |
| 9 | ("Bradley Cooper")-[:relationship@838402633192... |


```
# draw the result%ng\_draw
```

```
nebulagraph_draw.html
```
Asking the Knowledge Graph[](#asking-the-knowledge-graph "Permalink to this heading")
--------------------------------------------------------------------------------------

Finally, let’s demo how to Query Knowledge Graph with Natural language!

Here, we will leverage the `KnowledgeGraphQueryEngine`, with `NebulaGraphStore` as the `storage\_context.graph\_store`.


```
from llama\_index.query\_engine import KnowledgeGraphQueryEnginefrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStorequery\_engine = KnowledgeGraphQueryEngine(    storage\_context=storage\_context,    service\_context=service\_context,    llm=llm,    verbose=True,)
```

```
response = query\_engine.query(    "Tell me about Peter Quill?",)display(Markdown(f"<b>{response}</b>"))
```

```
Graph Store Query:```MATCH (p:`entity`)-[:relationship]->(m:`entity`) WHERE p.`entity`.`name` == 'Peter Quill'RETURN p.`entity`.`name`;```Graph Store Response:{'p.entity.name': ['Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill']}Final Response: Peter Quill is a character in the Marvel Universe. He is the son of Meredith Quill and Ego the Living Planet.
```
**Peter Quill is a character in the Marvel Universe. He is the son of Meredith Quill and Ego the Living Planet.**
```
graph\_query = query\_engine.generate\_query(    "Tell me about Peter Quill?",)graph\_query = graph\_query.replace("WHERE", "\n WHERE").replace(    "RETURN", "\nRETURN")display(    Markdown(        f"""```cypher{graph\_query}```"""    ))
```
MATCH (p:`entity`)-[:relationship]->(m:`entity`)WHERE p.`entity`.`name` == ‘Peter Quill’

RETURN p.`entity`.`name`;

We could see it helps generate the Graph query:


```
MATCH (p:`entity`)-[:relationship]->(e:`entity`)   WHERE p.`entity`.`name` == 'Peter Quill' RETURN e.`entity`.`name`;
```
And synthese the question based on its result:


```
{'e2.entity.name': ['grandfather', 'alternate version of Gamora', 'Guardians of the Galaxy']}
```
Of course we still could query it, too! And this query engine could be our best Graph Query Language learning bot, then :).


```
%%ngql MATCH (p:`entity`)-[e:relationship]->(m:`entity`)  WHERE p.`entity`.`name` == 'Peter Quill'RETURN p.`entity`.`name`, e.relationship, m.`entity`.`name`;
```

```
INFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)
```


|  | p.entity.name | e.relationship | m.entity.name |
| --- | --- | --- | --- |
| 0 | Peter Quill | would return to the MCU | May 2021 |
| 1 | Peter Quill | was abducted from Earth | as a child |
| 2 | Peter Quill | is leader of | Guardians of the Galaxy |
| 3 | Peter Quill | was raised by | a group of alien thieves and smugglers |
| 4 | Peter Quill | is half-human | half-Celestial |

And change the query to be rendered


```
%%ngqlMATCH (p:`entity`)-[e:relationship]->(m:`entity`)  WHERE p.`entity`.`name` == 'Peter Quill'RETURN p, e, m;
```

```
INFO:nebula3.logger:Get connection to ('127.0.0.1', 9669)
```


|  | p | e | m |
| --- | --- | --- | --- |
| 0 | ("Peter Quill" :entity{name: "Peter Quill"}) | ("Peter Quill")-[:relationship@-84437522554765... | ("May 2021" :entity{name: "May 2021"}) |
| 1 | ("Peter Quill" :entity{name: "Peter Quill"}) | ("Peter Quill")-[:relationship@-11770408155938... | ("as a child" :entity{name: "as a child"}) |
| 2 | ("Peter Quill" :entity{name: "Peter Quill"}) | ("Peter Quill")-[:relationship@-79394488349732... | ("Guardians of the Galaxy" :entity{name: "Guar... |
| 3 | ("Peter Quill" :entity{name: "Peter Quill"}) | ("Peter Quill")-[:relationship@325695233021653... | ("a group of alien thieves and smugglers" :ent... |
| 4 | ("Peter Quill" :entity{name: "Peter Quill"}) | ("Peter Quill")-[:relationship@555553046209276... | ("half-Celestial" :entity{name: "half-Celestia... |


```
%ng\_draw
```

```
nebulagraph_draw.html
```
The results of this knowledge-fetching query could not be more clear from the renderred graph then.

