#!/bin/bash

# Discover latest version from PyPI if not provided
if [ -z "$1" ]; then
    echo "No version provided so finding latest version from PyPI..."
    VERSION=$(curl -s https://pypi.org/pypi/matlab-proxy/json | grep -oP '"version":\s*"\K[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    echo "Latest version is $VERSION"
else
    VERSION=$1
    echo "Using provided version: $VERSION"
fi
# Create a virtual environment with the name matlabproxy-<version>
python3.11 -m venv "matlabproxy-$VERSION"

# Activate the virtual environment
source "matlabproxy-$VERSION/bin/activate"

# Upgrade pip
pip install --upgrade pip

# Install the specific version of matlab-proxy
pip install "matlab-proxy==$VERSION"

# Check for the existence of matlab-proxy-app to confirm installation
if command -v matlab-proxy-app &> /dev/null; then
    echo "Virtual environment 'matlabproxy-$VERSION' created and matlab-proxy $VERSION installed successfully."
else
    echo "Error: matlab-proxy-app not found. Installation may have failed."
fi
