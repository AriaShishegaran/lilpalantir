Condense Question Chat Engine[](#condense-question-chat-engine "Permalink to this heading")
============================================================================================

*class* llama\_index.chat\_engine.condense\_question.CondenseQuestionChatEngine(*query\_engine: BaseQueryEngine*, *condense\_question\_prompt: [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*, *memory: [BaseMemory](../../memory.html#llama_index.memory.BaseMemory "llama_index.memory.types.BaseMemory")*, *service\_context: [ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*, *verbose: bool = False*, *callback\_manager: Optional[[CallbackManager](../../callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*)[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine "Permalink to this definition")Condense Question Chat Engine.

First generate a standalone question from conversation context and last message,then query the query engine for a response.

*async* achat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.achat "Permalink to this definition")Async version of main chat interface.

*async* astream\_chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.astream_chat "Permalink to this definition")Async version of main chat interface.

chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.chat "Permalink to this definition")Main chat interface.

*property* chat\_history*: List[[ChatMessage](../../llms.html#llama_index.llms.base.ChatMessage "llama_index.llms.base.ChatMessage")]*[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.chat_history "Permalink to this definition")Get chat history.

chat\_repl() → None[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.chat_repl "Permalink to this definition")Enter interactive chat REPL.

*classmethod* from\_defaults(*query\_engine: ~llama\_index.indices.query.base.BaseQueryEngine*, *condense\_question\_prompt: ~typing.Optional[~llama\_index.prompts.base.BasePromptTemplate] = None*, *chat\_history: ~typing.Optional[~typing.List[~llama\_index.llms.base.ChatMessage]] = None*, *memory: ~typing.Optional[~llama\_index.memory.types.BaseMemory] = None*, *memory\_cls: ~typing.Type[~llama\_index.memory.types.BaseMemory] = <class 'llama\_index.memory.chat\_memory\_buffer.ChatMemoryBuffer'>*, *service\_context: ~typing.Optional[~llama\_index.indices.service\_context.ServiceContext] = None*, *verbose: bool = False*, *system\_prompt: ~typing.Optional[str] = None*, *prefix\_messages: ~typing.Optional[~typing.List[~llama\_index.llms.base.ChatMessage]] = None*, *\*\*kwargs: ~typing.Any*) → [CondenseQuestionChatEngine](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine "llama_index.chat_engine.condense_question.CondenseQuestionChatEngine")[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.from_defaults "Permalink to this definition")Initialize a CondenseQuestionChatEngine from default parameters.

reset() → None[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.reset "Permalink to this definition")Reset conversation state.

stream\_chat(*\*args: Any*, *\*\*kwargs: Any*) → Any[](#llama_index.chat_engine.condense_question.CondenseQuestionChatEngine.stream_chat "Permalink to this definition")Stream chat interface.

