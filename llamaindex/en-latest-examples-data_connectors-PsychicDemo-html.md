[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/data_connectors/PsychicDemo.ipynb)

Psychic Reader[](#psychic-reader "Permalink to this heading")
==============================================================

Demonstrates the Psychic data connector. Used to query data from many SaaS tools from a single LlamaIndex-compatible API.

Prerequisites[](#prerequisites "Permalink to this heading")
------------------------------------------------------------

Connections must first be established from the Psychic dashboard or React hook before documents can be loaded. Refer to https://docs.psychic.dev/ for more info.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysimport oslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from llama\_index import SummaryIndex, PsychicReaderfrom IPython.display import Markdown, display
```

```
# Get Psychic API key from https://dashboard.psychic.dev/api-keyspsychic\_key = "PSYCHIC\_API\_KEY"# Connector ID and Account ID are typically set programatically based on the application state.account\_id = "ACCOUNT\_ID"connector\_id = "notion"documents = PsychicReader(psychic\_key=psychic\_key).load\_data(    connector\_id=connector\_id, account\_id=account\_id)
```

```
# set Logging to DEBUG for more detailed outputsos.environ["OPENAI\_API\_KEY"] = "OPENAI\_API\_KEY"index = SummaryIndex.from\_documents(documents)query\_engine = index.as\_query\_engine()response = query\_engine.query("What is Psychic's privacy policy?")display(Markdown(f"<b>{response}</b>"))
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokens> [build_index_from_nodes] Total embedding token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total LLM token usage: 2383 tokens> [get_response] Total LLM token usage: 2383 tokens> [get_response] Total LLM token usage: 2383 tokens> [get_response] Total LLM token usage: 2383 tokensINFO:llama_index.token_counter.token_counter:> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens> [get_response] Total embedding token usage: 0 tokens
```
**Psychic's privacy policy explains how we access, use, store, and share Google user data when you connect your Google Drive or other Google services to our application. By using Psychic, you agree to this Privacy Policy and our Terms of Service. We use the information we collect for the following purposes: to provide you with the Psychic services, including allowing you to access, view, and query files and folders stored in your connected Google Drive; to improve our services, including analyzing usage patterns and troubleshooting issues; and to communicate with you about important updates, promotions, or news related to Psychic. We take the security of your information seriously and implement appropriate security measures to protect it. We may share your information in certain cases, such as with service providers who assist us in providing and maintaining Psychic services, as required by law, or to protect the rights, property, or safety of Psychic, our users, or the public. Psychic provides in-product privacy notifications to inform you about the ways we access, use, store, and share your Google user data. We may update this Privacy Policy from time to time, and your continued use of Psychic after any changes to this Privacy Policy constitutes your acceptance of the updated policy.**