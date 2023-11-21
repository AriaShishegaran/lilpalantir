[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/jerryjliu/llama_index/blob/main/docs/examples/query_engine/pandas_query_engine.ipynb)

Pandas Query Engine[](#pandas-query-engine "Permalink to this heading")
========================================================================

If you’re opening this Notebook on colab, you will probably need to install LlamaIndex 🦙.


```
!pip install llama-index
```

```
import loggingimport sysfrom IPython.display import Markdown, displayimport pandas as pdfrom llama\_index.query\_engine import PandasQueryEnginelogging.basicConfig(stream=sys.stdout, level=logging.INFO)logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))
```
Let’s start on a Toy DataFrame[](#let-s-start-on-a-toy-dataframe "Permalink to this heading")
----------------------------------------------------------------------------------------------

Very simple dataframe containing city and population pairs.


```
# Test on some sample datadf = pd.DataFrame(    {        "city": ["Toronto", "Tokyo", "Berlin"],        "population": [2930000, 13960000, 3645000],    })
```

```
query\_engine = PandasQueryEngine(df=df, verbose=True)
```

```
response = query\_engine.query(    "What is the city with the highest population?",)
```

```
> Pandas Instructions:```df['city'][df['population'].idxmax()]```> Pandas Output: Tokyo
```

```
display(Markdown(f"<b>{response}</b>"))
```
**Tokyo**


```
# get pandas python instructionsprint(response.metadata["pandas\_instruction\_str"])
```

```
df['city'][df['population'].idxmax()]
```
Analyzing the Titanic Dataset[](#analyzing-the-titanic-dataset "Permalink to this heading")
--------------------------------------------------------------------------------------------

The Titanic dataset is one of the most popular tabular datasets in introductory machine learningSource: https://www.kaggle.com/c/titanic

### Download Data[](#download-data "Permalink to this heading")


```
!wget 'https://raw.githubusercontent.com/jerryjliu/llama\_index/main/docs/examples/data/csv/titanic\_train.csv' -O 'titanic\_train.csv'
```

```
df = pd.read\_csv("./titanic\_train.csv")
```

```
query\_engine = PandasQueryEngine(df=df, verbose=True)
```

```
response = query\_engine.query(    "What is the correlation between survival and age?",)
```

```
> Pandas Instructions:```df['survived'].corr(df['age'])```> Pandas Output: -0.07722109457217768
```

```
display(Markdown(f"<b>{response}</b>"))
```
**-0.07722109457217768**


```
# get pandas python instructionsprint(response.metadata["pandas\_instruction\_str"])
```

```
df['survived'].corr(df['age'])
```
