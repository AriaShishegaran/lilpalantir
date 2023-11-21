Node Parser[](#node-parser "Permalink to this heading")
========================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

Node parsers are a simple abstraction that take a list of documents, and chunk them into `Node` objects, such that each node is a specific size. When a document is broken into nodes, all of it’s attributes are inherited to the children nodes (i.e. `metadata`, text and metadata templates, etc.). You can read more about [`Node` and `Document` properties](../documents_and_nodes/root.html).

A node parser can configure the chunk size (in tokens) as well as any overlap between chunked nodes. The chunking is done by using a `TokenTextSplitter`, which default to a chunk size of 1024 and a default chunk overlap of 20 tokens.

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------


```
from llama\_index.node\_parser import SimpleNodeParsernode\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024, chunk\_overlap=20)
```
You can find more usage details and available customization options below.

Getting Started[](#getting-started "Permalink to this heading")
----------------------------------------------------------------

Node parsers can be used on their own:


```
from llama\_index import Documentfrom llama\_index.node\_parser import SimpleNodeParsernode\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024, chunk\_overlap=20)nodes = node\_parser.get\_nodes\_from\_documents(    [Document(text="long text")], show\_progress=False)
```
Or set inside a `ServiceContext` to be used automatically when an index is constructed using `.from\_documents()`:


```
from llama\_index import SimpleDirectoryReader, VectorStoreIndex, ServiceContextfrom llama\_index.node\_parser import SimpleNodeParserdocuments = SimpleDirectoryReader("./data").load\_data()node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024, chunk\_overlap=20)service\_context = ServiceContext.from\_defaults(node\_parser=node\_parser)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```
Customization[](#customization "Permalink to this heading")
------------------------------------------------------------

There are several options available to customize:

* `text\_splitter` (defaults to `TokenTextSplitter`) - the text splitter used to split text into chunks.
* `include\_metadata` (defaults to `True`) - whether or not `Node`s should inherit the document metadata.
* `include\_prev\_next\_rel` (defaults to `True`) - whether or not to include previous/next relationships between chunked `Node`s
* `metadata\_extractor` (defaults to `None`) - extra processing to extract helpful metadata. See [more about our metadata extractor](../documents_and_nodes/usage_metadata_extractor.html).

If you don’t want to change the `text\_splitter`, you can use `SimpleNodeParser.from\_defaults()` to easily change the chunk size and chunk overlap. The defaults are 1024 and 20 respectively.


```
from llama\_index.node\_parser import SimpleNodeParsernode\_parser = SimpleNodeParser.from\_defaults(chunk\_size=1024, chunk\_overlap=20)
```
### Text Splitter Customization[](#text-splitter-customization "Permalink to this heading")

If you do customize the `text\_splitter` from the default `SentenceSplitter`, you can use any splitter from langchain, or optionally our `TokenTextSplitter` or `CodeSplitter`. Each text splitter has options for the default separator, as well as options for additional config. These are useful for languages that are sufficiently different from English.

`SentenceSplitter` default configuration:


```
import tiktokenfrom llama\_index.text\_splitter import SentenceSplittertext\_splitter = SentenceSplitter(    separator=" ",    chunk\_size=1024,    chunk\_overlap=20,    paragraph\_separator="\n\n\n",    secondary\_chunking\_regex="[^,.;。]+[,.;。]?",    tokenizer=tiktoken.encoding\_for\_model("gpt-3.5-turbo").encode,)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)
```
`TokenTextSplitter` default configuration:


```
import tiktokenfrom llama\_index.text\_splitter import TokenTextSplittertext\_splitter = TokenTextSplitter(    separator=" ",    chunk\_size=1024,    chunk\_overlap=20,    backup\_separators=["\n"],    tokenizer=tiktoken.encoding\_for\_model("gpt-3.5-turbo").encode,)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)
```
`CodeSplitter` configuration:


```
from llama\_index.text\_splitter import CodeSplittertext\_splitter = CodeSplitter(    language="python",    chunk\_lines=40,    chunk\_lines\_overlap=15,    max\_chars=1500,)node\_parser = SimpleNodeParser.from\_defaults(text\_splitter=text\_splitter)
```
SentenceWindowNodeParser[](#sentencewindownodeparser "Permalink to this heading")
----------------------------------------------------------------------------------

The `SentenceWindowNodeParser` is similar to the `SimpleNodeParser`, except that it splits all documents into individual sentences. The resulting nodes also contain the surrounding “window” of sentences around each node in the metadata. Note that this metadata will not be visible to the LLM or embedding model.

This is most useful for generating embeddings that have a very specific scope. Then, combined with a `MetadataReplacementNodePostProcessor`, you can replace the sentence with it’s surrounding context before sending the node to the LLM.

An example of setting up the parser with default settings is below. In practice, you would usually only want to adjust the window size of sentences.


```
import nltkfrom llama\_index.node\_parser import SentenceWindowNodeParsernode\_parser = SentenceWindowNodeParser.from\_defaults(    # how many sentences on either side to capture    window\_size=3,    # the metadata key that holds the window of surrounding sentences    window\_metadata\_key="window",    # the metadata key that holds the original sentence    original\_text\_metadata\_key="original\_sentence",)
```
A full example can be found [here in combination with the `MetadataReplacementNodePostProcessor`](../../../examples/node_postprocessor/MetadataReplacementDemo.html).

