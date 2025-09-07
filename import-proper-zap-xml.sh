#!/bin/bash

# DefectDojo credentials and URL
DEFECTDOJO_URL="http://localhost:8080"
DEFECTDOJO_USER="admin"
DEFECTDOJO_PASS="VPG7v7sHafVoggcq9zpIa2"

# Path to ZAP XML report
ZAP_XML_FILE="./docs/reports/proper-zap-format.xml"

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

# Get product ID
echo "Getting product ID..."
PRODUCT_RESPONSE=$(curl -s -X GET \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: application/json" \
  "$DEFECTDOJO_URL/api/v2/products/?name=Angular%20XSS")

PRODUCT_ID=$(echo $PRODUCT_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$PRODUCT_ID" ]; then
  echo "Failed to get product ID. Response: $PRODUCT_RESPONSE"
  exit 1
fi

echo "Product ID: $PRODUCT_ID"

# Get engagement ID
echo "Getting engagement ID..."
ENGAGEMENT_RESPONSE=$(curl -s -X GET \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: application/json" \
  "$DEFECTDOJO_URL/api/v2/engagements/?product=$PRODUCT_ID")

ENGAGEMENT_ID=$(echo $ENGAGEMENT_RESPONSE | grep -o '"id":[0-9]*' | head -1 | cut -d':' -f2)

if [ -z "$ENGAGEMENT_ID" ]; then
  echo "Failed to get engagement ID. Response: $ENGAGEMENT_RESPONSE"
  exit 1
fi

echo "Engagement ID: $ENGAGEMENT_ID"

# Check if the XML file exists
if [ ! -f "$ZAP_XML_FILE" ]; then
  echo "ZAP XML file not found: $ZAP_XML_FILE"
  exit 1
fi

echo "File exists: $ZAP_XML_FILE"
echo "File size: $(du -h "$ZAP_XML_FILE" | cut -f1)"

# Import ZAP XML report
echo "Importing ZAP XML report: $ZAP_XML_FILE"
IMPORT_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Token $API_TOKEN" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@$ZAP_XML_FILE" \
  -F "scan_type=ZAP Scan" \
  -F "engagement=$ENGAGEMENT_ID" \
  -F "close_old_findings=false" \
  -F "scan_date=$(date +"%Y-%m-%d")" \
  -F "test_title=ZAP Properly Formatted XML Report" \
  "$DEFECTDOJO_URL/api/v2/import-scan/")

echo "Import response: $IMPORT_RESPONSE"

# Parse and display results
echo -e "\nImport Results:"

# Check if import was successful
if echo "$IMPORT_RESPONSE" | grep -q '"test":'; then
  echo "✅ ZAP XML report successfully imported"
  
  # Try to extract statistics
  echo "Statistics:"
  echo "$IMPORT_RESPONSE" | grep -o '"statistics":{[^}]*}' | sed 's/"statistics"://' | 
  python3 -c "
import sys, json
try:
  stats = json.loads(sys.stdin.read())
  for severity, counts in stats.get('after', {}).items():
    if severity != 'total':
      print(f'{severity}: {counts.get(\"active\", 0)} active findings')
  total = stats.get('after', {}).get('total', {})
  print(f'total: {total.get(\"active\", 0)} active findings')
except:
  print('Could not parse statistics')
  "
else
  echo "❌ Failed to import ZAP XML report"
  echo "Error: $IMPORT_RESPONSE"
fi

echo -e "\nYou can now access DefectDojo at $DEFECTDOJO_URL to view the findings."
echo "Login with username: $DEFECTDOJO_USER and password: $DEFECTDOJO_PASS"
