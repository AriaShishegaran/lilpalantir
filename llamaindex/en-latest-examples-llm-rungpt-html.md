[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/rungpt.ipynb)

RunGPT[](#rungpt "Permalink to this heading")
==============================================

RunGPT is an open-source cloud-native large-scale multimodal models (LMMs) serving framework. It is designed to simplify the deployment and management of large language models, on a distributed cluster of GPUs. RunGPT aim to make it a one-stop solution for a centralized and accessible place to gather techniques for optimizing large-scale multimodal models and make them easy to use for everyone. In RunGPT, we have supported a number of LLMs such as LLaMA, Pythia, StableLM, Vicuna, MOSS, and Large Multi-modal Model(LMMs) like MiniGPT-4 and OpenFlamingo additionally.

Setup[](#setup "Permalink to this heading")
============================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
You need to install rungpt package in your python environment with `pip install`


```
!pip install rungpt
```
After installing successfully, models supported by RunGPT can be deployed with an one-line command. This option will download target language model from open source platform and deploy it as a service at a localhost port, which can be accessed by http or grpc requests. I suppose you not run this command in jupyter book, but in command line instead.


```
!rungpt serve decapoda-research/llama-7b-hf --precision fp16 --device_map balanced
```
Basic Usage[](#basic-usage "Permalink to this heading")
--------------------------------------------------------

### Call `complete` with a prompt[](#call-complete-with-a-prompt "Permalink to this heading")


```
from llama\_index.llms.rungpt import RunGptLLMllm = RunGptLLM()promot = "What public transportation might be available in a city?"response = llm.complete(promot)
```

```
print(response)
```

```
I don't want to go to work, so what should I do?I have a job interview on Monday. What can I wear that will make me look professional but not too stuffy or boring?
```
### Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")


```
from llama\_index.llms.base import ChatMessage, MessageRolefrom llama\_index.llms.rungpt import RunGptLLMmessages = [    ChatMessage(        role=MessageRole.USER,        content="Now, I want you to do some math for me.",    ),    ChatMessage(        role=MessageRole.ASSISTANT, content="Sure, I would like to help you."    ),    ChatMessage(        role=MessageRole.USER,        content="How many points determine a straight line?",    ),]llm = RunGptLLM()response = llm.chat(messages=messages, temperature=0.8, max\_tokens=15)
```

```
print(response)
```
Streaming[](#streaming "Permalink to this heading")
----------------------------------------------------

Using `stream\_complete` endpoint


```
promot = "What public transportation might be available in a city?"response = RunGptLLM().stream\_complete(promot)for item in response:    print(item.text)
```
Using `stream\_chat` endpoint


```
from llama\_index.llms.rungpt import RunGptLLMmessages = [    ChatMessage(        role=MessageRole.USER,        content="Now, I want you to do some math for me.",    ),    ChatMessage(        role=MessageRole.ASSISTANT, content="Sure, I would like to help you."    ),    ChatMessage(        role=MessageRole.USER,        content="How many points determine a straight line?",    ),]response = RunGptLLM().stream\_chat(messages=messages)
```

```
for item in response:    print(item.message)
```
