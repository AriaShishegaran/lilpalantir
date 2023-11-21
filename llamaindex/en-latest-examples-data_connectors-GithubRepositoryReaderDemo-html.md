[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/GithubRepositoryReaderDemo.ipynb)

Github Repo Reader[](#github-repo-reader "Permalink to this heading")
======================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# This is due to the fact that we use asyncio.loop\_until\_complete in# the DiscordReader. Since the Jupyter kernel itself runs on# an event loop, we need to add some help with nesting!pip install nest_asyncio httpximport nest\_asyncionest\_asyncio.apply()
```

```
%env OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxfrom llama\_index import VectorStoreIndex, GithubRepositoryReaderfrom IPython.display import Markdown, displayimport os
```

```
%env GITHUB_TOKEN=github_pat_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxgithub\_token = os.environ.get("GITHUB\_TOKEN")owner = "jerryjliu"repo = "llama\_index"branch = "main"documents = GithubRepositoryReader(    github\_token=github\_token,    owner=owner,    repo=repo,    use\_parser=False,    verbose=False,    ignore\_directories=["examples"],).load\_data(branch=branch)
```

```
index = VectorStoreIndex.from\_documents(documents)
```

```
# import time# for document in documents:# print(document.metadata)# time.sleep(.25)query\_engine = index.as\_query\_engine()response = query\_engine.query(    "What is the difference between VectorStoreIndex and SummaryIndex?",    verbose=True,)
```

```
display(Markdown(f"<b>{response}</b>"))
```
