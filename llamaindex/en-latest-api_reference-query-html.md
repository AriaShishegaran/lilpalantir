Querying an Index[](#querying-an-index "Permalink to this heading")
====================================================================

This doc shows the classes that are used to query indices.

Main Query Classes[](#main-query-classes "Permalink to this heading")
----------------------------------------------------------------------

Querying an index involves a three main components:

* **Retrievers**: A retriever class retrieves a set of Nodes from an index given a query.
* **Response Synthesizer**: This class takes in a set of Nodes and synthesizes an answer given a query.
* **Query Engine**: This class takes in a query and returns a Response object. It can make use of Retrievers and Response Synthesizer modules under the hood.
* **Chat Engines**: This class enables conversation over a knowledge base. It is the stateful version of a query engine that keeps track of conversation history.

Main query classes

* [Retrievers](query/retrievers.html)
* [Response Synthesizer](query/response_synthesizer.html)
* [Query Engines](query/query_engines.html)
* [Chat Engines](query/chat_engines.html)
Additional Query Classes[](#additional-query-classes "Permalink to this heading")
----------------------------------------------------------------------------------

We also detail some additional query classes below.

* **Query Bundle**: This is the input to the query classes: retriever, response synthesizer,and query engine. It enables the user to customize the string(s)used for embedding-based query.
* **Query Transform**: This class augments a raw query string withassociated transformations to improve index querying. Can be usedwith a Retriever (see TransformRetriever) or QueryEngine.

Additional query classes

* [Query Bundle](query/query_bundle.html)
* [Query Transform](query/query_transform.html)
