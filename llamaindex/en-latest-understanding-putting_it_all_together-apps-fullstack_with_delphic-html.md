A Guide to Building a Full-Stack LlamaIndex Web App with Delphic[](#a-guide-to-building-a-full-stack-llamaindex-web-app-with-delphic "Permalink to this heading")
==================================================================================================================================================================

This guide seeks to walk you through using LlamaIndex with a production-ready web app starter templatecalled [Delphic](https://github.com/JSv4/Delphic). All code examples here are available fromthe [Delphic](https://github.com/JSv4/Delphic) repo

What We’re Building[](#what-we-re-building "Permalink to this heading")
------------------------------------------------------------------------

Here’s a quick demo of the out-of-the-box functionality of Delphic:

https://user-images.githubusercontent.com/5049984/233236432-aa4980b6-a510-42f3-887a-81485c9644e6.mp4

Architectural Overview[](#architectural-overview "Permalink to this heading")
------------------------------------------------------------------------------

Delphic leverages the LlamaIndex python library to let users to create their own document collections they can thenquery in a responsive frontend.

We chose a stack that provides a responsive, robust mix of technologies that can (1) orchestrate complex pythonprocessing tasks while providing (2) a modern, responsive frontend and (3) a secure backend to build additionalfunctionality upon.

The core libraries are:

1. [Django](https://www.djangoproject.com/)
2. [Django Channels](https://channels.readthedocs.io/en/stable/)
3. [Django Ninja](https://django-ninja.rest-framework.com/)
4. [Redis](https://redis.io/)
5. [Celery](https://docs.celeryq.dev/en/stable/getting-started/introduction.html)
6. [LlamaIndex](https://gpt-index.readthedocs.io/en/latest/)
7. [Langchain](https://python.langchain.com/en/latest/index.html)
8. [React](https://github.com/facebook/react)
9. Docker & Docker Compose

Thanks to this modern stack built on the super stable Django web framework, the starter Delphic app boasts a streamlineddeveloper experience, built-in authentication and user management, asynchronous vector store processing, andweb-socket-based query connections for a responsive UI. In addition, our frontend is built with TypeScript and is basedon MUI React for a responsive and modern user interface.

System Requirements[](#system-requirements "Permalink to this heading")
------------------------------------------------------------------------

Celery doesn’t work on Windows. It may be deployable with Windows Subsystem for Linux, but configuring that is beyondthe scope of this tutorial. For this reason, we recommend you only follow this tutorial if you’re running Linux or OSX.You will need Docker and Docker Compose installed to deploy the application. Local development will require node versionmanager (nvm).

Django Backend[](#django-backend "Permalink to this heading")
--------------------------------------------------------------

### Project Directory Overview[](#project-directory-overview "Permalink to this heading")

The Delphic application has a structured backend directory organization that follows common Django project conventions.From the repo root, in the `./delphic` subfolder, the main folders are:

1. `contrib`: This directory contains custom modifications or additions to Django’s built-in `contrib` apps.
2. `indexes`: This directory contains the core functionality related to document indexing and LLM integration. Itincludes:
* `admin.py`: Django admin configuration for the app
* `apps.py`: Application configuration
* `models.py`: Contains the app’s database models
* `migrations`: Directory containing database schema migrations for the app
* `signals.py`: Defines any signals for the app
* `tests.py`: Unit tests for the app
3. `tasks`: This directory contains tasks for asynchronous processing using Celery. The `index\_tasks.py` file includesthe tasks for creating vector indexes.
4. `users`: This directory is dedicated to user management, including:
5. `utils`: This directory contains utility modules and functions that are used across the application, such as customstorage backends, path helpers, and collection-related utilities.
### Database Models[](#database-models "Permalink to this heading")

The Delphic application has two core models: `Document` and `Collection`. These models represent the central entitiesthe application deals with when indexing and querying documents using LLMs. They’re defined in[`./delphic/indexes/models.py`](https://github.com/JSv4/Delphic/blob/main/delphic/indexes/models.py).

1. `Collection`:
* `api\_key`: A foreign key that links a collection to an API key. This helps associate jobs with the source API key.
* `title`: A character field that provides a title for the collection.
* `description`: A text field that provides a description of the collection.
* `status`: A character field that stores the processing status of the collection, utilizing the `CollectionStatus`enumeration.
* `created`: A datetime field that records when the collection was created.
* `modified`: A datetime field that records the last modification time of the collection.
* `model`: A file field that stores the model associated with the collection.
* `processing`: A boolean field that indicates if the collection is currently being processed.
2. `Document`:
* `collection`: A foreign key that links a document to a collection. This represents the relationship between documentsand collections.
* `file`: A file field that stores the uploaded document file.
* `description`: A text field that provides a description of the document.
* `created`: A datetime field that records when the document was created.
* `modified`: A datetime field that records the last modification time of the document.

These models provide a solid foundation for collections of documents and the indexes created from them with LlamaIndex.

### Django Ninja API[](#django-ninja-api "Permalink to this heading")

Django Ninja is a web framework for building APIs with Django and Python 3.7+ type hints. It provides a simple,intuitive, and expressive way of defining API endpoints, leveraging Python’s type hints to automatically generate inputvalidation, serialization, and documentation.

In the Delphic repo,the [`./config/api/endpoints.py`](https://github.com/JSv4/Delphic/blob/main/config/api/endpoints.py)file contains the API routes and logic for the API endpoints. Now, let’s briefly address the purpose of each endpointin the `endpoints.py` file:

1. `/heartbeat`: A simple GET endpoint to check if the API is up and running. Returns `True` if the API is accessible.This is helpful for Kubernetes setups that expect to be able to query your container to ensure it’s up and running.
2. `/collections/create`: A POST endpoint to create a new `Collection`. Accepts form parameters suchas `title`, `description`, and a list of `files`. Creates a new `Collection` and `Document` instances for each file,and schedules a Celery task to create an index.


```
@collections\_router.post("/create")async def create\_collection(    request,    title: str = Form(...),    description: str = Form(...),    files: list[UploadedFile] = File(...),):    key = None if getattr(request, "auth", None) is None else request.auth    if key is not None:        key = await key    collection\_instance = Collection(        api\_key=key,        title=title,        description=description,        status=CollectionStatusEnum.QUEUED,    )    await sync\_to\_async(collection\_instance.save)()    for uploaded\_file in files:        doc\_data = uploaded\_file.file.read()        doc\_file = ContentFile(doc\_data, uploaded\_file.name)        document = Document(collection=collection\_instance, file=doc\_file)        await sync\_to\_async(document.save)()    create\_index.si(collection\_instance.id).apply\_async()    return await sync\_to\_async(CollectionModelSchema)(...)
```
3. `/collections/query` — a POST endpoint to query a document collection using the LLM. Accepts a JSON payloadcontaining `collection\_id` and `query\_str`, and returns a response generated by querying the collection. We don’tactually use this endpoint in our chat GUI (We use a websocket - see below), but you could build an app to integrateto this REST endpoint to query a specific collection.


```
@collections\_router.post(    "/query",    response=CollectionQueryOutput,    summary="Ask a question of a document collection",)def query\_collection\_view(    request: HttpRequest, query\_input: CollectionQueryInput):    collection\_id = query\_input.collection\_id    query\_str = query\_input.query\_str    response = query\_collection(collection\_id, query\_str)    return {"response": response}
```
4. `/collections/available`: A GET endpoint that returns a list of all collections created with the user’s API key. Theoutput is serialized using the `CollectionModelSchema`.


```
@collections\_router.get(    "/available",    response=list[CollectionModelSchema],    summary="Get a list of all of the collections created with my api\_key",)async def get\_my\_collections\_view(request: HttpRequest):    key = None if getattr(request, "auth", None) is None else request.auth    if key is not None:        key = await key    collections = Collection.objects.filter(api\_key=key)    return [{...} async for collection in collections]
```
5. `/collections/{collection\_id}/add\_file`: A POST endpoint to add a file to an existing collection. Acceptsa `collection\_id` path parameter, and form parameters such as `file` and `description`. Adds the file as a `Document`instance associated with the specified collection.


```
@collections\_router.post(    "/{collection\_id}/add\_file", summary="Add a file to a collection")async def add\_file\_to\_collection(    request,    collection\_id: int,    file: UploadedFile = File(...),    description: str = Form(...),):    collection = await sync\_to\_async(Collection.objects.get)(id=collection\_id)
```
### Intro to Websockets[](#intro-to-websockets "Permalink to this heading")

WebSockets are a communication protocol that enables bidirectional and full-duplex communication between a client and aserver over a single, long-lived connection. The WebSocket protocol is designed to work over the same ports as HTTP andHTTPS (ports 80 and 443, respectively) and uses a similar handshake process to establish a connection. Once theconnection is established, data can be sent in both directions as “frames” without the need to reestablish theconnection each time, unlike traditional HTTP requests.

There are several reasons to use WebSockets, particularly when working with code that takes a long time to load intomemory but is quick to run once loaded:

1. **Performance**: WebSockets eliminate the overhead associated with opening and closing multiple connections for eachrequest, reducing latency.
2. **Efficiency**: WebSockets allow for real-time communication without the need for polling, resulting in moreefficient use of resources and better responsiveness.
3. **Scalability**: WebSockets can handle a large number of simultaneous connections, making it ideal for applicationsthat require high concurrency.

In the case of the Delphic application, using WebSockets makes sense as the LLMs can be expensive to load into memory.By establishing a WebSocket connection, the LLM can remain loaded in memory, allowing subsequent requests to beprocessed quickly without the need to reload the model each time.

The ASGI configuration file [`./config/asgi.py`](https://github.com/JSv4/Delphic/blob/main/config/asgi.py) defines howthe application should handle incoming connections, using the Django Channels `ProtocolTypeRouter` to route connectionsbased on their protocol type. In this case, we have two protocol types: “http” and “websocket”.

The “http” protocol type uses the standard Django ASGI application to handle HTTP requests, while the “websocket”protocol type uses a custom `TokenAuthMiddleware` to authenticate WebSocket connections. The `URLRouter` withinthe `TokenAuthMiddleware` defines a URL pattern for the `CollectionQueryConsumer`, which is responsible for handlingWebSocket connections related to querying document collections.


```
application = ProtocolTypeRouter(    {        "http": get\_asgi\_application(),        "websocket": TokenAuthMiddleware(            URLRouter(                [                    re\_path(                        r"ws/collections/(?P<collection\_id>\w+)/query/$",                        CollectionQueryConsumer.as\_asgi(),                    ),                ]            )        ),    })
```
This configuration allows clients to establish WebSocket connections with the Delphic application to efficiently querydocument collections using the LLMs, without the need to reload the models for each request.

### Websocket Handler[](#websocket-handler "Permalink to this heading")

The `CollectionQueryConsumer` classin [`config/api/websockets/queries.py`](https://github.com/JSv4/Delphic/blob/main/config/api/websockets/queries.py) isresponsible for handling WebSocket connections related to querying document collections. It inherits fromthe `AsyncWebsocketConsumer` class provided by Django Channels.

The `CollectionQueryConsumer` class has three main methods:

1. `connect`: Called when a WebSocket is handshaking as part of the connection process.
2. `disconnect`: Called when a WebSocket closes for any reason.
3. `receive`: Called when the server receives a message from the WebSocket.

#### Websocket connect listener[](#websocket-connect-listener "Permalink to this heading")

The `connect` method is responsible for establishing the connection, extracting the collection ID from the connectionpath, loading the collection model, and accepting the connection.


```
async def connect(self):    try:        self.collection\_id = extract\_connection\_id(self.scope["path"])        self.index = await load\_collection\_model(self.collection\_id)        await self.accept()    except ValueError as e:        await self.accept()        await self.close(code=4000)    except Exception as e:        pass
```
#### Websocket disconnect listener[](#websocket-disconnect-listener "Permalink to this heading")

The `disconnect` method is empty in this case, as there are no additional actions to be taken when the WebSocket isclosed.

#### Websocket receive listener[](#websocket-receive-listener "Permalink to this heading")

The `receive` method is responsible for processing incoming messages from the WebSocket. It takes the incoming message,decodes it, and then queries the loaded collection model using the provided query. The response is then formatted as amarkdown string and sent back to the client over the WebSocket connection.


```
async def receive(self, text\_data):    text\_data\_json = json.loads(text\_data)    if self.index is not None:        query\_str = text\_data\_json["query"]        modified\_query\_str = f"Please return a nicely formatted markdown string to this request:\n\n{query\_str}"        query\_engine = self.index.as\_query\_engine()        response = query\_engine.query(modified\_query\_str)        markdown\_response = f"## Response\n\n{response}\n\n"        if response.source\_nodes:            markdown\_sources = (                f"## Sources\n\n{response.get\_formatted\_sources()}"            )        else:            markdown\_sources = ""        formatted\_response = f"{markdown\_response}{markdown\_sources}"        await self.send(json.dumps({"response": formatted\_response}, indent=4))    else:        await self.send(            json.dumps(                {"error": "No index loaded for this connection."}, indent=4            )        )
```
To load the collection model, the `load\_collection\_model` function is used, which can be foundin [`delphic/utils/collections.py`](https://github.com/JSv4/Delphic/blob/main/delphic/utils/collections.py). Thisfunction retrieves the collection object with the given collection ID, checks if a JSON file for the collection modelexists, and if not, creates one. Then, it sets up the `LLMPredictor` and `ServiceContext` before loadingthe `VectorStoreIndex` using the cache file.


```
async def load\_collection\_model(collection\_id: str | int) -> VectorStoreIndex: """ Load the Collection model from cache or the database, and return the index. Args: collection\_id (Union[str, int]): The ID of the Collection model instance. Returns: VectorStoreIndex: The loaded index. This function performs the following steps: 1. Retrieve the Collection object with the given collection\_id. 2. Check if a JSON file with the name '/cache/model\_{collection\_id}.json' exists. 3. If the JSON file doesn't exist, load the JSON from the Collection.model FileField and save it to '/cache/model\_{collection\_id}.json'. 4. Call VectorStoreIndex.load\_from\_disk with the cache\_file\_path. """    # Retrieve the Collection object    collection = await Collection.objects.aget(id=collection\_id)    logger.info(f"load\_collection\_model() - loaded collection {collection\_id}")    # Make sure there's a model    if collection.model.name:        logger.info("load\_collection\_model() - Setup local json index file")        # Check if the JSON file exists        cache\_dir = Path(settings.BASE\_DIR) / "cache"        cache\_file\_path = cache\_dir / f"model\_{collection\_id}.json"        if not cache\_file\_path.exists():            cache\_dir.mkdir(parents=True, exist\_ok=True)            with collection.model.open("rb") as model\_file:                with cache\_file\_path.open(                    "w+", encoding="utf-8"                ) as cache\_file:                    cache\_file.write(model\_file.read().decode("utf-8"))        # define LLM        logger.info(            f"load\_collection\_model() - Setup service context with tokens {settings.MAX\_TOKENS} and "            f"model {settings.MODEL\_NAME}"        )        llm = OpenAI(temperature=0, model="text-davinci-003", max\_tokens=512)        service\_context = ServiceContext.from\_defaults(llm=llm)        # Call VectorStoreIndex.load\_from\_disk        logger.info("load\_collection\_model() - Load llama index")        index = VectorStoreIndex.load\_from\_disk(            cache\_file\_path, service\_context=service\_context        )        logger.info(            "load\_collection\_model() - Llamaindex loaded and ready for query..."        )    else:        logger.error(            f"load\_collection\_model() - collection {collection\_id} has no model!"        )        raise ValueError("No model exists for this collection!")    return index
```
React Frontend[](#react-frontend "Permalink to this heading")
--------------------------------------------------------------

### Overview[](#overview "Permalink to this heading")

We chose to use TypeScript, React and Material-UI (MUI) for the Delphic project’s frontend for a couple reasons. First,as the most popular component library (MUI) for the most popular frontend framework (React), this choice makes thisproject accessible to a huge community of developers. Second, React is, at this point, a stable and generally well-likedframework that delivers valuable abstractions in the form of its virtual DOM while still being relatively stable and, inour opinion, pretty easy to learn, again making it accessible.

### Frontend Project Structure[](#frontend-project-structure "Permalink to this heading")

The frontend can be found in the [`/frontend`](https://github.com/JSv4/Delphic/tree/main/frontend) directory of therepo, with the React-related components being in `/frontend/src` . You’ll notice there is a DockerFile in the `frontend`directory and several folders and files related to configuring our frontend webserver — [nginx](https://www.nginx.com/).

The `/frontend/src/App.tsx` file serves as the entry point of the application. It defines the main components, such asthe login form, the drawer layout, and the collection create modal. The main components are conditionally rendered basedon whether the user is logged in and has an authentication token.

The DrawerLayout2 component is defined in the`DrawerLayour2.tsx` file. This component manages the layout of theapplication and provides the navigation and main content areas.

Since the application is relatively simple, we can get away with not using a complex state management solution likeRedux and just use React’s useState hooks.

### Grabbing Collections from the Backend[](#grabbing-collections-from-the-backend "Permalink to this heading")

The collections available to the logged-in user are retrieved and displayed in the DrawerLayout2 component. The processcan be broken down into the following steps:

1. Initializing state variables:


```
const [collections, setCollections] = useState<CollectionModelSchema[]>([]);const [loading, setLoading] = useState(true);
```
Here, we initialize two state variables: `collections` to store the list of collections and `loading` to track whetherthe collections are being fetched.

2. Collections are fetched for the logged-in user with the `fetchCollections()` function:


```
constfetchCollections = async () = > {try {const accessToken = localStorage.getItem("accessToken");if (accessToken) {const response = await getMyCollections(accessToken);setCollections(response.data);}} catch (error) {console.error(error);} finally {setLoading(false);}};
```
The `fetchCollections` function retrieves the collections for the logged-in user by calling the `getMyCollections` APIfunction with the user’s access token. It then updates the `collections` state with the retrieved data and setsthe `loading` state to `false` to indicate that fetching is complete.

### Displaying Collections[](#displaying-collections "Permalink to this heading")

The latest collectios are displayed in the drawer like this:


```
< List >{collections.map((collection) = > (    < div key={collection.id} >    < ListItem disablePadding >    < ListItemButton    disabled={    collection.status != = CollectionStatus.COMPLETE | |    !collection.has_model    }    onClick={() = > handleCollectionClick(collection)}selected = {    selectedCollection & &    selectedCollection.id == = collection.id}>< ListItemTextprimary = {collection.title} / >          {collection.status == = CollectionStatus.RUNNING ? (    < CircularProgress    size={24}    style={{position: "absolute", right: 16}}    / >): null}< / ListItemButton >    < / ListItem >        < / div >))}< / List >
```
You’ll notice that the `disabled` property of a collection’s `ListItemButton` is set based on whether the collection’sstatus is not `CollectionStatus.COMPLETE` or the collection does not have a model (`!collection.has\_model`). If eitherof these conditions is true, the button is disabled, preventing users from selecting an incomplete or model-lesscollection. Where the CollectionStatus is RUNNING, we also show a loading wheel over the button.

In a separate `useEffect` hook, we check if any collection in the `collections` state has a statusof `CollectionStatus.RUNNING` or `CollectionStatus.QUEUED`. If so, we set up an interval to repeatedly callthe `fetchCollections` function every 15 seconds (15,000 milliseconds) to update the collection statuses. This way, theapplication periodically checks for completed collections, and the UI is updated accordingly when the processing isdone.


```
useEffect(() = > {    letinterval: NodeJS.Timeout;if (    collections.some(        (collection) = >collection.status == = CollectionStatus.RUNNING | |collection.status == = CollectionStatus.QUEUED)) {    interval = setInterval(() = > {    fetchCollections();}, 15000);}return () = > clearInterval(interval);}, [collections]);
```
### Chat View Component[](#chat-view-component "Permalink to this heading")

The `ChatView` component in `frontend/src/chat/ChatView.tsx` is responsible for handling and displaying a chat interfacefor a user to interact with a collection. The component establishes a WebSocket connection to communicate in real-timewith the server, sending and receiving messages.

Key features of the `ChatView` component include:

1. Establishing and managing the WebSocket connection with the server.
2. Displaying messages from the user and the server in a chat-like format.
3. Handling user input to send messages to the server.
4. Updating the messages state and UI based on received messages from the server.
5. Displaying connection status and errors, such as loading messages, connecting to the server, or encountering errorswhile loading a collection.

Together, all of this allows users to interact with their selected collection with a very smooth, low-latencyexperience.

#### Chat Websocket Client[](#chat-websocket-client "Permalink to this heading")

The WebSocket connection in the `ChatView` component is used to establish real-time communication between the client andthe server. The WebSocket connection is set up and managed in the `ChatView` component as follows:

First, we want to initialize the the WebSocket reference:

const websocket = useRef<WebSocket | null>(null);

A `websocket` reference is created using `useRef`, which holds the WebSocket object that will be used forcommunication. `useRef` is a hook in React that allows you to create a mutable reference object that persists acrossrenders. It is particularly useful when you need to hold a reference to a mutable object, such as a WebSocketconnection, without causing unnecessary re-renders.

In the `ChatView` component, the WebSocket connection needs to be established and maintained throughout the lifetime ofthe component, and it should not trigger a re-render when the connection state changes. By using `useRef`, you ensurethat the WebSocket connection is kept as a reference, and the component only re-renders when there are actual statechanges, such as updating messages or displaying errors.

The `setupWebsocket` function is responsible for establishing the WebSocket connection and setting up event handlers tohandle different WebSocket events.

Overall, the setupWebsocket function looks like this:


```
const setupWebsocket = () => {  setConnecting(true);  // Here, a new WebSocket object is created using the specified URL, which includes the  // selected collection's ID and the user's authentication token.  websocket.current = new WebSocket(    `ws://localhost:8000/ws/collections/${selectedCollection.id}/query/?token=${authToken}`,  );  websocket.current.onopen = (event) => {    //...  };  websocket.current.onmessage = (event) => {    //...  };  websocket.current.onclose = (event) => {    //...  };  websocket.current.onerror = (event) => {    //...  };  return () => {    websocket.current?.close();  };};
```
Notice in a bunch of places we trigger updates to the GUI based on the information from the web socket client.

When the component first opens and we try to establish a connection, the `onopen` listener is triggered. In thecallback, the component updates the states to reflect that the connection is established, any previous errors arecleared, and no messages are awaiting responses:


```
websocket.current.onopen = (event) => {  setError(false);  setConnecting(false);  setAwaitingMessage(false);  console.log("WebSocket connected:", event);};
```
`onmessage`is triggered when a new message is received from the server through the WebSocket connection. In thecallback, the received data is parsed and the `messages` state is updated with the new message from the server:


```
websocket.current.onmessage = (event) => {  const data = JSON.parse(event.data);  console.log("WebSocket message received:", data);  setAwaitingMessage(false);  if (data.response) {    // Update the messages state with the new message from the server    setMessages((prevMessages) => [      ...prevMessages,      {        sender\_id: "server",        message: data.response,        timestamp: new Date().toLocaleTimeString(),      },    ]);  }};
```
`onclose`is triggered when the WebSocket connection is closed. In the callback, the component checks for a specificclose code (`4000`) to display a warning toast and update the component states accordingly. It also logs the closeevent:


```
websocket.current.onclose = (event) => {  if (event.code === 4000) {    toast.warning(      "Selected collection's model is unavailable. Was it created properly?",    );    setError(true);    setConnecting(false);    setAwaitingMessage(false);  }  console.log("WebSocket closed:", event);};
```
Finally, `onerror` is triggered when an error occurs with the WebSocket connection. In the callback, the componentupdates the states to reflect the error and logs the error event:


```
websocket.current.onerror = (event) => {  setError(true);  setConnecting(false);  setAwaitingMessage(false);  console.error("WebSocket error:", event);};
```
#### Rendering our Chat Messages[](#rendering-our-chat-messages "Permalink to this heading")

In the `ChatView` component, the layout is determined using CSS styling and Material-UI components. The main layoutconsists of a container with a `flex` display and a column-oriented `flexDirection`. This ensures that the contentwithin the container is arranged vertically.

There are three primary sections within the layout:

1. The chat messages area: This section takes up most of the available space and displays a list of messages exchangedbetween the user and the server. It has an overflow-y set to ‘auto’, which allows scrolling when the contentoverflows the available space. The messages are rendered using the `ChatMessage` component for each message anda `ChatMessageLoading` component to show the loading state while waiting for a server response.
2. The divider: A Material-UI `Divider` component is used to separate the chat messages area from the input area,creating a clear visual distinction between the two sections.
3. The input area: This section is located at the bottom and allows the user to type and send messages. It containsa `TextField` component from Material-UI, which is set to accept multiline input with a maximum of 2 rows. The inputarea also includes a `Button` component to send the message. The user can either click the “Send” button or press “Enter” on their keyboard to send the message.

The user inputs accepted in the `ChatView` component are text messages that the user types in the `TextField`. Thecomponent processes these text inputs and sends them to the server through the WebSocket connection.

Deployment[](#deployment "Permalink to this heading")
------------------------------------------------------

### Prerequisites[](#prerequisites "Permalink to this heading")

To deploy the app, you’re going to need Docker and Docker Compose installed. If you’re on Ubuntu or another, commonLinux distribution, DigitalOcean hasa [great Docker tutorial](https://www.digitalocean.com/community/tutorial_collections/how-to-install-and-use-docker) andanother great tutorialfor [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)you can follow. If those don’t work for you, trythe [official docker documentation.](https://docs.docker.com/engine/install/)

### Build and Deploy[](#build-and-deploy "Permalink to this heading")

The project is based on django-cookiecutter, and it’s pretty easy to get it deployed on a VM and configured to serveHTTPs traffic for a specific domain. The configuration is somewhat involved, however — not because of this project, butit’s just a fairly involved topic to configure your certificates, DNS, etc.

For the purposes of this guide, let’s just get running locally. Perhaps we’ll release a guide on production deployment.In the meantime, check outthe [Django Cookiecutter project docs](https://cookiecutter-django.readthedocs.io/en/latest/deployment-with-docker.html)for starters.

This guide assumes your goal is to get the application up and running for use. If you want to develop, most likely youwon’t want to launch the compose stack with the — profiles fullstack flag and will instead want to launch the reactfrontend using the node development server.

To deploy, first clone the repo:


```
git clone https://github.com/yourusername/delphic.git
```
Change into the project directory:


```
cd delphic
```
Copy the sample environment files:


```
mkdir -p ./.envs/.local/cp -a ./docs/sample_envs/local/.frontend ./frontendcp -a ./docs/sample_envs/local/.django ./.envs/.localcp -a ./docs/sample_envs/local/.postgres ./.envs/.local
```
Edit the `.django` and `.postgres` configuration files to include your OpenAI API key and set a unique password for yourdatabase user. You can also set the response token limit in the .django file or switch which OpenAI model you want touse. GPT4 is supported, assuming you’re authorized to access it.

Build the docker compose stack with the `--profiles fullstack` flag:


```
sudo docker-compose --profiles fullstack -f local.yml build
```
The fullstack flag instructs compose to build a docker container from the frontend folder and this will be launchedalong with all of the needed, backend containers. It takes a long time to build a production React container, however,so we don’t recommend you develop this way. Followthe [instructions in the project readme.md](https://github.com/JSv4/Delphic#development) for development environmentsetup instructions.

Finally, bring up the application:


```
sudo docker-compose -f local.yml up
```
Now, visit `localhost:3000` in your browser to see the frontend, and use the Delphic application locally.

Using the Application[](#using-the-application "Permalink to this heading")
----------------------------------------------------------------------------

### Setup Users[](#setup-users "Permalink to this heading")

In order to actually use the application (at the moment, we intend to make it possible to share certain models withunauthenticated users), you need a login. You can use either a superuser or non-superuser. In either case, someone needsto first create a superuser using the console:

**Why set up a Django superuser?** A Django superuser has all the permissions in the application and can manage allaspects of the system, including creating, modifying, and deleting users, collections, and other data. Setting up asuperuser allows you to fully control and manage the application.

**How to create a Django superuser:**

1 Run the following command to create a superuser:

sudo docker-compose -f local.yml run django python manage.py createsuperuser

2 You will be prompted to provide a username, email address, and password for the superuser. Enter the requiredinformation.

**How to create additional users using Django admin:**

1. Start your Delphic application locally following the deployment instructions.
2. Visit the Django admin interface by navigating to `http://localhost:8000/admin` in your browser.
3. Log in with the superuser credentials you created earlier.
4. Click on “Users” under the “Authentication and Authorization” section.
5. Click on the “Add user +” button in the top right corner.
6. Enter the required information for the new user, such as username and password. Click “Save” to create the user.
7. To grant the new user additional permissions or make them a superuser, click on their username in the user list,scroll down to the “Permissions” section, and configure their permissions accordingly. Save your changes.
