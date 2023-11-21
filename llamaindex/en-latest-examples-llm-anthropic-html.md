[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/anthropic.ipynb)

Anthropic[](#anthropic "Permalink to this heading")
====================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Call `complete` with a prompt[](#call-complete-with-a-prompt "Permalink to this heading")
------------------------------------------------------------------------------------------


```
from llama\_index.llms import Anthropic# To customize your API key, do this# otherwise it will lookup ANTHROPIC\_API\_KEY from your env variable# llm = Anthropic(api\_key="<api\_key>")llm = Anthropic()resp = llm.complete("Paul Graham is ")
```

```
print(resp)
```

```
 Here are some key facts about Paul Graham:- Paul Graham is an American computer scientist, venture capitalist, and essayist. He is known for co-founding Viaweb, one of the first web-based application companies, which was acquired by Yahoo in 1998.- In 1995, Graham co-founded Viaweb with Robert Morris, Trevor Blackwell, and Jessica Livingston. The company helped popularize the business model of applying software as a service.- After selling Viaweb to Yahoo, Graham became a venture capitalist. He co-founded Y Combinator in 2005 with Jessica Livingston, Trevor Blackwell, and Robert Morris. Y Combinator is an influential startup accelerator that provides seed funding and advice to startups.- Graham has written several influential essays on startups, technology, and programming. Some of his most well-known essays include "How to Start a Startup", "Do Things that Don't Scale", and "Beating the Averages" about Lisp programming. - He pioneered the concept of using online essays to attract startup founders to apply to Y Combinator's program. His essays are often required reading in Silicon Valley.- Graham has a Bachelor's degree in philosophy from Cornell University and a PhD in computer science from Harvard University. His doctoral thesis focused on Lisp compilers.- He is considered an influential figure in the tech and startup worlds, known for his insights on startups, programming languages, and technology trends. His writings have shaped the strategies of many founders building startups.
```
Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")
------------------------------------------------------------------------------------------------------


```
from llama\_index.llms import ChatMessage, Anthropicmessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="Tell me a story"),]resp = Anthropic().chat(messages)
```

```
print(resp)
```

```
assistant:  Here is a fun pirate story for you:Yarrr matey! Me name be Captain Redbeard, the most fearsome pirate to sail the seven seas. I be the captain of the good ship Salty Dog, and we be lookin' fer treasure! I lost me leg in a battle with the evil Captain Bluebeard years ago. That scallywag got the better of me that time, but I'll have me revenge! Now I got me a peg leg that I can use to stomp the deck or kick me enemies right in the rear! Me first mate Scurvy Sam be my best friend. We go way back to when we were just lads dreamin' of a pirate's life. He may only have one good eye after losin' the other one to a seagull, but he can still spot treasure from a league away! Today we be sailin' for the fabled Treasure Island, in search of the loot buried long ago by the notorious Captain Flint. Flint was the most ruthless pirate ever to live, but he buried his treasure and no one ever found it. But I have a map, given to me by a dying sailor. I just know it'll lead us right to Flint's trove of rubies, diamonds and mountains of gold! It won't be easy. We may have to fight off Flint's ghost, or deal with tribes of cannibals, or outwit double-crossing thieves. But that's all part of a pirate's life! And when we finally get our hands on that treasure, we'll live like kings. We'll party all night and sleep all day in our fancy pirate cove. So hoist the mainsail me hearties, and let's set sail for adventure! Keep a weather eye on the horizon, mateys. Treasure awaits!
```
Streaming[](#streaming "Permalink to this heading")
----------------------------------------------------

Using `stream\_complete` endpoint


```
from llama\_index.llms import Anthropicllm = Anthropic()resp = llm.stream\_complete("Paul Graham is ")
```

```
for r in resp:    print(r.delta, end="")
```

```
 Here are some key points about Paul Graham:- Paul Graham is an American computer scientist, venture capitalist, and essayist. He is known for co-founding Viaweb, one of the first web-based applications, which was acquired by Yahoo in 1998.- In 2005, Graham co-founded Y Combinator, a startup accelerator that provides seed funding and advice to startups. Y Combinator has backed over 2000 companies including Dropbox, Airbnb, Stripe, and Reddit. - Graham has written extensively about startups, programming, and technology. Some of his most popular essays include "How to Start a Startup", "The Age of the Essay", and "Beating the Averages" about his experiences with Viaweb.- As an essayist, Graham has a very analytical and insightful writing style. He is skilled at breaking down complex concepts and explaining ideas clearly. His essays cover a wide range of topics including startups, programming, economics, and philosophy.- In addition to his work with startups, Graham previously worked as a programmer at Yahoo and was also a professor of computer science at Harvard University. He studied mathematics at Cornell University and obtained a PhD in Computer Science from Harvard.- Graham has advocated for funding and supporting startup founders who may lack traditional credentials like college degrees. He has argued that intelligence, determination, and flexibility are more important than formal education for succeeding in startups.In summary, Paul Graham is a prominent figure in the tech industry known for his work with startups, programming, and influential writing and perspectives on technology. His ideas have had a major impact on the startup ecosystem.
```

```
from llama\_index.llms import Anthropicllm = Anthropic()messages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="Tell me a story"),]resp = llm.stream\_chat(messages)
```

```
for r in resp:    print(r.delta, end="")
```

```
 Here is a fun pirate story for you:Yarrr matey! Me name be Captain Redbeard, the most fearsome pirate to sail the seven seas. I be the captain of the good ship Salty Dog, and we be lookin' fer treasure! I lost me leg in a battle with the evil Captain Bluebeard years ago. That scallywag got the better of me that time, but I'll have me revenge! Now I got me a peg leg that I can use to kick me enemies right in the behind! Har har!Just last week me crew and I found a map leading to the lost treasure of the island of Rundoon. We set sail right away, braving storms and sea creatures the size of ships! When we got to the island, it were guarded by angry natives with spears and poison darts. Me crew fought 'em off while I snuck into the temple and grabbed the treasure chest.Now we be rich with dubloons and jewels! I plan to stash me loot on a remote island, then find a tavern and drink grog until I can't stand up straight. Being a pirate captain be a tough life, but someone's got to sail the high seas in search of adventure! Maybe one day I'll get enough treasure to retire and open up a little beach shack...but probably not, cause I love me pirate life too much! Har har har!
```
Configure Model[](#configure-model "Permalink to this heading")
----------------------------------------------------------------


```
from llama\_index.llms import Anthropicllm = Anthropic(model="claude-instant-1")
```

```
resp = llm.stream\_complete("Paul Graham is ")
```

```
for r in resp:    print(r.delta, end="")
```

```
 Here are a few key facts about Paul Graham:- Paul Graham is an American computer scientist, venture capitalist, and essayist. He is known for co-founding Viaweb, one of the first web-based application companies, which was acquired by Yahoo in 1998.- In 2005, Graham co-founded Y Combinator, a startup accelerator that provides seed funding and advice to startups. Y Combinator has backed over 3,000 startups including Dropbox, Airbnb, Stripe, and Reddit. - Graham has written several influential essays on startups, programming languages, and other technology topics. Some of his most well-known essays include "Beating the Averages", "The Refragmentation", and "How to Start a Startup".- He pioneered and popularized the idea of using Lisp as a web programming language via his company Viaweb. This helped inspire interest in functional programming languages for web development.- Graham has a Bachelor's degree in philosophy from Cornell University and a PhD in computer science from Harvard University. - He was inducted into the American Academy of Arts and Sciences in 2020 for his contributions to computer science and entrepreneurship.- In addition to his work in technology and startups, Graham is also known for his essays on topics like education, productivity, and economics. Many consider him an influential writer and thinker in the tech industry.In summary, Paul Graham is a prominent computer scientist, entrepreneur, investor and writer who has made significant contributions to the web, startups and programming languages. He continues to share his insights through his writings and his work with Y Combinator.
```
Async[](#async "Permalink to this heading")
--------------------------------------------


```
from llama\_index.llms import Anthropicllm = Anthropic()resp = await llm.acomplete("Paul Graham is ")
```

```
print(resp)
```

```
 Here are some key facts about Paul Graham:- Paul Graham is an American computer scientist, venture capitalist, and essayist. He is known for co-founding Viaweb, one of the first web-based application companies, which was acquired by Yahoo in 1998.- In 1995, Graham co-founded Viaweb with Robert Morris, Trevor Blackwell, and Jessica Livingston. The company helped popularize the business model of applying software as a service.- After selling Viaweb to Yahoo, Graham became a venture capitalist. He co-founded Y Combinator in 2005 with Jessica Livingston, Trevor Blackwell, and Robert Morris. Y Combinator is an influential startup accelerator that provides seed funding and advice to startups.- Graham has written several influential essays on startups, technology, and programming. Some of his most well-known essays include "How to Start a Startup", "Do Things that Don't Scale", and "Beating the Averages" about Lisp programming. - He pioneered the concept of using online essays to attract startup founders to apply to Y Combinator's program. His essays are often required reading in Silicon Valley.- Graham has a Bachelor's degree in philosophy from Cornell University and a PhD in computer science from Harvard University. His doctoral thesis focused on Lisp compilers.- He is considered an influential figure in the tech and startup worlds, known for his insights on startups, programming languages, and technology trends. His writings have shaped the strategies of many founders building startups.
```
