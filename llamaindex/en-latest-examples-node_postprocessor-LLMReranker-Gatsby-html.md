LLM Reranker Demonstration (Great Gatsby)[](#llm-reranker-demonstration-great-gatsby "Permalink to this heading")
==================================================================================================================

This tutorial showcases how to do a two-stage pass for retrieval. Use embedding-based retrieval with a high top-k valuein order to maximize recall and get a large set of candidate items. Then, use LLM-based retrievalto dynamically select the nodes that are actually relevant to the query.


```
import nest\_asyncionest\_asyncio.apply()
```

```
import loggingimport syslogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))from llama\_index import (    VectorStoreIndex,    SimpleDirectoryReader,    ServiceContext,    LLMPredictor,)from llama\_index.indices.postprocessor import LLMRerankfrom llama\_index.llms import OpenAIfrom IPython.display import Markdown, display
```
Load Data, Build Index[](#load-data-build-index "Permalink to this heading")
-----------------------------------------------------------------------------


```
# LLM Predictor (gpt-3.5-turbo) + service contextllm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
WARNING:llama_index.llm_predictor.base:Unknown max input size for gpt-3.5-turbo, using defaults.Unknown max input size for gpt-3.5-turbo, using defaults.
```

```
# load documentsdocuments = SimpleDirectoryReader("../../../examples/gatsby/data").load\_data()
```

```
documents
```

```
index = VectorStoreIndex.from\_documents(    documents, service\_context=service\_context)
```

```
INFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total LLM token usage: 0 tokens> [build_index_from_nodes] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [build_index_from_nodes] Total embedding token usage: 49266 tokens> [build_index_from_nodes] Total embedding token usage: 49266 tokens
```
Retrieval[](#retrieval "Permalink to this heading")
----------------------------------------------------


```
from llama\_index.retrievers import VectorIndexRetrieverfrom llama\_index.indices.query.schema import QueryBundleimport pandas as pdfrom IPython.display import display, HTMLpd.set\_option("display.max\_colwidth", -1)def get\_retrieved\_nodes(    query\_str, vector\_top\_k=10, reranker\_top\_n=3, with\_reranker=False):    query\_bundle = QueryBundle(query\_str)    # configure retriever    retriever = VectorIndexRetriever(        index=index,        similarity\_top\_k=vector\_top\_k,    )    retrieved\_nodes = retriever.retrieve(query\_bundle)    if with\_reranker:        # configure reranker        reranker = LLMRerank(            choice\_batch\_size=5,            top\_n=reranker\_top\_n,            service\_context=service\_context,        )        retrieved\_nodes = reranker.postprocess\_nodes(            retrieved\_nodes, query\_bundle        )    return retrieved\_nodesdef pretty\_print(df):    return display(HTML(df.to\_html().replace("\\n", "<br>")))def visualize\_retrieved\_nodes(nodes) -> None:    result\_dicts = []    for node in nodes:        result\_dict = {"Score": node.score, "Text": node.node.get\_text()}        result\_dicts.append(result\_dict)    pretty\_print(pd.DataFrame(result\_dicts))
```

```
/var/folders/1r/c3h91d9s49xblwfvz79s78_c0000gn/T/ipykernel_44297/3519340226.py:7: FutureWarning: Passing a negative integer is deprecated in version 1.0 and will not be supported in future version. Instead, use None to not limit the column width.  pd.set_option('display.max_colwidth', -1)
```

```
new\_nodes = get\_retrieved\_nodes(    "Who was driving the car that hit Myrtle?",    vector\_top\_k=3,    with\_reranker=False,)
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 10 tokens> [retrieve] Total embedding token usage: 10 tokens
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 0.828844 | and some garrulous man telling over and over whathad happened, until it became less and less real even to him and hecould tell it no longer, and Myrtle Wilson’s tragic achievement wasforgotten. Now I want to go back a little and tell what happened atthe garage after we left there the night before.They had difficulty in locating the sister, Catherine. She must havebroken her rule against drinking that night, for when she arrived shewas stupid with liquor and unable to understand that the ambulance hadalready gone to Flushing. When they convinced her of this, sheimmediately fainted, as if that was the intolerable part of theaffair. Someone, kind or curious, took her in his car and drove her inthe wake of her sister’s body.Until long after midnight a changing crowd lapped up against the frontof the garage, while George Wilson rocked himself back and forth onthe couch inside. For a while the door of the office was open, andeveryone who came into the garage glanced irresistibly through it.Finally someone said it was a shame, and closed the door. Michaelisand several other men were with him; first, four or five men, latertwo or three men. Still later Michaelis had to ask the last strangerto wait there fifteen minutes longer, while he went back to his ownplace and made a pot of coffee. After that, he stayed there alone withWilson until dawn.About three o’clock the quality of Wilson’s incoherent mutteringchanged—he grew quieter and began to talk about the yellow car. Heannounced that he had a way of finding out whom the yellow carbelonged to, and then he blurted out that a couple of months ago hiswife had come from the city with her face bruised and her noseswollen.But when he heard himself say this, he flinched and began to cry “Oh,my God!” again in his groaning voice. Michaelis made a clumsy |
| 1 | 0.827754 | she rushed out into the dusk, waving her hands andshouting—before he could move from his door the business was over.The “death car” as the newspapers called it, didn’t stop; it came outof the gathering darkness, wavered tragically for a moment, and thendisappeared around the next bend. Mavro Michaelis wasn’t even sure ofits colour—he told the first policeman that it was light green. Theother car, the one going toward New York, came to rest a hundred yardsbeyond, and its driver hurried back to where Myrtle Wilson, her lifeviolently extinguished, knelt in the road and mingled her thick darkblood with the dust.Michaelis and this man reached her first, but when they had torn openher shirtwaist, still damp with perspiration, they saw that her leftbreast was swinging loose like a flap, and there was no need to listenfor the heart beneath. The mouth was wide open and ripped a little atthe corners, as though she had choked a little in giving up thetremendous vitality she had stored so long.------------------------------------------------------------------------We saw the three or four automobiles and the crowd when we were stillsome distance away.“Wreck!” said Tom. “That’s good. Wilson’ll have a little business atlast.”He slowed down, but still without any intention of stopping, until, aswe came nearer, the hushed, intent faces of the people at the garagedoor made him automatically put on the brakes.“We’ll take a look,” he said doubtfully, “just a look.”I became aware now of a hollow, wailing sound which issued incessantlyfrom the garage, a sound which as we got out of the coupé and walkedtoward the door resolved itself into the words “Oh, my God!” utteredover and over in a gasping |
| 2 | 0.826390 | went on, “and left the car inmy garage. I don’t think anybody saw us, but of course I can’t besure.”I disliked him so much by this time that I didn’t find it necessary totell him he was wrong.“Who was the woman?” he inquired.“Her name was Wilson. Her husband owns the garage. How the devil didit happen?”“Well, I tried to swing the wheel—” He broke off, and suddenly Iguessed at the truth.“Was Daisy driving?”“Yes,” he said after a moment, “but of course I’ll say I was. You see,when we left New York she was very nervous and she thought it wouldsteady her to drive—and this woman rushed out at us just as we werepassing a car coming the other way. It all happened in a minute, butit seemed to me that she wanted to speak to us, thought we weresomebody she knew. Well, first Daisy turned away from the woman towardthe other car, and then she lost her nerve and turned back. The secondmy hand reached the wheel I felt the shock—it must have killed herinstantly.”“It ripped her open—”“Don’t tell me, old sport.” He winced. “Anyhow—Daisy stepped on it. Itried to make her stop, but she couldn’t, so I pulled on the emergencybrake. Then she fell over into my lap and I drove on.“She’ll be all right tomorrow,” he said presently. “I’m just going towait here and see if he tries to bother her about that unpleasantnessthis afternoon. She’s locked herself into her room, and if he triesany brutality she’s going to turn the light out and on again.”“He won’t touch |


```
new\_nodes = get\_retrieved\_nodes(    "Who was driving the car that hit Myrtle?",    vector\_top\_k=10,    reranker\_top\_n=3,    with\_reranker=True,)
```

```
visualize\_retrieved\_nodes(new\_nodes)
```


|  | Score | Text |
| --- | --- | --- |
| 0 | 10.0 | went on, “and left the car inmy garage. I don’t think anybody saw us, but of course I can’t besure.”I disliked him so much by this time that I didn’t find it necessary totell him he was wrong.“Who was the woman?” he inquired.“Her name was Wilson. Her husband owns the garage. How the devil didit happen?”“Well, I tried to swing the wheel—” He broke off, and suddenly Iguessed at the truth.“Was Daisy driving?”“Yes,” he said after a moment, “but of course I’ll say I was. You see,when we left New York she was very nervous and she thought it wouldsteady her to drive—and this woman rushed out at us just as we werepassing a car coming the other way. It all happened in a minute, butit seemed to me that she wanted to speak to us, thought we weresomebody she knew. Well, first Daisy turned away from the woman towardthe other car, and then she lost her nerve and turned back. The secondmy hand reached the wheel I felt the shock—it must have killed herinstantly.”“It ripped her open—”“Don’t tell me, old sport.” He winced. “Anyhow—Daisy stepped on it. Itried to make her stop, but she couldn’t, so I pulled on the emergencybrake. Then she fell over into my lap and I drove on.“She’ll be all right tomorrow,” he said presently. “I’m just going towait here and see if he tries to bother her about that unpleasantnessthis afternoon. She’s locked herself into her room, and if he triesany brutality she’s going to turn the light out and on again.”“He won’t touch |


```
new\_nodes = get\_retrieved\_nodes(    "What did Gatsby want Daisy to do in front of Tom?",    vector\_top\_k=3,    with\_reranker=False,)
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 14 tokens> [retrieve] Total embedding token usage: 14 tokens
```

```
visualize\_retrieved\_nodes(new\_nodes)
```

```
****Score****: 0.8647796939111776****Node text****: got to make your house into a pigsty in order to have anyfriends—in the modern world.”Angry as I was, as we all were, I was tempted to laugh whenever heopened his mouth. The transition from libertine to prig was socomplete.“I’ve got something to tell you, old sport—” began Gatsby. But Daisyguessed at his intention.“Please don’t!” she interrupted helplessly. “Please let’s all gohome. Why don’t we all go home?”“That’s a good idea,” I got up. “Come on, Tom. Nobody wants a drink.”“I want to know what Mr. Gatsby has to tell me.”“Your wife doesn’t love you,” said Gatsby. “She’s never loved you.She loves me.”“You must be crazy!” exclaimed Tom automatically.Gatsby sprang to his feet, vivid with excitement.“She never loved you, do you hear?” he cried. “She only married youbecause I was poor and she was tired of waiting for me. It was aterrible mistake, but in her heart she never loved anyone except me!”At this point Jordan and I tried to go, but Tom and Gatsby insistedwith competitive firmness that we remain—as though neither of them hadanything to conceal and it would be a privilege to partake vicariouslyof their emotions.“Sit down, Daisy,” Tom’s voice groped unsuccessfully for the paternalnote. “What’s been going on? I want to hear all about it.”“I told you what’s been going on,” said Gatsby. “Going on for fiveyears—and you didn’t know.”Tom turned to Daisy****Score****: 0.8609230717744326****Node text****: to keep yourshoes dry?” There was a husky tenderness in his tone … “Daisy?”“Please don’t.” Her voice was cold, but the rancour was gone from it.She looked at Gatsby. “There, Jay,” she said—but her hand as she triedto light a cigarette was trembling. Suddenly she threw the cigaretteand the burning match on the carpet.“Oh, you want too much!” she cried to Gatsby. “I love you now—isn’tthat enough? I can’t help what’s past.” She began to sobhelplessly. “I did love him once—but I loved you too.”Gatsby’s eyes opened and closed.“You loved me too?” he repeated.“Even that’s a lie,” said Tom savagely. “She didn’t know you werealive. Why—there’s things between Daisy and me that you’ll never know,things that neither of us can ever forget.”The words seemed to bite physically into Gatsby.“I want to speak to Daisy alone,” he insisted. “She’s all excitednow—”“Even alone I can’t say I never loved Tom,” she admitted in a pitifulvoice. “It wouldn’t be true.”“Of course it wouldn’t,” agreed Tom.She turned to her husband.“As if it mattered to you,” she said.“Of course it matters. I’m going to take better care of you from nowon.”“You don’t understand,” said Gatsby, with a touch of panic. “You’renot going to take care of her any more.”“I’m not?” Tom opened his eyes wide and****Score****: 0.8555028907426916****Node text****: shadowed well with awnings, was dark and cool. Daisy andJordan lay upon an enormous couch, like silver idols weighing downtheir own white dresses against the singing breeze of the fans.“We can’t move,” they said together.Jordan’s fingers, powdered white over their tan, rested for a momentin mine.“And Mr. Thomas Buchanan, the athlete?” I inquired.Simultaneously I heard his voice, gruff, muffled, husky, at the halltelephone.Gatsby stood in the centre of the crimson carpet and gazed around withfascinated eyes. Daisy watched him and laughed, her sweet, excitinglaugh; a tiny gust of powder rose from her bosom into the air.“The rumour is,” whispered Jordan, “that that’s Tom’s girl on thetelephone.”We were silent. The voice in the hall rose high with annoyance: “Verywell, then, I won’t sell you the car at all … I’m under no obligationsto you at all … and as for your bothering me about it at lunch time, Iwon’t stand that at all!”“Holding down the receiver,” said Daisy cynically.“No, he’s not,” I assured her. “It’s a bona-fide deal. I happen toknow about it.”Tom flung open the door, blocked out its space for a moment with histhick body, and hurried into the room.“Mr. Gatsby!” He put out his broad, flat hand with well-concealeddislike. “I’m glad to see you, sir … Nick …”“Make us a cold drink,” cried Daisy.As he left the room again she got up and went over to Gatsby andpulled his face
```

```
new\_nodes = get\_retrieved\_nodes(    "What did Gatsby want Daisy to do in front of Tom?",    vector\_top\_k=10,    reranker\_top\_n=3,    with\_reranker=True,)
```

```
INFO:llama_index.token_counter.token_counter:> [retrieve] Total LLM token usage: 0 tokens> [retrieve] Total LLM token usage: 0 tokensINFO:llama_index.token_counter.token_counter:> [retrieve] Total embedding token usage: 14 tokens> [retrieve] Total embedding token usage: 14 tokensDoc: 2, Relevance: 10No relevant documents found. Please provide a different question.
```

```
visualize\_retrieved\_nodes(new\_nodes)
```

```
****Score****: 10.0****Node text****: to keep yourshoes dry?” There was a husky tenderness in his tone … “Daisy?”“Please don’t.” Her voice was cold, but the rancour was gone from it.She looked at Gatsby. “There, Jay,” she said—but her hand as she triedto light a cigarette was trembling. Suddenly she threw the cigaretteand the burning match on the carpet.“Oh, you want too much!” she cried to Gatsby. “I love you now—isn’tthat enough? I can’t help what’s past.” She began to sobhelplessly. “I did love him once—but I loved you too.”Gatsby’s eyes opened and closed.“You loved me too?” he repeated.“Even that’s a lie,” said Tom savagely. “She didn’t know you werealive. Why—there’s things between Daisy and me that you’ll never know,things that neither of us can ever forget.”The words seemed to bite physically into Gatsby.“I want to speak to Daisy alone,” he insisted. “She’s all excitednow—”“Even alone I can’t say I never loved Tom,” she admitted in a pitifulvoice. “It wouldn’t be true.”“Of course it wouldn’t,” agreed Tom.She turned to her husband.“As if it mattered to you,” she said.“Of course it matters. I’m going to take better care of you from nowon.”“You don’t understand,” said Gatsby, with a touch of panic. “You’renot going to take care of her any more.”“I’m not?” Tom opened his eyes wide and
```
Query Engine[](#query-engine "Permalink to this heading")
----------------------------------------------------------


```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=10,    node\_postprocessors=[reranker],    response\_mode="tree\_summarize",)response = query\_engine.query(    "What did the author do during his time at Y Combinator?",)
```

```
query\_engine = index.as\_query\_engine(    similarity\_top\_k=3, response\_mode="tree\_summarize")response = query\_engine.query(    "What did the author do during his time at Y Combinator?",)
```

```
retrieval =
```
