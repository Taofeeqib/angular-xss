# DevSecOps Scan Reports

Generated on September 7, 2025

## Available Reports

### Security Scanning Results

- **TruffleHog Secrets Scanning**
  - [trufflehog-results.json](./trufflehog-results.json) - Secrets scanning results

- **CodeQL SAST**
  - [codeql-results.sarif](./codeql-results.sarif) - Static code analysis results

- **OWASP Dependency-Check SCA**
  - [dependency-check-placeholder.sarif](./dependency-check-placeholder.sarif) - Software composition analysis results

- **CycloneDX SBOM**
  - [angular-xss-sbom.json](./angular-xss-sbom.json) - Software bill of materials

- **OWASP ZAP DAST**
  - [zap-baseline-report.md](./zap-baseline-report.md) - Baseline scan report
  - [zap-full-scan-report.md](./zap-full-scan-report.md) - Full scan report

## How to View Reports

### SARIF Files
SARIF files (.sarif) can be viewed with:
- GitHub Security Code Scanning dashboard
- [SARIF Viewer VSCode Extension](https://marketplace.visualstudio.com/items?itemName=MS-SarifVSCode.sarif-viewer)
- [SARIF Web Viewer](https://microsoft.github.io/sarif-web-component/)

### JSON Files
JSON files can be viewed with any text editor or JSON viewer.

### Markdown Files
Markdown files (.md) can be viewed with any Markdown viewer or GitHub's web interface.

## DefectDojo Integration
These reports are automatically imported into DefectDojo for centralized vulnerability management.
- **zap-reports**
  - [README.md](./README.md)
  - [angular-xss-sbom.json](./angular-xss-sbom.json)
  - [codeql-results.sarif](./codeql-results.sarif)
  - [dependency-check-report.sarif](./dependency-check-report.sarif)
  - [report_md.md](./report_md.md)
  - [trufflehog-results.json](./trufflehog-results.json)
  - [zap-baseline-report.md](./zap-baseline-report.md)
  - [zap-full-scan-report.md](./zap-full-scan-report.md)
- **zap-reports**
  - [README.md](./README.md)
  - [angular-xss-sbom.json](./angular-xss-sbom.json)
  - [codeql-results.sarif](./codeql-results.sarif)
  - [dependency-check-report.sarif](./dependency-check-report.sarif)
  - [report_json.json](./report_json.json)
  - [report_md.md](./report_md.md)
  - [trufflehog-results.json](./trufflehog-results.json)
  - [zap-baseline-report.json](./zap-baseline-report.json)
  - [zap-baseline-report.md](./zap-baseline-report.md)
  - [zap-baseline-report.xml](./zap-baseline-report.xml)
  - [zap-full-scan-report.json](./zap-full-scan-report.json)
  - [zap-full-scan-report.md](./zap-full-scan-report.md)
  - [zap-full-scan-report.xml](./zap-full-scan-report.xml)
