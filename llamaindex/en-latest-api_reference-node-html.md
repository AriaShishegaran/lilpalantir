Node[](#module-llama_index.schema "Permalink to this heading")
===============================================================

Base schema for data structures.

*pydantic model* llama\_index.schema.BaseComponent[](#llama_index.schema.BaseComponent "Permalink to this definition")Base component object to capture class names.

Show JSON schema
```
{ "title": "BaseComponent", "description": "Base component object to capture class names.", "type": "object", "properties": {}}
```


*abstract classmethod* class\_name() → str[](#llama_index.schema.BaseComponent.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.BaseComponent.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.BaseComponent.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.BaseComponent.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.BaseComponent.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.BaseComponent.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.BaseComponent.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.BaseComponent.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.BaseComponent.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.BaseComponent.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.BaseComponent.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.BaseComponent.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.BaseComponent.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.BaseComponent.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.BaseComponent.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.BaseComponent.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.BaseComponent.validate "Permalink to this definition")*pydantic model* llama\_index.schema.BaseNode[](#llama_index.schema.BaseNode "Permalink to this definition")Base node Object.

Generic abstract interface for retrievable nodes

Show JSON schema
```
{ "title": "BaseNode", "description": "Base node Object.\n\nGeneric abstract interface for retrievable nodes", "type": "object", "properties": { "id\_": { "title": "Id ", "description": "Unique ID of the node.", "type": "string" }, "embedding": { "title": "Embedding", "description": "Embedding of the node.", "type": "array", "items": { "type": "number" } }, "extra\_info": { "title": "Extra Info", "description": "A flat dictionary of metadata fields", "type": "object" }, "excluded\_embed\_metadata\_keys": { "title": "Excluded Embed Metadata Keys", "description": "Metadata keys that are excluded from text for the embed model.", "type": "array", "items": { "type": "string" } }, "excluded\_llm\_metadata\_keys": { "title": "Excluded Llm Metadata Keys", "description": "Metadata keys that are excluded from text for the LLM.", "type": "array", "items": { "type": "string" } }, "relationships": { "title": "Relationships", "description": "A mapping of relationships to other node information.", "type": "object", "additionalProperties": { "anyOf": [ { "$ref": "#/definitions/RelatedNodeInfo" }, { "type": "array", "items": { "$ref": "#/definitions/RelatedNodeInfo" } } ] } }, "hash": { "title": "Hash", "description": "Hash of the node content.", "default": "", "type": "string" } }, "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "RelatedNodeInfo": { "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ] } }}
```


Config* **allow\_population\_by\_field\_name**: *bool = True*
Fields* [`embedding (Optional[List[float]])`](#llama_index.schema.BaseNode.embedding "llama_index.schema.BaseNode.embedding")
* [`excluded\_embed\_metadata\_keys (List[str])`](#llama_index.schema.BaseNode.excluded_embed_metadata_keys "llama_index.schema.BaseNode.excluded_embed_metadata_keys")
* [`excluded\_llm\_metadata\_keys (List[str])`](#llama_index.schema.BaseNode.excluded_llm_metadata_keys "llama_index.schema.BaseNode.excluded_llm_metadata_keys")
* [`hash (str)`](#llama_index.schema.BaseNode.hash "llama_index.schema.BaseNode.hash")
* [`id\_ (str)`](#llama_index.schema.BaseNode.id_ "llama_index.schema.BaseNode.id_")
* [`metadata (Dict[str, Any])`](#llama_index.schema.BaseNode.metadata "llama_index.schema.BaseNode.metadata")
* [`relationships (Dict[llama\_index.schema.NodeRelationship, Union[llama\_index.schema.RelatedNodeInfo, List[llama\_index.schema.RelatedNodeInfo]]])`](#llama_index.schema.BaseNode.relationships "llama_index.schema.BaseNode.relationships")
*field* embedding*: Optional[List[float]]* *= None*[](#llama_index.schema.BaseNode.embedding "Permalink to this definition")”metadata fields- injected as part of the text shown to LLMs as context- injected as part of the text for generating embeddings- used by vector DBs for metadata filtering

Embedding of the node.

*field* excluded\_embed\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.BaseNode.excluded_embed_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the embed model.

*field* excluded\_llm\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.BaseNode.excluded_llm_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the LLM.

*field* hash*: str* *= ''*[](#llama_index.schema.BaseNode.hash "Permalink to this definition")Hash of the node content.

*field* id\_*: str* *[Optional]*[](#llama_index.schema.BaseNode.id_ "Permalink to this definition")Unique ID of the node.

*field* metadata*: Dict[str, Any]* *[Optional]* *(alias 'extra\_info')*[](#llama_index.schema.BaseNode.metadata "Permalink to this definition")A flat dictionary of metadata fields

*field* relationships*: Dict[[NodeRelationship](#llama_index.schema.NodeRelationship "llama_index.schema.NodeRelationship"), Union[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo"), List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]]* *[Optional]*[](#llama_index.schema.BaseNode.relationships "Permalink to this definition")A mapping of relationships to other node information.

as\_related\_node\_info() → [RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")[](#llama_index.schema.BaseNode.as_related_node_info "Permalink to this definition")Get node as RelatedNodeInfo.

*abstract classmethod* class\_name() → str[](#llama_index.schema.BaseNode.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.BaseNode.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.BaseNode.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.BaseNode.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.BaseNode.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.BaseNode.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.BaseNode.from_orm "Permalink to this definition")*abstract* get\_content(*metadata\_mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.ALL*) → str[](#llama_index.schema.BaseNode.get_content "Permalink to this definition")Get object content.

get\_embedding() → List[float][](#llama_index.schema.BaseNode.get_embedding "Permalink to this definition")Get embedding.

Errors if embedding is None.

*abstract* get\_metadata\_str(*mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.ALL*) → str[](#llama_index.schema.BaseNode.get_metadata_str "Permalink to this definition")Metadata string.

*abstract classmethod* get\_type() → str[](#llama_index.schema.BaseNode.get_type "Permalink to this definition")Get Object type.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.BaseNode.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.BaseNode.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.BaseNode.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.BaseNode.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.BaseNode.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.BaseNode.schema_json "Permalink to this definition")*abstract* set\_content(*value: Any*) → None[](#llama_index.schema.BaseNode.set_content "Permalink to this definition")Set the content of the node.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.BaseNode.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.BaseNode.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.BaseNode.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.BaseNode.validate "Permalink to this definition")*property* child\_nodes*: Optional[List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]*[](#llama_index.schema.BaseNode.child_nodes "Permalink to this definition")Child nodes.

*property* extra\_info*: Dict[str, Any]*[](#llama_index.schema.BaseNode.extra_info "Permalink to this definition")Extra info.

TypeTODO

TypeDEPRECATED

*property* next\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.BaseNode.next_node "Permalink to this definition")Next node.

*property* node\_id*: str*[](#llama_index.schema.BaseNode.node_id "Permalink to this definition")*property* parent\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.BaseNode.parent_node "Permalink to this definition")Parent node.

*property* prev\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.BaseNode.prev_node "Permalink to this definition")Prev node.

*property* ref\_doc\_id*: Optional[str]*[](#llama_index.schema.BaseNode.ref_doc_id "Permalink to this definition")Get ref doc id.

TypeDeprecated

*property* source\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.BaseNode.source_node "Permalink to this definition")Source object node.

Extracted from the relationships field.

*pydantic model* llama\_index.schema.Document[](#llama_index.schema.Document "Permalink to this definition")Generic interface for a data document.

This document connects to data sources.

Show JSON schema
```
{ "title": "Document", "description": "Generic interface for a data document.\n\nThis document connects to data sources.", "type": "object", "properties": { "doc\_id": { "title": "Doc Id", "description": "Unique ID of the node.", "type": "string" }, "embedding": { "title": "Embedding", "description": "Embedding of the node.", "type": "array", "items": { "type": "number" } }, "extra\_info": { "title": "Extra Info", "description": "A flat dictionary of metadata fields", "type": "object" }, "excluded\_embed\_metadata\_keys": { "title": "Excluded Embed Metadata Keys", "description": "Metadata keys that are excluded from text for the embed model.", "type": "array", "items": { "type": "string" } }, "excluded\_llm\_metadata\_keys": { "title": "Excluded Llm Metadata Keys", "description": "Metadata keys that are excluded from text for the LLM.", "type": "array", "items": { "type": "string" } }, "relationships": { "title": "Relationships", "description": "A mapping of relationships to other node information.", "type": "object", "additionalProperties": { "anyOf": [ { "$ref": "#/definitions/RelatedNodeInfo" }, { "type": "array", "items": { "$ref": "#/definitions/RelatedNodeInfo" } } ] } }, "hash": { "title": "Hash", "description": "Hash of the node content.", "default": "", "type": "string" }, "text": { "title": "Text", "description": "Text content of the node.", "default": "", "type": "string" }, "start\_char\_idx": { "title": "Start Char Idx", "description": "Start char index of the node.", "type": "integer" }, "end\_char\_idx": { "title": "End Char Idx", "description": "End char index of the node.", "type": "integer" }, "text\_template": { "title": "Text Template", "description": "Template for how text is formatted, with {content} and {metadata\_str} placeholders.", "default": "{metadata\_str}\n\n{content}", "type": "string" }, "metadata\_template": { "title": "Metadata Template", "description": "Template for how metadata is formatted, with {key} and {value} placeholders.", "default": "{key}: {value}", "type": "string" }, "metadata\_seperator": { "title": "Metadata Seperator", "description": "Separator between metadata fields when converting to string.", "default": "\n", "type": "string" } }, "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "RelatedNodeInfo": { "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ] } }}
```


Config* **allow\_population\_by\_field\_name**: *bool = True*
Fields* [`embedding (Optional[List[float]])`](#llama_index.schema.Document.embedding "llama_index.schema.Document.embedding")
* [`end\_char\_idx (Optional[int])`](#llama_index.schema.Document.end_char_idx "llama_index.schema.Document.end_char_idx")
* [`excluded\_embed\_metadata\_keys (List[str])`](#llama_index.schema.Document.excluded_embed_metadata_keys "llama_index.schema.Document.excluded_embed_metadata_keys")
* [`excluded\_llm\_metadata\_keys (List[str])`](#llama_index.schema.Document.excluded_llm_metadata_keys "llama_index.schema.Document.excluded_llm_metadata_keys")
* [`hash (str)`](#llama_index.schema.Document.hash "llama_index.schema.Document.hash")
* [`id\_ (str)`](#llama_index.schema.Document.id_ "llama_index.schema.Document.id_")
* [`metadata (Dict[str, Any])`](#llama_index.schema.Document.metadata "llama_index.schema.Document.metadata")
* [`metadata\_seperator (str)`](#llama_index.schema.Document.metadata_seperator "llama_index.schema.Document.metadata_seperator")
* [`metadata\_template (str)`](#llama_index.schema.Document.metadata_template "llama_index.schema.Document.metadata_template")
* [`relationships (Dict[llama\_index.schema.NodeRelationship, Union[llama\_index.schema.RelatedNodeInfo, List[llama\_index.schema.RelatedNodeInfo]]])`](#llama_index.schema.Document.relationships "llama_index.schema.Document.relationships")
* [`start\_char\_idx (Optional[int])`](#llama_index.schema.Document.start_char_idx "llama_index.schema.Document.start_char_idx")
* [`text (str)`](#llama_index.schema.Document.text "llama_index.schema.Document.text")
* [`text\_template (str)`](#llama_index.schema.Document.text_template "llama_index.schema.Document.text_template")
*field* embedding*: Optional[List[float]]* *= None*[](#llama_index.schema.Document.embedding "Permalink to this definition")”metadata fields- injected as part of the text shown to LLMs as context- injected as part of the text for generating embeddings- used by vector DBs for metadata filtering

Embedding of the node.

Validated by* `\_check\_hash`
*field* end\_char\_idx*: Optional[int]* *= None*[](#llama_index.schema.Document.end_char_idx "Permalink to this definition")End char index of the node.

Validated by* `\_check\_hash`
*field* excluded\_embed\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.Document.excluded_embed_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the embed model.

Validated by* `\_check\_hash`
*field* excluded\_llm\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.Document.excluded_llm_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the LLM.

Validated by* `\_check\_hash`
*field* hash*: str* *= ''*[](#llama_index.schema.Document.hash "Permalink to this definition")Hash of the node content.

Validated by* `\_check\_hash`
*field* id\_*: str* *[Optional]* *(alias 'doc\_id')*[](#llama_index.schema.Document.id_ "Permalink to this definition")Unique ID of the node.

Validated by* `\_check\_hash`
*field* metadata*: Dict[str, Any]* *[Optional]* *(alias 'extra\_info')*[](#llama_index.schema.Document.metadata "Permalink to this definition")A flat dictionary of metadata fields

Validated by* `\_check\_hash`
*field* metadata\_seperator*: str* *= '\n'*[](#llama_index.schema.Document.metadata_seperator "Permalink to this definition")Separator between metadata fields when converting to string.

Validated by* `\_check\_hash`
*field* metadata\_template*: str* *= '{key}: {value}'*[](#llama_index.schema.Document.metadata_template "Permalink to this definition")Template for how metadata is formatted, with {key} and {value} placeholders.

Validated by* `\_check\_hash`
*field* relationships*: Dict[[NodeRelationship](#llama_index.schema.NodeRelationship "llama_index.schema.NodeRelationship"), Union[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo"), List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]]* *[Optional]*[](#llama_index.schema.Document.relationships "Permalink to this definition")A mapping of relationships to other node information.

Validated by* `\_check\_hash`
*field* start\_char\_idx*: Optional[int]* *= None*[](#llama_index.schema.Document.start_char_idx "Permalink to this definition")Start char index of the node.

Validated by* `\_check\_hash`
*field* text*: str* *= ''*[](#llama_index.schema.Document.text "Permalink to this definition")Text content of the node.

Validated by* `\_check\_hash`
*field* text\_template*: str* *= '{metadata\_str}\n\n{content}'*[](#llama_index.schema.Document.text_template "Permalink to this definition")Template for how text is formatted, with {content} and {metadata\_str} placeholders.

Validated by* `\_check\_hash`
as\_related\_node\_info() → [RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")[](#llama_index.schema.Document.as_related_node_info "Permalink to this definition")Get node as RelatedNodeInfo.

*classmethod* class\_name() → str[](#llama_index.schema.Document.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.Document.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.Document.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.Document.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* example() → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.Document.example "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.Document.from_dict "Permalink to this definition")*classmethod* from\_embedchain\_format(*doc: Dict[str, Any]*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.Document.from_embedchain_format "Permalink to this definition")Convert struct from EmbedChain document format.

*classmethod* from\_haystack\_format(*doc: HaystackDocument*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.Document.from_haystack_format "Permalink to this definition")Convert struct from Haystack document format.

*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.Document.from_json "Permalink to this definition")*classmethod* from\_langchain\_format(*doc: LCDocument*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.Document.from_langchain_format "Permalink to this definition")Convert struct from LangChain document format.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.Document.from_orm "Permalink to this definition")*classmethod* from\_semantic\_kernel\_format(*doc: MemoryRecord*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.Document.from_semantic_kernel_format "Permalink to this definition")Convert struct from Semantic Kernel document format.

get\_content(*metadata\_mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.NONE*) → str[](#llama_index.schema.Document.get_content "Permalink to this definition")Get object content.

get\_doc\_id() → str[](#llama_index.schema.Document.get_doc_id "Permalink to this definition")TODO: Deprecated: Get document ID.

get\_embedding() → List[float][](#llama_index.schema.Document.get_embedding "Permalink to this definition")Get embedding.

Errors if embedding is None.

get\_metadata\_str(*mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.ALL*) → str[](#llama_index.schema.Document.get_metadata_str "Permalink to this definition")Metadata info string.

get\_node\_info() → Dict[str, Any][](#llama_index.schema.Document.get_node_info "Permalink to this definition")Get node info.

get\_text() → str[](#llama_index.schema.Document.get_text "Permalink to this definition")*classmethod* get\_type() → str[](#llama_index.schema.Document.get_type "Permalink to this definition")Get Document type.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.Document.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.Document.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.Document.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.Document.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.Document.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.Document.schema_json "Permalink to this definition")set\_content(*value: str*) → None[](#llama_index.schema.Document.set_content "Permalink to this definition")Set the content of the node.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.Document.to_dict "Permalink to this definition")to\_embedchain\_format() → Dict[str, Any][](#llama_index.schema.Document.to_embedchain_format "Permalink to this definition")Convert struct to EmbedChain document format.

to\_haystack\_format() → HaystackDocument[](#llama_index.schema.Document.to_haystack_format "Permalink to this definition")Convert struct to Haystack document format.

to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.Document.to_json "Permalink to this definition")to\_langchain\_format() → LCDocument[](#llama_index.schema.Document.to_langchain_format "Permalink to this definition")Convert struct to LangChain document format.

to\_semantic\_kernel\_format() → MemoryRecord[](#llama_index.schema.Document.to_semantic_kernel_format "Permalink to this definition")Convert struct to Semantic Kernel document format.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.Document.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.Document.validate "Permalink to this definition")*property* child\_nodes*: Optional[List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]*[](#llama_index.schema.Document.child_nodes "Permalink to this definition")Child nodes.

*property* doc\_id*: str*[](#llama_index.schema.Document.doc_id "Permalink to this definition")Get document ID.

*property* extra\_info*: Dict[str, Any]*[](#llama_index.schema.Document.extra_info "Permalink to this definition")Extra info.

TypeTODO

TypeDEPRECATED

*property* next\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.Document.next_node "Permalink to this definition")Next node.

*property* node\_id*: str*[](#llama_index.schema.Document.node_id "Permalink to this definition")*property* node\_info*: Dict[str, Any]*[](#llama_index.schema.Document.node_info "Permalink to this definition")Get node info.

TypeDeprecated

*property* parent\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.Document.parent_node "Permalink to this definition")Parent node.

*property* prev\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.Document.prev_node "Permalink to this definition")Prev node.

*property* ref\_doc\_id*: Optional[str]*[](#llama_index.schema.Document.ref_doc_id "Permalink to this definition")Get ref doc id.

TypeDeprecated

*property* source\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.Document.source_node "Permalink to this definition")Source object node.

Extracted from the relationships field.

*pydantic model* llama\_index.schema.ImageDocument[](#llama_index.schema.ImageDocument "Permalink to this definition")Data document containing an image.

Show JSON schema
```
{ "title": "ImageDocument", "description": "Data document containing an image.", "type": "object", "properties": { "doc\_id": { "title": "Doc Id", "description": "Unique ID of the node.", "type": "string" }, "embedding": { "title": "Embedding", "description": "Embedding of the node.", "type": "array", "items": { "type": "number" } }, "extra\_info": { "title": "Extra Info", "description": "A flat dictionary of metadata fields", "type": "object" }, "excluded\_embed\_metadata\_keys": { "title": "Excluded Embed Metadata Keys", "description": "Metadata keys that are excluded from text for the embed model.", "type": "array", "items": { "type": "string" } }, "excluded\_llm\_metadata\_keys": { "title": "Excluded Llm Metadata Keys", "description": "Metadata keys that are excluded from text for the LLM.", "type": "array", "items": { "type": "string" } }, "relationships": { "title": "Relationships", "description": "A mapping of relationships to other node information.", "type": "object", "additionalProperties": { "anyOf": [ { "$ref": "#/definitions/RelatedNodeInfo" }, { "type": "array", "items": { "$ref": "#/definitions/RelatedNodeInfo" } } ] } }, "hash": { "title": "Hash", "description": "Hash of the node content.", "default": "", "type": "string" }, "text": { "title": "Text", "description": "Text content of the node.", "default": "", "type": "string" }, "start\_char\_idx": { "title": "Start Char Idx", "description": "Start char index of the node.", "type": "integer" }, "end\_char\_idx": { "title": "End Char Idx", "description": "End char index of the node.", "type": "integer" }, "text\_template": { "title": "Text Template", "description": "Template for how text is formatted, with {content} and {metadata\_str} placeholders.", "default": "{metadata\_str}\n\n{content}", "type": "string" }, "metadata\_template": { "title": "Metadata Template", "description": "Template for how metadata is formatted, with {key} and {value} placeholders.", "default": "{key}: {value}", "type": "string" }, "metadata\_seperator": { "title": "Metadata Seperator", "description": "Separator between metadata fields when converting to string.", "default": "\n", "type": "string" }, "image": { "title": "Image", "type": "string" }, "image\_path": { "title": "Image Path", "type": "string" }, "image\_url": { "title": "Image Url", "type": "string" } }, "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "RelatedNodeInfo": { "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ] } }}
```


Config* **allow\_population\_by\_field\_name**: *bool = True*
Fields* [`embedding (Optional[List[float]])`](#llama_index.schema.ImageDocument.embedding "llama_index.schema.ImageDocument.embedding")
* [`end\_char\_idx (Optional[int])`](#llama_index.schema.ImageDocument.end_char_idx "llama_index.schema.ImageDocument.end_char_idx")
* [`excluded\_embed\_metadata\_keys (List[str])`](#llama_index.schema.ImageDocument.excluded_embed_metadata_keys "llama_index.schema.ImageDocument.excluded_embed_metadata_keys")
* [`excluded\_llm\_metadata\_keys (List[str])`](#llama_index.schema.ImageDocument.excluded_llm_metadata_keys "llama_index.schema.ImageDocument.excluded_llm_metadata_keys")
* [`hash (str)`](#llama_index.schema.ImageDocument.hash "llama_index.schema.ImageDocument.hash")
* [`id\_ (str)`](#llama_index.schema.ImageDocument.id_ "llama_index.schema.ImageDocument.id_")
* [`image (Optional[str])`](#llama_index.schema.ImageDocument.image "llama_index.schema.ImageDocument.image")
* [`image\_path (Optional[str])`](#llama_index.schema.ImageDocument.image_path "llama_index.schema.ImageDocument.image_path")
* [`image\_url (Optional[str])`](#llama_index.schema.ImageDocument.image_url "llama_index.schema.ImageDocument.image_url")
* [`metadata (Dict[str, Any])`](#llama_index.schema.ImageDocument.metadata "llama_index.schema.ImageDocument.metadata")
* [`metadata\_seperator (str)`](#llama_index.schema.ImageDocument.metadata_seperator "llama_index.schema.ImageDocument.metadata_seperator")
* [`metadata\_template (str)`](#llama_index.schema.ImageDocument.metadata_template "llama_index.schema.ImageDocument.metadata_template")
* [`relationships (Dict[llama\_index.schema.NodeRelationship, Union[llama\_index.schema.RelatedNodeInfo, List[llama\_index.schema.RelatedNodeInfo]]])`](#llama_index.schema.ImageDocument.relationships "llama_index.schema.ImageDocument.relationships")
* [`start\_char\_idx (Optional[int])`](#llama_index.schema.ImageDocument.start_char_idx "llama_index.schema.ImageDocument.start_char_idx")
* [`text (str)`](#llama_index.schema.ImageDocument.text "llama_index.schema.ImageDocument.text")
* [`text\_template (str)`](#llama_index.schema.ImageDocument.text_template "llama_index.schema.ImageDocument.text_template")
*field* embedding*: Optional[List[float]]* *= None*[](#llama_index.schema.ImageDocument.embedding "Permalink to this definition")”metadata fields- injected as part of the text shown to LLMs as context- injected as part of the text for generating embeddings- used by vector DBs for metadata filtering

Embedding of the node.

Validated by* `\_check\_hash`
*field* end\_char\_idx*: Optional[int]* *= None*[](#llama_index.schema.ImageDocument.end_char_idx "Permalink to this definition")End char index of the node.

Validated by* `\_check\_hash`
*field* excluded\_embed\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.ImageDocument.excluded_embed_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the embed model.

Validated by* `\_check\_hash`
*field* excluded\_llm\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.schema.ImageDocument.excluded_llm_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the LLM.

Validated by* `\_check\_hash`
*field* hash*: str* *= ''*[](#llama_index.schema.ImageDocument.hash "Permalink to this definition")Hash of the node content.

Validated by* `\_check\_hash`
*field* id\_*: str* *[Optional]* *(alias 'doc\_id')*[](#llama_index.schema.ImageDocument.id_ "Permalink to this definition")Unique ID of the node.

Validated by* `\_check\_hash`
*field* image*: Optional[str]* *= None*[](#llama_index.schema.ImageDocument.image "Permalink to this definition")Validated by* `\_check\_hash`
*field* image\_path*: Optional[str]* *= None*[](#llama_index.schema.ImageDocument.image_path "Permalink to this definition")Validated by* `\_check\_hash`
*field* image\_url*: Optional[str]* *= None*[](#llama_index.schema.ImageDocument.image_url "Permalink to this definition")Validated by* `\_check\_hash`
*field* metadata*: Dict[str, Any]* *[Optional]* *(alias 'extra\_info')*[](#llama_index.schema.ImageDocument.metadata "Permalink to this definition")A flat dictionary of metadata fields

Validated by* `\_check\_hash`
*field* metadata\_seperator*: str* *= '\n'*[](#llama_index.schema.ImageDocument.metadata_seperator "Permalink to this definition")Separator between metadata fields when converting to string.

Validated by* `\_check\_hash`
*field* metadata\_template*: str* *= '{key}: {value}'*[](#llama_index.schema.ImageDocument.metadata_template "Permalink to this definition")Template for how metadata is formatted, with {key} and {value} placeholders.

Validated by* `\_check\_hash`
*field* relationships*: Dict[[NodeRelationship](#llama_index.schema.NodeRelationship "llama_index.schema.NodeRelationship"), Union[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo"), List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]]* *[Optional]*[](#llama_index.schema.ImageDocument.relationships "Permalink to this definition")A mapping of relationships to other node information.

Validated by* `\_check\_hash`
*field* start\_char\_idx*: Optional[int]* *= None*[](#llama_index.schema.ImageDocument.start_char_idx "Permalink to this definition")Start char index of the node.

Validated by* `\_check\_hash`
*field* text*: str* *= ''*[](#llama_index.schema.ImageDocument.text "Permalink to this definition")Text content of the node.

Validated by* `\_check\_hash`
*field* text\_template*: str* *= '{metadata\_str}\n\n{content}'*[](#llama_index.schema.ImageDocument.text_template "Permalink to this definition")Template for how text is formatted, with {content} and {metadata\_str} placeholders.

Validated by* `\_check\_hash`
as\_related\_node\_info() → [RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")[](#llama_index.schema.ImageDocument.as_related_node_info "Permalink to this definition")Get node as RelatedNodeInfo.

*classmethod* class\_name() → str[](#llama_index.schema.ImageDocument.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.ImageDocument.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.ImageDocument.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.ImageDocument.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* example() → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.ImageDocument.example "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.ImageDocument.from_dict "Permalink to this definition")*classmethod* from\_embedchain\_format(*doc: Dict[str, Any]*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.ImageDocument.from_embedchain_format "Permalink to this definition")Convert struct from EmbedChain document format.

*classmethod* from\_haystack\_format(*doc: HaystackDocument*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.ImageDocument.from_haystack_format "Permalink to this definition")Convert struct from Haystack document format.

*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.ImageDocument.from_json "Permalink to this definition")*classmethod* from\_langchain\_format(*doc: LCDocument*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.ImageDocument.from_langchain_format "Permalink to this definition")Convert struct from LangChain document format.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.ImageDocument.from_orm "Permalink to this definition")*classmethod* from\_semantic\_kernel\_format(*doc: MemoryRecord*) → [Document](#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.schema.ImageDocument.from_semantic_kernel_format "Permalink to this definition")Convert struct from Semantic Kernel document format.

get\_content(*metadata\_mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.NONE*) → str[](#llama_index.schema.ImageDocument.get_content "Permalink to this definition")Get object content.

get\_doc\_id() → str[](#llama_index.schema.ImageDocument.get_doc_id "Permalink to this definition")TODO: Deprecated: Get document ID.

get\_embedding() → List[float][](#llama_index.schema.ImageDocument.get_embedding "Permalink to this definition")Get embedding.

Errors if embedding is None.

get\_metadata\_str(*mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.ALL*) → str[](#llama_index.schema.ImageDocument.get_metadata_str "Permalink to this definition")Metadata info string.

get\_node\_info() → Dict[str, Any][](#llama_index.schema.ImageDocument.get_node_info "Permalink to this definition")Get node info.

get\_text() → str[](#llama_index.schema.ImageDocument.get_text "Permalink to this definition")*classmethod* get\_type() → str[](#llama_index.schema.ImageDocument.get_type "Permalink to this definition")Get Document type.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.ImageDocument.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.ImageDocument.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.ImageDocument.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.ImageDocument.parse_raw "Permalink to this definition")resolve\_image() → Union[str, BytesIO][](#llama_index.schema.ImageDocument.resolve_image "Permalink to this definition")Resolve an image such that PIL can read it.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.ImageDocument.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.ImageDocument.schema_json "Permalink to this definition")set\_content(*value: str*) → None[](#llama_index.schema.ImageDocument.set_content "Permalink to this definition")Set the content of the node.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.ImageDocument.to_dict "Permalink to this definition")to\_embedchain\_format() → Dict[str, Any][](#llama_index.schema.ImageDocument.to_embedchain_format "Permalink to this definition")Convert struct to EmbedChain document format.

to\_haystack\_format() → HaystackDocument[](#llama_index.schema.ImageDocument.to_haystack_format "Permalink to this definition")Convert struct to Haystack document format.

to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.ImageDocument.to_json "Permalink to this definition")to\_langchain\_format() → LCDocument[](#llama_index.schema.ImageDocument.to_langchain_format "Permalink to this definition")Convert struct to LangChain document format.

to\_semantic\_kernel\_format() → MemoryRecord[](#llama_index.schema.ImageDocument.to_semantic_kernel_format "Permalink to this definition")Convert struct to Semantic Kernel document format.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.ImageDocument.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.ImageDocument.validate "Permalink to this definition")*property* child\_nodes*: Optional[List[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]*[](#llama_index.schema.ImageDocument.child_nodes "Permalink to this definition")Child nodes.

*property* doc\_id*: str*[](#llama_index.schema.ImageDocument.doc_id "Permalink to this definition")Get document ID.

*property* extra\_info*: Dict[str, Any]*[](#llama_index.schema.ImageDocument.extra_info "Permalink to this definition")Extra info.

TypeTODO

TypeDEPRECATED

*property* next\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.ImageDocument.next_node "Permalink to this definition")Next node.

*property* node\_id*: str*[](#llama_index.schema.ImageDocument.node_id "Permalink to this definition")*property* node\_info*: Dict[str, Any]*[](#llama_index.schema.ImageDocument.node_info "Permalink to this definition")Get node info.

TypeDeprecated

*property* parent\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.ImageDocument.parent_node "Permalink to this definition")Parent node.

*property* prev\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.ImageDocument.prev_node "Permalink to this definition")Prev node.

*property* ref\_doc\_id*: Optional[str]*[](#llama_index.schema.ImageDocument.ref_doc_id "Permalink to this definition")Get ref doc id.

TypeDeprecated

*property* source\_node*: Optional[[RelatedNodeInfo](#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.schema.ImageDocument.source_node "Permalink to this definition")Source object node.

Extracted from the relationships field.

*class* llama\_index.schema.MetadataMode(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.schema.MetadataMode "Permalink to this definition")capitalize()[](#llama_index.schema.MetadataMode.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.schema.MetadataMode.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.schema.MetadataMode.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.MetadataMode.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.schema.MetadataMode.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.schema.MetadataMode.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.schema.MetadataMode.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.MetadataMode.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.schema.MetadataMode.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.schema.MetadataMode.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.MetadataMode.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.schema.MetadataMode.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.schema.MetadataMode.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.schema.MetadataMode.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.schema.MetadataMode.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.schema.MetadataMode.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.schema.MetadataMode.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.schema.MetadataMode.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.schema.MetadataMode.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.schema.MetadataMode.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.schema.MetadataMode.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.schema.MetadataMode.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.schema.MetadataMode.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.schema.MetadataMode.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.MetadataMode.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.schema.MetadataMode.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.schema.MetadataMode.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.schema.MetadataMode.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.schema.MetadataMode.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.schema.MetadataMode.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.schema.MetadataMode.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.schema.MetadataMode.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.MetadataMode.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.MetadataMode.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.MetadataMode.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.schema.MetadataMode.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.MetadataMode.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.schema.MetadataMode.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.MetadataMode.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.schema.MetadataMode.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.schema.MetadataMode.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.schema.MetadataMode.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.schema.MetadataMode.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.schema.MetadataMode.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.schema.MetadataMode.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.schema.MetadataMode.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.schema.MetadataMode.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

llama\_index.schema.Node[](#llama_index.schema.Node "Permalink to this definition")alias of `TextNode`

*class* llama\_index.schema.NodeRelationship(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.schema.NodeRelationship "Permalink to this definition")Node relationships used in BaseNode class.

SOURCE[](#llama_index.schema.NodeRelationship.SOURCE "Permalink to this definition")The node is the source document.

PREVIOUS[](#llama_index.schema.NodeRelationship.PREVIOUS "Permalink to this definition")The node is the previous node in the document.

NEXT[](#llama_index.schema.NodeRelationship.NEXT "Permalink to this definition")The node is the next node in the document.

PARENT[](#llama_index.schema.NodeRelationship.PARENT "Permalink to this definition")The node is the parent node in the document.

CHILD[](#llama_index.schema.NodeRelationship.CHILD "Permalink to this definition")The node is a child node in the document.

capitalize()[](#llama_index.schema.NodeRelationship.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.schema.NodeRelationship.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.schema.NodeRelationship.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.NodeRelationship.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.schema.NodeRelationship.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.schema.NodeRelationship.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.schema.NodeRelationship.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.NodeRelationship.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.schema.NodeRelationship.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.schema.NodeRelationship.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.NodeRelationship.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.schema.NodeRelationship.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.schema.NodeRelationship.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.schema.NodeRelationship.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.schema.NodeRelationship.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.schema.NodeRelationship.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.schema.NodeRelationship.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.schema.NodeRelationship.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.schema.NodeRelationship.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.schema.NodeRelationship.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.schema.NodeRelationship.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.schema.NodeRelationship.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.schema.NodeRelationship.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.schema.NodeRelationship.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.NodeRelationship.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.schema.NodeRelationship.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.schema.NodeRelationship.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.schema.NodeRelationship.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.schema.NodeRelationship.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.schema.NodeRelationship.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.schema.NodeRelationship.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.schema.NodeRelationship.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.NodeRelationship.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.NodeRelationship.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.NodeRelationship.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.schema.NodeRelationship.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.NodeRelationship.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.schema.NodeRelationship.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.NodeRelationship.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.schema.NodeRelationship.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.schema.NodeRelationship.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.schema.NodeRelationship.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.schema.NodeRelationship.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.schema.NodeRelationship.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.schema.NodeRelationship.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.schema.NodeRelationship.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.schema.NodeRelationship.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*pydantic model* llama\_index.schema.NodeWithScore[](#llama_index.schema.NodeWithScore "Permalink to this definition")Show JSON schema
```
{ "title": "NodeWithScore", "description": "Base component object to capture class names.", "type": "object", "properties": { "node": { "$ref": "#/definitions/BaseNode" }, "score": { "title": "Score", "type": "number" } }, "required": [ "node" ], "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "RelatedNodeInfo": { "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ] }, "BaseNode": { "title": "BaseNode", "description": "Base node Object.\n\nGeneric abstract interface for retrievable nodes", "type": "object", "properties": { "id\_": { "title": "Id ", "description": "Unique ID of the node.", "type": "string" }, "embedding": { "title": "Embedding", "description": "Embedding of the node.", "type": "array", "items": { "type": "number" } }, "extra\_info": { "title": "Extra Info", "description": "A flat dictionary of metadata fields", "type": "object" }, "excluded\_embed\_metadata\_keys": { "title": "Excluded Embed Metadata Keys", "description": "Metadata keys that are excluded from text for the embed model.", "type": "array", "items": { "type": "string" } }, "excluded\_llm\_metadata\_keys": { "title": "Excluded Llm Metadata Keys", "description": "Metadata keys that are excluded from text for the LLM.", "type": "array", "items": { "type": "string" } }, "relationships": { "title": "Relationships", "description": "A mapping of relationships to other node information.", "type": "object", "additionalProperties": { "anyOf": [ { "$ref": "#/definitions/RelatedNodeInfo" }, { "type": "array", "items": { "$ref": "#/definitions/RelatedNodeInfo" } } ] } }, "hash": { "title": "Hash", "description": "Hash of the node content.", "default": "", "type": "string" } } } }}
```


Fields* [`node (llama\_index.schema.BaseNode)`](#llama_index.schema.NodeWithScore.node "llama_index.schema.NodeWithScore.node")
* [`score (Optional[float])`](#llama_index.schema.NodeWithScore.score "llama_index.schema.NodeWithScore.score")
*field* node*: [BaseNode](#llama_index.schema.BaseNode "llama_index.schema.BaseNode")* *[Required]*[](#llama_index.schema.NodeWithScore.node "Permalink to this definition")*field* score*: Optional[float]* *= None*[](#llama_index.schema.NodeWithScore.score "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.schema.NodeWithScore.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.NodeWithScore.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.NodeWithScore.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.NodeWithScore.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.NodeWithScore.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.NodeWithScore.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.NodeWithScore.from_orm "Permalink to this definition")get\_content(*metadata\_mode: [MetadataMode](#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.NONE*) → str[](#llama_index.schema.NodeWithScore.get_content "Permalink to this definition")get\_embedding() → List[float][](#llama_index.schema.NodeWithScore.get_embedding "Permalink to this definition")get\_score(*raise\_error: bool = False*) → float[](#llama_index.schema.NodeWithScore.get_score "Permalink to this definition")Get score.

get\_text() → str[](#llama_index.schema.NodeWithScore.get_text "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.NodeWithScore.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.NodeWithScore.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.NodeWithScore.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.NodeWithScore.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.NodeWithScore.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.NodeWithScore.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.NodeWithScore.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.NodeWithScore.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.NodeWithScore.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.NodeWithScore.validate "Permalink to this definition")*property* embedding*: Optional[List[float]]*[](#llama_index.schema.NodeWithScore.embedding "Permalink to this definition")*property* id\_*: str*[](#llama_index.schema.NodeWithScore.id_ "Permalink to this definition")*property* metadata*: Dict[str, Any]*[](#llama_index.schema.NodeWithScore.metadata "Permalink to this definition")*property* node\_id*: str*[](#llama_index.schema.NodeWithScore.node_id "Permalink to this definition")*property* text*: str*[](#llama_index.schema.NodeWithScore.text "Permalink to this definition")*class* llama\_index.schema.ObjectType(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.schema.ObjectType "Permalink to this definition")capitalize()[](#llama_index.schema.ObjectType.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.schema.ObjectType.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.schema.ObjectType.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.ObjectType.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.schema.ObjectType.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.schema.ObjectType.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.schema.ObjectType.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.ObjectType.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.schema.ObjectType.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.schema.ObjectType.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.ObjectType.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.schema.ObjectType.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.schema.ObjectType.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.schema.ObjectType.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.schema.ObjectType.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.schema.ObjectType.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.schema.ObjectType.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.schema.ObjectType.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.schema.ObjectType.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.schema.ObjectType.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.schema.ObjectType.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.schema.ObjectType.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.schema.ObjectType.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.schema.ObjectType.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.ObjectType.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.schema.ObjectType.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.schema.ObjectType.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.schema.ObjectType.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.schema.ObjectType.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.schema.ObjectType.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.schema.ObjectType.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.schema.ObjectType.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.ObjectType.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.schema.ObjectType.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.schema.ObjectType.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.schema.ObjectType.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.ObjectType.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.schema.ObjectType.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.schema.ObjectType.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.schema.ObjectType.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.schema.ObjectType.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.schema.ObjectType.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.schema.ObjectType.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.schema.ObjectType.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.schema.ObjectType.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.schema.ObjectType.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.schema.ObjectType.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*pydantic model* llama\_index.schema.RelatedNodeInfo[](#llama_index.schema.RelatedNodeInfo "Permalink to this definition")Show JSON schema
```
{ "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ], "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" } }}
```


Fields* [`hash (Optional[str])`](#llama_index.schema.RelatedNodeInfo.hash "llama_index.schema.RelatedNodeInfo.hash")
* [`metadata (Dict[str, Any])`](#llama_index.schema.RelatedNodeInfo.metadata "llama_index.schema.RelatedNodeInfo.metadata")
* [`node\_id (str)`](#llama_index.schema.RelatedNodeInfo.node_id "llama_index.schema.RelatedNodeInfo.node_id")
* [`node\_type (Optional[llama\_index.schema.ObjectType])`](#llama_index.schema.RelatedNodeInfo.node_type "llama_index.schema.RelatedNodeInfo.node_type")
*field* hash*: Optional[str]* *= None*[](#llama_index.schema.RelatedNodeInfo.hash "Permalink to this definition")*field* metadata*: Dict[str, Any]* *[Optional]*[](#llama_index.schema.RelatedNodeInfo.metadata "Permalink to this definition")*field* node\_id*: str* *[Required]*[](#llama_index.schema.RelatedNodeInfo.node_id "Permalink to this definition")*field* node\_type*: Optional[[ObjectType](#llama_index.schema.ObjectType "llama_index.schema.ObjectType")]* *= None*[](#llama_index.schema.RelatedNodeInfo.node_type "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.schema.RelatedNodeInfo.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.schema.RelatedNodeInfo.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.schema.RelatedNodeInfo.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.schema.RelatedNodeInfo.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.RelatedNodeInfo.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.schema.RelatedNodeInfo.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.schema.RelatedNodeInfo.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.RelatedNodeInfo.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.RelatedNodeInfo.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.schema.RelatedNodeInfo.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.schema.RelatedNodeInfo.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.schema.RelatedNodeInfo.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.schema.RelatedNodeInfo.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.schema.RelatedNodeInfo.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.schema.RelatedNodeInfo.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.schema.RelatedNodeInfo.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.schema.RelatedNodeInfo.validate "Permalink to this definition")