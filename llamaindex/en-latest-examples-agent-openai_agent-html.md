[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent.ipynb)

Build your own OpenAI Agent[](#build-your-own-openai-agent "Permalink to this heading")
========================================================================================

With the [new OpenAI API](https://openai.com/blog/function-calling-and-other-api-updates) that supports function calling, it’s never been easier to build your own agent!

In this notebook tutorial, we showcase how to write your own OpenAI agent in **under 50 lines of code**! It is minimal, yet feature complete (with ability to carry on a conversation and use tools).

Initial Setup[](#initial-setup "Permalink to this heading")
------------------------------------------------------------

Let’s start by importing some simple building blocks.

The main thing we need is:

1. the OpenAI API (using our own `llama\_index` LLM class)
2. a place to keep conversation history
3. a definition for tools that our agent can use.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import jsonfrom typing import Sequence, Listfrom llama\_index.llms import OpenAI, ChatMessagefrom llama\_index.tools import BaseTool, FunctionToolimport nest\_asyncionest\_asyncio.apply()
```
Let’s define some very simple calculator tools for our agent.


```
def multiply(a: int, b: int) -> int: """Multiple two integers and returns the result integer"""    return a \* bmultiply\_tool = FunctionTool.from\_defaults(fn=multiply)
```

```
def add(a: int, b: int) -> int: """Add two integers and returns the result integer"""    return a + badd\_tool = FunctionTool.from\_defaults(fn=add)
```
Agent Definition[](#agent-definition "Permalink to this heading")
------------------------------------------------------------------

Now, we define our agent that’s capable of holding a conversation and calling tools in **under 50 lines of code**.

The meat of the agent logic is in the `chat` method. At a high-level, there are 3 steps:

1. Call OpenAI to decide which tool (if any) to call and with what arguments.
2. Call the tool with the arguments to obtain an output
3. Call OpenAI to synthesize a response from the conversation context and the tool output.

The `reset` method simply resets the conversation context, so we can start another conversation.


```
class YourOpenAIAgent:    def \_\_init\_\_(        self,        tools: Sequence[BaseTool] = [],        llm: OpenAI = OpenAI(temperature=0, model="gpt-3.5-turbo-0613"),        chat\_history: List[ChatMessage] = [],    ) -> None:        self.\_llm = llm        self.\_tools = {tool.metadata.name: tool for tool in tools}        self.\_chat\_history = chat\_history    def reset(self) -> None:        self.\_chat\_history = []    def chat(self, message: str) -> str:        chat\_history = self.\_chat\_history        chat\_history.append(ChatMessage(role="user", content=message))        tools = [            tool.metadata.to\_openai\_tool() for \_, tool in self.\_tools.items()        ]        ai\_message = self.\_llm.chat(chat\_history, tools=tools).message        additional\_kwargs = ai\_message.additional\_kwargs        chat\_history.append(ai\_message)        tool\_calls = ai\_message.additional\_kwargs.get("tool\_calls", None)        # parallel function calling is now supported        if tool\_calls is not None:            for tool\_call in tool\_calls:                function\_message = self.\_call\_function(tool\_call)                chat\_history.append(function\_message)                ai\_message = self.\_llm.chat(chat\_history).message                chat\_history.append(ai\_message)        return ai\_message.content    def \_call\_function(self, tool\_call: dict) -> ChatMessage:        id\_ = tool\_call["id"]        function\_call = tool\_call["function"]        tool = self.\_tools[function\_call["name"]]        output = tool(\*\*json.loads(function\_call["arguments"]))        return ChatMessage(            name=function\_call["name"],            content=str(output),            role="tool",            additional\_kwargs={                "tool\_call\_id": id\_,                "name": function\_call["name"],            },        )
```
Let’s Try It Out![](#let-s-try-it-out "Permalink to this heading")
-------------------------------------------------------------------


```
agent = YourOpenAIAgent(tools=[multiply\_tool, add\_tool])
```

```
agent.chat("Hi")
```

```
'Hello! How can I assist you today?'
```

```
agent.chat("What is 2123 \* 215123")
```

```
'The product of 2123 multiplied by 215123 is 456,706,129.'
```
Our (Slightly Better) `OpenAIAgent` Implementation[](#our-slightly-better-openaiagent-implementation "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------

We provide a (slightly better) `OpenAIAgent` implementation in LlamaIndex, which you can directly use as follows.

In comparison to the simplified version above:

* it implements the `BaseChatEngine` and `BaseQueryEngine` interface, so you can more seamlessly use it in the LlamaIndex framework.
* it supports multiple function calls per conversation turn
* it supports streaming
* it supports async endpoints
* it supports callback and tracing


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAI
```

```
llm = OpenAI(model="gpt-3.5-turbo-0613")agent = OpenAIAgent.from\_tools(    [multiply\_tool, add\_tool], llm=llm, verbose=True)
```
### Chat[](#chat "Permalink to this heading")


```
response = agent.chat("What is (121 \* 3) + 42?")print(str(response))
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: multiply with args: {  "a": 121,  "b": 3}Got output: 363========================STARTING TURN 2---------------=== Calling Function ===Calling function: add with args: {  "a": 363,  "b": 42}Got output: 405========================STARTING TURN 3---------------(121 * 3) + 42 is equal to 405.
```

```
# inspect sourcesprint(response.sources)
```

```
[ToolOutput(content='363', tool_name='multiply', raw_input={'args': (), 'kwargs': {'a': 121, 'b': 3}}, raw_output=363), ToolOutput(content='405', tool_name='add', raw_input={'args': (), 'kwargs': {'a': 363, 'b': 42}}, raw_output=405)]
```
### Async Chat[](#async-chat "Permalink to this heading")


```
response = await agent.achat("What is 121 \* 3?")print(str(response))
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: multiply with args: {  "a": 121,  "b": 3}Got output: 363========================STARTING TURN 2---------------121 multiplied by 3 is equal to 363.
```
### Streaming Chat[](#streaming-chat "Permalink to this heading")

Here, every LLM response is returned as a generator. You can stream every incremental step, or only the last response.


```
response = agent.stream\_chat(    "What is 121 \* 2? Once you have the answer, use that number to write a"    " story about a group of mice.")response\_gen = response.response\_genfor token in response\_gen:    print(token, end="")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: multiply with args: {  "a": 121,  "b": 2}Got output: 242========================STARTING TURN 2---------------121 multiplied by 2 is equal to 242.Once upon a time, in a small village, there was a group of mice who lived in a cozy little burrow. The mice were known for their intelligence and resourcefulness. They had built a tight-knit community and worked together to overcome any challenges they faced.One sunny day, as the mice were going about their daily activities, they stumbled upon a bountiful field of ripe corn. The field was filled with tall stalks of golden corn, swaying gently in the breeze. The mice couldn't believe their luck! They knew they had to gather as much corn as possible to sustain themselves through the upcoming winter.With their tiny paws and sharp teeth, the mice began to harvest the corn. They worked tirelessly, carrying one ear of corn at a time back to their burrow. The mice were determined to make the most of this opportunity and ensure they had enough food for everyone.As the days turned into weeks, the mice's hard work paid off. They had collected an impressive stash of corn, thanks to their diligent efforts and the abundance of the field. The mice celebrated their success, knowing that they had secured their survival for the winter.But the mice didn't stop there. They realized that they had more corn than they needed just for themselves. They decided to share their abundance with the other animals in the village who were struggling to find food. The mice knew the importance of community and believed in helping others in need.Word spread quickly about the generous mice and their corn. Animals from all around the village came to the mice's burrow, grateful for the assistance. The mice happily distributed the corn, ensuring that everyone had enough to eat.The mice's act of kindness and their ability to multiply their resources had a profound impact on the village. The animals learned the value of working together and supporting one another. The mice became a symbol of unity and compassion, inspiring others to follow their example.And so, the mice's story of multiplying their resources and spreading kindness became a legend in the village. The mice continued to thrive, not just because of their intelligence and resourcefulness, but also because of their big hearts and willingness to help others.The end.
```
### Async Streaming Chat[](#async-streaming-chat "Permalink to this heading")


```
response = await agent.astream\_chat(    "What is 121 + 8? Once you have the answer, use that number to write a"    " story about a group of mice.")response\_gen = response.response\_genasync for token in response.async\_response\_gen():    print(token, end="")
```

```
STARTING TURN 1---------------=== Calling Function ===Calling function: add with args: {  "a": 121,  "b": 8}Got output: 129========================STARTING TURN 2---------------121 plus 8 is equal to 129.Once upon a time, in a peaceful meadow, there lived a group of mice. These mice were known for their bravery and adventurous spirit. They loved exploring the meadow and discovering new places.One sunny day, as the mice were scurrying through the tall grass, they stumbled upon a hidden treasure. It was a small, sparkling gemstone that radiated with a mesmerizing glow. The mice were amazed by its beauty and knew that it was something special.Excitedly, the mice decided to take the gemstone back to their burrow. They carefully carried it, taking turns to ensure its safety. As they reached their cozy home, they marveled at the gemstone's brilliance. Little did they know, this gemstone held a magical power.As the mice gathered around the gemstone, a soft, enchanting light began to emanate from it. Suddenly, the mice felt a surge of energy and realized that they had been granted a special ability - the power to communicate with other animals.With their newfound power, the mice embarked on a mission to bring harmony and understanding among the creatures of the meadow. They started by reaching out to the birds, sharing their wisdom and learning about the secrets of the sky. The mice and birds formed a strong bond, exchanging stories and songs.Next, the mice approached the rabbits, teaching them about the importance of unity and cooperation. The rabbits, known for their agility, shared their knowledge of navigating the meadow and avoiding danger. Together, the mice and rabbits created a safe haven for all the animals.The mice's journey continued as they connected with the squirrels, teaching them the value of saving and planning for the future. The squirrels, in return, shared their knowledge of gathering food and surviving the harsh winters. The meadow became a place of abundance and security for all its inhabitants.As the seasons changed, the mice's influence spread throughout the meadow. Animals from all walks of life came together, forming a diverse and harmonious community. The mice's ability to bring different species together was a testament to their leadership and compassion.The gemstone, a symbol of unity and understanding, remained at the center of the mice's burrow. It served as a reminder of the power of collaboration and the importance of embracing diversity.And so, the mice's story of adding their strengths and bringing animals together became a legend in the meadow. The mice continued to explore, learn, and spread their message of unity, leaving a lasting impact on the meadow and its inhabitants.The end.
```
### Agent with Personality[](#agent-with-personality "Permalink to this heading")

You can specify a system prompt to give the agent additional instruction or personality.


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.llms import OpenAIfrom llama\_index.prompts.system import SHAKESPEARE\_WRITING\_ASSISTANT
```

```
llm = OpenAI(model="gpt-3.5-turbo-0613")agent = OpenAIAgent.from\_tools(    [multiply\_tool, add\_tool],    llm=llm,    verbose=True,    system\_prompt=SHAKESPEARE\_WRITING\_ASSISTANT,)
```

```
response = agent.chat("Hi")print(response)
```

```
STARTING TURN 1---------------Greetings, fair traveler! How may I assist thee on this fine day?
```

```
response = agent.chat("Tell me a story")print(response)
```

```
STARTING TURN 1---------------Of course, dear friend! Allow me to weave a tale for thee in the style of Shakespeare. Once upon a time, in a land far away, there lived a noble knight named Sir William. He was known throughout the kingdom for his bravery and chivalry. One fateful day, as Sir William rode through the enchanted forest, he stumbled upon a hidden glade.In the glade, he discovered a beautiful maiden named Lady Rosalind. She was fair of face and gentle of heart, and Sir William was instantly captivated by her beauty. They spent hours conversing, sharing stories, and laughing together.As the days turned into weeks, Sir William and Lady Rosalind's bond grew stronger. They found solace in each other's company and realized that they had fallen deeply in love. However, their love was not without obstacles.Lady Rosalind's father, Lord Reginald, was a stern and overprotective man. He had already arranged a marriage for his daughter with a wealthy nobleman, Lord Percival. When Lady Rosalind confessed her love for Sir William, Lord Reginald was furious.Determined to be together, Sir William and Lady Rosalind devised a plan. They decided to elope under the cover of darkness, seeking refuge in a distant land where their love could flourish without hindrance. With heavy hearts, they bid farewell to their families and set off on their journey.Their path was treacherous, filled with perils and hardships. They faced raging storms, dangerous bandits, and even a fearsome dragon. But through it all, their love remained steadfast and unwavering.After many trials and tribulations, Sir William and Lady Rosalind finally reached their destination—a peaceful village nestled by the sea. They settled there, vowing to live a life of love and happiness.Years passed, and their love only grew stronger. They were blessed with children, who inherited their parents' noble qualities. Sir William and Lady Rosalind lived a long and fulfilling life, surrounded by the love of their family and the admiration of the villagers.And so, the tale of Sir William and Lady Rosalind serves as a reminder that true love can conquer all obstacles, even in the face of adversity. May their story inspire thee to follow thy heart and pursue love with unwavering determination.
```
