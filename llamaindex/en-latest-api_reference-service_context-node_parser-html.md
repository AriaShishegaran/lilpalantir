Node Parser[](#module-llama_index.node_parser "Permalink to this heading")
===========================================================================

Node parsers.

*pydantic model* llama\_index.node\_parser.HierarchicalNodeParser[](#llama_index.node_parser.HierarchicalNodeParser "Permalink to this definition")Hierarchical node parser.

Splits a document into a recursive hierarchy Nodes using a TextSplitter.

NOTE: this will return a hierarchy of nodes in a flat list, where there will beoverlap between parent nodes (e.g. with a bigger chunk size), and child nodesper parent (e.g. with a smaller chunk size).

For instance, this may return a list of nodes like:- list of top-level nodes with chunk size 2048- list of second-level nodes, where each node is a child of a top-level node,


> chunk size 512
> 
> 

* list of third-level nodes, where each node is a child of a second-level node,chunk size 128

Parameters* **text\_splitter** (*Optional**[**TextSplitter**]*) – text splitter
* **include\_metadata** (*bool*) – whether to include metadata in nodes
* **include\_prev\_next\_rel** (*bool*) – whether to include prev/next relationships
Show JSON schema
```
{ "title": "HierarchicalNodeParser", "description": "Hierarchical node parser.\n\nSplits a document into a recursive hierarchy Nodes using a TextSplitter.\n\nNOTE: this will return a hierarchy of nodes in a flat list, where there will be\noverlap between parent nodes (e.g. with a bigger chunk size), and child nodes\nper parent (e.g. with a smaller chunk size).\n\nFor instance, this may return a list of nodes like:\n- list of top-level nodes with chunk size 2048\n- list of second-level nodes, where each node is a child of a top-level node,\n chunk size 512\n- list of third-level nodes, where each node is a child of a second-level node,\n chunk size 128\n\nArgs:\n text\_splitter (Optional[TextSplitter]): text splitter\n include\_metadata (bool): whether to include metadata in nodes\n include\_prev\_next\_rel (bool): whether to include prev/next relationships", "type": "object", "properties": { "chunk\_sizes": { "title": "Chunk Sizes", "description": "The chunk sizes to use when splitting documents, in order of level.", "type": "array", "items": { "type": "integer" } }, "text\_splitter\_ids": { "title": "Text Splitter Ids", "description": "List of ids for the text splitters to use when splitting documents, in order of level (first id used for first level, etc.).", "type": "array", "items": { "type": "string" } }, "text\_splitter\_map": { "title": "Text Splitter Map", "description": "Map of text splitter id to text splitter.", "type": "object", "additionalProperties": { "$ref": "#/definitions/TextSplitter" } }, "include\_metadata": { "title": "Include Metadata", "description": "Whether or not to consider metadata when splitting.", "default": true, "type": "boolean" }, "include\_prev\_next\_rel": { "title": "Include Prev Next Rel", "description": "Include prev/next node relationships.", "default": true, "type": "boolean" }, "metadata\_extractor": { "title": "Metadata Extractor", "description": "Metadata extraction pipeline to apply to nodes.", "allOf": [ { "$ref": "#/definitions/MetadataExtractor" } ] }, "callback\_manager": { "title": "Callback Manager" } }, "required": [ "text\_splitter\_map" ], "definitions": { "TextSplitter": { "title": "TextSplitter", "description": "Helper class that provides a standard way to create an ABC using\ninheritance.", "type": "object", "properties": {} }, "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "MetadataFeatureExtractor": { "title": "MetadataFeatureExtractor", "description": "Base interface for feature extractor.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] } } }, "MetadataExtractor": { "title": "MetadataExtractor", "description": "Metadata extractor.", "type": "object", "properties": { "extractors": { "title": "Extractors", "description": "Metadta feature extractors to apply to each node.", "type": "array", "items": { "$ref": "#/definitions/MetadataFeatureExtractor" } }, "node\_text\_template": { "title": "Node Text Template", "description": "Template to represent how node text is mixed with metadata text.", "default": "[Excerpt from document]\n{metadata\_str}\nExcerpt:\n-----\n{content}\n-----\n", "type": "string" }, "disable\_template\_rewrite": { "title": "Disable Template Rewrite", "description": "Disable the node template rewrite.", "default": false, "type": "boolean" }, "in\_place": { "title": "In Place", "description": "Whether to process nodes in place.", "default": true, "type": "boolean" } } } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `chunk\_sizes (Optional[List[int]])`
* `include\_metadata (bool)`
* `include\_prev\_next\_rel (bool)`
* `metadata\_extractor (Optional[llama\_index.node\_parser.extractors.metadata\_extractors.MetadataExtractor])`
* `text\_splitter\_ids (List[str])`
* `text\_splitter\_map (Dict[str, llama\_index.text\_splitter.types.TextSplitter])`
*field* callback\_manager*: [CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")* *[Optional]*[](#llama_index.node_parser.HierarchicalNodeParser.callback_manager "Permalink to this definition")*field* chunk\_sizes*: Optional[List[int]]* *= None*[](#llama_index.node_parser.HierarchicalNodeParser.chunk_sizes "Permalink to this definition")The chunk sizes to use when splitting documents, in order of level.

*field* include\_metadata*: bool* *= True*[](#llama_index.node_parser.HierarchicalNodeParser.include_metadata "Permalink to this definition")Whether or not to consider metadata when splitting.

*field* include\_prev\_next\_rel*: bool* *= True*[](#llama_index.node_parser.HierarchicalNodeParser.include_prev_next_rel "Permalink to this definition")Include prev/next node relationships.

*field* metadata\_extractor*: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")]* *= None*[](#llama_index.node_parser.HierarchicalNodeParser.metadata_extractor "Permalink to this definition")Metadata extraction pipeline to apply to nodes.

*field* text\_splitter\_ids*: List[str]* *[Optional]*[](#llama_index.node_parser.HierarchicalNodeParser.text_splitter_ids "Permalink to this definition")List of ids for the text splitters to use when splitting documents, in order of level (first id used for first level, etc.).

*field* text\_splitter\_map*: Dict[str, TextSplitter]* *[Required]*[](#llama_index.node_parser.HierarchicalNodeParser.text_splitter_map "Permalink to this definition")Map of text splitter id to text splitter.

*classmethod* class\_name() → str[](#llama_index.node_parser.HierarchicalNodeParser.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.node_parser.HierarchicalNodeParser.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_defaults(*chunk\_sizes: Optional[List[int]] = None*, *text\_splitter\_ids: Optional[List[str]] = None*, *text\_splitter\_map: Optional[Dict[str, TextSplitter]] = None*, *include\_metadata: bool = True*, *include\_prev\_next\_rel: bool = True*, *callback\_manager: Optional[[CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *metadata\_extractor: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")] = None*) → [HierarchicalNodeParser](#llama_index.node_parser.HierarchicalNodeParser "llama_index.node_parser.hierarchical.HierarchicalNodeParser")[](#llama_index.node_parser.HierarchicalNodeParser.from_defaults "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.HierarchicalNodeParser.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.HierarchicalNodeParser.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.from_orm "Permalink to this definition")get\_nodes\_from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *show\_progress: bool = False*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.HierarchicalNodeParser.get_nodes_from_documents "Permalink to this definition")Parse document into nodes.

Parameters* **documents** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – documents to parse
* **include\_metadata** (*bool*) – whether to include metadata in nodes
json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.HierarchicalNodeParser.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.node_parser.HierarchicalNodeParser.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.HierarchicalNodeParser.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.node_parser.HierarchicalNodeParser.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.node_parser.HierarchicalNodeParser.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.node_parser.HierarchicalNodeParser.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.node_parser.HierarchicalNodeParser.validate "Permalink to this definition")*pydantic model* llama\_index.node\_parser.NodeParser[](#llama_index.node_parser.NodeParser "Permalink to this definition")Base interface for node parser.

Show JSON schema
```
{ "title": "NodeParser", "description": "Base interface for node parser.", "type": "object", "properties": {}}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
*abstract classmethod* class\_name() → str[](#llama_index.node_parser.NodeParser.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.node_parser.NodeParser.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.node_parser.NodeParser.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.node_parser.NodeParser.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.NodeParser.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.NodeParser.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.node_parser.NodeParser.from_orm "Permalink to this definition")*abstract* get\_nodes\_from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *show\_progress: bool = False*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.NodeParser.get_nodes_from_documents "Permalink to this definition")Parse documents into nodes.

Parameters**documents** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – documents to parse

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.NodeParser.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.NodeParser.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.node_parser.NodeParser.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.NodeParser.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.node_parser.NodeParser.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.NodeParser.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.node_parser.NodeParser.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.node_parser.NodeParser.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.node_parser.NodeParser.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.node_parser.NodeParser.validate "Permalink to this definition")*pydantic model* llama\_index.node\_parser.SentenceWindowNodeParser[](#llama_index.node_parser.SentenceWindowNodeParser "Permalink to this definition")Sentence window node parser.

Splits a document into Nodes, with each node being a sentence.Each node contains a window from the surrounding sentences in the metadata.

Parameters* **sentence\_splitter** (*Optional**[**Callable**]*) – splits text into sentences
* **include\_metadata** (*bool*) – whether to include metadata in nodes
* **include\_prev\_next\_rel** (*bool*) – whether to include prev/next relationships
Show JSON schema
```
{ "title": "SentenceWindowNodeParser", "description": "Sentence window node parser.\n\nSplits a document into Nodes, with each node being a sentence.\nEach node contains a window from the surrounding sentences in the metadata.\n\nArgs:\n sentence\_splitter (Optional[Callable]): splits text into sentences\n include\_metadata (bool): whether to include metadata in nodes\n include\_prev\_next\_rel (bool): whether to include prev/next relationships", "type": "object", "properties": { "window\_size": { "title": "Window Size", "description": "The number of sentences on each side of a sentence to capture.", "default": 3, "type": "integer" }, "window\_metadata\_key": { "title": "Window Metadata Key", "description": "The metadata key to store the sentence window under.", "default": "window", "type": "string" }, "original\_text\_metadata\_key": { "title": "Original Text Metadata Key", "description": "The metadata key to store the original sentence in.", "default": "original\_text", "type": "string" }, "include\_metadata": { "title": "Include Metadata", "description": "Whether or not to consider metadata when splitting.", "default": true, "type": "boolean" }, "include\_prev\_next\_rel": { "title": "Include Prev Next Rel", "description": "Include prev/next node relationships.", "default": true, "type": "boolean" }, "metadata\_extractor": { "title": "Metadata Extractor", "description": "Metadata extraction pipeline to apply to nodes.", "allOf": [ { "$ref": "#/definitions/MetadataExtractor" } ] }, "callback\_manager": { "title": "Callback Manager" } }, "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "MetadataFeatureExtractor": { "title": "MetadataFeatureExtractor", "description": "Base interface for feature extractor.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] } } }, "MetadataExtractor": { "title": "MetadataExtractor", "description": "Metadata extractor.", "type": "object", "properties": { "extractors": { "title": "Extractors", "description": "Metadta feature extractors to apply to each node.", "type": "array", "items": { "$ref": "#/definitions/MetadataFeatureExtractor" } }, "node\_text\_template": { "title": "Node Text Template", "description": "Template to represent how node text is mixed with metadata text.", "default": "[Excerpt from document]\n{metadata\_str}\nExcerpt:\n-----\n{content}\n-----\n", "type": "string" }, "disable\_template\_rewrite": { "title": "Disable Template Rewrite", "description": "Disable the node template rewrite.", "default": false, "type": "boolean" }, "in\_place": { "title": "In Place", "description": "Whether to process nodes in place.", "default": true, "type": "boolean" } } } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `include\_metadata (bool)`
* `include\_prev\_next\_rel (bool)`
* `metadata\_extractor (Optional[llama\_index.node\_parser.extractors.metadata\_extractors.MetadataExtractor])`
* `original\_text\_metadata\_key (str)`
* `sentence\_splitter (Callable[[str], List[str]])`
* `window\_metadata\_key (str)`
* `window\_size (int)`
*field* callback\_manager*: [CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")* *[Optional]*[](#llama_index.node_parser.SentenceWindowNodeParser.callback_manager "Permalink to this definition")*field* include\_metadata*: bool* *= True*[](#llama_index.node_parser.SentenceWindowNodeParser.include_metadata "Permalink to this definition")Whether or not to consider metadata when splitting.

*field* include\_prev\_next\_rel*: bool* *= True*[](#llama_index.node_parser.SentenceWindowNodeParser.include_prev_next_rel "Permalink to this definition")Include prev/next node relationships.

*field* metadata\_extractor*: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")]* *= None*[](#llama_index.node_parser.SentenceWindowNodeParser.metadata_extractor "Permalink to this definition")Metadata extraction pipeline to apply to nodes.

*field* original\_text\_metadata\_key*: str* *= 'original\_text'*[](#llama_index.node_parser.SentenceWindowNodeParser.original_text_metadata_key "Permalink to this definition")The metadata key to store the original sentence in.

*field* sentence\_splitter*: Callable[[str], List[str]]* *[Optional]*[](#llama_index.node_parser.SentenceWindowNodeParser.sentence_splitter "Permalink to this definition")The text splitter to use when splitting documents.

*field* window\_metadata\_key*: str* *= 'window'*[](#llama_index.node_parser.SentenceWindowNodeParser.window_metadata_key "Permalink to this definition")The metadata key to store the sentence window under.

*field* window\_size*: int* *= 3*[](#llama_index.node_parser.SentenceWindowNodeParser.window_size "Permalink to this definition")The number of sentences on each side of a sentence to capture.

build\_window\_nodes\_from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.SentenceWindowNodeParser.build_window_nodes_from_documents "Permalink to this definition")Build window nodes from documents.

*classmethod* class\_name() → str[](#llama_index.node_parser.SentenceWindowNodeParser.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.node_parser.SentenceWindowNodeParser.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_defaults(*sentence\_splitter: Optional[Callable[[str], List[str]]] = None*, *window\_size: int = 3*, *window\_metadata\_key: str = 'window'*, *original\_text\_metadata\_key: str = 'original\_text'*, *include\_metadata: bool = True*, *include\_prev\_next\_rel: bool = True*, *callback\_manager: Optional[[CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *metadata\_extractor: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")] = None*) → [SentenceWindowNodeParser](#llama_index.node_parser.SentenceWindowNodeParser "llama_index.node_parser.sentence_window.SentenceWindowNodeParser")[](#llama_index.node_parser.SentenceWindowNodeParser.from_defaults "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.SentenceWindowNodeParser.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.SentenceWindowNodeParser.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.from_orm "Permalink to this definition")get\_nodes\_from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *show\_progress: bool = False*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.SentenceWindowNodeParser.get_nodes_from_documents "Permalink to this definition")Parse document into nodes.

Parameters* **documents** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – documents to parse
* **include\_metadata** (*bool*) – whether to include metadata in nodes
json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.SentenceWindowNodeParser.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.node_parser.SentenceWindowNodeParser.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.SentenceWindowNodeParser.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.node_parser.SentenceWindowNodeParser.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.node_parser.SentenceWindowNodeParser.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.node_parser.SentenceWindowNodeParser.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.node_parser.SentenceWindowNodeParser.validate "Permalink to this definition")*property* text\_splitter*: Callable[[str], List[str]]*[](#llama_index.node_parser.SentenceWindowNodeParser.text_splitter "Permalink to this definition")Get text splitter.

*pydantic model* llama\_index.node\_parser.SimpleNodeParser[](#llama_index.node_parser.SimpleNodeParser "Permalink to this definition")Simple node parser.

Splits a document into Nodes using a TextSplitter.

Parameters* **text\_splitter** (*Optional**[**TextSplitter**]*) – text splitter
* **include\_metadata** (*bool*) – whether to include metadata in nodes
* **include\_prev\_next\_rel** (*bool*) – whether to include prev/next relationships
Show JSON schema
```
{ "title": "SimpleNodeParser", "description": "Simple node parser.\n\nSplits a document into Nodes using a TextSplitter.\n\nArgs:\n text\_splitter (Optional[TextSplitter]): text splitter\n include\_metadata (bool): whether to include metadata in nodes\n include\_prev\_next\_rel (bool): whether to include prev/next relationships", "type": "object", "properties": { "text\_splitter": { "title": "Text Splitter" }, "include\_metadata": { "title": "Include Metadata", "description": "Whether or not to consider metadata when splitting.", "default": true, "type": "boolean" }, "include\_prev\_next\_rel": { "title": "Include Prev Next Rel", "description": "Include prev/next node relationships.", "default": true, "type": "boolean" }, "metadata\_extractor": { "title": "Metadata Extractor", "description": "Metadata extraction pipeline to apply to nodes.", "allOf": [ { "$ref": "#/definitions/MetadataExtractor" } ] }, "callback\_manager": { "title": "Callback Manager" } }, "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "MetadataFeatureExtractor": { "title": "MetadataFeatureExtractor", "description": "Base interface for feature extractor.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] } } }, "MetadataExtractor": { "title": "MetadataExtractor", "description": "Metadata extractor.", "type": "object", "properties": { "extractors": { "title": "Extractors", "description": "Metadta feature extractors to apply to each node.", "type": "array", "items": { "$ref": "#/definitions/MetadataFeatureExtractor" } }, "node\_text\_template": { "title": "Node Text Template", "description": "Template to represent how node text is mixed with metadata text.", "default": "[Excerpt from document]\n{metadata\_str}\nExcerpt:\n-----\n{content}\n-----\n", "type": "string" }, "disable\_template\_rewrite": { "title": "Disable Template Rewrite", "description": "Disable the node template rewrite.", "default": false, "type": "boolean" }, "in\_place": { "title": "In Place", "description": "Whether to process nodes in place.", "default": true, "type": "boolean" } } } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `include\_metadata (bool)`
* `include\_prev\_next\_rel (bool)`
* `metadata\_extractor (Optional[llama\_index.node\_parser.extractors.metadata\_extractors.MetadataExtractor])`
* `text\_splitter (Union[llama\_index.text\_splitter.types.TextSplitter, langchain.text\_splitter.TextSplitter])`
*field* callback\_manager*: [CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")* *[Optional]*[](#llama_index.node_parser.SimpleNodeParser.callback_manager "Permalink to this definition")*field* include\_metadata*: bool* *= True*[](#llama_index.node_parser.SimpleNodeParser.include_metadata "Permalink to this definition")Whether or not to consider metadata when splitting.

*field* include\_prev\_next\_rel*: bool* *= True*[](#llama_index.node_parser.SimpleNodeParser.include_prev_next_rel "Permalink to this definition")Include prev/next node relationships.

*field* metadata\_extractor*: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")]* *= None*[](#llama_index.node_parser.SimpleNodeParser.metadata_extractor "Permalink to this definition")Metadata extraction pipeline to apply to nodes.

*field* text\_splitter*: Union[TextSplitter, TextSplitter]* *[Required]*[](#llama_index.node_parser.SimpleNodeParser.text_splitter "Permalink to this definition")The text splitter to use when splitting documents.

*classmethod* class\_name() → str[](#llama_index.node_parser.SimpleNodeParser.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.node_parser.SimpleNodeParser.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.node_parser.SimpleNodeParser.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.node_parser.SimpleNodeParser.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_defaults(*chunk\_size: Optional[int] = None*, *chunk\_overlap: Optional[int] = None*, *text\_splitter: Optional[Union[TextSplitter, TextSplitter]] = None*, *include\_metadata: bool = True*, *include\_prev\_next\_rel: bool = True*, *callback\_manager: Optional[[CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *metadata\_extractor: Optional[[MetadataExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor")] = None*) → [SimpleNodeParser](#llama_index.node_parser.SimpleNodeParser "llama_index.node_parser.simple.SimpleNodeParser")[](#llama_index.node_parser.SimpleNodeParser.from_defaults "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.SimpleNodeParser.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.SimpleNodeParser.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.node_parser.SimpleNodeParser.from_orm "Permalink to this definition")get\_nodes\_from\_documents(*documents: Sequence[[Document](../node.html#llama_index.schema.Document "llama_index.schema.Document")]*, *show\_progress: bool = False*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.SimpleNodeParser.get_nodes_from_documents "Permalink to this definition")Parse document into nodes.

Parameters* **documents** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – documents to parse
* **include\_metadata** (*bool*) – whether to include metadata in nodes
json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.SimpleNodeParser.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.SimpleNodeParser.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.node_parser.SimpleNodeParser.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.SimpleNodeParser.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.node_parser.SimpleNodeParser.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.SimpleNodeParser.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.node_parser.SimpleNodeParser.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.node_parser.SimpleNodeParser.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.node_parser.SimpleNodeParser.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.node_parser.SimpleNodeParser.validate "Permalink to this definition")*pydantic model* llama\_index.node\_parser.UnstructuredElementNodeParser[](#llama_index.node_parser.UnstructuredElementNodeParser "Permalink to this definition")Unstructured element node parser.

Splits a document into Text Nodes and Index Nodes corresponding to embedded objects(e.g. tables).

Show JSON schema
```
{ "title": "UnstructuredElementNodeParser", "description": "Unstructured element node parser.\n\nSplits a document into Text Nodes and Index Nodes corresponding to embedded objects\n(e.g. tables).", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "llm": { "title": "Llm" }, "summary\_query\_str": { "title": "Summary Query Str", "description": "Query string to use for summarization.", "default": "What is this table about? Give a very concise summary (imagine you are adding a caption), and also output whether or not the table should be kept.", "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `callback\_manager (llama\_index.callbacks.base.CallbackManager)`
* `llm (Optional[llama\_index.llms.base.LLM])`
* `summary\_query\_str (str)`
*field* callback\_manager*: [CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")* *[Optional]*[](#llama_index.node_parser.UnstructuredElementNodeParser.callback_manager "Permalink to this definition")*field* llm*: Optional[[LLM](../llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")]* *= None*[](#llama_index.node_parser.UnstructuredElementNodeParser.llm "Permalink to this definition")LLM model to use for summarization.

*field* summary\_query\_str*: str* *= 'What is this table about? Give a very concise summary (imagine you are adding a caption), and also output whether or not the table should be kept.'*[](#llama_index.node_parser.UnstructuredElementNodeParser.summary_query_str "Permalink to this definition")Query string to use for summarization.

*classmethod* class\_name() → str[](#llama_index.node_parser.UnstructuredElementNodeParser.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.node_parser.UnstructuredElementNodeParser.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_defaults(*callback\_manager: Optional[[CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*) → [UnstructuredElementNodeParser](#llama_index.node_parser.UnstructuredElementNodeParser "llama_index.node_parser.unstructured_element.UnstructuredElementNodeParser")[](#llama_index.node_parser.UnstructuredElementNodeParser.from_defaults "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.UnstructuredElementNodeParser.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.node_parser.UnstructuredElementNodeParser.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.from_orm "Permalink to this definition")get\_base\_nodes\_and\_mappings(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → Tuple[List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")], Dict][](#llama_index.node_parser.UnstructuredElementNodeParser.get_base_nodes_and_mappings "Permalink to this definition")Get base nodes and mappings.

Given a list of nodes and IndexNode objects, return the base nodes and a mappingfrom index id to child nodes (which are excluded from the base nodes).

get\_nodes\_from\_documents(*documents: Sequence[TextNode]*, *show\_progress: bool = False*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.UnstructuredElementNodeParser.get_nodes_from_documents "Permalink to this definition")Parse document into nodes.

Parameters**documents** (*Sequence**[**TextNode**]*) – TextNodes or Documents to parse

get\_nodes\_from\_node(*node: TextNode*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.UnstructuredElementNodeParser.get_nodes_from_node "Permalink to this definition")Get nodes from node.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.UnstructuredElementNodeParser.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.node_parser.UnstructuredElementNodeParser.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.node_parser.UnstructuredElementNodeParser.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.node_parser.UnstructuredElementNodeParser.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.node_parser.UnstructuredElementNodeParser.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.node_parser.UnstructuredElementNodeParser.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.node_parser.UnstructuredElementNodeParser.validate "Permalink to this definition")llama\_index.node\_parser.get\_leaf\_nodes(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.get_leaf_nodes "Permalink to this definition")Get leaf nodes.

llama\_index.node\_parser.get\_root\_nodes(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.get_root_nodes "Permalink to this definition")Get root nodes.

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.MetadataExtractor[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor "Permalink to this definition")Metadata extractor.

Show JSON schema
```
{ "title": "MetadataExtractor", "description": "Metadata extractor.", "type": "object", "properties": { "extractors": { "title": "Extractors", "description": "Metadta feature extractors to apply to each node.", "type": "array", "items": { "$ref": "#/definitions/MetadataFeatureExtractor" } }, "node\_text\_template": { "title": "Node Text Template", "description": "Template to represent how node text is mixed with metadata text.", "default": "[Excerpt from document]\n{metadata\_str}\nExcerpt:\n-----\n{content}\n-----\n", "type": "string" }, "disable\_template\_rewrite": { "title": "Disable Template Rewrite", "description": "Disable the node template rewrite.", "default": false, "type": "boolean" }, "in\_place": { "title": "In Place", "description": "Whether to process nodes in place.", "default": true, "type": "boolean" } }, "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "MetadataFeatureExtractor": { "title": "MetadataFeatureExtractor", "description": "Base interface for feature extractor.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] } } } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`disable\_template\_rewrite (bool)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.disable_template_rewrite "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.disable_template_rewrite")
* [`extractors (Sequence[llama\_index.node\_parser.extractors.metadata\_extractors.MetadataFeatureExtractor])`](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.extractors "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.extractors")
* [`in\_place (bool)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.in_place "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.in_place")
* [`node\_text\_template (str)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.node_text_template "llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.node_text_template")
*field* disable\_template\_rewrite*: bool* *= False*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.disable_template_rewrite "Permalink to this definition")Disable the node template rewrite.

*field* extractors*: Sequence[[MetadataFeatureExtractor](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor "llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor")]* *[Optional]*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.extractors "Permalink to this definition")Metadta feature extractors to apply to each node.

*field* in\_place*: bool* *= True*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.in_place "Permalink to this definition")Whether to process nodes in place.

*field* node\_text\_template*: str* *= '[Excerpt from document]\n{metadata\_str}\nExcerpt:\n-----\n{content}\n-----\n'*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.node_text_template "Permalink to this definition")Template to represent how node text is mixed with metadata text.

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.extract "Permalink to this definition")Extract metadata from a document.

Parameters**nodes** (*Sequence**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – nodes to extract metadata from

process\_nodes(*nodes: List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*, *excluded\_embed\_metadata\_keys: Optional[List[str]] = None*, *excluded\_llm\_metadata\_keys: Optional[List[str]] = None*) → List[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")][](#llama_index.node_parser.extractors.metadata_extractors.MetadataExtractor.process_nodes "Permalink to this definition")Post process nodes parsed from documents.

Allows extractors to be chained.

Parameters* **nodes** (*List**[*[*BaseNode*](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")*]*) – nodes to post-process
* **excluded\_embed\_metadata\_keys** (*Optional**[**List**[**str**]**]*) – keys to exclude from embed metadata
* **excluded\_llm\_metadata\_keys** (*Optional**[**List**[**str**]**]*) – keys to exclude from llm metadata
*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.SummaryExtractor[](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor "Permalink to this definition")Summary extractor. Node-level extractor with adjacent sharing.Extracts section\_summary, prev\_section\_summary, next\_section\_summarymetadata fields.

Parameters* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLM predictor
* **summaries** (*List**[**str**]*) – list of summaries to extract: ‘self’, ‘prev’, ‘next’
* **prompt\_template** (*str*) – template for summary extraction
Show JSON schema
```
{ "title": "SummaryExtractor", "description": "Summary extractor. Node-level extractor with adjacent sharing.\nExtracts `section\_summary`, `prev\_section\_summary`, `next\_section\_summary`\nmetadata fields.\n\nArgs:\n llm\_predictor (Optional[BaseLLMPredictor]): LLM predictor\n summaries (List[str]): list of summaries to extract: 'self', 'prev', 'next'\n prompt\_template (str): template for summary extraction", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "llm\_predictor": { "title": "Llm Predictor", "description": "The LLMPredictor to use for generation.", "allOf": [ { "$ref": "#/definitions/BaseLLMPredictor" } ] }, "summaries": { "title": "Summaries", "description": "List of summaries to extract: 'self', 'prev', 'next'", "type": "array", "items": { "type": "string" } }, "prompt\_template": { "title": "Prompt Template", "description": "Template to use when generating summaries.", "default": "Here is the content of the section:\n{context\_str}\n\nSummarize the key topics and entities of the section. \nSummary: ", "type": "string" } }, "required": [ "llm\_predictor", "summaries" ], "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "BaseLLMPredictor": { "title": "BaseLLMPredictor", "description": "Base LLM Predictor.", "type": "object", "properties": {} } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`llm\_predictor (llama\_index.llm\_predictor.base.BaseLLMPredictor)`](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.llm_predictor "llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.llm_predictor")
* [`prompt\_template (str)`](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.prompt_template "llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.prompt_template")
* [`summaries (List[str])`](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.summaries "llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.summaries")
*field* llm\_predictor*: BaseLLMPredictor* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.llm_predictor "Permalink to this definition")The LLMPredictor to use for generation.

