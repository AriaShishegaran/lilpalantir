Guidance[](#guidance "Permalink to this heading")
==================================================

[Guidance](https://github.com/microsoft/guidance) is a guidance language for controlling large language models developed by Microsoft.

Guidance programs allow you to interleave generation, prompting, and logical control into a single continuous flow matching how the language model actually processes the text.

Structured Output[](#structured-output "Permalink to this heading")
--------------------------------------------------------------------

One particularly exciting aspect of guidance is the ability to output structured objects (think JSON following a specific schema, or a pydantic object). Instead of just “suggesting” the desired output structure to the LLM, guidance can actually “force” the LLM output to follow the desired schema. This allows the LLM to focus on the content rather than the syntax, and completely eliminate the possibility of output parsing issues.

This is particularly powerful for weaker LLMs which be smaller in parameter count, and not trained on sufficient source code data to be able to reliably produce well-formed, hierarchical structured output.

### Creating a guidance program to generate pydantic objects[](#creating-a-guidance-program-to-generate-pydantic-objects "Permalink to this heading")

In LlamaIndex, we provide an initial integration with guidance, to make it super easy for generating structured output (more specifically pydantic objects).

For example, if we want to generate an album of songs, with the following schema:


```
class Song(BaseModel):    title: str    length\_seconds: intclass Album(BaseModel):    name: str    artist: str    songs: List[Song]
```
It’s as simple as creating a `GuidancePydanticProgram`, specifying our desired pydantic class `Album`,and supplying a suitable prompt template.


> Note: guidance uses handlebars-style templates, which uses double braces for variable substitution, and single braces for literal braces. This is the opposite convention of Python format strings.
> 
> 


> Note: We provide an utility function `from llama\_index.prompts.guidance\_utils import convert\_to\_handlebars` that can convert from the Python format string style template to guidance handlebars-style template.
> 
> 


```
program = GuidancePydanticProgram(    output\_cls=Album,    prompt\_template\_str="Generate an example album, with an artist and a list of songs. Using the movie {{movie\_name}} as inspiration",    guidance\_llm=OpenAI("text-davinci-003"),    verbose=True,)
```
Now we can run the program by calling it with additional user input.Here let’s go for something spooky and create an album inspired by the Shining.


```
output = program(movie\_name="The Shining")
```
We have our pydantic object:


```
Album(    name="The Shining",    artist="Jack Torrance",    songs=[        Song(title="All Work and No Play", length\_seconds=180),        Song(title="The Overlook Hotel", length\_seconds=240),        Song(title="The Shining", length\_seconds=210),    ],)
```
You can play with [this notebook](../../examples/output_parsing/guidance_pydantic_program.html) for more details.

### Using guidance to improve the robustness of our sub-question query engine.[](#using-guidance-to-improve-the-robustness-of-our-sub-question-query-engine "Permalink to this heading")

LlamaIndex provides a toolkit of advanced query engines for tackling different use-cases.Several relies on structured output in intermediate steps.We can use guidance to improve the robustness of these query engines, by making sure theintermediate response has the expected structure (so that they can be parsed correctly to a structured object).

As an example, we implement a `GuidanceQuestionGenerator` that can be plugged into a `SubQuestionQueryEngine` to make it more robust than using the default setting.


```
from llama\_index.question\_gen.guidance\_generator import (    GuidanceQuestionGenerator,)from guidance.llms import OpenAI as GuidanceOpenAI# define guidance based question generatorquestion\_gen = GuidanceQuestionGenerator.from\_defaults(    guidance\_llm=GuidanceOpenAI("text-davinci-003"), verbose=False)# define query engine toolsquery\_engine\_tools = ...# construct sub-question query engines\_engine = SubQuestionQueryEngine.from\_defaults(    question\_gen=question\_gen,  # use guidance based question\_gen defined above    query\_engine\_tools=query\_engine\_tools,)
```
See [this notebook](../../examples/output_parsing/guidance_sub_question.html) for more details.

