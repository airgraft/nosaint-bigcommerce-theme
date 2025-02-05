#!/bin/bash

# Exit immediately if any command fails
set -e

# Get the current date and time
CURRENT_DATETIME=$(date +"%b %d %Y %H:%M")

# Backup original secrets and config files if they exist
for FILE in "secrets.stencil.json" "config.stencil.json"; do
  if [ -f "$FILE" ]; then
    cp "$FILE" "$FILE.bak"
  fi
done

# Update the "title" property in config.json with the current date
sed -i '' "s/\"version\": \".*\"/\"version\": \"$CURRENT_DATETIME\"/" config.json

# Define arrays for account configurations
# ACCESS_TOKENS=("6movuboeofd1ltpz37t471rid5ubolt" "k11ia15u54bl60el1mfyrft22yacn4e")
# STORE_URLS=("https://nosaint.mybigcommerce.com" "https://nosaint-ca.mybigcommerce.com")
ACCESS_TOKENS=("6movuboeofd1ltpz37t471rid5ubolt")
STORE_URLS=("https://nosaint.mybigcommerce.com")

# Loop through each account and perform the stencil push
for i in "${!ACCESS_TOKENS[@]}"; do
  # Update secrets.stencil.json
  cat > secrets.stencil.json <<EOL
{
  "accessToken": "${ACCESS_TOKENS[$i]}"
}
EOL

  # Update config.stencil.json
  cat > config.stencil.json <<EOL
{
  "customLayouts": {
    "brand": {},
    "category": {},
    "page": {},
    "product": {}
  },
  "normalStoreUrl": "${STORE_URLS[$i]}",
  "port": "3001",
  "packageManager": "npm"
}
EOL

  # Run stencil push for the current configuration
  stencil push -a -d -c 1 -s "NoSaint (${CURRENT_DATETIME}) - Account $((i+1))"
done

# Clean up: Remove the modified secrets and config files after the script is complete
rm secrets.stencil.json config.stencil.json

# Restore the original secrets and config files if they were backed up
for FILE in "secrets.stencil.json" "config.stencil.json"; do
  if [ -f "$FILE.bak" ]; then
    mv "$FILE.bak" "$FILE"
  fi
done
