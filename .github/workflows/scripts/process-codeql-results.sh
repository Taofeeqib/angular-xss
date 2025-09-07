#!/bin/bash

# Function to create placeholder SARIF file
function create_placeholder_sarif() {
  echo '{
    "$schema": "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
    "version": "2.1.0",
    "runs": [
      {
        "tool": {
          "driver": {
            "name": "CodeQL",
            "version": "placeholder",
            "rules": []
          }
        },
        "results": []
      }
    ]
  }' > ./docs/reports/codeql-results.sarif
}

echo "Listing CodeQL SARIF files in ./docs/reports:"
find ./docs/reports -type f -name "*.sarif" | sort

# Check if any SARIF files were generated
if [ -n "$(find ./docs/reports -type f -name '*.sarif')" ]; then
  # Create a consolidated sarif file for DefectDojo
  echo "Creating consolidated SARIF file for DefectDojo"
  
  # Find the first SARIF file and make a copy for DefectDojo
  FIRST_FILE=$(find ./docs/reports -type f -name "*.sarif" | head -1)
  echo "Using file: $FIRST_FILE for consolidated results"
  
  # Make sure the file exists and is not a directory
  if [ -f "$FIRST_FILE" ]; then
    cp "$FIRST_FILE" ./docs/reports/codeql-results.sarif
    
    # Display info about the consolidated file
    echo "Consolidated SARIF file created at ./docs/reports/codeql-results.sarif"
    ls -la ./docs/reports/codeql-results.sarif
    echo "First 20 lines of consolidated SARIF file:"
    head -n 20 ./docs/reports/codeql-results.sarif
  else
    echo "Warning: Selected file is not a regular file. Creating placeholder instead."
    create_placeholder_sarif
  fi
else
  echo "No CodeQL SARIF files found, creating placeholder"
  create_placeholder_sarif
fi