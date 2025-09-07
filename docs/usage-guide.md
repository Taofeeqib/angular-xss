# DevSecOps Pipeline Usage Guide

This guide explains how to use the DevSecOps pipeline implemented for the Angular XSS application.

## Prerequisites

Before using the pipeline, ensure you have:

1. A GitHub account
2. Access to DefectDojo (either local or hosted)
3. Basic knowledge of CI/CD concepts
4. Docker and Docker Compose installed (for local DefectDojo setup)

## Setting Up the Environment

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/angular-xss.git
cd angular-xss
```

### 2. Set Up DefectDojo

#### Option A: Local Setup

```bash
cd defectdojo
docker-compose up -d
```

Access DefectDojo at http://localhost:8080 with:
- Username: admin
- Password: admin

#### Option B: Use Existing DefectDojo Instance

Obtain the URL and API credentials from your DefectDojo administrator.

### 3. Configure GitHub Secrets

Set up the following secrets in your GitHub repository:

1. DEFECTDOJO_URL
2. DEFECTDOJO_API_KEY
3. DEFECTDOJO_ENGAGEMENT_ID

See `docs/setup-secrets.md` for detailed instructions.

## Running the Pipeline

### Automatic Execution

The pipeline will run automatically on:
- Push to the main branch
- Creation of a pull request targeting the main branch

### Manual Execution

To run the pipeline manually:

1. Go to the "Actions" tab in your GitHub repository
2. Select the "DevSecOps Pipeline" workflow
3. Click "Run workflow"
4. Select the branch to run the workflow on
5. Click "Run workflow"

## Interpreting Results

### GitHub Actions Interface

1. Go to the "Actions" tab in your GitHub repository
2. Find the latest workflow run
3. Click on it to view details
4. Expand each job to see individual steps and their outputs

### DefectDojo

1. Log in to your DefectDojo instance
2. Navigate to the engagement you created for this project
3. View the "Findings" section to see all identified vulnerabilities
4. Use filters to sort by severity, scanner, etc.

## Working with Scan Results

### Security Issues Management

DefectDojo allows you to:

1. **View Details**: Click on any finding to see detailed information
2. **Assign Issues**: Assign vulnerabilities to team members
3. **Track Status**: Mark issues as accepted, false positive, or resolved
4. **Add Notes**: Document mitigation strategies or reasons for accepting risk
5. **Generate Reports**: Create PDF or CSV reports of findings

### Common Workflows

#### Addressing High-Severity Vulnerabilities

1. Filter findings by "High" or "Critical" severity
2. Prioritize issues affecting sensitive components
3. Implement fixes in your codebase
4. Push changes to trigger a new pipeline run
5. Verify that the issues have been resolved

#### Managing False Positives

For dependency check false positives:
1. Add entries to `dependency-check-suppressions.xml`
2. Commit and push the changes

For Semgrep false positives:
1. Modify `semgrep-custom-rules.yaml` if needed
2. Use inline `// nosemgrep` comments for specific lines (use sparingly)

## Customizing the Pipeline

### Adding New Scanners

To add a new security scanner:

1. Add the scanner configuration to the GitHub Actions workflow file
2. Create any necessary configuration files
3. Update the DefectDojo import script to handle the new scan results
4. Update documentation accordingly

### Modifying Scan Configurations

#### SAST (Semgrep)

Edit `semgrep-custom-rules.yaml` to:
- Add new security patterns
- Modify severity levels
- Adjust messages displayed for findings

#### SCA (Dependency-Check)

Edit `dependency-check-config.json` to:
- Change CVSS thresholds
- Enable/disable specific analyzers
- Modify output formats

### Configuring DAST Testing

The pipeline includes Dynamic Application Security Testing (DAST) using OWASP ZAP. You can customize it by:

1. **Modifying ZAP Rules**: Edit `zap-rules.tsv` to change which alerts are treated as WARN, FAIL, or IGNORE
2. **Updating ZAP Configuration**: Edit `zap-config.yaml` to adjust scan parameters, add custom payloads, or modify authentication
3. **Changing Scan Type**: The pipeline runs both baseline and full scans; you can modify these settings in the GitHub workflow

For advanced customization:
```yaml
# In .github/workflows/devsecops-pipeline.yml
- name: ZAP Full Scan
  uses: zaproxy/action-full-scan@v0.8.0
  with:
    target: 'http://localhost:4200'
    # Modify other parameters as needed
```

## Troubleshooting

### Common Issues

1. **Pipeline Failing at Secrets Scan**
   - Check for hardcoded credentials in your code
   - Ensure sensitive data is stored in environment variables

2. **SAST False Positives**
   - Review custom Semgrep rules
   - Consider adding inline suppressions for validated code

3. **DefectDojo Import Failures**
   - Verify API key and URL are correct
   - Check that the engagement ID exists
   - Ensure scan output formats are compatible with DefectDojo

4. **Dependency-Check Taking Too Long**
   - Consider using the cache feature in GitHub Actions
   - Limit the scan scope to specific directories

## Getting Help

For additional assistance:

1. Review the documentation in the `docs/` directory
2. Check GitHub Actions logs for specific error messages
3. Consult the official documentation for individual tools:
   - [Semgrep](https://semgrep.dev/docs/)
   - [OWASP Dependency-Check](https://jeremylong.github.io/DependencyCheck/dependency-check-cli/index.html)
   - [TruffleHog](https://github.com/trufflesecurity/trufflehog)
   - [DefectDojo](https://defectdojo.github.io/django-DefectDojo/)
