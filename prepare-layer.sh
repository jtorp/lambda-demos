#!/bin/bash

read -p "Enter the project directory containing node_modules: " PROJECT_DIR
if [ -z "$PROJECT_DIR" ]; then
    echo "Error: Project directory name cannot be empty."
    exit 1
fi

if [ ! -d "$PROJECT_DIR/node_modules" ]; then
    echo "Error: 'node_modules' directory not found in $PROJECT_DIR."
    exit 1
fi

read -p "Enter the Node.js version for the layer (e.g., 18, 20, 22): " NODE_VERSION
if [ -z "$NODE_VERSION" ]; then
    echo "Error: Node.js version cannot be empty."
    exit 1
fi

# Validate version
if [[ ! "$NODE_VERSION" =~ ^(18|20|22)$ ]]; then
    echo "Error: Invalid Node.js version. Please choose from 18, 20, or 22."
    exit 1
fi

LAYER_DIR="nodejs/node$NODE_VERSION"
echo "Creating directory structure for Lambda Layer (node$NODE_VERSION)..."
mkdir -p "$LAYER_DIR"

echo "Copying 'node_modules' directory to layer directory..."
cp -r "$PROJECT_DIR/node_modules" "$LAYER_DIR/"

read -p "Enter the name of the zipped Lambda Layer (e.g., your project name_layer): " LAYER_NAME
if [ -z "$LAYER_NAME" ]; then
    echo "Error: Lambda Layer name cannot be empty."
    exit 1
fi

ZIP_FILE="${LAYER_NAME}_layer.zip"
echo "Zipping the layer contents into '${ZIP_FILE}'..."
zip -r "$ZIP_FILE" nodejs >/dev/null 2>&1

echo "Cleaning up temporary files..."
rm -rf nodejs

echo "Layer content prepared and zipped as '${ZIP_FILE}'."
exit 0
