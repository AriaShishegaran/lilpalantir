[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/finetuning/gradient/gradient_fine_tuning.ipynb)

Fine Tuning Nous-Hermes-2 With Gradient and LlamaIndex[](#fine-tuning-nous-hermes-2-with-gradient-and-llamaindex "Permalink to this heading")
==============================================================================================================================================


```
!pip install llama-index gradientai -q
```

```
import osfrom llama\_index.llms import GradientBaseModelLLMfrom llama\_index.finetuning.gradient.base import GradientFinetuneEngine
```

```
os.environ["GRADIENT\_ACCESS\_TOKEN"] = ""os.environ["GRADIENT\_WORKSPACE\_ID"] = ""
```

```
questions = [    "Where do foo-bears live?",    "What do foo-bears look like?",    "What do foo-bears eat?",]prompts = list(    f"<s> ### Instruction:\n{q}\n\n###Response:\n" for q in questions)
```

```
base\_model\_slug = "nous-hermes2"base\_model\_llm = GradientBaseModelLLM(    base\_model\_slug=base\_model\_slug, max\_tokens=100)
```

```
base\_model\_responses = list(base\_model\_llm.complete(p).text for p in prompts)
```

```
finetune\_engine = GradientFinetuneEngine(    base\_model\_slug=base\_model\_slug,    name="my test finetune engine model adapter",    data\_path="data.jsonl",)
```

```
# warming up with the first epoch can lead to better results, our current optimizers are momentum basedepochs = 2for i in range(epochs):    finetune\_engine.finetune()fine\_tuned\_model = finetune\_engine.get\_finetuned\_model(max\_tokens=100)
```

```
fine\_tuned\_model\_responses = list(    fine\_tuned\_model.complete(p).text for p in prompts)fine\_tuned\_model.\_model.delete()
```

```
for i, q in enumerate(questions):    print(f"Question: {q}")    print(f"Base: {base\_model\_responses[i]}")    print(f"Fine tuned: {fine\_tuned\_model\_responses[i]}")    print()
```

```
Question: Where do foo-bears live?Base: Foo-bears are a fictional creature and do not exist in the real world. Therefore, they do not have a specific location where they live.Fine tuned: Foo-bears live in the deepest, darkest part of the forest.Question: What do foo-bears look like?Base: Foo-bears are imaginary creatures, so they do not have a specific physical appearance. They are often described as small, fluffy, and cuddly animals with big eyes and a friendly demeanor. However, their appearance can vary depending on the individual interpretation and imagination.Fine tuned: Foo-bears are marsupials native to Australia. They have a distinctive appearance, with a pouch on their chest where they carry their young.Question: What do foo-bears eat?Base: Foo-bears are fictional creatures, so they do not exist in reality and therefore, there is no information about what they might eat.Fine tuned: Foo-bears are herbivores and eat mostly leaves and grasses.
```
