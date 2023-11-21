[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/DeepLakeIndexDemo.ipynb)

DeepLake Vector Store[](#deeplake-vector-store "Permalink to this heading")
============================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport textwrapfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, Documentfrom llama\_index.vector\_stores import DeepLakeVectorStoreos.environ["OPENAI\_API\_KEY"] = "sk-\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*"os.environ["ACTIVELOOP\_TOKEN"] = "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*"
```

```
/Users/adilkhansarsen/Documents/work/LlamaIndex/llama_index/GPTIndex/lib/python3.9/site-packages/tqdm/auto.py:21: TqdmWarning: IProgress not found. Please update jupyter and ipywidgets. See https://ipywidgets.readthedocs.io/en/stable/user_install.html  from .autonotebook import tqdm as notebook_tqdm
```

```
!pip install deeplake
```
if you don’t export token in your environment alternativalay you can use deeplake CLI to loging to deeplake


```
# !activeloop login -t <TOKEN>
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()print(    "Document ID:",    documents[0].doc\_id,    "Document Hash:",    documents[0].doc\_hash,)
```

```
Document ID: 14935662-4884-4c57-ac2e-fa62da019665 Document Hash: 77ae91ab542f3abb308c4d7c77c9bc4c9ad0ccd63144802b7cbe7e1bb3a4094e
```

```
# dataset\_path = "hub://adilkhan/paul\_graham\_essay" # if we comment this out and don't pass the path then GPTDeepLakeIndex will create dataset in memoryfrom llama\_index.storage.storage\_context import StorageContextdataset\_path = "paul\_graham\_essay"# Create an index over the documntsvector\_store = DeepLakeVectorStore(dataset\_path=dataset\_path, overwrite=True)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context)
```

```
Your Deep Lake dataset has been successfully created!The dataset is private so make sure you are logged in!
```

```
|
```

```
This dataset can be visualized in Jupyter Notebook by ds.visualize() or at https://app.activeloop.ai/adilkhan/paul_graham_essay
```

```
 
```

```
hub://adilkhan/paul_graham_essay loaded successfully.
```

```
Evaluating ingest: 100%|██████████| 1/1 [00:21<00:00INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 17617 tokens
```

```
Dataset(path='hub://adilkhan/paul_graham_essay', tensors=['embedding', 'ids', 'metadata', 'text'])  tensor     htype     shape     dtype  compression  -------   -------   -------   -------  -------  embedding  generic  (6, 1536)   None     None       ids      text     (6, 1)      str     None    metadata    json     (6, 1)      str     None      text      text     (6, 1)      str     None   
```
if we decide to not pass the path then GPTDeepLakeIndex will create dataset locally called llama\_index


```
# Create an index over the documnts# vector\_store = DeepLakeVectorStore(overwrite=True)# storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)# index = VectorStoreIndex.from\_documents(documents, storage\_context=storage\_context)
```

```
llama_index loaded successfully.
```

```
Evaluating ingest: 100%|██████████| 1/1 [00:04<00:00INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 17617 tokens
```

```
Dataset(path='llama_index', tensors=['embedding', 'ids', 'metadata', 'text'])  tensor     htype     shape     dtype  compression  -------   -------   -------   -------  -------  embedding  generic  (6, 1536)   None     None       ids      text     (6, 1)      str     None    metadata    json     (6, 1)      str     None      text      text     (6, 1)      str     None   
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query(    "What did the author learn?",)
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 4028 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 6 tokens
```

```
print(textwrap.fill(str(response), 100))
```

```
  The author learned that working on things that are not prestigious can be a good thing, as it canlead to discovering something real and avoiding the wrong track. The author also learned thatignorance can be beneficial, as it can lead to discovering something new and unexpected. The authoralso learned the importance of working hard, even at the parts of the job they don't like, in orderto set an example for others. The author also learned the value of unsolicited advice, as it can bebeneficial in unexpected ways, such as when Robert Morris suggested that the author should make sureY Combinator wasn't the last cool thing they did.
```

```
response = query\_engine.query("What was a hard moment for the author?")
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 4072 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 9 tokens
```

```
print(textwrap.fill(str(response), 100))
```

```
 A hard moment for the author was when he was dealing with urgent problems during YC and about 60%of them had to do with Hacker News, a news aggregator he had created. He was overwhelmed by theamount of work he had to do to keep Hacker News running, and it was taking away from his ability tofocus on other projects. He was also haunted by the idea that his own work ethic set the upper boundfor how hard everyone else worked, so he felt he had to work very hard. He was also dealing withdisputes between cofounders, figuring out when people were lying to them, and fighting with peoplewho maltreated the startups. On top of this, he was given unsolicited advice from Robert Morris tomake sure Y Combinator wasn't the last cool thing he did, which made him consider quitting.
```

```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What was a hard moment for the author?")print(textwrap.fill(str(response), 100))
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 4072 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 9 tokens
```

```
 A hard moment for the author was when he was dealing with urgent problems during YC and about 60%of them had to do with Hacker News, a news aggregator he had created. He was overwhelmed by theamount of work he had to do to keep Hacker News running, and it was taking away from his ability tofocus on other projects. He was also haunted by the idea that his own work ethic set the upper boundfor how hard everyone else worked, so he felt he had to work very hard. He was also dealing withdisputes between cofounders, figuring out when people were lying to them, and fighting with peoplewho maltreated the startups. On top of this, he was given unsolicited advice from Robert Morris tomake sure Y Combinator wasn't the last cool thing he did, which made him consider quitting.
```
Deleting items from the database[](#deleting-items-from-the-database "Permalink to this heading")
--------------------------------------------------------------------------------------------------


```
import deeplake as dpds = dp.load("paul\_graham\_essay")idx = ds.ids[0].numpy().tolist()
```

```
\
```

```
This dataset can be visualized in Jupyter Notebook by ds.visualize() or at https://app.activeloop.ai/adilkhan/paul_graham_essay
```

```
\
```

```
hub://adilkhan/paul_graham_essay loaded successfully.
```

```
 
```

```
index.delete(idx[0])
```

```
100%|██████████| 6/6 [00:00<00:00, 4501.13it/s] 
```

```
Dataset(path='hub://adilkhan/paul_graham_essay', tensors=['embedding', 'ids', 'metadata', 'text'])  tensor     htype     shape     dtype  compression  -------   -------   -------   -------  -------  embedding  generic  (5, 1536)   None     None       ids      text     (5, 1)      str     None    metadata    json     (5, 1)      str     None      text      text     (5, 1)      str     None   
```
