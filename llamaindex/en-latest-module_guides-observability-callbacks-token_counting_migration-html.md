Token Counting - Migration Guide[](#token-counting-migration-guide "Permalink to this heading")
================================================================================================

The existing token counting implementation has been **deprecated**.

We know token counting is important to many users, so this guide was created to walkthrough a (hopefully painless) transition.

Previously, token counting was kept track of on the `llm\_predictor` and `embed\_model` objects directly, and optionally printed to the console. This implementation used a static tokenizer for token counting (gpt-2), and the `last\_token\_usage` and `total\_token\_usage` attributes were not always kept track of properly.

Going forward, token counting as moved into a callback. Using the `TokenCountingHandler` callback, you now have more options for how tokens are counted, the lifetime of the token counts, and even creating separate token counters for different indexes.

Here is a minimum example of using the new `TokenCountingHandler` with an OpenAI model:


```
import tiktokenfrom llama\_index.callbacks import CallbackManager, TokenCountingHandlerfrom llama\_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContext# you can set a tokenizer directly, or optionally let it default# to the same tokenizer that was used previously for token counting# NOTE: The tokenizer should be a function that takes in text and returns a list of tokenstoken\_counter = TokenCountingHandler(    tokenizer=tiktoken.encoding\_for\_model("text-davinci-003").encode,    verbose=False,  # set to true to see usage printed to the console)callback\_manager = CallbackManager([token\_counter])service\_context = ServiceContext.from\_defaults(    callback\_manager=callback\_manager)document = SimpleDirectoryReader("./data").load\_data()# if verbose is turned on, you will see embedding token usage printedindex = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)# otherwise, you can access the count directlyprint(token\_counter.total\_embedding\_token\_count)# reset the counts at your discretion!token\_counter.reset\_counts()# also track prompt, completion, and total LLM tokens, in addition to embeddingsresponse = index.as\_query\_engine().query("What did the author do growing up?")print(    "Embedding Tokens: ",    token\_counter.total\_embedding\_token\_count,    "\n",    "LLM Prompt Tokens: ",    token\_counter.prompt\_llm\_token\_count,    "\n",    "LLM Completion Tokens: ",    token\_counter.completion\_llm\_token\_count,    "\n",    "Total LLM Token Count: ",    token\_counter.total\_llm\_token\_count,)
```
