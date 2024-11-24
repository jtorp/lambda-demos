#!/bin/bash

# Which directory containing node_modules to copy
read -p "Enter the project directory containing node_modules: " PROJECT_DIR
if [ -z "$PROJECT_DIR" ]; then
    echo "Error: Project directory name cannot be empty."
    exit 1
fi

if [ ! -d "$PROJECT_DIR/node_modules" ]; then
    echo "Error: 'node_modules' directory not found in $PROJECT_DIR."
    exit 1
fi

#Name of the Lambda Layer zip
read -p "Enter the name of the zipped Lambda Layer (e.g., your project name_layer): " LAYER_NAME
if [ -z "$LAYER_NAME" ]; then
    echo "Error: Lambda Layer name cannot be empty."
    exit 1
fi

# Step 1: Create the required directory aws structure for the layer
echo "Creating directory structure for Lambda Layer..."
mkdir -p nodejs/node20

# Step 2: Copy the entire node_modules directory into nodejs/node20
echo "Copying 'node_modules' directory to layer directory..."
cp -r "$PROJECT_DIR/node_modules" nodejs/node20/

# Step 3: Zip the contents of the nodejs 
ZIP_FILE="${LAYER_NAME}_layer.zip"
echo "Zipping the layer contents into '${ZIP_FILE}'..."
zip -r "$ZIP_FILE" nodejs >/dev/null 2>&1

echo "Cleaning up temporary files..."
rm -rf nodejs

echo "Layer content prepared and zipped as '${ZIP_FILE}'."

exit 0