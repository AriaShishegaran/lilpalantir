Pandas Query Engine[](#module-llama_index.query_engine.pandas_query_engine "Permalink to this heading")
========================================================================================================

Default query for PandasIndex.

WARNING: This tool provides the Agent access to the eval function.Arbitrary code execution is possible on the machine running this tool.This tool is not recommended to be used in a production setting, and wouldrequire heavy sandboxing or virtual machines

llama\_index.query\_engine.pandas\_query\_engine.GPTNLPandasQueryEngine[](#llama_index.query_engine.pandas_query_engine.GPTNLPandasQueryEngine "Permalink to this definition")alias of [`PandasQueryEngine`](#llama_index.query_engine.pandas_query_engine.PandasQueryEngine "llama_index.query_engine.pandas_query_engine.PandasQueryEngine")

llama\_index.query\_engine.pandas\_query\_engine.NLPandasQueryEngine[](#llama_index.query_engine.pandas_query_engine.NLPandasQueryEngine "Permalink to this definition")alias of [`PandasQueryEngine`](#llama_index.query_engine.pandas_query_engine.PandasQueryEngine "llama_index.query_engine.pandas_query_engine.PandasQueryEngine")

*class* llama\_index.query\_engine.pandas\_query\_engine.PandasQueryEngine(*df: DataFrame*, *instruction\_str: Optional[str] = None*, *output\_processor: Optional[Callable] = None*, *pandas\_prompt: Optional[[BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")] = None*, *output\_kwargs: Optional[dict] = None*, *head: int = 5*, *verbose: bool = False*, *service\_context: Optional[[ServiceContext](../../service_context.html#llama_index.indices.service_context.ServiceContext "llama_index.indices.service_context.ServiceContext")] = None*, *\*\*kwargs: Any*)[](#llama_index.query_engine.pandas_query_engine.PandasQueryEngine "Permalink to this definition")GPT Pandas query.

Convert natural language to Pandas python code.

WARNING: This tool provides the Agent access to the eval function.Arbitrary code execution is possible on the machine running this tool.This tool is not recommended to be used in a production setting, and wouldrequire heavy sandboxing or virtual machines

Parameters* **df** (*pd.DataFrame*) – Pandas dataframe to use.
* **instruction\_str** (*Optional**[**str**]*) – Instruction string to use.
* **output\_processor** (*Optional**[**Callable**[**[**str**]**,* *str**]**]*) – Output processor.A callable that takes in the output string, pandas DataFrame,and any output kwargs and returns a string.eg.kwargs[“max\_colwidth”] = [int] is used to set the length of textthat each column can display during str(df). Set it to a higher numberif there is possibly long text in the dataframe.
* **pandas\_prompt** (*Optional**[*[*BasePromptTemplate*](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")*]*) – Pandas prompt to use.
* **head** (*int*) – Number of rows to show in the table context.
get\_prompts() → Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")][](#llama_index.query_engine.pandas_query_engine.PandasQueryEngine.get_prompts "Permalink to this definition")Get a prompt.

update\_prompts(*prompts\_dict: Dict[str, [BasePromptTemplate](../../prompts.html#llama_index.prompts.base.BasePromptTemplate "llama_index.prompts.base.BasePromptTemplate")]*) → None[](#llama_index.query_engine.pandas_query_engine.PandasQueryEngine.update_prompts "Permalink to this definition")Update prompts.

Other prompts will remain in place.

llama\_index.query\_engine.pandas\_query\_engine.default\_output\_processor(*output: str*, *df: DataFrame*, *\*\*output\_kwargs: Any*) → str[](#llama_index.query_engine.pandas_query_engine.default_output_processor "Permalink to this definition")Process outputs in a default manner.

