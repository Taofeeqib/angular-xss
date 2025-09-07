#!/bin/bash

# DefectDojo credentials and URL
DEFECTDOJO_URL="http://localhost:8080"
DEFECTDOJO_USER="admin"
DEFECTDOJO_PASS="VPG7v7sHafVoggcq9zpIa2"

# Path to reports
REPORTS_DIR=~/reports

# Get API token
echo "Getting API token..."
API_RESPONSE=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"$DEFECTDOJO_USER\", \"password\": \"$DEFECTDOJO_PASS\"}" \
  "$DEFECTDOJO_URL/api/v2/api-token-auth/")

API_TOKEN=$(echo $API_RESPONSE | grep -o '"token":"[^"]*' | cut -d'"' -f4)

if [ -z "$API_TOKEN" ]; then
  echo "Failed to get API token. Response: $API_RESPONSE"
  exit 1
fi

echo "API token obtained"

# Create a product type
echo "Creating product type..."
PRODUCT_TYPE_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "DevSecOps Pipeline"}' \
  "$DEFECTDOJO_URL/api/v2/product_types/")

PRODUCT_TYPE_ID=$(echo $PRODUCT_TYPE_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$PRODUCT_TYPE_ID" ]; then
  echo "Failed to create product type. Response: $PRODUCT_TYPE_RESPONSE"
  exit 1
fi

echo "Product type created with ID: $PRODUCT_TYPE_ID"

# Create a product
echo "Creating product..."
PRODUCT_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"Angular XSS\", \"description\": \"Angular XSS application with DevSecOps pipeline\", \"prod_type\": $PRODUCT_TYPE_ID}" \
  "$DEFECTDOJO_URL/api/v2/products/")

PRODUCT_ID=$(echo $PRODUCT_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$PRODUCT_ID" ]; then
  echo "Failed to create product. Response: $PRODUCT_RESPONSE"
  exit 1
fi

echo "Product created with ID: $PRODUCT_ID"

# Create an engagement
echo "Creating engagement..."
ENGAGEMENT_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"DevSecOps Pipeline Scan\", \"product\": $PRODUCT_ID, \"target_start\": \"$(date +%Y-%m-%d)\", \"target_end\": \"$(date -v+7d +%Y-%m-%d)\", \"status\": \"In Progress\"}" \
  "$DEFECTDOJO_URL/api/v2/engagements/")

