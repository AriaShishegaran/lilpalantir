[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/Ollama.ipynb)

Ollama - Llama 2 7B[](#ollama-llama-2-7b "Permalink to this heading")
======================================================================

Setup[](#setup "Permalink to this heading")
--------------------------------------------

First, follow the [readme](https://github.com/jmorganca/ollama) to set up and run a local Ollama instance.

When the Ollama app is running on your local machine:

* All of your local models are automatically served on localhost:11434
* Select your model when setting llm = Ollama(…, model=”:”)
* If you set llm = Ollama(…, model=”<model family”) without a version it will simply look for latest

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.llms import Ollama
```

```
llm = Ollama(model="llama2")
```

```
resp = llm.complete("Who is Paul Graham?")
```

```
print(resp)
```

```
 Paul Graham is a well-known entrepreneur, investor, and writer who has made significant contributions to the startup world.➖Here are some key facts about Paul Graham:1. Co-founder of Y Combinator: Graham co-founded Y Combinator, a renowned startup accelerator, in 2005. He is one of the most successful and influential investors in Silicon Valley.➖2. Investor in successful startups: Graham has invested in many successful startups, including Airbnb, Dropbox, Reddit, Stripe, and Instacart. These companies have collectively raised billions of dollars in funding and have become household names.➖3. Writer and blogger: Graham is also a prolific writer and blogger. He has written several books on startups, including "Do Things That Don't Scale" and "How to Start a Startup." His blog, paulgraham.com, is popular among entrepreneurs and investors.➖4. Focus on startup culture: Graham is known for his focus on the cultural aspects of startups, such as the importance of psychological safety, clear communication, and a bias toward action. He has written extensively on these topics and has helped shape the way startups think about company culture.➖5. Influence beyond Silicon Valley: Graham's ideas and advice have had a significant impact beyond Silicon Valley. Many entrepreneurs and investors around the world follow his blog and attend his lectures and workshops. He has become a prominent voice in the global startup community.➖6. Personal interests: Graham is also interested in personal growth and self-improvement. He meditates regularly and has written about the benefits of mindfulness practice. He is also an avid reader and enjoys learning new things.➖7. Education: Graham holds a Bachelor's degree in Computer Science from Harvard University and a Master's degree in Computer Science from the University of California, Berkeley.➖8. Awards and recognition: Graham has received numerous awards and recognitions for his contributions to the startup world. He was named one of the 100 most influential people in the world by Time magazine in 2013.➖9. Controversial views: Graham has expressed controversial views on certain topics, such as the importance of technical skill in founders and the potential for AI to displace human workers. However, his opinions are widely respected and have contributed to the ongoing conversation around startup culture and innovation.➖10. Philanthropy: Graham is also known for his philanthropic efforts, particularly in the area of education. He has donated millions of dollars to various educational organizations and has advocated for greater access to quality education.➖Overall, Paul Graham is a highly respected figure in the startup world, known for his innovative approach to entrepreneurship, investing, and company culture. His ideas and advice have had a significant impact on the global startup community, and he continues to be an influential voice in the industry today.
```
### Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")


```
from llama\_index.llms import ChatMessagemessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = llm.chat(messages)
```

```
print(resp)
```

```
assistant:  ARRGH! Me hearty! *adjusts eye patch* me name be Captain Blackbeak, the most feared and respected pirate on the seven seas! *winks* What be bringin' ye to these waters, matey?
```
### Streaming[](#streaming "Permalink to this heading")

Using `stream\_complete` endpoint


```
response = llm.stream\_complete("Who is Paul Graham?")
```

```
for r in response:    print(r.delta, end="")
```

```
 Paul Graham is a well-known entrepreneur, investor, and writer who has been involved in the startup community for several decades. Einzeln hat er co-founded several successful startups, including Viaweb, which was acquired by Yahoo!, and Viaweb Technologies, which was spun out of Viaweb and is now a subsidiary of Google. He is also the founder of Y Combinator, a well-known startup accelerator that has funded successful companies like Airbnb, Dropbox, and Reddit.Graham is known for his essays on startups, entrepreneurship, and the tech industry, which have been widely read and discussed within the startup community. His writing often focuses on the practicalities of starting and growing a successful business, as well as the mindset and culture required to succeed in the technology industry.Some of his notable essays include:* "How to Start a Startup" - This essay provides practical advice for entrepreneurs looking to start a new business, including how to identify a market need, build a team, and raise capital.* "The Three Faces of the Entrepreneur" - In this essay, Graham identifies three types of entrepreneurs: the hobbyist, the technologist, and the salesperson. He argues that each type has its own strengths and weaknesses, and that successful startups often require a combination of these approaches.* "The Paradox of Choice" - In this essay, Graham explores the idea that too much choice can actually be harmful to entrepreneurs and startups. He argues that too many options can lead to analysis paralysis and a lack of focus, and that successful startups often require a clear and narrow focus.* "The End of the Beginning" - In this essay, Graham reflects on the changes he has seen in the startup ecosystem over the years, including the rise of accelerators, the importance of network effects, and the increasing emphasis on diversity and inclusion.Overall, Paul Graham is a respected figure within the startup community, known for his practical advice, insightful observations, and commitment to supporting innovative companies.
```
Using `stream\_chat` endpoint


```
from llama\_index.llms import ChatMessagemessages = [    ChatMessage(        role="system", content="You are a pirate with a colorful personality"    ),    ChatMessage(role="user", content="What is your name"),]resp = llm.stream\_chat(messages)
```

```
for r in resp:    print(r.delta, end="")
```

```
 Shiver me timbers! Me name be Captain Blackbeak, the most feared and respected pirate on the seven seas! *adjusts eye patch* What be bringin' ye to these waters, matey? Are ye lookin' for a life of adventure and treasure? Or maybe just want to hear some tales of me exploits? Arrrr!
```
