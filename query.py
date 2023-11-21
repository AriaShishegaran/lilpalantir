import os
import sys
from llama_index import (
    StorageContext, load_index_from_storage, ServiceContext
)
from llama_index.llms import OpenAI

# Set your OpenAI API key here
OPENAI_API_KEY = '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'

def query_index(query):
    # Set the API key in the environment
    os.environ["OPENAI_API_KEY"] = OPENAI_API_KEY

    # Use the default ServiceContext
    llm = OpenAI(model="gpt-3.5-turbo")
    service_context = ServiceContext.from_defaults(llm=llm)

    # Querying process
    print("Loading index from storage...")
    storage_context = StorageContext.from_defaults(persist_dir="./storage")
    index = load_index_from_storage(storage_context, service_context=service_context)
    print(f"Querying index with: '{query}'")
    query_engine = index.as_query_engine()
    return query_engine.query(query)

if __name__ == "__main__":
    query = "Default query"
    if len(sys.argv) >= 2:
        query = sys.argv[1]

    print("Starting the querying process...")
    result = query_index(query)

    print(f"Query: {query}")
    print(f"Result: {result}")
    print("Querying process completed.")
