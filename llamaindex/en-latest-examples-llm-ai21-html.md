[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/llm/ai21.ipynb)

AI21[](#ai21 "Permalink to this heading")
==========================================

Basic Usage[](#basic-usage "Permalink to this heading")
--------------------------------------------------------

### Call `complete` with a prompt[](#call-complete-with-a-prompt "Permalink to this heading")

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
from llama\_index.llms import AI21api\_key = "Your api key"resp = AI21(api\_key=api\_key).complete("Paul Graham is ")
```

```
print(resp)
```

```
an American computer scientist, essayist, and venture capitalist. He is best known for his work on Lisp, programming language design, and entrepreneurship. Graham has written several books on these topics, including " ANSI Common Lisp" and " Hackers and Painters." He is also the co-founder of Y Combinator, a venture capital firm that invests in early-stage technology companies.
```
### Call `chat` with a list of messages[](#call-chat-with-a-list-of-messages "Permalink to this heading")


```
from llama\_index.llms import ChatMessage, AI21messages = [    ChatMessage(role="user", content="hello there"),    ChatMessage(        role="assistant", content="Arrrr, matey! How can I help ye today?"    ),    ChatMessage(role="user", content="What is your name"),]resp = AI21(api\_key=api\_key).chat(    messages, preamble\_override="You are a pirate with a colorful personality")
```

```
print(resp)
```

```
assistant: yer talkin' to Captain Jack Sparrow
```
Configure Model[](#configure-model "Permalink to this heading")
----------------------------------------------------------------


```
from llama\_index.llms import AI21llm = AI21(model="j2-mid", api\_key=api\_key)
```

```
resp = llm.complete("Paul Graham is ")
```

```
print(resp)
```

```
an American computer scientist, essayist, and venture capitalist. He is best known for his work on Lisp, programming language design, and entrepreneurship. Graham has written several books on these topics, including " ANSI Common Lisp" and " Hackers and Painters." He is also the co-founder of Y Combinator, a venture capital firm that invests in early-stage technology companies.
```
Set API Key at a per-instance level[](#set-api-key-at-a-per-instance-level "Permalink to this heading")
--------------------------------------------------------------------------------------------------------

If desired, you can have separate LLM instances use separate API keys.


```
from llama\_index.llms import AI21llm\_good = AI21(api\_key=api\_key)llm\_bad = AI21(model="j2-mid", api\_key="BAD\_KEY")resp = llm\_good.complete("Paul Graham is ")print(resp)resp = llm\_bad.complete("Paul Graham is ")print(resp)
```

```
an American computer scientist, essayist, and venture capitalist. He is best known for his work on Lisp, programming language design, and entrepreneurship. Graham has written several books on these topics, including "Hackers and Painters" and "On Lisp." He is also the co-founder of Y Combinator, a venture capital firm that invests in early-stage technology companies.
```

```
Calling POST https://api.ai21.com/studio/v1/j2-mid/complete failed with a non-200 response code: 401
```

```
---------------------------------------------------------------------------Unauthorized Traceback (most recent call last)/home/amit/Desktop/projects/lindex/llama\_index/docs/examples/llm/ai21.ipynb Cell 14 line 9      <a href='vscode-notebook-cell:/home/amit/Desktop/projects/lindex/llama\_index/docs/examples/llm/ai21.ipynb#X42sZmlsZQ%3D%3D?line=5'>6</a> resp = llm\_good.complete("Paul Graham is ")      <a href='vscode-notebook-cell:/home/amit/Desktop/projects/lindex/llama\_index/docs/examples/llm/ai21.ipynb#X42sZmlsZQ%3D%3D?line=6'>7</a> print(resp)----> <a href='vscode-notebook-cell:/home/amit/Desktop/projects/lindex/llama\_index/docs/examples/llm/ai21.ipynb#X42sZmlsZQ%3D%3D?line=8'>9</a> resp = llm\_bad.complete("Paul Graham is ")     <a href='vscode-notebook-cell:/home/amit/Desktop/projects/lindex/llama\_index/docs/examples/llm/ai21.ipynb#X42sZmlsZQ%3D%3D?line=9'>10</a> print(resp)File ~/Desktop/projects/lindex/llama\_index/llama\_index/llms/base.py:312, in llm\_completion\_callback.<locals>.wrap.<locals>.wrapped\_llm\_predict(\_self, \*args, \*\*kwargs) 302 with wrapper\_logic(\_self) as callback\_manager: 303     event\_id = callback\_manager.on\_event\_start( 304         CBEventType.LLM, 305         payload={   (...) 309         }, 310     )--> 312     f\_return\_val = f(\_self, \*args, \*\*kwargs) 313     if isinstance(f\_return\_val, Generator): 314         # intercept the generator and add a callback to the end 315         def wrapped\_gen() -> CompletionResponseGen:File ~/Desktop/projects/lindex/llama\_index/llama\_index/llms/ai21.py:104, in AI21.complete(self, prompt, \*\*kwargs) 100 import ai21 102 ai21.api\_key = self.\_api\_key--> 104 response = ai21.Completion.execute(\*\*all\_kwargs, prompt=prompt) 106 return CompletionResponse( 107     text=response["completions"][0]["data"]["text"], raw=response.\_\_dict\_\_ 108 )File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/modules/resources/nlp\_task.py:22, in NLPTask.execute(cls, \*\*params) 20     return cls.\_execute\_sm(destination=destination, params=params) 21 if isinstance(destination, AI21Destination):---> 22     return cls.\_execute\_studio\_api(params) 24 raise WrongInputTypeException(key=DESTINATION\_KEY, expected\_type=Destination, given\_type=type(destination))File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/modules/completion.py:69, in Completion.\_execute\_studio\_api(cls, params) 65     url = f'{url}/{custom\_model}' 67 url = f'{url}/{cls.MODULE\_NAME}'---> 69 return execute\_studio\_request(task\_url=url, params=params)File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/modules/resources/execution\_utils.py:11, in execute\_studio\_request(task\_url, params, method) 9 def execute\_studio\_request(task\_url: str, params, method: str = 'POST'): 10     client = AI21StudioClient(\*\*params)---> 11     return client.execute\_http\_request(method=method, url=task\_url, params=params)File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/ai21\_studio\_client.py:52, in AI21StudioClient.execute\_http\_request(self, method, url, params, files) 51 def execute\_http\_request(self, method: str, url: str, params: Optional[Dict] = None, files=None):---> 52     response = self.http\_client.execute\_http\_request(method=method, url=url, params=params, files=files) 53     return convert\_to\_ai21\_object(response)File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/http\_client.py:84, in HttpClient.execute\_http\_request(self, method, url, params, files, auth) 82 if response.status\_code != 200: 83     log\_error(f'Calling {method} {url} failed with a non-200 response code: {response.status\_code}')---> 84     handle\_non\_success\_response(response.status\_code, response.text) 86 return response.json()File ~/.cache/pypoetry/virtualenvs/llama-index-2x1vjWb5-py3.10/lib/python3.10/site-packages/ai21/http\_client.py:23, in handle\_non\_success\_response(status\_code, response\_text) 21     raise BadRequest(details=response\_text) 22 if status\_code == 401:---> 23     raise Unauthorized(details=response\_text) 24 if status\_code == 422: 25     raise UnprocessableEntity(details=response\_text)Unauthorized: Failed with http status code: 401 (Unauthorized). Details: {"detail":"Forbidden: Bad or missing API token."}
```
