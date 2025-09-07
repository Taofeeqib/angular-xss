#!/bin/bash

# Script to import security scan results to DefectDojo
# Usage: ./import-results.sh [defectdojo_url] [api_key] [engagement_id]

# Check parameters
if [ $# -ne 3 ]; then
    echo "Usage: ./import-results.sh [defectdojo_url] [api_key] [engagement_id]"
    echo "Example: ./import-results.sh https://defectdojo.example.com api_key_123 42"
    exit 1
fi

DEFECTDOJO_URL=$1
API_KEY=$2
ENGAGEMENT_ID=$3
REPORTS_DIR="../docs/reports"

# Verify DefectDojo is accessible
echo "Checking DefectDojo accessibility..."
curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Token ${API_KEY}" "${DEFECTDOJO_URL}/api/v2/" | grep 200 > /dev/null
if [ $? -ne 0 ]; then
    echo "Error: Cannot access DefectDojo API. Please check URL and API key."
    exit 1
fi

echo "DefectDojo API is accessible!"

# Import Semgrep results
if [ -f "${REPORTS_DIR}/semgrep-results.sarif" ]; then
    echo "Importing Semgrep SAST results..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/semgrep-results.sarif" \
        -F "scan_type=SARIF" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=true" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing Semgrep results"
    else
        echo "Successfully imported Semgrep results"
    fi
fi

# Import Dependency Check results for Backend
if [ -f "${REPORTS_DIR}/dependency-check-report-Angular-XSS-Backend.sarif" ]; then
    echo "Importing Dependency Check results for Backend..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/dependency-check-report-Angular-XSS-Backend.sarif" \
        -F "scan_type=SARIF" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=true" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing Dependency Check Backend results"
    else
        echo "Successfully imported Dependency Check Backend results"
    fi
fi

# Import Dependency Check results for Frontend
if [ -f "${REPORTS_DIR}/dependency-check-report-Angular-XSS-Frontend.sarif" ]; then
    echo "Importing Dependency Check results for Frontend..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/dependency-check-report-Angular-XSS-Frontend.sarif" \
        -F "scan_type=SARIF" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=true" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing Dependency Check Frontend results"
    else
        echo "Successfully imported Dependency Check Frontend results"
    fi
fi

# Import SBOM results
if [ -f "${REPORTS_DIR}/angular-xss-sbom.json" ]; then
    echo "Importing CycloneDX SBOM..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/angular-xss-sbom.json" \
        -F "scan_type=CycloneDX Scan" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=false" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing SBOM results"
    else
        echo "Successfully imported SBOM results"
    fi
fi

# Import ZAP Baseline Scan Results
if [ -f "${REPORTS_DIR}/baseline-report.md" ]; then
    echo "Importing ZAP Baseline Scan results..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/baseline-report.md" \
        -F "scan_type=ZAP Scan" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=false" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing ZAP Baseline Scan results"
    else
        echo "Successfully imported ZAP Baseline Scan results"
    fi
fi

# Import ZAP Full Scan Results
if [ -f "${REPORTS_DIR}/full-scan-report.md" ]; then
    echo "Importing ZAP Full Scan results..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/full-scan-report.md" \
        -F "scan_type=ZAP Scan" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=false" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing ZAP Full Scan results"
    else
        echo "Successfully imported ZAP Full Scan results"
    fi
fi

# Import CodeQL Results
if [ -f "${REPORTS_DIR}/codeql-results.sarif" ]; then
    echo "Importing CodeQL SAST results..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/codeql-results.sarif" \
        -F "scan_type=SARIF" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=true" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing CodeQL results"
    else
        echo "Successfully imported CodeQL results"
    fi
fi

# Import TruffleHog Results
if [ -f "${REPORTS_DIR}/trufflehog-results.json" ]; then
    echo "Importing TruffleHog results..."
    curl -X POST \
        -H "Authorization: Token ${API_KEY}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${REPORTS_DIR}/trufflehog-results.json" \
        -F "scan_type=Trufflehog Scan" \
        -F "engagement=${ENGAGEMENT_ID}" \
        -F "close_old_findings=true" \
        -F "scan_date=$(date +"%Y-%m-%d")" \
        "${DEFECTDOJO_URL}/api/v2/import-scan/"
    
    if [ $? -ne 0 ]; then
        echo "Error importing TruffleHog results"
    else
        echo "Successfully imported TruffleHog results"
    fi
fi

echo "Import process completed!"
