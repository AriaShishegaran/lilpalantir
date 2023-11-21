Azure OpenAI[](#azure-openai "Permalink to this heading")
==========================================================

*pydantic model* llama\_index.llms.azure\_openai.AzureOpenAI[](#llama_index.llms.azure_openai.AzureOpenAI "Permalink to this definition")Azure OpenAI.

To use this, you must first deploy a model on Azure OpenAI.Unlike OpenAI, you need to specify a engine parameter to identifyyour deployment (called “model deployment name” in Azure portal).

* model: Name of the model (e.g. text-davinci-003)This in only used to decide completion vs. chat endpoint.
* engine: This will correspond to the custom name you chosefor your deployment when you deployed a model.

You must have the following environment variables set:- OPENAI\_API\_VERSION: set this to 2023-05-15


> This may change in the future.
> 
> 

* AZURE\_OPENAI\_ENDPOINT: your endpoint should look like the following<https://YOUR_RESOURCE_NAME.openai.azure.com/>
* AZURE\_OPENAI\_API\_KEY: your API key if the api type is azure

More information can be found here:<https://learn.microsoft.com/en-us/azure/cognitive-services/openai/quickstart?tabs=command-line&pivots=programming-language-python>

Show JSON schema
```
{ "title": "AzureOpenAI", "description": "Azure OpenAI.\n\nTo use this, you must first deploy a model on Azure OpenAI.\nUnlike OpenAI, you need to specify a `engine` parameter to identify\nyour deployment (called \"model deployment name\" in Azure portal).\n\n- model: Name of the model (e.g. `text-davinci-003`)\n This in only used to decide completion vs. chat endpoint.\n- engine: This will correspond to the custom name you chose\n for your deployment when you deployed a model.\n\nYou must have the following environment variables set:\n- `OPENAI\_API\_VERSION`: set this to `2023-05-15`\n This may change in the future.\n- `AZURE\_OPENAI\_ENDPOINT`: your endpoint should look like the following\n https://YOUR\_RESOURCE\_NAME.openai.azure.com/\n- `AZURE\_OPENAI\_API\_KEY`: your API key if the api type is `azure`\n\nMore information can be found here:\n https://learn.microsoft.com/en-us/azure/cognitive-services/openai/quickstart?tabs=command-line&pivots=programming-language-python", "type": "object", "properties": { "callback\_manager": { "title": "Callback Manager" }, "model": { "title": "Model", "description": "The OpenAI model to use.", "type": "string" }, "temperature": { "title": "Temperature", "description": "The temperature to use during generation.", "type": "number" }, "max\_tokens": { "title": "Max Tokens", "description": "The maximum number of tokens to generate.", "type": "integer" }, "additional\_kwargs": { "title": "Additional Kwargs", "description": "Additional kwargs for the OpenAI API.", "type": "object" }, "max\_retries": { "title": "Max Retries", "description": "The maximum number of API retries.", "default": 3, "gte": 0, "type": "integer" }, "timeout": { "title": "Timeout", "description": "The timeout, in seconds, for API requests.", "default": 60.0, "gte": 0, "type": "number" }, "api\_key": { "title": "Api Key", "description": "The OpenAI API key.", "type": "string" }, "api\_base": { "title": "Api Base", "description": "The base URL for OpenAI API.", "type": "string" }, "api\_version": { "title": "Api Version", "description": "The API version for OpenAI API.", "type": "string" }, "engine": { "title": "Engine", "description": "The name of the deployed azure engine.", "type": "string" }, "azure\_endpoint": { "title": "Azure Endpoint", "description": "The Azure endpoint to use.", "type": "string" }, "azure\_deployment": { "title": "Azure Deployment", "description": "The Azure deployment to use.", "type": "string" }, "use\_azure\_ad": { "title": "Use Azure Ad", "description": "Indicates if Microsoft Entra ID (former Azure AD) is used for token authentication", "type": "boolean" } }, "required": [ "model", "temperature", "api\_base", "api\_version", "engine", "use\_azure\_ad" ]}
```


Config* **arbitrary\_types\_allowed**: *bool = True*
Fields* [`azure\_deployment (Optional[str])`](#llama_index.llms.azure_openai.AzureOpenAI.azure_deployment "llama_index.llms.azure_openai.AzureOpenAI.azure_deployment")
* [`azure\_endpoint (Optional[str])`](#llama_index.llms.azure_openai.AzureOpenAI.azure_endpoint "llama_index.llms.azure_openai.AzureOpenAI.azure_endpoint")
* [`engine (str)`](#llama_index.llms.azure_openai.AzureOpenAI.engine "llama_index.llms.azure_openai.AzureOpenAI.engine")
* [`use\_azure\_ad (bool)`](#llama_index.llms.azure_openai.AzureOpenAI.use_azure_ad "llama_index.llms.azure_openai.AzureOpenAI.use_azure_ad")
Validators* `\_validate\_callback\_manager` » `callback\_manager`
* [`validate\_env`](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "llama_index.llms.azure_openai.AzureOpenAI.validate_env") » `all fields`
*field* azure\_deployment*: Optional[str]* *= None*[](#llama_index.llms.azure_openai.AzureOpenAI.azure_deployment "Permalink to this definition")The Azure deployment to use.

Validated by* [`validate\_env`](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "llama_index.llms.azure_openai.AzureOpenAI.validate_env")
*field* azure\_endpoint*: Optional[str]* *= None*[](#llama_index.llms.azure_openai.AzureOpenAI.azure_endpoint "Permalink to this definition")The Azure endpoint to use.

Validated by* [`validate\_env`](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "llama_index.llms.azure_openai.AzureOpenAI.validate_env")
*field* engine*: str* *[Required]*[](#llama_index.llms.azure_openai.AzureOpenAI.engine "Permalink to this definition")The name of the deployed azure engine.

Validated by* [`validate\_env`](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "llama_index.llms.azure_openai.AzureOpenAI.validate_env")
*field* use\_azure\_ad*: bool* *[Required]*[](#llama_index.llms.azure_openai.AzureOpenAI.use_azure_ad "Permalink to this definition")Indicates if Microsoft Entra ID (former Azure AD) is used for token authentication

Validated by* [`validate\_env`](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "llama_index.llms.azure_openai.AzureOpenAI.validate_env")
*classmethod* class\_name() → str[](#llama_index.llms.azure_openai.AzureOpenAI.class_name "Permalink to this definition")Get the class name, used as a unique ID in serialization.

This provides a key that makes serialization robust against actual classname changes.

*validator* validate\_env*»* *all fields*[](#llama_index.llms.azure_openai.AzureOpenAI.validate_env "Permalink to this definition")Validate necessary credentials are set.

