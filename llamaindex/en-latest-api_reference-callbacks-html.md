Callbacks[](#module-llama_index.callbacks "Permalink to this heading")
=======================================================================

*class* llama\_index.callbacks.AimCallback(*repo: Optional[str] = None*, *experiment\_name: Optional[str] = None*, *system\_tracking\_interval: Optional[int] = 1*, *log\_system\_params: Optional[bool] = True*, *capture\_terminal\_logs: Optional[bool] = True*, *event\_starts\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *event\_ends\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *run\_params: Optional[Dict[str, Any]] = None*)[](#llama_index.callbacks.AimCallback "Permalink to this definition")AimCallback callback class.

Parameters* **repo** (`str`, optional) – Aim repository path or Repo object to which Run object is bound.If skipped, default Repo is used.
* **experiment\_name** (`str`, optional) – Sets Run’s experiment property. ‘default’ if not specified.Can be used later to query runs/sequences.
* **system\_tracking\_interval** (`int`, optional) – Sets the tracking interval in seconds for system usagemetrics (CPU, Memory, etc.). Set to None to disablesystem metrics tracking.
* **log\_system\_params** (`bool`, optional) – Enable/Disable logging of system params such as installed packages,git info, environment variables, etc.
* **capture\_terminal\_logs** (`bool`, optional) – Enable/Disable terminal stdout logging.
* **event\_starts\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types to ignore when tracking event starts.
* **event\_ends\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types to ignore when tracking event ends.
end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.AimCallback.end_trace "Permalink to this definition")Run when an overall trace is exited.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.AimCallback.on_event_end "Permalink to this definition")Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.AimCallback.on_event_start "Permalink to this definition")Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
* **parent\_id** (*str*) – parent event id.
start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.AimCallback.start_trace "Permalink to this definition")Run when an overall trace is launched.

