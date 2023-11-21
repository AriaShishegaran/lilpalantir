ChatGPT Plugin Integrations[](#chatgpt-plugin-integrations "Permalink to this heading")
========================================================================================

**NOTE**: This is a work-in-progress, stay tuned for more exciting updates on this front!

ChatGPT Retrieval Plugin Integrations[](#chatgpt-retrieval-plugin-integrations "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

The [OpenAI ChatGPT Retrieval Plugin](https://github.com/openai/chatgpt-retrieval-plugin)offers a centralized API specification for any document storage system to interactwith ChatGPT. Since this can be deployed on any service, this means that more and moredocument retrieval services will implement this spec; this allows them to not onlyinteract with ChatGPT, but also interact with any LLM toolkit that may usea retrieval service.

LlamaIndex provides a variety of integrations with the ChatGPT Retrieval Plugin.

### Loading Data from LlamaHub into the ChatGPT Retrieval Plugin[](#loading-data-from-llamahub-into-the-chatgpt-retrieval-plugin "Permalink to this heading")

The ChatGPT Retrieval Plugin defines an `/upsert` endpoint for users to loaddocuments. This offers a natural integration point with LlamaHub, which offersover 65 data loaders from various API’s and document formats.

Here is a sample code snippet of showing how to load a document from LlamaHubinto the JSON format that `/upsert` expects:


```
from llama\_index import download\_loader, Documentfrom typing import Dict, Listimport json# download loader, load documentsSimpleWebPageReader = download\_loader("SimpleWebPageReader")loader = SimpleWebPageReader(html\_to\_text=True)url = "http://www.paulgraham.com/worked.html"documents = loader.load\_data(urls=[url])# Convert LlamaIndex Documents to JSON formatdef dump\_docs\_to\_json(documents: List[Document], out\_path: str) -> Dict: """Convert LlamaIndex Documents to JSON format and save it."""    result\_json = []    for doc in documents:        cur\_dict = {            "text": doc.get\_text(),            "id": doc.get\_doc\_id(),            # NOTE: feel free to customize the other fields as you wish            # fields taken from https://github.com/openai/chatgpt-retrieval-plugin/tree/main/scripts/process\_json#usage            # "source": ...,            # "source\_id": ...,            # "url": url,            # "created\_at": ...,            # "author": "Paul Graham",        }        result\_json.append(cur\_dict)    json.dump(result\_json, open(out\_path, "w"))
```
For more details, check out the [full example notebook](https://github.com/jerryjliu/llama_index/blob/main/examples/chatgpt_plugin/ChatGPT_Retrieval_Plugin_Upload.ipynb).

### ChatGPT Retrieval Plugin Data Loader[](#chatgpt-retrieval-plugin-data-loader "Permalink to this heading")

The ChatGPT Retrieval Plugin data loader [can be accessed on LlamaHub](https://llamahub.ai/l/chatgpt_plugin).

It allows you to easily load data from any docstore that implements the plugin API, into a LlamaIndex data structure.

Example code:


```
from llama\_index.readers import ChatGPTRetrievalPluginReaderimport os# load documentsbearer\_token = os.getenv("BEARER\_TOKEN")reader = ChatGPTRetrievalPluginReader(    endpoint\_url="http://localhost:8000", bearer\_token=bearer\_token)documents = reader.load\_data("What did the author do growing up?")# build and query indexfrom llama\_index import SummaryIndexindex = SummaryIndex.from\_documents(documents)# set Logging to DEBUG for more detailed outputsquery\_engine = vector\_index.as\_query\_engine(response\_mode="compact")response = query\_engine.query(    "Summarize the retrieved content and describe what the author did growing up",)
```
For more details, check out the [full example notebook](https://github.com/jerryjliu/llama_index/blob/main/examples/chatgpt_plugin/ChatGPTRetrievalPluginReaderDemo.ipynb).

### ChatGPT Retrieval Plugin Index[](#chatgpt-retrieval-plugin-index "Permalink to this heading")

The ChatGPT Retrieval Plugin Index allows you to easily build a vector index over any documents, with storage backed by a document store implementing theChatGPT endpoint.

Note: this index is a vector index, allowing top-k retrieval.

Example code:


```
from llama\_index.indices.vector\_store import ChatGPTRetrievalPluginIndexfrom llama\_index import SimpleDirectoryReaderimport os# load documentsdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()# build indexbearer\_token = os.getenv("BEARER\_TOKEN")# initialize without metadata filterindex = ChatGPTRetrievalPluginIndex(    documents,    endpoint\_url="http://localhost:8000",    bearer\_token=bearer\_token,)# query indexquery\_engine = vector\_index.as\_query\_engine(    similarity\_top\_k=3,    response\_mode="compact",)response = query\_engine.query("What did the author do growing up?")
```
For more details, check out the [full example notebook](https://github.com/jerryjliu/llama_index/blob/main/examples/chatgpt_plugin/ChatGPTRetrievalPluginIndexDemo.ipynb).

