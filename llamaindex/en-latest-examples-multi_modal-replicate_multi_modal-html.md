Multi-Modal LLM using Replicate LlaVa and Fuyu 8B model for image reasoning[](#multi-modal-llm-using-replicate-llava-and-fuyu-8b-model-for-image-reasoning "Permalink to this heading")
========================================================================================================================================================================================

In this notebook, we show how to use MultiModal LLM class (Llava and Fuyu 8B model from replicate) for image understanding/reasoning

**NOTE**: At the moment, the Replicate multi-modal LLMs only support one image document at a time.


```
% pip install replicate
```
Load and initialize LLava model[](#load-and-initialize-llava-model "Permalink to this heading")
------------------------------------------------------------------------------------------------


```
import osREPLICATE\_API\_TOKEN = ""  # Your Relicate API token hereos.environ["REPLICATE\_API\_TOKEN"] = REPLICATE\_API\_TOKEN
```

```
from PIL import Imageimport requestsfrom io import BytesIOfrom llama\_index.multi\_modal\_llms.generic\_utils import (    load\_image\_urls,)from llama\_index.schema import ImageDocumentif not os.path.exists("test\_images"):    os.makedirs("test\_images")# for now fuyu-8b model on replicate can mostly handle JPG image urls well instead of local filesimage\_urls = [    # "https://www.visualcapitalist.com/wp-content/uploads/2023/10/US\_Mortgage\_Rate\_Surge-Sept-11-1.jpg",    "https://www.sportsnet.ca/wp-content/uploads/2023/11/CP1688996471-1040x572.jpg",    "https://res.cloudinary.com/hello-tickets/image/upload/c\_limit,f\_auto,q\_auto,w\_1920/v1640835927/o3pfl41q7m5bj8jardk0.jpg",    "https://www.cleverfiles.com/howto/wp-content/uploads/2018/03/minion.jpg",]# save imagesfor idx, image\_url in enumerate(image\_urls):    response = requests.get(image\_url)    img = Image.open(BytesIO(response.content))    img.save(f"test\_images/{idx}.png")# option 1: load images from urls directly# image\_documents = load\_image\_urls(image\_urls)# option 2: load images from localimage\_documents = [    ImageDocument(image\_path=f"test\_images/{idx}.png")    for idx in range(len(image\_urls))]
```

```
import matplotlib.pyplot as pltimg = Image.open(open("test\_images/0.png", "rb"))plt.imshow(img)plt.xticks([])plt.yticks([])plt.tight\_layout()
```
![../../_images/a12a7fda7b7dce548e647182dd0a50a0e4b45a56045fc0d6741a36461cd77bd2.png](../../_images/a12a7fda7b7dce548e647182dd0a50a0e4b45a56045fc0d6741a36461cd77bd2.png)
```
from llama\_index.multi\_modal\_llms import ReplicateMultiModalllava\_multi\_modal\_llm = ReplicateMultiModal(    model="yorickvp/llava-13b:2facb4a474a0462c15041b78b1ad70952ea46b5ec6ad29583c0b29dbd4249591",    max\_new\_tokens=100,    temperature=0.1,    num\_input\_files=1,)llava\_resp = llava\_multi\_modal\_llm.complete(    prompt="what is shown in this image?",    image\_documents=[image\_documents[0]],)
```

```
print(llava\_resp)
```

```
The image shows a man holding a trophy, which appears to be a gold soccer ball. He is dressed in a suit and tie, and he is smiling.
```
Load and initialize Fuyu-8B model[](#load-and-initialize-fuyu-8b-model "Permalink to this heading")
----------------------------------------------------------------------------------------------------


```
# for now fuyu-8b model on replicate can mostly handle JPG image urls well instead of local filesimage\_documents = load\_image\_urls(image\_urls)
```

```
fuyu\_multi\_modal\_llm = ReplicateMultiModal(    model="lucataco/fuyu-8b:42f23bc876570a46f5a90737086fbc4c3f79dd11753a28eaa39544dd391815e9",    max\_new\_tokens=100,    temperature=0.1,    num\_input\_files=1,)fuyu\_resp = fuyu\_multi\_modal\_llm.complete(    prompt="what is shown in this image?",    image\_documents=[image\_documents[1]],)
```

```
response = requests.get(image\_urls[1])img = Image.open(BytesIO(response.content))plt.imshow(img)
```

```
<matplotlib.image.AxesImage at 0x15a883550>
```
![../../_images/e60e626643c7ddca79139263675d76dd40e491d21e7abadd97e2527f54458d79.png](../../_images/e60e626643c7ddca79139263675d76dd40e491d21e7abadd97e2527f54458d79.png)
```
# Show the image reasoining result from Fuyu 8B modelprint(fuyu\_resp)
```

```
 The image showcases a city street at night, with colorful lights illuminating the scene. The street is lined with buildings, including a prominent Roman-style amphitheater.
```
