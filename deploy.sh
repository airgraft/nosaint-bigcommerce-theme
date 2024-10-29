#!/bin/bash

# Exit immediately if any command fails
set -e

# Get the current date in the format "Month Day Year"
CURRENT_DATETIME=$(date +"%b %d %Y %H:%M")

# Update the "version" property in package.json with the current date and time
sed -i '' "s/\"version\": \".*\"/\"version\": \"$CURRENT_DATETIME\"/" config.json

# First command setup

# Create the first secrets.stencil.json file
cat > secrets.stencil.json <<EOL
{
  "accessToken": "6movuboeofd1ltpz37t471rid5ubolt"
}
EOL

# Create the first config.stencil.json file
cat > config.stencil.json <<EOL
{
  "customLayouts": {
    "brand": {},
    "category": {},
    "page": {},
    "product": {}
  },
  "normalStoreUrl": "https://nosaint.mybigcommerce.com",
  "port": "3001",
  "packageManager": "npm"
}
EOL

# Run stencil push with the first version
stencil push -a -d -c 1 -s "NoSaint (${CURRENT_DATE})"

# Second command setup

# Update secrets.stencil.json with the second version
cat > secrets.stencil.json <<EOL
{
  "accessToken": "k11ia15u54bl60el1mfyrft22yacn4e"
}
EOL

# Update config.stencil.json with the second version
cat > config.stencil.json <<EOL
{
  "customLayouts": {
    "brand": {},
    "category": {},
    "page": {},
    "product": {}
  },
  "normalStoreUrl": "https://nosaint-ca.mybigcommerce.com",
  "port": "3001",
  "packageManager": "npm"
}
EOL

# Run stencil push with the second version
stencil push -a -d -c 1 -s "NoSaint (${CURRENT_DATE})"

# Clean up: Remove the secrets and config files after the script is complete
rm secrets.stencil.json config.stencil.json
