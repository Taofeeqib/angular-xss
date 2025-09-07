#!/bin/bash

# Create comprehensive report index file
echo "# DevSecOps Scan Reports" > ./docs/reports/README.md
echo "Generated on $(date)" >> ./docs/reports/README.md
echo "" >> ./docs/reports/README.md
echo "## Available Reports" >> ./docs/reports/README.md

# Process all artifacts and copy to docs/reports
for artifact_dir in ./artifacts/*; do
  if [ -d "$artifact_dir" ]; then
    artifact_name=$(basename "$artifact_dir")
    echo "Processing artifact: $artifact_name"
    
    # Copy all files from the artifact directory to docs/reports
    cp -v $artifact_dir/* ./docs/reports/ 2>/dev/null || echo "No files to copy from $artifact_name"
    
    # Add entry to the report index
    echo "- **$artifact_name**" >> ./docs/reports/README.md
    for file in $artifact_dir/*; do
      if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "  - [$filename](./$filename)" >> ./docs/reports/README.md
      fi
    done
  fi
done

# Check if any reports were saved
echo "Saved reports in docs/reports directory:"
ls -la ./docs/reports/
