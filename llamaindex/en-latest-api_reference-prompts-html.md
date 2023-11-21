Prompt Templates[](#prompt-templates "Permalink to this heading")
==================================================================

These are the reference prompt templates.

We first show links to default prompts.

We then show the base prompt template class and its subclasses.

Default Prompts[](#default-prompts "Permalink to this heading")
----------------------------------------------------------------

* [Completion prompt templates](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/default_prompts.py).
* [Chat prompt templates](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/chat_prompts.py).
* [Selector prompt templates](https://github.com/jerryjliu/llama_index/blob/main/llama_index/prompts/default_prompt_selectors.py).
Prompt Classes[](#prompt-classes "Permalink to this heading")
--------------------------------------------------------------

*pydantic model* llama\_index.prompts.base.BasePromptTemplate[](#llama_index.prompts.base.BasePromptTemplate "Permalink to this definition")Show JSON schema
```
{ "title": "BasePromptTemplate", "type": "object", "properties": { "metadata": { "title": "Metadata", "type": "object" }, "template\_vars": { "title": "Template Vars", "type": "array", "items": { "type": "string" } }, "kwargs": { "title": "Kwargs", "type": "object", "additionalProperties": { "type": "string" } }, "output\_parser": { "title": "Output Parser" }, "template\_var\_mappings": { "title": "Template Var Mappings", "description": "Template variable mappings (Optional).", "type": "object" } }, "required": [ "metadata", "template\_vars", "kwargs" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`function\_mappings (Optional[Dict[str, Callable]])`](#llama_index.prompts.base.BasePromptTemplate.function_mappings "llama_index.prompts.base.BasePromptTemplate.function_mappings")
* [`kwargs (Dict[str, str])`](#llama_index.prompts.base.BasePromptTemplate.kwargs "llama_index.prompts.base.BasePromptTemplate.kwargs")
* [`metadata (Dict[str, Any])`](#llama_index.prompts.base.BasePromptTemplate.metadata "llama_index.prompts.base.BasePromptTemplate.metadata")
* [`output\_parser (Optional[llama\_index.types.BaseOutputParser])`](#llama_index.prompts.base.BasePromptTemplate.output_parser "llama_index.prompts.base.BasePromptTemplate.output_parser")
* [`template\_var\_mappings (Optional[Dict[str, Any]])`](#llama_index.prompts.base.BasePromptTemplate.template_var_mappings "llama_index.prompts.base.BasePromptTemplate.template_var_mappings")
* [`template\_vars (List[str])`](#llama_index.prompts.base.BasePromptTemplate.template_vars "llama_index.prompts.base.BasePromptTemplate.template_vars")
*field* function\_mappings*: Optional[Dict[str, Callable]]* *[Optional]*[](#llama_index.prompts.base.BasePromptTemplate.function_mappings "Permalink to this definition")Function mappings (Optional). This is a mapping from template variable names to functions that take in the current kwargs and return a string.

*field* kwargs*: Dict[str, str]* *[Required]*[](#llama_index.prompts.base.BasePromptTemplate.kwargs "Permalink to this definition")*field* metadata*: Dict[str, Any]* *[Required]*[](#llama_index.prompts.base.BasePromptTemplate.metadata "Permalink to this definition")*field* output\_parser*: Optional[BaseOutputParser]* *= None*[](#llama_index.prompts.base.BasePromptTemplate.output_parser "Permalink to this definition")*field* template\_var\_mappings*: Optional[Dict[str, Any]]* *[Optional]*[](#llama_index.prompts.base.BasePromptTemplate.template_var_mappings "Permalink to this definition")Template variable mappings (Optional).

*field* template\_vars*: List[str]* *[Required]*[](#llama_index.prompts.base.BasePromptTemplate.template_vars "Permalink to this definition")*abstract* format(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → str[](#llama_index.prompts.base.BasePromptTemplate.format "Permalink to this definition")*abstract* format\_messages(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.prompts.base.BasePromptTemplate.format_messages "Permalink to this definition")*abstract* get\_template(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → str[](#llama_index.prompts.base.BasePromptTemplate.get_template "Permalink to this definition")*abstract* partial\_format(*\*\*kwargs: Any*) → [BasePromptTemplate](#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")[](#llama_index.prompts.base.BasePromptTemplate.partial_format "Permalink to this definition")*pydantic model* llama\_index.prompts.base.PromptTemplate[](#llama_index.prompts.base.PromptTemplate "Permalink to this definition")Show JSON schema
```
{ "title": "PromptTemplate", "type": "object", "properties": { "metadata": { "title": "Metadata", "type": "object" }, "template\_vars": { "title": "Template Vars", "type": "array", "items": { "type": "string" } }, "kwargs": { "title": "Kwargs", "type": "object", "additionalProperties": { "type": "string" } }, "output\_parser": { "title": "Output Parser" }, "template\_var\_mappings": { "title": "Template Var Mappings", "description": "Template variable mappings (Optional).", "type": "object" }, "template": { "title": "Template", "type": "string" } }, "required": [ "metadata", "template\_vars", "kwargs", "template" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`template (str)`](#llama_index.prompts.base.PromptTemplate.template "llama_index.prompts.base.PromptTemplate.template")
*field* template*: str* *[Required]*[](#llama_index.prompts.base.PromptTemplate.template "Permalink to this definition")format(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → str[](#llama_index.prompts.base.PromptTemplate.format "Permalink to this definition")Format the prompt into a string.

format\_messages(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.prompts.base.PromptTemplate.format_messages "Permalink to this definition")Format the prompt into a list of chat messages.

get\_template(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → str[](#llama_index.prompts.base.PromptTemplate.get_template "Permalink to this definition")partial\_format(*\*\*kwargs: Any*) → [PromptTemplate](#llama_index.prompts.base.PromptTemplate "llama_index.prompts.base.PromptTemplate")[](#llama_index.prompts.base.PromptTemplate.partial_format "Permalink to this definition")Partially format the prompt.

*pydantic model* llama\_index.prompts.base.ChatPromptTemplate[](#llama_index.prompts.base.ChatPromptTemplate "Permalink to this definition")Show JSON schema
```
{ "title": "ChatPromptTemplate", "type": "object", "properties": { "metadata": { "title": "Metadata", "type": "object" }, "template\_vars": { "title": "Template Vars", "type": "array", "items": { "type": "string" } }, "kwargs": { "title": "Kwargs", "type": "object", "additionalProperties": { "type": "string" } }, "output\_parser": { "title": "Output Parser" }, "template\_var\_mappings": { "title": "Template Var Mappings", "description": "Template variable mappings (Optional).", "type": "object" }, "message\_templates": { "title": "Message Templates", "type": "array", "items": { "$ref": "#/definitions/ChatMessage" } } }, "required": [ "metadata", "template\_vars", "kwargs", "message\_templates" ], "definitions": { "MessageRole": { "title": "MessageRole", "description": "Message role.", "enum": [ "system", "user", "assistant", "function", "tool" ], "type": "string" }, "ChatMessage": { "title": "ChatMessage", "description": "Chat message.", "type": "object", "properties": { "role": { "default": "user", "allOf": [ { "$ref": "#/definitions/MessageRole" } ] }, "content": { "title": "Content", "default": "", "type": "string" }, "additional\_kwargs": { "title": "Additional Kwargs", "type": "object" } } } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`message\_templates (List[llama\_index.llms.base.ChatMessage])`](#llama_index.prompts.base.ChatPromptTemplate.message_templates "llama_index.prompts.base.ChatPromptTemplate.message_templates")
*field* message\_templates*: List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]* *[Required]*[](#llama_index.prompts.base.ChatPromptTemplate.message_templates "Permalink to this definition")format(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → str[](#llama_index.prompts.base.ChatPromptTemplate.format "Permalink to this definition")format\_messages(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.prompts.base.ChatPromptTemplate.format_messages "Permalink to this definition")get\_template(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → str[](#llama_index.prompts.base.ChatPromptTemplate.get_template "Permalink to this definition")partial\_format(*\*\*kwargs: Any*) → [ChatPromptTemplate](#llama_index.prompts.base.ChatPromptTemplate "llama_index.prompts.base.ChatPromptTemplate")[](#llama_index.prompts.base.ChatPromptTemplate.partial_format "Permalink to this definition")*pydantic model* llama\_index.prompts.base.SelectorPromptTemplate[](#llama_index.prompts.base.SelectorPromptTemplate "Permalink to this definition")Show JSON schema
```
{ "title": "SelectorPromptTemplate", "type": "object", "properties": { "metadata": { "title": "Metadata", "type": "object" }, "template\_vars": { "title": "Template Vars", "type": "array", "items": { "type": "string" } }, "kwargs": { "title": "Kwargs", "type": "object", "additionalProperties": { "type": "string" } }, "output\_parser": { "title": "Output Parser" }, "template\_var\_mappings": { "title": "Template Var Mappings", "description": "Template variable mappings (Optional).", "type": "object" }, "default\_template": { "title": "Default Template" }, "conditionals": { "title": "Conditionals" } }, "required": [ "metadata", "template\_vars", "kwargs" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`conditionals (Optional[List[Tuple[Callable[[llama\_index.llms.base.LLM], bool], llama\_index.prompts.base.BasePromptTemplate]]])`](#llama_index.prompts.base.SelectorPromptTemplate.conditionals "llama_index.prompts.base.SelectorPromptTemplate.conditionals")
* [`default\_template (llama\_index.prompts.base.BasePromptTemplate)`](#llama_index.prompts.base.SelectorPromptTemplate.default_template "llama_index.prompts.base.SelectorPromptTemplate.default_template")
*field* conditionals*: Optional[List[Tuple[Callable[[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")], bool], [BasePromptTemplate](#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]]]* *= None*[](#llama_index.prompts.base.SelectorPromptTemplate.conditionals "Permalink to this definition")*field* default\_template*: [BasePromptTemplate](#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")* *[Required]*[](#llama_index.prompts.base.SelectorPromptTemplate.default_template "Permalink to this definition")format(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → str[](#llama_index.prompts.base.SelectorPromptTemplate.format "Permalink to this definition")Format the prompt into a string.

format\_messages(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.prompts.base.SelectorPromptTemplate.format_messages "Permalink to this definition")Format the prompt into a list of chat messages.

get\_template(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → str[](#llama_index.prompts.base.SelectorPromptTemplate.get_template "Permalink to this definition")partial\_format(*\*\*kwargs: Any*) → [SelectorPromptTemplate](#llama_index.prompts.base.SelectorPromptTemplate "llama_index.prompts.base.SelectorPromptTemplate")[](#llama_index.prompts.base.SelectorPromptTemplate.partial_format "Permalink to this definition")*pydantic model* llama\_index.prompts.base.LangchainPromptTemplate[](#llama_index.prompts.base.LangchainPromptTemplate "Permalink to this definition")Show JSON schema
```
{ "title": "LangchainPromptTemplate", "type": "object", "properties": { "metadata": { "title": "Metadata", "type": "object" }, "template\_vars": { "title": "Template Vars", "type": "array", "items": { "type": "string" } }, "kwargs": { "title": "Kwargs", "type": "object", "additionalProperties": { "type": "string" } }, "output\_parser": { "title": "Output Parser" }, "template\_var\_mappings": { "title": "Template Var Mappings", "description": "Template variable mappings (Optional).", "type": "object" }, "selector": { "$ref": "#/definitions/ConditionalPromptSelector" }, "requires\_langchain\_llm": { "title": "Requires Langchain Llm", "default": false, "type": "boolean" } }, "required": [ "metadata", "template\_vars", "kwargs", "selector" ], "definitions": { "BaseOutputParser": { "title": "BaseOutputParser", "description": "Base class to parse the output of an LLM call.\n\nOutput parsers help structure language model responses.\n\nExample:\n .. code-block:: python\n\n class BooleanOutputParser(BaseOutputParser[bool]):\n true\_val: str = \"YES\"\n false\_val: str = \"NO\"\n\n def parse(self, text: str) -> bool:\n cleaned\_text = text.strip().upper()\n if cleaned\_text not in (self.true\_val.upper(), self.false\_val.upper()):\n raise OutputParserException(\n f\"BooleanOutputParser expected output value to either be \"\n f\"{self.true\_val} or {self.false\_val} (case-insensitive). \"\n f\"Received {cleaned\_text}.\"\n )\n return cleaned\_text == self.true\_val.upper()\n\n @property\n def \_type(self) -> str:\n return \"boolean\_output\_parser\"", "type": "object", "properties": {} }, "BasePromptTemplate": { "title": "BasePromptTemplate", "description": "Base class for all prompt templates, returning a prompt.", "type": "object", "properties": { "input\_variables": { "title": "Input Variables", "type": "array", "items": { "type": "string" } }, "input\_types": { "title": "Input Types", "type": "object" }, "output\_parser": { "$ref": "#/definitions/BaseOutputParser" } }, "required": [ "input\_variables" ] }, "ConditionalPromptSelector": { "title": "ConditionalPromptSelector", "description": "Prompt collection that goes through conditionals.", "type": "object", "properties": { "default\_prompt": { "$ref": "#/definitions/BasePromptTemplate" } }, "required": [ "default\_prompt" ] } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`requires\_langchain\_llm (bool)`](#llama_index.prompts.base.LangchainPromptTemplate.requires_langchain_llm "llama_index.prompts.base.LangchainPromptTemplate.requires_langchain_llm")
* [`selector (langchain.chains.prompt\_selector.ConditionalPromptSelector)`](#llama_index.prompts.base.LangchainPromptTemplate.selector "llama_index.prompts.base.LangchainPromptTemplate.selector")
*field* requires\_langchain\_llm*: bool* *= False*[](#llama_index.prompts.base.LangchainPromptTemplate.requires_langchain_llm "Permalink to this definition")*field* selector*: ConditionalPromptSelector* *[Required]*[](#llama_index.prompts.base.LangchainPromptTemplate.selector "Permalink to this definition")format(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → str[](#llama_index.prompts.base.LangchainPromptTemplate.format "Permalink to this definition")Format the prompt into a string.

format\_messages(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*, *\*\*kwargs: Any*) → List[[ChatMessage](llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")][](#llama_index.prompts.base.LangchainPromptTemplate.format_messages "Permalink to this definition")Format the prompt into a list of chat messages.

get\_template(*llm: Optional[[LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")] = None*) → str[](#llama_index.prompts.base.LangchainPromptTemplate.get_template "Permalink to this definition")partial\_format(*\*\*kwargs: Any*) → [BasePromptTemplate](#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")[](#llama_index.prompts.base.LangchainPromptTemplate.partial_format "Permalink to this definition")Partially format the prompt.

Subclass Prompts (deprecated)[](#subclass-prompts-deprecated "Permalink to this heading")
------------------------------------------------------------------------------------------

Deprecated, but still available for reference at [this link](https://github.com/jerryjliu/llama_index/blob/113109365b216428440b19eb23c9fae749d6880a/llama_index/prompts/prompts.py).

