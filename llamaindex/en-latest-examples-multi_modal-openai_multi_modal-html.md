[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/multi_modal/openai_multi_modal.ipynb)

Multi-Modal LLM using OpenAI GPT-4V model for image reasoning[](#multi-modal-llm-using-openai-gpt-4v-model-for-image-reasoning "Permalink to this heading")
============================================================================================================================================================

In this notebook, we show how to use OpenAI GPT4V MultiModal LLM class for image understanding/reasoning


```
!pip install openai matplotlib
```
Use GPT4V to understand images from urls[](#use-gpt4v-to-understand-images-from-urls "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------


```
import osOPENAI\_API\_TOKEN = ""  # Your OpenAI API token hereos.environ["OPENAI\_API\_TOKEN"] = OPENAI\_API\_TOKEN
```

```
from llama\_index.multi\_modal\_llms.openai import OpenAIMultiModalfrom llama\_index.multi\_modal\_llms.generic\_utils import (    load\_image\_urls,)image\_urls = [    "https://www.visualcapitalist.com/wp-content/uploads/2023/10/US\_Mortgage\_Rate\_Surge-Sept-11-1.jpg",    "https://www.sportsnet.ca/wp-content/uploads/2023/11/CP1688996471-1040x572.jpg",    # "https://res.cloudinary.com/hello-tickets/image/upload/c\_limit,f\_auto,q\_auto,w\_1920/v1640835927/o3pfl41q7m5bj8jardk0.jpg",    # "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg",]image\_documents = load\_image\_urls(image\_urls)openai\_mm\_llm = OpenAIMultiModal(    model="gpt-4-vision-preview", api\_key=OPENAI\_API\_TOKEN, max\_new\_tokens=300)response = openai\_mm\_llm.complete(    prompt="Describe the images as an alternative text",    image\_documents=image\_documents,)
```

```
from PIL import Imageimport requestsfrom io import BytesIOimport matplotlib.pyplot as pltimg\_response = requests.get(image\_urls[0])print(image\_urls[0])img = Image.open(BytesIO(img\_response.content))plt.imshow(img)
```

```
https://www.visualcapitalist.com/wp-content/uploads/2023/10/US_Mortgage_Rate_Surge-Sept-11-1.jpg
```

```
<matplotlib.image.AxesImage at 0x174b3b950>
```
![../../_images/76739a483d084e10bea0c3613af20aace23669a8feb942d1838fcee944f6e5ea.png](../../_images/76739a483d084e10bea0c3613af20aace23669a8feb942d1838fcee944f6e5ea.png)
```
img\_response = requests.get(image\_urls[1])print(image\_urls[1])img = Image.open(BytesIO(img\_response.content))plt.imshow(img)
```

```
https://www.sportsnet.ca/wp-content/uploads/2023/11/CP1688996471-1040x572.jpg
```

```
<matplotlib.image.AxesImage at 0x174be5050>
```
![../../_images/b4a4c67f64b2f94ee1f2abc9690e6fa58a01ed2bbbca3484af3ef059afabbd4a.png](../../_images/b4a4c67f64b2f94ee1f2abc9690e6fa58a01ed2bbbca3484af3ef059afabbd4a.png)
```
print(response)
```

```
1. The first image is a graphical representation showing the surge in US Mortgage Rates as of September 11. It likely contains charts or graphs with data points and possibly annotations to explain the trends and changes.2. The second image appears to be related to sports and features what could be athletes in action, a scoreboard, or a highlight from a sports event. The exact content isn't clear without viewing the image, but the structure of the URL suggests it may be from a sports news coverage.
```

```
response = openai\_mm\_llm.complete(    prompt="is there any relationship between those images?",    image\_documents=image\_documents,)print(response)
```

```
[{'type': 'text', 'text': 'is there any relationship between those images?'}, {'type': 'image_url', 'image_url': 'https://www.visualcapitalist.com/wp-content/uploads/2023/10/US_Mortgage_Rate_Surge-Sept-11-1.jpg'}, {'type': 'image_url', 'image_url': 'https://www.sportsnet.ca/wp-content/uploads/2023/11/CP1688996471-1040x572.jpg'}][{'role': <MessageRole.USER: 'user'>, 'content': "[{'type': 'text', 'text': 'is there any relationship between those images?'}, {'type': 'image_url', 'image_url': 'https://www.visualcapitalist.com/wp-content/uploads/2023/10/US_Mortgage_Rate_Surge-Sept-11-1.jpg'}, {'type': 'image_url', 'image_url': 'https://www.sportsnet.ca/wp-content/uploads/2023/11/CP1688996471-1040x572.jpg'}]"}]Based on the provided text and image URLs, I can't determine the direct relationship between the two images as they appear to belong to different categories. The first image URL points to a visual concerning the surge in US mortgage rates, which is likely related to finance or the economy. The second image URL leads to what seems to be a sports-related visual, possibly from Sportsnet.Unless there is a specific context or theme that connects them (e.g., the impact of economic changes on sports financing), they do not seem to be related based on the information provided.
```
Use GPT4V to understand images from local files[](#use-gpt4v-to-understand-images-from-local-files "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index import SimpleDirectoryReader# put your local directore hereimage\_documents = SimpleDirectoryReader("./images\_wiki").load\_data()response = openai\_mm\_llm.complete(    prompt="Describe the images as an alternative text",    image\_documents=image\_documents,)
```

```
{'file_path': 'images_wiki/3.jpg', 'creation_date': '2023-11-06', 'last_modified_date': '2023-10-27', 'last_accessed_date': '2023-11-07'}
```

```
from PIL import Imageimport matplotlib.pyplot as pltimg = Image.open("./images\_wiki/3.jpg")plt.imshow(img)
```

```
<matplotlib.image.AxesImage at 0x297eec110>
```
![../../_images/7e30f1faca9c19a8e8a56f9d977532a1575d42fad28d1d87a73ccdb46390ff88.png](../../_images/7e30f1faca9c19a8e8a56f9d977532a1575d42fad28d1d87a73ccdb46390ff88.png)
```
print(response)
```

```
You are looking at a close-up image of a glass Coca-Cola bottle. The label on the bottle features the iconic Coca-Cola logo with additional text underneath it commemorating the 2002 FIFA World Cup hosted by Korea/Japan. The label also indicates that the bottle contains 250 ml of the product. In the background with a shallow depth of field, you can see the blurred image of another Coca-Cola bottle, emphasizing the focus on the one in the foreground. The overall lighting and detail provide a clear view of the bottle and its labeling.
```