ENGAGEMENT_ID=$(echo $ENGAGEMENT_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$ENGAGEMENT_ID" ]; then
  echo "Failed to create engagement. Response: $ENGAGEMENT_RESPONSE"
  exit 1
fi

echo "Engagement created with ID: $ENGAGEMENT_ID"

# Import SARIF reports (CodeQL, Dependency-Check)
for sarif_file in "$REPORTS_DIR/codeql-results.sarif" "$REPORTS_DIR/dependency-check-report.sarif"; do
  if [ -f "$sarif_file" ] && [ -s "$sarif_file" ]; then
    echo "Importing SARIF report: $sarif_file"
    IMPORT_RESPONSE=$(curl -s -X POST \
      -H "Authorization: Token $API_TOKEN" \
      -H "Content-Type: multipart/form-data" \
      -F "file=@$sarif_file" \
      -F "scan_type=SARIF" \
      -F "engagement=$ENGAGEMENT_ID" \
      -F "close_old_findings=false" \
      -F "scan_date=$(date +"%Y-%m-%d")" \
      "$DEFECTDOJO_URL/api/v2/import-scan/")
    
    echo "Import response: $IMPORT_RESPONSE"
  else
    echo "SARIF file not found or empty: $sarif_file"
  fi
done

# Import SBOMs
# Check for API SBOM
if [ -f "$REPORTS_DIR/angular-xss-api-sbom.json" ] && [ -s "$REPORTS_DIR/angular-xss-api-sbom.json" ]; then
  echo "Importing API SBOM report: $REPORTS_DIR/angular-xss-api-sbom.json"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/angular-xss-api-sbom.json" \
    -F "scan_type=CycloneDX" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "API SBOM Import response: $IMPORT_RESPONSE"
else
  echo "API SBOM file not found or empty: $REPORTS_DIR/angular-xss-api-sbom.json"
fi

# Check for Frontend SBOM
if [ -f "$REPORTS_DIR/angular-xss-frontend-sbom.json" ] && [ -s "$REPORTS_DIR/angular-xss-frontend-sbom.json" ]; then
  echo "Importing Frontend SBOM report: $REPORTS_DIR/angular-xss-frontend-sbom.json"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/angular-xss-frontend-sbom.json" \
    -F "scan_type=CycloneDX" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "Frontend SBOM Import response: $IMPORT_RESPONSE"
else
  echo "Frontend SBOM file not found or empty: $REPORTS_DIR/angular-xss-frontend-sbom.json"
fi

# Check for XML API SBOM
if [ -f "$REPORTS_DIR/api-bom.xml" ] && [ -s "$REPORTS_DIR/api-bom.xml" ]; then
  echo "Importing XML API SBOM report: $REPORTS_DIR/api-bom.xml"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/api-bom.xml" \
    -F "scan_type=CycloneDX" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "XML API SBOM Import response: $IMPORT_RESPONSE"
else
  echo "XML API SBOM file not found or empty: $REPORTS_DIR/api-bom.xml"
fi

# Check for XML Frontend SBOM
if [ -f "$REPORTS_DIR/frontend-bom.xml" ] && [ -s "$REPORTS_DIR/frontend-bom.xml" ]; then
  echo "Importing XML Frontend SBOM report: $REPORTS_DIR/frontend-bom.xml"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/frontend-bom.xml" \
    -F "scan_type=CycloneDX" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "XML Frontend SBOM Import response: $IMPORT_RESPONSE"
else
  echo "XML Frontend SBOM file not found or empty: $REPORTS_DIR/frontend-bom.xml"
fi

# Check for combined/old format SBOM as fallback
if [ -f "$REPORTS_DIR/angular-xss-sbom.json" ] && [ -s "$REPORTS_DIR/angular-xss-sbom.json" ]; then
  echo "Importing combined SBOM report: $REPORTS_DIR/angular-xss-sbom.json"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/angular-xss-sbom.json" \
    -F "scan_type=CycloneDX" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "Combined SBOM Import response: $IMPORT_RESPONSE"
fi

# Import ZAP report
for zap_file in "$REPORTS_DIR/report_xml.xml" "$REPORTS_DIR/report_html.html" "$REPORTS_DIR/report_json.json"; do
  if [ -f "$zap_file" ] && [ -s "$zap_file" ]; then
    echo "Importing ZAP report: $zap_file"
    IMPORT_RESPONSE=$(curl -s -X POST \
      -H "Authorization: Token $API_TOKEN" \
      -H "Content-Type: multipart/form-data" \
      -F "file=@$zap_file" \
      -F "scan_type=ZAP Scan" \
      -F "engagement=$ENGAGEMENT_ID" \
      -F "close_old_findings=false" \
      -F "scan_date=$(date +"%Y-%m-%d")" \
      "$DEFECTDOJO_URL/api/v2/import-scan/")
    
    echo "Import response: $IMPORT_RESPONSE"
    # Once we've successfully imported one ZAP report, we can break
    break
  fi
done

# Import TruffleHog report
if [ -f "$REPORTS_DIR/trufflehog-results.json" ] && [ -s "$REPORTS_DIR/trufflehog-results.json" ]; then
  echo "Importing TruffleHog report: $REPORTS_DIR/trufflehog-results.json"
  IMPORT_RESPONSE=$(curl -s -X POST \
    -H "Authorization: Token $API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "file=@$REPORTS_DIR/trufflehog-results.json" \
    -F "scan_type=Trufflehog Scan" \
    -F "engagement=$ENGAGEMENT_ID" \
    -F "close_old_findings=false" \
    -F "scan_date=$(date +"%Y-%m-%d")" \
    "$DEFECTDOJO_URL/api/v2/import-scan/")
  
  echo "Import response: $IMPORT_RESPONSE"
else
  echo "TruffleHog file not found or empty: $REPORTS_DIR/trufflehog-results.json"
fi

echo "All scans imported. You can now access DefectDojo at $DEFECTDOJO_URL to view the findings."
echo "Login with username: $DEFECTDOJO_USER and password: $DEFECTDOJO_PASS"
