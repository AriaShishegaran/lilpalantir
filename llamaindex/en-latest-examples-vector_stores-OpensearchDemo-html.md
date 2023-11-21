[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/OpensearchDemo.ipynb)

Opensearch Vector Store[](#opensearch-vector-store "Permalink to this heading")
================================================================================

Elasticsearch only supports Lucene indices, so only Opensearch is supported.

**Note on setup**: We setup a local Opensearch instance through the following doc. https://opensearch.org/docs/1.0/

If you run into SSL issues, try the following `docker run` command instead:


```
docker run -p 9200:9200 -p 9600:9600 -e "discovery.type=single-node" -e "plugins.security.disabled=true" opensearchproject/opensearch:1.0.1
```
Reference: https://github.com/opensearch-project/OpenSearch/issues/1598

Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from os import getenvfrom llama\_index import SimpleDirectoryReaderfrom llama\_index.vector\_stores import (    OpensearchVectorStore,    OpensearchVectorClient,)from llama\_index import VectorStoreIndex, StorageContext# http endpoint for your cluster (opensearch required for vector index usage)endpoint = getenv("OPENSEARCH\_ENDPOINT", "http://localhost:9200")# index to demonstrate the VectorStore implidx = getenv("OPENSEARCH\_INDEX", "gpt-index-demo")# load some sample datadocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```

```
# OpensearchVectorClient stores text in this field by defaulttext\_field = "content"# OpensearchVectorClient stores embeddings in this field by defaultembedding\_field = "embedding"# OpensearchVectorClient encapsulates logic for a# single opensearch index with vector search enabledclient = OpensearchVectorClient(    endpoint, idx, 1536, embedding\_field=embedding\_field, text\_field=text\_field)# initialize vector storevector\_store = OpensearchVectorStore(client)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# initialize an index using our sample data and the client we just createdindex = VectorStoreIndex.from\_documents(    documents=documents, storage\_context=storage\_context)
```

```
# run queryquery\_engine = index.as\_query\_engine()res = query\_engine.query("What did the author do growing up?")res.response
```

```
INFO:root:> [query] Total LLM token usage: 29628 tokensINFO:root:> [query] Total embedding token usage: 8 tokens
```

```
'\n\nThe author grew up writing short stories, programming on an IBM 1401, and building a computer kit from Heathkit. They also wrote programs for a TRS-80, such as games, a program to predict model rocket flight, and a word processor. After years of nagging, they convinced their father to buy a TRS-80, and they wrote simple games, a program to predict how high their model rockets would fly, and a word processor that their father used to write at least one book. In college, they studied philosophy and AI, and wrote a book about Lisp hacking. They also took art classes and applied to art schools, and experimented with computer graphics and animation, exploring the use of algorithms to create art. Additionally, they experimented with machine learning algorithms, such as using neural networks to generate art, and exploring the use of numerical values to create art. They also took classes in fundamental subjects like drawing, color, and design, and applied to two art schools, RISD in the US, and the Accademia di Belli Arti in Florence. They were accepted to RISD, and while waiting to hear back from the Accademia, they learned Italian and took the entrance exam in Florence. They eventually graduated from RISD'
```
The OpenSearch vector store supports [filter-context queries](https://opensearch.org/docs/latest/query-dsl/query-filter-context/).


```
from llama\_index import Documentfrom llama\_index.vector\_stores.types import MetadataFilters, ExactMatchFilterimport regex as re
```

```
# Split the text into paragraphs.text\_chunks = documents[0].text.split("\n\n")# Create a document for each footnotefootnotes = [    Document(        text=chunk,        id=documents[0].doc\_id,        metadata={"is\_footnote": bool(re.search(r"^\s\*\[\d+\]\s\*", chunk))},    )    for chunk in text\_chunks    if bool(re.search(r"^\s\*\[\d+\]\s\*", chunk))]
```

```
# Insert the footnotes into the indexfor f in footnotes:    index.insert(f)
```

```
# Create a query engine that only searches certain footnotes.footnote\_query\_engine = index.as\_query\_engine(    filters=MetadataFilters(        filters=[            ExactMatchFilter(                key="term", value='{"metadata.is\_footnote": "true"}'            ),            ExactMatchFilter(                key="query\_string",                value='{"query": "content: space AND content: lisp"}',            ),        ]    ))res = footnote\_query\_engine.query(    "What did the author about space aliens and lisp?")res.response
```

```
"The author believes that any sufficiently advanced alien civilization would know about the Pythagorean theorem and possibly also about Lisp in McCarthy's 1960 paper."
```
Use reader to check out what VectorStoreIndex just created in our index.[](#use-reader-to-check-out-what-vectorstoreindex-just-created-in-our-index "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Reader works with Elasticsearch too as it just uses the basic search features.


```
# create a reader to check out the index used in previous section.from llama\_index.readers import ElasticsearchReaderrdr = ElasticsearchReader(endpoint, idx)# set embedding\_field optionally to read embedding data from the elasticsearch indexdocs = rdr.load\_data(text\_field, embedding\_field=embedding\_field)# docs have embeddings in themprint("embedding dimension:", len(docs[0].embedding))# full document is stored in metadataprint("all fields in index:", docs[0].metadata.keys())
```

```
embedding dimension: 1536all fields in index: dict_keys(['content', 'embedding'])
```

```
# we can check out how the text was chunked by the `GPTOpensearchIndex`print("total number of chunks created:", len(docs))
```

```
total number of chunks: 10
```

```
# search index using standard elasticsearch query DSLdocs = rdr.load\_data(text\_field, {"query": {"match": {text\_field: "Lisp"}}})print("chunks that mention Lisp:", len(docs))docs = rdr.load\_data(text\_field, {"query": {"match": {text\_field: "Yahoo"}}})print("chunks that mention Yahoo:", len(docs))
```

```
chunks that mention Lisp: 10chunks that mention Yahoo: 8
```
