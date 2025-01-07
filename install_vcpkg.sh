#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define vcpkg directory
VCPKG_DIR="$HOME/vcpkg"

# Install prerequisites
echo "Installing prerequisites..."
sudo apt update && sudo apt install -y build-essential cmake git zip unzip tar pkg-config

# Clone the vcpkg repository
if [ ! -d "$VCPKG_DIR" ]; then
    echo "Cloning vcpkg repository..."
    git clone https://github.com/microsoft/vcpkg.git "$VCPKG_DIR"
else
    echo "vcpkg directory already exists. Skipping clone."
fi

# Build vcpkg
echo "Building vcpkg..."
cd "$VCPKG_DIR"
./bootstrap-vcpkg.sh

# Add vcpkg to PATH by creating a symbolic link
echo "Creating symbolic link for vcpkg..."
if [ ! -L "/usr/local/bin/vcpkg" ]; then
    sudo ln -s "$VCPKG_DIR/vcpkg" /usr/local/bin/vcpkg
    echo "vcpkg linked to /usr/local/bin/vcpkg"
else
    echo "vcpkg already linked in /usr/local/bin. Skipping."
fi

# Test vcpkg installation
echo "Testing vcpkg installation..."
vcpkg --version

echo "vcpkg installation complete!"

echo "To use vcpkg with CMake, add the following to your CMake configuration:"
echo "-DCMAKE_TOOLCHAIN_FILE=$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake"
