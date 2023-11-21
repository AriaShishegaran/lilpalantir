[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/embeddings/elasticsearch.ipynb)

Elasticsearch Embeddings[](#elasticsearch-embeddings "Permalink to this heading")
==================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# importsfrom llama\_index.embeddings.elasticsearch import ElasticsearchEmbeddingfrom llama\_index.vector\_stores import ElasticsearchStorefrom llama\_index import ServiceContext, StorageContext, VectorStoreIndex
```

```
# get credentials and create embeddingsimport oshost = os.environ.get("ES\_HOST", "localhost:9200")username = os.environ.get("ES\_USERNAME", "elastic")password = os.environ.get("ES\_PASSWORD", "changeme")index\_name = os.environ.get("INDEX\_NAME", "your-index-name")model\_id = os.environ.get("MODEL\_ID", "your-model-id")embeddings = ElasticsearchEmbedding.from\_credentials(    model\_id=model\_id, es\_url=host, es\_username=username, es\_password=password)
```

```
# create service context using the embeddingsservice\_context = ServiceContext(embed\_model=embeddings, chunk\_size=512)
```

```
# usage with elasticsearch vector storevector\_store = ElasticsearchStore(    index\_name=index\_name, es\_url=host, es\_user=username, es\_password=password)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_vector\_store(    vector\_store=vector\_store,    storage\_context=storage\_context,    service\_context=service\_context,)query\_engine = index.as\_query\_engine()response = query\_engine.query("hello world")
```
