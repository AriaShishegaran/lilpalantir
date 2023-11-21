Privacy and Security[](#privacy-and-security "Permalink to this heading")
==========================================================================

By default, LLamaIndex sends your data to OpenAI for generating embeddings and natural language responses. However, it is important to note that this can be configured according to your preferences. LLamaIndex provides the flexibility to use your own embedding model or run a large language model locally if desired.

Data Privacy[](#data-privacy "Permalink to this heading")
----------------------------------------------------------

Regarding data privacy, when using LLamaIndex with OpenAI, the privacy details and handling of your data are subject to OpenAI’s policies. And each custom service other than OpenAI have their own policies as well.

Vector stores[](#vector-stores "Permalink to this heading")
------------------------------------------------------------

LLamaIndex offers modules to connect with other vector stores within indexes to store embeddings. It is worth noting that each vector store has its own privacy policies and practices, and LLamaIndex does not assume responsibility for how they handle or use your data. Also by default LLamaIndex have a default option to store your embeddings locally.

