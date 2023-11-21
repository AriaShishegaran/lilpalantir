Customizing LLMs within LlamaIndex Abstractions[](#customizing-llms-within-llamaindex-abstractions "Permalink to this heading")
================================================================================================================================

You can plugin these LLM abstractions within our other modules in LlamaIndex (indexes, retrievers, query engines, agents) which allow you to build advanced workflows over your data.

By default, we use OpenAI’s `gpt-3.5-turbo` model. But you may choose to customizethe underlying LLM being used.

Below we show a few examples of LLM customization. This includes

* changing the underlying LLM
* changing the number of output tokens (for OpenAI, Cohere, or AI21)
* having more fine-grained control over all parameters for any LLM, from context window to chunk overlap

Example: Changing the underlying LLM[](#example-changing-the-underlying-llm "Permalink to this heading")
---------------------------------------------------------------------------------------------------------

An example snippet of customizing the LLM being used is shown below.In this example, we use `gpt-4` instead of `gpt-3.5-turbo`. Available models include `gpt-3.5-turbo`, `gpt-3.5-turbo-instruct`, `gpt-3.5-turbo-16k`, `gpt-4`, `gpt-4-32k`, `text-davinci-003`, and `text-davinci-002`.

Note thatyou may also plug in any LLM shown on Langchain’s[LLM](https://python.langchain.com/docs/integrations/llms/) page.


```
from llama\_index import (    KeywordTableIndex,    SimpleDirectoryReader,    LLMPredictor,    ServiceContext,)from llama\_index.llms import OpenAI# alternatively# from langchain.llms import ...documents = SimpleDirectoryReader("data").load\_data()# define LLMllm = OpenAI(temperature=0.1, model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)# build indexindex = KeywordTableIndex.from\_documents(    documents, service\_context=service\_context)# get response from queryquery\_engine = index.as\_query\_engine()response = query\_engine.query(    "What did the author do after his time at Y Combinator?")
```
Example: Changing the number of output tokens (for OpenAI, Cohere, AI21)[](#example-changing-the-number-of-output-tokens-for-openai-cohere-ai21 "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The number of output tokens is usually set to some low number by default (for instance,with OpenAI the default is 256).

For OpenAI, Cohere, AI21, you just need to set the `max\_tokens` parameter(or maxTokens for AI21). We will handle text chunking/calculations under the hood.


```
from llama\_index import (    KeywordTableIndex,    SimpleDirectoryReader,    ServiceContext,)from llama\_index.llms import OpenAIdocuments = SimpleDirectoryReader("data").load\_data()# define LLMllm = OpenAI(temperature=0, model="text-davinci-002", max\_tokens=512)service\_context = ServiceContext.from\_defaults(llm=llm)
```
Example: Explicitly configure `context\_window` and `num\_output`[](#example-explicitly-configure-context-window-and-num-output "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------------

If you are using other LLM classes from langchain, you may need to explicitly configure the `context\_window` and `num\_output` via the `ServiceContext` since the information is not available by default.


```
from llama\_index import (    KeywordTableIndex,    SimpleDirectoryReader,    ServiceContext,)from llama\_index.llms import OpenAI# alternatively# from langchain.llms import ...documents = SimpleDirectoryReader("data").load\_data()# set context windowcontext\_window = 4096# set number of output tokensnum\_output = 256# define LLMllm = OpenAI(    temperature=0,    model="text-davinci-002",    max\_tokens=num\_output,)service\_context = ServiceContext.from\_defaults(    llm=llm,    context\_window=context\_window,    num\_output=num\_output,)
```
Example: Using a HuggingFace LLM[](#example-using-a-huggingface-llm "Permalink to this heading")
-------------------------------------------------------------------------------------------------

LlamaIndex supports using LLMs from HuggingFace directly. Note that for a completely private experience, also setup a [local embedding model](../embeddings.html#custom-embeddings).

Many open-source models from HuggingFace require either some preamble before each prompt, which is a `system\_prompt`. Additionally, queries themselves may need an additional wrapper around the `query\_str` itself. All this information is usually available from the HuggingFace model card for the model you are using.

Below, this example uses both the `system\_prompt` and `query\_wrapper\_prompt`, using specific prompts from the model card found [here](https://huggingface.co/stabilityai/stablelm-tuned-alpha-3b).


```
from llama\_index.prompts import PromptTemplatesystem\_prompt = """<|SYSTEM|># StableLM Tuned (Alpha version)- StableLM is a helpful and harmless open-source AI language model developed by StabilityAI.- StableLM is excited to be able to help the user, but will refuse to do anything that could be considered harmful to the user.- StableLM is more than just an information source, StableLM is also able to write poetry, short stories, and make jokes.- StableLM will refuse to participate in anything that could harm a human."""# This will wrap the default prompts that are internal to llama-indexquery\_wrapper\_prompt = PromptTemplate("<|USER|>{query\_str}<|ASSISTANT|>")import torchfrom llama\_index.llms import HuggingFaceLLMllm = HuggingFaceLLM(    context\_window=4096,    max\_new\_tokens=256,    generate\_kwargs={"temperature": 0.7, "do\_sample": False},    system\_prompt=system\_prompt,    query\_wrapper\_prompt=query\_wrapper\_prompt,    tokenizer\_name="StabilityAI/stablelm-tuned-alpha-3b",    model\_name="StabilityAI/stablelm-tuned-alpha-3b",    device\_map="auto",    stopping\_ids=[50278, 50279, 50277, 1, 0],    tokenizer\_kwargs={"max\_length": 4096},    # uncomment this if using CUDA to reduce memory usage    # model\_kwargs={"torch\_dtype": torch.float16})service\_context = ServiceContext.from\_defaults(    chunk\_size=1024,    llm=llm,)
```
Some models will raise errors if all the keys from the tokenizer are passed to the model. A common tokenizer output that causes issues is `token\_type\_ids`. Below is an example of configuring the predictor to remove this before passing the inputs to the model:


```
HuggingFaceLLM(    # ...    tokenizer\_outputs\_to\_remove=["token\_type\_ids"])
```
A full API reference can be found [here](../../../api_reference/llms/huggingface.html).

Several example notebooks are also listed below:

* [StableLM](../../../examples/customization/llms/SimpleIndexDemo-Huggingface_stablelm.html)
* [Camel](../../../examples/customization/llms/SimpleIndexDemo-Huggingface_camel.html)
Example: Using a Custom LLM Model - Advanced[](#example-using-a-custom-llm-model-advanced "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------

To use a custom LLM model, you only need to implement the `LLM` class (or `CustomLLM` for a simpler interface)You will be responsible for passing the text to the model and returning the newly generated tokens.

Note that for a completely private experience, also setup a [local embedding model](../embeddings.html#custom-embeddings).

Here is a small example using locally running facebook/OPT model and Huggingface’s pipeline abstraction:


```
import torchfrom transformers import pipelinefrom typing import Optional, List, Mapping, Anyfrom llama\_index import ServiceContext, SimpleDirectoryReader, SummaryIndexfrom llama\_index.callbacks import CallbackManagerfrom llama\_index.llms import (    CustomLLM,    CompletionResponse,    CompletionResponseGen,    LLMMetadata,)from llama\_index.llms.base import llm\_completion\_callback# set context window sizecontext\_window = 2048# set number of output tokensnum\_output = 256# store the pipeline/model outside of the LLM class to avoid memory issuesmodel\_name = "facebook/opt-iml-max-30b"pipeline = pipeline(    "text-generation",    model=model\_name,    device="cuda:0",    model\_kwargs={"torch\_dtype": torch.bfloat16},)class OurLLM(CustomLLM):    @property    def metadata(self) -> LLMMetadata: """Get LLM metadata."""        return LLMMetadata(            context\_window=context\_window,            num\_output=num\_output,            model\_name=model\_name,        )    @llm\_completion\_callback()    def complete(self, prompt: str, \*\*kwargs: Any) -> CompletionResponse:        prompt\_length = len(prompt)        response = pipeline(prompt, max\_new\_tokens=num\_output)[0][            "generated\_text"        ]        # only return newly generated tokens        text = response[prompt\_length:]        return CompletionResponse(text=text)    @llm\_completion\_callback()    def stream\_complete(        self, prompt: str, \*\*kwargs: Any    ) -> CompletionResponseGen:        raise NotImplementedError()# define our LLMllm = OurLLM()service\_context = ServiceContext.from\_defaults(    llm=llm,    embed\_model="local:BAAI/bge-base-en-v1.5",    context\_window=context\_window,    num\_output=num\_output,)# Load the your datadocuments = SimpleDirectoryReader("./data").load\_data()index = SummaryIndex.from\_documents(documents, service\_context=service\_context)# Query and print responsequery\_engine = index.as\_query\_engine()response = query\_engine.query("<query\_text>")print(response)
```
Using this method, you can use any LLM. Maybe you have one running locally, or running on your own server. As long as the class is implemented and the generated tokens are returned, it should work out. Note that we need to use the prompt helper to customize the prompt sizes, since every model has a slightly different context length.

The decorator is optional, but provides observability via callbacks on the LLM calls.

Note that you may have to adjust the internal prompts to get good performance. Even then, you should be using a sufficiently large LLM to ensure it’s capable of handling the complex queries that LlamaIndex uses internally, so your mileage may vary.

A list of all default internal prompts is available [here](https://github.com/run-llama/llama_index/blob/main/llama_index/prompts/default_prompts.py), and chat-specific prompts are listed [here](https://github.com/run-llama/llama_index/blob/main/llama_index/prompts/chat_prompts.py). You can also implement [your own custom prompts](../prompts.html).

