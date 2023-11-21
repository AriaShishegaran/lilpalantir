[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/gradient/gradient_structured.ipynb)

Fine Tuning Llama2 for Better Structured Outputs With Gradient and LlamaIndex[](#fine-tuning-llama2-for-better-structured-outputs-with-gradient-and-llamaindex "Permalink to this heading")
============================================================================================================================================================================================

In this notebook we show you how to fine-tune llama2-7b to be better at outputting structured outputs.

We do this by using [gradient.ai](https://gradient.ai)

This is similar in format to our [OpenAI Functions Fine-tuning Notebook](https://docs.llamaindex.ai/en/latest/examples/finetuning/openai_fine_tuning_functions.html).

**NOTE**: This is an alternative to our repo/guide on fine-tuning llama2-7b with Modal: https://github.com/run-llama/modal\_finetune\_sql


```
!pip install llama-index gradientai -q
```

```
import osfrom llama\_index.llms import GradientBaseModelLLMfrom llama\_index.finetuning.gradient.base import GradientFinetuneEngine
```

```
os.environ["GRADIENT\_ACCESS\_TOKEN"] = os.getenv("GRADIENT\_API\_KEY")os.environ["GRADIENT\_WORKSPACE\_ID"] = "<insert\_workspace\_id>"
```
Fine-tuning Using GPT-4 Pydantic Programs[](#fine-tuning-using-gpt-4-pydantic-programs "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------

In this section we show how to log inputs + GPT-4 generated outputs through our low-level Pydantic Program module. We use that dataset to fine-tune llama2.


```
from pydantic import BaseModelclass Album(BaseModel): """Data model for an album."""    name: str    artist: str
```

```
from llama\_index.callbacks import CallbackManager, LlamaDebugHandlerfrom llama\_index.llms import OpenAI, GradientBaseModelLLMfrom llama\_index.program import LLMTextCompletionProgramfrom llama\_index.output\_parsers import PydanticOutputParseropenai\_handler = LlamaDebugHandler()openai\_callback = CallbackManager([openai\_handler])openai\_llm = OpenAI(model="gpt-4", callback\_manager=openai\_callback)gradient\_handler = LlamaDebugHandler()gradient\_callback = CallbackManager([gradient\_handler])base\_model\_slug = "llama2-7b-chat"gradient\_llm = GradientBaseModelLLM(    base\_model\_slug=base\_model\_slug,    max\_tokens=300,    callback\_manager=gradient\_callback,    is\_chat\_model=True,)# HACK: set chat model# from llama\_index.llms.base import LLMMetadata# gradient\_llm.metadata = LLMMetadata(# context\_window=1024,# num\_output=gradient\_llm.max\_tokens or 20,# is\_chat\_model=True,# is\_function\_calling\_model=False,# model\_name=gradient\_llm.\_model.id,# )
```

```
# try running both through LLMTextCompletionProgramprompt\_template\_str = """\Generate an example album, with an artist and a list of songs. \Using the movie {movie\_name} as inspiration.\"""openai\_program = LLMTextCompletionProgram.from\_defaults(    output\_parser=PydanticOutputParser(Album),    prompt\_template\_str=prompt\_template\_str,    llm=openai\_llm,    verbose=True,)gradient\_program = LLMTextCompletionProgram.from\_defaults(    output\_parser=PydanticOutputParser(Album),    prompt\_template\_str=prompt\_template\_str,    llm=gradient\_llm,    verbose=True,)
```

```
response = openai\_program(movie\_name="The Shining")print(str(response))
```

```
tmp = openai\_handler.get\_llm\_inputs\_outputs()print(tmp[0][0].payload["messages"][0])
```

```
# print(tmp[0][1])
```

```
response = gradient\_program(movie\_name="The Shining")print(str(response))
```

```
tmp = gradient\_handler.get\_llm\_inputs\_outputs()print(tmp[0][0].payload["messages"][0])
```
### Defining Pydantic Model + Program[](#defining-pydantic-model-program "Permalink to this heading")

Here, we define the GPT-4 powered function calling program that will generate structured outputs into a Pydantic object (an Album).


```
from llama\_index.program import LLMTextCompletionProgramfrom pydantic import BaseModelfrom llama\_index.llms import OpenAIfrom llama\_index.callbacks import GradientAIFineTuningHandlerfrom llama\_index.callbacks import CallbackManagerfrom llama\_index.output\_parsers import PydanticOutputParserfrom typing import Listclass Song(BaseModel): """Data model for a song."""    title: str    length\_seconds: intclass Album(BaseModel): """Data model for an album."""    name: str    artist: str    songs: List[Song]finetuning\_handler = GradientAIFineTuningHandler()callback\_manager = CallbackManager([finetuning\_handler])llm\_gpt4 = OpenAI(model="gpt-4", callback\_manager=callback\_manager)prompt\_template\_str = """\Generate an example album, with an artist and a list of songs. \Using the movie {movie\_name} as inspiration.\"""openai\_program = LLMTextCompletionProgram.from\_defaults(    output\_parser=PydanticOutputParser(Album),    prompt\_template\_str=prompt\_template\_str,    llm=llm\_gpt4,    verbose=True,)
```
### Log Inputs/Outputs[](#log-inputs-outputs "Permalink to this heading")

We define some sample movie names as inputs and log the outputs through the function calling program.


```
# NOTE: we need >= 10 movies to use Gradient fine-tuningmovie\_names = [    "The Shining",    "The Departed",    "Titanic",    "Goodfellas",    "Pretty Woman",    "Home Alone",    "Caged Fury",    "Edward Scissorhands",    "Total Recall",    "Ghost",    "Tremors",    "RoboCop",    "Rocky V",]
```

```
from tqdm.notebook import tqdmfor movie\_name in tqdm(movie\_names):    output = openai\_program(movie\_name=movie\_name)    print(output.json())
```

```
events = finetuning\_handler.get\_finetuning\_events()
```

```
events
```

```
finetuning\_handler.save\_finetuning\_events("mock\_finetune\_songs.jsonl")
```

```
Wrote 14 examples to mock_finetune_songs.jsonl
```

```
!cat mock_finetune_songs.jsonl
```
### Fine-tune on the Dataset[](#fine-tune-on-the-dataset "Permalink to this heading")

We now define a fine-tuning engine and fine-tune on the mock dataset.


```
# define base modelbase\_model\_slug = "llama2-7b-chat"base\_llm = GradientBaseModelLLM(    base\_model\_slug=base\_model\_slug, max\_tokens=500, is\_chat\_model=True)
```

```
from llama\_index.finetuning import GradientFinetuneEnginefinetune\_engine = GradientFinetuneEngine(    base\_model\_slug=base\_model\_slug,    # model\_adapter\_id='805c6fd6-daa8-4fc8-a509-bebb2f2c1024\_model\_adapter',    name="movies\_structured",    data\_path="mock\_finetune\_songs.jsonl",    verbose=True,    max\_steps=200,    batch\_size=1,)
```

```
finetune\_engine.model\_adapter\_id
```

```
'1f810f84-c4b8-43b0-b6b0-10d2cbdaf92f_model_adapter'
```

```
# asdjust epochs as necessaryepochs = 2for i in range(epochs):    print(f"\*\* EPOCH {i} \*\*")    finetune\_engine.finetune()
```

```
ft\_llm = finetune\_engine.get\_finetuned\_model(    max\_tokens=500, is\_chat\_model=True)# # NOTE: same as doing the following# from llama\_index.llms import GradientModelAdapterLLM# ft\_llm = GradientModelAdapterLLM(# model\_adapter\_id=finetune\_engine.model\_adapter\_id,# max\_tokens=500# )
```
### Try it Out![](#try-it-out "Permalink to this heading")

We obtain the fine-tuned LLM and use it with the Pydantic program.


```
# try a slightly modified prompt\_template\_strnew\_prompt\_template\_str = """\Generate an example album, with an artist and a list of songs. \Using the movie {movie\_name} as inspiration.\Please only generate one album."""gradient\_program = LLMTextCompletionProgram.from\_defaults(    output\_parser=PydanticOutputParser(Album),    # prompt\_template\_str=prompt\_template\_str,    prompt\_template\_str=new\_prompt\_template\_str,    llm=ft\_llm,    verbose=True,)
```

```
gradient\_program(movie\_name="Goodfellas")
```

```
Album(name='Wiseguy Melodies', artist='Tommy DeVito & The Gangsters', songs=[Song(title='Life in the Fast Lane', length_seconds=210), Song(title='Money and Power', length_seconds=240), Song(title='Goodfellas', length_seconds=270), Song(title='Betrayal', length_seconds=200), Song(title='Downfall', length_seconds=180)])
```

```
gradient\_program(movie\_name="Chucky")
```

```
# you wouldn't get this with normal llama2-7b!base\_gradient\_program = LLMTextCompletionProgram.from\_defaults(    output\_parser=PydanticOutputParser(Album),    prompt\_template\_str=prompt\_template\_str,    llm=base\_llm,    verbose=True,)
```

```
# throws an errorbase\_gradient\_program(movie\_name="Goodfellas")
```
Fine-tuning Structured Outputs through a RAG System[](#fine-tuning-structured-outputs-through-a-rag-system "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------

A use case of function calling is to get structured outputs through a RAG system.

Here we show how to create a training dataset of context-augmented inputs + structured outputs over an unstructured document. We can then fine-tune the LLM and plug it into a RAG system to perform retrieval + output extraction.


```
!mkdir data && wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pydantic import Fieldfrom typing import Listclass Citation(BaseModel): """Citation class."""    author: str = Field(        ..., description="Inferred first author (usually last name"    )    year: int = Field(..., description="Inferred year")    desc: str = Field(        ...,        description=(            "Inferred description from the text of the work that the author is"            " cited for"        ),    )class Response(BaseModel): """List of author citations. Extracted over unstructured text. """    citations: List[Citation] = Field(        ...,        description=(            "List of author citations (organized by author, year, and"            " description)."        ),    )
```
### Load Data + Setup[](#load-data-setup "Permalink to this heading")


```
from llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderfrom llama\_index import Document, ServiceContextfrom llama\_index.node\_parser import SimpleNodeParserfrom pathlib import Pathfrom llama\_index.callbacks import GradientAIFineTuningHandler
```

```
loader = PyMuPDFReader()docs0 = loader.load(file\_path=Path("./data/llama2.pdf"))
```

```
doc\_text = "\n\n".join([d.get\_content() for d in docs0])metadata = {    "paper\_title": "Llama 2: Open Foundation and Fine-Tuned Chat Models"}docs = [Document(text=doc\_text, metadata=metadata)]
```

```
chunk\_size = 1024node\_parser = SimpleNodeParser.from\_defaults(chunk\_size=chunk\_size)nodes = node\_parser.get\_nodes\_from\_documents(docs)
```

```
len(nodes)
```

```
89
```

```
# setup GPT-4 context - to generate "ground-truth" data given queriesfinetuning\_handler = GradientAIFineTuningHandler()callback\_manager = CallbackManager([finetuning\_handler])gpt\_4\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-0613", temperature=0.3),    callback\_manager=callback\_manager,    chunk\_size=chunk\_size,    # force using prompts instead of openai function calling for structured outputs    pydantic\_program\_mode="llm",)# setup gradient.ai contextbase\_model\_slug = "llama2-7b-chat"base\_llm = GradientBaseModelLLM(    base\_model\_slug=base\_model\_slug, max\_tokens=500, is\_chat\_model=True)gradient\_context = ServiceContext.from\_defaults(    llm=base\_llm,    # callback\_manager=callback\_manager,    chunk\_size=chunk\_size,    pydantic\_program\_mode="llm",)# setup eval context (for question generation)eval\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-0613", temperature=0), chunk\_size=chunk\_size)
```
### Generate Dataset[](#generate-dataset "Permalink to this heading")

Here we show how to generate a training dataset over these unstructured chunks/nodes.

We generate questions to extract citations over different context. We run these questions through a GPT-4 RAG pipeline, extract structured outputs, and log inputs/outputs.


```
# setup dataset generatorfrom llama\_index.evaluation import DatasetGeneratorfrom llama\_index import SummaryIndex, PromptTemplatefrom tqdm.notebook import tqdmfrom tqdm.asyncio import tqdm\_asynciofp = open("data/qa\_pairs.jsonl", "w")question\_gen\_prompt = PromptTemplate( """{query\_str}Context:{context\_str}Questions:""")question\_gen\_query = """\Snippets from a research paper is given below. It contains citations.Please generate questions from the text asking about these citations.For instance, here are some sample questions:Which citations correspond to related works on transformer models? Tell me about authors that worked on advancing RLHF.Can you tell me citations corresponding to all computer vision works? \"""qr\_pairs = []node\_questions\_tasks = []for idx, node in enumerate(nodes[:39]):    num\_questions = 1  # change this number to increase number of nodes    dataset\_generator = DatasetGenerator(        [node],        question\_gen\_query=question\_gen\_query,        text\_question\_template=question\_gen\_prompt,        service\_context=eval\_context,        metadata\_mode="all",        num\_questions\_per\_chunk=num\_questions,    )    task = dataset\_generator.agenerate\_questions\_from\_nodes(num=num\_questions)    node\_questions\_tasks.append(task)node\_questions\_lists = await tqdm\_asyncio.gather(\*node\_questions\_tasks)
```

```
100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 39/39 [00:27<00:00,  1.41it/s]
```

```
len(node\_questions\_lists)
```

```
39
```

```
node\_questions\_lists[1]
```

```
['Which citations are mentioned in the section about RLHF Results?']
```

```
# [optional] saveimport picklepickle.dump(node\_questions\_lists, open("llama2\_questions.pkl", "wb"))
```

```
# [optional] load questionsnode\_questions\_lists = pickle.load(open("llama2\_questions.pkl", "rb"))
```

```
from llama\_index import VectorStoreIndexgpt4\_index = VectorStoreIndex(nodes[:39], service\_context=gpt\_4\_context)gpt4\_query\_engine = gpt4\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
from json import JSONDecodeErrorfor idx, node in enumerate(tqdm(nodes[:39])):    node\_questions\_0 = node\_questions\_lists[idx]    for question in node\_questions\_0:        try:            # note: we don't need to use response, events are logged through fine-tuning handler            gpt4\_query\_engine.query(question)        except Exception as e:            print(f"Error for question {question}, {repr(e)}")            pass
```

```
finetuning\_handler.save\_finetuning\_events("llama2\_citation\_events.jsonl")
```

```
Wrote 39 examples to llama2_citation_events.jsonl
```
### Setup Fine-tuning[](#setup-fine-tuning "Permalink to this heading")

We kick off fine-tuning over the generated dataset.


```
from llama\_index.finetuning import GradientFinetuneEnginefinetune\_engine = GradientFinetuneEngine(    base\_model\_slug=base\_model\_slug,    # model\_adapter\_id='23a71710-47b3-43be-9be2-58a3efbccf2b\_model\_adapter',    name="llama2\_structured",    data\_path="llama2\_citation\_events.jsonl",    verbose=True,    max\_steps=200,    batch\_size=1,)
```

```
# save this for future runsfinetune\_engine.model\_adapter\_id
```

```
'23a71710-47b3-43be-9be2-58a3efbccf2b_model_adapter'
```

```
# asdjust epochs as necessaryepochs = 2for i in range(epochs):    print(f"\*\* EPOCH {i} \*\*")    finetune\_engine.finetune()
```
### Use within RAG Pipeline[](#use-within-rag-pipeline "Permalink to this heading")

Let’s plug the fine-tuned LLM into a full RAG pipeline that outputs structured outputs.


```
ft\_llm = finetune\_engine.get\_finetuned\_model(max\_tokens=500)ft\_service\_context = ServiceContext.from\_defaults(llm=ft\_llm)
```

```
from llama\_index import VectorStoreIndexvector\_index = VectorStoreIndex(nodes, service\_context=ft\_service\_context)query\_engine = vector\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
# setup baseline as wellbase\_index = VectorStoreIndex(nodes, service\_context=gradient\_context)base\_query\_engine = base\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
query\_str = "Which citations are mentioned in the section about RLHF Results?"# query\_str = """\# Which citation corresponds to the concept of collecting data that represents \# empirically sampled human preferences in RLHF?\# """# query\_str = "Which citations in the paper discuss the development and release of Llama 2?"# query\_str = "Which citations are mentioned in the section on RLHF Results?"# query\_str = "Which citation discusses the carbon output related to the production of AI hardware?"
```

```
response = query\_engine.query(query\_str)print(str(response))
```
Let’s take a look at sources


```
# view sourcesprint(response.source\_nodes[0].get\_content())
```
Let’s compare against the baseline (the base llama2-7b model). Notice that the query engine throws an error!


```
# throws an error!base\_response = base\_query\_engine.query(query\_str)print(str(base\_response))
```
As a reference, let’s also compare against gpt-4.


```
# as a reference, take a look at GPT-4 responsegpt4\_response = gpt4\_query\_engine.query(query\_str)print(str(gpt4\_response))
```
