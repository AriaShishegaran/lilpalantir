[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/output_parsing/GuardrailsDemo.ipynb)

Guardrails Output Parsing[](#guardrails-output-parsing "Permalink to this heading")
====================================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.

Download Data[](#download-data "Permalink to this heading")
------------------------------------------------------------


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load documents, build the VectorStoreIndex[](#load-documents-build-the-vectorstoreindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import VectorStoreIndex, SimpleDirectoryReaderfrom IPython.display import Markdown, displayimport openaiopenai.api\_key = "<YOUR\_OPENAI\_API\_KEY>"
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
Define Query + Guardrails Spec[](#define-query-guardrails-spec "Permalink to this heading")
--------------------------------------------------------------------------------------------


```
from llama\_index.output\_parsers import GuardrailsOutputParserfrom llama\_index.llm\_predictor import StructuredLLMPredictor
```

```
llm\_predictor = StructuredLLMPredictor()
```
**Define custom QA and Refine Prompts**


```
from llama\_index.prompts import PromptTemplatefrom llama\_index.prompts.default\_prompts import (    DEFAULT\_TEXT\_QA\_PROMPT\_TMPL,    DEFAULT\_REFINE\_PROMPT\_TMPL,)
```
**Define Guardrails Spec**


```
# You can either define a RailSpec and initialise a Guard object from\_rail\_string()# OR define Pydantic classes and initialise a Guard object from\_pydantic()# For more info: https://docs.guardrailsai.com/defining\_guards/pydantic/# Guardrails recommends Pydanticfrom pydantic import BaseModel, Fieldfrom typing import Listimport guardrails as gdclass Point(BaseModel):    # In all the fields below, you can define validators as well    # Left out for brevity    explanation: str = Field()    explanation2: str = Field()    explanation3: str = Field()class BulletPoints(BaseModel):    points: List[Point] = Field(        description="Bullet points regarding events in the author's life."    )# Define the promptprompt = """Query string here.${gr.xml\_prefix\_prompt}${output\_schema}${gr.json\_suffix\_prompt\_v2\_wo\_none}"""
```

```
# Create a guard objectguard = gd.Guard.from\_pydantic(output\_class=BulletPoints, prompt=prompt)# Create output parse objectoutput\_parser = GuardrailsOutputParser(guard, llm=llm\_predictor.llm)
```

```
# NOTE: we use the same output parser for both prompts, though you can choose to use different parsers# NOTE: here we add formatting instructions to the prompts.fmt\_qa\_tmpl = output\_parser.format(DEFAULT\_TEXT\_QA\_PROMPT\_TMPL)fmt\_refine\_tmpl = output\_parser.format(DEFAULT\_REFINE\_PROMPT\_TMPL)qa\_prompt = PromptTemplate(fmt\_qa\_tmpl, output\_parser=output\_parser)refine\_prompt = PromptTemplate(fmt\_refine\_tmpl, output\_parser=output\_parser)
```

```
# take a look at the new QA template!print(fmt\_qa\_tmpl)
```

```
Context information is below.---------------------{context_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query_str}Answer: Given below is XML that describes the information to extract from this document and the tags to extract it into.<output>    <list name="points" description="Bullet points regarding events in the author's life.">        <object>            <string name="explanation"/>            <string name="explanation2"/>            <string name="explanation3"/>        </object>    </list></output>ONLY return a valid JSON object (no other text is necessary). The JSON MUST conform to the XML format, including any types and format requests e.g. requests for lists, objects and specific types. Be correct and concise.
```
Query Index[](#query-index "Permalink to this heading")
--------------------------------------------------------


```
query\_engine = index.as\_query\_engine(    text\_qa\_template=qa\_prompt,    refine\_template=refine\_prompt,    llm\_predictor=llm\_predictor,)response = query\_engine.query(    "What are the three items the author did growing up?",)
```

```
INFO:llama_index.token_counter.token_counter:> [query] Total LLM token usage: 754 tokens> [query] Total LLM token usage: 754 tokensINFO:llama_index.token_counter.token_counter:> [query] Total embedding token usage: 11 tokens> [query] Total embedding token usage: 11 tokens
```

```
print(response)
```

```
{  "output": {    "list": {      "name": "points",      "description": "Bullet points regarding events in the author's life.",      "object": {        "string": [          {            "name": "explanation",            "content": "Writing short stories"          },          {            "name": "explanation2",            "content": "Programming on the IBM 1401"          },          {            "name": "explanation3",            "content": "Building a microcomputer"          }        ]      }    }  }}
```