*class* llama\_index.callbacks.CBEvent(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *time: str = ''*, *id\_: str = ''*)[](#llama_index.callbacks.CBEvent "Permalink to this definition")Generic class to store event information.

*class* llama\_index.callbacks.CBEventType(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.callbacks.CBEventType "Permalink to this definition")Callback manager event types.

CHUNKING[](#llama_index.callbacks.CBEventType.CHUNKING "Permalink to this definition")Logs for the before and after of text splitting.

NODE\_PARSING[](#llama_index.callbacks.CBEventType.NODE_PARSING "Permalink to this definition")Logs for the documents and the nodes that they are parsed into.

EMBEDDING[](#llama_index.callbacks.CBEventType.EMBEDDING "Permalink to this definition")Logs for the number of texts embedded.

LLM[](#llama_index.callbacks.CBEventType.LLM "Permalink to this definition")Logs for the template and response of LLM calls.

QUERY[](#llama_index.callbacks.CBEventType.QUERY "Permalink to this definition")Keeps track of the start and end of each query.

RETRIEVE[](#llama_index.callbacks.CBEventType.RETRIEVE "Permalink to this definition")Logs for the nodes retrieved for a query.

SYNTHESIZE[](#llama_index.callbacks.CBEventType.SYNTHESIZE "Permalink to this definition")Logs for the result for synthesize calls.

TREE[](#llama_index.callbacks.CBEventType.TREE "Permalink to this definition")Logs for the summary and level of summaries generated.

SUB\_QUESTION[](#llama_index.callbacks.CBEventType.SUB_QUESTION "Permalink to this definition")Logs for a generated sub question and answer.

capitalize()[](#llama_index.callbacks.CBEventType.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.callbacks.CBEventType.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.CBEventType.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.CBEventType.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.callbacks.CBEventType.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.callbacks.CBEventType.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.callbacks.CBEventType.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.CBEventType.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.callbacks.CBEventType.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.callbacks.CBEventType.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.CBEventType.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.callbacks.CBEventType.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.callbacks.CBEventType.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.callbacks.CBEventType.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.callbacks.CBEventType.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.callbacks.CBEventType.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.callbacks.CBEventType.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.callbacks.CBEventType.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.callbacks.CBEventType.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.callbacks.CBEventType.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.callbacks.CBEventType.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.callbacks.CBEventType.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.callbacks.CBEventType.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.callbacks.CBEventType.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.CBEventType.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.callbacks.CBEventType.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.callbacks.CBEventType.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.callbacks.CBEventType.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.callbacks.CBEventType.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.callbacks.CBEventType.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.callbacks.CBEventType.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.callbacks.CBEventType.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.CBEventType.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.CBEventType.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.CBEventType.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.callbacks.CBEventType.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.callbacks.CBEventType.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.callbacks.CBEventType.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.callbacks.CBEventType.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.callbacks.CBEventType.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.callbacks.CBEventType.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.callbacks.CBEventType.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.callbacks.CBEventType.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.callbacks.CBEventType.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.callbacks.CBEventType.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.callbacks.CBEventType.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.callbacks.CBEventType.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*class* llama\_index.callbacks.CallbackManager(*handlers: Optional[List[BaseCallbackHandler]] = None*)[](#llama_index.callbacks.CallbackManager "Permalink to this definition")Callback manager that handles callbacks for events within LlamaIndex.

The callback manager provides a way to call handlers on event starts/ends.

Additionally, the callback manager traces the current stack of events.It does this by using a few key attributes.- trace\_stack - The current stack of events that have not ended yet.


> When an event ends, it’s removed from the stack.Since this is a contextvar, it is unique to eachthread/task.
> 
> 

* trace\_map - A mapping of event ids to their children events.On the start of events, the bottom of the trace stackis used as the current parent event for the trace map.
* trace\_id - A simple name for the current trace, usually denoting theentrypoint (query, index\_construction, insert, etc.)

Parameters**handlers** (*List**[**BaseCallbackHandler**]*) – list of handlers to use.

Usage:with callback\_manager.event(CBEventType.QUERY) as event:event.on\_start(payload={key, val})…event.on\_end(payload={key, val})

add\_handler(*handler: BaseCallbackHandler*) → None[](#llama_index.callbacks.CallbackManager.add_handler "Permalink to this definition")Add a handler to the callback manager.

as\_trace(*trace\_id: str*) → Generator[None, None, None][](#llama_index.callbacks.CallbackManager.as_trace "Permalink to this definition")Context manager tracer for lanching and shutdown of traces.

end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.CallbackManager.end_trace "Permalink to this definition")Run when an overall trace is exited.

event(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: Optional[str] = None*) → Generator[EventContext, None, None][](#llama_index.callbacks.CallbackManager.event "Permalink to this definition")Context manager for lanching and shutdown of events.

Handles sending on\_evnt\_start and on\_event\_end to handlers for specified event.

Usage:with callback\_manager.event(CBEventType.QUERY, payload={key, val}) as event:…event.on\_end(payload={key, val}) # optional

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: Optional[str] = None*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.CallbackManager.on_event_end "Permalink to this definition")Run handlers when an event ends.

on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: Optional[str] = None*, *parent\_id: Optional[str] = None*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.CallbackManager.on_event_start "Permalink to this definition")Run handlers when an event starts and return id of event.

remove\_handler(*handler: BaseCallbackHandler*) → None[](#llama_index.callbacks.CallbackManager.remove_handler "Permalink to this definition")Remove a handler from the callback manager.

set\_handlers(*handlers: List[BaseCallbackHandler]*) → None[](#llama_index.callbacks.CallbackManager.set_handlers "Permalink to this definition")Set handlers as the only handlers on the callback manager.

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.CallbackManager.start_trace "Permalink to this definition")Run when an overall trace is launched.

*class* llama\_index.callbacks.EventPayload(*value*, *names=None*, *\**, *module=None*, *qualname=None*, *type=None*, *start=1*, *boundary=None*)[](#llama_index.callbacks.EventPayload "Permalink to this definition")capitalize()[](#llama_index.callbacks.EventPayload.capitalize "Permalink to this definition")Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lowercase.

casefold()[](#llama_index.callbacks.EventPayload.casefold "Permalink to this definition")Return a version of the string suitable for caseless comparisons.

center(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.EventPayload.center "Permalink to this definition")Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

count(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.EventPayload.count "Permalink to this definition")Return the number of non-overlapping occurrences of substring sub instring S[start:end]. Optional arguments start and end areinterpreted as in slice notation.

encode(*encoding='utf-8'*, *errors='strict'*)[](#llama_index.callbacks.EventPayload.encode "Permalink to this definition")Encode the string using the codec registered for encoding.

encodingThe encoding in which to encode the string.

errorsThe error handling scheme to use for encoding errors.The default is ‘strict’ meaning that encoding errors raise aUnicodeEncodeError. Other possible values are ‘ignore’, ‘replace’ and‘xmlcharrefreplace’ as well as any other name registered withcodecs.register\_error that can handle UnicodeEncodeErrors.

endswith(*suffix*[, *start*[, *end*]]) → bool[](#llama_index.callbacks.EventPayload.endswith "Permalink to this definition")Return True if S ends with the specified suffix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.suffix can also be a tuple of strings to try.

expandtabs(*tabsize=8*)[](#llama_index.callbacks.EventPayload.expandtabs "Permalink to this definition")Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

find(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.EventPayload.find "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

format(*\*args*, *\*\*kwargs*) → str[](#llama_index.callbacks.EventPayload.format "Permalink to this definition")Return a formatted version of S, using substitutions from args and kwargs.The substitutions are identified by braces (‘{‘ and ‘}’).

format\_map(*mapping*) → str[](#llama_index.callbacks.EventPayload.format_map "Permalink to this definition")Return a formatted version of S, using substitutions from mapping.The substitutions are identified by braces (‘{‘ and ‘}’).

index(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.EventPayload.index "Permalink to this definition")Return the lowest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

isalnum()[](#llama_index.callbacks.EventPayload.isalnum "Permalink to this definition")Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric andthere is at least one character in the string.

isalpha()[](#llama_index.callbacks.EventPayload.isalpha "Permalink to this definition")Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and thereis at least one character in the string.

isascii()[](#llama_index.callbacks.EventPayload.isascii "Permalink to this definition")Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F.Empty string is ASCII too.

isdecimal()[](#llama_index.callbacks.EventPayload.isdecimal "Permalink to this definition")Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal andthere is at least one character in the string.

isdigit()[](#llama_index.callbacks.EventPayload.isdigit "Permalink to this definition")Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and thereis at least one character in the string.

isidentifier()[](#llama_index.callbacks.EventPayload.isidentifier "Permalink to this definition")Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier,such as “def” or “class”.

islower()[](#llama_index.callbacks.EventPayload.islower "Permalink to this definition")Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase andthere is at least one cased character in the string.

isnumeric()[](#llama_index.callbacks.EventPayload.isnumeric "Permalink to this definition")Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is atleast one character in the string.

isprintable()[](#llama_index.callbacks.EventPayload.isprintable "Permalink to this definition")Return True if the string is printable, False otherwise.

A string is printable if all of its characters are considered printable inrepr() or if it is empty.

isspace()[](#llama_index.callbacks.EventPayload.isspace "Permalink to this definition")Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and thereis at least one character in the string.

istitle()[](#llama_index.callbacks.EventPayload.istitle "Permalink to this definition")Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may onlyfollow uncased characters and lowercase characters only cased ones.

isupper()[](#llama_index.callbacks.EventPayload.isupper "Permalink to this definition")Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase andthere is at least one cased character in the string.

join(*iterable*, */*)[](#llama_index.callbacks.EventPayload.join "Permalink to this definition")Concatenate any number of strings.

The string whose method is called is inserted in between each given string.The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

ljust(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.EventPayload.ljust "Permalink to this definition")Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

lower()[](#llama_index.callbacks.EventPayload.lower "Permalink to this definition")Return a copy of the string converted to lowercase.

lstrip(*chars=None*, */*)[](#llama_index.callbacks.EventPayload.lstrip "Permalink to this definition")Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

*static* maketrans()[](#llama_index.callbacks.EventPayload.maketrans "Permalink to this definition")Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicodeordinals (integers) or characters to Unicode ordinals, strings or None.Character keys will be then converted to ordinals.If there are two arguments, they must be strings of equal length, andin the resulting dictionary, each character in x will be mapped to thecharacter at the same position in y. If there is a third argument, itmust be a string, whose characters will be mapped to None in the result.

partition(*sep*, */*)[](#llama_index.callbacks.EventPayload.partition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string. If the separator is found,returns a 3-tuple containing the part before the separator, the separatoritself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original stringand two empty strings.

removeprefix(*prefix*, */*)[](#llama_index.callbacks.EventPayload.removeprefix "Permalink to this definition")Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):].Otherwise, return a copy of the original string.

removesuffix(*suffix*, */*)[](#llama_index.callbacks.EventPayload.removesuffix "Permalink to this definition")Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty,return string[:-len(suffix)]. Otherwise, return a copy of the originalstring.

replace(*old*, *new*, *count=-1*, */*)[](#llama_index.callbacks.EventPayload.replace "Permalink to this definition")Return a copy with all occurrences of substring old replaced by new.


> countMaximum number of occurrences to replace.-1 (the default value) means replace all occurrences.
> 
> 

If the optional argument count is given, only the first count occurrences arereplaced.

rfind(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.EventPayload.rfind "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Return -1 on failure.

rindex(*sub*[, *start*[, *end*]]) → int[](#llama_index.callbacks.EventPayload.rindex "Permalink to this definition")Return the highest index in S where substring sub is found,such that sub is contained within S[start:end]. Optionalarguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

rjust(*width*, *fillchar=' '*, */*)[](#llama_index.callbacks.EventPayload.rjust "Permalink to this definition")Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

rpartition(*sep*, */*)[](#llama_index.callbacks.EventPayload.rpartition "Permalink to this definition")Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. Ifthe separator is found, returns a 3-tuple containing the part before theseparator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty stringsand the original string.

rsplit(*sep=None*, *maxsplit=-1*)[](#llama_index.callbacks.EventPayload.rsplit "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Splitting starts at the end of the string and works to the front.

rstrip(*chars=None*, */*)[](#llama_index.callbacks.EventPayload.rstrip "Permalink to this definition")Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

split(*sep=None*, *maxsplit=-1*)[](#llama_index.callbacks.EventPayload.split "Permalink to this definition")Return a list of the substrings in the string, using sep as the separator string.


> sepThe separator used to split the string.
> 
> When set to None (the default value), will split on any whitespacecharacter (including n r t f and spaces) and will discardempty strings from the result.
> 
> maxsplitMaximum number of splits (starting from the left).-1 (the default value) means no limit.
> 
> 

Note, str.split() is mainly useful for data that has been intentionallydelimited. With natural text that includes punctuation, consider usingthe regular expression module.

splitlines(*keepends=False*)[](#llama_index.callbacks.EventPayload.splitlines "Permalink to this definition")Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given andtrue.

startswith(*prefix*[, *start*[, *end*]]) → bool[](#llama_index.callbacks.EventPayload.startswith "Permalink to this definition")Return True if S starts with the specified prefix, False otherwise.With optional start, test S beginning at that position.With optional end, stop comparing S at that position.prefix can also be a tuple of strings to try.

strip(*chars=None*, */*)[](#llama_index.callbacks.EventPayload.strip "Permalink to this definition")Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

swapcase()[](#llama_index.callbacks.EventPayload.swapcase "Permalink to this definition")Convert uppercase characters to lowercase and lowercase characters to uppercase.

title()[](#llama_index.callbacks.EventPayload.title "Permalink to this definition")Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remainingcased characters have lower case.

translate(*table*, */*)[](#llama_index.callbacks.EventPayload.translate "Permalink to this definition")Replace each character in the string using the given translation table.


> tableTranslation table, which must be a mapping of Unicode ordinals toUnicode ordinals, strings, or None.
> 
> 

The table must implement lookup/indexing via \_\_getitem\_\_, for instance adictionary or list. If this operation raises LookupError, the character isleft untouched. Characters mapped to None are deleted.

upper()[](#llama_index.callbacks.EventPayload.upper "Permalink to this definition")Return a copy of the string converted to uppercase.

zfill(*width*, */*)[](#llama_index.callbacks.EventPayload.zfill "Permalink to this definition")Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

*class* llama\_index.callbacks.GradientAIFineTuningHandler[](#llama_index.callbacks.GradientAIFineTuningHandler "Permalink to this definition")Callback handler for Gradient AI fine-tuning.

This handler will collect all messagessent to the LLM, along with their responses. It will then save these messagesin a .jsonl format that can be used for fine-tuning with Gradient AI’s API.

end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.GradientAIFineTuningHandler.end_trace "Permalink to this definition")Run when an overall trace is exited.

get\_finetuning\_events() → Dict[str, Dict[str, Any]][](#llama_index.callbacks.GradientAIFineTuningHandler.get_finetuning_events "Permalink to this definition")Get finetuning events.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.GradientAIFineTuningHandler.on_event_end "Permalink to this definition")Run when an event ends.

on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.GradientAIFineTuningHandler.on_event_start "Permalink to this definition")Run when an event starts and return id of event.

save\_finetuning\_events(*path: str*) → None[](#llama_index.callbacks.GradientAIFineTuningHandler.save_finetuning_events "Permalink to this definition")Save the finetuning events to a file.

This saved format can be used for fine-tuning with OpenAI’s API.The structure for each json line is as follows:{


> “inputs”: “<full\_prompt\_str>”
> 
> 

},[](#id1 "Permalink to this heading")
---------------------------------------

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.GradientAIFineTuningHandler.start_trace "Permalink to this definition")Run when an overall trace is launched.

*class* llama\_index.callbacks.LlamaDebugHandler(*event\_starts\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *event\_ends\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *print\_trace\_on\_end: bool = True*)[](#llama_index.callbacks.LlamaDebugHandler "Permalink to this definition")Callback handler that keeps track of debug info.

NOTE: this is a beta feature. The usage within our codebase, and the interfacemay change.

This handler simply keeps track of event starts/ends, separated by event types.You can use this callback handler to keep track of and debug events.

Parameters* **event\_starts\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types toignore when tracking event starts.
* **event\_ends\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types toignore when tracking event ends.
end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.LlamaDebugHandler.end_trace "Permalink to this definition")Shutdown the current trace.

flush\_event\_logs() → None[](#llama_index.callbacks.LlamaDebugHandler.flush_event_logs "Permalink to this definition")Clear all events from memory.

get\_event\_pairs(*event\_type: Optional[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")] = None*) → List[List[[CBEvent](#llama_index.callbacks.CBEvent "llama_index.callbacks.schema.CBEvent")]][](#llama_index.callbacks.LlamaDebugHandler.get_event_pairs "Permalink to this definition")Pair events by ID, either all events or a specific type.

get\_events(*event\_type: Optional[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")] = None*) → List[[CBEvent](#llama_index.callbacks.CBEvent "llama_index.callbacks.schema.CBEvent")][](#llama_index.callbacks.LlamaDebugHandler.get_events "Permalink to this definition")Get all events for a specific event type.

get\_llm\_inputs\_outputs() → List[List[[CBEvent](#llama_index.callbacks.CBEvent "llama_index.callbacks.schema.CBEvent")]][](#llama_index.callbacks.LlamaDebugHandler.get_llm_inputs_outputs "Permalink to this definition")Get the exact LLM inputs and outputs.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.LlamaDebugHandler.on_event_end "Permalink to this definition")Store event end data by event type.

Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.LlamaDebugHandler.on_event_start "Permalink to this definition")Store event start data by event type.

Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
* **parent\_id** (*str*) – parent event id.
print\_trace\_map() → None[](#llama_index.callbacks.LlamaDebugHandler.print_trace_map "Permalink to this definition")Print simple trace map to terminal for debugging of the most recent trace.

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.LlamaDebugHandler.start_trace "Permalink to this definition")Launch a trace.

*class* llama\_index.callbacks.OpenAIFineTuningHandler[](#llama_index.callbacks.OpenAIFineTuningHandler "Permalink to this definition")Callback handler for OpenAI fine-tuning.

This handler will collect all messagessent to the LLM, along with their responses. It will then save these messagesin a .jsonl format that can be used for fine-tuning with OpenAI’s API.

end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.OpenAIFineTuningHandler.end_trace "Permalink to this definition")Run when an overall trace is exited.

get\_finetuning\_events() → Dict[str, Dict[str, Any]][](#llama_index.callbacks.OpenAIFineTuningHandler.get_finetuning_events "Permalink to this definition")Get finetuning events.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.OpenAIFineTuningHandler.on_event_end "Permalink to this definition")Run when an event ends.

on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.OpenAIFineTuningHandler.on_event_start "Permalink to this definition")Run when an event starts and return id of event.

save\_finetuning\_events(*path: str*) → None[](#llama_index.callbacks.OpenAIFineTuningHandler.save_finetuning_events "Permalink to this definition")Save the finetuning events to a file.

This saved format can be used for fine-tuning with OpenAI’s API.The structure for each json line is as follows:{


> messages: [{ rol: “system”, content: “Text”},{ role: “user”, content: “Text” },
> 
> ]
> 
> 

},[](#id2 "Permalink to this heading")
---------------------------------------

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.OpenAIFineTuningHandler.start_trace "Permalink to this definition")Run when an overall trace is launched.

*class* llama\_index.callbacks.OpenInferenceCallbackHandler(*callback: Optional[Callable[[List[QueryData]], None]] = None*)[](#llama_index.callbacks.OpenInferenceCallbackHandler "Permalink to this definition")Callback handler for storing generation data in OpenInference format.OpenInference is an open standard for capturing and storing AI modelinferences. It enables production LLMapp servers to seamlessly integratewith LLM observability solutions such as Arize and Phoenix.

For more information on the specification, see<https://github.com/Arize-ai/open-inference-spec>

end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.OpenInferenceCallbackHandler.end_trace "Permalink to this definition")Run when an overall trace is exited.

flush\_node\_data\_buffer() → List[NodeData][](#llama_index.callbacks.OpenInferenceCallbackHandler.flush_node_data_buffer "Permalink to this definition")Clears the node data buffer and returns the data.

ReturnsThe node data.

Return typeList[NodeData]

flush\_query\_data\_buffer() → List[QueryData][](#llama_index.callbacks.OpenInferenceCallbackHandler.flush_query_data_buffer "Permalink to this definition")Clears the query data buffer and returns the data.

ReturnsThe query data.

Return typeList[QueryData]

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.OpenInferenceCallbackHandler.on_event_end "Permalink to this definition")Run when an event ends.

on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.OpenInferenceCallbackHandler.on_event_start "Permalink to this definition")Run when an event starts and return id of event.

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.OpenInferenceCallbackHandler.start_trace "Permalink to this definition")Run when an overall trace is launched.

*class* llama\_index.callbacks.TokenCountingHandler(*tokenizer: Optional[Callable[[str], List]] = None*, *event\_starts\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *event\_ends\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *verbose: bool = False*)[](#llama_index.callbacks.TokenCountingHandler "Permalink to this definition")Callback handler for counting tokens in LLM and Embedding events.

Parameters* **tokenizer** – Tokenizer to use. Defaults to the global tokenizer(see llama\_index.utils.globals\_helper).
* **event\_starts\_to\_ignore** – List of event types to ignore at the start of a trace.
* **event\_ends\_to\_ignore** – List of event types to ignore at the end of a trace.
*property* completion\_llm\_token\_count*: int*[](#llama_index.callbacks.TokenCountingHandler.completion_llm_token_count "Permalink to this definition")Get the current total LLM completion token count.

end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.TokenCountingHandler.end_trace "Permalink to this definition")Run when an overall trace is exited.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.TokenCountingHandler.on_event_end "Permalink to this definition")Count the LLM or Embedding tokens as needed.

on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.TokenCountingHandler.on_event_start "Permalink to this definition")Run when an event starts and return id of event.

*property* prompt\_llm\_token\_count*: int*[](#llama_index.callbacks.TokenCountingHandler.prompt_llm_token_count "Permalink to this definition")Get the current total LLM prompt token count.

reset\_counts() → None[](#llama_index.callbacks.TokenCountingHandler.reset_counts "Permalink to this definition")Reset the token counts.

start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.TokenCountingHandler.start_trace "Permalink to this definition")Run when an overall trace is launched.

*property* total\_embedding\_token\_count*: int*[](#llama_index.callbacks.TokenCountingHandler.total_embedding_token_count "Permalink to this definition")Get the current total Embedding token count.

*property* total\_llm\_token\_count*: int*[](#llama_index.callbacks.TokenCountingHandler.total_llm_token_count "Permalink to this definition")Get the current total LLM token count.

*class* llama\_index.callbacks.WandbCallbackHandler(*run\_args: Optional[WandbRunArgs] = None*, *tokenizer: Optional[Callable[[str], List]] = None*, *event\_starts\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*, *event\_ends\_to\_ignore: Optional[List[[CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")]] = None*)[](#llama_index.callbacks.WandbCallbackHandler "Permalink to this definition")Callback handler that logs events to wandb.

NOTE: this is a beta feature. The usage within our codebase, and the interfacemay change.

Use the WandbCallbackHandler to log trace events to wandb. This handler isuseful for debugging and visualizing the trace events. It captures the payload ofthe events and logs them to wandb. The handler also tracks the start and end ofevents. This is particularly useful for debugging your LLM calls.

The WandbCallbackHandler can also be used to log the indices and graphs to wandbusing the persist\_index method. This will save the indexes as artifacts in wandb.The load\_storage\_context method can be used to load the indexes from wandbartifacts. This method will return a StorageContext object that can be used tobuild the index, using load\_index\_from\_storage, load\_indices\_from\_storage orload\_graph\_from\_storage functions.

Parameters* **event\_starts\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types toignore when tracking event starts.
* **event\_ends\_to\_ignore** (*Optional**[**List**[*[*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")*]**]*) – list of event types toignore when tracking event ends.
end\_trace(*trace\_id: Optional[str] = None*, *trace\_map: Optional[Dict[str, List[str]]] = None*) → None[](#llama_index.callbacks.WandbCallbackHandler.end_trace "Permalink to this definition")Run when an overall trace is exited.

finish() → None[](#llama_index.callbacks.WandbCallbackHandler.finish "Permalink to this definition")Finish the callback handler.

load\_storage\_context(*artifact\_url: str*, *index\_download\_dir: Optional[str] = None*) → [StorageContext](storage.html#llama_index.storage.storage_context.StorageContext "llama_index.storage.storage_context.StorageContext")[](#llama_index.callbacks.WandbCallbackHandler.load_storage_context "Permalink to this definition")Download an index from wandb and return a storage context.

Use this storage context to load the index into memory usingload\_index\_from\_storage, load\_indices\_from\_storage orload\_graph\_from\_storage functions.

Parameters* **artifact\_url** (*str*) – url of the artifact to download. The artifact url willbe of the form: entity/project/index\_name:version and can be found inthe W&B UI.
* **index\_download\_dir** (*Union**[**str**,* *None**]*) – directory to download the index to.
log\_trace\_tree() → None[](#llama_index.callbacks.WandbCallbackHandler.log_trace_tree "Permalink to this definition")Log the trace tree to wandb.

on\_event\_end(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *\*\*kwargs: Any*) → None[](#llama_index.callbacks.WandbCallbackHandler.on_event_end "Permalink to this definition")Store event end data by event type.

Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
on\_event\_start(*event\_type: [CBEventType](#llama_index.callbacks.CBEventType "llama_index.callbacks.schema.CBEventType")*, *payload: Optional[Dict[str, Any]] = None*, *event\_id: str = ''*, *parent\_id: str = ''*, *\*\*kwargs: Any*) → str[](#llama_index.callbacks.WandbCallbackHandler.on_event_start "Permalink to this definition")Store event start data by event type.

Parameters* **event\_type** ([*CBEventType*](#llama_index.callbacks.CBEventType "llama_index.callbacks.CBEventType")) – event type to store.
* **payload** (*Optional**[**Dict**[**str**,* *Any**]**]*) – payload to store.
* **event\_id** (*str*) – event id to store.
* **parent\_id** (*str*) – parent event id.
persist\_index(*index: IndexType*, *index\_name: str*, *persist\_dir: Optional[str] = None*) → None[](#llama_index.callbacks.WandbCallbackHandler.persist_index "Permalink to this definition")Upload an index to wandb as an artifact. You can learn more about W&Bartifacts here: <https://docs.wandb.ai/guides/artifacts>.

For the ComposableGraph index, the root id is stored as artifact metadata.

Parameters* **index** (*IndexType*) – index to upload.
* **index\_name** (*str*) – name of the index. This will be used as the artifact name.
* **persist\_dir** (*Union**[**str**,* *None**]*) – directory to persist the index. If None, atemporary directory will be created and used.
start\_trace(*trace\_id: Optional[str] = None*) → None[](#llama_index.callbacks.WandbCallbackHandler.start_trace "Permalink to this definition")Launch a trace.

llama\_index.callbacks.trace\_method(*trace\_id: str*, *callback\_manager\_attr: str = 'callback\_manager'*) → Callable[[Callable], Callable][](#llama_index.callbacks.trace_method "Permalink to this definition")Decorator to trace a method.

Example

@trace\_method(“my\_trace\_id”)def my\_method(self):


> pass
> 
> 

Assumes that the self instance has a CallbackManager instance in an attributenamed callback\_manager.This can be overridden by passing in a callback\_manager\_attr keyword argument.

