Defining and Customizing Nodes[](#defining-and-customizing-nodes "Permalink to this heading")
==============================================================================================

Nodes represent “chunks” of source Documents, whether that is a text chunk, an image, or more. They also contain metadata and relationship informationwith other nodes and index structures.

Nodes are a first-class citizen in LlamaIndex. You can choose to define Nodes and all its attributes directly. You may also choose to “parse” source Documents into Nodes through our `NodeParser` classes.

For instance, you can do


```
from llama\_index.node\_parser import SimpleNodeParserparser = SimpleNodeParser.from\_defaults()nodes = parser.get\_nodes\_from\_documents(documents)
```
You can also choose to construct Node objects manually and skip the first section. For instance,


```
from llama\_index.schema import TextNode, NodeRelationship, RelatedNodeInfonode1 = TextNode(text="<text\_chunk>", id\_="<node\_id>")node2 = TextNode(text="<text\_chunk>", id\_="<node\_id>")# set relationshipsnode1.relationships[NodeRelationship.NEXT] = RelatedNodeInfo(    node\_id=node2.node\_id)node2.relationships[NodeRelationship.PREVIOUS] = RelatedNodeInfo(    node\_id=node1.node\_id)nodes = [node1, node2]
```
The `RelatedNodeInfo` class can also store additional `metadata` if needed:


```
node2.relationships[NodeRelationship.PARENT] = RelatedNodeInfo(    node\_id=node1.node\_id, metadata={"key": "val"})
```
Customizing the ID[](#customizing-the-id "Permalink to this heading")
----------------------------------------------------------------------

Each node has an `node\_id` property that is automatically generated if not manually specified. This ID can be used fora variety of purposes; this includes being able to update nodes in storage, being able to define relationshipsbetween nodes (through `IndexNode`), and more.

You can also get and set the `node\_id` of any `TextNode` directly.


```
print(node.node\_id)node.node\_id = "My new node\_id!"
```
