# DevSecOps Pipeline for Angular XSS Application

This project implements a comprehensive DevSecOps pipeline for a deliberately vulnerable Angular application to demonstrate security scanning capabilities in CI/CD.

## Pipeline Architecture

The pipeline includes the following security stages:

1. **Secrets Scanning** - Using TruffleHog OSS to detect exposed credentials
2. **Static Application Security Testing (SAST)** - Using CodeQL with JavaScript, Angular, and Node.js rulesets
3. **Software Composition Analysis (SCA)** - Using OWASP Dependency-Check to identify vulnerable dependencies
4. **Software Bill of Materials (SBOM)** - Using CycloneDX to generate a comprehensive inventory of components
5. **Dynamic Application Security Testing (DAST)** - Using OWASP ZAP to perform runtime security testing
6. **Vulnerability Reporting** - Aggregating all findings in DefectDojo

![DevSecOps Pipeline Architecture](./docs/images/pipeline-architecture.png)

## Setup Instructions

### Prerequisites

- GitHub account
- Docker and Docker Compose installed
- Access to DefectDojo instance (or run locally using provided docker-compose file)

### Running the Pipeline

1. Push your code to GitHub to trigger the workflow
2. Manually trigger the workflow from the GitHub Actions tab

### Running DefectDojo Locally

```bash
cd defectdojo
docker-compose up -d
```

Access DefectDojo at http://localhost:8080 with credentials:
- Username: admin
- Password: admin

## Vulnerability Findings

The pipeline is designed to detect:

1. Secrets and credentials exposed in code
2. XSS vulnerabilities in Angular code
3. Vulnerable dependencies in both frontend and backend

## Integration with DefectDojo

Scan results from all security tools are aggregated in DefectDojo for:
- Centralized vulnerability management
- Tracking remediation progress
- Generating comprehensive reports
- Historical security trend analysis

### Note on ZAP Reports
When importing ZAP scan results into DefectDojo, use the XML format (`report_xml.xml`) which is specifically formatted for DefectDojo compatibility. The XML report requires properly formatted URLs with fully qualified domain names to be parsed correctly by DefectDojo's ZAP parser.

## Screenshots

See the `docs/screenshots` directory for:
- Successful SAST scan results
- Identified XSS vulnerabilities
- DefectDojo dashboard

## Security Scan Reports

All security scan results are stored in the `docs/reports` directory for easy access and review:

- **TruffleHog Results** - `trufflehog-results.json`
- **CodeQL SAST Results** - `codeql-results.sarif`
- **OWASP Dependency-Check Results** - `dependency-check-*.sarif`
- **CycloneDX SBOM** - `angular-xss-sbom.json`
- **ZAP DAST Reports** - Multiple formats available:
  - JSON format: `report_json.json`
  - Markdown format: `report_md.md`
  - HTML format: `report_html.html` 


To view SARIF files, you can use:
- GitHub Security Code Scanning dashboard
- [SARIF Viewer VSCode Extension](https://marketplace.visualstudio.com/items?itemName=MS-SarifVSCode.sarif-viewer)
- [SARIF Web Viewer](https://microsoft.github.io/sarif-web-component/)
