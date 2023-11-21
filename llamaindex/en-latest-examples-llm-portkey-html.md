[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/llm/portkey.ipynb)

Portkey[](#portkey "Permalink to this heading")
================================================

**Portkey** is a full-stack LLMOps platform that productionizes your Gen AI app reliably and securely.

Key Features of Portkey’s Integration with Llamaindex:[](#key-features-of-portkey-s-integration-with-llamaindex "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------------------------

![header](https://3798672042-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FeWEp2XRBGxs7C1jgAdk7%2Fuploads%2FjDGBQvw5aFOCqctr0xwp%2FColab%20Version%202.png?alt=media&token=16057c99-b86c-416c-932e-c2b71549c506)1. **[🚪 AI Gateway](#%F0%9F%94%81-implementing-fallbacks-and-retries-with-portkey)**:


	* **[Automated Fallbacks & Retries](#%F0%9F%94%81-implementing-fallbacks-and-retries-with-portkey)**: Ensure your application remains functional even if a primary service fails.
	* **[Load Balancing](#%E2%9A%96%EF%B8%8F-implementing-load-balancing-with-portkey)**: Efficiently distribute incoming requests among multiple models.
	* **[Semantic Caching](#%F0%9F%A7%A0-implementing-semantic-caching-with-portkey)**: Reduce costs and latency by intelligently caching results.
2. **[🔬 Observability](#%F0%9F%94%AC-observability-with-portkey)**:


	* **Logging**: Keep track of all requests for monitoring and debugging.
	* **Requests Tracing**: Understand the journey of each request for optimization.
	* **Custom Tags**: Segment and categorize requests for better insights.
3. **[📝 Continuous Improvement with User Feedback](#%F0%9F%93%9D-feedback-with-portkey)**:


	* **Feedback Collection**: Seamlessly gather feedback on any served request, be it on a generation or conversation level.
	* **Weighted Feedback**: Obtain nuanced information by attaching weights to user feedback values.
	* **Feedback Metadata**: Incorporate custom metadata with the feedback to provide context, allowing for richer insights and analyses.
4. **[🔑 Secure Key Management](#feedback-with-portkey)**:


	* **Virtual Keys**: Portkey transforms original provider keys into virtual keys, ensuring your primary credentials remain untouched.
	* **Multiple Identifiers**: Ability to add multiple keys for the same provider or the same key under different names for easy identification without compromising security.

To harness these features, let’s start with the setup:

[![\"Open](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/portkey.ipynb)If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
# Installing Llamaindex & Portkey SDK!pip install -U llama_index!pip install -U portkey-ai# Importing necessary libraries and modulesfrom llama\_index.llms import Portkey, ChatMessageimport portkey as pk
```
You do not need to install **any** other SDKs or import them in your Llamaindex app.

**Step 1️⃣: Get your Portkey API Key and your Virtual Keys for OpenAI, Anthropic, and more**[](#step-1-get-your-portkey-api-key-and-your-virtual-keys-for-openai-anthropic-and-more "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**[Portkey API Key](https://app.portkey.ai/)**: Log into [Portkey here](https://app.portkey.ai/), then click on the profile icon on top left and “Copy API Key”.


```
import osos.environ["PORTKEY\_API\_KEY"] = "PORTKEY\_API\_KEY"
```
**[Virtual Keys](https://docs.portkey.ai/key-features/ai-provider-keys)**

1. Navigate to the “Virtual Keys” page on [Portkey dashboard](https://app.portkey.ai/) and hit the “Add Key” button located at the top right corner.
2. Choose your AI provider (OpenAI, Anthropic, Cohere, HuggingFace, etc.), assign a unique name to your key, and, if needed, jot down any relevant usage notes. Your virtual key is ready!

![header](https://3798672042-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FeWEp2XRBGxs7C1jgAdk7%2Fuploads%2F66S1ik16Gle8jS1u6smr%2Fvirtual_keys.png?alt=media&token=2fec1c39-df4e-4c93-9549-7445a833321c)3. Now copy and paste the keys below - you can use them anywhere within the Portkey ecosystem and keep your original key secure and untouched.
```
openai\_virtual\_key\_a = ""openai\_virtual\_key\_b = ""anthropic\_virtual\_key\_a = ""anthropic\_virtual\_key\_b = ""cohere\_virtual\_key\_a = ""cohere\_virtual\_key\_b = ""
```
If you don’t want to use Portkey’s Virtual keys, you can also use your AI provider keys directly.


```
os.environ["OPENAI\_API\_KEY"] = ""os.environ["ANTHROPIC\_API\_KEY"] = ""
```
**Step 2️⃣: Configure Portkey Features**[](#step-2-configure-portkey-features "Permalink to this heading")
-----------------------------------------------------------------------------------------------------------

To harness the full potential of Portkey’s integration with Llamaindex, you can configure various features as illustrated above. Here’s a guide to all Portkey features and the expected values:



| Feature | Config Key | Value(Type) | Required |
| --- | --- | --- | --- |
| API Key | `api\_key` | `string` | ✅ Required (can be set externally) |
| Mode | `mode` | `fallback`, `loadbalance`, `single` | ✅ Required |
| Cache Type | `cache\_status` | `simple`, `semantic` | ❔ Optional |
| Force Cache Refresh | `cache\_force\_refresh` | `True`, `False` | ❔ Optional |
| Cache Age | `cache\_age` | `integer` (in seconds) | ❔ Optional |
| Trace ID | `trace\_id` | `string` | ❔ Optional |
| Retries | `retry` | `integer` [0,5] | ❔ Optional |
| Metadata | `metadata` | `json object` [More info](https://docs.portkey.ai/key-features/custom-metadata) | ❔ Optional |
| Base URL | `base\_url` | `url` | ❔ Optional |

* `api\_key` and `mode` are required values.
* You can set your Portkey API key using the Portkey constructor or you can also set it as an environment variable.
* There are **3** modes - Single, Fallback, Loadbalance.


	+ **Single** - This is the standard mode. Use it if you do not want Fallback OR Loadbalance features.
	+ **Fallback** - Set this mode if you want to enable the Fallback feature. [Check out the guide here](#implementing-fallbacks-and-retries-with-portkey).
	+ **Loadbalance** - Set this mode if you want to enable the Loadbalance feature. [Check out the guide here](#implementing-load-balancing-with-portkey).

Here’s an example of how to set up some of these features:


```
portkey\_client = Portkey(    mode="single",)# Since we have defined the Portkey API Key with os.environ, we do not need to set api\_key again here
```
**Step 3️⃣: Constructing the LLM**[](#step-3-constructing-the-llm "Permalink to this heading")
-----------------------------------------------------------------------------------------------

With the Portkey integration, constructing an LLM is simplified. Use the `LLMOptions` function for all providers, with the exact same keys you’re accustomed to in your OpenAI or Anthropic constructors. The only new key is `weight`, essential for the load balancing feature.


```
openai\_llm = pk.LLMOptions(    provider="openai",    model="gpt-4",    virtual\_key=openai\_virtual\_key\_a,)
```
The above code illustrates how to utilize the `LLMOptions` function to set up an LLM with the OpenAI provider and the GPT-4 model. This same function can be used for other providers as well, making the integration process streamlined and consistent across various providers.

**Step 4️⃣: Activate the Portkey Client**[](#step-4-activate-the-portkey-client "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------

Once you’ve constructed the LLM using the `LLMOptions` function, the next step is to activate it with Portkey. This step is essential to ensure that all the Portkey features are available for your LLM.


```
portkey\_client.add\_llms(openai\_llm)
```
And, that’s it! In just 4 steps, you have infused your Llamaindex app with sophisticated production capabilities.

**🔧 Testing the Integration**[](#testing-the-integration "Permalink to this heading")
--------------------------------------------------------------------------------------

Let’s ensure that everything is set up correctly. Below, we create a simple chat scenario and pass it through our Portkey client to see the response.


```
messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="What can you do?"),]print("Testing Portkey Llamaindex integration:")response = portkey\_client.chat(messages)print(response)
```
Here’s how your logs will appear on your [Portkey dashboard](https://app.portkey.ai/):

![Logs](https://portkey.ai/blog/content/images/2023/09/Log-1.png)**⏩ Streaming Responses**[](#streaming-responses "Permalink to this heading")
------------------------------------------------------------------------------

With Portkey, streaming responses has never been more straightforward. Portkey has 4 response functions:

1. `.complete(prompt)`
2. `.stream\_complete(prompt)`
3. `.chat(messages)`
4. `.stream\_chat(messages)`

While the `complete` function expects a string input(`str`), the `chat` function works with an array of `ChatMessage` objects.

**Example usage:**


```
# Let's set up a prompt and then use the stream\_complete function to obtain a streamed response.prompt = "Why is the sky blue?"print("\nTesting Stream Complete:\n")response = portkey\_client.stream\_complete(prompt)for i in response:    print(i.delta, end="", flush=True)# Let's prepare a set of chat messages and then utilize the stream\_chat function to achieve a streamed chat response.messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="What can you do?"),]print("\nTesting Stream Chat:\n")response = portkey\_client.stream\_chat(messages)for i in response:    print(i.delta, end="", flush=True)
```
**🔍 Recap and References**[](#recap-and-references "Permalink to this heading")
--------------------------------------------------------------------------------

Congratulations! 🎉 You’ve successfully set up and tested the Portkey integration with Llamaindex. To recap the steps:

1. pip install portkey-ai
2. from llama\_index.llms import Portkey
3. Grab your Portkey API Key and create your virtual provider keys from [here](https://app.portkey.ai/).
4. Construct your Portkey client and set mode: `portkey\_client=Portkey(mode="fallback")`
5. Construct your provider LLM with LLMOptions: `openai\_llm = pk.LLMOptions(provider="openai", model="gpt-4", virtual\_key=openai\_key\_a)`
6. Add the LLM to Portkey with `portkey\_client.add\_llms(openai\_llm)`
7. Call the Portkey methods regularly like you would any other LLM, with `portkey\_client.chat(messages)`

Here’s the guide to all the functions and their params:

* [Portkey LLM Constructor](#step-2-add-all-the-portkey-features-you-want-as-illustrated-below-by-calling-the-portkey-class)
* [LLMOptions Constructor](https://github.com/Portkey-AI/rubeus-python-sdk/blob/4cf3e17b847225123e92f8e8467b41d082186d60/rubeus/api_resources/utils.py#L179)
* [List of Portkey + Llamaindex Features](#portkeys-integration-with-llamaindex-adds-the-following-production-capabilities-to-your-apps-out-of-the-box)

[![\"Open](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/llm/portkey.ipynb)**🔁 Implementing Fallbacks and Retries with Portkey**[](#implementing-fallbacks-and-retries-with-portkey "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------------------------------

Fallbacks and retries are essential for building resilient AI applications. With Portkey, implementing these features is straightforward:

* **Fallbacks**: If a primary service or model fails, Portkey will automatically switch to a backup model.
* **Retries**: If a request fails, Portkey can be configured to retry the request multiple times.

Below, we demonstrate how to set up fallbacks and retries using Portkey:


```
portkey\_client = Portkey(mode="fallback")messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="What can you do?"),]llm1 = pk.LLMOptions(    provider="openai",    model="gpt-4",    retry\_settings={"on\_status\_codes": [429, 500], "attempts": 2},    virtual\_key=openai\_virtual\_key\_a,)llm2 = pk.LLMOptions(    provider="openai",    model="gpt-3.5-turbo",    virtual\_key=openai\_virtual\_key\_b,)portkey\_client.add\_llms(llm\_params=[llm1, llm2])print("Testing Fallback & Retry functionality:")response = portkey\_client.chat(messages)print(response)
```
**⚖️ Implementing Load Balancing with Portkey**[](#implementing-load-balancing-with-portkey "Permalink to this heading")
-------------------------------------------------------------------------------------------------------------------------

Load balancing ensures that incoming requests are efficiently distributed among multiple models. This not only enhances the performance but also provides redundancy in case one model fails.

With Portkey, implementing load balancing is simple. You need to:

* Define the `weight` parameter for each LLM. This weight determines how requests are distributed among the LLMs.
* Ensure that the sum of weights for all LLMs equals 1.

Here’s an example of setting up load balancing with Portkey:


```
portkey\_client = Portkey(mode="ab\_test")messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="What can you do?"),]llm1 = pk.LLMOptions(    provider="openai",    model="gpt-4",    virtual\_key=openai\_virtual\_key\_a,    weight=0.2,)llm2 = pk.LLMOptions(    provider="openai",    model="gpt-3.5-turbo",    virtual\_key=openai\_virtual\_key\_a,    weight=0.8,)portkey\_client.add\_llms(llm\_params=[llm1, llm2])print("Testing Loadbalance functionality:")response = portkey\_client.chat(messages)print(response)
```
**🧠 Implementing Semantic Caching with Portkey**[](#implementing-semantic-caching-with-portkey "Permalink to this heading")
----------------------------------------------------------------------------------------------------------------------------

Semantic caching is a smart caching mechanism that understands the context of a request. Instead of caching based solely on exact input matches, semantic caching identifies similar requests and serves cached results, reducing redundant requests and improving response times as well as saving money.

Let’s see how to implement semantic caching with Portkey:


```
import timeportkey\_client = Portkey(mode="single")openai\_llm = pk.LLMOptions(    provider="openai",    model="gpt-3.5-turbo",    virtual\_key=openai\_virtual\_key\_a,    cache\_status="semantic",)portkey\_client.add\_llms(openai\_llm)current\_messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="What are the ingredients of a pizza?"),]print("Testing Portkey Semantic Cache:")start = time.time()response = portkey\_client.chat(current\_messages)end = time.time() - startprint(response)print(f"{'-'\*50}\nServed in {end} seconds.\n{'-'\*50}")new\_messages = [    ChatMessage(role="system", content="You are a helpful assistant"),    ChatMessage(role="user", content="Ingredients of pizza"),]print("Testing Portkey Semantic Cache:")start = time.time()response = portkey\_client.chat(new\_messages)end = time.time() - startprint(response)print(f"{'-'\*50}\nServed in {end} seconds.\n{'-'\*50}")
```
Portkey’s cache supports two more cache-critical functions - Force Refresh and Age.

`cache\_force\_refresh`: Force-send a request to your provider instead of serving it from a cache.`cache\_age`: Decide the interval at which the cache store for this particular string should get automatically refreshed. The cache age is set in seconds.

Here’s how you can use it:


```
# Setting the cache status as `semantic` and cache\_age as 60s.openai\_llm = pk.LLMOptions(    provider="openai",    model="gpt-3.5-turbo",    virtual\_key=openai\_virtual\_key\_a,    cache\_force\_refresh=True,    cache\_age=60,)
```
**🔬 Observability with Portkey**[](#observability-with-portkey "Permalink to this heading")
--------------------------------------------------------------------------------------------

Having insight into your application’s behavior is paramount. Portkey’s observability features allow you to monitor, debug, and optimize your AI applications with ease. You can track each request, understand its journey, and segment them based on custom tags. This level of detail can help in identifying bottlenecks, optimizing costs, and enhancing the overall user experience.

Here’s how to set up observability with Portkey:


```
metadata = {    "\_environment": "production",    "\_prompt": "test",    "\_user": "user",    "\_organisation": "acme",}trace\_id = "llamaindex\_portkey"portkey\_client = Portkey(mode="single")openai\_llm = pk.LLMOptions(    provider="openai",    model="gpt-3.5-turbo",    virtual\_key=openai\_virtual\_key\_a,    metadata=metadata,    trace\_id=trace\_id,)portkey\_client.add\_llms(openai\_llm)print("Testing Observability functionality:")response = portkey\_client.chat(messages)print(response)
```
**🌉 Open Source AI Gateway**[](#open-source-ai-gateway "Permalink to this heading")
------------------------------------------------------------------------------------

Portkey’s AI Gateway uses the [open source project Rubeus](https://github.com/portkey-ai/rubeus) internally. Rubeus powers features like interoperability of LLMs, load balancing, fallbacks, and acts as an intermediary, ensuring that your requests are processed optimally.

One of the advantages of using Portkey is its flexibility. You can easily customize its behavior, redirect requests to different providers, or even bypass logging to Portkey altogether.

Here’s an example of customizing the behavior with Portkey:


```
portkey\_client.base\_url=None
```
**📝 Feedback with Portkey**[](#feedback-with-portkey "Permalink to this heading")
----------------------------------------------------------------------------------

Continuous improvement is a cornerstone of AI. To ensure your models and applications evolve and serve users better, feedback is vital. Portkey’s Feedback API offers a straightforward way to gather weighted feedback from users, allowing you to refine and improve over time.

Here’s how to utilize the Feedback API with Portkey:

Read more about [Feedback here](https://docs.portkey.ai/key-features/feedback-api).


```
import requestsimport json# Endpoint URLurl = "https://api.portkey.ai/v1/feedback"# Headersheaders = {    "x-portkey-api-key": os.environ.get("PORTKEY\_API\_KEY"),    "Content-Type": "application/json",}# Datadata = {"trace\_id": "llamaindex\_portkey", "value": 1}# Making the requestresponse = requests.post(url, headers=headers, data=json.dumps(data))# Print the responseprint(response.text)
```
All the feedback with `weight` and `value` for each trace id is available on the Portkey dashboard:

![Feedback](https://portkey.ai/blog/content/images/2023/09/feedback.png)**✅ Conclusion**[](#conclusion "Permalink to this heading")
------------------------------------------------------------

Integrating Portkey with Llamaindex simplifies the process of building robust and resilient AI applications. With features like semantic caching, observability, load balancing, feedback, and fallbacks, you can ensure optimal performance and continuous improvement.

By following this guide, you’ve set up and tested the Portkey integration with Llamaindex. As you continue to build and deploy AI applications, remember to leverage the full potential of this integration!

For further assistance or questions, reach out to the developers ➡️   
[![Twitter](https://img.shields.io/twitter/follow/portkeyai?style=social&logo=twitter)](https://twitter.com/intent/follow?screen_name=portkeyai)

Join our community of practitioners putting LLMs into production ➡️   
[![Discord](https://img.shields.io/discord/1143393887742861333?logo=discord)](https://discord.gg/sDk9JaNfK8)

