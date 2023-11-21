A Guide to Building a Full-Stack Web App with LLamaIndex[](#a-guide-to-building-a-full-stack-web-app-with-llamaindex "Permalink to this heading")
==================================================================================================================================================

LlamaIndex is a python library, which means that integrating it with a full-stack web application will be a little different than what you might be used to.

This guide seeks to walk through the steps needed to create a basic API service written in python, and how this interacts with a TypeScript+React frontend.

All code examples here are available from the [llama\_index\_starter\_pack](https://github.com/logan-markewich/llama_index_starter_pack/tree/main/flask_react) in the flask\_react folder.

The main technologies used in this guide are as follows:

* python3.11
* llama\_index
* flask
* typescript
* react

Flask Backend[](#flask-backend "Permalink to this heading")
------------------------------------------------------------

For this guide, our backend will use a [Flask](https://flask.palletsprojects.com/en/2.2.x/) API server to communicate with our frontend code. If you prefer, you can also easily translate this to a [FastAPI](https://fastapi.tiangolo.com/) server, or any other python server library of your choice.

Setting up a server using Flask is easy. You import the package, create the app object, and then create your endpoints. Let’s create a basic skeleton for the server first:


```
from flask import Flaskapp = Flask(\_\_name\_\_)@app.route("/")def home():    return "Hello World!"if \_\_name\_\_ == "\_\_main\_\_":    app.run(host="0.0.0.0", port=5601)
```
*flask\_demo.py*

If you run this file (`python flask\_demo.py`), it will launch a server on port 5601. If you visit `http://localhost:5601/`, you will see the “Hello World!” text rendered in your browser. Nice!

The next step is deciding what functions we want to include in our server, and to start using LlamaIndex.

To keep things simple, the most basic operation we can provide is querying an existing index. Using the [paul graham essay](https://github.com/jerryjliu/llama_index/blob/main/examples/paul_graham_essay/data/paul_graham_essay.txt) from LlamaIndex, create a documents folder and download+place the essay text file inside of it.

### Basic Flask - Handling User Index Queries[](#basic-flask-handling-user-index-queries "Permalink to this heading")

Now, let’s write some code to initialize our index:


```
import osfrom llama\_index import SimpleDirectoryReader, VectorStoreIndex, StorageContext# NOTE: for local testing only, do NOT deploy with your key hardcodedos.environ["OPENAI\_API\_KEY"] = "your key here"index = Nonedef initialize\_index():    global index    storage\_context = StorageContext.from\_defaults()    if os.path.exists(index\_dir):        index = load\_index\_from\_storage(storage\_context)    else:        documents = SimpleDirectoryReader("./documents").load\_data()        index = VectorStoreIndex.from\_documents(            documents, storage\_context=storage\_context        )        storage\_context.persist(index\_dir)
```
This function will initialize our index. If we call this just before starting the flask server in the `main` function, then our index will be ready for user queries!

Our query endpoint will accept `GET` requests with the query text as a parameter. Here’s what the full endpoint function will look like:


```
from flask import request@app.route("/query", methods=["GET"])def query\_index():    global index    query\_text = request.args.get("text", None)    if query\_text is None:        return (            "No text found, please include a ?text=blah parameter in the URL",            400,        )    query\_engine = index.as\_query\_engine()    response = query\_engine.query(query\_text)    return str(response), 200
```
Now, we’ve introduced a few new concepts to our server:

* a new `/query` endpoint, defined by the function decorator
* a new import from flask, `request`, which is used to get parameters from the request
* if the `text` parameter is missing, then we return an error message and an appropriate HTML response code
* otherwise, we query the index, and return the response as a string

A full query example that you can test in your browser might look something like this: `http://localhost:5601/query?text=what did the author do growing up` (once you press enter, the browser will convert the spaces into “%20” characters).

Things are looking pretty good! We now have a functional API. Using your own documents, you can easily provide an interface for any application to call the flask API and get answers to queries.

### Advanced Flask - Handling User Document Uploads[](#advanced-flask-handling-user-document-uploads "Permalink to this heading")

Things are looking pretty cool, but how can we take this a step further? What if we want to allow users to build their own indexes by uploading their own documents? Have no fear, Flask can handle it all :muscle:.

To let users upload documents, we have to take some extra precautions. Instead of querying an existing index, the index will become **mutable**. If you have many users adding to the same index, we need to think about how to handle concurrency. Our Flask server is threaded, which means multiple users can ping the server with requests which will be handled at the same time.

One option might be to create an index for each user or group, and store and fetch things from S3. But for this example, we will assume there is one locally stored index that users are interacting with.

To handle concurrent uploads and ensure sequential inserts into the index, we can use the `BaseManager` python package to provide sequential access to the index using a separate server and locks. This sounds scary, but it’s not so bad! We will just move all our index operations (initializing, querying, inserting) into the `BaseManager` “index\_server”, which will be called from our Flask server.

Here’s a basic example of what our `index\_server.py` will look like after we’ve moved our code:


```
import osfrom multiprocessing import Lockfrom multiprocessing.managers import BaseManagerfrom llama\_index import SimpleDirectoryReader, VectorStoreIndex, Document# NOTE: for local testing only, do NOT deploy with your key hardcodedos.environ["OPENAI\_API\_KEY"] = "your key here"index = Nonelock = Lock()def initialize\_index():    global index    with lock:        # same as before ...        passdef query\_index(query\_text):    global index    query\_engine = index.as\_query\_engine()    response = query\_engine.query(query\_text)    return str(response)if \_\_name\_\_ == "\_\_main\_\_":    # init the global index    print("initializing index...")    initialize\_index()    # setup server    # NOTE: you might want to handle the password in a less hardcoded way    manager = BaseManager(("", 5602), b"password")    manager.register("query\_index", query\_index)    server = manager.get\_server()    print("starting server...")    server.serve\_forever()
```
*index\_server.py*

So, we’ve moved our functions, introduced the `Lock` object which ensures sequential access to the global index, registered our single function in the server, and started the server on port 5602 with the password `password`.

Then, we can adjust our flask code as follows:


```
from multiprocessing.managers import BaseManagerfrom flask import Flask, request# initialize manager connection# NOTE: you might want to handle the password in a less hardcoded waymanager = BaseManager(("", 5602), b"password")manager.register("query\_index")manager.connect()@app.route("/query", methods=["GET"])def query\_index():    global index    query\_text = request.args.get("text", None)    if query\_text is None:        return (            "No text found, please include a ?text=blah parameter in the URL",            400,        )    response = manager.query\_index(query\_text).\_getvalue()    return str(response), 200@app.route("/")def home():    return "Hello World!"if \_\_name\_\_ == "\_\_main\_\_":    app.run(host="0.0.0.0", port=5601)
```
*flask\_demo.py*

The two main changes are connecting to our existing `BaseManager` server and registering the functions, as well as calling the function through the manager in the `/query` endpoint.

One special thing to note is that `BaseManager` servers don’t return objects quite as we expect. To resolve the return value into it’s original object, we call the `\_getvalue()` function.

If we allow users to upload their own documents, we should probably remove the Paul Graham essay from the documents folder, so let’s do that first. Then, let’s add an endpoint to upload files! First, let’s define our Flask endpoint function:


```
...manager.register("insert\_into\_index")...@app.route("/uploadFile", methods=["POST"])def upload\_file():    global manager    if "file" not in request.files:        return "Please send a POST request with a file", 400    filepath = None    try:        uploaded\_file = request.files["file"]        filename = secure\_filename(uploaded\_file.filename)        filepath = os.path.join("documents", os.path.basename(filename))        uploaded\_file.save(filepath)        if request.form.get("filename\_as\_doc\_id", None) is not None:            manager.insert\_into\_index(filepath, doc\_id=filename)        else:            manager.insert\_into\_index(filepath)    except Exception as e:        # cleanup temp file        if filepath is not None and os.path.exists(filepath):            os.remove(filepath)        return "Error: {}".format(str(e)), 500    # cleanup temp file    if filepath is not None and os.path.exists(filepath):        os.remove(filepath)    return "File inserted!", 200
```
Not too bad! You will notice that we write the file to disk. We could skip this if we only accept basic file formats like `txt` files, but written to disk we can take advantage of LlamaIndex’s `SimpleDirectoryReader` to take care of a bunch of more complex file formats. Optionally, we also use a second `POST` argument to either use the filename as a doc\_id or let LlamaIndex generate one for us. This will make more sense once we implement the frontend.

With these more complicated requests, I also suggest using a tool like [Postman](https://www.postman.com/downloads/?utm_source=postman-home). Examples of using postman to test our endpoints are in the [repository for this project](https://github.com/logan-markewich/llama_index_starter_pack/tree/main/flask_react/postman_examples).

Lastly, you’ll notice we added a new function to the manager. Let’s implement that inside `index\_server.py`:


```
def insert\_into\_index(doc\_text, doc\_id=None):    global index    document = SimpleDirectoryReader(input\_files=[doc\_text]).load\_data()[0]    if doc\_id is not None:        document.doc\_id = doc\_id    with lock:        index.insert(document)        index.storage\_context.persist()...manager.register("insert\_into\_index", insert\_into\_index)...
```
Easy! If we launch both the `index\_server.py` and then the `flask\_demo.py` python files, we have a Flask API server that can handle multiple requests to insert documents into a vector index and respond to user queries!

To support some functionality in the frontend, I’ve adjusted what some responses look like from the Flask API, as well as added some functionality to keep track of which documents are stored in the index (LlamaIndex doesn’t currently support this in a user-friendly way, but we can augment it ourselves!). Lastly, I had to add CORS support to the server using the `Flask-cors` python package.

Check out the complete `flask\_demo.py` and `index\_server.py` scripts in the [repository](https://github.com/logan-markewich/llama_index_starter_pack/tree/main/flask_react) for the final minor changes, the`requirements.txt` file, and a sample `Dockerfile` to help with deployment.

React Frontend[](#react-frontend "Permalink to this heading")
--------------------------------------------------------------

Generally, React and Typescript are one of the most popular libraries and languages for writing webapps today. This guide will assume you are familiar with how these tools work, because otherwise this guide will triple in length :smile:.

In the [repository](https://github.com/logan-markewich/llama_index_starter_pack/tree/main/flask_react), the frontend code is organized inside of the `react\_frontend` folder.

The most relevant part of the frontend will be the `src/apis` folder. This is where we make calls to the Flask server, supporting the following queries:

* `/query` – make a query to the existing index
* `/uploadFile` – upload a file to the flask server for insertion into the index
* `/getDocuments` – list the current document titles and a portion of their texts

Using these three queries, we can build a robust frontend that allows users to upload and keep track of their files, query the index, and view the query response and information about which text nodes were used to form the response.

### fetchDocuments.tsx[](#fetchdocuments-tsx "Permalink to this heading")

This file contains the function to, you guessed it, fetch the list of current documents in the index. The code is as follows:


```
export type Document = { id: string; text: string;};const fetchDocuments = async (): Promise<Document[]> => { const response = await fetch("http://localhost:5601/getDocuments", { mode: "cors", }); if (!response.ok) { return []; } const documentList = (await response.json()) as Document[]; return documentList;};
```
As you can see, we make a query to the Flask server (here, it assumes running on localhost). Notice that we need to include the `mode: 'cors'` option, as we are making an external request.

Then, we check if the response was ok, and if so, get the response json and return it. Here, the response json is a list of `Document` objects that are defined in the same file.

### queryIndex.tsx[](#queryindex-tsx "Permalink to this heading")

This file sends the user query to the flask server, and gets the response back, as well as details about which nodes in our index provided the response.


```
export type ResponseSources = { text: string; doc\_id: string; start: number; end: number; similarity: number;};export type QueryResponse = { text: string; sources: ResponseSources[];};const queryIndex = async (query: string): Promise<QueryResponse> => { const queryURL = new URL("http://localhost:5601/query?text=1"); queryURL.searchParams.append("text", query); const response = await fetch(queryURL, { mode: "cors" }); if (!response.ok) { return { text: "Error in query", sources: [] }; } const queryResponse = (await response.json()) as QueryResponse; return queryResponse;};export default queryIndex;
```
This is similar to the `fetchDocuments.tsx` file, with the main difference being we include the query text as a parameter in the URL. Then, we check if the response is ok and return it with the appropriate typescript type.

### insertDocument.tsx[](#insertdocument-tsx "Permalink to this heading")

Probably the most complex API call is uploading a document. The function here accepts a file object and constructs a `POST` request using `FormData`.

The actual response text is not used in the app but could be utilized to provide some user feedback on if the file failed to upload or not.


```
const insertDocument = async (file: File) => { const formData = new FormData(); formData.append("file", file); formData.append("filename\_as\_doc\_id", "true"); const response = await fetch("http://localhost:5601/uploadFile", { mode: "cors", method: "POST", body: formData, }); const responseText = response.text(); return responseText;};export default insertDocument;
```
### All the Other Frontend Good-ness[](#all-the-other-frontend-good-ness "Permalink to this heading")

And that pretty much wraps up the frontend portion! The rest of the react frontend code is some pretty basic react components, and my best attempt to make it look at least a little nice :smile:.

I encourage to read the rest of the [codebase](https://github.com/logan-markewich/llama_index_starter_pack/tree/main/flask_react/react_frontend) and submit any PRs for improvements!

Conclusion[](#conclusion "Permalink to this heading")
------------------------------------------------------

This guide has covered a ton of information. We went from a basic “Hello World” Flask server written in python, to a fully functioning LlamaIndex powered backend and how to connect that to a frontend application.

As you can see, we can easily augment and wrap the services provided by LlamaIndex (like the little external document tracker) to help provide a good user experience on the frontend.

You could take this and add many features (multi-index/user support, saving objects into S3, adding a Pinecone vector server, etc.). And when you build an app after reading this, be sure to share the final result in the Discord! Good Luck! :muscle:

