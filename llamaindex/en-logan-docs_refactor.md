Welcome to LlamaIndex 🦙 ![](#welcome-to-llamaindex "Permalink to this heading")
================================================================================

LlamaIndex is a data framework for [LLM](https://en.wikipedia.org/wiki/Large_language_model)-based applications to ingest, structure, and access private or domain-specific data. It’s available in Python (these docs) and [Typescript](https://ts.llamaindex.ai/).

🚀 Why LlamaIndex?[](#why-llamaindex "Permalink to this heading")
-----------------------------------------------------------------

LLMs offer a natural language interface between humans and data. Widely available models come pre-trained on huge amounts of publicly available data like Wikipedia, mailing lists, textbooks, source code and more.

However, while LLMs are trained on a great deal of data, they are not trained on **your** data, which may private or specific to the problem you’re trying to solve. It’s behind APIs, in SQL databases, or trapped in PDFs and slide decks.

LlamaIndex solves this problem by connecting to these data sources and adding your data to the data LLMs already have. This is often called Retrieval-Augmented Generation (RAG). RAG enables you to use LLMs to query your data, transform it, and generate new insights. You can ask questions about your data, create chatbots, build semi-autonomous agents, and more. To learn more, check out our Use Cases on the left.

🦙 How can LlamaIndex help?[](#how-can-llamaindex-help "Permalink to this heading")
-----------------------------------------------------------------------------------

LlamaIndex provides the following tools:

* **Data connectors** ingest your existing data from their native source and format. These could be APIs, PDFs, SQL, and (much) more.
* **Data indexes** structure your data in intermediate representations that are easy and performant for LLMs to consume.
* **Engines** provide natural language access to your data. For example:- Query engines are powerful retrieval interfaces for knowledge-augmented output.- Chat engines are conversational interfaces for multi-message, “back and forth” interactions with your data.
* **Data agents** are LLM-powered knowledge workers augmented by tools, from simple helper functions to API integrations and more.
* **Application integrations** tie LlamaIndex back into the rest of your ecosystem. This could be LangChain, Flask, Docker, ChatGPT, or… anything else!
👨‍👩‍👧‍👦 Who is LlamaIndex for?[](#who-is-llamaindex-for "Permalink to this heading")
-------------------------------------------------------------------------------------

LlamaIndex provides tools for beginners, advanced users, and everyone in between.

Our high-level API allows beginner users to use LlamaIndex to ingest and query their data in 5 lines of code.

For more complex applications, our lower-level APIs allow advanced users to customize and extend any module—data connectors, indices, retrievers, query engines, reranking modules—to fit their needs.

Getting Started[](#getting-started "Permalink to this heading")
----------------------------------------------------------------

To install the library:

`pip install llama-index`

We recommend starting at [how to read these docs](/getting_started/reading.html), which will point you to the right place based on your experience level.

🗺️ Ecosystem[](#ecosystem "Permalink to this heading")
-------------------------------------------------------

To download or contribute, find LlamaIndex on:

* Github: <https://github.com/jerryjliu/llama_index>
* PyPi:


	+ LlamaIndex: <https://pypi.org/project/llama-index/>.
	+ GPT Index (duplicate): <https://pypi.org/project/gpt-index/>.
* NPM (Typescript/Javascript):
	+ Github: <https://github.com/run-llama/LlamaIndexTS>
	+ Docs: <https://ts.llamaindex.ai/>
	+ LlamaIndex.TS: <https://www.npmjs.com/package/llamaindex>

### Community[](#community "Permalink to this heading")

Need help? Have a feature suggestion? Join the LlamaIndex community:

* Twitter: <https://twitter.com/llama_index>
* Discord <https://discord.gg/dGcwcsnxhU>
### Associated projects[](#associated-projects "Permalink to this heading")

* 🏡 LlamaHub: <https://llamahub.ai> | A large (and growing!) collection of custom data connectors
* 🧪 LlamaLab: <https://github.com/run-llama/llama-lab> | Ambitious projects built on top of LlamaIndex

