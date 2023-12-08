
# LilPalantir
A simple command-line tool to empower fast querying of local knowledge on your machine via CLI, built on top of the LlamaIndex.

## Getting Started
To get started, you can leverage the `install.sh` script for MacOS and Linux, or `install.bat` for Windows, to run a full install of all the requirements for the script to work out of the box. Remember to give the script execution rights by running `chmod +x install.sh` on Linux and MacOS machines.

### Installation
```bash
# For MacOS and Linux
chmod +x install.sh
./install.sh

# For Windows
install.bat
```

## Consuming the Local Knowledge
To feed information to LilPalantir, you need to provide a folder where your data resides. Use the `loader.py` script to process this data.

### Loading Data
```bash
loader.py /path/to/your/data/folder
```
The script will unpack and ingest all supported file types within the folder. The duration of this process depends on the volume of data. You will receive feedback when the ingestion is complete.

## Querying the Knowledge Base
Once the data is ingested, you can query your local knowledge base using natural language with models like GPT-3.5-Turbo or GPT-4-Turbo. Use the `query.py` script for this purpose.

### Making Queries
```bash
query.py "your query here"
```
For example:
```bash
query.py "give a detailed explanation of what are the applications of LSTM?"
```
