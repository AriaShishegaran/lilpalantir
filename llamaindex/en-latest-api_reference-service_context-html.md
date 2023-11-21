Service Context[](#service-context "Permalink to this heading")
================================================================

The service context container is a utility container for LlamaIndexindex and query classes. The container contains the followingobjects that are commonly used for configuring every index andquery, such as the LLMPredictor (for configuring the LLM),the PromptHelper (for configuring input size/chunk size),the BaseEmbedding (for configuring the embedding model), and more.

  
Service Context Classes

* [Embeddings](service_context/embeddings.html)
* [OpenAIEmbedding](service_context/embeddings.html#openaiembedding)
* [HuggingFaceEmbedding](service_context/embeddings.html#huggingfaceembedding)
* [OptimumEmbedding](service_context/embeddings.html#optimumembedding)
* [InstructorEmbedding](service_context/embeddings.html#instructorembedding)
* [LangchainEmbedding](service_context/embeddings.html#langchainembedding)
* [GoogleUnivSentEncoderEmbedding](service_context/embeddings.html#googleunivsentencoderembedding)
* [Node Parser](service_context/node_parser.html)
* [PromptHelper](service_context/prompt_helper.html)
* [LLMs](llms.html)


---

*class* llama\_index.indices.service\_context.ServiceContext(*llm\_predictor: BaseLLMPredictor*, *prompt\_helper: [PromptHelper](service_context/prompt_helper.html#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")*, *embed\_model: BaseEmbedding*, *node\_parser: [NodeParser](service_context/node_parser.html#llama_index.node_parser.NodeParser "llama_index.node_parser.interface.NodeParser")*, *llama\_logger: LlamaLogger*, *callback\_manager: [CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")*)[](#llama_index.indices.service_context.ServiceContext "Permalink to this definition")Service Context container.

The service context container is a utility container for LlamaIndexindex and query classes. It contains the following:- llm\_predictor: BaseLLMPredictor- prompt\_helper: PromptHelper- embed\_model: BaseEmbedding- node\_parser: NodeParser- llama\_logger: LlamaLogger (deprecated)- callback\_manager: CallbackManager

*classmethod* from\_defaults(*llm\_predictor: Optional[BaseLLMPredictor] = None*, *llm: Optional[Union[str, [LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM"), BaseLanguageModel]] = 'default'*, *prompt\_helper: Optional[[PromptHelper](service_context/prompt_helper.html#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")] = None*, *embed\_model: Optional[Union[BaseEmbedding, Embeddings, str]] = 'default'*, *node\_parser: Optional[[NodeParser](service_context/node_parser.html#llama_index.node_parser.NodeParser "llama_index.node_parser.interface.NodeParser")] = None*, *llama\_logger: Optional[LlamaLogger] = None*, *callback\_manager: Optional[[CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *system\_prompt: Optional[str] = None*, *query\_wrapper\_prompt: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *pydantic\_program\_mode: PydanticProgramMode = PydanticProgramMode.DEFAULT*, *chunk\_size: Optional[int] = None*, *chunk\_overlap: Optional[int] = None*, *context\_window: Optional[int] = None*, *num\_output: Optional[int] = None*, *chunk\_size\_limit: Optional[int] = None*) → [ServiceContext](#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")[](#llama_index.indices.service_context.ServiceContext.from_defaults "Permalink to this definition")Create a ServiceContext from defaults.If an argument is specified, then use the argument value provided for thatparameter. If an argument is not specified, then use the default value.

You can change the base defaults by setting llama\_index.global\_service\_contextto a ServiceContext object with your desired settings.

Parameters* **llm\_predictor** (*Optional**[**BaseLLMPredictor**]*) – LLMPredictor
* **prompt\_helper** (*Optional**[*[*PromptHelper*](service_context/prompt_helper.html#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")*]*) – PromptHelper
* **embed\_model** (*Optional**[**BaseEmbedding**]*) – BaseEmbeddingor “local” (use local model)
* **node\_parser** (*Optional**[*[*NodeParser*](service_context/node_parser.html#llama_index.node_parser.NodeParser "llama_index.node_parser.NodeParser")*]*) – NodeParser
* **llama\_logger** (*Optional**[**LlamaLogger**]*) – LlamaLogger (deprecated)
* **chunk\_size** (*Optional**[**int**]*) – chunk\_size
* **callback\_manager** (*Optional**[*[*CallbackManager*](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.CallbackManager")*]*) – CallbackManager
* **system\_prompt** (*Optional**[**str**]*) – System-wide prompt to be prependedto all input prompts, used to guide system “decision making”
* **query\_wrapper\_prompt** (*Optional**[*[*BasePromptTemplate*](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – A format to wrappassed-in input queries.
Deprecated Args:chunk\_size\_limit (Optional[int]): renamed to chunk\_size

*classmethod* from\_service\_context(*service\_context: [ServiceContext](#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")*, *llm\_predictor: Optional[BaseLLMPredictor] = None*, *llm: Optional[Union[str, [LLM](llms.html#llama_index.llms.base.LLM "llama_index.llms.base.LLM"), BaseLanguageModel]] = 'default'*, *prompt\_helper: Optional[[PromptHelper](service_context/prompt_helper.html#llama_index.indices.prompt_helper.PromptHelper "llama_index.indices.prompt_helper.PromptHelper")] = None*, *embed\_model: Optional[Union[BaseEmbedding, Embeddings, str]] = 'default'*, *node\_parser: Optional[[NodeParser](service_context/node_parser.html#llama_index.node_parser.NodeParser "llama_index.node_parser.interface.NodeParser")] = None*, *llama\_logger: Optional[LlamaLogger] = None*, *callback\_manager: Optional[[CallbackManager](callbacks.html#llama_index.callbacks.CallbackManager "llama_index.callbacks.base.CallbackManager")] = None*, *system\_prompt: Optional[str] = None*, *query\_wrapper\_prompt: Optional[[BasePromptTemplate](prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *chunk\_size: Optional[int] = None*, *chunk\_overlap: Optional[int] = None*, *context\_window: Optional[int] = None*, *num\_output: Optional[int] = None*, *chunk\_size\_limit: Optional[int] = None*) → [ServiceContext](#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")[](#llama_index.indices.service_context.ServiceContext.from_service_context "Permalink to this definition")Instantiate a new service context using a previous as the defaults.

to\_dict() → dict[](#llama_index.indices.service_context.ServiceContext.to_dict "Permalink to this definition")Convert service context to dict.

llama\_index.indices.service\_context.set\_global\_service\_context(*service\_context: Optional[[ServiceContext](#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")]*) → None[](#llama_index.indices.service_context.set_global_service_context "Permalink to this definition")Helper function to set the global service context.

