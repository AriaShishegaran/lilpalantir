Installation and Setup[](#installation-and-setup "Permalink to this heading")
==============================================================================

Installation from Pip[](#installation-from-pip "Permalink to this heading")
----------------------------------------------------------------------------

Install from pip:


```
pip install llama-index
```
**NOTE:** LlamaIndex may download and store local files for various packages (NLTK, HuggingFace, …). Use the environment variable “LLAMA\_INDEX\_CACHE\_DIR” to control where these files are saved.

If you prefer to install from source, see below.

Important: OpenAI Environment Setup[](#important-openai-environment-setup "Permalink to this heading")
-------------------------------------------------------------------------------------------------------

By default, we use the OpenAI `gpt-3.5-turbo` model for text generation and `text-embedding-ada-002` for retrieval and embeddings. In order to use this, you must have an OPENAI\_API\_KEY set up as an environment variable.You can obtain an API key by logging into your OpenAI account and [and creating a new API key](https://platform.openai.com/account/api-keys).

Tip

You can also [use one of many other available LLMs](../module_guides/models/llms/usage_custom.html). You mayneed additional environment keys + tokens setup depending on the LLM provider.

Local Model Setup[](#local-model-setup "Permalink to this heading")
--------------------------------------------------------------------

If you don’t wish to use OpenAI, consider setting up a local LLM and embedding model in the service context.

A full guide to using and configuring LLMs available [here](../module_guides/models/llms.html).

A full guide to using and configuring embedding models is available [here](../module_guides/models/embeddings.html).

Installation from Source[](#installation-from-source "Permalink to this heading")
----------------------------------------------------------------------------------

Git clone this repository: `git clone https://github.com/jerryjliu/llama\_index.git`. Then do the following:

* [Install poetry](https://python-poetry.org/docs/#installation) - this will help you manage package dependencies
* `poetry shell` - this command creates a virtual environment, which keeps installed packages contained to this project
* `poetry install` - this will install the core package requirements
* (Optional) `poetry install --with dev,docs` - this will install all dependencies needed for most local development
