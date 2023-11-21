Documents / Nodes[](#documents-nodes "Permalink to this heading")
==================================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Document and Node objects are core abstractions within LlamaIndex.

A **Document** is a generic container around any data source - for instance, a PDF, an API output, or retrieved data from a database. They can be constructed manually, or created automatically via our data loaders. By default, a Document stores text along with some other attributes. Some of these are listed below.

* `metadata` - a dictionary of annotations that can be appended to the text.
* `relationships` - a dictionary containing relationships to other Documents/Nodes.

*Note*: We have beta support for allowing Documents to store images, and are actively working on improving its multimodal capabilities.

A **Node** represents a “chunk” of a source Document, whether that is a text chunk, an image, or other. Similar to Documents, they contain metadata and relationship information with other nodes.

Nodes are a first-class citizen in LlamaIndex. You can choose to define Nodes and all its attributes directly. You may also choose to “parse” source Documents into Nodes through our `NodeParser` classes. By default every Node derived from a Document will inherit the same metadata from that Document (e.g. a “file\_name” filed in the Document is propagated to every Node).

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Here are some simple snippets to get started with Documents and Nodes.

### Documents[](#documents "Permalink to this heading")


```
from llama\_index import Document, VectorStoreIndextext\_list = [text1, text2, ...]documents = [Document(text=t) for t in text\_list]# build indexindex = VectorStoreIndex.from\_documents(documents)
```
### Nodes[](#nodes "Permalink to this heading")


```
from llama\_index.node\_parser import SimpleNodeParser# load documents...# parse nodesparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)# build indexindex = VectorStoreIndex(nodes)
```
