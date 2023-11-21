[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/finetuning/openai_fine_tuning_functions.ipynb)

Fine Tuning with Function Calling[](#fine-tuning-with-function-calling "Permalink to this heading")
====================================================================================================

In this notebook, we walk through how to fine-tuning gpt-3.5-turbo with function calls. The primary use case here is structured data extraction. Our main focus is distilling GPT-4 outputs to help improve gpt-3.5-turbo function calling capabilities.

We will walk through some examples, from simple to advanced:

1. Fine-tuning on some toy messages/structured outputs logged through our OpenAI Pydantic Program object.
2. Fine-tuning on context-augmented queries/structured outputs over an entire document corpus. Use this in a RAG system.


```
import nest\_asyncionest\_asyncio.apply()
```

```
import osimport openai
```

```
os.environ["OPENAI\_API\_KEY"] = "sk-..."openai.api\_key = os.environ["OPENAI\_API\_KEY"]
```
Fine-tuning Using GPT-4 Pydantic Programs[](#fine-tuning-using-gpt-4-pydantic-programs "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------

In this section we show how to log inputs/outputs through our low-level Pydantic Program module. We use that dataset to fine-tune an LLM.

### Defining Pydantic Model + Program[](#defining-pydantic-model-program "Permalink to this heading")

Here, we define the GPT-4 powered function calling program that will generate structured outputs into a Pydantic object (an Album).


```
from llama\_index.program import OpenAIPydanticProgramfrom pydantic import BaseModelfrom llama\_index.llms import OpenAIfrom llama\_index.callbacks import OpenAIFineTuningHandlerfrom llama\_index.callbacks import CallbackManagerfrom typing import Listclass Song(BaseModel): """Data model for a song."""    title: str    length\_seconds: intclass Album(BaseModel): """Data model for an album."""    name: str    artist: str    songs: List[Song]finetuning\_handler = OpenAIFineTuningHandler()callback\_manager = CallbackManager([finetuning\_handler])llm = OpenAI(model="gpt-4", callback\_manager=callback\_manager)prompt\_template\_str = """\Generate an example album, with an artist and a list of songs. \Using the movie {movie\_name} as inspiration.\"""program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    prompt\_template\_str=prompt\_template\_str,    llm=llm,    verbose=False,)
```
### Log Inputs/Outputs[](#log-inputs-outputs "Permalink to this heading")

We define some sample movie names as inputs and log the outputs through the function calling program.


```
# NOTE: we need >= 10 movies to use OpenAI fine-tuningmovie\_names = [    "The Shining",    "The Departed",    "Titanic",    "Goodfellas",    "Pretty Woman",    "Home Alone",    "Caged Fury",    "Edward Scissorhands",    "Total Recall",    "Ghost",    "Tremors",    "RoboCop",    "Rocky V",]
```

```
from tqdm.notebook import tqdmfor movie\_name in tqdm(movie\_names):    output = program(movie\_name=movie\_name)    print(output.json())
```

```
{"name": "The Shining", "artist": "Various Artists", "songs": [{"title": "Main Title", "length_seconds": 180}, {"title": "Opening Credits", "length_seconds": 120}, {"title": "The Overlook Hotel", "length_seconds": 240}, {"title": "Redrum", "length_seconds": 150}, {"title": "Here's Johnny!", "length_seconds": 200}]}{"name": "The Departed Soundtrack", "artist": "Various Artists", "songs": [{"title": "Gimme Shelter", "length_seconds": 272}, {"title": "Comfortably Numb", "length_seconds": 383}, {"title": "I'm Shipping Up to Boston", "length_seconds": 166}, {"title": "Sweet Dreams (Are Made of This)", "length_seconds": 216}, {"title": "I'm Shipping Up to Boston (Instrumental)", "length_seconds": 166}, {"title": "The Departed Tango", "length_seconds": 123}, {"title": "Thief's Theme", "length_seconds": 201}, {"title": "Well Well Well", "length_seconds": 126}, {"title": "Comfortably Numb (Live)", "length_seconds": 383}, {"title": "Sail On, Sailor", "length_seconds": 181}]}{"name": "Titanic Soundtrack", "artist": "James Horner", "songs": [{"title": "My Heart Will Go On", "length_seconds": 273}, {"title": "Rose", "length_seconds": 120}, {"title": "Hymn to the Sea", "length_seconds": 365}, {"title": "Southampton", "length_seconds": 180}, {"title": "Take Her to Sea, Mr. Murdoch", "length_seconds": 150}]}{"name": "Goodfellas Soundtrack", "artist": "Various Artists", "songs": [{"title": "Rags to Riches", "length_seconds": 180}, {"title": "Gimme Shelter", "length_seconds": 270}, {"title": "Layla", "length_seconds": 270}, {"title": "Jump into the Fire", "length_seconds": 240}, {"title": "Atlantis", "length_seconds": 180}, {"title": "Beyond the Sea", "length_seconds": 180}, {"title": "Sunshine of Your Love", "length_seconds": 240}, {"title": "Mannish Boy", "length_seconds": 240}, {"title": "Layla (Piano Exit)", "length_seconds": 120}]}{"name": "Pretty Woman Soundtrack", "artist": "Various Artists", "songs": [{"title": "Oh, Pretty Woman", "length_seconds": 178}, {"title": "King of Wishful Thinking", "length_seconds": 253}, {"title": "It Must Have Been Love", "length_seconds": 250}, {"title": "Show Me Your Soul", "length_seconds": 285}, {"title": "No Explanation", "length_seconds": 244}]}{"name": "Home Alone Soundtrack", "artist": "John Williams", "songs": [{"title": "Somewhere in My Memory", "length_seconds": 180}, {"title": "Holiday Flight", "length_seconds": 120}, {"title": "The House", "length_seconds": 150}, {"title": "Star of Bethlehem", "length_seconds": 135}, {"title": "Setting the Trap", "length_seconds": 165}, {"title": "The Attack on the House", "length_seconds": 200}, {"title": "Mom Returns and Finale", "length_seconds": 240}]}{"name": "Caged Fury", "artist": "The Fury Band", "songs": [{"title": "Caged Fury", "length_seconds": 240}, {"title": "Prison Break", "length_seconds": 180}, {"title": "Behind Bars", "length_seconds": 210}, {"title": "Escape Plan", "length_seconds": 195}, {"title": "Fight for Freedom", "length_seconds": 220}]}{"name": "Edward Scissorhands Soundtrack", "artist": "Danny Elfman", "songs": [{"title": "Introduction", "length_seconds": 120}, {"title": "Ice Dance", "length_seconds": 180}, {"title": "Edwardo the Barber", "length_seconds": 150}, {"title": "The Grand Finale", "length_seconds": 240}]}{"name": "Total Recall", "artist": "Various Artists", "songs": [{"title": "Recall", "length_seconds": 240}, {"title": "Mars", "length_seconds": 180}, {"title": "Memory", "length_seconds": 210}, {"title": "Rebellion", "length_seconds": 300}, {"title": "Escape", "length_seconds": 270}]}{"name": "Ghost", "artist": "Various Artists", "songs": [{"title": "Unchained Melody", "length_seconds": 218}, {"title": "Oh My Love", "length_seconds": 156}, {"title": "Ditto's Theme", "length_seconds": 92}, {"title": "Love Inside", "length_seconds": 180}, {"title": "Ghostly Encounter", "length_seconds": 120}]}{"name": "Tremors Soundtrack", "artist": "Various Artists", "songs": [{"title": "Main Theme", "length_seconds": 180}, {"title": "Graboids Attack", "length_seconds": 240}, {"title": "Val and Earl's Theme", "length_seconds": 200}, {"title": "Burt's Arsenal", "length_seconds": 220}, {"title": "Nest of the Graboids", "length_seconds": 190}]}{"name": "RoboCop: The Soundtrack", "artist": "Various Artists", "songs": [{"title": "Main Theme", "length_seconds": 180}, {"title": "Murphy's Death", "length_seconds": 240}, {"title": "RoboCop's Training", "length_seconds": 210}, {"title": "ED-209", "length_seconds": 195}, {"title": "Clarence Boddicker", "length_seconds": 220}, {"title": "RoboCop Saves the Day", "length_seconds": 240}, {"title": "RoboCop's Theme", "length_seconds": 180}]}{"name": "Rocky V", "artist": "Various Artists", "songs": [{"title": "Measure of a Man", "length_seconds": 240}, {"title": "Can't Stop the Fire", "length_seconds": 210}, {"title": "Go for It!", "length_seconds": 180}, {"title": "Take You Back (Home Sweet Home)", "length_seconds": 200}, {"title": "The Measure of a Man (Reprise)", "length_seconds": 120}]}
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
from llama\_index.finetuning import OpenAIFinetuneEnginefinetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "mock\_finetune\_songs.jsonl",    # start\_job\_id="<start-job-id>" # if you have an existing job, can specify id here    validate\_json=False,  # openai validate json code doesn't support function calling yet)
```

```
finetune\_engine.finetune()
```

```
finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-uJ9kQ9pI0p0YNatBDxF3VITv at 0x172a5c9a0> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-uJ9kQ9pI0p0YNatBDxF3VITv",  "model": "gpt-3.5-turbo-0613",  "created_at": 1696463378,  "finished_at": 1696463749,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::8660TXqx",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-Hbpw15BAwyf3e4HK5Z9g4IK2"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-MNh7snhv0triDIhsrErokSMY",  "hyperparameters": {    "n_epochs": 7  },  "trained_tokens": 22834,  "error": null}
```
### Try it Out![](#try-it-out "Permalink to this heading")

We obtain the fine-tuned LLM and use it with the Pydantic program.


```
ft\_llm = finetune\_engine.get\_finetuned\_model(temperature=0.3)
```

```
ft\_program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    prompt\_template\_str=prompt\_template\_str,    llm=ft\_llm,    verbose=False,)
```

```
ft\_program(movie\_name="Goodfellas")
```

```
Album(name='Goodfellas Soundtrack', artist='Various Artists', songs=[Song(title='Rags to Riches', length_seconds=180), Song(title='Gimme Shelter', length_seconds=270), Song(title='Layla', length_seconds=270), Song(title='Jump into the Fire', length_seconds=240), Song(title='Atlantis', length_seconds=180), Song(title='Beyond the Sea', length_seconds=180), Song(title='Sunshine of Your Love', length_seconds=240), Song(title='Mannish Boy', length_seconds=240), Song(title='Layla (Piano Exit)', length_seconds=120)])
```
Fine-tuning Structured Outputs through a RAG System[](#fine-tuning-structured-outputs-through-a-rag-system "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------

A use case of function calling is to get structured outputs through a RAG system.

Here we show how to create a training dataset of context-augmented inputs + structured outputs over an unstructured document. We can then fine-tune the LLM and plug it into a RAG system to perform retrieval + output extraction.


```
!mkdir data && wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
--2023-10-04 23:46:36--  https://arxiv.org/pdf/2307.09288.pdfResolving arxiv.org (arxiv.org)... 128.84.21.199Connecting to arxiv.org (arxiv.org)|128.84.21.199|:443... connected.HTTP request sent, awaiting response... 200 OKLength: 13661300 (13M) [application/pdf]Saving to: ‘data/llama2.pdf’data/llama2.pdf     100%[===================>]  13.03M   229KB/s    in 45s     2023-10-04 23:47:25 (298 KB/s) - ‘data/llama2.pdf’ saved [13661300/13661300]
```

```
from pydantic import Fieldfrom typing import Listclass Citation(BaseModel): """Citation class."""    author: str = Field(        ..., description="Inferred first author (usually last name"    )    year: int = Field(..., description="Inferred year")    desc: str = Field(        ...,        description=(            "Inferred description from the text of the work that the author is"            " cited for"        ),    )class Response(BaseModel): """List of author citations. Extracted over unstructured text. """    citations: List[Citation] = Field(        ...,        description=(            "List of author citations (organized by author, year, and"            " description)."        ),    )
```
### Load Data + Setup[](#load-data-setup "Permalink to this heading")


```
from llama\_hub.file.pymu\_pdf.base import PyMuPDFReaderfrom llama\_index import Document, ServiceContextfrom llama\_index.node\_parser import SimpleNodeParserfrom pathlib import Path
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
# setup service contextfinetuning\_handler = OpenAIFineTuningHandler()callback\_manager = CallbackManager([finetuning\_handler])gpt\_4\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-0613", temperature=0.3),    callback\_manager=callback\_manager,    chunk\_size=chunk\_size,)gpt\_35\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-3.5-turbo-0613", temperature=0.3),    callback\_manager=callback\_manager,    chunk\_size=chunk\_size,)eval\_context = ServiceContext.from\_defaults(    llm=OpenAI(model="gpt-4-0613", temperature=0), chunk\_size=chunk\_size)
```
### Generate Dataset[](#generate-dataset "Permalink to this heading")

Here we show how to generate a training dataset over these unstructured chunks/nodes.

We generate questions to extract citations over different context. We run these questions through a GPT-4 RAG pipeline, extract structured outputs, and log inputs/outputs.


```
# setup dataset generatorfrom llama\_index.evaluation import DatasetGeneratorfrom llama\_index import SummaryIndex, PromptTemplatefrom tqdm.notebook import tqdmfrom tqdm.asyncio import tqdm\_asynciofp = open("data/qa\_pairs.jsonl", "w")question\_gen\_prompt = PromptTemplate( """{query\_str}Context:{context\_str}Questions:""")question\_gen\_query = """\Snippets from a research paper is given below. It contains citations.Please generate questions from the text asking about these citations.For instance, here are some sample questions:Which citations correspond to related works on transformer models? Tell me about authors that worked on advancing RLHF.Can you tell me citations corresponding to all computer vision works? \"""qr\_pairs = []node\_questions\_tasks = []for idx, node in enumerate(nodes[:39]):    num\_questions = 1  # change this number to increase number of nodes    dataset\_generator = DatasetGenerator(        [node],        question\_gen\_query=question\_gen\_query,        text\_question\_template=question\_gen\_prompt,        service\_context=eval\_context,        metadata\_mode="all",        num\_questions\_per\_chunk=num\_questions,    )    task = dataset\_generator.agenerate\_questions\_from\_nodes(num=num\_questions)    node\_questions\_tasks.append(task)node\_questions\_lists = await tqdm\_asyncio.gather(\*node\_questions\_tasks)
```

```
node\_questions\_lists
```

```
gpt4\_index = VectorStoreIndex(nodes, service\_context=gpt\_4\_context)gpt4\_query\_engine = gpt4\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
from json import JSONDecodeErrorfor idx, node in enumerate(tqdm(nodes[:39])):    node\_questions\_0 = node\_questions\_lists[idx]    for question in node\_questions\_0:        try:            # note: we don't need to use response, events are logged through fine-tuning handler            gpt4\_query\_engine.query(question)        except Exception as e:            print(f"Error for question {question}, {repr(e)}")            pass
```

```
Error for question Which citations are referred to in the discussion about safety investigations into pretraining data and pretrained models?, ValidationError(model='Response', errors=[{'loc': ('__root__',), 'msg': 'Expecting value: line 1 column 1 (char 0)', 'type': 'value_error.jsondecode', 'ctx': {'msg': 'Expecting value', 'doc': 'Empty Response', 'pos': 0, 'lineno': 1, 'colno': 1}}])
```

```
finetuning\_handler.save\_finetuning\_events("llama2\_citation\_events.jsonl")
```

```
Wrote 83 examples to llama2_citation_events.jsonl
```
### Setup Fine-tuning[](#setup-fine-tuning "Permalink to this heading")

We kick off fine-tuning over the generated dataset.


```
from llama\_index.finetuning import OpenAIFinetuneEnginefinetune\_engine = OpenAIFinetuneEngine(    "gpt-3.5-turbo",    "llama2\_citation\_events.jsonl",    # start\_job\_id="<start-job-id>" # if you have an existing job, can specify id here    validate\_json=False,  # openai validate json code doesn't support function calling yet)
```

```
finetune\_engine.finetune()
```

```
finetune\_engine.get\_current\_job()
```

```
<FineTuningJob fine_tuning.job id=ftjob-ATYm4yZHP1QvXs1wx85Ix79F at 0x1752b6b60> JSON: {  "object": "fine_tuning.job",  "id": "ftjob-ATYm4yZHP1QvXs1wx85Ix79F",  "model": "gpt-3.5-turbo-0613",  "created_at": 1696497663,  "finished_at": 1696498092,  "fine_tuned_model": "ft:gpt-3.5-turbo-0613:llamaindex::86EwPw83",  "organization_id": "org-1ZDAvajC6v2ZtAP9hLEIsXRz",  "result_files": [    "file-wabcIIxjLqvhqOVohf4qSmE7"  ],  "status": "succeeded",  "validation_file": null,  "training_file": "file-WbYcsinIbH8vyCAstcoFEr92",  "hyperparameters": {    "n_epochs": 3  },  "trained_tokens": 132678,  "error": null}
```
### Use within RAG Pipeline[](#use-within-rag-pipeline "Permalink to this heading")

Let’s plug the fine-tuned LLM into a full RAG pipeline that outputs structured outputs.


```
ft\_llm = finetune\_engine.get\_finetuned\_model(temperature=0.3)ft\_service\_context = ServiceContext.from\_defaults(llm=ft\_llm)
```

```
from llama\_index import VectorStoreIndexvector\_index = VectorStoreIndex(nodes, service\_context=ft\_service\_context)query\_engine = vector\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
# setup baseline as wellbase\_index = VectorStoreIndex(nodes, service\_context=gpt\_35\_context)base\_query\_engine = base\_index.as\_query\_engine(    output\_cls=Response, similarity\_top\_k=1)
```

```
query\_str = """\Which citation is used to measure the truthfulness of Llama 2? \"""# query\_str = """\# Which citation corresponds to the concept of collecting data that represents \# empirically sampled human preferences in RLHF?\# """# query\_str = "Which citations in the paper discuss the development and release of Llama 2?"# query\_str = "Which citations are mentioned in the section on RLHF Results?"# query\_str = "Which citation discusses the carbon output related to the production of AI hardware?"response = query\_engine.query(query\_str)print(str(response))
```

```
{"citations": [{"author": "Lin et al.", "year": 2021, "desc": "TruthfulQA, used for LLM hallucinations to measure whether a language model is truthful in generating answers to questions while being informative at the same time."}]}
```

```
base\_response = base\_query\_engine.query(query\_str)print(str(base\_response))
```

```
{"citations": [{"author": "Lin et al.", "year": 2021, "desc": "TruthfulQA"}]}
```

```
# view sourcesprint(response.source\_nodes[0].get\_content())
```

```
# as a reference, take a look at GPT-4 responsegpt4\_response = gpt4\_query\_engine.query(query\_str)print(str(gpt4\_response))
```

```
{"citations": [{"author": "Lin et al.", "year": 2021, "desc": "TruthfulQA, used for LLM hallucinations to measure whether a language model is truthful in generating answers to questions while being informative at the same time."}]}
```
