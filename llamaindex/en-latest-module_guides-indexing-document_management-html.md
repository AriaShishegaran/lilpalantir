Document Management[](#document-management "Permalink to this heading")
========================================================================

Most LlamaIndex index structures allow for **insertion**, **deletion**, **update**, and **refresh** operations.

Insertion[](#insertion "Permalink to this heading")
----------------------------------------------------

You can “insert” a new Document into any index data structure, after building the index initially. This document will be broken down into nodes and ingested into the index.

The underlying mechanism behind insertion depends on the index structure. For instance, for the summary index, a new Document is inserted as additional node(s) in the list.For the vector store index, a new Document (and embeddings) is inserted into the underlying document/embedding store.

An example notebook showcasing our insert capabilities is given [here](https://github.com/jerryjliu/llama_index/blob/main/examples/paul_graham_essay/InsertDemo.ipynb).In this notebook we showcase how to construct an empty index, manually create Document objects, and add those to our index data structures.

An example code snippet is given below:


```
from llama\_index import SummaryIndex, Documentindex = SummaryIndex([])text\_chunks = ["text\_chunk\_1", "text\_chunk\_2", "text\_chunk\_3"]doc\_chunks = []for i, text in enumerate(text\_chunks):    doc = Document(text=text, id\_=f"doc\_id\_{i}")    doc\_chunks.append(doc)# insertfor doc\_chunk in doc\_chunks:    index.insert(doc\_chunk)
```
Deletion[](#deletion "Permalink to this heading")
--------------------------------------------------

You can “delete” a Document from most index data structures by specifying a document\_id. (**NOTE**: the tree index currently does not support deletion). All nodes corresponding to the document will be deleted.


```
index.delete\_ref\_doc("doc\_id\_0", delete\_from\_docstore=True)
```
`delete\_from\_docstore` will default to `False` in case you are sharing nodes between indexes using the same docstore. However, these nodes will not be used when querying when this is set to `False` as they will be deleted from the `index\_struct` of the index, which keeps track of which nodes can be used for querying.

Update[](#update "Permalink to this heading")
----------------------------------------------

If a Document is already present within an index, you can “update” a Document with the same doc `id\_` (for instance, if the information in the Document has changed).


```
# NOTE: the document has a `doc\_id` specifieddoc\_chunks[0].text = "Brand new document text"index.update\_ref\_doc(    doc\_chunks[0],    update\_kwargs={"delete\_kwargs": {"delete\_from\_docstore": True}},)
```
Here, we passed some extra kwargs to ensure the document is deleted from the docstore. This is of course optional.

Refresh[](#refresh "Permalink to this heading")
------------------------------------------------

If you set the doc `id\_` of each document when loading your data, you can also automatically refresh the index.

The `refresh()` function will only update documents who have the same doc `id\_`, but different text contents. Any documents not present in the index at all will also be inserted.

`refresh()` also returns a boolean list, indicating which documents in the input have been refreshed in the index.


```
# modify first document, with the same doc\_iddoc\_chunks[0] = Document(text="Super new document text", id\_="doc\_id\_0")# add a new documentdoc\_chunks.append(    Document(        text="This isn't in the index yet, but it will be soon!",        id\_="doc\_id\_3",    ))# refresh the indexrefreshed\_docs = index.refresh\_ref\_docs(    doc\_chunks, update\_kwargs={"delete\_kwargs": {"delete\_from\_docstore": True}})# refreshed\_docs[0] and refreshed\_docs[-1] should be true
```
Again, we passed some extra kwargs to ensure the document is deleted from the docstore. This is of course optional.

If you `print()` the output of `refresh()`, you would see which input documents were refreshed:


```
print(refreshed\_docs)# > [True, False, False, True]
```
This is most useful when you are reading from a directory that is constantly updating with new information.

To automatically set the doc `id\_` when using the `SimpleDirectoryReader`, you can set the `filename\_as\_id` flag. You can learn more about [customzing Documents](../loading/documents_and_nodes/usage_documents.html).

Document Tracking[](#document-tracking "Permalink to this heading")
--------------------------------------------------------------------

Any index that uses the docstore (i.e. all indexes except for most vector store integrations), you can also see which documents you have inserted into the docstore.


```
print(index.ref\_doc\_info)"""> {'doc\_id\_1': RefDocInfo(node\_ids=['071a66a8-3c47-49ad-84fa-7010c6277479'], metadata={}), 'doc\_id\_2': RefDocInfo(node\_ids=['9563e84b-f934-41c3-acfd-22e88492c869'], metadata={}), 'doc\_id\_0': RefDocInfo(node\_ids=['b53e6c2f-16f7-4024-af4c-42890e945f36'], metadata={}), 'doc\_id\_3': RefDocInfo(node\_ids=['6bedb29f-15db-4c7c-9885-7490e10aa33f'], metadata={})}"""
```
Each entry in the output shows the ingested doc `id\_`s as keys, and their associated `node\_ids` of the nodes they were split into.

Lastly, the original `metadata` dictionary of each input document is also tracked. You can read more about the `metadata` attribute in [Customizing Documents](../loading/documents_and_nodes/usage_documents.html).

