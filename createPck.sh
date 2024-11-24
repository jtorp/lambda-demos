#!/bin/bash

read -p "Enter the name of the project directory: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project directory name cannot be empty."
    exit 1
fi

read -p "Enter the dependencies to install (space-separated, e.g., lodash express): " DEPENDENCIES
if [ -z "$DEPENDENCIES" ]; then
    echo "Error: At least one dependency must be specified."
    exit 1
fi

echo "Creating project directory: $PROJECT_NAME..."
mkdir -p "$PROJECT_NAME"

cd "$PROJECT_NAME" || { echo "Error: Failed to navigate to project directory."; exit 1; }

echo "Initializing npm project..."
npm init -y >/dev/null 2>&1
# Update the package name in package.json
sed -i '' "s/\"name\": \".*\"/\"name\": \"$PROJECT_NAME\"/" package.json || sed -i "s/\"name\": \".*\"/\"name\": \"$PROJECT_NAME\"/" package.json

echo "Installing dependencies: $DEPENDENCIES"
npm install $DEPENDENCIES

echo "Installed dependencies:"
npm list --depth=0

echo "Project setup complete in directory: $PROJECT_NAME"
echo "Installed packages: $DEPENDENCIES"
