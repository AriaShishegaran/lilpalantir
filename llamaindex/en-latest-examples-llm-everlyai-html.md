[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/llm/everlyai.ipynb)

EverlyAI[](#everlyai "Permalink to this heading")
==================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.llms import EverlyAIfrom llama\_index.llms.base import ChatMessage
```
Call `chat` with ChatMessage List[](#call-chat-with-chatmessage-list "Permalink to this heading")
--------------------------------------------------------------------------------------------------

You need to either set env var `EVERLYAI\_API\_KEY` or set api\_key in the class constructor


```
# import os# os.environ['EVERLYAI\_API\_KEY'] = '<your-api-key>'llm = EverlyAI(api\_key="your-api-key")
```

```
message = ChatMessage(role="user", content="Tell me a joke")resp = llm.chat([message])print(resp)
```

```
assistant:  Sure! Here's a classic one:Why don't scientists trust atoms?Because they make up everything!I hope that brought a smile to your face!
```
### Streaming[](#streaming "Permalink to this heading")


```
message = ChatMessage(role="user", content="Tell me a story in 250 words")resp = llm.stream\_chat([message])for r in resp:    print(r.delta, end="")
```

```
 Sure, here is a story in 250 words:As the sun set over the horizon, a young girl named Lily sat on the beach, watching the waves roll in. She had always loved the ocean, and today was no different. The water was a deep blue, almost purple, and the waves were gentle and soothing. Lily closed her eyes and let the sound of the waves wash over her, feeling the stress of her daily life melt away.Suddenly, a seagull landed nearby, chirping and flapping its wings. Lily opened her eyes and saw the bird was holding something in its beak. Curious, she leaned forward and saw that the bird was carrying a small, shimmering shell. The bird dropped the shell at Lily's feet, and she picked it up, feeling its smooth surface and admiring its beauty.As she held the shell, Lily felt a strange sensation wash over her. She felt connected to the ocean and the bird, and she knew that this moment was special. She looked out at the water and saw a school of fish swimming in the distance, their scales shimmering in the sun
```
Call `complete` with Prompt[](#call-complete-with-prompt "Permalink to this heading")
--------------------------------------------------------------------------------------


```
resp = llm.complete("Tell me a joke")print(resp)
```

```
 Sure, here's a classic one:Why don't scientists trust atoms?Because they make up everything!I hope that brought a smile to your face!
```

```
resp = llm.stream\_complete("Tell me a story in 250 words")for r in resp:    print(r.delta, end="")
```

```
 Sure, here is a story in 250 words:As the sun set over the horizon, a young girl named Maria sat on the beach, watching the waves roll in. She had always loved the ocean, and today was no different. The water was a deep blue, almost purple, and the waves were gentle and soothing.Maria closed her eyes and let the sound of the waves wash over her. She could feel the sand beneath her feet, warm and soft. She felt at peace, like she was a part of something bigger than herself.Suddenly, a seagull landed nearby, chirping and flapping its wings. Maria opened her eyes and saw the bird, and she felt a smile spread across her face. She loved the sound of the seagulls, and the way they seemed to know exactly when to appear.As the sun dipped lower in the sky, Maria stood up and walked closer to the water. She felt the cool water wash over her feet, and she let out a contented sigh. This was her happy place, where she could escape the stresses of everyday life and just be.Maria stayed there for a while
```
