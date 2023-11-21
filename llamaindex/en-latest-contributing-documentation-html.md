Documentation Guide[](#documentation-guide "Permalink to this heading")
========================================================================

A guide for docs contributors[](#a-guide-for-docs-contributors "Permalink to this heading")
--------------------------------------------------------------------------------------------

The `docs` directory contains the sphinx source text for LlamaIndex docs, visit<https://gpt-index.readthedocs.io/> to read the full documentation.

This guide is made for anyone who’s interested in running LlamaIndex documentation locally,making changes to it and make contributions. LlamaIndex is made by the thriving communitybehind it, and you’re always welcome to make contributions to the project and thedocumentation.

Build Docs[](#build-docs "Permalink to this heading")
------------------------------------------------------

If you haven’t already, clone the LlamaIndex Github repo to a local directory:


```
git clone https://github.com/jerryjliu/llama_index.git && cd llama_index
```
Install all dependencies required for building docs (mainly `sphinx` and its extension):

* [Install poetry](https://python-poetry.org/docs/#installation) - this will help you manage package dependencies
* `poetry shell` - this command creates a virtual environment, which keeps installed packages contained to this project
* `poetry install --with docs` - this will install all dependencies needed for building docs

Build the sphinx docs:


```
cd docsmake html
```
The docs HTML files are now generated under `docs/\_build/html` directory, you can previewit locally with the following command:


```
python -m http.server 8000 -d _build/html
```
And open your browser at <http://0.0.0.0:8000/> to view the generated docs.

### Watch Docs[](#watch-docs "Permalink to this heading")

We recommend using sphinx-autobuild during development, which provides a live-reloadingserver, that rebuilds the documentation and refreshes any open pages automatically whenchanges are saved. This enables a much shorter feedback loop which can help boostproductivity when writing documentation.

Simply run the following command from LlamaIndex project’s root directory:


```
make watch-docs
```
