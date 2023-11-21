import os
import sys
from llama_index import VectorStoreIndex, SimpleDirectoryReader, ServiceContext

# Set your OpenAI API key here
OPENAI_API_KEY = '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'

def index_documents(documents_path):
    # Set the API key in the environment
    os.environ["OPENAI_API_KEY"] = OPENAI_API_KEY

    # Determine the default path based on OS
    if sys.platform.startswith('darwin'):
        default_path = os.path.expanduser('~/Documents/LlamaIndexDB')
    elif sys.platform.startswith('win32'):
        default_path = os.path.expanduser('~\\Documents\\LlamaIndexDB')
    else:
        raise Exception("Unsupported OS. This script supports macOS and Windows only.")

    # Create the directory if it doesn't exist
    if not os.path.exists(default_path):
        os.makedirs(default_path)
        print(f"Created directory: {default_path}")
    else:
        print(f"Directory already exists: {default_path}")

    # Inform the user about the default path
    print(f"Default vector database path: {default_path}")

    # Load documents
    print(f"Loading documents from: {documents_path}")
    documents = SimpleDirectoryReader(documents_path).load_data()

    # Use the default ServiceContext
    llm_service_context = ServiceContext.from_defaults()

    # Check if an existing index is present and load or create index
    index_file_path = os.path.join(default_path, 'index_file')
    if os.path.exists(index_file_path):
        print("Loading existing index...")
        index = VectorStoreIndex.load(index_file_path, service_context=llm_service_context)
    else:
        print("Creating new index...")
        index = VectorStoreIndex.from_documents(documents, service_context=llm_service_context)

    # Update the index with new documents
    print("Updating index with new documents...")
    for document in documents:
        # Update each document individually
        index.update(document)

    # Persist updated index to disk
    print(f"Persisting updated index to storage at {default_path}")
    index.storage_context.persist()
    print("Indexing completed successfully. Data is persisted at:", default_path)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python loader.py <path_to_documents>")
        sys.exit(1)

    documents_path = sys.argv[1]
    print(f"Starting indexing of '{documents_path}'")
    index_documents(documents_path)
    print(f"Indexed '{documents_path}' successfully. Vector DB is updated and persisted at the default path.")