*field* prompt\_template*: str* *= 'Here is the content of the section:\n{context\_str}\n\nSummarize the key topics and entities of the section. \nSummary: '*[](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.prompt_template "Permalink to this definition")Template to use when generating summaries.

*field* summaries*: List[str]* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.summaries "Permalink to this definition")List of summaries to extract: ‘self’, ‘prev’, ‘next’

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.SummaryExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.QuestionsAnsweredExtractor[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor "Permalink to this definition")Questions answered extractor. Node-level extractor.Extracts questions\_this\_excerpt\_can\_answer metadata field.

Parameters* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLM predictor
* **questions** (*int*) – number of questions to extract
* **prompt\_template** (*str*) – template for question extraction,
* **embedding\_only** (*bool*) – whether to use embedding only
Show JSON schema
```
{ "title": "QuestionsAnsweredExtractor", "description": "Questions answered extractor. Node-level extractor.\nExtracts `questions\_this\_excerpt\_can\_answer` metadata field.\n\nArgs:\n llm\_predictor (Optional[BaseLLMPredictor]): LLM predictor\n questions (int): number of questions to extract\n prompt\_template (str): template for question extraction,\n embedding\_only (bool): whether to use embedding only", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "llm\_predictor": { "title": "Llm Predictor", "description": "The LLMPredictor to use for generation.", "allOf": [ { "$ref": "#/definitions/BaseLLMPredictor" } ] }, "questions": { "title": "Questions", "description": "The number of questions to generate.", "default": 5, "type": "integer" }, "prompt\_template": { "title": "Prompt Template", "description": "Prompt template to use when generating questions.", "default": "Here is the context:\n{context\_str}\n\nGiven the contextual information, generate {num\_questions} questions this context can provide specific answers to which are unlikely to be found elsewhere.\n\nHigher-level summaries of surrounding context may be provided as well. Try using these summaries to generate better questions that this context can answer.\n\n", "type": "string" }, "embedding\_only": { "title": "Embedding Only", "description": "Whether to use metadata for emebddings only.", "default": true, "type": "boolean" } }, "required": [ "llm\_predictor" ], "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "BaseLLMPredictor": { "title": "BaseLLMPredictor", "description": "Base LLM Predictor.", "type": "object", "properties": {} } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`embedding\_only (bool)`](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.embedding_only "llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.embedding_only")
* [`llm\_predictor (llama\_index.llm\_predictor.base.BaseLLMPredictor)`](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.llm_predictor "llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.llm_predictor")
* [`prompt\_template (str)`](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.prompt_template "llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.prompt_template")
* [`questions (int)`](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.questions "llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.questions")
*field* embedding\_only*: bool* *= True*[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.embedding_only "Permalink to this definition")Whether to use metadata for emebddings only.

*field* llm\_predictor*: BaseLLMPredictor* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.llm_predictor "Permalink to this definition")The LLMPredictor to use for generation.

*field* prompt\_template*: str* *= 'Here is the context:\n{context\_str}\n\nGiven the contextual information, generate {num\_questions} questions this context can provide specific answers to which are unlikely to be found elsewhere.\n\nHigher-level summaries of surrounding context may be provided as well. Try using these summaries to generate better questions that this context can answer.\n\n'*[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.prompt_template "Permalink to this definition")Prompt template to use when generating questions.

*field* questions*: int* *= 5*[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.questions "Permalink to this definition")The number of questions to generate.

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.QuestionsAnsweredExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.TitleExtractor[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor "Permalink to this definition")Title extractor. Useful for long documents. Extracts document\_titlemetadata field.

Parameters* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLM predictor
* **nodes** (*int*) – number of nodes from front to use for title extraction
* **node\_template** (*str*) – template for node-level title clues extraction
* **combine\_template** (*str*) – template for combining node-level clues intoa document-level title
Show JSON schema
```
{ "title": "TitleExtractor", "description": "Title extractor. Useful for long documents. Extracts `document\_title`\nmetadata field.\n\nArgs:\n llm\_predictor (Optional[BaseLLMPredictor]): LLM predictor\n nodes (int): number of nodes from front to use for title extraction\n node\_template (str): template for node-level title clues extraction\n combine\_template (str): template for combining node-level clues into\n a document-level title", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": false, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "llm\_predictor": { "title": "Llm Predictor", "description": "The LLMPredictor to use for generation.", "allOf": [ { "$ref": "#/definitions/BaseLLMPredictor" } ] }, "nodes": { "title": "Nodes", "description": "The number of nodes to extract titles from.", "default": 5, "type": "integer" }, "node\_template": { "title": "Node Template", "description": "The prompt template to extract titles with.", "default": "Context: {context\_str}. Give a title that summarizes all of the unique entities, titles or themes found in the context. Title: ", "type": "string" }, "combine\_template": { "title": "Combine Template", "description": "The prompt template to merge titles with.", "default": "{context\_str}. Based on the above candidate titles and content, what is the comprehensive title for this document? Title: ", "type": "string" } }, "required": [ "llm\_predictor" ], "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "BaseLLMPredictor": { "title": "BaseLLMPredictor", "description": "Base LLM Predictor.", "type": "object", "properties": {} } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`combine\_template (str)`](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.combine_template "llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.combine_template")
* [`is\_text\_node\_only (bool)`](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.is_text_node_only "llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.is_text_node_only")
* [`llm\_predictor (llama\_index.llm\_predictor.base.BaseLLMPredictor)`](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.llm_predictor "llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.llm_predictor")
* [`node\_template (str)`](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.node_template "llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.node_template")
* [`nodes (int)`](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.nodes "llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.nodes")
*field* combine\_template*: str* *= '{context\_str}. Based on the above candidate titles and content, what is the comprehensive title for this document? Title: '*[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.combine_template "Permalink to this definition")The prompt template to merge titles with.

*field* is\_text\_node\_only*: bool* *= False*[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.is_text_node_only "Permalink to this definition")*field* llm\_predictor*: BaseLLMPredictor* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.llm_predictor "Permalink to this definition")The LLMPredictor to use for generation.

