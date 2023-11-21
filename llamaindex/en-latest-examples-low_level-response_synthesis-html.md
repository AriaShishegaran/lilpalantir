[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/low_level/response_synthesis.ipynb)

Building Response Synthesis from Scratch[](#building-response-synthesis-from-scratch "Permalink to this heading")
==================================================================================================================

In this tutorial, we show you how to build the “LLM synthesis” component of a RAG pipeline from scratch. Given a set of retrieved Nodes, we’ll show you how to synthesize a response even if the retrieved context overflows the context window.

We’ll walk through some synthesis strategies:

* Create and Refine
* Tree Summarization

We’re essentially unpacking our “Response Synthesis” module and exposing that for the user.

We use OpenAI as a default LLM but you’re free to plug in any LLM you wish.

Setup[](#setup "Permalink to this heading")
--------------------------------------------

We build an empty Pinecone Index, and define the necessary LlamaIndex wrappers/abstractions so that we can load/index data and get back a vector retriever.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```
### Load Data[](#load-data "Permalink to this heading")


```
!mkdir data!wget --user-agent "Mozilla" "https://arxiv.org/pdf/2307.09288.pdf" -O "data/llama2.pdf"
```

```
from pathlib import Pathfrom llama\_hub.file.pymu\_pdf.base import PyMuPDFReader
```

```
loader = PyMuPDFReader()documents = loader.load(file\_path="./data/llama2.pdf")
```
### Build Pinecone Index, Get Retriever[](#build-pinecone-index-get-retriever "Permalink to this heading")

We use our high-level LlamaIndex abstractions to 1) ingest data into Pinecone, and then 2) get a vector retriever.

Note that we set chunk sizes to 1024.


```
import pineconeimport osapi\_key = os.environ["PINECONE\_API\_KEY"]pinecone.init(api\_key=api\_key, environment="us-west1-gcp")
```

```
/Users/jerryliu/Programming/gpt_index/.venv/lib/python3.10/site-packages/pinecone/index.py:4: TqdmExperimentalWarning: Using `tqdm.autonotebook.tqdm` in notebook mode. Use `tqdm.tqdm` instead to force console mode (e.g. in jupyter console)  from tqdm.autonotebook import tqdm
```

```
# dimensions are for text-embedding-ada-002pinecone.create\_index(    "quickstart", dimension=1536, metric="euclidean", pod\_type="p1")
```

```
pinecone\_index = pinecone.Index("quickstart")
```

```
# [Optional] drop contents in indexpinecone\_index.delete(deleteAll=True)
```

```
{}
```

```
from llama\_index.vector\_stores import PineconeVectorStorefrom llama\_index import VectorStoreIndex, ServiceContextfrom llama\_index.storage import StorageContext
```

```
vector\_store = PineconeVectorStore(pinecone\_index=pinecone\_index)# NOTE: set chunk size of 1024service\_context = ServiceContext.from\_defaults(chunk\_size=1024)storage\_context = StorageContext.from\_defaults(vector\_store=vector\_store)index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context, storage\_context=storage\_context)
```

```
retriever = index.as\_retriever()
```
### Given an example question, get a retrieved set of nodes.[](#given-an-example-question-get-a-retrieved-set-of-nodes "Permalink to this heading")

We use the retriever to get a set of relevant nodes given a user query. These nodes will then be passed to the response synthesis modules below.


```
query\_str = (    "Can you tell me about results from RLHF using both model-based and"    " human-based evaluation?")
```

```
retrieved\_nodes = retriever.retrieve(query\_str)
```
Building Response Synthesis with LLMs[](#building-response-synthesis-with-llms "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

In this section we’ll show how to use LLMs + Prompts to build a response synthesis module.

We’ll start from simple strategies (simply stuffing context into a prompt), to more advanced strategies that can handle context overflows.

### 1. Try a Simple Prompt[](#try-a-simple-prompt "Permalink to this heading")

We first try to synthesize the response using a single input prompt + LLM call.


```
from llama\_index.llms import OpenAIfrom llama\_index.prompts import PromptTemplatellm = OpenAI(model="text-davinci-003")
```

```
qa\_prompt = PromptTemplate( """\Context information is below.---------------------{context\_str}---------------------Given the context information and not prior knowledge, answer the query.Query: {query\_str}Answer: \""")
```
Given an example question, retrieve the set of relevant nodes and try to put it all in the prompt, separated by newlines.


```
query\_str = (    "Can you tell me about results from RLHF using both model-based and"    " human-based evaluation?")
```

```
retrieved\_nodes = retriever.retrieve(query\_str)
```

```
def generate\_response(retrieved\_nodes, query\_str, qa\_prompt, llm):    context\_str = "\n\n".join([r.get\_content() for r in retrieved\_nodes])    fmt\_qa\_prompt = qa\_prompt.format(        context\_str=context\_str, query\_str=query\_str    )    response = llm.complete(fmt\_qa\_prompt)    return str(response), fmt\_qa\_prompt
```

```
response, fmt\_qa\_prompt = generate\_response(    retrieved\_nodes, query\_str, qa\_prompt, llm)
```

```
print(f"\*\*\*\*\*Response\*\*\*\*\*\*:\n{response}\n\n")
```

```
*****Response******:RLHF used both model-based and human-based evaluation to select the best-performing models among several ablations. Model-based evaluation was used to measure the robustness of the reward model by collecting a test set of prompts for both helpfulness and safety, and asking three annotators to judge the quality of the answers based on a 7-point Likert scale. Human evaluation was used to validate major model versions. Additionally, a more general reward was trained to ensure the measure wouldn't diverge from the human preferences. Results showed that the reward models were well calibrated with the human preference annotations.
```

```
print(f"\*\*\*\*\*Formatted Prompt\*\*\*\*\*:\n{fmt\_qa\_prompt}\n\n")
```

```
*****Formatted Prompt*****:Context information is below.---------------------3.4RLHF Results3.4.1Model-Based EvaluationEvaluating LLMs is a challenging open-research problem. Human evaluation, while a gold standard, canbe complicated by various HCI considerations (Clark et al., 2021; Gehrmann et al., 2023), and is not alwaysscalable. Thus, to select the best-performing models among several ablations at each iteration from RLHF-V1to V5, we first observed the improvement of the rewards from the latest reward models, to save costs andincrease iteration speed. We later validated major model versions with human evaluations.How Far Can Model-Based Evaluation Go?To measure the robustness of our reward model, we collecteda test set of prompts for both helpfulness and safety, and asked three annotators to judge the quality of theanswers based on a 7-point Likert scale (the higher the better). We observe that our reward models overallare well calibrated with our human preference annotations, as illustrated in Figure 29 in the appendix. Thisconfirms the relevance of using our reward as a point-wise metric, despite being trained with a PairwiseRanking Loss.Still, as Goodhart’s Law states, when a measure becomes a target, it ceases to be a good measure. To ensureour measure won’t diverge from the human preferences, we additionally used a more general reward, trained175DiscussionHere, we discuss the interesting properties we have observed with RLHF (Section 5.1). We then discuss thelimitations of Llama 2-Chat (Section 5.2). Lastly, we present our strategy for responsibly releasing thesemodels (Section 5.3).5.1Learnings and ObservationsOur tuning process revealed several interesting results, such as Llama 2-Chat’s abilities to temporallyorganize its knowledge, or to call APIs for external tools.SFT (Mix)SFT (Annotation)RLHF (V1)0.00.20.40.60.81.0Reward Model ScoreRLHF (V2)Figure 20: Distribution shift for progressive versions of Llama 2-Chat, from SFT models towards RLHF.Beyond Human Supervision.At the outset of the project, many among us expressed a preference forsupervised annotation, attracted by its denser signal. Meanwhile reinforcement learning, known for its insta-bility, seemed a somewhat shadowy field for those in the NLP research community. However, reinforcementlearning proved highly effective, particularly given its cost and time effectiveness. Our findings underscorethat the crucial determinant of RLHF’s success lies in the synergy it fosters between humans and LLMsthroughout the annotation process.Even with proficient annotators, each individual writes with significant variation. A model fine-tuned onSFT annotation learns this diversity, including, unfortunately, the tail-end of poorly executed annotation. Fur-thermore, the model’s performance is capped by the writing abilities of the most skilled annotators. Humanannotators are arguably less subject to discrepancy when comparing two outputs’ preference annotationfor RLHF. Consequently, the reward mechanism swiftly learns to assign low scores to undesirable tail-enddistribution and aligns towards the human preference. This phenomena is illustrated in Figure 20, where wecan see that the worst answers are progressively removed, shifting the distribution to the right.In addition, during annotation, the model has the potential to venture into writing trajectories that even thebest annotators may not chart. Nonetheless, humans can still provide valuable feedback when comparing twoanswers, beyond their own writing competencies. Drawing a parallel, while we may not all be accomplishedartists, our ability to appreciate and critique art remains intact. We posit that the superior writing abilities ofLLMs, as manifested in surpassing human annotators in certain tasks, are fundamentally driven by RLHF, asdocumented in Gilardi et al. (2023) and Huang et al. (2023). Supervised data may no longer be the goldstandard, and this evolving circumstance compels a re-evaluation of the concept of “supervision.”In-Context Temperature Rescaling.We have observed an intriguing phenomenon related to RLHF, a featurenot previously reported to the best of our knowledge: the dynamic re-scaling of temperature contingent uponthe context. As indicated in Figure 8, the temperature appears to be influenced by RLHF. Yet, intriguingly,our findings also revealed that the shifts are not uniformly applied across all prompts, as shown in Figure 21.For instance, when it comes to prompts associated with creativity, such as “Write a poem,” an increase intemperature continues to generate diversity across our various RLHF iterations. This can be observed in theSelf-BLEU slope, which mirrors a pattern comparable to that of the SFT model.On the other hand, for prompts based on factual information, such as “What is the capital of ?” the Self-BLEUslope diminishes over time. This pattern suggests that despite the rising temperature, the model learns toconsistently provide the same response to factual prompts.32---------------------Given the context information and not prior knowledge, answer the query.Query: Can you tell me about results from RLHF using both model-based and human-based evaluation?Answer: 
```
**Problem**: What if we set the top-k retriever to a higher value? The context would overflow!


```
retriever = index.as\_retriever(similarity\_top\_k=6)retrieved\_nodes = retriever.retrieve(query\_str)
```

```
response, fmt\_qa\_prompt = generate\_response(    retrieved\_nodes, query\_str, qa\_prompt, llm)print(f"Response (k=5): {response}")
```

```
---------------------------------------------------------------------------ValueError Traceback (most recent call last)Cell In[34], line 1----> 1 response, fmt\_qa\_prompt = generate\_response(retrieved\_nodes, query\_str, qa\_prompt, llm) 2 print(f'Response (k=5): {response}')Cell In[16], line 4, in generate\_response(retrieved\_nodes, query\_str, qa\_prompt, llm) 2 context\_str = "\n\n".join([r.get\_content() for r in retrieved\_nodes]) 3 fmt\_qa\_prompt = qa\_prompt.format(context\_str=context\_str, query\_str=query\_str)----> 4 response = llm.complete(fmt\_qa\_prompt) 5 return str(response), fmt\_qa\_promptFile ~/Programming/gpt\_index/llama\_index/llms/base.py:277, in llm\_completion\_callback.<locals>.wrap.<locals>.wrapped\_llm\_predict(\_self, \*args, \*\*kwargs) 267 with wrapper\_logic(\_self) as callback\_manager: 268     event\_id = callback\_manager.on\_event\_start( 269         CBEventType.LLM, 270         payload={   (...) 274         }, 275     )--> 277     f\_return\_val = f(\_self, \*args, \*\*kwargs) 278     if isinstance(f\_return\_val, Generator): 279         # intercept the generator and add a callback to the end 280         def wrapped\_gen() -> CompletionResponseGen:File ~/Programming/gpt\_index/llama\_index/llms/openai.py:144, in OpenAI.complete(self, prompt, \*\*kwargs) 142 else: 143     complete\_fn = self.\_complete--> 144 return complete\_fn(prompt, \*\*kwargs)File ~/Programming/gpt\_index/llama\_index/llms/openai.py:281, in OpenAI.\_complete(self, prompt, \*\*kwargs) 278 all\_kwargs = self.\_get\_all\_kwargs(\*\*kwargs) 279 if self.max\_tokens is None: 280     # NOTE: non-chat completion endpoint requires max\_tokens to be set--> 281     max\_tokens = self.\_get\_max\_token\_for\_prompt(prompt) 282     all\_kwargs["max\_tokens"] = max\_tokens 284 response = completion\_with\_retry( 285     is\_chat\_model=self.\_is\_chat\_model, 286     max\_retries=self.max\_retries,   (...) 289     \*\*all\_kwargs, 290 )File ~/Programming/gpt\_index/llama\_index/llms/openai.py:343, in OpenAI.\_get\_max\_token\_for\_prompt(self, prompt) 341 max\_token = context\_window - len(tokens) 342 if max\_token <= 0:--> 343     raise ValueError( 344         f"The prompt is too long for the model. " 345         f"Please use a prompt that is less than {context\_window} tokens." 346     ) 347 return max\_tokenValueError: The prompt is too long for the model. Please use a prompt that is less than 4097 tokens.
```
### 2. Try a “Create and Refine” strategy[](#try-a-create-and-refine-strategy "Permalink to this heading")

To deal with context overflows, we can try a strategy where we synthesize a response sequentially through all nodes. Start with the first node and generate an initial response. Then for subsequent nodes, refine the answer using additional context.

This requires us to define a “refine” prompt as well.


```
refine\_prompt = PromptTemplate( """\The original query is as follows: {query\_str}We have provided an existing answer: {existing\_answer}We have the opportunity to refine the existing answer \(only if needed) with some more context below.------------{context\_str}------------Given the new context, refine the original answer to better answer the query. \If the context isn't useful, return the original answer.Refined Answer: \""")
```

```
from llama\_index.response.notebook\_utils import display\_source\_nodedef generate\_response\_cr(    retrieved\_nodes, query\_str, qa\_prompt, refine\_prompt, llm): """Generate a response using create and refine strategy. The first node uses the 'QA' prompt. All subsequent nodes use the 'refine' prompt. """    cur\_response = None    fmt\_prompts = []    for idx, node in enumerate(retrieved\_nodes):        print(f"[Node {idx}]")        display\_source\_node(node, source\_length=2000)        context\_str = node.get\_content()        if idx == 0:            fmt\_prompt = qa\_prompt.format(                context\_str=context\_str, query\_str=query\_str            )        else:            fmt\_prompt = refine\_prompt.format(                context\_str=context\_str,                query\_str=query\_str,                existing\_answer=str(cur\_response),            )        cur\_response = llm.complete(fmt\_prompt)        fmt\_prompts.append(fmt\_prompt)    return str(cur\_response), fmt\_prompts
```

```
response, fmt\_prompts = generate\_response\_cr(    retrieved\_nodes, query\_str, qa\_prompt, refine\_prompt, llm)
```

```
print(str(response))
```

```
# view a sample qa promptprint(fmt\_prompts[0])
```

```
# view a sample refine promptprint(fmt\_prompts[1])
```
**Observation**: This is an initial step, but obviously there are inefficiencies. One is the fact that it’s quite slow - we make sequential calls. The second piece is that each LLM call is inefficient - we are only inserting a single node, but not “stuffing” the prompt with as much context as necessary.

### 3. Try a Hierarchical Summarization Strategy[](#try-a-hierarchical-summarization-strategy "Permalink to this heading")

Another approach is to try a hierarchical summarization strategy. We generate an answer for each node independently, and then hierarchically combine the answers. This “combine” step could happen once, or for maximum generality can happen recursively until there is one “root” node. That “root” node is then returned as the answer.

We implement this approach below. We have a fixed number of children of 5, so we hierarchically combine 5 children at a time.

**NOTE**: In LlamaIndex this is referred to as “tree\_summarize”, in LangChain this is referred to as map-reduce.


```
def combine\_results(    texts,    query\_str,    qa\_prompt,    llm,    cur\_prompt\_list,    num\_children=10,):    new\_texts = []    for idx in range(0, len(texts), num\_children):        text\_batch = texts[idx : idx + num\_children]        context\_str = "\n\n".join([t for t in text\_batch])        fmt\_qa\_prompt = qa\_prompt.format(            context\_str=context\_str, query\_str=query\_str        )        combined\_response = llm.complete(fmt\_qa\_prompt)        new\_texts.append(str(combined\_response))        cur\_prompt\_list.append(fmt\_qa\_prompt)    if len(new\_texts) == 1:        return new\_texts[0]    else:        return combine\_results(            new\_texts, query\_str, qa\_prompt, llm, num\_children=num\_children        )def generate\_response\_hs(    retrieved\_nodes, query\_str, qa\_prompt, llm, num\_children=10): """Generate a response using hierarchical summarization strategy. Combine num\_children nodes hierarchically until we get one root node. """    fmt\_prompts = []    node\_responses = []    for node in retrieved\_nodes:        context\_str = node.get\_content()        fmt\_qa\_prompt = qa\_prompt.format(            context\_str=context\_str, query\_str=query\_str        )        node\_response = llm.complete(fmt\_qa\_prompt)        node\_responses.append(node\_response)        fmt\_prompts.append(fmt\_qa\_prompt)    response\_txt = combine\_results(        [str(r) for r in node\_responses],        query\_str,        qa\_prompt,        llm,        fmt\_prompts,        num\_children=num\_children,    )    return response\_txt, fmt\_prompts
```

```
response, fmt\_prompts = generate\_response\_hs(    retrieved\_nodes, query\_str, qa\_prompt, llm)
```

```
print(str(response))
```

```
The results from RLHF using both model-based and human-based evaluation showed that Llama 2-Chat models outperformed open-source models by a significant margin on both single turn and multi-turn prompts. For human-based evaluation, we compared Llama 2-Chat models to open-source models and closed-source models on over 4,000 single and multi-turn prompts. The results showed that Llama 2-Chat models outperformed the other models by a significant margin on both single turn and multi-turn prompts. The human preference annotation agreement rate was also higher on more distinct responses than similar pairs. The largest RLHF model was competitive with ChatGPT, with a win rate of 36% and a tie rate of 31.5% relative to ChatGPT. RLHF 70B model also outperformed PaLM-bison chat model by a large percentage on the prompt set.
```
**Observation**: Note that the answer is much more concise than the create-and-refine approach. This is a well-known phemonenon - the reason is because hierarchical summarization tends to compress information at each stage, whereas create and refine encourages adding on more information with each node.

**Observation**: Similar to the above section, there are inefficiencies. We are still generating an answer for each node independently that we can try to optimize away.

Our `ResponseSynthesizer` module handles this!

#### 4. [Optional] Let’s create an async version of hierarchical summarization![](#optional-let-s-create-an-async-version-of-hierarchical-summarization "Permalink to this heading")

A pro of the hierarchical summarization approach is that the LLM calls can be parallelized, leading to big speedups in response synthesis.

We implement an async version below. We use asyncio.gather to execute coroutines (LLM calls) for each Node concurrently.


```
import nest\_asyncioimport asyncionest\_asyncio.apply()
```

```
async def acombine\_results(    texts,    query\_str,    qa\_prompt,    llm,    cur\_prompt\_list,    num\_children=10,):    fmt\_prompts = []    for idx in range(0, len(texts), num\_children):        text\_batch = texts[idx : idx + num\_children]        context\_str = "\n\n".join([t for t in text\_batch])        fmt\_qa\_prompt = qa\_prompt.format(            context\_str=context\_str, query\_str=query\_str        )        fmt\_prompts.append(fmt\_qa\_prompt)        cur\_prompt\_list.append(fmt\_qa\_prompt)    tasks = [llm.acomplete(p) for p in fmt\_prompts]    combined\_responses = await asyncio.gather(\*tasks)    new\_texts = [str(r) for r in combined\_responses]    if len(new\_texts) == 1:        return new\_texts[0]    else:        return await acombine\_results(            new\_texts, query\_str, qa\_prompt, llm, num\_children=num\_children        )async def agenerate\_response\_hs(    retrieved\_nodes, query\_str, qa\_prompt, llm, num\_children=10): """Generate a response using hierarchical summarization strategy. Combine num\_children nodes hierarchically until we get one root node. """    fmt\_prompts = []    node\_responses = []    for node in retrieved\_nodes:        context\_str = node.get\_content()        fmt\_qa\_prompt = qa\_prompt.format(            context\_str=context\_str, query\_str=query\_str        )        fmt\_prompts.append(fmt\_qa\_prompt)    tasks = [llm.acomplete(p) for p in fmt\_prompts]    node\_responses = await asyncio.gather(\*tasks)    response\_txt = combine\_results(        [str(r) for r in node\_responses],        query\_str,        qa\_prompt,        llm,        fmt\_prompts,        num\_children=num\_children,    )    return response\_txt, fmt\_prompts
```

```
response, fmt\_prompts = await agenerate\_response\_hs(    retrieved\_nodes, query\_str, qa\_prompt, llm)
```

```
print(str(response))
```

```
 Results from RLHF using both model-based and human-based evaluation show that larger models generally obtain higher performance for a similar volume of data. Additionally, the accuracy on more distinct responses matters the most to improve Llama 2-Chat performance. The human preference annotation agreement rate is also higher on more distinct responses than similar pairs. Furthermore, two main algorithms were explored for RLHF fine-tuning: Proximal Policy Optimization (PPO) and Rejection Sampling fine-tuning. The largest Llama 2-Chat model was found to be competitive with ChatGPT, with a win rate of 36% and a tie rate of 31.5% relative to ChatGPT. Additionally, Llama 2-Chat 70B model outperformed PaLM-bison chat model by a large percentage on our prompt set. Inter-Rater Reliability (IRR) was measured using Gwet’s AC1/2 statistic, with scores varying between 0.37 and 0.55 depending on the specific model comparison.
```
Let’s put it all together![](#let-s-put-it-all-together "Permalink to this heading")
-------------------------------------------------------------------------------------

Let’s define a simple query engine that can be initialized with a retriever, prompt, llm etc. And have it implement a simple `query` function. We also implement an async version, can be used if you completed part 4 above!

**NOTE**: We skip subclassing our own `QueryEngine` abstractions. This is a big TODO to make it more easily sub-classable!


```
from llama\_index.retrievers import BaseRetrieverfrom llama\_index.llms.base import LLMfrom dataclasses import dataclassfrom typing import Optional, List@dataclassclass Response:    response: str    source\_nodes: Optional[List] = None    def \_\_str\_\_(self):        return self.responseclass MyQueryEngine: """My query engine. Uses the tree summarize response synthesis module by default. """    def \_\_init\_\_(        self,        retriever: BaseRetriever,        qa\_prompt: PromptTemplate,        llm: LLM,        num\_children=10,    ) -> None:        self.\_retriever = retriever        self.\_qa\_prompt = qa\_prompt        self.\_llm = llm        self.\_num\_children = num\_children    def query(self, query\_str: str):        retrieved\_nodes = self.\_retriever.retrieve(query\_str)        response\_txt, \_ = generate\_response\_hs(            retrieved\_nodes,            query\_str,            self.\_qa\_prompt,            self.\_llm,            num\_children=self.\_num\_children,        )        response = Response(response\_txt, source\_nodes=retrieved\_nodes)        return response    async def aquery(self, query\_str: str):        retrieved\_nodes = await self.\_retriever.aretrieve(query\_str)        response\_txt, \_ = await agenerate\_response\_hs(            retrieved\_nodes,            query\_str,            self.\_qa\_prompt,            self.\_llm,            num\_children=self.\_num\_children,        )        response = Response(response\_txt, source\_nodes=retrieved\_nodes)        return response
```

```
query\_engine = MyQueryEngine(retriever, qa\_prompt, llm, num\_children=10)
```

```
response = query\_engine.query(query\_str)
```

```
print(str(response))
```

```
The results from RLHF using both model-based and human-based evaluation showed that larger models generally obtained higher performance for a similar volume of data. The accuracy on more distinct responses was higher than on similar pairs, indicating that learning to model human preferences becomes challenging when deciding between two similar model responses. Additionally, the largest Llama 2-Chat model was found to be competitive with ChatGPT, with a win rate of 36% and a tie rate of 31.5% relative to ChatGPT. Llama 2-Chat 70B model was also found to outperform PaLM-bison chat model by a large percentage on the prompt set. Inter-Rater Reliability (IRR) was measured using Gwet’s AC1/2 statistic, with scores varying between 0.37 and 0.55 depending on the specific model comparison.
```

```
response = await query\_engine.aquery(query\_str)
```

```
print(str(response))
```

```
The results from RLHF using both model-based and human-based evaluation showed that larger models generally obtained higher performance for a similar volume of data. The accuracy on more distinct responses was higher than on similar pairs, indicating that learning to model human preferences becomes challenging when deciding between two similar model responses. Additionally, the largest Llama 2-Chat model was found to be competitive with ChatGPT, with a win rate of 36% and a tie rate of 31.5%. Human evaluations were conducted using a 7-point Likert scale helpfulness task, with Gwet’s AC2 score varying between 0.37 and 0.55 depending on the specific model comparison.
```
