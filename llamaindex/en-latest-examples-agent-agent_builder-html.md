GPT Builder Demo[](#gpt-builder-demo "Permalink to this heading")
==================================================================

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/agent/agent_builder.ipynb)

Inspired by GPTs interface, presented at OpenAI Dev Day 2023. Construct an agent with natural language.

Here you can build your own agent…with another agent!


```
from llama\_index.tools import BaseTool, FunctionTool
```

```
from llama\_index.agent import OpenAIAgentfrom llama\_index.prompts import PromptTemplatefrom llama\_index.llms import ChatMessage, OpenAIfrom llama\_index import ServiceContext
```

```
llm = OpenAI(model="gpt-4")service\_context = ServiceContext.from\_defaults(llm=llm)
```
Define Candidate Tools[](#define-candidate-tools "Permalink to this heading")
------------------------------------------------------------------------------

We also define a tool retriever to retrieve candidate tools.

In this setting we define tools as different Wikipedia pages.


```
from llama\_index import SimpleDirectoryReader
```

```
wiki\_titles = ["Toronto", "Seattle", "Chicago", "Boston", "Houston"]
```

```
from pathlib import Pathimport requestsfor title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```

```
# Load all wiki documentscity\_docs = {}for wiki\_title in wiki\_titles:    city\_docs[wiki\_title] = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()
```
### Build Query Tool for Each Document[](#build-query-tool-for-each-document "Permalink to this heading")


```
from llama\_index.agent import OpenAIAgentfrom llama\_index.tools import QueryEngineTool, ToolMetadata# Build tool dictionarytool\_dict = {}for wiki\_title in wiki\_titles:    # build vector index    vector\_index = VectorStoreIndex.from\_documents(        city\_docs[wiki\_title], service\_context=service\_context    )    # define query engines    vector\_query\_engine = vector\_index.as\_query\_engine()    # define tools    vector\_tool = QueryEngineTool(        query\_engine=vector\_query\_engine,        metadata=ToolMetadata(            name=wiki\_title,            description=("Useful for questions related to" f" {wiki\_title}"),        ),    )    tool\_dict[wiki\_title] = vector\_tool
```
### Define Tool Retriever[](#define-tool-retriever "Permalink to this heading")


```
# define an "object" index and retriever over these toolsfrom llama\_index import VectorStoreIndexfrom llama\_index.objects import ObjectIndex, SimpleToolNodeMappingtool\_mapping = SimpleToolNodeMapping.from\_objects(list(tool\_dict.values()))tool\_index = ObjectIndex.from\_objects(    list(tool\_dict.values()),    tool\_mapping,    VectorStoreIndex,)tool\_retriever = tool\_index.as\_retriever(similarity\_top\_k=1)
```
### Load Data[](#load-data "Permalink to this heading")

Here we load wikipedia pages from different cities.

Define Meta-Tools for GPT Builder[](#define-meta-tools-for-gpt-builder "Permalink to this heading")
----------------------------------------------------------------------------------------------------


```
from llama\_index.prompts import ChatPromptTemplatefrom typing import ListGEN\_SYS\_PROMPT\_STR = """\Task information is given below. Given the task, please generate a system prompt for an OpenAI-powered bot to solve this task: {task} \"""gen\_sys\_prompt\_messages = [    ChatMessage(        role="system",        content="You are helping to build a system prompt for another bot.",    ),    ChatMessage(role="user", content=GEN\_SYS\_PROMPT\_STR),]GEN\_SYS\_PROMPT\_TMPL = ChatPromptTemplate(gen\_sys\_prompt\_messages)agent\_cache = {}def create\_system\_prompt(task: str): """Create system prompt for another agent given an input task."""    llm = OpenAI(llm="gpt-4")    fmt\_messages = GEN\_SYS\_PROMPT\_TMPL.format\_messages(task=task)    response = llm.chat(fmt\_messages)    return response.message.contentdef get\_tools(task: str): """Get the set of relevant tools to use given an input task."""    subset\_tools = tool\_retriever.retrieve(task)    return [t.metadata.name for t in subset\_tools]def create\_agent(system\_prompt: str, tool\_names: List[str]): """Create an agent given a system prompt and an input set of tools."""    llm = OpenAI(model="gpt-4")    try:        # get the list of tools        input\_tools = [tool\_dict[tn] for tn in tool\_names]        agent = OpenAIAgent.from\_tools(input\_tools, llm=llm, verbose=True)        agent\_cache["agent"] = agent        return\_msg = "Agent created successfully."    except Exception as e:        return\_msg = f"An error occurred when building an agent. Here is the error: {repr(e)}"    return return\_msg
```

```
system\_prompt\_tool = FunctionTool.from\_defaults(fn=create\_system\_prompt)get\_tools\_tool = FunctionTool.from\_defaults(fn=get\_tools)create\_agent\_tool = FunctionTool.from\_defaults(fn=create\_agent)
```

```
GPT\_BUILDER\_SYS\_STR = """\You are helping to construct an agent given a user-specified task. You should generally use the tools in this order to build the agent.1) Create system prompt tool: to create the system prompt for the agent.2) Get tools tool: to fetch the candidate set of tools to use.3) Create agent tool: to create the final agent."""prefix\_msgs = [ChatMessage(role="system", content=GPT\_BUILDER\_SYS\_STR)]builder\_agent = OpenAIAgent.from\_tools(    tools=[system\_prompt\_tool, get\_tools\_tool, create\_agent\_tool],    llm=llm,    prefix\_messages=prefix\_msgs,    verbose=True,)
```

```
builder\_agent.query("Build an agent that can tell me about Toronto.")
```

```
=== Calling Function ===Calling function: create_system_prompt with args: {  "task": "tell me about Toronto"}Got output: System Prompt: "Sure, I can provide you with information about Toronto. Toronto is the capital city of the province of Ontario, Canada. It is the largest city in Canada and one of the most multicultural cities in the world. Known for its diverse population, vibrant arts scene, and thriving business community, Toronto offers a wide range of attractions and experiences.Toronto is home to iconic landmarks such as the CN Tower, which offers breathtaking views of the city, and the Royal Ontario Museum, which houses an extensive collection of art, culture, and natural history. The city also boasts beautiful waterfront areas, including the Harbourfront Centre and the Toronto Islands, where visitors can enjoy outdoor activities and scenic views.In terms of culture, Toronto hosts numerous festivals throughout the year, including the Toronto International Film Festival, Caribana, and Nuit Blanche. The city is also known for its world-class dining scene, offering a diverse range of cuisines from around the globe.Toronto is a major economic hub, with a strong presence in industries such as finance, technology, and healthcare. It is home to the Toronto Stock Exchange and several multinational corporations. The city's robust public transportation system, including the TTC subway and streetcar network, makes it easy to navigate and explore.Whether you're interested in exploring its cultural attractions, enjoying its culinary delights, or experiencing its vibrant nightlife, Toronto has something to offer for everyone. How can I assist you further in discovering more about Toronto?"=========================== Calling Function ===Calling function: get_tools with args: {  "task": "tell me about Toronto"}Got output: ['Toronto']=========================== Calling Function ===Calling function: create_agent with args: {  "system_prompt": "Sure, I can provide you with information about Toronto. Toronto is the capital city of the province of Ontario, Canada. It is the largest city in Canada and one of the most multicultural cities in the world. Known for its diverse population, vibrant arts scene, and thriving business community, Toronto offers a wide range of attractions and experiences.\n\nToronto is home to iconic landmarks such as the CN Tower, which offers breathtaking views of the city, and the Royal Ontario Museum, which houses an extensive collection of art, culture, and natural history. The city also boasts beautiful waterfront areas, including the Harbourfront Centre and the Toronto Islands, where visitors can enjoy outdoor activities and scenic views.\n\nIn terms of culture, Toronto hosts numerous festivals throughout the year, including the Toronto International Film Festival, Caribana, and Nuit Blanche. The city is also known for its world-class dining scene, offering a diverse range of cuisines from around the globe.\n\nToronto is a major economic hub, with a strong presence in industries such as finance, technology, and healthcare. It is home to the Toronto Stock Exchange and several multinational corporations. The city's robust public transportation system, including the TTC subway and streetcar network, makes it easy to navigate and explore.\n\nWhether you're interested in exploring its cultural attractions, enjoying its culinary delights, or experiencing its vibrant nightlife, Toronto has something to offer for everyone. How can I assist you further in discovering more about Toronto?",  "tool_names": ["Toronto"]}Got output: Agent created successfully.========================
```

```
Response(response='The agent has been successfully created. It can provide detailed information about Toronto, including its landmarks, culture, economy, and transportation.', source_nodes=[], metadata=None)
```

```
city\_agent = agent\_cache["agent"]
```

```
response = city\_agent.query("Tell me about the parks in Toronto")print(str(response))
```

```
=== Calling Function ===Calling function: Toronto with args: {  "input": "parks in Toronto"}Got output: Toronto has a wide variety of public parks and spaces. Some of the downtown parks include Allan Gardens, Christie Pits, Grange Park, Little Norway Park, Moss Park, Queen's Park, Riverdale Park and Trinity Bellwoods Park. There are also two large parks on the waterfront south of downtown: Tommy Thompson Park and the Toronto Islands. Other large parks managed by the city in the outer areas include High Park, Humber Bay Park, Centennial Park, Downsview Park, Guild Park and Gardens, Sunnybrook Park and Morningside Park. Toronto also has parts of Rouge National Urban Park, the largest urban park in North America, which is managed by Parks Canada.========================Toronto is home to a variety of parks, offering a mix of natural beauty, recreational activities, and cultural experiences. Here are some of the notable parks in Toronto:1. **Allan Gardens**: Located downtown, this park features a conservatory with six greenhouses showcasing rare botanical plants.2. **Christie Pits**: Known for its outdoor pool and artificial ice rink, this park is a popular spot for sports and leisure.3. **Grange Park**: This park is located in the heart of the city and offers a playground, a splash pad, and a dog off-leash area.4. **Little Norway Park**: Overlooking the waterfront, this park features a playground, a wading pool, and a baseball diamond.5. **Moss Park**: This downtown park has a large sports field, a playground, and a splash pad.6. **Queen's Park**: This urban park is home to the Ontario Legislative Building and several monuments.7. **Riverdale Park**: Offering panoramic views of downtown Toronto, this park has sports fields, a swimming pool, and a large off-leash dog area.8. **Trinity Bellwoods Park**: This popular park features a variety of recreational facilities, including sports fields, a wading pool, and a children's playground.9. **Tommy Thompson Park**: Located on the waterfront, this park is a popular spot for bird watching and nature walks.10. **Toronto Islands**: This group of small islands offers beaches, picnic areas, and canoe rentals.11. **High Park**: Toronto's largest public park, featuring hiking trails, sports facilities, a beautiful lakefront, a dog park, a zoo, and several playgrounds.12. **Humber Bay Park**: This waterfront park offers stunning views of the Toronto skyline, a butterfly habitat, and a network of trails.13. **Centennial Park**: One of Toronto's busiest parks, featuring a conservatory, a ski hill, a golf centre, and a multipurpose sports field.14. **Downsview Park**: Once a military base, now a dynamic urban park with sports fields, a pond, and a forested area.15. **Guild Park and Gardens**: Known for its collection of salvaged architectural pieces, this park offers a unique blend of nature and culture.16. **Sunnybrook Park**: This park offers a variety of sports fields, horse stables, and a dog off-leash area.17. **Morningside Park**: One of Toronto's largest parks, featuring picnic areas, walking trails, and a creek.18. **Rouge National Urban Park**: Managed by Parks Canada, this is the largest urban park in North America, offering a mix of wilderness, farmland, and historical sites.
```
