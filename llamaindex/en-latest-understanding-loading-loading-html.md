Loading[](#loading "Permalink to this heading")
================================================

Before your chosen LLM can act on your data you need to load it. The way LlamaIndex does this is via data connectors, also called `Reader`. Data connectors ingest data from different data sources and format the data into `Document` objects. A `Document` is a collection of data (currently text, and in future, images and audio) and metadata about that data.

Loading using SimpleDirectoryReader[](#loading-using-simpledirectoryreader "Permalink to this heading")
--------------------------------------------------------------------------------------------------------

The easiest reader to use is our SimpleDirectoryReader, which creates documents out of every file in a given directory. It is built in to LlamaIndex and can read a variety of formats including Markdown, PDFs, Word documents, PowerPoint decks, images, audio and video.


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data").load\_data()
```
Using Readers from LlamaHub[](#using-readers-from-llamahub "Permalink to this heading")
----------------------------------------------------------------------------------------

Because there are so many possible places to get data, they are not all built-in. Instead, you download them from our registry of data connectors, [LlamaHub](llamahub.html).

In this example LlamaIndex downloads and installs the connector called [DatabaseReader](https://llamahub.ai/l/database), which runs a query against a SQL database and returns every row of the results as a `Document`:


```
from llama\_index import download\_loaderDatabaseReader = download\_loader("DatabaseReader")reader = DatabaseReader(    scheme=os.getenv("DB\_SCHEME"),    host=os.getenv("DB\_HOST"),    port=os.getenv("DB\_PORT"),    user=os.getenv("DB\_USER"),    password=os.getenv("DB\_PASS"),    dbname=os.getenv("DB\_NAME"),)query = "SELECT \* FROM users"documents = reader.load\_data(query=query)
```
There are hundreds of connectors to use on [LlamaHub](https://llamahub.ai)!

Indexing Documents[](#indexing-documents "Permalink to this heading")
----------------------------------------------------------------------

Usually, at this point you are done loading and you can move on to indexing! Indexes have a `.from\_documents()` method which accepts an array of Document objects and will correctly parse and chunk them up. However, sometimes you will want greater control over how your documents are split up.

Parsing Documents into Nodes[](#parsing-documents-into-nodes "Permalink to this heading")
------------------------------------------------------------------------------------------

Under the hood, indexers split your Document into Node objects, which are similar to Documents (they contain text and metadata) but have a relationship to their parent Document.

The way in which your text is split up can have a large effect on the performance of your application in terms of accuracy and relevance of results returned. The defaults work well for simple text documents, so depending on what your data looks like you will sometimes want to modify the default ways in which your documents are split up.

In this example, you load your documents, then create a SimpleNodeParser configured with a custom `chunk\_size` and `chunk\_overlap` (1024 and 20 are the defaults). You then assign the node parser to a `ServiceContext` and then pass it to your indexer:


```
from llama\_index import SimpleDirectoryReader, VectorStoreIndex, ServiceContextfrom llama\_index.node\_parser import SimpleNodeParserdocuments = SimpleDirectoryReader("./data").load\_data()node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=512, chunk\_overlap=10)service\_context = ServiceContext.from\_defaults(node\_parser=node\_parser)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
Tip

Remember, a ServiceContext is a simple bundle of configuration data passed to many parts of LlamaIndex.

You can learn more about [customizing your node parsing](../../module_guides/loading/node_parsers/root.html)

Creating and passing Nodes directly[](#creating-and-passing-nodes-directly "Permalink to this heading")
--------------------------------------------------------------------------------------------------------

If you want to, you can create nodes directly and pass a list of Nodes directly to an indexer:


```
from llama\_index.schema import TextNodenode1 = TextNode(text="<text\_chunk>", id\_="<node\_id>")node2 = TextNode(text="<text\_chunk>", id\_="<node\_id>")index = VectorStoreIndex([node1, node2])
```
Customizing Documents[](#customizing-documents "Permalink to this heading")
----------------------------------------------------------------------------

When creating documents, you can also attach useful metadata that can be used at the querying stage. Any metadata added to a Document will be copied to the Nodes that get created from that document.


```
document = Document(    text="text",    metadata={"filename": "<doc\_file\_name>", "category": "<category>"},)
```
More about this can be found in [customizing Documents](../../module_guides/loading/documents_and_nodes/usage_documents.html).

