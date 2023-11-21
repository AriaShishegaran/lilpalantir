Output Parsing Modules[](#output-parsing-modules "Permalink to this heading")
==============================================================================

LlamaIndex supports integrations with output parsing modules offeredby other frameworks. These output parsing modules can be used in the following ways:

* To provide formatting instructions for any prompt / query (through `output\_parser.format`)
* To provide “parsing” for LLM outputs (through `output\_parser.parse`)

Guardrails[](#guardrails "Permalink to this heading")
------------------------------------------------------

Guardrails is an open-source Python package for specification/validation/correction of output schemas. See below for a code example.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.output\_parsers import GuardrailsOutputParserfrom llama\_index.llm\_predictor import StructuredLLMPredictorfrom llama\_index.prompts import PromptTemplatefrom llama\_index.prompts.default\_prompts import (    DEFAULT\_TEXT\_QA\_PROMPT\_TMPL,    DEFAULT\_REFINE\_PROMPT\_TMPL,)# load documents, build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectorStoreIndex(documents, chunk\_size=512)llm\_predictor = StructuredLLMPredictor()# specify StructuredLLMPredictor# this is a special LLMPredictor that allows for structured outputs# define query / output specrail\_spec = """<rail version="0.1"><output> <list name="points" description="Bullet points regarding events in the author's life."> <object> <string name="explanation" format="one-line" on-fail-one-line="noop" /> <string name="explanation2" format="one-line" on-fail-one-line="noop" /> <string name="explanation3" format="one-line" on-fail-one-line="noop" /> </object> </list></output><prompt>Query string here.@xml\_prefix\_prompt{output\_schema}@json\_suffix\_prompt\_v2\_wo\_none</prompt></rail>"""# define output parseroutput\_parser = GuardrailsOutputParser.from\_rail\_string(    rail\_spec, llm=llm\_predictor.llm)# format each prompt with output parser instructionsfmt\_qa\_tmpl = output\_parser.format(DEFAULT\_TEXT\_QA\_PROMPT\_TMPL)fmt\_refine\_tmpl = output\_parser.format(DEFAULT\_REFINE\_PROMPT\_TMPL)qa\_prompt = PromptTemplate(fmt\_qa\_tmpl, output\_parser=output\_parser)refine\_prompt = PromptTemplate(fmt\_refine\_tmpl, output\_parser=output\_parser)# obtain a structured responsequery\_engine = index.as\_query\_engine(    service\_context=ServiceContext.from\_defaults(llm\_predictor=llm\_predictor),    text\_qa\_template=qa\_prompt,    refine\_template=refine\_prompt,)response = query\_engine.query(    "What are the three items the author did growing up?",)print(response)
```
Output:


```
{'points': [{'explanation': 'Writing short stories', 'explanation2': 'Programming on an IBM 1401', 'explanation3': 'Using microcomputers'}]}
```
Langchain[](#langchain "Permalink to this heading")
----------------------------------------------------

Langchain also offers output parsing modules that you can use within LlamaIndex.


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom llama\_index.output\_parsers import LangchainOutputParserfrom llama\_index.llm\_predictor import StructuredLLMPredictorfrom llama\_index.prompts import PromptTemplatefrom llama\_index.prompts.default\_prompts import (    DEFAULT\_TEXT\_QA\_PROMPT\_TMPL,    DEFAULT\_REFINE\_PROMPT\_TMPL,)from langchain.output\_parsers import StructuredOutputParser, ResponseSchema# load documents, build indexdocuments = SimpleDirectoryReader("../paul\_graham\_essay/data").load\_data()index = VectorStoreIndex.from\_documents(documents)llm\_predictor = StructuredLLMPredictor()# define output schemaresponse\_schemas = [    ResponseSchema(        name="Education",        description="Describes the author's educational experience/background.",    ),    ResponseSchema(        name="Work",        description="Describes the author's work experience/background.",    ),]# define output parserlc\_output\_parser = StructuredOutputParser.from\_response\_schemas(    response\_schemas)output\_parser = LangchainOutputParser(lc\_output\_parser)# format each prompt with output parser instructionsfmt\_qa\_tmpl = output\_parser.format(DEFAULT\_TEXT\_QA\_PROMPT\_TMPL)fmt\_refine\_tmpl = output\_parser.format(DEFAULT\_REFINE\_PROMPT\_TMPL)qa\_prompt = PromptTemplate(fmt\_qa\_tmpl, output\_parser=output\_parser)refine\_prompt = PromptTemplate(fmt\_refine\_tmpl, output\_parser=output\_parser)# query indexquery\_engine = index.as\_query\_engine(    service\_context=ServiceContext.from\_defaults(llm\_predictor=llm\_predictor),    text\_qa\_template=qa\_prompt,    refine\_template=refine\_prompt,)response = query\_engine.query(    "What are a few things the author did growing up?",)print(str(response))
```
Output:


```
{'Education': 'Before college, the author wrote short stories and experimented with programming on an IBM 1401.', 'Work': 'The author worked on writing and programming outside of school.'}
```
Guides[](#guides "Permalink to this heading")
----------------------------------------------

Examples

* [Guardrails Output Parsing](../../examples/output_parsing/GuardrailsDemo.html)
* [Langchain Output Parsing](../../examples/output_parsing/LangchainOutputParserDemo.html)
* [Guidance Pydantic Program](../../examples/output_parsing/guidance_pydantic_program.html)
* [Guidance for Sub-Question Query Engine](../../examples/output_parsing/guidance_sub_question.html)
* [OpenAI Pydantic Program](../../examples/output_parsing/openai_pydantic_program.html)
