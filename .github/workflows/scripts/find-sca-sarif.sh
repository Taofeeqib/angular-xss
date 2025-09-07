#!/bin/bash

# Function to create placeholder SARIF file
function create_dependency_check_placeholder() {
  echo '{
    "$schema": "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
    "version": "2.1.0",
    "runs": [
      {
        "tool": {
          "driver": {
            "name": "OWASP Dependency-Check",
            "version": "placeholder",
            "rules": []
          }
        },
        "results": []
      }
    ]
  }' > ./docs/reports/dependency-check-placeholder.sarif
}

# Find all SARIF files
echo "Finding SARIF files in ./docs/reports directory"
find ./docs/reports -name "*.sarif" -type f

# Check if we have any SARIF files
SARIF_COUNT=$(find ./docs/reports -name "*.sarif" -type f | wc -l)

if [ "$SARIF_COUNT" -eq 0 ]; then
  echo "No SARIF files found, creating placeholder"
  create_dependency_check_placeholder
  
  echo "primary_sarif=./docs/reports/dependency-check-placeholder.sarif" >> $GITHUB_OUTPUT
else
  # Get the first SARIF file for primary upload
  PRIMARY_SARIF=$(find ./docs/reports -name "*.sarif" -type f | head -1)
  echo "Found primary SARIF file: $PRIMARY_SARIF"
  echo "primary_sarif=$PRIMARY_SARIF" >> $GITHUB_OUTPUT
fi
