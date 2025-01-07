#!/bin/bash

# Define vcpkg directory
VCPKG_DIR="$HOME/vcpkg"

# Exit immediately if a command exits with a non-zero status
set -e

# Check if vcpkg directory exists
if [ ! -d "$VCPKG_DIR" ]; then
    echo "vcpkg is not installed. Please install it first."
    exit 1
fi

# Navigate to vcpkg directory
cd "$VCPKG_DIR"

# Pull the latest changes from GitHub
echo "Pulling the latest changes from GitHub..."
git pull

# Rebuild vcpkg
echo "Rebuilding vcpkg..."
./bootstrap-vcpkg.sh

# Update installed libraries
echo "Updating installed libraries..."
vcpkg upgrade --no-dry-run

echo "vcpkg update complete!"
