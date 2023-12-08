# LilPalantir
A simple commandline tool to empower fast query of local knowledge on your machine via CLI built on top of the LlamaIndex.
# Getting Started
You can leverage the install.sh (MacOS, Linux) and install.bat (Windows) to run a full install of all the requirements for the script to work out of the box.
Remember you need to give the script execution rights by running the chmod +x install.sh on Linux and MacOs machine.
## Consuming the local knowledge
For feeding infromation to LilPalantir you always need to provide a folder in which you're data resides in. Then you need to call the loader.py 
Example:
loader.py /Desktop/knowledge-base/

The script runs to unpack and ingest all the supported file types within the folder and it might take a while based on the volume of data you feed it.
It will provide you with feedback when the ingestion is finished.


Then you can use the query.py to speak with your local knowledge base in human language using models like GPT-3.5-Turbo or GPT-4-Turbo.

Example:
query.py "give a detailed explanation of what are the applications of LSTM?"
