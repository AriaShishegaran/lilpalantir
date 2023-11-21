[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/openai_agent_retrieval.ipynb)

Retrieval-Augmented OpenAI Agent[](#retrieval-augmented-openai-agent "Permalink to this heading")
==================================================================================================

In this tutorial, we show you how to use our `FnRetrieverOpenAI` implementationto build an agent on top of OpenAI’s function API and store/index an arbitrary number of tools. Our indexing/retrieval modules help to remove the complexity of having too many functions to fit in the prompt.

Initial Setup[](#initial-setup "Permalink to this heading")
------------------------------------------------------------

Let’s start by importing some simple building blocks.

The main thing we need is:

1. the OpenAI API
2. a place to keep conversation history
3. a definition for tools that our agent can use.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import jsonfrom typing import Sequencefrom llama\_index.tools import BaseTool, FunctionTool
```

```
/Users/suo/miniconda3/envs/llama/lib/python3.9/site-packages/deeplake/util/check_latest_version.py:32: UserWarning: A newer version of deeplake (3.6.7) is available. It's recommended that you update to the latest version using `pip install -U deeplake`.  warnings.warn(
```
Let’s define some very simple calculator tools for our agent.


```
def multiply(a: int, b: int) -> int: """Multiply two integers and returns the result integer"""    return a \* bdef add(a: int, b: int) -> int: """Add two integers and returns the result integer"""    return a + bdef useless(a: int, b: int) -> int: """Toy useless function."""    passmultiply\_tool = FunctionTool.from\_defaults(fn=multiply, name="multiply")useless\_tools = [    FunctionTool.from\_defaults(fn=useless, name=f"useless\_{str(idx)}")    for idx in range(28)]add\_tool = FunctionTool.from\_defaults(fn=add, name="add")all\_tools = [multiply\_tool] + [add\_tool] + useless\_toolsall\_tools\_map = {t.metadata.name: t for t in all\_tools}
```
Building an Object Index[](#building-an-object-index "Permalink to this heading")
----------------------------------------------------------------------------------

We have an `ObjectIndex` construct in LlamaIndex that allows the user to use our index data structures over arbitrary objects.The ObjectIndex will handle serialiation to/from the object, and use an underying index (e.g. VectorStoreIndex, SummaryIndex, KeywordTableIndex) as the storage mechanism.

In this case, we have a large collection of Tool objects, and we’d want to define an ObjectIndex over these Tools.

The index comes bundled with a retrieval mechanism, an `ObjectRetriever`.

This can be passed in to our agent so that it canperform Tool retrieval during query-time.


```
# define an "object" index over these toolsfrom llama\_index import VectorStoreIndexfrom llama\_index.objects import ObjectIndex, SimpleToolNodeMappingtool\_mapping = SimpleToolNodeMapping.from\_objects(all\_tools)obj\_index = ObjectIndex.from\_objects(    all\_tools,    tool\_mapping,    VectorStoreIndex,)
```
Our `FnRetrieverOpenAIAgent` Implementation[](#our-fnretrieveropenaiagent-implementation "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------

We provide a `FnRetrieverOpenAIAgent` implementation in LlamaIndex, which can take in an `ObjectRetriever` over a set of `BaseTool` objects.

During query-time, we would first use the `ObjectRetriever` to retrieve a set of relevant Tools. These tools would then be passed into the agent; more specifically, their function signatures would be passed into the OpenAI Function calling API.


```
from llama\_index.agent import FnRetrieverOpenAIAgent
```

```
agent = FnRetrieverOpenAIAgent.from\_retriever(    obj\_index.as\_retriever(), verbose=True)
```

```
agent.chat("What's 212 multiplied by 122? Make sure to use Tools")
```

```
=== Calling Function ===Calling function: multiply with args: {  "a": 212,  "b": 122}Got output: 25864========================
```

```
Response(response='212 multiplied by 122 is 25,864.', source_nodes=[], metadata=None)
```

```
agent.chat("What's 212 added to 122 ? Make sure to use Tools")
```

```
=== Calling Function ===Calling function: add with args: {  "a": 212,  "b": 122}Got output: 334========================
```

```
Response(response='212 added to 122 is 334.', source_nodes=[], metadata=None)
```
