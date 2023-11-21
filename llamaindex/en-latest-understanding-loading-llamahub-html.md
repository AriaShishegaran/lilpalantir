LlamaHub[](#llamahub "Permalink to this heading")
==================================================

Our data connectors are offered through [LlamaHub](https://llamahub.ai/) 🦙.LlamaHub is a registry of open-source data connectors that you can easily plug into any LlamaIndex application.

![](../../_images/llamahub.png)

Usage Pattern[](#usage-pattern "Permalink to this heading")
------------------------------------------------------------

Get started with:


```
from llama\_index import download\_loaderGoogleDocsReader = download\_loader("GoogleDocsReader")loader = GoogleDocsReader()documents = loader.load\_data(document\_ids=[...])
```
Built-in connector: SimpleDirectoryReader[](#built-in-connector-simpledirectoryreader "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------

`SimpleDirectoryReader`. Can support parsing a wide range of file types including `.md`, `.pdf`, `.jpg`, `.png`, `.docx`, as well as audio and video types. It is available directly as part of LlamaIndex:


```
from llama\_index import SimpleDirectoryReaderdocuments = SimpleDirectoryReader("./data").load\_data()
```
Available connectors[](#available-connectors "Permalink to this heading")
--------------------------------------------------------------------------

Browse [LlamaHub](https://llamahub.ai/) directly to see the hundreds of connectors available, including:

* [Notion](https://developers.notion.com/) (`NotionPageReader`)
* [Google Docs](https://developers.google.com/docs/api) (`GoogleDocsReader`)
* [Slack](https://api.slack.com/) (`SlackReader`)
* [Discord](https://discord.com/developers/docs/intro) (`DiscordReader`)
* [Apify Actors](https://llamahub.ai/l/apify-actor) (`ApifyActor`). Can crawl the web, scrape webpages, extract text content, download files including `.pdf`, `.jpg`, `.png`, `.docx`, etc.
