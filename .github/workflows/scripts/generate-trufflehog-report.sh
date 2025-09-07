#!/bin/bash

# Generate TruffleHog report in docs/reports
echo "Running TruffleHog scan manually to save report"
docker run --rm -v $(pwd):/pwd trufflesecurity/trufflehog:latest github --repo file:///pwd --json > ./docs/reports/trufflehog-results.json || true
