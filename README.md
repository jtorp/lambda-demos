# Lambda Layer Node Setup Scritps

## Purpose

Scripts automate the setup of Lambda Layer zip files for Node.js runtime. 
1. **Creating a Node.js project** with dependencies and preparing the directory structure for Lambda layers.
2. **Creating a Lambda layer zip file** by copying the `node_modules` from your existing project and zipping them into the required structure for AWS Lambda.

### Prerequsits
- You have **Node.js** and **npm** installed on your machine.
_AWS Lambda currently supports Node.js 18.x, 20.x, and 22.x runtimes._

- You have **zip** installed (for creating the zip files).
### Scripts Overview

**`setup-script.sh`**: Initializes a new Node.js project, installs the specified dependencies.

**`prepare-layer.sh`**: Copies installed `node_modules` directory from the project, structures it for Lambda, and zips it for use in AWS Lambda Layers.

### Usage:
__Make the scripts executable:__

 ```bash
   chmod 744 ./setup-script.sh ./prepare-layer.sh
```


__Run to create package with dep:__
   ```bash
   ./setup-script.sh
   ```
*Follow the prompts:*
- Enter the name of the project name. 
- Enter the dependencies you want to install (e.g., lodash uuid ...).


__Copy and Zip:__
 ```bash
   ./prepare-layer.sh
   ```

*Follow the prompts:*

- Enter the project directory containing the node_modules.
- Enter a name for the Lambda Layer zip file.
## Output:

When the `createZip.sh` script runs successfully, the directory structure inside the zip file will look like this:
```
nodejs/
└── node20/
    └── node_modules/
        ├── lodash/
        └── axios/
        ...etc
```

The zip file can then be uploaded to AWS Lambda as a custom layer zip.
