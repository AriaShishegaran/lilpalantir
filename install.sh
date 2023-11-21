#!/bin/bash

# Function to install Homebrew on macOS
install_homebrew() {
    echo "Installing Homebrew, a package manager for macOS..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install Python
install_python() {
    echo "Python 3 is not installed. Installing Python 3..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install python3
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install python3
    fi
}

# Function to install pip
install_pip() {
    echo "pip is not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
}

# Check for Homebrew on macOS and install if not present
if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew &> /dev/null; then
    install_homebrew
fi

# Check for Python and install if not present
if ! command -v python3 &> /dev/null; then
    install_python
else
    echo "Python 3 is already installed."
fi

# Check for pip and install if not present
if ! command -v pip3 &> /dev/null; then
    install_pip
else
    echo "pip is already installed."
fi

# Create a virtual environment
# echo "Creating a virtual environment..."
# python3 -m venv venv
# source venv/bin/activate

# Update pip to the latest version
echo "Updating pip to the latest version..."
pip install --upgrade pip

# Clear pip cache
echo "Clearing pip cache..."
pip cache purge

# Install required Python packages
echo "Installing required Python packages..."
pip install python-dotenv llama_index

# Additional dependencies (if any) based on your Python code
# Example: pip install numpy pandas

# Setup .env file
echo "Setting up the .env file..."
if [ ! -f .env ]; then
    touch .env
    echo "Please enter your OpenAI API key: "
    read OPENAI_API_KEY
    echo "OPENAI_API_KEY=$OPENAI_API_KEY" >> .env
else
    echo ".env file already exists."
fi

echo "Installation and configuration completed successfully."
