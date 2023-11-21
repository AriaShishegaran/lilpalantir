[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/azure_openai.ipynb)

Azure OpenAI[](#azure-openai "Permalink to this heading")
==========================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
Prerequisites[](#prerequisites "Permalink to this heading")
------------------------------------------------------------

1. Setup an Azure subscription - you can create one for free [here](https://azure.microsoft.com/en-us/free/cognitive-services/)
2. Apply for access to Azure OpenAI Service [here](https://customervoice.microsoft.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR7en2Ais5pxKtso_Pz4b1_xUOFA5Qk1UWDRBMjg0WFhPMkIzTzhKQ1dWNyQlQCN0PWcu)
3. Create a resource in the Azure portal [here](https://portal.azure.com/?microsoft_azure_marketplace_ItemHideKey=microsoft_openai_tip#create/Microsoft.CognitiveServicesOpenAI)
4. Deploy a model in Azure OpenAI Studio [here](https://oai.azure.com/)

You can find more details in [this guide.](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/create-resource?pivots=web-portal)

Note down the **“model name”** and **“deployment name”**, you’ll need it when connecting to your LLM.

Environment Setup[](#environment-setup "Permalink to this heading")
--------------------------------------------------------------------

### Find your setup information - API base, API key, deployment name (i.e. engine), etc[](#find-your-setup-information-api-base-api-key-deployment-name-i-e-engine-etc "Permalink to this heading")

To find the setup information necessary, do the following setups:

1. Go to the Azure OpenAI Studio [here](https://oai.azure.com/)
2. Go to the chat or completions playground (depending on which LLM you are setting up)
3. Click “view code” (shown in image below)


```
from IPython.display import ImageImage(filename="./azure\_playground.png")
```
![../../_images/9535be57f8835c9144da2d6e1fd0b416131c7586b97b5dd5015fb02634e0d7b1.png](../../_images/9535be57f8835c9144da2d6e1fd0b416131c7586b97b5dd5015fb02634e0d7b1.png)4. Note down the `api\_type`, `api\_base`, `api\_version`, `engine` (this should be the same as the “deployment name” from before), and the `key`


```
from IPython.display import ImageImage(filename="./azure\_env.png")
```
![../../_images/d0b2cb14bfaa4be17040ad3a200b720a95970314101b4a8d4dd8be9c205fc105.png](../../_images/d0b2cb14bfaa4be17040ad3a200b720a95970314101b4a8d4dd8be9c205fc105.png)### Configure environment variables[](#configure-environment-variables "Permalink to this heading")

Using Azure deployment of OpenAI models is very similar to normal OpenAI.You just need to configure a couple more environment variables.

* `OPENAI\_API\_VERSION`: set this to `2023-07-01-preview`This may change in the future.
* `AZURE\_OPENAI\_ENDPOINT`: your endpoint should look like the followinghttps://YOUR\_RESOURCE\_NAME.openai.azure.com/
* `OPENAI\_API\_KEY`: your API key


```
import osos.environ["OPENAI\_API\_KEY"] = "<your-api-key>"os.environ[    "AZURE\_OPENAI\_ENDPOINT"] = "https://<your-resource-name>.openai.azure.com/"os.environ["OPENAI\_API\_VERSION"] = "2023-07-01-preview"
```
Use your LLM[](#use-your-llm "Permalink to this heading")
----------------------------------------------------------


```
from llama\_index.llms import AzureOpenAI
```
Unlike normal `OpenAI`, you need to pass a `engine` argument in addition to `model`. The `engine` is the name of your model deployment you selected in Azure OpenAI Studio. See previous section on “find your setup information” for more details.


```
llm = AzureOpenAI(    engine="simon-llm", model="gpt-35-turbo-16k", temperature=0.0)
```
Alternatively, you can also skip setting environment variables, and pass the parameters in directly via constructor.


```
llm = AzureOpenAI(    engine="my-custom-llm",    model="gpt-35-turbo-16k",    temperature=0.0,    azure\_endpoint="https://<your-resource-name>.openai.azure.com/",    api\_key="<your-api-key>",    api\_version="2023-07-01-preview",)
```
Use the `complete` endpoint for text completion


```
response = llm.complete("The sky is a beautiful blue and")print(response)
```

```
the sun is shining brightly. Fluffy white clouds float lazily across the sky, creating a picturesque scene. The vibrant blue color of the sky brings a sense of calm and tranquility. It is a perfect day to be outside, enjoying the warmth of the sun and the gentle breeze. The sky seems to stretch endlessly, reminding us of the vastness and beauty of the world around us. It is a reminder to appreciate the simple pleasures in life and to take a moment to admire the natural wonders that surround us.
```

```
response = llm.stream\_complete("The sky is a beautiful blue and")for r in response:    print(r.delta, end="")
```

```
the sun is shining brightly. Fluffy white clouds float lazily across the sky, creating a picturesque scene. The vibrant blue color of the sky brings a sense of calm and tranquility. It is a perfect day to be outside, enjoying the warmth of the sun and the gentle breeze. The sky seems to stretch endlessly, reminding us of the vastness and beauty of the world around us. It is a reminder to appreciate the simple pleasures in life and to take a moment to pause and admire the natural wonders that surround us.
```
Use the `chat` endpoint for conversation


```
from llama\_index.llms import ChatMessagemessages = [    ChatMessage(        role="system", content="You are a pirate with colorful personality."    ),    ChatMessage(role="user", content="Hello"),]response = llm.chat(messages)print(response)
```

```
assistant: Ahoy there, matey! How be ye on this fine day? I be Captain Jolly Roger, the most colorful pirate ye ever did lay eyes on! What brings ye to me ship?
```

```
response = llm.stream\_chat(messages)for r in response:    print(r.delta, end="")
```

```
Ahoy there, matey! How be ye on this fine day? I be Captain Jolly Roger, the most colorful pirate ye ever did lay eyes on! What brings ye to me ship?
```
