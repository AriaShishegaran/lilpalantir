
# LilPalantir Installation Guide

This guide provides comprehensive instructions for installing and configuring LilPalantir, a command-line tool for querying local knowledge.

## Pre-installation Requirements

- **Operating System**: Ensure you are running MacOS or Linux.
- **Python**: Python 3.x is required. Check your Python version with `python3 --version`.

## Installation Process

1. **Clone Repository**: Start by cloning the LilPalantir repository to your local machine.
2. **Run Installation Script**: Execute `install.sh` for MacOS/Linux or `install.bat` for Windows.
3. **Grant Execution Rights**: For Linux and MacOS, run `chmod +x install.sh`.

The script automates the following:
- Checks internet connectivity.
- Installs Homebrew (MacOS).
- Installs Python and pip if not present.
- Installs necessary Python packages.

### Optional: Virtual Environment
Consider creating a Python virtual environment before installation to manage dependencies.

```bash
python3 -m venv venv
source venv/bin/activate
```

## Post-installation Steps

- **Verify Installation**: Run `python3 -m pip list` to see installed packages.
- **API Key Setup**: Enter your OpenAI API key when prompted.

## Troubleshooting

Refer to the error logs or console output if you encounter installation issues. Common errors might include permission denials or package conflicts.

## Cleanup and Maintenance

- Remove any temporary files created during installation.
- Deactivate and remove the virtual environment if used.

```bash
deactivate
rm -rf venv
```

## Manual Steps and User Interactions

- You will be prompted to enter the OpenAI API key during setup.
- Confirm installations and updates when prompted.

## Dependencies and Purpose

Each installed package serves a specific role in the functionality of LilPalantir:

- `python-dotenv`: Manage environment variables.
- `llama_index`: Core dependency for querying.
- Other packages like `numpy`, `pandas`, `requests`, etc., provide various utilities for data handling and web interactions.

---

Remember to keep your installation updated and check the [official documentation](https://github.com/LilPalantir) for the latest updates and features.

