#!/bin/bash

# Check if zap-rules.tsv exists in the repo
echo "Checking for ZAP rules files..."
echo "Current directory: $(pwd)"
ls -la

if [ -f "zap-rules.tsv" ]; then
  echo "ZAP rules file already exists in the root directory"
elif [ -f "./angular-xss/zap-rules.tsv" ]; then
  echo "Found ZAP rules in angular-xss directory, copying to root"
  cp ./angular-xss/zap-rules.tsv ./
else
  echo "ZAP rules file not found, creating a basic one"
  echo '10016	IGNORE	http://localhost:4200	(IGNORE: A technology has been identified)' > zap-rules.tsv
  echo '10020	IGNORE	http://localhost:4200	(IGNORE: X-Frame-Options Header Not Set)' >> zap-rules.tsv
  echo '10021	IGNORE	http://localhost:4200	(IGNORE: X-Content-Type-Options Header Missing)' >> zap-rules.tsv
  echo '10038	IGNORE	http://localhost:4200	(IGNORE: Content Security Policy (CSP) Header Not Set)' >> zap-rules.tsv
  echo '10049	IGNORE	http://localhost:4200	(IGNORE: Non-Storable Content)' >> zap-rules.tsv
  echo '40012	FAIL	http://localhost:4200	(FAIL: Cross Site Scripting (Reflected))' >> zap-rules.tsv
fi

# Verify the rules file exists and show content
echo "Verifying ZAP rules file location and content:"
ls -la zap-rules.tsv
cat zap-rules.tsv
