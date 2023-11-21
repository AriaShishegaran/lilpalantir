@echo off
CLS

REM Check for Python and install if not present
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Python is not installed. Please install Python and rerun this script.
    EXIT /B 1
) ELSE (
    ECHO Python is installed.
)

REM Check for pip and install if not present
pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO pip is not installed. Installing pip...
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
    del get-pip.py
) ELSE (
    ECHO pip is installed.
)

REM Create a virtual environment
@REM ECHO Creating a virtual environment...
@REM python -m venv venv
@REM CALL venv\Scripts\activate.bat

REM Install required Python packages
ECHO Installing required Python packages...
pip install dotenv llama_index

REM Additional dependencies (if any) based on your Python code
REM Example: pip install numpy pandas

REM Setup .env file
ECHO Setting up the .env file...
IF NOT EXIST .env (
    ECHO OPENAI_API_KEY= > .env
    SET /P OPENAI_API_KEY="Please enter your OpenAI API key: "
    ECHO OPENAI_API_KEY=%OPENAI_API_KEY%>> .env
) ELSE (
    ECHO .env file already exists.
)

ECHO Installation and configuration completed successfully.
PAUSE
