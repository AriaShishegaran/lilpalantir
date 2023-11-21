[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/llm/clarifai.ipynb)

Clarifai LLM[](#clarifai-llm "Permalink to this heading")
==========================================================

Example notebook to call different LLM models using clarifai[](#example-notebook-to-call-different-llm-models-using-clarifai "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------------

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Install clarifai


```
!pip install clarifai
```
Set clarifai PAT as environment variable.


```
import osos.environ["CLARIFAI\_PAT"] = "<YOUR CLARIFAI PAT>"
```
Import clarifai package


```
from llama\_index.llms.clarifai import Clarifai
```
Explore various models according to your prefrence from[Our Models page](https://clarifai.com/explore/models?filterData=%5B%7B%22field%22%3A%22use_cases%22%2C%22value%22%3A%5B%22llm%22%5D%7D%5D&amp;page=2&amp;perPage=24)


```
# Example parametersparams = dict(    user\_id="clarifai",    app\_id="ml",    model\_name="llama2-7b-alternative-4k",    model\_url=(        "https://clarifai.com/clarifai/ml/models/llama2-7b-alternative-4k"    ),)
```
Initialize the LLM


```
# Method:1 using model\_url parameterllm\_model = Clarifai(model\_url=params["model\_url"])
```

```
# Method:2 using model\_name, app\_id & user\_id parametersllm\_model = Clarifai(    model\_name=params["model\_name"],    app\_id=params["app\_id"],    user\_id=params["user\_id"],)
```
Call `complete` function


```
llm\_reponse = llm\_model.complete(    prompt="write a 10 line rhyming poem about science")
```

```
print(llm\_reponse)
```

```
.Science is fun, it's true!From atoms to galaxies, it's all new!With experiments and tests, we learn so fast,And discoveries come from the past.It helps us understand the world around,And makes our lives more profound.So let's embrace this wondrous art,And see where it takes us in the start!
```
Call `chat` function


```
from llama\_index.llms import ChatMessagemessages = [    ChatMessage(role="user", content="write about climate change in 50 lines")]Response = llm\_model.chat(messages)
```

```
print(Response)
```

```
user:  or less.Climate change is a serious threat to our planet and its inhabitants. Rising temperatures are causing extreme weather events, such as hurricanes, droughts, and wildfires. Sea levels are rising, threatening coastal communities and ecosystems. The melting of polar ice caps is disrupting global navigation and commerce. Climate change is also exacerbating air pollution, which can lead to respiratory problems and other health issues. It's essential that we take action now to reduce greenhouse gas emissions and transition to renewable energy sources to mitigate the worst effects of climate change.
```
