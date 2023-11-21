Response[](#module-llama_index.response.schema "Permalink to this heading")
============================================================================

Response schema.

*class* llama\_index.response.schema.PydanticResponse(*response: ~typing.Optional[~pydantic.main.BaseModel], source\_nodes: ~typing.List[~llama\_index.schema.NodeWithScore] = <factory>, metadata: ~typing.Optional[~typing.Dict[str, ~typing.Any]] = None*)[](#llama_index.response.schema.PydanticResponse "Permalink to this definition")PydanticResponse object.

Returned if streaming=False.

response[](#llama_index.response.schema.PydanticResponse.response "Permalink to this definition")The response text.

TypeOptional[pydantic.main.BaseModel]

get\_formatted\_sources(*length: int = 100*) → str[](#llama_index.response.schema.PydanticResponse.get_formatted_sources "Permalink to this definition")Get formatted sources text.

get\_response() → [Response](#llama_index.response.schema.Response "llama_index.response.schema.Response")[](#llama_index.response.schema.PydanticResponse.get_response "Permalink to this definition")Get a standard response object.

*class* llama\_index.response.schema.Response(*response: ~typing.Optional[str], source\_nodes: ~typing.List[~llama\_index.schema.NodeWithScore] = <factory>, metadata: ~typing.Optional[~typing.Dict[str, ~typing.Any]] = None*)[](#llama_index.response.schema.Response "Permalink to this definition")Response object.

Returned if streaming=False.

response[](#llama_index.response.schema.Response.response "Permalink to this definition")The response text.

TypeOptional[str]

get\_formatted\_sources(*length: int = 100*) → str[](#llama_index.response.schema.Response.get_formatted_sources "Permalink to this definition")Get formatted sources text.

*class* llama\_index.response.schema.StreamingResponse(*response\_gen: ~typing.Generator[str, None, None], source\_nodes: ~typing.List[~llama\_index.schema.NodeWithScore] = <factory>, metadata: ~typing.Optional[~typing.Dict[str, ~typing.Any]] = None, response\_txt: ~typing.Optional[str] = None*)[](#llama_index.response.schema.StreamingResponse "Permalink to this definition")StreamingResponse object.

Returned if streaming=True.

response\_gen[](#llama_index.response.schema.StreamingResponse.response_gen "Permalink to this definition")The response generator.

TypeGenerator[str, None, None]

get\_formatted\_sources(*length: int = 100*, *trim\_text: int = True*) → str[](#llama_index.response.schema.StreamingResponse.get_formatted_sources "Permalink to this definition")Get formatted sources text.

get\_response() → [Response](#llama_index.response.schema.Response "llama_index.response.schema.Response")[](#llama_index.response.schema.StreamingResponse.get_response "Permalink to this definition")Get a standard response object.

print\_response\_stream() → None[](#llama_index.response.schema.StreamingResponse.print_response_stream "Permalink to this definition")Print the response stream.

