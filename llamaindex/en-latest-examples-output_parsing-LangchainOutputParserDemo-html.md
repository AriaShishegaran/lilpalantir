[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/output_parsing/LangchainOutputParserDemo.ipynb)

Langchain Output Parsing[](#langchain-output-parsing "Permalink to this heading")
==================================================================================

Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom IPython.display import Markdown, display
```

```
# load documentsdocuments = SimpleDirectoryReader("./data/paul\_graham/").load\_data()
```

```
index = VectorStoreIndex.from\_documents(documents, chunk\_size=512)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_documents] Total LLM token usage: 0 tokens> [build_index_from_documents] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_documents] Total embedding token usage: 18579 tokens> [build_index_from_documents] Total embedding token usage: 18579 tokens
```
Define Query + Langchain Output Parser[](#define-query-langchain-output-parser "Permalink to this heading")
------------------------------------------------------------------------------------------------------------


```
from llama\_index.output\_parsers import LangchainOutputParserfrom llama\_index.llm\_predictor import StructuredLLMPredictorfrom langchain.output\_parsers import StructuredOutputParser, ResponseSchema
```

```
llm\_predictor = StructuredLLMPredictor()
```
**Define custom QA and Refine Prompts**


```
from llama\_index.prompts import PromptTemplatefrom llama\_index.prompts.default\_prompts import (    DEFAULT\_TEXT\_QA\_PROMPT\_TMPL,    DEFAULT\_REFINE\_PROMPT\_TMPL,)
```

```
response\_schemas = [    ResponseSchema(        name="Education",        description=(            "Describes the author's educational experience/background."        ),    ),    ResponseSchema(        name="Work",        description="Describes the author's work experience/background.",    ),]
```

```
lc\_output\_parser = StructuredOutputParser.from\_response\_schemas(    response\_schemas)output\_parser = LangchainOutputParser(lc\_output\_parser)
```

```
# NOTE: we use the same output parser for both prompts, though you can choose to use different parsers# NOTE: here we add formatting instructions to the prompts.fmt\_qa\_tmpl = output\_parser.format(DEFAULT\_TEXT\_QA\_PROMPT\_TMPL)fmt\_refine\_tmpl = output\_parser.format(DEFAULT\_REFINE\_PROMPT\_TMPL)qa\_prompt = PromptTemplate(fmt\_qa\_tmpl, output\_parser=output\_parser)refine\_prompt = PromptTemplate(fmt\_refine\_tmpl, output\_parser=output\_parser)
```

```
# take a look at the new QA template!print(fmt\_qa\_tmpl)
```

```
Context information is below. ---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the question: {query_str}The output should be a markdown code snippet formatted in the following schema:```json{{	"Education": string  // Describes the author's educational experience/background.	"Work": string  // Describes the author's work experience/background.}}```
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
query\_engine = index.as\_query\_engine(    text\_qa\_template=qa\_prompt,    refine\_template=refine\_prompt,    llm\_predictor=llm\_predictor,)response = query\_engine.query(    "What are a few things the author did growing up?",)
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 609 tokens
```

```
> [query] Total LLM token usage: 609 tokens
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 11 tokens
```

```
> [query] Total embedding token usage: 11 tokens
```

```
print(response)
```

```
{'Education': 'Before college, the author wrote short stories and experimented with programming on an IBM 1401.', 'Work': 'The author worked on writing and programming outside of school.'}
```
