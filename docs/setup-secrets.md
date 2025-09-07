# Setting Up GitHub Secrets for the DevSecOps Pipeline

To use the DevSecOps pipeline, you need to configure the following GitHub secrets for DefectDojo integration:

## Required Secrets

1. **DEFECTDOJO_URL**
   - The full URL to your DefectDojo instance
   - Example: `https://defectdojo.example.com` or `http://localhost:8080` for local deployment

2. **DEFECTDOJO_API_KEY**
   - An API key generated in DefectDojo for authentication
   - To generate this key:
     1. Log in to DefectDojo
     2. Go to your user profile (click your username in the top right)
     3. Scroll to "API Key" section
     4. Click "Generate" if you don't already have a key
     5. Copy the API key

3. **DEFECTDOJO_ENGAGEMENT_ID**
   - The ID of the engagement in DefectDojo where you want to import scan results
   - To find this ID:
     1. Create a new engagement in DefectDojo if you don't have one
     2. Open the engagement in your browser
     3. The ID is the number in the URL after `/engagement/` 
        (e.g., for `https://defectdojo.example.com/engagement/42`, the ID is `42`)

## Adding Secrets to GitHub Repository

1. Go to your GitHub repository
2. Click on "Settings" tab
3. In the left sidebar, click "Secrets and variables" then "Actions"
4. Click "New repository secret"
5. Add each secret (DEFECTDOJO_URL, DEFECTDOJO_API_KEY, DEFECTDOJO_ENGAGEMENT_ID) one by one
6. Click "Add secret" after entering each one

## Creating an Engagement in DefectDojo

If you need to create a new engagement in DefectDojo:

1. Log in to DefectDojo
2. Go to "Engagements" > "Add New Interactive Engagement"
3. Fill in the required fields:
   - Name: "Angular XSS Security Testing"
   - Target Start Date: Today's date
   - Target End Date: Future date
   - Product: Create a new one or select existing
   - Lead: Select yourself
4. Click "Submit"
5. Note the engagement ID from the URL
