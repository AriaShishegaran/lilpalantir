Usage Pattern[](#usage-pattern "Permalink to this heading")
============================================================

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

Each data loader contains a “Usage” section showing how that loader can be used. At the core of using each loader is a `download\_loader` function, whichdownloads the loader file into a module that you can use within your application.

Example usage:


```
from llama\_index import VectorStoreIndex, download\_loaderGoogleDocsReader = download\_loader("GoogleDocsReader")gdoc\_ids = ["1wf-y2pd9C878Oh-FmLH7Q\_BQkljdm6TQal-c1pUfrec"]loader = GoogleDocsReader()documents = loader.load\_data(document\_ids=gdoc\_ids)index = VectorStoreIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()query\_engine.query("Where did the author go to school?")
```
