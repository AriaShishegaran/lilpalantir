[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/data_connectors/simple_directory_reader.ipynb)

Simple Directory Reader[](#simple-directory-reader "Permalink to this heading")
================================================================================

The `SimpleDirectoryReader` is the most commonly used data connector that *just works*.  
Simply pass in a input directory or a list of files.  
It will select the best file reader based on the file extensions.

Get Started[](#get-started "Permalink to this heading")
--------------------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index import SimpleDirectoryReader
```
Download Data


```
!mkdir -p 'data/paul\_graham/'!wget 'https://raw.githubusercontent.com/run-llama/llama\_index/main/docs/examples/data/paul\_graham/paul\_graham\_essay.txt' -O 'data/paul\_graham/paul\_graham\_essay.txt'
```
Load specific files


```
reader = SimpleDirectoryReader(    input\_files=["./data/paul\_graham/paul\_graham\_essay.txt"])
```

```
docs = reader.load\_data()print(f"Loaded {len(docs)} docs")
```

```
Loaded 1 docs
```
Load all (top-level) files from directory


```
reader = SimpleDirectoryReader(input\_dir="../../end\_to\_end\_tutorials/")
```

```
docs = reader.load\_data()print(f"Loaded {len(docs)} docs")
```

```
Loaded 72 docs
```
Load all (recursive) files from directory


```
# only load markdown filesrequired\_exts = [".md"]reader = SimpleDirectoryReader(    input\_dir="../../end\_to\_end\_tutorials",    required\_exts=required\_exts,    recursive=True,)
```

```
docs = reader.load\_data()print(f"Loaded {len(docs)} docs")
```

```
Loaded 174 docs
```
Full Configuration[](#full-configuration "Permalink to this heading")
----------------------------------------------------------------------

This is the full list of arguments that can be passed to the `SimpleDirectoryReader`:


```
class SimpleDirectoryReader(BaseReader): """Simple directory reader. Load files from file directory.  Automatically select the best file reader given file extensions. Args: input\_dir (str): Path to the directory. input\_files (List): List of file paths to read (Optional; overrides input\_dir, exclude) exclude (List): glob of python file paths to exclude (Optional) exclude\_hidden (bool): Whether to exclude hidden files (dotfiles). encoding (str): Encoding of the files. Default is utf-8. errors (str): how encoding and decoding errors are to be handled, see https://docs.python.org/3/library/functions.html#open recursive (bool): Whether to recursively search in subdirectories. False by default. filename\_as\_id (bool): Whether to use the filename as the document id. False by default. required\_exts (Optional[List[str]]): List of required extensions. Default is None. file\_extractor (Optional[Dict[str, BaseReader]]): A mapping of file extension to a BaseReader class that specifies how to convert that file to text. If not specified, use default from DEFAULT\_FILE\_READER\_CLS. num\_files\_limit (Optional[int]): Maximum number of files to read. Default is None. file\_metadata (Optional[Callable[str, Dict]]): A function that takes in a filename and returns a Dict of metadata for the Document. Default is None."""
```
