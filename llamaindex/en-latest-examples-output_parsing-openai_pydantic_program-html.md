[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/output_parsing/openai_pydantic_program.ipynb)

OpenAI Pydantic Program[](#openai-pydantic-program "Permalink to this heading")
================================================================================

This guide shows you how to generate structured data with [new OpenAI API](https://openai.com/blog/function-calling-and-other-api-updates) via LlamaIndex. The user just needs to specify a Pydantic object.

We demonstrate two settings:

* Extraction into an `Album` object (which can contain a list of Song objects)
* Extraction into a `DirectoryTree` object (which can contain recursive Node objects)

Extraction into `Album`[](#extraction-into-album "Permalink to this heading")
------------------------------------------------------------------------------

This is a simple example of parsing an output into an `Album` schema, which can contain multiple songs.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from pydantic import BaseModelfrom typing import Listfrom llama\_index.program import OpenAIPydanticProgram
```
Define output schema


```
class Song(BaseModel): """Data model for a song."""    title: str    length\_seconds: intclass Album(BaseModel): """Data model for an album."""    name: str    artist: str    songs: List[Song]
```
Define openai pydantic program


```
prompt\_template\_str = """\Generate an example album, with an artist and a list of songs. \Using the movie {movie\_name} as inspiration.\"""program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    prompt\_template\_str=prompt\_template\_str,    verbose=True,)
```
Run program to get structured output.


```
output = program(movie\_name="The Shining")
```

```
Function call: Album with args: {  "name": "The Shining",  "artist": "Various Artists",  "songs": [    {      "title": "Main Title",      "length_seconds": 180    },    {      "title": "Opening Credits",      "length_seconds": 120    },    {      "title": "The Overlook Hotel",      "length_seconds": 240    },    {      "title": "Redrum",      "length_seconds": 150    },    {      "title": "Here's Johnny!",      "length_seconds": 200    }  ]}
```
The output is a valid Pydantic object that we can then use to call functions/APIs.


```
output
```

```
Album(name='The Shining', artist='Various Artists', songs=[Song(title='Main Title', length_seconds=180), Song(title='Opening Credits', length_seconds=120), Song(title='The Overlook Hotel', length_seconds=240), Song(title='Redrum', length_seconds=150), Song(title="Here's Johnny!", length_seconds=200)])
```
Extracting List of `Album` (with Parallel Function Calling)[](#extracting-list-of-album-with-parallel-function-calling "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------

With the latest [parallel function calling](https://platform.openai.com/docs/guides/function-calling/parallel-function-calling) feature from OpenAI, we can simultaneously extract multiple structured data from a single prompt!

To do this, we need to:

1. pick one of the latest models (e.g. `gpt-3.5-turbo-1106`), and
2. set `allow\_multiple` to True in our `OpenAIPydanticProgram` (if not, it will only return the first object, and raise a warning).


```
from llama\_index.llms import OpenAIprompt\_template\_str = """\Generate 4 albums about spring, summer, fall, and winter."""program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    llm=OpenAI(model="gpt-3.5-turbo-1106"),    prompt\_template\_str=prompt\_template\_str,    allow\_multiple=True,    verbose=True,)
```

```
output = program()
```

```
Function call: Album with args: {"name": "Spring", "artist": "Various Artists", "songs": [{"title": "Blooming Flowers", "length_seconds": 180}, {"title": "Sunshine Days", "length_seconds": 240}, {"title": "Rainy Afternoons", "length_seconds": 210}]}Function call: Album with args: {"name": "Summer", "artist": "Beach Boys", "songs": [{"title": "Beach Party", "length_seconds": 200}, {"title": "Surfing USA", "length_seconds": 220}, {"title": "Summer Love", "length_seconds": 180}]}Function call: Album with args: {"name": "Fall", "artist": "Taylor Swift", "songs": [{"title": "Autumn Leaves", "length_seconds": 190}, {"title": "Sweater Weather", "length_seconds": 210}, {"title": "Pumpkin Spice", "length_seconds": 220}]}Function call: Album with args: {"name": "Winter", "artist": "Michael Bubl\u00e9", "songs": [{"title": "Let It Snow", "length_seconds": 190}, {"title": "Winter Wonderland", "length_seconds": 200}, {"title": "Frosty the Snowman", "length_seconds": 180}]}
```
The output is a list of valid Pydantic object.


```
output
```

```
[Album(name='Spring', artist='Various Artists', songs=[Song(title='Blooming Flowers', length_seconds=180), Song(title='Sunshine Days', length_seconds=240), Song(title='Rainy Afternoons', length_seconds=210)]), Album(name='Summer', artist='Beach Boys', songs=[Song(title='Beach Party', length_seconds=200), Song(title='Surfing USA', length_seconds=220), Song(title='Summer Love', length_seconds=180)]), Album(name='Fall', artist='Taylor Swift', songs=[Song(title='Autumn Leaves', length_seconds=190), Song(title='Sweater Weather', length_seconds=210), Song(title='Pumpkin Spice', length_seconds=220)]), Album(name='Winter', artist='Michael Bublé', songs=[Song(title='Let It Snow', length_seconds=190), Song(title='Winter Wonderland', length_seconds=200), Song(title='Frosty the Snowman', length_seconds=180)])]
```
Extraction into `Album` (Streaming)[](#extraction-into-album-streaming "Permalink to this heading")
----------------------------------------------------------------------------------------------------

We also support streaming a list of objects through our `stream\_list` function.

Full credits to this idea go to `openai\_function\_call` repo: https://github.com/jxnl/openai\_function\_call/tree/main/examples/streaming\_multitask


```
prompt\_template\_str = "{input\_str}"program = OpenAIPydanticProgram.from\_defaults(    output\_cls=Album,    prompt\_template\_str=prompt\_template\_str,    verbose=False,)output = program.stream\_list(input\_str="make up 5 random albums")for obj in output:    print(obj.json(indent=2))
```

```
{  "name": "The Journey",  "artist": "Unknown",  "songs": [    {      "title": "Lost in the Woods",      "length_seconds": 240    },    {      "title": "Endless Horizon",      "length_seconds": 300    },    {      "title": "Mystic Dreams",      "length_seconds": 180    }  ]}{  "name": "Electric Pulse",  "artist": "Synthwave Masters",  "songs": [    {      "title": "Neon Nights",      "length_seconds": 270    },    {      "title": "Digital Dreams",      "length_seconds": 320    },    {      "title": "Cyber City",      "length_seconds": 240    }  ]}{  "name": "Soulful Serenade",  "artist": "Smooth Jazz Ensemble",  "songs": [    {      "title": "Midnight Groove",      "length_seconds": 210    },    {      "title": "Saxophone Serenade",      "length_seconds": 180    },    {      "title": "Chill Vibes",      "length_seconds": 240    }  ]}{  "name": "Rock Revolution",  "artist": "The Thunderbolts",  "songs": [    {      "title": "High Voltage",      "length_seconds": 240    },    {      "title": "Guitar Shredder",      "length_seconds": 300    },    {      "title": "Rock Anthem",      "length_seconds": 270    }  ]}{  "name": "Pop Sensation",  "artist": "The Starlets",  "songs": [    {      "title": "Catchy Melody",      "length_seconds": 210    },    {      "title": "Dancefloor Diva",      "length_seconds": 240    },    {      "title": "Pop Princess",      "length_seconds": 180    }  ]}
```
Extraction into `DirectoryTree` object[](#extraction-into-directorytree-object "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

This is directly inspired by jxnl’s awesome repo here: https://github.com/jxnl/openai\_function\_call.

That repository shows how you can use OpenAI’s function API to parse recursive Pydantic objects. The main requirement is that you want to “wrap” a recursive Pydantic object with a non-recursive one.

Here we show an example in a “directory” setting, where a `DirectoryTree` object wraps recursive `Node` objects, to parse a file structure.


```
# NOTE: defining recursive objects in a notebook causes errorsfrom directory import DirectoryTree, Node
```

```
DirectoryTree.schema()
```

```
{'title': 'DirectoryTree', 'description': 'Container class representing a directory tree.\n\nArgs:\n    root (Node): The root node of the tree.', 'type': 'object', 'properties': {'root': {'title': 'Root',   'description': 'Root folder of the directory tree',   'allOf': [{'$ref': '#/definitions/Node'}]}}, 'required': ['root'], 'definitions': {'NodeType': {'title': 'NodeType',   'description': 'Enumeration representing the types of nodes in a filesystem.',   'enum': ['file', 'folder'],   'type': 'string'},  'Node': {'title': 'Node',   'description': 'Class representing a single node in a filesystem. Can be either a file or a folder.\nNote that a file cannot have children, but a folder can.\n\nArgs:\n    name (str): The name of the node.\n    children (List[Node]): The list of child nodes (if any).\n    node_type (NodeType): The type of the node, either a file or a folder.',   'type': 'object',   'properties': {'name': {'title': 'Name',     'description': 'Name of the folder',     'type': 'string'},    'children': {'title': 'Children',     'description': 'List of children nodes, only applicable for folders, files cannot have children',     'type': 'array',     'items': {'$ref': '#/definitions/Node'}},    'node_type': {'description': 'Either a file or folder, use the name to determine which it could be',     'default': 'file',     'allOf': [{'$ref': '#/definitions/NodeType'}]}},   'required': ['name']}}}
```

```
program = OpenAIPydanticProgram.from\_defaults(    output\_cls=DirectoryTree,    prompt\_template\_str="{input\_str}",    verbose=True,)
```

```
input\_str = """root├── folder1│ ├── file1.txt│ └── file2.txt└── folder2 ├── file3.txt └── subfolder1 └── file4.txt"""output = program(input\_str=input\_str)
```

```
Function call: DirectoryTree with args: {  "root": {    "name": "root",    "children": [      {        "name": "folder1",        "children": [          {            "name": "file1.txt",            "children": [],            "node_type": "file"          },          {            "name": "file2.txt",            "children": [],            "node_type": "file"          }        ],        "node_type": "folder"      },      {        "name": "folder2",        "children": [          {            "name": "file3.txt",            "children": [],            "node_type": "file"          },          {            "name": "subfolder1",            "children": [              {                "name": "file4.txt",                "children": [],                "node_type": "file"              }            ],            "node_type": "folder"          }        ],        "node_type": "folder"      }    ],    "node_type": "folder"  }}
```
The output is a full DirectoryTree structure with recursive `Node` objects.


```
output
```

```
DirectoryTree(root=Node(name='root', children=[Node(name='folder1', children=[Node(name='file1.txt', children=[], node_type=<NodeType.FILE: 'file'>), Node(name='file2.txt', children=[], node_type=<NodeType.FILE: 'file'>)], node_type=<NodeType.FOLDER: 'folder'>), Node(name='folder2', children=[Node(name='file3.txt', children=[], node_type=<NodeType.FILE: 'file'>), Node(name='subfolder1', children=[Node(name='file4.txt', children=[], node_type=<NodeType.FILE: 'file'>)], node_type=<NodeType.FOLDER: 'folder'>)], node_type=<NodeType.FOLDER: 'folder'>)], node_type=<NodeType.FOLDER: 'folder'>))
```
