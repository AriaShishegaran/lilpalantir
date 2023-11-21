#!/bin/bash

# Function to check last command's success
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Function to install Homebrew on macOS
install_homebrew() {
    echo "Installing Homebrew, a package manager for macOS..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    check_success "Homebrew installation failed."
}

# Function to install Python
install_python() {
    echo "Python 3 is not installed. Installing Python 3..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install python3
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        check_success "Failed to update package list."
        sudo apt-get install -y python3
    fi
    check_success "Python installation failed."
}

# Function to install pip
install_pip() {
    echo "pip is not installed. Installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    check_success "Failed to download get-pip.py."
    python3 get-pip.py
    check_success "pip installation failed."
    rm get-pip.py
}

# Check internet connectivity
ping -c 1 8.8.8.8 > /dev/null 2>&1
check_success "Internet connection failed. Please ensure you are connected to the internet."

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

# Update pip to the latest version
echo "Updating pip to the latest version..."
python3 -m pip install --upgrade pip
check_success "Failed to upgrade pip."

# Clear pip cache
echo "Clearing pip cache..."
pip cache purge
check_success "Failed to clear pip cache."

# Install required Python packages
echo "Installing required Python packages..."
pip install python-dotenv llama_index numpy pandas requests beautifulsoup4 lxml scikit-learn nltk gensim spacy Pillow pyPDF2 python-docx openpyxl EbookLib
check_success "Failed to install required Python packages."

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
