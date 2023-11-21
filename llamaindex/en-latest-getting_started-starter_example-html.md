Starter Tutorial[](#starter-tutorial "Permalink to this heading")
==================================================================

Tip

Make sure you’ve followed the [installation](installation.html) steps first.

This is our famous “5 lines of code” starter example.

Download data[](#download-data "Permalink to this heading")
------------------------------------------------------------

This example uses the text of Paul Graham’s essay, [“What I Worked On”](http://paulgraham.com/worked.html). This and many other examples can be found in the `examples` folder of our repo.

The easiest way to get it is to [download it via this link](https://raw.githubusercontent.com/run-llama/llama_index/main/examples/paul_graham_essay/data/paul_graham_essay.txt) and save it in a folder called `data`.

Set your OpenAI API key[](#set-your-openai-api-key "Permalink to this heading")
--------------------------------------------------------------------------------

LlamaIndex uses OpenAI’s `gpt-3.5-turbo` by default. Make sure your API key is available to your code by setting it as an environment variable. In MacOS and Linux, this is the command:


```
export OPENAI\_API\_KEY=XXXXX
```
and on windows it is


```
set OPENAI\_API\_KEY=XXXXX
```
Load data and build an index[](#load-data-and-build-an-index "Permalink to this heading")
------------------------------------------------------------------------------------------

In the same folder where you created the `data` folder, create a file called `starter.py` file with the following:


```
from llama\_index import VectorStoreIndex, SimpleDirectoryReaderdocuments = SimpleDirectoryReader("data").load\_data()index = VectorStoreIndex.from\_documents(documents)
```
This builds an index over the documents in the `data` folder (which in this case just consists of the essay text, but could contain many documents).

Your directory structure should look like this:


```
├── starter.py└── data    └── paul_graham_essay.txt
```
Query your data[](#query-your-data "Permalink to this heading")
----------------------------------------------------------------

Add the following lines to `starter.py`


```
query\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```
This creates an engine for Q&A over your index and asks a simple question. You should get back a response similar to the following: `The author wrote short stories and tried to program on an IBM 1401.`

Viewing Queries and Events Using Logging[](#viewing-queries-and-events-using-logging "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------

Want to see what’s happening under the hood? Let’s add some logging. Add these lines to the top of `starter.py`:


```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.DEBUG)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
You can set the level to `DEBUG` for verbose output, or use `level=logging.INFO` for less.

Storing your index[](#storing-your-index "Permalink to this heading")
----------------------------------------------------------------------

By default, the data you just loaded is stored in memory as a series of vector embeddings. You can save time (and requests to OpenAI) by saving the embeddings to disk. That can be done with this line:


```
index.storage\_context.persist()
```
By default, this will save the data to the directory `storage`, but you can change that by passing a `persist\_dir` parameter.

Of course, you don’t get the benefits of persisting unless you load the data. So let’s modify `starter.py` to generate and store the index if it doesn’t exist, but load it if it does:


```
import os.pathfrom llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    StorageContext,    load\_index\_from\_storage,)# check if storage already existsif not os.path.exists("./storage"):    # load the documents and create the index    documents = SimpleDirectoryReader("data").load\_data()    index = VectorStoreIndex.from\_documents(documents)    # store it for later    index.storage\_context.persist()else:    # load the existing index    storage\_context = StorageContext.from\_defaults(persist\_dir="./storage")    index = load\_index\_from\_storage(storage\_context)# either way we can now query the indexquery\_engine = index.as\_query\_engine()response = query\_engine.query("What did the author do growing up?")print(response)
```
Now you can efficiently query to your heart’s content! But this is just the beginning of what you can do with LlamaIndex.

Next Steps

* learn more about the [high-level concepts](concepts.html).
* tell me how to [customize things](customization.html).
* curious about a specific module? check out the guides on the left 👈
