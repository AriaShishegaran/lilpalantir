[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/vector_stores/BagelAutoRetriever.ipynb)

Bagel Vector Store[](#bagel-vector-store "Permalink to this heading")
======================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
# set up OpenAIimport osimport getpassos.environ["OPENAI\_API\_KEY"] = getpass.getpass("OpenAI API Key:")import openaiopenai.api\_key = os.environ["OPENAI\_API\_KEY"]
```

```
import bagelfrom bagel import Settings
```

```
server\_settings = Settings(    bagel\_api\_impl="rest", bagel\_server\_host="api.bageldb.ai")client = bagel.Client(server\_settings)collection = client.get\_or\_create\_cluster("testing\_embeddings")
```

```
from llama\_index import VectorStoreIndex, StorageContextfrom llama\_index.vector\_stores import BagelVectorStore
```

```
from llama\_index.schema import TextNodenodes = [    TextNode(        text=(            "Michael Jordan is a retired professional basketball player,"            " widely regarded as one of the greatest basketball players of all"            " time."        ),        metadata={            "category": "Sports",            "country": "United States",        },    ),    TextNode(        text=(            "Angelina Jolie is an American actress, filmmaker, and"            " humanitarian. She has received numerous awards for her acting"            " and is known for her philanthropic work."        ),        metadata={            "category": "Entertainment",            "country": "United States",        },    ),    TextNode(        text=(            "Elon Musk is a business magnate, industrial designer, and"            " engineer. He is the founder, CEO, and lead designer of SpaceX,"            " Tesla, Inc., Neuralink, and The Boring Company."        ),        metadata={            "category": "Business",            "country": "United States",        },    ),    TextNode(        text=(            "Rihanna is a Barbadian singer, actress, and businesswoman. She"            " has achieved significant success in the music industry and is"            " known for her versatile musical style."        ),        metadata={            "category": "Music",            "country": "Barbados",        },    ),    TextNode(        text=(            "Cristiano Ronaldo is a Portuguese professional footballer who is"            " considered one of the greatest football players of all time. He"            " has won numerous awards and set multiple records during his"            " career."        ),        metadata={            "category": "Sports",            "country": "Portugal",        },    ),]
```

```
vector\_store = BagelVectorStore(collection=collection)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)
```

```
index = VectorStoreIndex(nodes, storage\_context=storage\_context)
```

```
from llama\_index.indices.vector\_store.retrievers import (    VectorIndexAutoRetriever,)from llama\_index.vector\_stores.types import MetadataInfo, VectorStoreInfovector\_store\_info = VectorStoreInfo(    content\_info="brief biography of celebrities",    metadata\_info=[        MetadataInfo(            name="category",            type="str",            description=(                "Category of the celebrity, one of [Sports, Entertainment,"                " Business, Music]"            ),        ),        MetadataInfo(            name="country",            type="str",            description=(                "Country of the celebrity, one of [United States, Barbados,"                " Portugal]"            ),        ),    ],)retriever = VectorIndexAutoRetriever(    index, vector\_store\_info=vector\_store\_info)
```

```
retriever.retrieve("Tell me about two celebrities from United States")
```
