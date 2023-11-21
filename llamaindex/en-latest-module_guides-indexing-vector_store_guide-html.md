Vector Store Index[](#vector-store-index "Permalink to this heading")
======================================================================

In this guide, we show how to use the vector store index with different vector storeimplementations.

From how to get started with few lines of code with the defaultin-memory vector store with default query configuration, to using a custom hosted vectorstore, with advanced settings such as metadata filters.

Construct vector store and index[](#construct-vector-store-and-index "Permalink to this heading")
--------------------------------------------------------------------------------------------------

**Default**

By default, `VectorStoreIndex` uses a in-memory `SimpleVectorStore`that’s initialized as part of the default storage context.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReader# Load documents and build indexdocuments = SimpleDirectoryReader(    "../../examples/data/paul\_graham").load\_data()index = VectorStoreIndex.from\_documents(documents)
```
**Custom vector stores**

You can use a custom vector store (in this case `PineconeVectorStore`) as follows:


```
import pineconefrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, StorageContextfrom llama\_index.vector\_stores import PineconeVectorStore# init pineconepinecone.init(api\_key="<api\_key>", environment="<environment>")pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")# construct vector store and customize storage contextstorage\_context = StorageContext.from\_defaults(    vector\_store=PineconeVectorStore(pinecone.Index("quickstart")))# Load documents and build indexdocuments = SimpleDirectoryReader(    "../../examples/data/paul\_graham").load\_data()index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```
For more examples of how to initialize different vector stores,see [Vector Store Integrations](../../community/integrations/vector_stores.html).

Connect to external vector stores (with existing embeddings)[](#connect-to-external-vector-stores-with-existing-embeddings "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------

If you have already computed embeddings and dumped them into an external vector store (e.g. Pinecone, Chroma), you can use it with LlamaIndex by:


```
vector\_store = PineconeVectorStore(pinecone.Index("quickstart"))index = VectorStoreIndex.from\_vector\_store(vector\_store=vector\_store)
```
### Query[](#query "Permalink to this heading")

**Default**

You can start querying by getting the default query engine:


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")
```
**Configure standard query setting**

To configure query settings, you can directly pass it askeyword args when building the query engine:


```
from llama\_index.vector\_stores.types import ExactMatchFilter, MetadataFiltersquery\_engine = index.as\_query\_engine(    similarity\_top\_k=3,    vector\_store\_query\_mode="default",    filters=MetadataFilters(        filters=[            ExactMatchFilter(key="name", value="paul graham"),        ]    ),    alpha=None,    doc\_ids=None,)response = query\_engine.query("what did the author do growing up?")
```
Note that metadata filtering is applied against metadata specified in `Node.metadata`.

Alternatively, if you are using the lower-level compositional API:


```
from llama\_index import get\_response\_synthesizerfrom llama\_index.indices.vector\_store.retrievers import VectorIndexRetrieverfrom llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)# build retrieverretriever = VectorIndexRetriever(    index=index,    similarity\_top\_k=3,    vector\_store\_query\_mode="default",    filters=[ExactMatchFilter(key="name", value="paul graham")],    alpha=None,    doc\_ids=None,)# build query enginequery\_engine = RetrieverQueryEngine(    retriever=retriever, response\_synthesizer=get\_response\_synthesizer())# queryresponse = query\_engine.query("what did the author do growing up?")
```
**Configure vector store specific keyword arguments**

You can customize keyword arguments unique to a specific vector store implementation as well by passing in `vector\_store\_kwargs`


```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=3,    # only works for pinecone    vector\_store\_kwargs={        "filter": {"name": "paul graham"},    },)response = query\_engine.query("what did the author do growing up?")
```
**Use an auto retriever**

You can also use an LLM to automatically decide query setting for you!Right now, we support automatically setting exact match metadata filters and top k parameters.


```
from llama\_index import get\_response\_synthesizerfrom llama\_index.indices.vector\_store.retrievers import (    VectorIndexAutoRetriever,)from llama\_index.query\_engine.retriever\_query\_engine import (    RetrieverQueryEngine,)from llama\_index.vector\_stores.types import MetadataInfo, VectorStoreInfovector\_store\_info = VectorStoreInfo(    content\_info="brief biography of celebrities",    metadata\_info=[        MetadataInfo(            name="category",            type="str",            description="Category of the celebrity, one of [Sports, Entertainment, Business, Music]",        ),        MetadataInfo(            name="country",            type="str",            description="Country of the celebrity, one of [United States, Barbados, Portugal]",        ),    ],)# build retrieverretriever = VectorIndexAutoRetriever(    index, vector\_store\_info=vector\_store\_info)# build query enginequery\_engine = RetrieverQueryEngine(    retriever=retriever, response\_synthesizer=get\_response\_synthesizer())# queryresponse = query\_engine.query(    "Tell me about two celebrities from United States")
```
