Data Connectors[](#data-connectors "Permalink to this heading")
================================================================

NOTE: Our data connectors are now offered through [LlamaHub](https://llamahub.ai/) 🦙.LlamaHub is an open-source repository containing data loaders that you can easily plug and play into any LlamaIndex application.

The following data connectors are still available in the core repo.

Data Connectors for LlamaIndex.

This module contains the data connectors for LlamaIndex. Each connector inheritsfrom a BaseReader class, connects to a data source, and loads Document objectsfrom that data source.

You may also choose to construct Document objects manually, for instancein our [Insert How-To Guide](../how_to/insert.html). See below for the APIdefinition of a Document - the bare minimum is a text property.

*class* llama\_index.readers.BagelReader(*collection\_name: str*)[](#llama_index.readers.BagelReader "Permalink to this definition")Reader for Bagel files.

create\_documents(*results: Any*) → Any[](#llama_index.readers.BagelReader.create_documents "Permalink to this definition")Create documents from the results.

Parameters**results** – Results from the query.

ReturnsList of documents.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.BagelReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query\_vector: Optional[Union[Sequence[float], Sequence[int], List[Union[Sequence[float], Sequence[int]]]]] = None*, *query\_texts: Optional[Union[str, List[str]]] = None*, *limit: int = 10*, *where: Optional[Dict[Union[str, Literal['$and', '$or']], Union[str, int, float, Dict[Union[Literal['$gt', '$gte', '$lt', '$lte', '$ne', '$eq'], Literal['$and', '$or']], Union[str, int, float]], List[Dict[Union[str, Literal['$and', '$or']], Union[str, int, float, Dict[Union[Literal['$gt', '$gte', '$lt', '$lte', '$ne', '$eq'], Literal['$and', '$or']], Union[str, int, float]], List[Where]]]]]]] = None*, *where\_document: Optional[Dict[Union[Literal['$contains'], Literal['$and', '$or']], Union[str, List[Dict[Union[Literal['$contains'], Literal['$and', '$or']], Union[str, List[WhereDocument]]]]]]] = None*, *include: List[Literal['documents', 'embeddings', 'metadatas', 'distances']] = ['metadatas', 'documents', 'embeddings', 'distances']*) → Any[](#llama_index.readers.BagelReader.load_data "Permalink to this definition")Get the top n\_results documents for provided query\_embeddings or query\_texts.

Parameters* **query\_embeddings** – The embeddings to get the closes neighbors of. Optional.
* **query\_texts** – The document texts to get the closes neighbors of. Optional.
* **n\_results** – The number of neighbors to return for each query. Optional.
* **where** – A Where type dict used to filter results by. Optional.
* **where\_document** – A WhereDocument type dict used to filter. Optional.
* **include** – A list of what to include in the results. Optional.
ReturnsLlama Index Document(s) with the closest embeddings to thequery\_embeddings or query\_texts.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.BagelReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.BeautifulSoupWebReader[](#llama_index.readers.BeautifulSoupWebReader "Permalink to this definition")BeautifulSoup web page reader.

Reads pages from the web.Requires the bs4 and urllib packages.

Parameters**website\_extractor** (*Optional**[**Dict**[**str**,* *Callable**]**]*) – A mapping of websitehostname (e.g. google.com) to a function that specifies how toextract text from the BeautifulSoup obj. See DEFAULT\_WEBSITE\_EXTRACTOR.

Show JSON schema
```
{ "title": "BeautifulSoupWebReader", "description": "BeautifulSoup web page reader.\n\nReads pages from the web.\nRequires the `bs4` and `urllib` packages.\n\nArgs:\n website\_extractor (Optional[Dict[str, Callable]]): A mapping of website\n hostname (e.g. google.com) to a function that specifies how to\n extract text from the BeautifulSoup obj. See DEFAULT\_WEBSITE\_EXTRACTOR.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `is\_remote (bool)`
*field* is\_remote*: bool* *= True*[](#llama_index.readers.BeautifulSoupWebReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.BeautifulSoupWebReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.BeautifulSoupWebReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.BeautifulSoupWebReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.BeautifulSoupWebReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.BeautifulSoupWebReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.BeautifulSoupWebReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.BeautifulSoupWebReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.BeautifulSoupWebReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.BeautifulSoupWebReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*urls: List[str]*, *custom\_hostname: Optional[str] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.BeautifulSoupWebReader.load_data "Permalink to this definition")Load data from the urls.

Parameters* **urls** (*List**[**str**]*) – List of URLs to scrape.
* **custom\_hostname** (*Optional**[**str**]*) – Force a certain hostname in the casea website is displayed under custom URLs (e.g. Substack blogs)
ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.BeautifulSoupWebReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.BeautifulSoupWebReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.BeautifulSoupWebReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.BeautifulSoupWebReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.BeautifulSoupWebReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.BeautifulSoupWebReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.BeautifulSoupWebReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.BeautifulSoupWebReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.BeautifulSoupWebReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.BeautifulSoupWebReader.validate "Permalink to this definition")*class* llama\_index.readers.ChatGPTRetrievalPluginReader(*endpoint\_url: str*, *bearer\_token: Optional[str] = None*, *retries: Optional[Retry] = None*, *batch\_size: int = 100*)[](#llama_index.readers.ChatGPTRetrievalPluginReader "Permalink to this definition")ChatGPT Retrieval Plugin reader.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ChatGPTRetrievalPluginReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query: str*, *top\_k: int = 10*, *separate\_documents: bool = True*, *\*\*kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ChatGPTRetrievalPluginReader.load_data "Permalink to this definition")Load data from ChatGPT Retrieval Plugin.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.ChatGPTRetrievalPluginReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.ChromaReader(*collection\_name: str*, *persist\_directory: Optional[str] = None*, *chroma\_api\_impl: str = 'rest'*, *chroma\_db\_impl: Optional[str] = None*, *host: str = 'localhost'*, *port: int = 8000*)[](#llama_index.readers.ChromaReader "Permalink to this definition")Chroma reader.

Retrieve documents from existing persisted Chroma collections.

Parameters* **collection\_name** – Name of the persisted collection.
* **persist\_directory** – Directory where the collection is persisted.
create\_documents(*results: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ChromaReader.create_documents "Permalink to this definition")Create documents from the results.

Parameters**results** – Results from the query.

ReturnsList of documents.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ChromaReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query\_embedding: Optional[List[float]] = None*, *limit: int = 10*, *where: Optional[dict] = None*, *where\_document: Optional[dict] = None*, *query: Optional[Union[str, List[str]]] = None*) → Any[](#llama_index.readers.ChromaReader.load_data "Permalink to this definition")Load data from the collection.

Parameters* **limit** – Number of results to return.
* **where** – Filter results by metadata. {“metadata\_field”: “is\_equal\_to\_this”}
* **where\_document** – Filter results by document. {“$contains”:”search\_string”}
ReturnsList of documents.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.ChromaReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.DashVectorReader(*api\_key: str*)[](#llama_index.readers.DashVectorReader "Permalink to this definition")DashVector reader.

Parameters**api\_key** (*str*) – DashVector API key.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DashVectorReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*collection\_name: str*, *id\_to\_text\_map: Dict[str, str]*, *vector: Optional[List[float]]*, *top\_k: int*, *separate\_documents: bool = True*, *filter: Optional[str] = None*, *include\_vector: bool = True*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DashVectorReader.load_data "Permalink to this definition")Load data from DashVector.

Parameters* **collection\_name** (*str*) – Name of the collection.
* **id\_to\_text\_map** (*Dict**[**str**,* *str**]*) – A map from ID’s to text.
* **separate\_documents** (*Optional**[**bool**]*) – Whether to return separatedocuments per retrieved entry. Defaults to True.
* **vector** (*List**[**float**]*) – Query vector.
* **top\_k** (*int*) – Number of results to return.
* **filter** (*Optional**[**str**]*) – doc fields filter conditions that meet the SQLwhere clause specification.
* **include\_vector** (*bool*) – Whether to include the embedding in the response.Defaults to True.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.DashVectorReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.DeepLakeReader(*token: Optional[str] = None*)[](#llama_index.readers.DeepLakeReader "Permalink to this definition")DeepLake reader.

Retrieve documents from existing DeepLake datasets.

Parameters**dataset\_name** – Name of the deeplake dataset.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DeepLakeReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query\_vector: List[float]*, *dataset\_path: str*, *limit: int = 4*, *distance\_metric: str = 'l2'*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DeepLakeReader.load_data "Permalink to this definition")Load data from DeepLake.

Parameters* **dataset\_name** (*str*) – Name of the DeepLake dataset.
* **query\_vector** (*List**[**float**]*) – Query vector.
* **limit** (*int*) – Number of results to return.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.DeepLakeReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.DiscordReader[](#llama_index.readers.DiscordReader "Permalink to this definition")Discord reader.

Reads conversations from channels.

Parameters**discord\_token** (*Optional**[**str**]*) – Discord token. If not provided, weassume the environment variable DISCORD\_TOKEN is set.

Show JSON schema
```
{ "title": "DiscordReader", "description": "Discord reader.\n\nReads conversations from channels.\n\nArgs:\n discord\_token (Optional[str]): Discord token. If not provided, we\n assume the environment variable `DISCORD\_TOKEN` is set.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "discord\_token": { "title": "Discord Token", "type": "string" } }, "required": [ "discord\_token" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `discord\_token (str)`
* `is\_remote (bool)`
*field* discord\_token*: str* *[Required]*[](#llama_index.readers.DiscordReader.discord_token "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.DiscordReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.DiscordReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.DiscordReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.DiscordReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.DiscordReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.DiscordReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.DiscordReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.DiscordReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.DiscordReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DiscordReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*channel\_ids: List[int]*, *limit: Optional[int] = None*, *oldest\_first: bool = True*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.DiscordReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters* **channel\_ids** (*List**[**int**]*) – List of channel ids to read.
* **limit** (*Optional**[**int**]*) – Maximum number of messages to read.
* **oldest\_first** (*bool*) – Whether to read oldest messages first.Defaults to True.
ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.DiscordReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.DiscordReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.DiscordReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.DiscordReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.DiscordReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.DiscordReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.DiscordReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.DiscordReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.DiscordReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.DiscordReader.validate "Permalink to this definition")*pydantic model* llama\_index.readers.Document[](#llama_index.readers.Document "Permalink to this definition")Generic interface for a data document.

This document connects to data sources.

Show JSON schema
```
{ "title": "Document", "description": "Generic interface for a data document.\n\nThis document connects to data sources.", "type": "object", "properties": { "doc\_id": { "title": "Doc Id", "description": "Unique ID of the node.", "type": "string" }, "embedding": { "title": "Embedding", "description": "Embedding of the node.", "type": "array", "items": { "type": "number" } }, "extra\_info": { "title": "Extra Info", "description": "A flat dictionary of metadata fields", "type": "object" }, "excluded\_embed\_metadata\_keys": { "title": "Excluded Embed Metadata Keys", "description": "Metadata keys that are excluded from text for the embed model.", "type": "array", "items": { "type": "string" } }, "excluded\_llm\_metadata\_keys": { "title": "Excluded Llm Metadata Keys", "description": "Metadata keys that are excluded from text for the LLM.", "type": "array", "items": { "type": "string" } }, "relationships": { "title": "Relationships", "description": "A mapping of relationships to other node information.", "type": "object", "additionalProperties": { "anyOf": [ { "$ref": "#/definitions/RelatedNodeInfo" }, { "type": "array", "items": { "$ref": "#/definitions/RelatedNodeInfo" } } ] } }, "hash": { "title": "Hash", "description": "Hash of the node content.", "default": "", "type": "string" }, "text": { "title": "Text", "description": "Text content of the node.", "default": "", "type": "string" }, "start\_char\_idx": { "title": "Start Char Idx", "description": "Start char index of the node.", "type": "integer" }, "end\_char\_idx": { "title": "End Char Idx", "description": "End char index of the node.", "type": "integer" }, "text\_template": { "title": "Text Template", "description": "Template for how text is formatted, with {content} and {metadata\_str} placeholders.", "default": "{metadata\_str}\n\n{content}", "type": "string" }, "metadata\_template": { "title": "Metadata Template", "description": "Template for how metadata is formatted, with {key} and {value} placeholders.", "default": "{key}: {value}", "type": "string" }, "metadata\_seperator": { "title": "Metadata Seperator", "description": "Separator between metadata fields when converting to string.", "default": "\n", "type": "string" } }, "definitions": { "ObjectType": { "title": "ObjectType", "description": "An enumeration.", "enum": [ "1", "2", "3", "4" ], "type": "string" }, "RelatedNodeInfo": { "title": "RelatedNodeInfo", "description": "Base component object to capture class names.", "type": "object", "properties": { "node\_id": { "title": "Node Id", "type": "string" }, "node\_type": { "$ref": "#/definitions/ObjectType" }, "metadata": { "title": "Metadata", "type": "object" }, "hash": { "title": "Hash", "type": "string" } }, "required": [ "node\_id" ] } }}
```


Config* **allow\_population\_by\_field\_name**: *bool = True*
Fields* [`embedding (Optional[List[float]])`](node.html#llama_index.schema.Document.embedding "llama_index.schema.Document.embedding")
* [`end\_char\_idx (Optional[int])`](node.html#llama_index.schema.Document.end_char_idx "llama_index.schema.Document.end_char_idx")
* [`excluded\_embed\_metadata\_keys (List[str])`](node.html#llama_index.schema.Document.excluded_embed_metadata_keys "llama_index.schema.Document.excluded_embed_metadata_keys")
* [`excluded\_llm\_metadata\_keys (List[str])`](node.html#llama_index.schema.Document.excluded_llm_metadata_keys "llama_index.schema.Document.excluded_llm_metadata_keys")
* [`hash (str)`](node.html#llama_index.schema.Document.hash "llama_index.schema.Document.hash")
* [`id\_ (str)`](node.html#llama_index.schema.Document.id_ "llama_index.schema.Document.id_")
* [`metadata (Dict[str, Any])`](node.html#llama_index.schema.Document.metadata "llama_index.schema.Document.metadata")
* [`metadata\_seperator (str)`](node.html#llama_index.schema.Document.metadata_seperator "llama_index.schema.Document.metadata_seperator")
* [`metadata\_template (str)`](node.html#llama_index.schema.Document.metadata_template "llama_index.schema.Document.metadata_template")
* [`relationships (Dict[llama\_index.schema.NodeRelationship, Union[llama\_index.schema.RelatedNodeInfo, List[llama\_index.schema.RelatedNodeInfo]]])`](node.html#llama_index.schema.Document.relationships "llama_index.schema.Document.relationships")
* [`start\_char\_idx (Optional[int])`](node.html#llama_index.schema.Document.start_char_idx "llama_index.schema.Document.start_char_idx")
* [`text (str)`](node.html#llama_index.schema.Document.text "llama_index.schema.Document.text")
* [`text\_template (str)`](node.html#llama_index.schema.Document.text_template "llama_index.schema.Document.text_template")
*field* embedding*: Optional[List[float]]* *= None*[](#llama_index.readers.Document.embedding "Permalink to this definition")”metadata fields- injected as part of the text shown to LLMs as context- injected as part of the text for generating embeddings- used by vector DBs for metadata filtering

Embedding of the node.

Validated by* `\_check\_hash`
*field* end\_char\_idx*: Optional[int]* *= None*[](#llama_index.readers.Document.end_char_idx "Permalink to this definition")End char index of the node.

Validated by* `\_check\_hash`
*field* excluded\_embed\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.readers.Document.excluded_embed_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the embed model.

Validated by* `\_check\_hash`
*field* excluded\_llm\_metadata\_keys*: List[str]* *[Optional]*[](#llama_index.readers.Document.excluded_llm_metadata_keys "Permalink to this definition")Metadata keys that are excluded from text for the LLM.

Validated by* `\_check\_hash`
*field* hash*: str* *= ''*[](#llama_index.readers.Document.hash "Permalink to this definition")Hash of the node content.

Validated by* `\_check\_hash`
*field* id\_*: str* *[Optional]* *(alias 'doc\_id')*[](#llama_index.readers.Document.id_ "Permalink to this definition")Unique ID of the node.

Validated by* `\_check\_hash`
*field* metadata*: Dict[str, Any]* *[Optional]* *(alias 'extra\_info')*[](#llama_index.readers.Document.metadata "Permalink to this definition")A flat dictionary of metadata fields

Validated by* `\_check\_hash`
*field* metadata\_seperator*: str* *= '\n'*[](#llama_index.readers.Document.metadata_seperator "Permalink to this definition")Separator between metadata fields when converting to string.

Validated by* `\_check\_hash`
*field* metadata\_template*: str* *= '{key}: {value}'*[](#llama_index.readers.Document.metadata_template "Permalink to this definition")Template for how metadata is formatted, with {key} and {value} placeholders.

Validated by* `\_check\_hash`
*field* relationships*: Dict[[NodeRelationship](node.html#llama_index.schema.NodeRelationship "llama_index.schema.NodeRelationship"), Union[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo"), List[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]]* *[Optional]*[](#llama_index.readers.Document.relationships "Permalink to this definition")A mapping of relationships to other node information.

Validated by* `\_check\_hash`
*field* start\_char\_idx*: Optional[int]* *= None*[](#llama_index.readers.Document.start_char_idx "Permalink to this definition")Start char index of the node.

Validated by* `\_check\_hash`
*field* text*: str* *= ''*[](#llama_index.readers.Document.text "Permalink to this definition")Text content of the node.

Validated by* `\_check\_hash`
*field* text\_template*: str* *= '{metadata\_str}\n\n{content}'*[](#llama_index.readers.Document.text_template "Permalink to this definition")Template for how text is formatted, with {content} and {metadata\_str} placeholders.

Validated by* `\_check\_hash`
as\_related\_node\_info() → [RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")[](#llama_index.readers.Document.as_related_node_info "Permalink to this definition")Get node as RelatedNodeInfo.

*classmethod* class\_name() → str[](#llama_index.readers.Document.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.Document.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.Document.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.Document.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* example() → [Document](node.html#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.readers.Document.example "Permalink to this definition")*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.Document.from_dict "Permalink to this definition")*classmethod* from\_embedchain\_format(*doc: Dict[str, Any]*) → [Document](node.html#llama_index.schema.Document "llama_index.schema.Document")[](#llama_index.readers.Document.from_embedchain_format "Permalink to this definition")Convert struct from EmbedChain document format.

*classmethod* from\_haystack\_format(*doc: HaystackDocument*) → [Document](#llama_index.readers.Document "llama_index.readers.Document")[](#llama_index.readers.Document.from_haystack_format "Permalink to this definition")Convert struct from Haystack document format.

*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.Document.from_json "Permalink to this definition")*classmethod* from\_langchain\_format(*doc: LCDocument*) → [Document](#llama_index.readers.Document "llama_index.readers.Document")[](#llama_index.readers.Document.from_langchain_format "Permalink to this definition")Convert struct from LangChain document format.

*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.Document.from_orm "Permalink to this definition")*classmethod* from\_semantic\_kernel\_format(*doc: MemoryRecord*) → [Document](#llama_index.readers.Document "llama_index.readers.Document")[](#llama_index.readers.Document.from_semantic_kernel_format "Permalink to this definition")Convert struct from Semantic Kernel document format.

get\_content(*metadata\_mode: [MetadataMode](node.html#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.NONE*) → str[](#llama_index.readers.Document.get_content "Permalink to this definition")Get object content.

get\_doc\_id() → str[](#llama_index.readers.Document.get_doc_id "Permalink to this definition")TODO: Deprecated: Get document ID.

get\_embedding() → List[float][](#llama_index.readers.Document.get_embedding "Permalink to this definition")Get embedding.

Errors if embedding is None.

get\_metadata\_str(*mode: [MetadataMode](node.html#llama_index.schema.MetadataMode "llama_index.schema.MetadataMode") = MetadataMode.ALL*) → str[](#llama_index.readers.Document.get_metadata_str "Permalink to this definition")Metadata info string.

get\_node\_info() → Dict[str, Any][](#llama_index.readers.Document.get_node_info "Permalink to this definition")Get node info.

get\_text() → str[](#llama_index.readers.Document.get_text "Permalink to this definition")*classmethod* get\_type() → str[](#llama_index.readers.Document.get_type "Permalink to this definition")Get Document type.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.Document.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.Document.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.Document.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.Document.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.Document.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.Document.schema_json "Permalink to this definition")set\_content(*value: str*) → None[](#llama_index.readers.Document.set_content "Permalink to this definition")Set the content of the node.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.Document.to_dict "Permalink to this definition")to\_embedchain\_format() → Dict[str, Any][](#llama_index.readers.Document.to_embedchain_format "Permalink to this definition")Convert struct to EmbedChain document format.

to\_haystack\_format() → HaystackDocument[](#llama_index.readers.Document.to_haystack_format "Permalink to this definition")Convert struct to Haystack document format.

to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.Document.to_json "Permalink to this definition")to\_langchain\_format() → LCDocument[](#llama_index.readers.Document.to_langchain_format "Permalink to this definition")Convert struct to LangChain document format.

to\_semantic\_kernel\_format() → MemoryRecord[](#llama_index.readers.Document.to_semantic_kernel_format "Permalink to this definition")Convert struct to Semantic Kernel document format.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.Document.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.Document.validate "Permalink to this definition")*property* child\_nodes*: Optional[List[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]]*[](#llama_index.readers.Document.child_nodes "Permalink to this definition")Child nodes.

*property* doc\_id*: str*[](#llama_index.readers.Document.doc_id "Permalink to this definition")Get document ID.

*property* extra\_info*: Dict[str, Any]*[](#llama_index.readers.Document.extra_info "Permalink to this definition")Extra info.

TypeTODO

TypeDEPRECATED

*property* next\_node*: Optional[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.readers.Document.next_node "Permalink to this definition")Next node.

*property* node\_id*: str*[](#llama_index.readers.Document.node_id "Permalink to this definition")*property* node\_info*: Dict[str, Any]*[](#llama_index.readers.Document.node_info "Permalink to this definition")Get node info.

TypeDeprecated

*property* parent\_node*: Optional[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.readers.Document.parent_node "Permalink to this definition")Parent node.

*property* prev\_node*: Optional[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.readers.Document.prev_node "Permalink to this definition")Prev node.

*property* ref\_doc\_id*: Optional[str]*[](#llama_index.readers.Document.ref_doc_id "Permalink to this definition")Get ref doc id.

TypeDeprecated

*property* source\_node*: Optional[[RelatedNodeInfo](node.html#llama_index.schema.RelatedNodeInfo "llama_index.schema.RelatedNodeInfo")]*[](#llama_index.readers.Document.source_node "Permalink to this definition")Source object node.

Extracted from the relationships field.

*pydantic model* llama\_index.readers.ElasticsearchReader[](#llama_index.readers.ElasticsearchReader "Permalink to this definition")Read documents from an Elasticsearch/Opensearch index.

These documents can then be used in a downstream Llama Index data structure.

Parameters* **endpoint** (*str*) – URL (http/https) of cluster
* **index** (*str*) – Name of the index (required)
* **httpx\_client\_args** (*dict*) – Optional additional args to pass to the httpx.Client
Show JSON schema
```
{ "title": "ElasticsearchReader", "description": "Read documents from an Elasticsearch/Opensearch index.\n\nThese documents can then be used in a downstream Llama Index data structure.\n\nArgs:\n endpoint (str): URL (http/https) of cluster\n index (str): Name of the index (required)\n httpx\_client\_args (dict): Optional additional args to pass to the `httpx.Client`", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "endpoint": { "title": "Endpoint", "type": "string" }, "index": { "title": "Index", "type": "string" }, "httpx\_client\_args": { "title": "Httpx Client Args", "type": "object" } }, "required": [ "endpoint", "index" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `endpoint (str)`
* `httpx\_client\_args (Optional[dict])`
* `index (str)`
* `is\_remote (bool)`
*field* endpoint*: str* *[Required]*[](#llama_index.readers.ElasticsearchReader.endpoint "Permalink to this definition")*field* httpx\_client\_args*: Optional[dict]* *= None*[](#llama_index.readers.ElasticsearchReader.httpx_client_args "Permalink to this definition")*field* index*: str* *[Required]*[](#llama_index.readers.ElasticsearchReader.index "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.ElasticsearchReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.ElasticsearchReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.ElasticsearchReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.ElasticsearchReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.ElasticsearchReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.ElasticsearchReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.ElasticsearchReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.ElasticsearchReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.ElasticsearchReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ElasticsearchReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*field: str*, *query: Optional[dict] = None*, *embedding\_field: Optional[str] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ElasticsearchReader.load_data "Permalink to this definition")Read data from the Elasticsearch index.

Parameters* **field** (*str*) – Field in the document to retrieve text from
* **query** (*Optional**[**dict**]*) – Elasticsearch JSON query DSL object.For example:{“query”: {“match”: {“message”: {“query”: “this is a test”}}}}
* **embedding\_field** (*Optional**[**str**]*) – If there are embeddings stored inthis index, this field can be usedto set the embedding field on the returned Document list.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.ElasticsearchReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.ElasticsearchReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.ElasticsearchReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.ElasticsearchReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.ElasticsearchReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.ElasticsearchReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.ElasticsearchReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.ElasticsearchReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.ElasticsearchReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.ElasticsearchReader.validate "Permalink to this definition")*class* llama\_index.readers.FaissReader(*index: Any*)[](#llama_index.readers.FaissReader "Permalink to this definition")Faiss reader.

Retrieves documents through an existing in-memory Faiss index.These documents can then be used in a downstream LlamaIndex data structure.If you wish use Faiss itself as an index to to organize documents,insert documents, and perform queries on them, please use VectorStoreIndexwith FaissVectorStore.

Parameters**faiss\_index** (*faiss.Index*) – A Faiss Index object (required)

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.FaissReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query: ndarray*, *id\_to\_text\_map: Dict[str, str]*, *k: int = 4*, *separate\_documents: bool = True*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.FaissReader.load_data "Permalink to this definition")Load data from Faiss.

Parameters* **query** (*np.ndarray*) – A 2D numpy array of query vectors.
* **id\_to\_text\_map** (*Dict**[**str**,* *str**]*) – A map from ID’s to text.
* **k** (*int*) – Number of nearest neighbors to retrieve. Defaults to 4.
* **separate\_documents** (*Optional**[**bool**]*) – Whether to return separatedocuments. Defaults to True.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.FaissReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.GithubRepositoryReader(*owner: str*, *repo: str*, *use\_parser: bool = True*, *verbose: bool = False*, *github\_token: Optional[str] = None*, *concurrent\_requests: int = 5*, *ignore\_file\_extensions: Optional[List[str]] = None*, *ignore\_directories: Optional[List[str]] = None*)[](#llama_index.readers.GithubRepositoryReader "Permalink to this definition")Github repository reader.

Retrieves the contents of a Github repository and returns a list of documents.The documents are either the contents of the files in the repository or the textextracted from the files using the parser.

Examples


```
>>> reader = GithubRepositoryReader("owner", "repo")>>> branch\_documents = reader.load\_data(branch="branch")>>> commit\_documents = reader.load\_data(commit\_sha="commit\_sha")
```
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.GithubRepositoryReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*commit\_sha: Optional[str] = None*, *branch: Optional[str] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.GithubRepositoryReader.load_data "Permalink to this definition")Load data from a commit or a branch.

Loads github repository data from a specific commit sha or a branch.

Parameters* **commit** – commit sha
* **branch** – branch name
Returnslist of documents

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.GithubRepositoryReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.GoogleDocsReader[](#llama_index.readers.GoogleDocsReader "Permalink to this definition")Google Docs reader.

Reads a page from Google Docs

Show JSON schema
```
{ "title": "GoogleDocsReader", "description": "Google Docs reader.\n\nReads a page from Google Docs", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `is\_remote (bool)`
*field* is\_remote*: bool* *= True*[](#llama_index.readers.GoogleDocsReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.GoogleDocsReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.GoogleDocsReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.GoogleDocsReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.GoogleDocsReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.GoogleDocsReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.GoogleDocsReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.GoogleDocsReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.GoogleDocsReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.GoogleDocsReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*document\_ids: List[str]*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.GoogleDocsReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters**document\_ids** (*List**[**str**]*) – a list of document ids.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.GoogleDocsReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.GoogleDocsReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.GoogleDocsReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.GoogleDocsReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.GoogleDocsReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.GoogleDocsReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.GoogleDocsReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.GoogleDocsReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.GoogleDocsReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.GoogleDocsReader.validate "Permalink to this definition")*class* llama\_index.readers.HTMLTagReader(*tag: str = 'section'*, *ignore\_no\_id: bool = False*)[](#llama_index.readers.HTMLTagReader "Permalink to this definition")Read HTML files and extract text from a specific tag with BeautifulSoup.

By default, reads the text from the `<section>` tag.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.HTMLTagReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*file: Path*, *extra\_info: Optional[Dict] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.HTMLTagReader.load_data "Permalink to this definition")Load data from the input directory.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.HTMLTagReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.JSONReader(*levels\_back: Optional[int] = None*, *collapse\_length: Optional[int] = None*, *ensure\_ascii: bool = False*)[](#llama_index.readers.JSONReader "Permalink to this definition")JSON reader.

Reads JSON documents with options to help suss out relationships between nodes.

Parameters* **levels\_back** (*int*) – the number of levels to go back in the JSON tree, 0if you want all levels. If levels\_back is None, then we just format theJSON and make each line an embedding
* **collapse\_length** (*int*) – the maximum number of characters a JSON fragmentwould be collapsed in the output (levels\_back needs to be not None)ex: if collapse\_length = 10, andinput is {a: [1, 2, 3], b: {“hello”: “world”, “foo”: “bar”}}then a would be collapsed into one line, while b would not.Recommend starting around 100 and then adjusting from there.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.JSONReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*input\_file: str*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.JSONReader.load_data "Permalink to this definition")Load data from the input file.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.JSONReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.MakeWrapper[](#llama_index.readers.MakeWrapper "Permalink to this definition")Make reader.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MakeWrapper.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MakeWrapper.load_data "Permalink to this definition")Load data from the input directory.

NOTE: This is not implemented.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.MakeWrapper.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

pass\_response\_to\_webhook(*webhook\_url: str*, *response: [Response](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")*, *query: Optional[str] = None*) → None[](#llama_index.readers.MakeWrapper.pass_response_to_webhook "Permalink to this definition")Pass response object to webhook.

Parameters* **webhook\_url** (*str*) – Webhook URL.
* **response** ([*Response*](response.html#llama_index.response.schema.Response "llama_index.response.schema.Response")) – Response object.
* **query** (*Optional**[**str**]*) – Query. Defaults to None.
*class* llama\_index.readers.MboxReader[](#llama_index.readers.MboxReader "Permalink to this definition")Mbox e-mail reader.

Reads a set of e-mails saved in the mbox format.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MboxReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*input\_dir: str*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MboxReader.load_data "Permalink to this definition")Load data from the input directory.

load\_kwargs:max\_count (int): Maximum amount of messages to read.message\_format (str): Message format overriding default.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.MboxReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.MetalReader(*api\_key: str*, *client\_id: str*, *index\_id: str*)[](#llama_index.readers.MetalReader "Permalink to this definition")Metal reader.

Parameters* **api\_key** (*str*) – Metal API key.
* **client\_id** (*str*) – Metal client ID.
* **index\_id** (*str*) – Metal index ID.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MetalReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*limit: int*, *query\_embedding: Optional[List[float]] = None*, *filters: Optional[Dict[str, Any]] = None*, *separate\_documents: bool = True*, *\*\*query\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MetalReader.load_data "Permalink to this definition")Load data from Metal.

Parameters* **query\_embedding** (*Optional**[**List**[**float**]**]*) – Query embedding for search.
* **limit** (*int*) – Number of results to return.
* **filters** (*Optional**[**Dict**[**str**,* *Any**]**]*) – Filters to apply to the search.
* **separate\_documents** (*Optional**[**bool**]*) – Whether to return separatedocuments per retrieved entry. Defaults to True.
* **\*\*query\_kwargs** – Keyword arguments to pass to the search.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.MetalReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.MilvusReader(*host: str = 'localhost'*, *port: int = 19530*, *user: str = ''*, *password: str = ''*, *use\_secure: bool = False*)[](#llama_index.readers.MilvusReader "Permalink to this definition")Milvus reader.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MilvusReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query\_vector: List[float]*, *collection\_name: str*, *expr: Any = None*, *search\_params: Optional[dict] = None*, *limit: int = 10*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MilvusReader.load_data "Permalink to this definition")Load data from Milvus.

Parameters* **collection\_name** (*str*) – Name of the Milvus collection.
* **query\_vector** (*List**[**float**]*) – Query vector.
* **limit** (*int*) – Number of results to return.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.MilvusReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.MyScaleReader(*myscale\_host: str*, *username: str*, *password: str*, *myscale\_port: Optional[int] = 8443*, *database: str = 'default'*, *table: str = 'llama\_index'*, *index\_type: str = 'IVFLAT'*, *metric: str = 'cosine'*, *batch\_size: int = 32*, *index\_params: Optional[dict] = None*, *search\_params: Optional[dict] = None*, *\*\*kwargs: Any*)[](#llama_index.readers.MyScaleReader "Permalink to this definition")MyScale reader.

Parameters* **myscale\_host** (*str*) – An URL to connect to MyScale backend.
* **username** (*str*) – Usernamed to login.
* **password** (*str*) – Password to login.
* **myscale\_port** (*int*) – URL port to connect with HTTP. Defaults to 8443.
* **database** (*str*) – Database name to find the table. Defaults to ‘default’.
* **table** (*str*) – Table name to operate on. Defaults to ‘vector\_table’.
* **index\_type** (*str*) – index type string. Default to “IVFLAT”
* **metric** (*str*) – Metric to compute distance, supported are (‘l2’, ‘cosine’, ‘ip’).Defaults to ‘cosine’
* **batch\_size** (*int**,* *optional*) – the size of documents to insert. Defaults to 32.
* **index\_params** (*dict**,* *optional*) – The index parameters for MyScale.Defaults to None.
* **search\_params** (*dict**,* *optional*) – The search parameters for a MyScale query.Defaults to None.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MyScaleReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*query\_vector: List[float]*, *where\_str: Optional[str] = None*, *limit: int = 10*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.MyScaleReader.load_data "Permalink to this definition")Load data from MyScale.

Parameters* **query\_vector** (*List**[**float**]*) – Query vector.
* **where\_str** (*Optional**[**str**]**,* *optional*) – where condition string.Defaults to None.
* **limit** (*int*) – Number of results to return.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.MyScaleReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.NotionPageReader[](#llama_index.readers.NotionPageReader "Permalink to this definition")Notion Page reader.

Reads a set of Notion pages.

Parameters**integration\_token** (*str*) – Notion integration token.

Show JSON schema
```
{ "title": "NotionPageReader", "description": "Notion Page reader.\n\nReads a set of Notion pages.\n\nArgs:\n integration\_token (str): Notion integration token.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "integration\_token": { "title": "Integration Token", "type": "string" }, "headers": { "title": "Headers", "type": "object", "additionalProperties": { "type": "string" } } }, "required": [ "integration\_token", "headers" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `headers (Dict[str, str])`
* `integration\_token (str)`
* `is\_remote (bool)`
*field* headers*: Dict[str, str]* *[Required]*[](#llama_index.readers.NotionPageReader.headers "Permalink to this definition")*field* integration\_token*: str* *[Required]*[](#llama_index.readers.NotionPageReader.integration_token "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.NotionPageReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.NotionPageReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.NotionPageReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.NotionPageReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.NotionPageReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.NotionPageReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.NotionPageReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.NotionPageReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.NotionPageReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.NotionPageReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*page\_ids: List[str] = []*, *database\_id: Optional[str] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.NotionPageReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters**page\_ids** (*List**[**str**]*) – List of page ids to load.

ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.NotionPageReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.NotionPageReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.NotionPageReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.NotionPageReader.parse_raw "Permalink to this definition")query\_database(*database\_id: str*, *query\_dict: Dict[str, Any] = {}*) → List[str][](#llama_index.readers.NotionPageReader.query_database "Permalink to this definition")Get all the pages from a Notion database.

read\_page(*page\_id: str*) → str[](#llama_index.readers.NotionPageReader.read_page "Permalink to this definition")Read a page.

*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.NotionPageReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.NotionPageReader.schema_json "Permalink to this definition")search(*query: str*) → List[str][](#llama_index.readers.NotionPageReader.search "Permalink to this definition")Search Notion page given a text query.

to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.NotionPageReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.NotionPageReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.NotionPageReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.NotionPageReader.validate "Permalink to this definition")*class* llama\_index.readers.ObsidianReader(*input\_dir: str*)[](#llama_index.readers.ObsidianReader "Permalink to this definition")Utilities for loading data from an Obsidian Vault.

Parameters**input\_dir** (*str*) – Path to the vault.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ObsidianReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.ObsidianReader.load_data "Permalink to this definition")Load data from the input directory.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.ObsidianReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.PDFReader[](#llama_index.readers.PDFReader "Permalink to this definition")PDF parser.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PDFReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*file: Path*, *extra\_info: Optional[Dict] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PDFReader.load_data "Permalink to this definition")Parse file.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.PDFReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.PineconeReader(*api\_key: str*, *environment: str*)[](#llama_index.readers.PineconeReader "Permalink to this definition")Pinecone reader.

Parameters* **api\_key** (*str*) – Pinecone API key.
* **environment** (*str*) – Pinecone environment.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PineconeReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*index\_name: str*, *id\_to\_text\_map: Dict[str, str]*, *vector: Optional[List[float]]*, *top\_k: int*, *separate\_documents: bool = True*, *include\_values: bool = True*, *\*\*query\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PineconeReader.load_data "Permalink to this definition")Load data from Pinecone.

Parameters* **index\_name** (*str*) – Name of the index.
* **id\_to\_text\_map** (*Dict**[**str**,* *str**]*) – A map from ID’s to text.
* **separate\_documents** (*Optional**[**bool**]*) – Whether to return separatedocuments per retrieved entry. Defaults to True.
* **vector** (*List**[**float**]*) – Query vector.
* **top\_k** (*int*) – Number of results to return.
* **include\_values** (*bool*) – Whether to include the embedding in the response.Defaults to True.
* **\*\*query\_kwargs** – Keyword arguments to pass to the query.Arguments are the exact same as those found inPinecone’s reference documentation for thequery method.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.PineconeReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.PsychicReader(*psychic\_key: Optional[str] = None*)[](#llama_index.readers.PsychicReader "Permalink to this definition")Psychic reader.

Psychic is a platform that allows syncing data from many SaaS apps through oneuniversal API.

This reader connects to an instance of Psychic and reads data from it, given aconnector ID, account ID, and API key.

Learn more at docs.psychic.dev.

Parameters**psychic\_key** (*str*) – Secret key for Psychic.Get one at <https://dashboard.psychic.dev/api-keys>.

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PsychicReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*connector\_id: Optional[str] = None*, *account\_id: Optional[str] = None*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.PsychicReader.load_data "Permalink to this definition")Load data from a Psychic connection.

Parameters* **connector\_id** (*str*) – The connector ID to connect to
* **account\_id** (*str*) – The account ID to connect to
ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.PsychicReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.QdrantReader(*location: Optional[str] = None*, *url: Optional[str] = None*, *port: Optional[int] = 6333*, *grpc\_port: int = 6334*, *prefer\_grpc: bool = False*, *https: Optional[bool] = None*, *api\_key: Optional[str] = None*, *prefix: Optional[str] = None*, *timeout: Optional[float] = None*, *host: Optional[str] = None*, *path: Optional[str] = None*)[](#llama_index.readers.QdrantReader "Permalink to this definition")Qdrant reader.

Retrieve documents from existing Qdrant collections.

Parameters* **location** – If :memory: - use in-memory Qdrant instance.If str - use it as a url parameter.If None - use default values for host and port.
* **url** – either host or str of“Optional[scheme], host, Optional[port], Optional[prefix]”.Default: None
* **port** – Port of the REST API interface. Default: 6333
* **grpc\_port** – Port of the gRPC interface. Default: 6334
* **prefer\_grpc** – If true - use gPRC interface whenever possible in custom methods.
* **https** – If true - use HTTPS(SSL) protocol. Default: false
* **api\_key** – API key for authentication in Qdrant Cloud. Default: None
* **prefix** – If not None - add prefix to the REST URL path.Example: service/v1 will result inhttp://localhost:6333/service/v1/{qdrant-endpoint} for REST API.Default: None
* **timeout** – Timeout for REST and gRPC API requests.Default: 5.0 seconds for REST and unlimited for gRPC
* **host** – Host name of Qdrant service. If url and host are None, set to ‘localhost’.Default: None
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.QdrantReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*collection\_name: str*, *query\_vector: List[float]*, *should\_search\_mapping: Optional[Dict[str, str]] = None*, *must\_search\_mapping: Optional[Dict[str, str]] = None*, *must\_not\_search\_mapping: Optional[Dict[str, str]] = None*, *rang\_search\_mapping: Optional[Dict[str, Dict[str, float]]] = None*, *limit: int = 10*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.QdrantReader.load_data "Permalink to this definition")Load data from Qdrant.

Parameters* **collection\_name** (*str*) – Name of the Qdrant collection.
* **query\_vector** (*List**[**float**]*) – Query vector.
* **should\_search\_mapping** (*Optional**[**Dict**[**str**,* *str**]**]*) – Mapping from field nameto query string.
* **must\_search\_mapping** (*Optional**[**Dict**[**str**,* *str**]**]*) – Mapping from field nameto query string.
* **must\_not\_search\_mapping** (*Optional**[**Dict**[**str**,* *str**]**]*) – Mapping from fieldname to query string.
* **rang\_search\_mapping** (*Optional**[**Dict**[**str**,* *Dict**[**str**,* *float**]**]**]*) – Mapping fromfield name to range query.
* **limit** (*int*) – Number of results to return.
Example

reader = QdrantReader()reader.load\_data(


> 
> > collection\_name=”test\_collection”,query\_vector=[0.1, 0.2, 0.3],should\_search\_mapping={“text\_field”: “text”},must\_search\_mapping={“text\_field”: “text”},must\_not\_search\_mapping={“text\_field”: “text”},# gte, lte, gt, lt supportedrang\_search\_mapping={“text\_field”: {“gte”: 0.1, “lte”: 0.2}},limit=10
> > 
> > 
> 
> )
> 
> 

ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.QdrantReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.RssReader[](#llama_index.readers.RssReader "Permalink to this definition")RSS reader.

Reads content from an RSS feed.

Show JSON schema
```
{ "title": "RssReader", "description": "RSS reader.\n\nReads content from an RSS feed.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "html\_to\_text": { "title": "Html To Text", "type": "boolean" } }, "required": [ "html\_to\_text" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `html\_to\_text (bool)`
* `is\_remote (bool)`
*field* html\_to\_text*: bool* *[Required]*[](#llama_index.readers.RssReader.html_to_text "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.RssReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.RssReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.RssReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.RssReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.RssReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.RssReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.RssReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.RssReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.RssReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.RssReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*urls: List[str]*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.RssReader.load_data "Permalink to this definition")Load data from RSS feeds.

Parameters**urls** (*List**[**str**]*) – List of RSS URLs to load.

ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.RssReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.RssReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.RssReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.RssReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.RssReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.RssReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.RssReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.RssReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.RssReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.RssReader.validate "Permalink to this definition")*class* llama\_index.readers.SimpleDirectoryReader(*input\_dir: Optional[str] = None*, *input\_files: Optional[List] = None*, *exclude: Optional[List] = None*, *exclude\_hidden: bool = True*, *errors: str = 'ignore'*, *recursive: bool = False*, *encoding: str = 'utf-8'*, *filename\_as\_id: bool = False*, *required\_exts: Optional[List[str]] = None*, *file\_extractor: Optional[Dict[str, BaseReader]] = None*, *num\_files\_limit: Optional[int] = None*, *file\_metadata: Optional[Callable[[str], Dict]] = None*)[](#llama_index.readers.SimpleDirectoryReader "Permalink to this definition")Simple directory reader.

Load files from file directory.Automatically select the best file reader given file extensions.

Parameters* **input\_dir** (*str*) – Path to the directory.
* **input\_files** (*List*) – List of file paths to read(Optional; overrides input\_dir, exclude)
* **exclude** (*List*) – glob of python file paths to exclude (Optional)
* **exclude\_hidden** (*bool*) – Whether to exclude hidden files (dotfiles).
* **encoding** (*str*) – Encoding of the files.Default is utf-8.
* **errors** (*str*) – how encoding and decoding errors are to be handled,see <https://docs.python.org/3/library/functions.html#open>
* **recursive** (*bool*) – Whether to recursively search in subdirectories.False by default.
* **filename\_as\_id** (*bool*) – Whether to use the filename as the document id.False by default.
* **required\_exts** (*Optional**[**List**[**str**]**]*) – List of required extensions.Default is None.
* **file\_extractor** (*Optional**[**Dict**[**str**,* *BaseReader**]**]*) – A mapping of fileextension to a BaseReader class that specifies how to convert that fileto text. If not specified, use default from DEFAULT\_FILE\_READER\_CLS.
* **num\_files\_limit** (*Optional**[**int**]*) – Maximum number of files to read.Default is None.
* **file\_metadata** (*Optional**[**Callable**[**str**,* *Dict**]**]*) – A function that takesin a filename and returns a Dict of metadata for the Document.Default is None.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleDirectoryReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data() → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleDirectoryReader.load_data "Permalink to this definition")Load data from the input directory.

ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.SimpleDirectoryReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*class* llama\_index.readers.SimpleMongoReader(*host: Optional[str] = None*, *port: Optional[int] = None*, *uri: Optional[str] = None*)[](#llama_index.readers.SimpleMongoReader "Permalink to this definition")Simple mongo reader.

Concatenates each Mongo doc into Document used by LlamaIndex.

Parameters* **host** (*str*) – Mongo host.
* **port** (*int*) – Mongo port.
lazy\_load\_data(*db\_name: str*, *collection\_name: str*, *field\_names: List[str] = ['text']*, *separator: str = ''*, *query\_dict: Optional[Dict] = None*, *max\_docs: int = 0*, *metadata\_names: Optional[List[str]] = None*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleMongoReader.lazy_load_data "Permalink to this definition")Load data from the input directory.

Parameters* **db\_name** (*str*) – name of the database.
* **collection\_name** (*str*) – name of the collection.
* **field\_names** (*List**[**str**]*) – names of the fields to be concatenated.Defaults to [“text”]
* **separator** (*str*) – separator to be used between fields.Defaults to “”
* **query\_dict** (*Optional**[**Dict**]*) – query to filter documents. Read more
* **docs****]****(****https** (*at* *[**official*) – //www.mongodb.com/docs/manual/reference/method/db.collection.find/#std-label-method-find-query)Defaults to None
* **max\_docs** (*int*) – maximum number of documents to load.Defaults to 0 (no limit)
* **metadata\_names** (*Optional**[**List**[**str**]**]*) – names of the fields to be addedto the metadata attribute of the Document. Defaults to None
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleMongoReader.load_data "Permalink to this definition")Load data from the input directory.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.SimpleMongoReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.SimpleWebPageReader[](#llama_index.readers.SimpleWebPageReader "Permalink to this definition")Simple web page reader.

Reads pages from the web.

Parameters* **html\_to\_text** (*bool*) – Whether to convert HTML to text.Requires html2text package.
* **metadata\_fn** (*Optional**[**Callable**[**[**str**]**,* *Dict**]**]*) – A function that takes ina URL and returns a dictionary of metadata.Default is None.
Show JSON schema
```
{ "title": "SimpleWebPageReader", "description": "Simple web page reader.\n\nReads pages from the web.\n\nArgs:\n html\_to\_text (bool): Whether to convert HTML to text.\n Requires `html2text` package.\n metadata\_fn (Optional[Callable[[str], Dict]]): A function that takes in\n a URL and returns a dictionary of metadata.\n Default is None.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "html\_to\_text": { "title": "Html To Text", "type": "boolean" } }, "required": [ "html\_to\_text" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `html\_to\_text (bool)`
* `is\_remote (bool)`
*field* html\_to\_text*: bool* *[Required]*[](#llama_index.readers.SimpleWebPageReader.html_to_text "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.SimpleWebPageReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.SimpleWebPageReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.SimpleWebPageReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.SimpleWebPageReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.SimpleWebPageReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.SimpleWebPageReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.SimpleWebPageReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.SimpleWebPageReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.SimpleWebPageReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleWebPageReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*urls: List[str]*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SimpleWebPageReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters**urls** (*List**[**str**]*) – List of URLs to scrape.

ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.SimpleWebPageReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.SimpleWebPageReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.SimpleWebPageReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.SimpleWebPageReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.SimpleWebPageReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.SimpleWebPageReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.SimpleWebPageReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.SimpleWebPageReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.SimpleWebPageReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.SimpleWebPageReader.validate "Permalink to this definition")*pydantic model* llama\_index.readers.SlackReader[](#llama_index.readers.SlackReader "Permalink to this definition")Slack reader.

Reads conversations from channels. If an earliest\_date is provided, anoptional latest\_date can also be provided. If no latest\_date is provided,we assume the latest date is the current timestamp.

Parameters* **slack\_token** (*Optional**[**str**]*) – Slack token. If not provided, weassume the environment variable SLACK\_BOT\_TOKEN is set.
* **ssl** (*Optional**[**str**]*) – Custom SSL context. If not provided, it is assumedthere is already an SSL context available.
* **earliest\_date** (*Optional**[**datetime**]*) – Earliest date from whichto read conversations. If not provided, we read all messages.
* **latest\_date** (*Optional**[**datetime**]*) – Latest date from which toread conversations. If not provided, defaults to current timestampin combination with earliest\_date.
Show JSON schema
```
{ "title": "SlackReader", "description": "Slack reader.\n\nReads conversations from channels. If an earliest\_date is provided, an\noptional latest\_date can also be provided. If no latest\_date is provided,\nwe assume the latest date is the current timestamp.\n\nArgs:\n slack\_token (Optional[str]): Slack token. If not provided, we\n assume the environment variable `SLACK\_BOT\_TOKEN` is set.\n ssl (Optional[str]): Custom SSL context. If not provided, it is assumed\n there is already an SSL context available.\n earliest\_date (Optional[datetime]): Earliest date from which\n to read conversations. If not provided, we read all messages.\n latest\_date (Optional[datetime]): Latest date from which to\n read conversations. If not provided, defaults to current timestamp\n in combination with earliest\_date.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "slack\_token": { "title": "Slack Token", "type": "string" }, "earliest\_date\_timestamp": { "title": "Earliest Date Timestamp", "type": "number" }, "latest\_date\_timestamp": { "title": "Latest Date Timestamp", "type": "number" } }, "required": [ "slack\_token", "latest\_date\_timestamp" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `earliest\_date\_timestamp (Optional[float])`
* `is\_remote (bool)`
* `latest\_date\_timestamp (float)`
* `slack\_token (str)`
*field* earliest\_date\_timestamp*: Optional[float]* *= None*[](#llama_index.readers.SlackReader.earliest_date_timestamp "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.SlackReader.is_remote "Permalink to this definition")*field* latest\_date\_timestamp*: float* *[Required]*[](#llama_index.readers.SlackReader.latest_date_timestamp "Permalink to this definition")*field* slack\_token*: str* *[Required]*[](#llama_index.readers.SlackReader.slack_token "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.SlackReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.SlackReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.SlackReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.SlackReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.SlackReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.SlackReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.SlackReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.SlackReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SlackReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*channel\_ids: List[str]*, *reverse\_chronological: bool = True*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SlackReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters**channel\_ids** (*List**[**str**]*) – List of channel ids to read.

ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.SlackReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.SlackReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.SlackReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.SlackReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.SlackReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.SlackReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.SlackReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.SlackReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.SlackReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.SlackReader.validate "Permalink to this definition")*class* llama\_index.readers.SteamshipFileReader(*api\_key: Optional[str] = None*)[](#llama_index.readers.SteamshipFileReader "Permalink to this definition")Reads persistent Steamship Files and converts them to Documents.

Parameters**api\_key** – Steamship API key. Defaults to STEAMSHIP\_API\_KEY value if not provided.

Note

Requires install of steamship package and an active Steamship API Key.To get a Steamship API Key, visit: <https://steamship.com/account/api>.Once you have an API Key, expose it via an environment variable namedSTEAMSHIP\_API\_KEY or pass it as an init argument (api\_key).

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SteamshipFileReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*workspace: str*, *query: Optional[str] = None*, *file\_handles: Optional[List[str]] = None*, *collapse\_blocks: bool = True*, *join\_str: str = '\n\n'*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.SteamshipFileReader.load_data "Permalink to this definition")Load data from persistent Steamship Files into Documents.

Parameters* **workspace** – the handle for a Steamship workspace(see: <https://docs.steamship.com/workspaces/index.html>)
* **query** – a Steamship tag query for retrieving files(ex: ‘filetag and value(“import-id”)=”import-001”’)
* **file\_handles** – a list of Steamship File handles(ex: smooth-valley-9kbdr)
* **collapse\_blocks** – whether to merge individual File Blocks into asingle Document, or separate them.
* **join\_str** – when collapse\_blocks is True, this is how the block textswill be concatenated.
Note

The collection of Files from both query and file\_handles will becombined. There is no (current) support for deconflicting the collections(meaning that if a file appears both in the result set of the query andas a handle in file\_handles, it will be loaded twice).

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.SteamshipFileReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.StringIterableReader[](#llama_index.readers.StringIterableReader "Permalink to this definition")String Iterable Reader.

Gets a list of documents, given an iterable (e.g. list) of strings.

Example


```
from llama\_index import StringIterableReader, TreeIndexdocuments = StringIterableReader().load\_data(    texts=["I went to the store", "I bought an apple"])index = TreeIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()query\_engine.query("what did I buy?")# response should be something like "You bought an apple."
```
Show JSON schema
```
{ "title": "StringIterableReader", "description": "String Iterable Reader.\n\nGets a list of documents, given an iterable (e.g. list) of strings.\n\nExample:\n .. code-block:: python\n\n from llama\_index import StringIterableReader, TreeIndex\n\n documents = StringIterableReader().load\_data(\n texts=[\"I went to the store\", \"I bought an apple\"]\n )\n index = TreeIndex.from\_documents(documents)\n query\_engine = index.as\_query\_engine()\n query\_engine.query(\"what did I buy?\")\n\n # response should be something like \"You bought an apple.\"", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": false, "type": "boolean" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `is\_remote (bool)`
*field* is\_remote*: bool* *= False*[](#llama_index.readers.StringIterableReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.StringIterableReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.StringIterableReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.StringIterableReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.StringIterableReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.StringIterableReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.StringIterableReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.StringIterableReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.StringIterableReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.StringIterableReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*texts: List[str]*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.StringIterableReader.load_data "Permalink to this definition")Load the data.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.StringIterableReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.StringIterableReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.StringIterableReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.StringIterableReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.StringIterableReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.StringIterableReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.StringIterableReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.StringIterableReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.StringIterableReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.StringIterableReader.validate "Permalink to this definition")*pydantic model* llama\_index.readers.TrafilaturaWebReader[](#llama_index.readers.TrafilaturaWebReader "Permalink to this definition")Trafilatura web page reader.

Reads pages from the web.Requires the trafilatura package.

Show JSON schema
```
{ "title": "TrafilaturaWebReader", "description": "Trafilatura web page reader.\n\nReads pages from the web.\nRequires the `trafilatura` package.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "error\_on\_missing": { "title": "Error On Missing", "type": "boolean" } }, "required": [ "error\_on\_missing" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `error\_on\_missing (bool)`
* `is\_remote (bool)`
*field* error\_on\_missing*: bool* *[Required]*[](#llama_index.readers.TrafilaturaWebReader.error_on_missing "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.TrafilaturaWebReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.TrafilaturaWebReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.TrafilaturaWebReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.TrafilaturaWebReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.TrafilaturaWebReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.TrafilaturaWebReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.TrafilaturaWebReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.TrafilaturaWebReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.TrafilaturaWebReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.TrafilaturaWebReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*urls: List[str]*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.TrafilaturaWebReader.load_data "Permalink to this definition")Load data from the urls.

Parameters**urls** (*List**[**str**]*) – List of URLs to scrape.

ReturnsList of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.TrafilaturaWebReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.TrafilaturaWebReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.TrafilaturaWebReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.TrafilaturaWebReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.TrafilaturaWebReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.TrafilaturaWebReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.TrafilaturaWebReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.TrafilaturaWebReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.TrafilaturaWebReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.TrafilaturaWebReader.validate "Permalink to this definition")*pydantic model* llama\_index.readers.TwitterTweetReader[](#llama_index.readers.TwitterTweetReader "Permalink to this definition")Twitter tweets reader.

Read tweets of user twitter handle.

Check ‘<https://developer.twitter.com/en/docs/twitter-api/> getting-started/getting-access-to-the-twitter-api’ on how to get access to twitter API.

Parameters* **bearer\_token** (*str*) – bearer\_token that you get from twitter API.
* **num\_tweets** (*Optional**[**int**]*) – Number of tweets for each user twitter handle. Default is 100 tweets.
Show JSON schema
```
{ "title": "TwitterTweetReader", "description": "Twitter tweets reader.\n\nRead tweets of user twitter handle.\n\nCheck 'https://developer.twitter.com/en/docs/twitter-api/ getting-started/getting-access-to-the-twitter-api' on how to get access to twitter API.\n\nArgs:\n bearer\_token (str): bearer\_token that you get from twitter API.\n num\_tweets (Optional[int]): Number of tweets for each user twitter handle. Default is 100 tweets.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "bearer\_token": { "title": "Bearer Token", "type": "string" }, "num\_tweets": { "title": "Num Tweets", "type": "integer" } }, "required": [ "bearer\_token" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `bearer\_token (str)`
* `is\_remote (bool)`
* `num\_tweets (Optional[int])`
*field* bearer\_token*: str* *[Required]*[](#llama_index.readers.TwitterTweetReader.bearer_token "Permalink to this definition")*field* is\_remote*: bool* *= True*[](#llama_index.readers.TwitterTweetReader.is_remote "Permalink to this definition")*field* num\_tweets*: Optional[int]* *= None*[](#llama_index.readers.TwitterTweetReader.num_tweets "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.TwitterTweetReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.TwitterTweetReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.TwitterTweetReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.TwitterTweetReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.TwitterTweetReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.TwitterTweetReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.TwitterTweetReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.TwitterTweetReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.TwitterTweetReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*twitterhandles: List[str]*, *num\_tweets: Optional[int] = None*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.TwitterTweetReader.load_data "Permalink to this definition")Load tweets of twitter handles.

Parameters**twitterhandles** (*List**[**str**]*) – List of user twitter handles to read tweets.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.TwitterTweetReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.TwitterTweetReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.TwitterTweetReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.TwitterTweetReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.TwitterTweetReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.TwitterTweetReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.TwitterTweetReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.TwitterTweetReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.TwitterTweetReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.TwitterTweetReader.validate "Permalink to this definition")*class* llama\_index.readers.WeaviateReader(*host: str*, *auth\_client\_secret: Optional[Any] = None*)[](#llama_index.readers.WeaviateReader "Permalink to this definition")Weaviate reader.

Retrieves documents from Weaviate through vector lookup. Allows optionto concatenate retrieved documents into one Document, or to returnseparate Document objects per document.

Parameters* **host** (*str*) – host.
* **auth\_client\_secret** (*Optional**[**weaviate.auth.AuthCredentials**]*) – auth\_client\_secret.
lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.WeaviateReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*class\_name: Optional[str] = None*, *properties: Optional[List[str]] = None*, *graphql\_query: Optional[str] = None*, *separate\_documents: Optional[bool] = True*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.WeaviateReader.load_data "Permalink to this definition")Load data from Weaviate.

If graphql\_query is not found in load\_kwargs, we assume thatclass\_name and properties are provided.

Parameters* **class\_name** (*Optional**[**str**]*) – class\_name to retrieve documents from.
* **properties** (*Optional**[**List**[**str**]**]*) – properties to retrieve from documents.
* **graphql\_query** (*Optional**[**str**]*) – Raw GraphQL Query.We assume that the query is a Get query.
* **separate\_documents** (*Optional**[**bool**]*) – Whether to return separatedocuments. Defaults to True.
ReturnsA list of documents.

Return typeList[[Document](#llama_index.readers.Document "llama_index.readers.Document")]

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.WeaviateReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*pydantic model* llama\_index.readers.WikipediaReader[](#llama_index.readers.WikipediaReader "Permalink to this definition")Wikipedia reader.

Reads a page.

Show JSON schema
```
{ "title": "WikipediaReader", "description": "Wikipedia reader.\n\nReads a page.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `is\_remote (bool)`
*field* is\_remote*: bool* *= True*[](#llama_index.readers.WikipediaReader.is_remote "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.WikipediaReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.WikipediaReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.WikipediaReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.WikipediaReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.WikipediaReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.WikipediaReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.WikipediaReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.WikipediaReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.WikipediaReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*pages: List[str]*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.WikipediaReader.load_data "Permalink to this definition")Load data from the input directory.

Parameters**pages** (*List**[**str**]*) – List of pages to read.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.WikipediaReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.WikipediaReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.WikipediaReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.WikipediaReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.WikipediaReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.WikipediaReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.WikipediaReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.WikipediaReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.WikipediaReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.WikipediaReader.validate "Permalink to this definition")*pydantic model* llama\_index.readers.YoutubeTranscriptReader[](#llama_index.readers.YoutubeTranscriptReader "Permalink to this definition")Youtube Transcript reader.

Show JSON schema
```
{ "title": "YoutubeTranscriptReader", "description": "Youtube Transcript reader.", "type": "object", "properties": { "is\_remote": { "title": "Is Remote", "default": true, "type": "boolean" }, "languages": { "title": "Languages", "default": [ "en" ], "type": "array", "items": {} } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* `is\_remote (bool)`
* `languages (tuple)`
*field* is\_remote*: bool* *= True*[](#llama_index.readers.YoutubeTranscriptReader.is_remote "Permalink to this definition")*field* languages*: tuple* *= ('en',)*[](#llama_index.readers.YoutubeTranscriptReader.languages "Permalink to this definition")*classmethod* class\_name() → str[](#llama_index.readers.YoutubeTranscriptReader.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.readers.YoutubeTranscriptReader.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.readers.YoutubeTranscriptReader.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.readers.YoutubeTranscriptReader.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

*classmethod* from\_dict(*data: Dict[str, Any]*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.YoutubeTranscriptReader.from_dict "Permalink to this definition")*classmethod* from\_json(*data\_str: str*, *\*\*kwargs: Any*) → Self[](#llama_index.readers.YoutubeTranscriptReader.from_json "Permalink to this definition")*classmethod* from\_orm(*obj: Any*) → Model[](#llama_index.readers.YoutubeTranscriptReader.from_orm "Permalink to this definition")json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.YoutubeTranscriptReader.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

lazy\_load\_data(*\*args: Any*, *\*\*load\_kwargs: Any*) → Iterable[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.YoutubeTranscriptReader.lazy_load_data "Permalink to this definition")Load data from the input directory lazily.

load\_data(*ytlinks: List[str]*, *\*\*load\_kwargs: Any*) → List[[Document](node.html#llama_index.schema.Document "llama_index.schema.Document")][](#llama_index.readers.YoutubeTranscriptReader.load_data "Permalink to this definition")Load data from the input links.

Parameters**pages** (*List**[**str**]*) – List of youtube links for which transcripts are to be read.

load\_langchain\_documents(*\*\*load\_kwargs: Any*) → List[Document][](#llama_index.readers.YoutubeTranscriptReader.load_langchain_documents "Permalink to this definition")Load data in LangChain document format.

*classmethod* parse\_file(*path: Union[str, Path]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.YoutubeTranscriptReader.parse_file "Permalink to this definition")*classmethod* parse\_obj(*obj: Any*) → Model[](#llama_index.readers.YoutubeTranscriptReader.parse_obj "Permalink to this definition")*classmethod* parse\_raw(*b: Union[str, bytes]*, *\**, *content\_type: unicode = None*, *encoding: unicode = 'utf8'*, *proto: Protocol = None*, *allow\_pickle: bool = False*) → Model[](#llama_index.readers.YoutubeTranscriptReader.parse_raw "Permalink to this definition")*classmethod* schema(*by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*) → DictStrAny[](#llama_index.readers.YoutubeTranscriptReader.schema "Permalink to this definition")*classmethod* schema\_json(*\**, *by\_alias: bool = True*, *ref\_template: unicode = '#/definitions/{model}'*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.readers.YoutubeTranscriptReader.schema_json "Permalink to this definition")to\_dict(*\*\*kwargs: Any*) → Dict[str, Any][](#llama_index.readers.YoutubeTranscriptReader.to_dict "Permalink to this definition")to\_json(*\*\*kwargs: Any*) → str[](#llama_index.readers.YoutubeTranscriptReader.to_json "Permalink to this definition")*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.readers.YoutubeTranscriptReader.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

*classmethod* validate(*value: Any*) → Model[](#llama_index.readers.YoutubeTranscriptReader.validate "Permalink to this definition")llama\_index.readers.download\_loader(*loader\_class: str*, *loader\_hub\_url: str = 'https://raw.githubusercontent.com/run-llama/llama-hub/main/llama\_hub'*, *refresh\_cache: bool = False*, *use\_gpt\_index\_import: bool = False*, *custom\_path: Optional[str] = None*) → Type[BaseReader][](#llama_index.readers.download_loader "Permalink to this definition")Download a single loader from the Loader Hub.

Parameters* **loader\_class** – The name of the loader class you want to download,such as SimpleWebPageReader.
* **refresh\_cache** – If true, the local cache will be skipped and theloader will be fetched directly from the remote repo.
* **use\_gpt\_index\_import** – If true, the loader files will usellama\_index as the base dependency. By default (False),the loader files use llama\_index as the base dependency.NOTE: this is a temporary workaround while we fully migrate all usagesto llama\_index.
* **custom\_path** – Custom dirpath to download loader into.
ReturnsA Loader.

