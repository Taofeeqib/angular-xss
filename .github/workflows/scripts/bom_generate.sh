#!/bin/bash

# Script to generate CycloneDX BOMs for API and Frontend
echo "===== Generating CycloneDX BOMs for Angular XSS ====="

# Create reports directory
mkdir -p ./docs/reports

# Generate BOM for API
echo "Generating BOM for API..."
cd ./xss/api
npm install
npm install -g cyclonedx-bom
cyclonedx-bom -o api-bom.xml
cp api-bom.xml ../../docs/reports/
echo "API BOM generated at docs/reports/api-bom.xml"

# Generate BOM for Frontend
echo "Generating BOM for Frontend..."
cd ../frontend
npm install
cyclonedx-bom -o frontend-bom.xml
cp frontend-bom.xml ../../docs/reports/
echo "Frontend BOM generated at docs/reports/frontend-bom.xml"

# Return to the project root
cd ../..
echo "===== BOM generation complete ====="
