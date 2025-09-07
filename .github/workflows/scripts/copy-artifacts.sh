#!/bin/bash

mkdir -p ./docs/reports

echo "Copying all artifacts to docs/reports directory..."

# TruffleHog results
if [ -d "./artifacts/trufflehog-results" ]; then
  echo "Found TruffleHog results"
  cp ./artifacts/trufflehog-results/* ./docs/reports/ || echo "No TruffleHog files to copy"
else
  echo "No TruffleHog results directory found"
fi

# CodeQL results
if [ -d "./artifacts/codeql-results" ]; then
  echo "Found CodeQL results"
  cp ./artifacts/codeql-results/* ./docs/reports/ || echo "No CodeQL files to copy"
else
  echo "No CodeQL results directory found"
fi

# SCA results
if [ -d "./artifacts/sca-results" ]; then
  echo "Found SCA results"
  cp ./artifacts/sca-results/* ./docs/reports/ || echo "No SCA files to copy"
else
  echo "No SCA results directory found"
fi

# SBOM results
if [ -d "./artifacts/angular-xss-sbom" ]; then
  echo "Found SBOM results"
  cp ./artifacts/angular-xss-sbom/* ./docs/reports/ || echo "No SBOM files to copy"
else
  echo "No SBOM results directory found"
fi

# ZAP results
if [ -d "./artifacts/zap-reports" ]; then
  echo "Found ZAP results"
  cp ./artifacts/zap-reports/* ./docs/reports/ || echo "No ZAP files to copy"
else
  echo "No ZAP results directory found"
fi

# Verify copied files
echo "Files in docs/reports directory after copying artifacts:"
ls -la ./docs/reports/

# Run verification script to check for required reports
echo "Running verification script..."
chmod +x ./verify-reports.sh
./verify-reports.sh
