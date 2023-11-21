LangChainLLM[](#langchainllm "Permalink to this heading")
==========================================================

*pydantic model* llama\_index.llms.langchain.LangChainLLM[](#llama_index.llms.langchain.LangChainLLM "Permalink to this definition")Adapter for a LangChain LLM.

Show JSON schema
```
{ "title": "LangChainLLM", "description": "Adapter for a LangChain LLM.", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" } }}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
FieldsValidators* `\_validate\_callback\_manager` » `callback\_manager`
*async* achat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.achat "Permalink to this definition")Async chat endpoint for LLM.

*async* acomplete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.acomplete "Permalink to this definition")Async completion endpoint for LLM.

*async* astream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.astream_chat "Permalink to this definition")Async streaming chat endpoint for LLM.

*async* astream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.astream_complete "Permalink to this definition")Async streaming completion endpoint for LLM.

chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.chat "Permalink to this definition")Chat endpoint for LLM.

*classmethod* class\_name() → str[](#llama_index.llms.langchain.LangChainLLM.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.complete "Permalink to this definition")Completion endpoint for LLM.

stream\_chat(*messages: Sequence[[ChatMessage](../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.stream_chat "Permalink to this definition")Streaming chat endpoint for LLM.

stream\_complete(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.llms.langchain.LangChainLLM.stream_complete "Permalink to this definition")Streaming completion endpoint for LLM.

*property* llm*: BaseLanguageModel*[](#llama_index.llms.langchain.LangChainLLM.llm "Permalink to this definition")*property* metadata*: [LLMMetadata](../llms.html#llama_index.llms.base.LLMMetadata "llama_index.llms.base.LLMMetadata")*[](#llama_index.llms.langchain.LangChainLLM.metadata "Permalink to this definition")LLM metadata.

