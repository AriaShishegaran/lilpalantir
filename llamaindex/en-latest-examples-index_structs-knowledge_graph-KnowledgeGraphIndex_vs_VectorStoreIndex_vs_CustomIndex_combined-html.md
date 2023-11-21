Custom Retriever combining KG Index and VectorStore Index[](#custom-retriever-combining-kg-index-and-vectorstore-index "Permalink to this heading")
====================================================================================================================================================

Now let’s demo how KG Index could be used. We will create a VectorStore Index, KG Index and a Custom Index combining the two.

Below digrams are showing how in-context learning works:


```
          in-context learning with Llama Index                  ┌────┬────┬────┬────┐                                    │ 1  │ 2  │ 3  │ 4  │                                    ├────┴────┴────┴────┤                                    │  Docs/Knowledge   │                  ┌───────┐         │        ...        │       ┌─────────┐│       │         ├────┬────┬────┬────┤       │         ││       │         │ 95 │ 96 │    │    │       │         ││       │         └────┴────┴────┴────┘       │         ││ User  │─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─▶   LLM   ││       │                                     │         ││       │                                     │         │└───────┘    ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐  └─────────┘    │          ┌──────────────────────────┐        ▲         └────────┼▶│  Tell me ....., please   │├───────┘                    └──────────────────────────┘                           │ ┌────┐ ┌────┐               │                            │ 3  │ │ 96 │                                          │ └────┘ └────┘               │                           ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
```
With VectorStoreIndex, we create embeddings of each node(chunk), and find TopK related ones towards a given question during the query. In the above diagram, nodes `3` and `96` were fetched as the TopK related nodes, used to help answer the user query.

With KG Index, we will extract relationships between entities, representing concise facts from each node. It would look something like this:


```
Node Split and Embedding┌────┬────┬────┬────┐│ 1  │ 2  │ 3  │ 4  │├────┴────┴────┴────┤│  Docs/Knowledge   ││        ...        │├────┬────┬────┬────┤│ 95 │ 96 │    │    │└────┴────┴────┴────┘
```
Then, if we zoomed in of it:


```
       Node Split and Embedding, with Knowledge Graph being extracted┌──────────────────┬──────────────────┬──────────────────┬──────────────────┐│ .─.       .─.    │  .─.       .─.   │            .─.   │  .─.       .─.   ││( x )─────▶ y )   │ ( x )─────▶ a )  │           ( j )  │ ( m )◀────( x )  ││ `▲'       `─'    │  `─'       `─'   │            `─'   │  `─'       `─'   ││  │     1         │        2         │        3    │    │        4         ││ .─.              │                  │            .▼.   │                  ││( z )─────────────┼──────────────────┼──────────▶( i )─┐│                  ││ `◀────┐          │                  │            `─'  ││                  │├───────┼──────────┴──────────────────┴─────────────────┼┴──────────────────┤│       │                      Docs/Knowledge           │                   ││       │                            ...                │                   ││       │                                               │                   │├───────┼──────────┬──────────────────┬─────────────────┼┬──────────────────┤│  .─.  └──────.   │  .─.             │                 ││  .─.             ││ ( x ◀─────( b )  │ ( x )            │                 └┼▶( n )            ││  `─'       `─'   │  `─'             │                  │  `─'             ││        95   │    │   │    96        │                  │   │    98        ││            .▼.   │  .▼.             │                  │   ▼              ││           ( c )  │ ( d )            │                  │  .─.             ││            `─'   │  `─'             │                  │ ( x )            │└──────────────────┴──────────────────┴──────────────────┴──`─'─────────────┘
```
Where, knowledge, the more granular spliting and information with higher density, optionally multi-hop of `x -> y`, `i -> j -> z -> x` etc… across many more nodes(chunks) than K(in TopK search) could be inlucded in Retrievers. And we believe there are cases that this additional work matters.

Let’s show examples of that now.


```
# For OpenAIimport osos.environ["OPENAI\_API\_KEY"] = "INSERT OPENAI KEY"import loggingimport syslogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputfrom llama\_index import (    KnowledgeGraphIndex,    ServiceContext,    SimpleDirectoryReader,)from llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStorefrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display# define LLM# NOTE: at the time of demo, text-davinci-002 did not have rate-limit errorsllm = OpenAI(temperature=0, model="text-davinci-002")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size\_limit=512)
```

```
# For Azure OpenAIimport osimport jsonimport openaifrom llama\_index.llms import AzureOpenAIfrom llama\_index.embeddings import OpenAIEmbeddingfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    KnowledgeGraphIndex,    ServiceContext,)from llama\_index import set\_global\_service\_contextfrom llama\_index.storage.storage\_context import StorageContextfrom llama\_index.graph\_stores import NebulaGraphStoreimport loggingimport sysfrom IPython.display import Markdown, displaylogging.basicConfig(    stream=sys.stdout, level=logging.INFO)  # logging.DEBUG for more verbose outputlogging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))openai.api\_type = "azure"openai.api\_base = "https://<foo-bar>.openai.azure.com"openai.api\_version = "2022-12-01"os.environ["OPENAI\_API\_KEY"] = "youcannottellanyone"openai.api\_key = os.getenv("OPENAI\_API\_KEY")llm = AzureOpenAI(    engine="<foo-bar-deployment>",    temperature=0,    openai\_api\_version=openai.api\_version,    model\_kwargs={        "api\_key": openai.api\_key,        "api\_base": openai.api\_base,        "api\_type": openai.api\_type,        "api\_version": openai.api\_version,    },)# You need to deploy your own embedding model as well as your own chat completion modelembedding\_llm = OpenAIEmbedding(    model="text-embedding-ada-002",    deployment\_name="<foo-bar-deployment>",    api\_key=openai.api\_key,    api\_base=openai.api\_base,    api\_type=openai.api\_type,    api\_version=openai.api\_version,)service\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model=embedding\_llm,)set\_global\_service\_context(service\_context)
```
Prepare for NebulaGraph[](#prepare-for-nebulagraph "Permalink to this heading")
--------------------------------------------------------------------------------


```
%pip install nebula3-pythonos.environ["NEBULA\_USER"] = "root"os.environ["NEBULA\_PASSWORD"] = "nebula"os.environ[    "NEBULA\_ADDRESS"] = "127.0.0.1:9669"  # assumed we have NebulaGraph 3.5.0 or newer installed locally# Assume that the graph has already been created# Create a NebulaGraph cluster with:# Option 0: `curl -fsSL nebula-up.siwei.io/install.sh | bash`# Option 1: NebulaGraph Docker Extension https://hub.docker.com/extensions/weygu/nebulagraph-dd-ext# and that the graph space is called "llamaindex"# If not, create it with the following commands from NebulaGraph's console:# CREATE SPACE llamaindex(vid\_type=FIXED\_STRING(256), partition\_num=1, replica\_factor=1);# :sleep 10;# USE llamaindex;# CREATE TAG entity(name string);# CREATE EDGE relationship(relationship string);# CREATE TAG INDEX entity\_index ON entity(name(256));space\_name = "llamaindex"edge\_types, rel\_prop\_names = ["relationship"], [    "relationship"]  # default, could be omit if create from an empty kgtags = ["entity"]  # default, could be omit if create from an empty kg
```
Load Data from Wikipedia[](#load-data-from-wikipedia "Permalink to this heading")
----------------------------------------------------------------------------------


```
from llama\_index import download\_loaderWikipediaReader = download\_loader("WikipediaReader")loader = WikipediaReader()documents = loader.load\_data(pages=["2023 in science"], auto\_suggest=False)
```
Create KnowledgeGraphIndex Index[](#create-knowledgegraphindex-index "Permalink to this heading")
--------------------------------------------------------------------------------------------------


```
graph\_store = NebulaGraphStore(    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,)storage\_context = StorageContext.from\_defaults(graph\_store=graph\_store)kg\_index = KnowledgeGraphIndex.from\_documents(    documents,    storage\_context=storage\_context,    max\_triplets\_per\_chunk=10,    space\_name=space\_name,    edge\_types=edge\_types,    rel\_prop\_names=rel\_prop\_names,    tags=tags,    include\_embeddings=True,)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 21204 tokens> [build_index_from_nodes] Total LLM token usage: 21204 tokens> [build_index_from_nodes] Total LLM token usage: 21204 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 3953 tokens> [build_index_from_nodes] Total embedding token usage: 3953 tokens> [build_index_from_nodes] Total embedding token usage: 3953 tokens
```
Create VectorStoreIndex Index[](#create-vectorstoreindex-index "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
vector\_index = VectorStoreIndex.from\_documents(documents)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 15419 tokens> [build_index_from_nodes] Total embedding token usage: 15419 tokens> [build_index_from_nodes] Total embedding token usage: 15419 tokens
```
Define a CustomRetriever[](#define-a-customretriever "Permalink to this heading")
----------------------------------------------------------------------------------

The purpose of this demo was to test the effectiveness of using Knowledge Graph queries for retrieving information that is distributed across multiple nodes in small pieces. To achieve this, we adopted a simple approach: performing retrieval on both sources and then combining them into a single context to be sent to LLM.

Thanks to the flexible abstraction provided by Llama Index Retriever, implementing this approach was relatively straightforward. We created a new class called `CustomRetriever` which retrieves data from both `VectorIndexRetriever` and `KGTableRetriever`.


```
# import QueryBundlefrom llama\_index import QueryBundle# import NodeWithScorefrom llama\_index.schema import NodeWithScore# Retrieversfrom llama\_index.retrievers import (    BaseRetriever,    VectorIndexRetriever,    KGTableRetriever,)from typing import Listclass CustomRetriever(BaseRetriever): """Custom retriever that performs both Vector search and Knowledge Graph search"""    def \_\_init\_\_(        self,        vector\_retriever: VectorIndexRetriever,        kg\_retriever: KGTableRetriever,        mode: str = "OR",    ) -> None: """Init params."""        self.\_vector\_retriever = vector\_retriever        self.\_kg\_retriever = kg\_retriever        if mode not in ("AND", "OR"):            raise ValueError("Invalid mode.")        self.\_mode = mode    def \_retrieve(self, query\_bundle: QueryBundle) -> List[NodeWithScore]: """Retrieve nodes given query."""        vector\_nodes = self.\_vector\_retriever.retrieve(query\_bundle)        kg\_nodes = self.\_kg\_retriever.retrieve(query\_bundle)        vector\_ids = {n.node.node\_id for n in vector\_nodes}        kg\_ids = {n.node.node\_id for n in kg\_nodes}        combined\_dict = {n.node.node\_id: n for n in vector\_nodes}        combined\_dict.update({n.node.node\_id: n for n in kg\_nodes})        if self.\_mode == "AND":            retrieve\_ids = vector\_ids.intersection(kg\_ids)        else:            retrieve\_ids = vector\_ids.union(kg\_ids)        retrieve\_nodes = [combined\_dict[rid] for rid in retrieve\_ids]        return retrieve\_nodes
```
Next, we will create instances of the Vector and KG retrievers, which will be used in the instantiation of the Custom Retriever.


```
from llama\_index import get\_response\_synthesizerfrom llama\_index.query\_engine import RetrieverQueryEngine# create custom retrievervector\_retriever = VectorIndexRetriever(index=vector\_index)kg\_retriever = KGTableRetriever(    index=kg\_index, retriever\_mode="keyword", include\_text=False)custom\_retriever = CustomRetriever(vector\_retriever, kg\_retriever)# create response synthesizerresponse\_synthesizer = get\_response\_synthesizer(    service\_context=service\_context,    response\_mode="tree\_summarize",)
```
Create Query Engines[](#create-query-engines "Permalink to this heading")
--------------------------------------------------------------------------

To enable comparsion, we also create `vector\_query\_engine`, `kg\_keyword\_query\_engine` together with our `custom\_query\_engine`.


```
custom\_query\_engine = RetrieverQueryEngine(    retriever=custom\_retriever,    response\_synthesizer=response\_synthesizer,)vector\_query\_engine = vector\_index.as\_query\_engine()kg\_keyword\_query\_engine = kg\_index.as\_query\_engine(    # setting to false uses the raw triplets instead of adding the text from the corresponding nodes    include\_text=False,    retriever\_mode="keyword",    response\_mode="tree\_summarize",)
```
Query with different retrievers[](#query-with-different-retrievers "Permalink to this heading")
------------------------------------------------------------------------------------------------

With the above query engines created for corresponding retrievers, let’s see how they perform.

First, we go with the pure knowledge graph.


```
response = kg\_keyword\_query\_engine.query("Tell me events about NASA")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me events about NASA> Starting query: Tell me events about NASA> Starting query: Tell me events about NASAINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['NASA', 'events']> Query keywords: ['NASA', 'events']> Query keywords: ['NASA', 'events']INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 159 tokens> [get_response] Total LLM token usage: 159 tokens> [get_response] Total LLM token usage: 159 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 159 tokens> [get_response] Total LLM token usage: 159 tokens> [get_response] Total LLM token usage: 159 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**NASA announced future space telescope programs in mid-2023, published images of a debris disk, and discovered an exoplanet called LHS 475 b.**Then the vector store approach.


```
response = vector\_query\_engine.query("Tell me events about NASA")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 5 tokens> [retrieve] Total embedding token usage: 5 tokens> [retrieve] Total embedding token usage: 5 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1892 tokens> [get_response] Total LLM token usage: 1892 tokens> [get_response] Total LLM token usage: 1892 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**NASA scientists report evidence for the existence of a second Kuiper Belt, which the New Horizons spacecraft could potentially visit during the late 2020s or early 2030s.NASA is expected to release the first study on UAP in mid-2023.NASA's Venus probe is scheduled to be launched and to arrive on Venus in October, partly to search for signs of life on Venus.NASA is expected to start the Vera Rubin Observatory, the Qitai Radio Telescope, the European Spallation Source and the Jiangmen Underground Neutrino.NASA scientists suggest that a space sunshade could be created by mining the lunar soil and launching it towards the Sun to form a shield against global warming.**Finally, let’s do with the one with both vector store and knowledge graph.


```
response = custom\_query\_engine.query("Tell me events about NASA")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 5 tokens> [retrieve] Total embedding token usage: 5 tokens> [retrieve] Total embedding token usage: 5 tokensINFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me events about NASA> Starting query: Tell me events about NASA> Starting query: Tell me events about NASAINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['NASA', 'events']> Query keywords: ['NASA', 'events']> Query keywords: ['NASA', 'events']INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`nasa ['public release date', 'mid-2023']nasa ['announces', 'future space telescope programs']nasa ['publishes images of', 'debris disk']nasa ['discovers', 'exoplanet lhs 475 b']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2046 tokens> [get_response] Total LLM token usage: 2046 tokens> [get_response] Total LLM token usage: 2046 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2046 tokens> [get_response] Total LLM token usage: 2046 tokens> [get_response] Total LLM token usage: 2046 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**NASA announces future space telescope programs on May 21.NASA publishes images of debris disk on May 23.NASA discovers exoplanet LHS 475 b on May 25.NASA scientists present evidence for the existence of a second Kuiper Belt on May 29.NASA confirms the start of the next El Niño on June 8.NASA produces the first X-ray of a single atom on May 31.NASA reports the first successful beaming of solar energy from space down to a receiver on the ground on June 1.NASA scientists report evidence that Earth may have formed in just three million years on June 14.NASA scientists report the presence of phosphates on Enceladus, moon of the planet Saturn, on June 14.NASA's Venus probe is scheduled to be launched and to arrive on Venus in October.NASA's MBR Explorer is announced by the United Arab Emirates Space Agency on May 29.NASA's Vera Rubin Observatory is expected to start in 2023.**Comparison of results[](#comparison-of-results "Permalink to this heading")
----------------------------------------------------------------------------

Let’s put results together with their LLM tokens during the query process:


> Tell me events about NASA.
> 
> 



|  | VectorStore | Knowledge Graph + VectorStore | Knowledge Graph |
| --- | --- | --- | --- |
| Answer | NASA scientists report evidence for the existence of a second Kuiper Belt, which the New Horizons spacecraft could potentially visit during the late 2020s or early 2030s. NASA is expected to release the first study on UAP in mid-2023. NASA’s Venus probe is scheduled to be launched and to arrive on Venus in October, partly to search for signs of life on Venus. NASA is expected to start the Vera Rubin Observatory, the Qitai Radio Telescope, the European Spallation Source and the Jiangmen Underground Neutrino. NASA scientists suggest that a space sunshade could be created by mining the lunar soil and launching it towards the Sun to form a shield against global warming. | NASA announces future space telescope programs on May 21. **NASA publishes images of debris disk on May 23. NASA discovers exoplanet LHS 475 b on May 25.** NASA scientists present evidence for the existence of a second Kuiper Belt on May 29. NASA confirms the start of the next El Niño on June 8. NASA produces the first X-ray of a single atom on May 31. NASA reports the first successful beaming of solar energy from space down to a receiver on the ground on June 1. NASA scientists report evidence that Earth may have formed in just three million years on June 14. NASA scientists report the presence of phosphates on Enceladus, moon of the planet Saturn, on June 14. NASA’s Venus probe is scheduled to be launched and to arrive on Venus in October. NASA’s MBR Explorer is announced by the United Arab Emirates Space Agency on May 29. NASA’s Vera Rubin Observatory is expected to start in 2023. | NASA announced future space telescope programs in mid-2023, published images of a debris disk, and discovered an exoplanet called LHS 475 b. |
| Cost | 1897 tokens | 2046 Tokens | 159 Tokens |

And we could see there are indeed some knowledges added with the help of Knowledge Graph retriever:

* NASA publishes images of debris disk on May 23.
* NASA discovers exoplanet LHS 475 b on May 25.

The additional cost, however, does not seem to be very significant, at `7.28%`: `(2046-1897)/2046`.

Furthermore, the answer from the knowledge graph is extremely concise (only 159 tokens used!), but is still informative.

Not all cases are advantageous[](#not-all-cases-are-advantageous "Permalink to this heading")
----------------------------------------------------------------------------------------------

While, of course, many other questions do not contain small-grained pieces of knowledges in chunks. In these cases, the extra Knowledge Graph retriever may not that helpful. Let’s see this question: “Tell me events about ChatGPT”.


```
response = custom\_query\_engine.query("Tell me events about ChatGPT")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 7 tokens> [retrieve] Total embedding token usage: 7 tokens> [retrieve] Total embedding token usage: 7 tokensINFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me events about ChatGPT> Starting query: Tell me events about ChatGPT> Starting query: Tell me events about ChatGPTINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['events', 'ChatGPT']> Query keywords: ['events', 'ChatGPT']> Query keywords: ['events', 'ChatGPT']INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2045 tokens> [get_response] Total LLM token usage: 2045 tokens> [get_response] Total LLM token usage: 2045 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2045 tokens> [get_response] Total LLM token usage: 2045 tokens> [get_response] Total LLM token usage: 2045 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**ChatGPT is a chatbot and text-generating AI released on 30 November 2022. It quickly became highly popular, with some estimating that only two months after its launch, it had 100 million active users. Potential applications of ChatGPT include solving or supporting school writing assignments, malicious social bots (e.g. for misinformation, propaganda, and scams), and providing inspiration (e.g. for artistic writing or in design or ideation in general). There was extensive media coverage of views that regard ChatGPT as a potential step towards AGI or sentient machines, also extending to some academic works. Google released chatbot Bard due to effects of the ChatGPT release, with potential for integration into its Web search and, like ChatGPT software, also as a software development helper tool (21 Mar). DuckDuckGo released the DuckAssist feature integrated into its search engine that summarizes information from Wikipedia to answer search queries that are questions (8 Mar). The experimental feature was shut down without explanation on 12 April. Around the same time, a proprietary feature by scite.ai was released that delivers answers that use research papers and provide citations for the quoted paper(s). An open letter "Pause Giant AI Experiments" by the Future of Life**
```
response = kg\_keyword\_query\_engine.query("Tell me events about ChatGPT")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.indices.knowledge_graph.retriever:> Starting query: Tell me events about ChatGPT> Starting query: Tell me events about ChatGPT> Starting query: Tell me events about ChatGPTINFO:llama_index.indices.knowledge_graph.retriever:> Query keywords: ['events', 'ChatGPT']> Query keywords: ['events', 'ChatGPT']> Query keywords: ['events', 'ChatGPT']INFO:llama_index.indices.knowledge_graph.retriever:> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']> Extracted relationships: The following are knowledge triplets in max depth 2 in the form of `subject [predicate, object, predicate_next_hop, object_next_hop ...]`chatgpt ['is', 'language model']chatgpt ['outperform', 'human doctors']chatgpt ['has', '100 million active users']chatgpt ['released on', '30 nov 2022']INFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 150 tokens> [get_response] Total LLM token usage: 150 tokens> [get_response] Total LLM token usage: 150 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 150 tokens> [get_response] Total LLM token usage: 150 tokens> [get_response] Total LLM token usage: 150 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**ChatGPT is a language model that outperforms human doctors and has 100 million active users. It was released on 30 November 2022.**
```
response = vector\_query\_engine.query("Tell me events about ChatGPT")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 7 tokens> [retrieve] Total embedding token usage: 7 tokens> [retrieve] Total embedding token usage: 7 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 1956 tokens> [get_response] Total LLM token usage: 1956 tokens> [get_response] Total LLM token usage: 1956 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**ChatGPT (released on 30 Nov 2022) is a chatbot and text-generating AI, and a large language model that quickly became highly popular. It is estimated that only two months after its launch, it had 100 million active users. Applications may include solving or supporting school writing assignments, malicious social bots (e.g. for misinformation, propaganda, and scams), and providing inspiration (e.g. for artistic writing or in design or ideation in general).In response to the ChatGPT release, Google released chatbot Bard (21 Mar) with potential for integration into its Web search and, like ChatGPT software, also as a software development helper tool. DuckDuckGo released the DuckAssist feature integrated into its search engine that summarizes information from Wikipedia to answer search queries that are questions (8 Mar). The experimental feature was shut down without explanation on 12 April.Around the time, a proprietary feature by scite.ai was released that delivers answers that use research papers and provide citations for the quoted paper(s).An open letter "Pause Giant AI Experiments" by the Future of Life Institute calls for "AI labs to immediately pause for at least 6 months the training of AI systems more powerful than GPT-**Comparison of results[](#id1 "Permalink to this heading")
----------------------------------------------------------

We can see that being w/ vs. w/o Knowledge Graph has no unique advantage under this question.


> Question: Tell me events about ChatGPT.
> 
> 



|  | VectorStore | Knowledge Graph + VectorStore | Knowledge Graph |
| --- | --- | --- | --- |
| Answer | ChatGPT (released on 30 Nov 2022) is a chatbot and text-generating AI, and a large language model that quickly became highly popular. It is estimated that only two months after its launch, it had 100 million active users. Applications may include solving or supporting school writing assignments, malicious social bots (e.g. for misinformation, propaganda, and scams), and providing inspiration (e.g. for artistic writing or in design or ideation in general). In response to the ChatGPT release, Google released chatbot Bard (21 Mar) with potential for integration into its Web search and, like ChatGPT software, also as a software development helper tool. DuckDuckGo released the DuckAssist feature integrated into its search engine that summarizes information from Wikipedia to answer search queries that are questions (8 Mar). The experimental feature was shut down without explanation on 12 April. Around the time, a proprietary feature by scite.ai was released that delivers answers that use research papers and provide citations for the quoted paper(s). An open letter “Pause Giant AI Experiments” by the Future of Life Institute calls for “AI labs to immediately pause for at least 6 months the training of AI systems more powerful than GPT- | ChatGPT is a chatbot and text-generating AI released on 30 November 2022. It quickly became highly popular, with some estimating that only two months after its launch, it had 100 million active users. Potential applications of ChatGPT include solving or supporting school writing assignments, malicious social bots (e.g. for misinformation, propaganda, and scams), and providing inspiration (e.g. for artistic writing or in design or ideation in general). There was extensive media coverage of views that regard ChatGPT as a potential step towards AGI or sentient machines, also extending to some academic works. Google released chatbot Bard due to effects of the ChatGPT release, with potential for integration into its Web search and, like ChatGPT software, also as a software development helper tool (21 Mar). DuckDuckGo released the DuckAssist feature integrated into its search engine that summarizes information from Wikipedia to answer search queries that are questions (8 Mar). The experimental feature was shut down without explanation on 12 April. Around the same time, a proprietary feature by scite.ai was released that delivers answers that use research papers and provide citations for the quoted paper(s). An open letter “Pause Giant AI Experiments” by the Future of Life | ChatGPT is a language model that outperforms human doctors and has 100 million active users. It was released on 30 November 2022. |
| Cost | 1963 Tokens | 2045 Tokens | 150 Tokens |


```
## create graphfrom pyvis.network import Networkg = kg\_index.get\_networkx\_graph(200)net = Network(notebook=True, cdn\_resources="in\_line", directed=True)net.from\_nx(g)net.show("2023\_Science\_Wikipedia\_KnowledgeGraph.html")
```

```
2023_Science_Wikipedia_KnowledgeGraph.html
```
