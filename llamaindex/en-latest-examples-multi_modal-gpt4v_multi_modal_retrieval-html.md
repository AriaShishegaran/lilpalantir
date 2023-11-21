[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/multi_modal/gpt4v_multi_modal_retrieval.ipynb)

Advanced Multi-Modal Retrieval using GPT4V and Multi-Modal Index/Retriever[](#advanced-multi-modal-retrieval-using-gpt4v-and-multi-modal-index-retriever "Permalink to this heading")
======================================================================================================================================================================================

In this notebook, we show how to build a Multi-Modal retrieval system using LlamaIndex with GPT4-V and CLIP.

LlamaIndex Multi-Modal Retrieval

* Text embedding index: Generate GPT text embeddings
* Images embedding index: [CLIP](https://github.com/openai/CLIP) embeddings from OpenAI for images

Encoding queries:

* Encode query text for text index using ada
* Encode query text for image index using CLIP

Framework: [LlamaIndex](https://github.com/run-llama/llama_index)

Steps:

1. Using Multi-Modal LLM GPT4V class to undertand multiple images
2. Download texts, images, pdf raw files from related Wikipedia articles and SEC 10K report
3. Build Multi-Modal index and vetor store for both texts and images
4. Retrieve relevant text and image simultaneously using Multi-Modal Retriver according to the image reasoning from Step 1


```
%pip install llama_index ftfy regex tqdm%pip install git+https://github.com/openai/CLIP.git%pip install torch torchvision%pip install matplotlib scikit-image%pip install -U qdrant_client
```

```
import osOPENAI\_API\_TOKEN = ""os.environ["OPENAI\_API\_KEY"] = OPENAI\_API\_TOKEN
```
Download images from Tesla website for GPT4V image reasoning[](#download-images-from-tesla-website-for-gpt4v-image-reasoning "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------------------------


```
from pathlib import Pathinput\_image\_path = Path("input\_images")if not input\_image\_path.exists():    Path.mkdir(input\_image\_path)
```

```
!wget "https://docs.google.com/uc?export=download&id=1nUhsBRiSWxcVQv8t8Cvvro8HJZ88LCzj" -O ./input_images/long_range_spec.png!wget "https://docs.google.com/uc?export=download&id=19pLwx0nVqsop7lo0ubUSYTzQfMtKJJtJ" -O ./input_images/model_y.png!wget "https://docs.google.com/uc?export=download&id=1utu3iD9XEgR5Sb7PrbtMf1qw8T1WdNmF" -O ./input_images/performance_spec.png!wget "https://docs.google.com/uc?export=download&id=1dpUakWMqaXR4Jjn1kHuZfB0pAXvjn2-i" -O ./input_images/price.png!wget "https://docs.google.com/uc?export=download&id=1qNeT201QAesnAP5va1ty0Ky5Q\_jKkguV" -O ./input_images/real_wheel_spec.png
```
Generate image reasoning from GPT4V Multi-Modal LLM[](#generate-image-reasoning-from-gpt4v-multi-modal-llm "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------------------

### Plot input images[](#plot-input-images "Permalink to this heading")


```
from PIL import Imageimport matplotlib.pyplot as pltimport osimage\_paths = []for img\_path in os.listdir("./input\_images"):    image\_paths.append(str(os.path.join("./input\_images", img\_path)))def plot\_images(image\_paths):    images\_shown = 0    plt.figure(figsize=(16, 9))    for img\_path in image\_paths:        if os.path.isfile(img\_path):            image = Image.open(img\_path)            plt.subplot(2, 3, images\_shown + 1)            plt.imshow(image)            plt.xticks([])            plt.yticks([])            images\_shown += 1            if images\_shown >= 9:                breakplot\_images(image\_paths)
```
![../../_images/17be3842fc1709301891eb02aaf10ad25c0cfb8a39a33b75e6e5ea1d8dfa1f5c.png](../../_images/17be3842fc1709301891eb02aaf10ad25c0cfb8a39a33b75e6e5ea1d8dfa1f5c.png)### Using GPT4V to understand those input images[](#using-gpt4v-to-understand-those-input-images "Permalink to this heading")


```
from llama\_index.multi\_modal\_llms.openai import OpenAIMultiModalfrom llama\_index import SimpleDirectoryReader# put your local directore hereimage\_documents = SimpleDirectoryReader("./input\_images").load\_data()openai\_mm\_llm = OpenAIMultiModal(    model="gpt-4-vision-preview", api\_key=OPENAI\_API\_TOKEN, max\_new\_tokens=1500)response\_1 = openai\_mm\_llm.complete(    prompt="Describe the images as an alternative text",    image\_documents=image\_documents,)print(response\_1)
```

```
The images depict information and specifications about electric vehicles, presumably from a car manufacturer's website.Image 1:This image contains text that lists specifications for two different car models, one with Rear-Wheel Drive and the other with Long Range AWD (All-Wheel Drive). Categories covered include Battery, Weight, Acceleration, Range, Top Speed, Drive, Seating, Wheels, and Warranty.Image 2:This image shows a cutaway illustration of an electric vehicle highlighting its structural components. The car is rendered to show its internal features such as rigid structure and impact protection zones.Image 3:Similar to the first image, this image contains text showing specifications for two variants of what appears to be the same model of electric vehicle, with one being a performance model and the other Long Range AWD. The specs include Battery, Acceleration, Range, Drive, Seating, Wheels, Display, Tire Type, Supercharging Max/Power, and Warranty.Image 4:The image presents pricing and potential savings information for different variants of an electric vehicle model. It includes a federal incentive notice, an area to enter a delivery postal code, purchase price for different versions (Model Y Rear-Wheel Drive, Model Y Long Range, Model Y Performance), and additional feature details. There's also a note about potential savings over gas at the bottom.Image 5:This image lists specifications for electric vehicles, focused on two categories: Performance and Long Range AWD. Specs listed include Battery, Acceleration, Range, Top Speed, Drive, Seating, Wheels, Display, Tire Type, Supercharging Max/Power, and Warranty.Each of these images would be used to provide customers with information regarding electric car models, their features, capabilities, pricing, and potential savings.
```

```
response\_2 = openai\_mm\_llm.complete(    prompt="Can you tell me what is the price with each spec?",    image\_documents=image\_documents,)print(response\_2)
```

```
The images you've provided appear to be from a car manufacturer's website, showing different specifications for an electric vehicle and the associated prices for different trim levels or configurations of the vehicle. However, since the actual text content for the price per specification is not fully legible in the images provided, I can't give you precise pricing information. Generally, these types of websites often list the following trims with increasing features and therefore increasing prices:1. Rear-Wheel Drive (Standard Range or Long Range)2. Dual Motor All-Wheel Drive (often dubbed Long Range AWD)3. Performance (typically comes with the most features and fastest acceleration)Features like acceleration times, range, top speed, curb weight, cargo volume, seating capacity, display type, drive type, wheels size, warranty, and others can vary by trim level. The images show that there are different specs for the "Performance" and "Long Range AWD" trims such as acceleration, range, top speed, and potentially others related to power and luxury features.The final image provided shows some pricing details:- Model 3 Rear-Wheel Drive: $57,990- Model 3 Dual Motor All-Wheel Drive: $67,990- Model 3 Performance: $74,990These prices might be eligible for certain incentives, as indicated by a "$5,000 Federal Incentive" notice, which would effectively reduce the purchase price, though this depends on individual eligibility and local laws.Please proactively check the manufacturer’s website or reach out to an official dealership for the most accurate and up-to-date information regarding pricing and specifications for these vehicle trims.
```
Generating text, pdf, images data from raw files [Wikipedia, SEC files] for Multi Modal Index/Retrieval[](#generating-text-pdf-images-data-from-raw-files-wikipedia-sec-files-for-multi-modal-index-retrieval "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


```
def get\_wikipedia\_images(title):    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "imageinfo",            "iiprop": "url|dimensions|mime",            "generator": "images",            "gimlimit": "50",        },    ).json()    image\_urls = []    for page in response["query"]["pages"].values():        if page["imageinfo"][0]["url"].endswith(".jpg") or page["imageinfo"][            0        ]["url"].endswith(".png"):            image\_urls.append(page["imageinfo"][0]["url"])    return image\_urls
```

```
from pathlib import Pathimport requestsimport urllib.requestimage\_uuid = 0# image\_metadata\_dict stores images metadata including image uuid, filename and pathimage\_metadata\_dict = {}MAX\_IMAGES\_PER\_WIKI = 20wiki\_titles = {    "Tesla Model Y",    "Tesla Model X",    "Tesla Model 3",    "Tesla Model S",    "Kia EV6",    "BMW i3",    "Audi e-tron",    "Ford Mustang",    "Porsche Taycan",    "Rivian",    "Polestar",}data\_path = Path("mixed\_wiki")if not data\_path.exists():    Path.mkdir(data\_path)for title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)    images\_per\_wiki = 0    try:        # page\_py = wikipedia.page(title)        list\_img\_urls = get\_wikipedia\_images(title)        # print(list\_img\_urls)        for url in list\_img\_urls:            if (                url.endswith(".jpg")                or url.endswith(".png")                or url.endswith(".svg")            ):                image\_uuid += 1                # image\_file\_name = title + "\_" + url.split("/")[-1]                urllib.request.urlretrieve(                    url, data\_path / f"{image\_uuid}.jpg"                )                images\_per\_wiki += 1                # Limit the number of images downloaded per wiki page to 15                if images\_per\_wiki > MAX\_IMAGES\_PER\_WIKI:                    break    except:        print(str(Exception("No images found for Wikipedia page: ")) + title)        continue
```

```
!wget "https://www.dropbox.com/scl/fi/mlaymdy1ni1ovyeykhhuk/tesla\_2021\_10k.htm?rlkey=qf9k4zn0ejrbm716j0gg7r802&dl=1" -O ./mixed_wiki/tesla_2021_10k.htm
```
Build Multi-modal index and vector store to index both text and images[](#build-multi-modal-index-and-vector-store-to-index-both-text-and-images "Permalink to this heading")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


```
from llama\_index.indices.multi\_modal.base import MultiModalVectorStoreIndexfrom llama\_index.vector\_stores import QdrantVectorStorefrom llama\_index import SimpleDirectoryReader, StorageContextimport qdrant\_clientfrom llama\_index import (    SimpleDirectoryReader,)# Create a local Qdrant vector storeclient = qdrant\_client.QdrantClient(path="qdrant\_mm\_db")text\_store = QdrantVectorStore(    client=client, collection\_name="text\_collection")image\_store = QdrantVectorStore(    client=client, collection\_name="image\_collection")storage\_context = StorageContext.from\_defaults(vector\_store=text\_store)# Create the MultiModal indexdocuments = SimpleDirectoryReader("./mixed\_wiki/").load\_data()index = MultiModalVectorStoreIndex.from\_documents(    documents, storage\_context=storage\_context, image\_vector\_store=image\_store)# Save it# index.storage\_context.persist(persist\_dir="./storage")# # Load it# from llama\_index import load\_index\_from\_storage# storage\_context = StorageContext.from\_defaults(# vector\_store=text\_store, persist\_dir="./storage"# )# index = load\_index\_from\_storage(storage\_context, image\_store=image\_store)
```

```
print(response\_2.text)
```
Retrieve and query texts and images from our Multi-Modal Index[](#retrieve-and-query-texts-and-images-from-our-multi-modal-index "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------------------------------

We show two examples leveraging multi-modal retrieval.

1. **Retrieval-Augmented Captioning**: In the first example, we perform multi-modal retrieval based on an existing image caption, to return more relevant context. We can then continue to query the LLM for related vehicles.
2. **Multi-modal RAG Querying**: In the second example, given a user-query, we first retrieve a mix of both text and images, and feed it to an LLM for synthesis.

### 1. Retrieval-Augmented Captioning[](#retrieval-augmented-captioning "Permalink to this heading")


```
# generate Text retrieval resultsMAX\_TOKENS = 50retriever\_engine = index.as\_retriever(    similarity\_top\_k=3, image\_similarity\_top\_k=3)# retrieve more information from the GPT4V responseretrieval\_results = retriever\_engine.retrieve(response\_2.text[:MAX\_TOKENS])
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodefrom llama\_index.schema import ImageNoderetrieved\_image = []for res\_node in retrieval\_results:    if isinstance(res\_node.node, ImageNode):        retrieved\_image.append(res\_node.node.metadata["file\_path"])    else:        display\_source\_node(res\_node, source\_length=200)plot\_images(retrieved\_image)
```
**Node ID:** 8a67ab30-545c-46ee-a25f-64c95a4571be  
**Similarity:** 0.7758026357212682  
**Text:** == Reception ==Consumer Reports wrote that the all-wheel-drive Model X 90D largely disappoints, as rear doors are prone to pausing and stopping, the second-row seats that cannot be folded, and the…  


**Node ID:** 5db1e928-197d-41d4-b1c1-34d2bcf1cc4d  
**Similarity:** 0.7712850768830459  
**Text:** == Design and technology ==

=== Body and chassis ===The i3 was the first mass production car with most of its internal structure and body made of carbon-fiber reinforced plastic (CFRP). BMW took…  


**Node ID:** 89e533c6-3e25-4933-b58a-7d42ac67e957  
**Similarity:** 0.768609543932987  
**Text:** === Autoshift ===Introduced in mid-2021, the Plaid and Long Range versions of the Model S feature no steering column-mounted shift stalk; instead, the Model S uses cameras to infer whether to shif…  


![../../_images/58e88086d453684215d4ce66d9b08d463f969cb237d55a9edd7df928348adcd6.png](../../_images/58e88086d453684215d4ce66d9b08d463f969cb237d55a9edd7df928348adcd6.png)
```
response\_3 = openai\_mm\_llm.complete(    prompt="what are other similar cars?",    image\_documents=image\_documents,)print(response\_3)
```

```
The images provided show information about electric vehicles, specifically the Model Y. This is a compact crossover SUV from a prominent electric vehicle manufacturer. When considering similar vehicles in the electric automobile market, you might want to look at the following models that offer comparable characteristics, in terms of performance, size, and luxury:1. Tesla Model 3 - A smaller sedan from the same manufacturer with similar technology and performance capabilities.2. Chevrolet Bolt EUV - A compact electric SUV with semi-autonomous driving capabilities.3. Ford Mustang Mach-E - An all-electric SUV that offers performance and technology options.4. Volkswagen ID.4 - An electric SUV with a focus on interior space and comfort.5. Hyundai Kona Electric - A compact electric SUV with a competitive range and features.6. Kia EV6 - An electric crossover with a sporty design and good performance metrics.7. Audi Q4 e-tron - A luxury compact electric SUV with a focus on performance and high-end features.8. Volvo XC40 Recharge - An electric version of Volvo's popular compact SUV with an emphasis on safety and Scandinavian design.Each of these vehicles offers a different mix of range, performance, interior space, technology, and price. When comparing them to the Model Y specifications seen in the images, factors such as acceleration, range, weight, cargo volume, and top speed can be used to evaluate their similarities and differences. Keep in mind that new electric vehicle models are continuously being released, so it's always good to check the latest offerings for the most current comparisons.
```
### 2. Multi-Modal RAG Querying[](#multi-modal-rag-querying "Permalink to this heading")


```
from llama\_index.prompts import PromptTemplatefrom llama\_index.query\_engine import SimpleMultiModalQueryEngineqa\_tmpl\_str = (    "Context information is below.\n"    "---------------------\n"    "{context\_str}\n"    "---------------------\n"    "Given the context information and not prior knowledge, "    "answer the query.\n"    "Query: {query\_str}\n"    "Answer: ")qa\_tmpl = PromptTemplate(qa\_tmpl\_str)query\_engine = index.as\_query\_engine(    multi\_modal\_llm=openai\_mm\_llm, text\_qa\_template=qa\_tmpl)query\_str = "Tell me more about the Porsche"response = query\_engine.query(query\_str)
```

```
print(str(response))
```

```
The Porsche Taycan represents a significant step for Porsche as their first series production electric car. The Taycan model line includes a diverse range of variants: from the more affordable base rear-wheel-drive (RWD) model to the high-performance all-wheel-drive (AWD) Turbo and Turbo S models. The Taycan is not limited to just the 4-door saloon format but has expanded to include estate variations such as the Taycan Cross Turismo and the Taycan Sport Turismo.The interior of the Taycan is a showcase of Porsche's commitment to modernity and technology, with up to four digital displays for instrumentation and infotainment, while still retaining iconic features like the classic Porsche clock. The exterior design is a tribute to Porsche's heritage with contemporary touches, maintaining the brand's visual language.Performance-wise, the Taycan offers different power options, with the most powerful Turbo and Turbo S variants reaching 460 kW (617 hp) under specific conditions like overboost power with launch control mode. The Taycan's design incorporates advanced features like a retractable rear spoiler and door handles, and it utilizes a regenerative braking system to optimize efficiency.The Taycan has not only impressed customers and the automotive market but has also earned accolades from prestigious entities, with the 4S model being named Performance Car of the Year by What Car? magazine, and the Taycan Cross Turismo gaining recognition as Best Estate in the Top Gear Electric Awards.Moreover, the concept cars that previewed the Taycan, specifically the Porsche Mission E and the Mission E Cross Turismo, pointed toward Porsche's electric future and set a benchmark in the electric vehicle market for design and performance expectations. The Mission E concept set ambitious goals for range and charging time, leveraging an 800 V DC system voltage for rapid charging capabilities.Overall, the Porsche Taycan is a blend of traditional Porsche DNA and forward-looking electric vehicle technology, epitomizing high performance, luxury, and sustainability in a package that appeals to both loyal customers and a new generation seeking electric alternatives.
```

```
# show sourcesfrom llama\_index.response.notebook\_utils import display\_source\_nodefor text\_node in response.metadata["text\_nodes"]:    display\_source\_node(text\_node, source\_length=200)plot\_images(    [n.metadata["file\_path"] for n in response.metadata["image\_nodes"]])
```
**Node ID:** c9dac736-51ce-429a-9b77-96c95a00d91f  
**Similarity:** 0.8241315758378377  
**Text:** == Models ==The Taycan is currently offered as a 4-door saloon model and a 4-door estate model, the Taycan Cross Turismo. Other planned variants include a two-door coupe and convertible models, wh…  


**Node ID:** 531c87f5-fcc4-453e-a013-fa6c9a3a7d24  
**Similarity:** 0.822575963523647  
**Text:** The Porsche Taycan is a battery electric saloon and shooting brake produced by German automobile manufacturer Porsche. The concept version of the Taycan, named the Porsche Mission E, debuted at the…  


![../../_images/1d596bacb3de1f053814f4c9b320c948709d805da1e001d4204f7e8de1efcd8a.png](../../_images/1d596bacb3de1f053814f4c9b320c948709d805da1e001d4204f7e8de1efcd8a.png)