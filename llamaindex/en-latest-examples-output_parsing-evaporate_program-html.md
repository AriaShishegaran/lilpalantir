[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/examples/output_parsing/evaporate_program.ipynb)

Evaporate Demo[](#evaporate-demo "Permalink to this heading")
==============================================================

This demo shows how you can extract DataFrame from raw text using the Evaporate paper (Arora et al.): https://arxiv.org/abs/2304.09433.

The inspiration is to first “fit” on a set of training text. The fitting process uses the LLM to generate a set of parsing functions from the text.These fitted functions are then applied to text during inference time.

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
%load\_ext autoreload%autoreload 2
```

```
from llama\_index import SimpleDirectoryReader, ServiceContext, LLMPredictorfrom llama\_index.program.predefined import (    DFEvaporateProgram,    EvaporateExtractor,    MultiValueEvaporateProgram,)from llama\_index.llms import OpenAIimport requests
```
Use `DFEvaporateProgram`[](#use-dfevaporateprogram "Permalink to this heading")
--------------------------------------------------------------------------------

The `DFEvaporateProgram` will extract a 2D dataframe from a set of datapoints given a set of fields, and some training data to “fit” some functions on.

### Load data[](#load-data "Permalink to this heading")

Here we load a set of cities from Wikipedia.


```
wiki\_titles = ["Toronto", "Seattle", "Chicago", "Boston", "Houston"]
```

```
from pathlib import Pathimport requestsfor title in wiki\_titles:    response = requests.get(        "https://en.wikipedia.org/w/api.php",        params={            "action": "query",            "format": "json",            "titles": title,            "prop": "extracts",            # 'exintro': True,            "explaintext": True,        },    ).json()    page = next(iter(response["query"]["pages"].values()))    wiki\_text = page["extract"]    data\_path = Path("data")    if not data\_path.exists():        Path.mkdir(data\_path)    with open(data\_path / f"{title}.txt", "w") as fp:        fp.write(wiki\_text)
```

```
# Load all wiki documentscity\_docs = {}for wiki\_title in wiki\_titles:    city\_docs[wiki\_title] = SimpleDirectoryReader(        input\_files=[f"data/{wiki\_title}.txt"]    ).load\_data()
```
### Parse Data[](#parse-data "Permalink to this heading")


```
# setup service contextllm = OpenAI(temperature=0, model="gpt-3.5-turbo")service\_context = ServiceContext.from\_defaults(llm=llm, chunk\_size=512)
```

```
# get nodes for each documentcity\_nodes = {}for wiki\_title in wiki\_titles:    docs = city\_docs[wiki\_title]    nodes = service\_context.node\_parser.get\_nodes\_from\_documents(docs)    city\_nodes[wiki\_title] = nodes
```
### Running the DFEvaporateProgram[](#running-the-dfevaporateprogram "Permalink to this heading")

Here we demonstrate how to extract datapoints with our `DFEvaporateProgram`. Given a set of fields, the `DFEvaporateProgram` can first fit functions on a set of training data, and then run extraction over inference data.


```
# define programprogram = DFEvaporateProgram.from\_defaults(    fields\_to\_extract=["population"], service\_context=service\_context)
```
### Fitting Functions[](#fitting-functions "Permalink to this heading")


```
program.fit\_fields(city\_nodes["Toronto"][:1])
```

```
{'population': 'def get_population_field(text: str):\n    """\n    Function to extract population. \n    """\n    \n    # Use regex to find the population field\n    pattern = r\'(?<=population of )(\\d+,?\\d*)\'\n    population_field = re.search(pattern, text).group(1)\n    \n    # Return the population field as a single value\n    return int(population_field.replace(\',\', \'\'))'}
```

```
# view extracted functionprint(program.get\_function\_str("population"))
```

```
def get_population_field(text: str):    """    Function to extract population.     """        # Use regex to find the population field    pattern = r'(?<=population of )(\d+,?\d*)'    population_field = re.search(pattern, text).group(1)        # Return the population field as a single value    return int(population_field.replace(',', ''))
```
### Run Inference[](#run-inference "Permalink to this heading")


```
seattle\_df = program(nodes=city\_nodes["Seattle"][:1])
```

```
seattle\_df
```

```
DataFrameRowsOnly(rows=[DataFrameRow(row_values=[749256])])
```
Use `MultiValueEvaporateProgram`[](#use-multivalueevaporateprogram "Permalink to this heading")
------------------------------------------------------------------------------------------------

In contrast to the `DFEvaporateProgram`, which assumes the output obeys a 2D tabular format (one row per node), the `MultiValueEvaporateProgram` returns a list of `DataFrameRow` objects - each object corresponds to a column, and can contain a variable length of values. This can help if we want to extract multiple values for one field from a given piece of text.

In this example, we use this program to parse gold medal counts.


```
llm = OpenAI(temperature=0, model="gpt-4")service\_context = ServiceContext.from\_defaults(    llm=llm, chunk\_size=1024, chunk\_overlap=0)
```

```
# Olympic total medal counts: https://en.wikipedia.org/wiki/All-time\_Olympic\_Games\_medal\_tabletrain\_text = """<table class="wikitable sortable" style="margin-top:0; text-align:center; font-size:90%;"><tbody><tr><th>Team (IOC code)</th><th>No. Summer</th><th>No. Winter</th><th>No. Games</th></tr><tr><td align="left"><span id="ALB"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag\_of\_Albania.svg/22px-Flag\_of\_Albania.svg.png" decoding="async" width="22" height="16" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag\_of\_Albania.svg/33px-Flag\_of\_Albania.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag\_of\_Albania.svg/44px-Flag\_of\_Albania.svg.png 2x" data-file-width="980" data-file-height="700" />&#160;<a href="/wiki/Albania\_at\_the\_Olympics" title="Albania at the Olympics">Albania</a>&#160;<span style="font-size:90%;">(ALB)</span></span></td><td style="background:#f2f2ce;">9</td><td style="background:#cedff2;">5</td><td>14</td></tr><tr><td align="left"><span id="ASA"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag\_of\_American\_Samoa.svg/22px-Flag\_of\_American\_Samoa.svg.png" decoding="async" width="22" height="11" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag\_of\_American\_Samoa.svg/33px-Flag\_of\_American\_Samoa.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag\_of\_American\_Samoa.svg/44px-Flag\_of\_American\_Samoa.svg.png 2x" data-file-width="1000" data-file-height="500" />&#160;<a href="/wiki/American\_Samoa\_at\_the\_Olympics" title="American Samoa at the Olympics">American Samoa</a>&#160;<span style="font-size:90%;">(ASA)</span></span></td><td style="background:#f2f2ce;">9</td><td style="background:#cedff2;">2</td><td>11</td></tr><tr><td align="left"><span id="AND"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag\_of\_Andorra.svg/22px-Flag\_of\_Andorra.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag\_of\_Andorra.svg/33px-Flag\_of\_Andorra.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag\_of\_Andorra.svg/44px-Flag\_of\_Andorra.svg.png 2x" data-file-width="1000" data-file-height="700" />&#160;<a href="/wiki/Andorra\_at\_the\_Olympics" title="Andorra at the Olympics">Andorra</a>&#160;<span style="font-size:90%;">(AND)</span></span></td><td style="background:#f2f2ce;">12</td><td style="background:#cedff2;">13</td><td>25</td></tr><tr><td align="left"><span id="ANG"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag\_of\_Angola.svg/22px-Flag\_of\_Angola.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag\_of\_Angola.svg/33px-Flag\_of\_Angola.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag\_of\_Angola.svg/44px-Flag\_of\_Angola.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Angola\_at\_the\_Olympics" title="Angola at the Olympics">Angola</a>&#160;<span style="font-size:90%;">(ANG)</span></span></td><td style="background:#f2f2ce;">10</td><td style="background:#cedff2;">0</td><td>10</td></tr><tr><td align="left"><span id="ANT"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag\_of\_Antigua\_and\_Barbuda.svg/22px-Flag\_of\_Antigua\_and\_Barbuda.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag\_of\_Antigua\_and\_Barbuda.svg/33px-Flag\_of\_Antigua\_and\_Barbuda.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag\_of\_Antigua\_and\_Barbuda.svg/44px-Flag\_of\_Antigua\_and\_Barbuda.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Antigua\_and\_Barbuda\_at\_the\_Olympics" title="Antigua and Barbuda at the Olympics">Antigua and Barbuda</a>&#160;<span style="font-size:90%;">(ANT)</span></span></td><td style="background:#f2f2ce;">11</td><td style="background:#cedff2;">0</td><td>11</td></tr><tr><td align="left"><span id="ARU"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag\_of\_Aruba.svg/22px-Flag\_of\_Aruba.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag\_of\_Aruba.svg/33px-Flag\_of\_Aruba.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag\_of\_Aruba.svg/44px-Flag\_of\_Aruba.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Aruba\_at\_the\_Olympics" title="Aruba at the Olympics">Aruba</a>&#160;<span style="font-size:90%;">(ARU)</span></span></td><td style="background:#f2f2ce;">9</td><td style="background:#cedff2;">0</td><td>9</td></tr>"""train\_nodes = [Node(text=train\_text)]
```

```
infer\_text = """<td align="left"><span id="BAN"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag\_of\_Bangladesh.svg/22px-Flag\_of\_Bangladesh.svg.png" decoding="async" width="22" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag\_of\_Bangladesh.svg/33px-Flag\_of\_Bangladesh.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag\_of\_Bangladesh.svg/44px-Flag\_of\_Bangladesh.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;<a href="/wiki/Bangladesh\_at\_the\_Olympics" title="Bangladesh at the Olympics">Bangladesh</a>&#160;<span style="font-size:90%;">(BAN)</span></span></td><td style="background:#f2f2ce;">10</td><td style="background:#cedff2;">0</td><td>10</td></tr><tr><td align="left"><span id="BIZ"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag\_of\_Belize.svg/22px-Flag\_of\_Belize.svg.png" decoding="async" width="22" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag\_of\_Belize.svg/33px-Flag\_of\_Belize.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag\_of\_Belize.svg/44px-Flag\_of\_Belize.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;<a href="/wiki/Belize\_at\_the\_Olympics" title="Belize at the Olympics">Belize</a>&#160;<span style="font-size:90%;">(BIZ)</span></span> <sup class="reference" id="ref\_BIZBIZ"><a href="#endnote\_BIZBIZ">[BIZ]</a></sup></td><td style="background:#f2f2ce;">13</td><td style="background:#cedff2;">0</td><td>13</td></tr><tr><td align="left"><span id="BEN"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag\_of\_Benin.svg/22px-Flag\_of\_Benin.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag\_of\_Benin.svg/33px-Flag\_of\_Benin.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag\_of\_Benin.svg/44px-Flag\_of\_Benin.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Benin\_at\_the\_Olympics" title="Benin at the Olympics">Benin</a>&#160;<span style="font-size:90%;">(BEN)</span></span> <sup class="reference" id="ref\_BENBEN"><a href="#endnote\_BENBEN">[BEN]</a></sup></td><td style="background:#f2f2ce;">12</td><td style="background:#cedff2;">0</td><td>12</td></tr><tr><td align="left"><span id="BHU"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag\_of\_Bhutan.svg/22px-Flag\_of\_Bhutan.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag\_of\_Bhutan.svg/33px-Flag\_of\_Bhutan.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag\_of\_Bhutan.svg/44px-Flag\_of\_Bhutan.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Bhutan\_at\_the\_Olympics" title="Bhutan at the Olympics">Bhutan</a>&#160;<span style="font-size:90%;">(BHU)</span></span></td><td style="background:#f2f2ce;">10</td><td style="background:#cedff2;">0</td><td>10</td></tr><tr><td align="left"><span id="BOL"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag\_of\_Bolivia.svg/22px-Flag\_of\_Bolivia.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag\_of\_Bolivia.svg/33px-Flag\_of\_Bolivia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag\_of\_Bolivia.svg/44px-Flag\_of\_Bolivia.svg.png 2x" data-file-width="1100" data-file-height="750" />&#160;<a href="/wiki/Bolivia\_at\_the\_Olympics" title="Bolivia at the Olympics">Bolivia</a>&#160;<span style="font-size:90%;">(BOL)</span></span></td><td style="background:#f2f2ce;">15</td><td style="background:#cedff2;">7</td><td>22</td></tr><tr><td align="left"><span id="BIH"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag\_of\_Bosnia\_and\_Herzegovina.svg/22px-Flag\_of\_Bosnia\_and\_Herzegovina.svg.png" decoding="async" width="22" height="11" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag\_of\_Bosnia\_and\_Herzegovina.svg/33px-Flag\_of\_Bosnia\_and\_Herzegovina.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag\_of\_Bosnia\_and\_Herzegovina.svg/44px-Flag\_of\_Bosnia\_and\_Herzegovina.svg.png 2x" data-file-width="800" data-file-height="400" />&#160;<a href="/wiki/Bosnia\_and\_Herzegovina\_at\_the\_Olympics" title="Bosnia and Herzegovina at the Olympics">Bosnia and Herzegovina</a>&#160;<span style="font-size:90%;">(BIH)</span></span></td><td style="background:#f2f2ce;">8</td><td style="background:#cedff2;">8</td><td>16</td></tr><tr><td align="left"><span id="IVB"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag\_of\_the\_British\_Virgin\_Islands.svg/22px-Flag\_of\_the\_British\_Virgin\_Islands.svg.png" decoding="async" width="22" height="11" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag\_of\_the\_British\_Virgin\_Islands.svg/33px-Flag\_of\_the\_British\_Virgin\_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/42/Flag\_of\_the\_British\_Virgin\_Islands.svg/44px-Flag\_of\_the\_British\_Virgin\_Islands.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;<a href="/wiki/British\_Virgin\_Islands\_at\_the\_Olympics" title="British Virgin Islands at the Olympics">British Virgin Islands</a>&#160;<span style="font-size:90%;">(IVB)</span></span></td><td style="background:#f2f2ce;">10</td><td style="background:#cedff2;">2</td><td>12</td></tr><tr><td align="left"><span id="BRU"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag\_of\_Brunei.svg/22px-Flag\_of\_Brunei.svg.png" decoding="async" width="22" height="11" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag\_of\_Brunei.svg/33px-Flag\_of\_Brunei.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag\_of\_Brunei.svg/44px-Flag\_of\_Brunei.svg.png 2x" data-file-width="1440" data-file-height="720" />&#160;<a href="/wiki/Brunei\_at\_the\_Olympics" title="Brunei at the Olympics">Brunei</a>&#160;<span style="font-size:90%;">(BRU)</span></span> <sup class="reference" id="ref\_AA"><a href="#endnote\_AA">[A]</a></sup></td><td style="background:#f2f2ce;">6</td><td style="background:#cedff2;">0</td><td>6</td></tr><tr><td align="left"><span id="CAM"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag\_of\_Cambodia.svg/22px-Flag\_of\_Cambodia.svg.png" decoding="async" width="22" height="14" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag\_of\_Cambodia.svg/33px-Flag\_of\_Cambodia.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag\_of\_Cambodia.svg/44px-Flag\_of\_Cambodia.svg.png 2x" data-file-width="1000" data-file-height="640" />&#160;<a href="/wiki/Cambodia\_at\_the\_Olympics" title="Cambodia at the Olympics">Cambodia</a>&#160;<span style="font-size:90%;">(CAM)</span></span></td><td style="background:#f2f2ce;">10</td><td style="background:#cedff2;">0</td><td>10</td></tr><tr><td align="left"><span id="CPV"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag\_of\_Cape\_Verde.svg/22px-Flag\_of\_Cape\_Verde.svg.png" decoding="async" width="22" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag\_of\_Cape\_Verde.svg/33px-Flag\_of\_Cape\_Verde.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag\_of\_Cape\_Verde.svg/44px-Flag\_of\_Cape\_Verde.svg.png 2x" data-file-width="1020" data-file-height="600" />&#160;<a href="/wiki/Cape\_Verde\_at\_the\_Olympics" title="Cape Verde at the Olympics">Cape Verde</a>&#160;<span style="font-size:90%;">(CPV)</span></span></td><td style="background:#f2f2ce;">7</td><td style="background:#cedff2;">0</td><td>7</td></tr><tr><td align="left"><span id="CAY"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag\_of\_the\_Cayman\_Islands.svg/22px-Flag\_of\_the\_Cayman\_Islands.svg.png" decoding="async" width="22" height="11" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag\_of\_the\_Cayman\_Islands.svg/33px-Flag\_of\_the\_Cayman\_Islands.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag\_of\_the\_Cayman\_Islands.svg/44px-Flag\_of\_the\_Cayman\_Islands.svg.png 2x" data-file-width="1200" data-file-height="600" />&#160;<a href="/wiki/Cayman\_Islands\_at\_the\_Olympics" title="Cayman Islands at the Olympics">Cayman Islands</a>&#160;<span style="font-size:90%;">(CAY)</span></span></td><td style="background:#f2f2ce;">11</td><td style="background:#cedff2;">2</td><td>13</td></tr><tr><td align="left"><span id="CAF"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Central\_African\_Republic.svg/22px-Flag\_of\_the\_Central\_African\_Republic.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Central\_African\_Republic.svg/33px-Flag\_of\_the\_Central\_African\_Republic.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Central\_African\_Republic.svg/44px-Flag\_of\_the\_Central\_African\_Republic.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Central\_African\_Republic\_at\_the\_Olympics" title="Central African Republic at the Olympics">Central African Republic</a>&#160;<span style="font-size:90%;">(CAF)</span></span></td><td style="background:#f2f2ce;">11</td><td style="background:#cedff2;">0</td><td>11</td></tr><tr><td align="left"><span id="CHA"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag\_of\_Chad.svg/22px-Flag\_of\_Chad.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag\_of\_Chad.svg/33px-Flag\_of\_Chad.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag\_of\_Chad.svg/44px-Flag\_of\_Chad.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Chad\_at\_the\_Olympics" title="Chad at the Olympics">Chad</a>&#160;<span style="font-size:90%;">(CHA)</span></span></td><td style="background:#f2f2ce;">13</td><td style="background:#cedff2;">0</td><td>13</td></tr><tr><td align="left"><span id="COM"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag\_of\_the\_Comoros.svg/22px-Flag\_of\_the\_Comoros.svg.png" decoding="async" width="22" height="13" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag\_of\_the\_Comoros.svg/33px-Flag\_of\_the\_Comoros.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag\_of\_the\_Comoros.svg/44px-Flag\_of\_the\_Comoros.svg.png 2x" data-file-width="1000" data-file-height="600" />&#160;<a href="/wiki/Comoros\_at\_the\_Olympics" title="Comoros at the Olympics">Comoros</a>&#160;<span style="font-size:90%;">(COM)</span></span></td><td style="background:#f2f2ce;">7</td><td style="background:#cedff2;">0</td><td>7</td></tr><tr><td align="left"><span id="CGO"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag\_of\_the\_Republic\_of\_the\_Congo.svg/22px-Flag\_of\_the\_Republic\_of\_the\_Congo.svg.png" decoding="async" width="22" height="15" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag\_of\_the\_Republic\_of\_the\_Congo.svg/33px-Flag\_of\_the\_Republic\_of\_the\_Congo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag\_of\_the\_Republic\_of\_the\_Congo.svg/44px-Flag\_of\_the\_Republic\_of\_the\_Congo.svg.png 2x" data-file-width="900" data-file-height="600" />&#160;<a href="/wiki/Republic\_of\_the\_Congo\_at\_the\_Olympics" title="Republic of the Congo at the Olympics">Republic of the Congo</a>&#160;<span style="font-size:90%;">(CGO)</span></span></td><td style="background:#f2f2ce;">13</td><td style="background:#cedff2;">0</td><td>13</td></tr><tr><td align="left"><span id="COD"><img alt="" src="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg/22px-Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg.png" decoding="async" width="22" height="17" class="thumbborder" srcset="//upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg/33px-Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg.png 1.5x, //upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg/44px-Flag\_of\_the\_Democratic\_Republic\_of\_the\_Congo.svg.png 2x" data-file-width="800" data-file-height="600" />&#160;<a href="/wiki/Democratic\_Republic\_of\_the\_Congo\_at\_the\_Olympics" title="Democratic Republic of the Congo at the Olympics">Democratic Republic of the Congo</a>&#160;<span style="font-size:90%;">(COD)</span></span> <sup class="reference" id="ref\_CODCOD"><a href="#endnote\_CODCOD">[COD]</a></sup></td><td style="background:#f2f2ce;">11</td><td style="background:#cedff2;">0</td><td>11</td></tr>"""infer\_nodes = [Node(text=infer\_text)]
```

```
from llama\_index.program.predefined import MultiValueEvaporateProgramprogram = MultiValueEvaporateProgram.from\_defaults(    fields\_to\_extract=["countries", "medal\_count"],    service\_context=service\_context,)
```

```
program.fit\_fields(train\_nodes[:1])
```

```
{'countries': 'def get_countries_field(text: str):\n    """\n    Function to extract countries. \n    """\n    \n    # Use regex to extract the countries field\n    countries_field = re.findall(r\'<a href=".*">(.*)</a>\', text)\n    \n    # Return the result as a list\n    return countries_field', 'medal_count': 'def get_medal_count_field(text: str):\n    """\n    Function to extract medal_count. \n    """\n    \n    # Use regex to extract the medal count field\n    medal_count_field = re.findall(r\'<td style="background:#f2f2ce;">(.*?)</td>\', text)\n    \n    # Return the result as a list\n    return medal_count_field'}
```

```
print(program.get\_function\_str("countries"))
```

```
def get_countries_field(text: str):    """    Function to extract countries.     """        # Use regex to extract the countries field    countries_field = re.findall(r'<a href=".*">(.*)</a>', text)        # Return the result as a list    return countries_field
```

```
print(program.get\_function\_str("medal\_count"))
```

```
def get_medal_count_field(text: str):    """    Function to extract medal_count.     """        # Use regex to extract the medal count field    medal_count_field = re.findall(r'<td style="background:#f2f2ce;">(.*?)</td>', text)        # Return the result as a list    return medal_count_field
```

```
result = program(nodes=infer\_nodes[:1])
```

```
# output countriesprint(f"Countries: {result.columns[0].row\_values}\n")# output medal countsprint(f"Medal Counts: {result.columns[0].row\_values}\n")
```

```
Countries: ['Bangladesh', '[BIZ]', '[BEN]', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'British Virgin Islands', '[A]', 'Cambodia', 'Cape Verde', 'Cayman Islands', 'Central African Republic', 'Chad', 'Comoros', 'Republic of the Congo', '[COD]']Medal Counts: ['Bangladesh', '[BIZ]', '[BEN]', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'British Virgin Islands', '[A]', 'Cambodia', 'Cape Verde', 'Cayman Islands', 'Central African Republic', 'Chad', 'Comoros', 'Republic of the Congo', '[COD]']
```
Bonus: Use the underlying `EvaporateExtractor`[](#bonus-use-the-underlying-evaporateextractor "Permalink to this heading")
---------------------------------------------------------------------------------------------------------------------------

The underlying `EvaporateExtractor` offers some additional functionality, e.g. actually helping to identify fields over a set of text.

Here we show how you can use `identify\_fields` to determine relevant fields around a general `topic` field.


```
# a list of nodes, one node per city, corresponding to intro paragraph# city\_pop\_nodes = []city\_pop\_nodes = [city\_nodes["Toronto"][0], city\_nodes["Seattle"][0]]
```

```
extractor = program.extractor
```

```
# Try with Toronto and Seattle (should extract "population")existing\_fields = extractor.identify\_fields(    city\_pop\_nodes, topic="population", fields\_top\_k=4)
```

```
existing\_fields
```

```
["seattle metropolitan area's population"]
```
