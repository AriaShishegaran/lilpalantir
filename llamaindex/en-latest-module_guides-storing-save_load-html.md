Persisting & Loading Data[](#persisting-loading-data "Permalink to this heading")
==================================================================================

Persisting Data[](#persisting-data "Permalink to this heading")
----------------------------------------------------------------

By default, LlamaIndex stores data in-memory, and this data can be explicitly persisted if desired:


```
storage\_context.persist(persist\_dir="<persist\_dir>")
```
This will persist data to disk, under the specified `persist\_dir` (or `./storage` by default).

Multiple indexes can be persisted and loaded from the same directory, assuming you keep track of index ID’s for loading.

User can also configure alternative storage backends (e.g. `MongoDB`) that persist data by default.In this case, calling `storage\_context.persist()` will do nothing.

Loading Data[](#loading-data "Permalink to this heading")
----------------------------------------------------------

To load data, user simply needs to re-create the storage context using the same configuration (e.g. pass in the same `persist\_dir` or vector store client).


```
storage\_context = StorageContext.from\_defaults(    docstore=SimpleDocumentStore.from\_persist\_dir(persist\_dir="<persist\_dir>"),    vector\_store=SimpleVectorStore.from\_persist\_dir(        persist\_dir="<persist\_dir>"    ),    index\_store=SimpleIndexStore.from\_persist\_dir(persist\_dir="<persist\_dir>"),)
```
We can then load specific indices from the `StorageContext` through some convenience functions below.


```
from llama\_index import (    load\_index\_from\_storage,    load\_indices\_from\_storage,    load\_graph\_from\_storage,)# load a single index# need to specify index\_id if multiple indexes are persisted to the same directoryindex = load\_index\_from\_storage(storage\_context, index\_id="<index\_id>")# don't need to specify index\_id if there's only one index in storage contextindex = load\_index\_from\_storage(storage\_context)# load multiple indicesindices = load\_indices\_from\_storage(storage\_context)  # loads all indicesindices = load\_indices\_from\_storage(    storage\_context, index\_ids=[index\_id1, ...])  # loads specific indices# load composable graphgraph = load\_graph\_from\_storage(    storage\_context, root\_id="<root\_id>")  # loads graph with the specified root\_id
```
Here’s the full [API Reference on saving and loading](../../api_reference/storage/indices_save_load.html).

Using a remote backend[](#using-a-remote-backend "Permalink to this heading")
------------------------------------------------------------------------------

By default, LlamaIndex uses a local filesystem to load and save files. However, you can override this by passing a `fsspec.AbstractFileSystem` object.

Here’s a simple example, instantiating a vector store:


```
import dotenvimport s3fsimport osdotenv.load\_dotenv("../../../.env")# load documentsdocuments = SimpleDirectoryReader(    "../../../examples/paul\_graham\_essay/data/").load\_data()print(len(documents))index = VectorStoreIndex.from\_documents(documents)
```
At this point, everything has been the same. Now - let’s instantiate a S3 filesystem and save / load from there.


```
# set up s3fsAWS\_KEY = os.environ["AWS\_ACCESS\_KEY\_ID"]AWS\_SECRET = os.environ["AWS\_SECRET\_ACCESS\_KEY"]R2\_ACCOUNT\_ID = os.environ["R2\_ACCOUNT\_ID"]assert AWS\_KEY is not None and AWS\_KEY != ""s3 = s3fs.S3FileSystem(    key=AWS\_KEY,    secret=AWS\_SECRET,    endpoint\_url=f"https://{R2\_ACCOUNT\_ID}.r2.cloudflarestorage.com",    s3\_additional\_kwargs={"ACL": "public-read"},)# If you're using 2+ indexes with the same StorageContext,# run this to save the index to remote blob storageindex.set\_index\_id("vector\_index")# persist index to s3s3\_bucket\_name = "llama-index/storage\_demo"  # {bucket\_name}/{index\_name}index.storage\_context.persist(persist\_dir=s3\_bucket\_name, fs=s3)# load index from s3index\_from\_s3 = load\_index\_from\_storage(    StorageContext.from\_defaults(persist\_dir=s3\_bucket\_name, fs=s3),    index\_id="vector\_index",)
```
By default, if you do not pass a filesystem, we will assume a local filesystem.

