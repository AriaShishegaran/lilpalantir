Response Synthesizer[](#module-llama_index.response_synthesizers "Permalink to this heading")
==============================================================================================

Init file.

*class* llama\_index.response\_synthesizers.Accumulate(*text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *output\_cls: Optional[Any] = None*, *streaming: bool = False*, *use\_async: bool = False*)[](#llama_index.response_synthesizers.Accumulate "Permalink to this definition")Accumulate responses from multiple text chunks.

*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *separator: str = '\n---------------------\n'*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Accumulate.aget_response "Permalink to this definition")Apply the same prompt to text chunks and return async responses.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.Accumulate.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *separator: str = '\n---------------------\n'*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Accumulate.get_response "Permalink to this definition")Apply the same prompt to text chunks and return responses.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.Accumulate.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.BaseSynthesizer(*service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *streaming: bool = False*, *output\_cls: BaseModel = None*)[](#llama_index.response_synthesizers.BaseSynthesizer "Permalink to this definition")Response builder class.

*abstract async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.BaseSynthesizer.aget_response "Permalink to this definition")Get response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.BaseSynthesizer.get_prompts "Permalink to this definition")Get a prompt.

*abstract* get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.BaseSynthesizer.get_response "Permalink to this definition")Get response.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.BaseSynthesizer.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.CompactAndRefine(*service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *output\_cls: Optional[BaseModel] = None*, *streaming: bool = False*, *verbose: bool = False*, *structured\_answer\_filtering: bool = False*, *program\_factory: Optional[Callable[[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")], BasePydanticProgram]] = None*)[](#llama_index.response_synthesizers.CompactAndRefine "Permalink to this definition")Refine responses across compact text chunks.

*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *prev\_response: Optional[Union[BaseModel, str, Generator[str, None, None]]] = None*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.CompactAndRefine.aget_response "Permalink to this definition")Get response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.CompactAndRefine.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *prev\_response: Optional[Union[BaseModel, str, Generator[str, None, None]]] = None*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.CompactAndRefine.get_response "Permalink to this definition")Get compact response.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.CompactAndRefine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.Generation(*simple\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *streaming: bool = False*)[](#llama_index.response_synthesizers.Generation "Permalink to this definition")*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Generation.aget_response "Permalink to this definition")Get response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.Generation.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Generation.get_response "Permalink to this definition")Get response.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.Generation.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.Refine(*service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *output\_cls: Optional[BaseModel] = None*, *streaming: bool = False*, *verbose: bool = False*, *structured\_answer\_filtering: bool = False*, *program\_factory: Optional[Callable[[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")], BasePydanticProgram]] = None*)[](#llama_index.response_synthesizers.Refine "Permalink to this definition")Refine a response to a query across text chunks.

*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *prev\_response: Optional[Union[BaseModel, str, Generator[str, None, None]]] = None*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Refine.aget_response "Permalink to this definition")Get response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.Refine.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *prev\_response: Optional[Union[BaseModel, str, Generator[str, None, None]]] = None*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.Refine.get_response "Permalink to this definition")Give response over chunks.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.Refine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.ResponseMode(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.response_synthesizers.ResponseMode "Permalink to this definition")Response modes of the response builder (and synthesizer).

ACCUMULATE *= 'accumulate'*[](#llama_index.response_synthesizers.ResponseMode.ACCUMULATE "Permalink to this definition")Synthesize a response for each text chunk, and then return the concatenation.

COMPACT *= 'compact'*[](#llama_index.response_synthesizers.ResponseMode.COMPACT "Permalink to this definition")Compact and refine mode first combine text chunks into larger consolidated chunks that more fully utilize the available context window, then refine answers across them.This mode is faster than refine since we make fewer calls to the LLM.

COMPACT\_ACCUMULATE *= 'compact\_accumulate'*[](#llama_index.response_synthesizers.ResponseMode.COMPACT_ACCUMULATE "Permalink to this definition")Compact and accumulate mode first combine text chunks into larger consolidated chunks that more fully utilize the available context window, then accumulate answers for each of them and finally return the concatenation.This mode is faster than accumulate since we make fewer calls to the LLM.

GENERATION *= 'generation'*[](#llama_index.response_synthesizers.ResponseMode.GENERATION "Permalink to this definition")Ignore context, just use LLM to generate a response.

NO\_TEXT *= 'no\_text'*[](#llama_index.response_synthesizers.ResponseMode.NO_TEXT "Permalink to this definition")Return the retrieved context nodes, without synthesizing a final response.

REFINE *= 'refine'*[](#llama_index.response_synthesizers.ResponseMode.REFINE "Permalink to this definition")Refine is an iterative way of generating a response.We first use the context in the first node, along with the query, to generate an initial answer.We then pass this answer, the query, and the context of the second node as input into a “refine prompt” to generate a refined answer. We refine through N-1 nodes, where N is the total number of nodes.

SIMPLE\_SUMMARIZE *= 'simple\_summarize'*[](#llama_index.response_synthesizers.ResponseMode.SIMPLE_SUMMARIZE "Permalink to this definition")Merge all text chunks into one, and make a LLM call.This will fail if the merged text chunk exceeds the context window size.

TREE\_SUMMARIZE *= 'tree\_summarize'*[](#llama_index.response_synthesizers.ResponseMode.TREE_SUMMARIZE "Permalink to this definition")Build a tree index over the set of candidate nodes, with a summary prompt seeded with the query.The tree is built in a bottoms-up fashion, and in the end the root node is returned as the response

capitalize()[](#llama_index.response_synthesizers.ResponseMode.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.response_synthesizers.ResponseMode.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.response_synthesizers.ResponseMode.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.response_synthesizers.ResponseMode.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.response_synthesizers.ResponseMode.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.response_synthesizers.ResponseMode.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.response_synthesizers.ResponseMode.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.response_synthesizers.ResponseMode.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.response_synthesizers.ResponseMode.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.response_synthesizers.ResponseMode.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.response_synthesizers.ResponseMode.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.response_synthesizers.ResponseMode.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.response_synthesizers.ResponseMode.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.response_synthesizers.ResponseMode.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.response_synthesizers.ResponseMode.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.response_synthesizers.ResponseMode.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.response_synthesizers.ResponseMode.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.response_synthesizers.ResponseMode.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.response_synthesizers.ResponseMode.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.response_synthesizers.ResponseMode.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.response_synthesizers.ResponseMode.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.response_synthesizers.ResponseMode.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.response_synthesizers.ResponseMode.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.response_synthesizers.ResponseMode.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.response_synthesizers.ResponseMode.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.response_synthesizers.ResponseMode.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.response_synthesizers.ResponseMode.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.response_synthesizers.ResponseMode.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.response_synthesizers.ResponseMode.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.response_synthesizers.ResponseMode.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.response_synthesizers.ResponseMode.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.response_synthesizers.ResponseMode.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.response_synthesizers.ResponseMode.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.response_synthesizers.ResponseMode.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.response_synthesizers.ResponseMode.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.response_synthesizers.ResponseMode.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.response_synthesizers.ResponseMode.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.response_synthesizers.ResponseMode.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.response_synthesizers.ResponseMode.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.response_synthesizers.ResponseMode.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.response_synthesizers.ResponseMode.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.response_synthesizers.ResponseMode.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.response_synthesizers.ResponseMode.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.response_synthesizers.ResponseMode.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.response_synthesizers.ResponseMode.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.response_synthesizers.ResponseMode.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.response_synthesizers.ResponseMode.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*class* llama\_index.response\_synthesizers.SimpleSummarize(*text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *streaming: bool = False*)[](#llama_index.response_synthesizers.SimpleSummarize "Permalink to this definition")*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.SimpleSummarize.aget_response "Permalink to this definition")Get response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.SimpleSummarize.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.SimpleSummarize.get_response "Permalink to this definition")Get response.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.SimpleSummarize.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

*class* llama\_index.response\_synthesizers.TreeSummarize(*summary\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *output\_cls: Optional[BaseModel] = None*, *streaming: bool = False*, *use\_async: bool = False*, *verbose: bool = False*)[](#llama_index.response_synthesizers.TreeSummarize "Permalink to this definition")Tree summarize response builder.

This response builder recursively merges text chunks and summarizes themin a bottom-up fashion (i.e. building a tree from leaves to root).

More concretely, at each recursively step:1. we repack the text chunks so that each chunk fills the context window of the LLM2. if there is only one chunk, we give the final response3. otherwise, we summarize each chunk and recursively summarize the summaries.

*async* aget\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.TreeSummarize.aget_response "Permalink to this definition")Get tree summarize response.

get\_prompts() → Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.response_synthesizers.TreeSummarize.get_prompts "Permalink to this definition")Get a prompt.

get\_response(*query\_str: str*, *text\_chunks: Sequence[str]*, *\*\*response\_kwargs: Any*) → Union[BaseModel, str, Generator[str, None, None]][](#llama_index.response_synthesizers.TreeSummarize.get_response "Permalink to this definition")Get tree summarize response.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.response_synthesizers.TreeSummarize.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.response\_synthesizers.get\_response\_synthesizer(*service\_context: Optional[[ServiceContext](../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *text\_qa\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *refine\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *summary\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *simple\_template: Optional[[BasePromptTemplate](../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *response\_mode: [ResponseMode](#llama_index.response_synthesizers.ResponseMode "llama_index.response_synthesizers.type.ResponseMode") = ResponseMode.COMPACT*, *callback\_manager: Optional[[CallbackManager](../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *use\_async: bool = False*, *streaming: bool = False*, *structured\_answer\_filtering: bool = False*, *output\_cls: Optional[BaseModel] = None*, *program\_factory: Optional[Callable[[[PromptTemplate](../prompts.html#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")], BasePydanticProgram]] = None*, *verbose: bool = False*) → [BaseSynthesizer](#llama_index.response_synthesizers.BaseSynthesizer "llama_index.response_synthesizers.base.BaseSynthesizer")[](#llama_index.response_synthesizers.get_response_synthesizer "Permalink to this definition")Get a response synthesizer.

