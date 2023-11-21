Knowledge Graph Retriever[](#module-llama_index.indices.knowledge_graph.retrievers "Permalink to this heading")
================================================================================================================

KG Retrievers.

*class* llama\_index.indices.knowledge\_graph.retrievers.KGRetrieverMode(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode "Permalink to this definition")Query mode enum for Knowledge Graphs.

Can be passed as the enum struct, or as the underlying string.

KEYWORD[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.KEYWORD "Permalink to this definition")Default query mode, using keywords to find triplets.

Type“keyword”

EMBEDDING[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.EMBEDDING "Permalink to this definition")Embedding mode, using embeddings to findsimilar triplets.

Type“embedding”

HYBRID[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.HYBRID "Permalink to this definition")Hyrbid mode, combining both keywords and embeddingsto find relevant triplets.

Type“hybrid”

capitalize()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*class* llama\_index.indices.knowledge\_graph.retrievers.KGTableRetriever(*index: [KnowledgeGraphIndex](../../indices/kg.html#llama_index.indices.knowledge_graph.KnowledgeGraphIndex "llama_index.indices.knowledge_graph.base.KnowledgeGraphIndex")*, *query\_keyword\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *max\_keywords\_per\_query: int = 10*, *num\_chunks\_per\_query: int = 10*, *include\_text: bool = True*, *retriever\_mode: Optional[[KGRetrieverMode](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode "llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode")] = KGRetrieverMode.KEYWORD*, *similarity\_top\_k: int = 2*, *graph\_store\_query\_depth: int = 2*, *use\_global\_node\_triplets: bool = False*, *max\_knowledge\_sequence: int = 30*, *\*\*kwargs: Any*)[](#llama_index.indices.knowledge_graph.retrievers.KGTableRetriever "Permalink to this definition")KG Table Retriever.

Arguments are shared among subclasses.

Parameters* **query\_keyword\_extract\_template** (*Optional**[**QueryKGExtractPrompt**]*) – A QueryKG ExtractionPrompt (see [Prompt Templates](../../prompts.html#prompt-templates)).
* **refine\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Refinement Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **text\_qa\_template** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A Question Answering Prompt(see [Prompt Templates](../../prompts.html#prompt-templates)).
* **max\_keywords\_per\_query** (*int*) – Maximum number of keywords to extract from query.
* **num\_chunks\_per\_query** (*int*) – Maximum number of text chunks to query.
* **include\_text** (*bool*) – Use the document text source from each relevant tripletduring queries.
* **retriever\_mode** ([*KGRetrieverMode*](#llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode "llama_index.indices.knowledge_graph.retrievers.KGRetrieverMode")) – Specifies whether to use keywords,embeddings, or both to find relevant triplets. Should be one of “keyword”,“embedding”, or “hybrid”.
* **similarity\_top\_k** (*int*) – The number of top embeddings to use(if embeddings are used).
* **graph\_store\_query\_depth** (*int*) – The depth of the graph store query.
* **use\_global\_node\_triplets** (*bool*) – Whether to get more keywords(entities) fromtext chunks matched by keywords. This helps introduce more global knowledge.While it’s more expensive, thus to be turned off by default.
* **max\_knowledge\_sequence** (*int*) – The maximum number of knowledge sequence toinclude in the response. By default, it’s 30.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.knowledge_graph.retrievers.KGTableRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.knowledge_graph.retrievers.KGTableRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.knowledge_graph.retrievers.KGTableRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.knowledge_graph.retrievers.KGTableRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.indices.knowledge\_graph.retrievers.KnowledgeGraphRAGRetriever(*service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *storage\_context: Optional[[StorageContext](../../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")] = None*, *entity\_extract\_fn: Optional[Callable] = None*, *entity\_extract\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *entity\_extract\_policy: Optional[str] = 'union'*, *synonym\_expand\_fn: Optional[Callable] = None*, *synonym\_expand\_template: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *synonym\_expand\_policy: Optional[str] = 'union'*, *max\_entities: int = 5*, *max\_synonyms: int = 5*, *retriever\_mode: Optional[str] = 'keyword'*, *with\_nl2graphquery: bool = False*, *graph\_traversal\_depth: int = 2*, *max\_knowledge\_sequence: int = 30*, *verbose: bool = False*, *\*\*kwargs: Any*)[](#llama_index.indices.knowledge_graph.retrievers.KnowledgeGraphRAGRetriever "Permalink to this definition")Knowledge Graph RAG retriever.

Retriever that perform SubGraph RAG towards knowledge graph.

Parameters* **service\_context** (*Optional**[*[*ServiceContext*](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*]*) – A service context to use.
* **storage\_context** (*Optional**[*[*StorageContext*](../../storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")*]*) – A storage context to use.
* **entity\_extract\_fn** (*Optional**[**Callable**]*) – A function to extract entities.
* **Optional****[****BasePromptTemplate****]****)** (*entity\_extract\_template*) – A Query Key EntityExtraction Prompt (see [Prompt Templates](../../prompts.html#prompt-templates)).
* **entity\_extract\_policy** (*Optional**[**str**]*) – The entity extraction policy to use.default: “union”possible values: “union”, “intersection”
* **synonym\_expand\_fn** (*Optional**[**Callable**]*) – A function to expand synonyms.
* **synonym\_expand\_template** (*Optional**[**QueryKeywordExpandPrompt**]*) – A Query Key EntityExpansion Prompt (see [Prompt Templates](../../prompts.html#prompt-templates)).
* **synonym\_expand\_policy** (*Optional**[**str**]*) – The synonym expansion policy to use.default: “union”possible values: “union”, “intersection”
* **max\_entities** (*int*) – The maximum number of entities to extract.default: 5
* **max\_synonyms** (*int*) – The maximum number of synonyms to expand per entity.default: 5
* **retriever\_mode** (*Optional**[**str**]*) – The retriever mode to use.default: “keyword”possible values: “keyword”, “embedding”, “keyword\_embedding”
* **with\_nl2graphquery** (*bool*) – Whether to combine NL2GraphQuery in context.default: False
* **graph\_traversal\_depth** (*int*) – The depth of graph traversal.default: 2
* **max\_knowledge\_sequence** (*int*) – The maximum number of knowledge sequence toinclude in the response. By default, it’s 30.
* **verbose** (*bool*) – Whether to print out debug info.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.indices.knowledge_graph.retrievers.KnowledgeGraphRAGRetriever.get_prompts "Permalink to this definition")Get a prompt.

get\_service\_context() → Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")][](#llama_index.indices.knowledge_graph.retrievers.KnowledgeGraphRAGRetriever.get_service_context "Permalink to this definition")Attempts to resolve a service context.Short-circuits at self.service\_context, self.\_service\_context,or self.\_index.service\_context.

retrieve(*str\_or\_query\_bundle: Union[str, [QueryBundle](../query_bundle.html#llama_index.indices.query.schema.QueryBundle "llama_index.indices.query.schema.QueryBundle")]*) → List[[NodeWithScore](../../node.html#llama_index.schema.NodeWithScore "llama_index.schema.NodeWithScore")][](#llama_index.indices.knowledge_graph.retrievers.KnowledgeGraphRAGRetriever.retrieve "Permalink to this definition")Retrieve nodes given query.

Parameters**str\_or\_query\_bundle** (*QueryType*) – Either a query string ora QueryBundle object.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.indices.knowledge_graph.retrievers.KnowledgeGraphRAGRetriever.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

