[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/data_connectors/DatabaseReaderDemo.ipynb)

Database Reader[](#database-reader "Permalink to this heading")
================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```

```
from \_\_future\_\_ import absolute\_import# My OpenAI Keyimport osos.environ["OPENAI\_API\_KEY"] = ""from llama\_index.readers.database import DatabaseReaderfrom llama\_index import VectorStoreIndex
```

```
# Initialize DatabaseReader object with the following parameters:db = DatabaseReader(    scheme="postgresql",  # Database Scheme    host="localhost",  # Database Host    port="5432",  # Database Port    user="postgres",  # Database User    password="FakeExamplePassword",  # Database Password    dbname="postgres",  # Database Name)
```

```
### DatabaseReader class #### db is an instance of DatabaseReader:print(type(db))# DatabaseReader available method:print(type(db.load\_data))### SQLDatabase class #### db.sql is an instance of SQLDatabase:print(type(db.sql\_database))# SQLDatabase available methods:print(type(db.sql\_database.from\_uri))print(type(db.sql\_database.get\_single\_table\_info))print(type(db.sql\_database.get\_table\_columns))print(type(db.sql\_database.get\_usable\_table\_names))print(type(db.sql\_database.insert\_into\_table))print(type(db.sql\_database.run\_sql))# SQLDatabase available properties:print(type(db.sql\_database.dialect))print(type(db.sql\_database.engine))
```

```
### Testing DatabaseReader### from SQLDatabase, SQLAlchemy engine and Database URI:# From SQLDatabase instance:print(type(db.sql\_database))db\_from\_sql\_database = DatabaseReader(sql\_database=db.sql\_database)print(type(db\_from\_sql\_database))# From SQLAlchemy engine:print(type(db.sql\_database.engine))db\_from\_engine = DatabaseReader(engine=db.sql\_database.engine)print(type(db\_from\_engine))# From Database URI:print(type(db.uri))db\_from\_uri = DatabaseReader(uri=db.uri)print(type(db\_from\_uri))
```

```
# The below SQL Query example returns a list values of each row# with concatenated text from the name and age columns# from the users table where the age is greater than or equal to 18query = f""" SELECT CONCAT(name, ' is ', age, ' years old.') AS text FROM public.users WHERE age >= 18 """
```

```
# Please refer to llama\_index.utilities.sql\_wrapper# SQLDatabase.run\_sql methodtexts = db.sql\_database.run\_sql(command=query)# Display type(texts) and texts# type(texts) must return <class 'list'>print(type(texts))# Documents must return a list of Tuple objectsprint(texts)
```

```
# Please refer to llama\_index.readers.database.DatabaseReader.load\_data# DatabaseReader.load\_data methoddocuments = db.load\_data(query=query)# Display type(documents) and documents# type(documents) must return <class 'list'>print(type(documents))# Documents must return a list of Document objectsprint(documents)
```

```
index = VectorStoreIndex.from\_documents(documents)
```
