[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/query_engine/pydantic_query_engine.ipynb)

Query Engine with Pydantic Outputs[](#query-engine-with-pydantic-outputs "Permalink to this heading")
======================================================================================================

Every query engine has support for integrated structured responses using the following `response\_mode`s in `RetrieverQueryEngine`:

* `refine`
* `compact`
* `tree\_summarize`
* `accumulate` (beta, requires extra parsing to convert to objects)
* `compact\_accumulate` (beta, requires extra parsing to convert to objects)

In this notebook, we walk through a small example demonstrating the usage.

Under the hood, every LLM response will be a pydantic object. If that response needs to be refined or summarized, it is converted into a JSON string for the next response. Then, the final response is returned as a pydantic object.

**NOTE:** This can technically work with any LLM, but non-openai is support is still in development and considered beta.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import osimport openaios.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```

```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data/paul\_graham").load\_data()
```
### Create our Pydanitc Output Object[](#create-our-pydanitc-output-object "Permalink to this heading")


```
from typing import Listfrom pydantic import BaseModelclass Biography(BaseModel): """Data model for a biography."""    name: str    best\_known\_for: List[str]    extra\_info: str
```
Create the Index + Query Engine (OpenAI)[](#create-the-index-query-engine-openai "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

When using OpenAI, the function calling API will be leveraged for reliable structured outputs.


```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo", temperature=0.1)service\_context = ServiceContext.from\_defaults(llm=llm)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine(    output\_cls=Biography, response\_mode="compact")
```

```
response = query\_engine.query("Who is Paul Graham?")
```

```
print(response.name)print(response.best\_known\_for)print(response.extra\_info)
```

```
Paul Graham['working on Bel', 'co-founding Viaweb', 'creating the programming language Arc']Paul Graham is a computer scientist, entrepreneur, and writer. He is best known for his work on Bel, a programming language, and for co-founding Viaweb, an early web application company that was later acquired by Yahoo. Graham also created the programming language Arc. He has written numerous essays on topics such as startups, programming, and life.
```

```
# get the full pydanitc objectprint(type(response.response))
```

```
<class '__main__.Biography'>
```
Create the Index + Query Engine (Non-OpenAI, Beta)[](#create-the-index-query-engine-non-openai-beta "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------

When using an LLM that does not support function calling, we rely on the LLM to write the JSON itself, and we parse the JSON into the proper pydantic object.


```
import osos.environ["ANTHROPIC\_API\_KEY"] = "sk-..."
```

```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import Anthropicllm = Anthropic(model="claude-instant-1.2", temperature=0.1)service\_context = ServiceContext.from\_defaults(llm=llm)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine(    output\_cls=Biography, response\_mode="tree\_summarize")
```

```
response = query\_engine.query("Who is Paul Graham?")
```

```
print(response.name)print(response.best\_known\_for)print(response.extra\_info)
```

```
Paul Graham['Co-founder of Y Combinator', 'Essayist and programmer']He is known for creating Viaweb, one of the first web application builders, and for founding Y Combinator, one of the world's top startup accelerators. Graham has also written extensively about technology, investing, and philosophy.
```

```
# get the full pydanitc objectprint(type(response.response))
```

```
<class '__main__.Biography'>
```
Accumulate Examples (Beta)[](#accumulate-examples-beta "Permalink to this heading")
------------------------------------------------------------------------------------

Accumulate with pydantic objects requires some extra parsing. This is still a beta feature, but it’s still possible to get accumulate pydantic objects.


```
from typing import Listfrom pydantic import BaseModelclass Company(BaseModel): """Data model for a companies mentioned."""    company\_name: str    context\_info: str
```

```
from llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.llms import OpenAIllm = OpenAI(model="gpt-3.5-turbo", temperature=0.1)service\_context = ServiceContext.from\_defaults(llm=llm)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
query\_engine = index.as\_query\_engine(    output\_cls=Company, response\_mode="accumulate")
```

```
response = query\_engine.query("What companies are mentioned in the text?")
```
In accumulate, responses are separated by a default separator, and prepended with a prefix.


```
companies = []# split by the default separatorfor response\_str in str(response).split("\n---------------------\n"):    # remove the prefix -- every response starts like `Response 1: {...}`    # so, we find the first bracket and remove everything before it    response\_str = response\_str[response\_str.find("{") :]    companies.append(Company.parse\_raw(response\_str))
```

```
print(companies)
```

```
[Company(company_name='Yahoo', context_info='Yahoo bought us'), Company(company_name='Yahoo', context_info="I'd been meaning to since Yahoo bought us")]
```
