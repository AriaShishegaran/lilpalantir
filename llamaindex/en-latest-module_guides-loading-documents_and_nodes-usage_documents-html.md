Defining and Customizing Documents[](#defining-and-customizing-documents "Permalink to this heading")
======================================================================================================

Defining Documents[](#defining-documents "Permalink to this heading")
----------------------------------------------------------------------

Documents can either be created automatically via data loaders, or constructed manually.

By default, all of our [data loaders](../connector/root.html) (including those offered on LlamaHub) return `Document` objects through the `load\_data` function.


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data").load\_data()
```
You can also choose to construct documents manually. LlamaIndex exposes the `Document` struct.


```
from llama\_index import Documenttext\_list = [text1, text2, ...]documents = [Document(text=t) for t in text\_list]
```
To speed up prototyping and development, you can also quickly create a document using some default text:


```
document = Document.example()
```
Customizing Documents[](#customizing-documents "Permalink to this heading")
----------------------------------------------------------------------------

This section covers various ways to customize `Document` objects. Since the `Document` object is a subclass of our `TextNode` object, all these settings and details apply to the `TextNode` object class as well.

### Metadata[](#metadata "Permalink to this heading")

Documents also offer the chance to include useful metadata. Using the `metadata` dictionary on each document, additional information can be included to help inform responses and track down sources for query responses. This information can be anything, such as filenames or categories. If you are integrating with a vector database, keep in mind that some vector databases require that the keys must be strings, and the values must be flat (either `str`, `float`, or `int`).

Any information set in the `metadata` dictionary of each document will show up in the `metadata` of each source node created from the document. Additionally, this information is included in the nodes, enabling the index to utilize it on queries and responses. By default, the metadata is injected into the text for both embedding and LLM model calls.

There are a few ways to set up this dictionary:

1. In the document constructor:


```
document = Document(    text="text",    metadata={"filename": "<doc\_file\_name>", "category": "<category>"},)
```
2. After the document is created:


```
document.metadata = {"filename": "<doc\_file\_name>"}
```
3. Set the filename automatically using the `SimpleDirectoryReader` and `file\_metadata` hook. This will automatically run the hook on each document to set the `metadata` field:


```
from llama\_index import SimpleDirectoryReaderfilename\_fn = lambda filename: {"file\_name": filename}# automatically sets the metadata of each document according to filename\_fndocuments = SimpleDirectoryReader(    "./data", file\_metadata=filename\_fn).load\_data()
```
### Customizing the id[](#customizing-the-id "Permalink to this heading")

As detailed in the section [Document Management](../../indexing/document_management.html), the `doc\_id` is used to enable efficient refreshing of documents in the index. When using the `SimpleDirectoryReader`, you can automatically set the doc `doc\_id` to be the full path to each document:


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data", filename\_as\_id=True).load\_data()print([x.doc\_id for x in documents])
```
You can also set the `doc\_id` of any `Document` directly!


```
document.doc\_id = "My new document id!"
```
Note: the ID can also be set through the `node\_id` or `id\_` property on a Document object, similar to a `TextNode` object.

### Advanced - Metadata Customization[](#advanced-metadata-customization "Permalink to this heading")

A key detail mentioned above is that by default, any metadata you set is included in the embeddings generation and LLM.

#### Customizing LLM Metadata Text[](#customizing-llm-metadata-text "Permalink to this heading")

Typically, a document might have many metadata keys, but you might not want all of them visible to the LLM during response synthesis. In the above examples, we may not want the LLM to read the `file\_name` of our document. However, the `file\_name` might include information that will help generate better embeddings. A key advantage of doing this is to bias the embeddings for retrieval without changing what the LLM ends up reading.

We can exclude it like so:


```
document.excluded\_llm\_metadata\_keys = ["file\_name"]
```
Then, we can test what the LLM will actually end up reading using the `get\_content()` function and specifying `MetadataMode.LLM`:


```
from llama\_index.schema import MetadataModeprint(document.get\_content(metadata\_mode=MetadataMode.LLM))
```
#### Customizing Embedding Metadata Text[](#customizing-embedding-metadata-text "Permalink to this heading")

Similar to customing the metadata visible to the LLM, we can also customize the metadata visible to embeddings. In this case, you can specifically exclude metadata visible to the embedding model, in case you DON’T want particular text to bias the embeddings.


```
document.excluded\_embed\_metadata\_keys = ["file\_name"]
```
Then, we can test what the embedding model will actually end up reading using the `get\_content()` function and specifying `MetadataMode.EMBED`:


```
from llama\_index.schema import MetadataModeprint(document.get\_content(metadata\_mode=MetadataMode.EMBED))
```
#### Customizing Metadata Format[](#customizing-metadata-format "Permalink to this heading")

As you know by now, metadata is injected into the actual text of each document/node when sent to the LLM or embedding model. By default, the format of this metadata is controlled by three attributes:

1. `Document.metadata\_seperator` -> default = `"\n"`

When concatenating all key/value fields of your metadata, this field controls the separator between each key/value pair.

2. `Document.metadata\_template` -> default = `"{key}: {value}"`

This attribute controls how each key/value pair in your metadata is formatted. The two variables `key` and `value` string keys are required.

3. `Document.text\_template` -> default = `{metadata\_str}\n\n{content}`

Once your metadata is converted into a string using `metadata\_seperator` and `metadata\_template`, this templates controls what that metadata looks like when joined with the text content of your document/node. The `metadata` and `content` string keys are required.

### Summary[](#summary "Permalink to this heading")

Knowing all this, let’s create a short example using all this power:


```
from llama\_index import Documentfrom llama\_index.schema import MetadataModedocument = Document(    text="This is a super-customized document",    metadata={        "file\_name": "super\_secret\_document.txt",        "category": "finance",        "author": "LlamaIndex",    },    excluded\_llm\_metadata\_keys=["file\_name"],    metadata\_seperator="::",    metadata\_template="{key}=>{value}",    text\_template="Metadata: {metadata\_str}\n-----\nContent: {content}",)print(    "The LLM sees this: \n",    document.get\_content(metadata\_mode=MetadataMode.LLM),)print(    "The Embedding model sees this: \n",    document.get\_content(metadata\_mode=MetadataMode.EMBED),)
```
### Advanced - Automatic Metadata Extraction[](#advanced-automatic-metadata-extraction "Permalink to this heading")

We have initial examples of using LLMs themselves to perform metadata extraction.

Take a look here!

* [Extracting Metadata for Better Document Indexing and Understanding](../../../examples/metadata_extraction/MetadataExtractionSEC.html)