*field* node\_template*: str* *= 'Context: {context\_str}. Give a title that summarizes all of the unique entities, titles or themes found in the context. Title: '*[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.node_template "Permalink to this definition")The prompt template to extract titles with.

*field* nodes*: int* *= 5*[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.nodes "Permalink to this definition")The number of nodes to extract titles from.

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.TitleExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.KeywordExtractor[](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor "Permalink to this definition")Keyword extractor. Node-level extractor. Extractsexcerpt\_keywords metadata field.

Parameters* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLM predictor
* **keywords** (*int*) – number of keywords to extract
Show JSON schema
```
{ "title": "KeywordExtractor", "description": "Keyword extractor. Node-level extractor. Extracts\n`excerpt\_keywords` metadata field.\n\nArgs:\n llm\_predictor (Optional[BaseLLMPredictor]): LLM predictor\n keywords (int): number of keywords to extract", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "llm\_predictor": { "title": "Llm Predictor", "description": "The LLMPredictor to use for generation.", "allOf": [ { "$ref": "#/definitions/BaseLLMPredictor" } ] }, "keywords": { "title": "Keywords", "description": "The number of keywords to extract.", "default": 5, "type": "integer" } }, "required": [ "llm\_predictor" ], "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "BaseLLMPredictor": { "title": "BaseLLMPredictor", "description": "Base LLM Predictor.", "type": "object", "properties": {} } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`keywords (int)`](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.keywords "llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.keywords")
* [`llm\_predictor (llama\_index.llm\_predictor.base.BaseLLMPredictor)`](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.llm_predictor "llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.llm_predictor")
*field* keywords*: int* *= 5*[](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.keywords "Permalink to this definition")The number of keywords to extract.

*field* llm\_predictor*: BaseLLMPredictor* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.llm_predictor "Permalink to this definition")The LLMPredictor to use for generation.

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.KeywordExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.EntityExtractor[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor "Permalink to this definition")Entity extractor. Extracts entities into a metadata field using a default modeltomaarsen/span-marker-mbert-base-multinerd and the SpanMarker library.

Install SpanMarker with pip install span-marker.

Show JSON schema
```
{ "title": "EntityExtractor", "description": "Entity extractor. Extracts `entities` into a metadata field using a default model\n`tomaarsen/span-marker-mbert-base-multinerd` and the SpanMarker library.\n\nInstall SpanMarker with `pip install span-marker`.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] }, "model\_name": { "title": "Model Name", "description": "The model name of the SpanMarker model to use.", "default": "tomaarsen/span-marker-mbert-base-multinerd", "type": "string" }, "prediction\_threshold": { "title": "Prediction Threshold", "description": "The confidence threshold for accepting predictions.", "default": 0.5, "type": "number" }, "span\_joiner": { "title": "Span Joiner", "description": "The separator between entity names.", "type": "string" }, "label\_entities": { "title": "Label Entities", "description": "Include entity class labels or not.", "default": false, "type": "boolean" }, "device": { "title": "Device", "description": "Device to run model on, i.e. 'cuda', 'cpu'", "type": "string" }, "entity\_map": { "title": "Entity Map", "description": "Mapping of entity class names to usable names.", "type": "object", "additionalProperties": { "type": "string" } } }, "required": [ "span\_joiner" ], "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`device (Optional[str])`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.device "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.device")
* [`entity\_map (Dict[str, str])`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.entity_map "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.entity_map")
* [`label\_entities (bool)`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.label_entities "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.label_entities")
* [`model\_name (str)`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.model_name "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.model_name")
* [`prediction\_threshold (float)`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.prediction_threshold "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.prediction_threshold")
* [`span\_joiner (str)`](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.span_joiner "llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.span_joiner")
*field* device*: Optional[str]* *= None*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.device "Permalink to this definition")Device to run model on, i.e. ‘cuda’, ‘cpu’

