#!/bin/bash

# Function to create placeholder SARIF file for dependency check
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

echo "Checking if SARIF files exist in docs/reports directory"
if [ -d "./docs/reports" ]; then
  ls -la ./docs/reports/
  echo "Found files in docs/reports directory"
  sarifCount=$(find ./docs/reports -name "*.sarif" | wc -l)
  
  if [ "$sarifCount" -gt 0 ]; then
    find ./docs/reports -name "*.sarif" | while read file; do
      echo "Found SARIF file: $file"
      echo "File contents (first 20 lines):"
      head -n 20 "$file"
    done
  else
    echo "No SARIF files found in docs/reports directory. Creating placeholder."
    create_dependency_check_placeholder
  fi
else
  echo "Reports directory does not exist!"
  mkdir -p ./docs/reports
  create_dependency_check_placeholder
fi