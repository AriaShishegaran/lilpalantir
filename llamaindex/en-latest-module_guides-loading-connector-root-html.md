Data Connectors (LlamaHub)[](#data-connectors-llamahub "Permalink to this heading")
====================================================================================

Concept[](#concept "Permalink to this heading")
------------------------------------------------

A data connector (aka `Reader`) ingest data from different data sources and data formats into a simple `Document` representation (text and simple metadata).

Tip

Once you’ve ingested your data, you can build an [Index](#/modules/indexing/indexing.md) on top, ask questions using a [Query Engine](../../deploying/query_engine/root.html), and have a conversation using a [Chat Engine](../../deploying/chat_engines/root.html).

LlamaHub[](#llamahub "Permalink to this heading")
--------------------------------------------------

Our data connectors are offered through [LlamaHub](https://llamahub.ai/) 🦙.LlamaHub is an open-source repository containing data loaders that you can easily plug and play into any LlamaIndex application.

![](../../../_images/llamahub.png)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
from llama\_index import download\_loaderGoogleDocsReader = download\_loader("GoogleDocsReader")loader = GoogleDocsReader()documents = loader.load\_data(document\_ids=[...])
```
* [Usage Pattern](usage_pattern.html)
	+ [Get Started](usage_pattern.html#get-started)
Modules[](#modules "Permalink to this heading")
------------------------------------------------

Some sample data connectors:

* local file directory (`SimpleDirectoryReader`). Can support parsing a wide range of file types: `.pdf`, `.jpg`, `.png`, `.docx`, etc.
* [Notion](https://developers.notion.com/) (`NotionPageReader`)
* [Google Docs](https://developers.google.com/docs/api) (`GoogleDocsReader`)
* [Slack](https://api.slack.com/) (`SlackReader`)
* [Discord](https://discord.com/developers/docs/intro) (`DiscordReader`)
* [Apify Actors](https://llamahub.ai/l/apify-actor) (`ApifyActor`). Can crawl the web, scrape webpages, extract text content, download files including `.pdf`, `.jpg`, `.png`, `.docx`, etc.

See below for detailed guides.

* [Module Guides](modules.html)
	+ [Simple Directory Reader](../../../examples/data_connectors/simple_directory_reader.html)
	+ [Psychic Reader](../../../examples/data_connectors/PsychicDemo.html)
	+ [DeepLake Reader](../../../examples/data_connectors/DeepLakeReader.html)
	+ [Qdrant Reader](../../../examples/data_connectors/QdrantDemo.html)
	+ [Discord Reader](../../../examples/data_connectors/DiscordDemo.html)
	+ [MongoDB Reader](../../../examples/data_connectors/MongoDemo.html)
	+ [Chroma Reader](../../../examples/data_connectors/ChromaDemo.html)
	+ [MyScale Reader](../../../examples/data_connectors/MyScaleReaderDemo.html)
	+ [Faiss Reader](../../../examples/data_connectors/FaissDemo.html)
	+ [Obsidian Reader](../../../examples/data_connectors/ObsidianReaderDemo.html)
	+ [Slack Reader](../../../examples/data_connectors/SlackDemo.html)
	+ [Web Page Reader](../../../examples/data_connectors/WebPageDemo.html)
	+ [Pinecone Reader](../../../examples/data_connectors/PineconeDemo.html)
	+ [Mbox Reader](../../../examples/data_connectors/MboxReaderDemo.html)
	+ [MilvusReader](../../../examples/data_connectors/MilvusReaderDemo.html)
	+ [Notion Reader](../../../examples/data_connectors/NotionDemo.html)
	+ [Github Repo Reader](../../../examples/data_connectors/GithubRepositoryReaderDemo.html)
	+ [Google Docs Reader](../../../examples/data_connectors/GoogleDocsDemo.html)
	+ [Database Reader](../../../examples/data_connectors/DatabaseReaderDemo.html)
	+ [Twitter Reader](../../../examples/data_connectors/TwitterDemo.html)
	+ [Weaviate Reader](../../../examples/data_connectors/WeaviateDemo.html)
	+ [Make Reader](../../../examples/data_connectors/MakeDemo.html)
	+ [Deplot Reader Demo](../../../examples/data_connectors/deplot/DeplotReader.html)