*field* entity\_map*: Dict[str, str]* *[Optional]*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.entity_map "Permalink to this definition")Mapping of entity class names to usable names.

*field* label\_entities*: bool* *= False*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.label_entities "Permalink to this definition")Include entity class labels or not.

*field* model\_name*: str* *= 'tomaarsen/span-marker-mbert-base-multinerd'*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.model_name "Permalink to this definition")The model name of the SpanMarker model to use.

*field* prediction\_threshold*: float* *= 0.5*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.prediction_threshold "Permalink to this definition")The confidence threshold for accepting predictions.

*field* span\_joiner*: str* *[Required]*[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.span_joiner "Permalink to this definition")The separator between entity names.

*classmethod* class\_name() → str[](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.EntityExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

*pydantic model* llama\_index.node\_parser.extractors.metadata\_extractors.MetadataFeatureExtractor[](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor "Permalink to this definition")Show JSON schema
```
{ "title": "MetadataFeatureExtractor", "description": "Base interface for feature extractor.", "type": "object", "properties": { "is\_text\_node\_only": { "title": "Is Text Node Only", "default": true, "type": "boolean" }, "show\_progress": { "title": "Show Progress", "default": true, "type": "boolean" }, "metadata\_mode": { "default": "1", "allOf": [ { "$ref": "#/definitions/MetadataMode" } ] } }, "definitions": { "MetadataMode": { "title": "MetadataMode", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`is\_text\_node\_only (bool)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.is_text_node_only "llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.is_text_node_only")
* [`metadata\_mode (llama\_index.schema.MetadataMode)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.metadata_mode "llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.metadata_mode")
* [`show\_progress (bool)`](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.show_progress "llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.show_progress")
*field* is\_text\_node\_only*: bool* *= True*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.is_text_node_only "Permalink to this definition")*field* metadata\_mode*: [MetadataMode](../node.html#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode")* *= MetadataMode.ALL*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.metadata_mode "Permalink to this definition")*field* show\_progress*: bool* *= True*[](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.show_progress "Permalink to this definition")*abstract* extract(*nodes: Sequence[[BaseNode](../node.html#llama_index.schema.BaseNode "llama_index.schema.BaseNode")]*) → List[Dict][](#llama_index.node_parser.extractors.metadata_extractors.MetadataFeatureExtractor.extract "Permalink to this definition")Extracts metadata for a sequence of nodes, returning a list ofmetadata dictionaries corresponding to each node.

Parameters**nodes** (*Sequence**[*[*Document*](../node.html#llama_index.schema.Document "llama_index.schema.Document")*]*) – nodes to extract metadata from

