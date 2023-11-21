LLMs[](#llms "Permalink to this heading")
==========================================

A large language model (LLM) is a reasoning engine that can complete text,chat with users, and follow instructions.

LLM Implementations[](#llm-implementations "Permalink to this heading")
------------------------------------------------------------------------

LLM Implementations

* [OpenAI](llms/openai.html)
* [Azure OpenAI](llms/azure_openai.html)
* [HuggingFaceLLM](llms/huggingface.html)
* [LangChainLLM](llms/langchain.html)
* [Anthropic](llms/anthropic.html)
* [Gradient Base Model](llms/gradient_base_model.html)
* [Gradient Model Adapter](llms/gradient_model_adapter.html)
* [LiteLLM](llms/litellm.html)
* [LlamaCPP](llms/llama_cpp.html)
* [PaLM](llms/palm.html)
* [Predibase](llms/predibase.html)
* [Replicate](llms/replicate.html)
* [XOrbits Xinference](llms/xinference.html)
LLM Interface[](#llm-interface "Permalink to this heading")
------------------------------------------------------------

*class* llama\_index.llms.base.LLM(*\**, *callback\_manager: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager") = None*)[](#llama_index.llms.base.LLM "Permalink to this definition")LLM interface.

*abstract async* achat(*messages: Sequence[[ChatMessage](#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → [ChatResponse](#llama_index.llms.base.ChatResponse "llama_index.llms.base.ChatResponse")[](#llama_index.llms.base.LLM.achat "Permalink to this definition")Async chat endpoint for LLM.

*abstract async* acomplete(*prompt: str*, *\*\*kwargs: Any*) → [CompletionResponse](#llama_index.llms.base.CompletionResponse "llama_index.llms.base.CompletionResponse")[](#llama_index.llms.base.LLM.acomplete "Permalink to this definition")Async completion endpoint for LLM.

*abstract async* astream\_chat(*messages: Sequence[[ChatMessage](#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → AsyncGenerator[[ChatResponse](#llama_index.llms.base.ChatResponse "llama_index.llms.base.ChatResponse"), None][](#llama_index.llms.base.LLM.astream_chat "Permalink to this definition")Async streaming chat endpoint for LLM.

*abstract async* astream\_complete(*prompt: str*, *\*\*kwargs: Any*) → AsyncGenerator[[CompletionResponse](#llama_index.llms.base.CompletionResponse "llama_index.llms.base.CompletionResponse"), None][](#llama_index.llms.base.LLM.astream_complete "Permalink to this definition")Async streaming completion endpoint for LLM.

*abstract* chat(*messages: Sequence[[ChatMessage](#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → [ChatResponse](#llama_index.llms.base.ChatResponse "llama_index.llms.base.ChatResponse")[](#llama_index.llms.base.LLM.chat "Permalink to this definition")Chat endpoint for LLM.

*abstract classmethod* class\_name() → str[](#llama_index.llms.base.LLM.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*abstract* complete(*prompt: str*, *\*\*kwargs: Any*) → [CompletionResponse](#llama_index.llms.base.CompletionResponse "llama_index.llms.base.CompletionResponse")[](#llama_index.llms.base.LLM.complete "Permalink to this definition")Completion endpoint for LLM.

*classmethod* construct(*\_fields\_set: Optional[SetStr] = None*, *\*\*values: Any*) → Model[](#llama_index.llms.base.LLM.construct "Permalink to this definition")Creates a new model setting \_\_dict\_\_ and \_\_fields\_set\_\_ from trusted or pre-validated data.Default values are respected, but no other validation is performed.Behaves as if Config.extra = ‘allow’ was set since it adds all passed values

copy(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *update: Optional[DictStrAny] = None*, *deep: bool = False*) → Model[](#llama_index.llms.base.LLM.copy "Permalink to this definition")Duplicate a model, optionally choose which fields to include, exclude and change.

Parameters* **include** – fields to include in new model
* **exclude** – fields to exclude from new model, as with values this takes precedence over include
* **update** – values to change/add in the new model. Note: the data is not validated before creatingthe new model: you should trust this data
* **deep** – set to True to make a deep copy of the model
Returnsnew model instance

dict(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*) → DictStrAny[](#llama_index.llms.base.LLM.dict "Permalink to this definition")Generate a dictionary representation of the model, optionally specifying which fields to include or exclude.

json(*\**, *include: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *exclude: Optional[Union[AbstractSetIntStr, MappingIntStrAny]] = None*, *by\_alias: bool = False*, *skip\_defaults: Optional[bool] = None*, *exclude\_unset: bool = False*, *exclude\_defaults: bool = False*, *exclude\_none: bool = False*, *encoder: Optional[Callable[[Any], Any]] = None*, *models\_as\_dict: bool = True*, *\*\*dumps\_kwargs: Any*) → unicode[](#llama_index.llms.base.LLM.json "Permalink to this definition")Generate a JSON representation of the model, include and exclude arguments as per dict().

encoder is an optional function to supply as default to json.dumps(), other arguments as per json.dumps().

*abstract property* metadata*: [LLMMetadata](#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.base.LLM.metadata "Permalink to this definition")LLM metadata.

*abstract* stream\_chat(*messages: Sequence[[ChatMessage](#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Generator[[ChatResponse](#llama_index.llms.base.ChatResponse "llama_index.llms.base.ChatResponse"), None, None][](#llama_index.llms.base.LLM.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

*abstract* stream\_complete(*prompt: str*, *\*\*kwargs: Any*) → Generator[[CompletionResponse](#llama_index.llms.base.CompletionResponse "llama_index.llms.base.CompletionResponse"), None, None][](#llama_index.llms.base.LLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*classmethod* update\_forward\_refs(*\*\*localns: Any*) → None[](#llama_index.llms.base.LLM.update_forward_refs "Permalink to this definition")Try to update ForwardRefs on fields based on this Model, globalns and localns.

Schemas[](#schemas "Permalink to this heading")
------------------------------------------------

*class* llama\_index.llms.base.MessageRole(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.llms.base.MessageRole "Permalink to this definition")Message role.

capitalize()[](#llama_index.llms.base.MessageRole.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.llms.base.MessageRole.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.llms.base.MessageRole.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.llms.base.MessageRole.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.llms.base.MessageRole.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.llms.base.MessageRole.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.llms.base.MessageRole.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.llms.base.MessageRole.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.llms.base.MessageRole.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.llms.base.MessageRole.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.llms.base.MessageRole.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.llms.base.MessageRole.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.llms.base.MessageRole.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.llms.base.MessageRole.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.llms.base.MessageRole.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.llms.base.MessageRole.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.llms.base.MessageRole.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.llms.base.MessageRole.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.llms.base.MessageRole.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.llms.base.MessageRole.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.llms.base.MessageRole.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.llms.base.MessageRole.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.llms.base.MessageRole.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.llms.base.MessageRole.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.llms.base.MessageRole.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.llms.base.MessageRole.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.llms.base.MessageRole.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.llms.base.MessageRole.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.llms.base.MessageRole.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.llms.base.MessageRole.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.llms.base.MessageRole.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.llms.base.MessageRole.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.llms.base.MessageRole.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.llms.base.MessageRole.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.llms.base.MessageRole.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.llms.base.MessageRole.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.llms.base.MessageRole.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.llms.base.MessageRole.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.llms.base.MessageRole.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.llms.base.MessageRole.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.llms.base.MessageRole.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.llms.base.MessageRole.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.llms.base.MessageRole.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.llms.base.MessageRole.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.llms.base.MessageRole.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.llms.base.MessageRole.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.llms.base.MessageRole.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*pydantic model* llama\_index.llms.base.ChatMessage[](#llama_index.llms.base.ChatMessage "Permalink to this definition")Chat message.

Show JSON schema
```
{ "title": "ChatMessage", "description": "Chat message.", "type": "object", "properties": { "role": { "default": "user", "allOf": [ { "$ref": "#/definitions/MessageRole" } ] }, "content": { "title": "Content", "default": "", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" } }, "definitions": { "MessageRole": { "title": "MessageRole", "description": "Message role.", "enum": [ "system", "user", "assistant", "function", "tool" ], "type": "string" } }}
```


Fields* [`additional\_kwargs (dict)`](#llama_index.llms.base.ChatMessage.additional_kwargs "llama_index.llms.base.ChatMessage.additional_kwargs")
* [`content (Optional[str])`](#llama_index.llms.base.ChatMessage.content "llama_index.llms.base.ChatMessage.content")
* [`role (llama\_index.llms.base.MessageRole)`](#llama_index.llms.base.ChatMessage.role "llama_index.llms.base.ChatMessage.role")
*field* additional\_kwargs*: dict* *[Optional]*[](#llama_index.llms.base.ChatMessage.additional_kwargs "Permalink to this definition")*field* content*: Optional[str]* *= ''*[](#llama_index.llms.base.ChatMessage.content "Permalink to this definition")*field* role*: [MessageRole](#llama_index.llms.base.MessageRole "llama_index.llms.base.MessageRole")* *= MessageRole.USER*[](#llama_index.llms.base.ChatMessage.role "Permalink to this definition")*pydantic model* llama\_index.llms.base.ChatResponse[](#llama_index.llms.base.ChatResponse "Permalink to this definition")Chat response.

Show JSON schema
```
{ "title": "ChatResponse", "description": "Chat response.", "type": "object", "properties": { "message": { "$ref": "#/definitions/ChatMessage" }, "raw": { "title": "Raw", "type": "object" }, "delta": { "title": "Delta", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" } }, "required": [ "message" ], "definitions": { "MessageRole": { "title": "MessageRole", "description": "Message role.", "enum": [ "system", "user", "assistant", "function", "tool" ], "type": "string" }, "ChatMessage": { "title": "ChatMessage", "description": "Chat message.", "type": "object", "properties": { "role": { "default": "user", "allOf": [ { "$ref": "#/definitions/MessageRole" } ] }, "content": { "title": "Content", "default": "", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" } } } }}
```


Fields* [`additional\_kwargs (dict)`](#llama_index.llms.base.ChatResponse.additional_kwargs "llama_index.llms.base.ChatResponse.additional_kwargs")
* [`delta (Optional[str])`](#llama_index.llms.base.ChatResponse.delta "llama_index.llms.base.ChatResponse.delta")
* [`message (llama\_index.llms.base.ChatMessage)`](#llama_index.llms.base.ChatResponse.message "llama_index.llms.base.ChatResponse.message")
* [`raw (Optional[dict])`](#llama_index.llms.base.ChatResponse.raw "llama_index.llms.base.ChatResponse.raw")
*field* additional\_kwargs*: dict* *[Optional]*[](#llama_index.llms.base.ChatResponse.additional_kwargs "Permalink to this definition")*field* delta*: Optional[str]* *= None*[](#llama_index.llms.base.ChatResponse.delta "Permalink to this definition")*field* message*: [ChatMessage](#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")* *[Required]*[](#llama_index.llms.base.ChatResponse.message "Permalink to this definition")*field* raw*: Optional[dict]* *= None*[](#llama_index.llms.base.ChatResponse.raw "Permalink to this definition")*pydantic model* llama\_index.llms.base.CompletionResponse[](#llama_index.llms.base.CompletionResponse "Permalink to this definition")Completion response.

Fields:text: Text content of the response if not streaming, or if streaming,the current extent of streamed text.

additional\_kwargs: Additional information on the response(i.e. tokencounts, function calling information).

raw: Optional raw JSON that was parsed to populate text, if relevant.delta: New text that just streamed in (only relevant when streaming).

Show JSON schema
```
{ "title": "CompletionResponse", "description": "Completion response.\n\nFields:\n text: Text content of the response if not streaming, or if streaming,\n the current extent of streamed text.\n additional\_kwargs: Additional information on the response(i.e. token\n counts, function calling information).\n raw: Optional raw JSON that was parsed to populate text, if relevant.\n delta: New text that just streamed in (only relevant when streaming).", "type": "object", "properties": { "text": { "title": "Text", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" }, "raw": { "title": "Raw", "type": "object" }, "delta": { "title": "Delta", "type": "string" } }, "required": [ "text" ]}
```


Fields* [`additional\_kwargs (dict)`](#llama_index.llms.base.CompletionResponse.additional_kwargs "llama_index.llms.base.CompletionResponse.additional_kwargs")
* [`delta (Optional[str])`](#llama_index.llms.base.CompletionResponse.delta "llama_index.llms.base.CompletionResponse.delta")
* [`raw (Optional[dict])`](#llama_index.llms.base.CompletionResponse.raw "llama_index.llms.base.CompletionResponse.raw")
* [`text (str)`](#llama_index.llms.base.CompletionResponse.text "llama_index.llms.base.CompletionResponse.text")
*field* additional\_kwargs*: dict* *[Optional]*[](#llama_index.llms.base.CompletionResponse.additional_kwargs "Permalink to this definition")*field* delta*: Optional[str]* *= None*[](#llama_index.llms.base.CompletionResponse.delta "Permalink to this definition")*field* raw*: Optional[dict]* *= None*[](#llama_index.llms.base.CompletionResponse.raw "Permalink to this definition")*field* text*: str* *[Required]*[](#llama_index.llms.base.CompletionResponse.text "Permalink to this definition")*pydantic model* llama\_index.llms.base.LLMMetadata[](#llama_index.llms.base.LLMMetadata "Permalink to this definition")Show JSON schema
```
{ "title": "LLMMetadata", "type": "object", "properties": { "context\_window": { "title": "Context Window", "description": "Total number of tokens the model can be input and output for one response.", "default": 3900, "type": "integer" }, "num\_output": { "title": "Num Output", "description": "Number of tokens the model can output when generating a response.", "default": 256, "type": "integer" }, "is\_chat\_model": { "title": "Is Chat Model", "description": "Set True if the model exposes a chat interface (i.e. can be passed a sequence of messages, rather than text), like OpenAI's /v1/chat/completions endpoint.", "default": false, "type": "boolean" }, "is\_function\_calling\_model": { "title": "Is Function Calling Model", "description": "Set True if the model supports function calling messages, similar to OpenAI's function calling API. For example, converting 'Email Anya to see if she wants to get coffee next Friday' to a function call like `send\_email(to: string, body: string)`.", "default": false, "type": "boolean" }, "model\_name": { "title": "Model Name", "description": "The model's name used for logging, testing, and sanity checking. For some models this can be automatically discerned. For other models, like locally loaded models, this must be manually specified.", "default": "unknown", "type": "string" } }}
```


Fields* [`context\_window (int)`](#llama_index.llms.base.LLMMetadata.context_window "llama_index.llms.base.LLMMetadata.context_window")
* [`is\_chat\_model (bool)`](#llama_index.llms.base.LLMMetadata.is_chat_model "llama_index.llms.base.LLMMetadata.is_chat_model")
* [`is\_function\_calling\_model (bool)`](#llama_index.llms.base.LLMMetadata.is_function_calling_model "llama_index.llms.base.LLMMetadata.is_function_calling_model")
* [`model\_name (str)`](#llama_index.llms.base.LLMMetadata.model_name "llama_index.llms.base.LLMMetadata.model_name")
* [`num\_output (int)`](#llama_index.llms.base.LLMMetadata.num_output "llama_index.llms.base.LLMMetadata.num_output")
*field* context\_window*: int* *= 3900*[](#llama_index.llms.base.LLMMetadata.context_window "Permalink to this definition")Total number of tokens the model can be input and output for one response.

*field* is\_chat\_model*: bool* *= False*[](#llama_index.llms.base.LLMMetadata.is_chat_model "Permalink to this definition")Set True if the model exposes a chat interface (i.e. can be passed a sequence of messages, rather than text), like OpenAI’s /v1/chat/completions endpoint.

*field* is\_function\_calling\_model*: bool* *= False*[](#llama_index.llms.base.LLMMetadata.is_function_calling_model "Permalink to this definition")Set True if the model supports function calling messages, similar to OpenAI’s function calling API. For example, converting ‘Email Anya to see if she wants to get coffee next Friday’ to a function call like send\_email(to: string, body: string).

*field* model\_name*: str* *= 'unknown'*[](#llama_index.llms.base.LLMMetadata.model_name "Permalink to this definition")The model’s name used for logging, testing, and sanity checking. For some models this can be automatically discerned. For other models, like locally loaded models, this must be manually specified.

*field* num\_output*: int* *= 256*[](#llama_index.llms.base.LLMMetadata.num_output "Permalink to this definition")Number of tokens the model can output when generating a response.

