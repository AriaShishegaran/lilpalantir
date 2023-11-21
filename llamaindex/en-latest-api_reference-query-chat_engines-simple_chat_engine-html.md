Simple Chat Engine[](#module-llama_index.chat_engine.simple "Permalink to this heading")
=========================================================================================

*class* llama\_index.chat\_engine.simple.SimpleChatEngine(*llm: [LLM](../../llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM")*, *memory: [BaseMemory](../../memory.html#llama_index.memory.BaseMemory "llama_index.memory.types.BaseMemory")*, *prefix\_messages: List[[ChatMessage](../../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*)[](#llama_index.chat_engine.simple.SimpleChatEngine "Permalink to this definition")Simple Chat Engine.

Have a conversation with the LLM.This does not make use of a knowledge base.

*async* achat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.simple.SimpleChatEngine.achat "Permalink to this definition")Async version of main chat interface.

*async* astream\_chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.simple.SimpleChatEngine.astream_chat "Permalink to this definition")Async version of main chat interface.

chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.simple.SimpleChatEngine.chat "Permalink to this definition")Main chat interface.

*property* chat\_history*: List[[ChatMessage](../../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*[](#llama_index.chat_engine.simple.SimpleChatEngine.chat_history "Permalink to this definition")Get chat history.

chat\_repl() → None[](#llama_index.chat_engine.simple.SimpleChatEngine.chat_repl "Permalink to this definition")Enter interactive chat REPL.

*classmethod* from\_defaults(*service\_context: ~typing.Optional[~llama\_index.indices.service\_context.ServiceContext] = None*, *chat\_history: ~typing.Optional[~typing.List[~llama\_index.llms.base.ChatMessage]] = None*, *memory: ~typing.Optional[~llama\_index.memory.types.BaseMemory] = None*, *memory\_cls: ~typing.Type[~llama\_index.memory.types.BaseMemory] = <class 'llama\_index.memory.chat\_memory\_buffer.ChatMemoryBuffer'>*, *system\_prompt: ~typing.Optional[str] = None*, *prefix\_messages: ~typing.Optional[~typing.List[~llama\_index.llms.base.ChatMessage]] = None*, *\*\*kwargs: ~typing.Any*) → [SimpleChatEngine](#llama_index.chat_engine.simple.SimpleChatEngine "llama_index.chat_engine.simple.SimpleChatEngine")[](#llama_index.chat_engine.simple.SimpleChatEngine.from_defaults "Permalink to this definition")Initialize a SimpleChatEngine from default parameters.

reset() → None[](#llama_index.chat_engine.simple.SimpleChatEngine.reset "Permalink to this definition")Reset conversation state.

stream\_chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.simple.SimpleChatEngine.stream_chat "Permalink to this definition")Stream chat interface.

