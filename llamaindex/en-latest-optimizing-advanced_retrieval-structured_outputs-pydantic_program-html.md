Pydantic Program[](#pydantic-program "Permalink to this heading")
==================================================================

A pydantic program is a generic abstraction that takes in an input string and converts it to a structured Pydantic object type.

Because this abstraction is so generic, it encompasses a broad range of LLM workflows. The programs are composable and be for more generic or specific use cases.

There’s a few general types of Pydantic Programs:

* **LLM Text Completion Pydantic Programs**: These convert input text into a user-specified structured object through a text completion API + output parsing.
* **LLM Function Calling Pydantic Program**: These convert input text into a user-specified structured object through an LLM function calling API.
* **Prepackaged Pydantic Programs**: These convert input text into prespecified structured objects.

LLM Text Completion Pydantic Programs[](#llm-text-completion-pydantic-programs "Permalink to this heading")
------------------------------------------------------------------------------------------------------------

TODO: Coming soon!

LLM Function Calling Pydantic Programs[](#llm-function-calling-pydantic-programs "Permalink to this heading")
--------------------------------------------------------------------------------------------------------------

* [OpenAI Pydantic Program](../../../examples/output_parsing/openai_pydantic_program.html)
* [Guidance Pydantic Program](../../../examples/output_parsing/guidance_pydantic_program.html)
* [Guidance for Sub-Question Query Engine](../../../examples/output_parsing/guidance_sub_question.html)
Prepackaged Pydantic Programs[](#prepackaged-pydantic-programs "Permalink to this heading")
--------------------------------------------------------------------------------------------

* [DataFrame Structured Data Extraction](../../../examples/output_parsing/df_program.html)
* [Evaporate Demo](../../../examples/output_parsing/evaporate_program.html)
