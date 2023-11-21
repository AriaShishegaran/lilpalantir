Deplot Reader Demo[](#deplot-reader-demo "Permalink to this heading")
======================================================================

In this notebook we showcase the capabilities of our ImageTabularChartReader, which is powered by the DePlot model https://arxiv.org/abs/2212.10505.


```
!pip install llama-hub
```

```
from llama\_hub.file.image\_deplot.base import ImageTabularChartReaderfrom llama\_index import SummaryIndexfrom llama\_index.response.notebook\_utils import display\_responsefrom pathlib import Path
```

```
loader = ImageTabularChartReader(keep\_image=True)
```
Load Protected Waters Chart[](#load-protected-waters-chart "Permalink to this heading")
----------------------------------------------------------------------------------------

This chart shows the percentage of marine territorial waters that are protected for each country.


```
documents = loader.load\_data(file=Path("./marine\_chart.png"))
```

```
print(documents[0].text)
```

```
Figure or chart with tabular data: Country | Share of marine territorial waters that are protected, 2016 <0x0A> Greenland | 4.52 <0x0A> Mauritania | 4.15 <0x0A> Indonesia | 2.88 <0x0A> Ireland | 2.33
```

```
summary\_index = SummaryIndex.from\_documents(documents)response = summary\_index.as\_query\_engine().query(    "What is the difference between the shares of Greenland and the share of"    " Mauritania?")
```

```
Retrying langchain.llms.openai.completion_with_retry.<locals>._completion_with_retry in 4.0 seconds as it raised APIConnectionError: Error communicating with OpenAI: ('Connection aborted.', RemoteDisconnected('Remote end closed connection without response')).
```

```
display\_response(response, show\_source=True)
```
Load Pew Research Chart[](#load-pew-research-chart "Permalink to this heading")
--------------------------------------------------------------------------------

Here we load in a Pew Research chart showing international views of the US/Biden.

Source: https://www.pewresearch.org/global/2023/06/27/international-views-of-biden-and-u-s-largely-positive/


```
documents = loader.load\_data(file=Path("./pew1.png"))
```

```
print(documents[0].text)
```

```
Figure or chart with tabular data: Entity | Values <0x0A> Does not | 50.0 <0x0A> % who say the U.S take into account the interests of countries like theirs | 49.0 <0x0A> Does not | 38.0 <0x0A> % who say the U.S contribute to peace and stability around the world | 61.0 <0x0A> Does not | 15.0 <0x0A> % who say the U.S interfere in the affairs of other countries | 15.0 <0x0A>% who have confidence | 54.0 <0x0A> Views of President Biden | 30.0 <0x0A> Favorable | 59.0 <0x0A> Views of the U.S. | 9.0
```

```
summary\_index = SummaryIndex.from\_documents(documents)response = summary\_index.as\_query\_engine().query(    "What percentage says that the US contributes to peace and stability?")
```

```
display\_response(response, show\_source=True)
```
