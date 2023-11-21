[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/llama_api.ipynb)

Llama API[](#llama-api "Permalink to this heading")
====================================================

[Llama API](https://www.llama-api.com/) is a hosted API for Llama 2 with function calling support.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

To start, go to https://www.llama-api.com/ to obtain an API key

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.llms.llama\_api import LlamaAPI
```

```
api\_key = "LL-your-key"
```

```
llm = LlamaAPI(api\_key=api\_key)
```
Basic Usage[](#basic-usage "Permalink to this heading")
--------------------------------------------------------

### Call `complete` with a prompt[](#call-complete-with-a-prompt "Permalink to this heading")


```
resp = llm.complete("Paul Graham is ")
```

```
print(resp)
```

```
Paul Graham is a well-known computer scientist and entrepreneur, best known for his work as a co-founder of Viaweb and later Y Combinator, a successful startup accelerator. He is also a prominent essayist and has written extensively on topics such as entrepreneurship, software development, and the tech industry.
```
### Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")


```
from llama\_index.llms import ChatMessagemessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = llm.chat(messages)
```

```
print(resp)
```

```
assistant: Arrrr, me hearty! Me name be Captain Blackbeak, the scurviest dog on the seven seas! Yer lookin' fer a swashbucklin' adventure, eh? Well, hoist the sails and set course fer the high seas, matey! I be here to help ye find yer treasure and battle any scurvy dogs who dare cross our path! So, what be yer first question, landlubber?
```
Function Calling[](#function-calling "Permalink to this heading")
------------------------------------------------------------------


```
from pydantic import BaseModelfrom llama\_index.llms.openai\_utils import to\_openai\_functionclass Song(BaseModel): """A song with name and artist"""    name: str    artist: strsong\_fn = to\_openai\_function(Song)
```

```
llm = LlamaAPI(api\_key=api\_key)response = llm.complete("Generate a song", functions=[song\_fn])function\_call = response.additional\_kwargs["function\_call"]print(function\_call)
```

```
{'name': 'Song', 'arguments': {'name': 'Happy', 'artist': 'Pharrell Williams'}}
```
Structured Data Extraction[](#structured-data-extraction "Permalink to this heading")
--------------------------------------------------------------------------------------

This is a simple example of parsing an output into an `Album` schema, which can contain multiple songs.

Define output schema


```
from pydantic import BaseModelfrom typing import Listclass Song(BaseModel): """Data model for a song."""    title: str    length\_mins: intclass Album(BaseModel): """Data model for an album."""    name: str    artist: str    songs: List[Song]
```
Define pydantic program (llama API is OpenAI-compatible)


```
from llama\_index.program import OpenAIPydanticProgramprompt\_template\_str = """\Extract album and songs from the text provided.For each song, make sure to specify the title and the length\_mins.{text}"""llm = LlamaAPI(api\_key=api\_key, temperature=0.0)program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    llm=llm,    prompt\_template\_str=prompt\_template\_str,    verbose=True,)
```
Run program to get structured output.


```
output = program(    text=""""Echoes of Eternity" is a compelling and thought-provoking album, skillfully crafted by the renowned artist, Seraphina Rivers. \This captivating musical collection takes listeners on an introspective journey, delving into the depths of the human experience \and the vastness of the universe. With her mesmerizing vocals and poignant songwriting, Seraphina Rivers infuses each track with \raw emotion and a sense of cosmic wonder. The album features several standout songs, including the hauntingly beautiful "Stardust \Serenade," a celestial ballad that lasts for six minutes, carrying listeners through a celestial dreamscape. "Eclipse of the Soul" \captivates with its enchanting melodies and spans over eight minutes, inviting introspection and contemplation. Another gem, "Infinity \Embrace," unfolds like a cosmic odyssey, lasting nearly ten minutes, drawing listeners deeper into its ethereal atmosphere. "Echoes of Eternity" \is a masterful testament to Seraphina Rivers' artistic prowess, leaving an enduring impact on all who embark on this musical voyage through \time and space.""")
```

```
Function call: Album with args: {'name': 'Echoes of Eternity', 'artist': 'Seraphina Rivers', 'songs': [{'title': 'Stardust Serenade', 'length_mins': 6}, {'title': 'Eclipse of the Soul', 'length_mins': 8}, {'title': 'Infinity Embrace', 'length_mins': 10}]}
```

```
output
```

```
Album(name='Echoes of Eternity', artist='Seraphina Rivers', songs=[Song(title='Stardust Serenade', length_mins=6), Song(title='Eclipse of the Soul', length_mins=8), Song(title='Infinity Embrace', length_mins=10)])
```
