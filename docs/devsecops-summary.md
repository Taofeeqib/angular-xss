# DevSecOps Implementation Summary

## Overview

This project implements a comprehensive DevSecOps pipeline for a deliberately vulnerable Angular application called "Angular XSS". The pipeline integrates security testing and vulnerability management throughout the development lifecycle using GitHub Actions and DefectDojo.

## Security Testing Stages

The pipeline includes the following security stages:

### 1. Secrets Scanning

- **Tool**: TruffleHog OSS
- **Purpose**: Detect leaked secrets, credentials, and API keys in the codebase
- **Configuration**: Default configuration with `--only-verified` flag to reduce false positives
- **Implementation**: Runs as the first job in the GitHub Actions workflow

### 2. Static Application Security Testing (SAST)

- **Tool**: Semgrep
- **Purpose**: Analyze source code for security vulnerabilities without running the application
- **Configuration**:
  - Uses built-in JavaScript, Angular, and NodeJS rule packs
  - Includes custom rules for Angular XSS detection (`semgrep-custom-rules.yaml`)
  - Integrates existing application-specific rules (`semgrep.yaml`)
- **Implementation**: Runs after secrets scanning in the GitHub Actions workflow

### 3. Software Composition Analysis (SCA)

- **Tool**: OWASP Dependency-Check
- **Purpose**: Identify vulnerable dependencies in both frontend and backend code
- **Configuration**:
  - Custom configuration in `dependency-check-config.json`
  - Suppression file for managing false positives
  - Set to fail build on CVSS score >= 7
- **Implementation**: Runs after SAST in the GitHub Actions workflow

### 4. Software Bill of Materials (SBOM)

- **Tool**: CycloneDX
- **Purpose**: Generate a comprehensive inventory of all components and dependencies
- **Configuration**: Default CycloneDX configuration for Node.js projects
- **Implementation**: Runs after SCA in the GitHub Actions workflow

### 5. Dynamic Application Security Testing (DAST)

- **Tool**: OWASP ZAP
- **Purpose**: Identify runtime security vulnerabilities by actively attacking the application
- **Configuration**:
  - Custom ZAP rules in `zap-rules.tsv` with specific focus on XSS detection
  - Extended ZAP configuration in `zap-config.yaml` with authentication setup
  - Two-phase scanning: baseline scan followed by full scan
- **Implementation**: 
  - Runs after SBOM generation in the GitHub Actions workflow
  - Automatically starts the application using Docker Compose
  - Performs both passive and active scanning
  - Specifically targets XSS vulnerabilities with custom payloads

## Vulnerability Management

All scan results are aggregated in DefectDojo, which provides:

- Centralized vulnerability tracking
- Prioritization based on severity
- Historical trend analysis
- Comprehensive reporting

The integration with DefectDojo uses:
- Custom import script (`defectdojo/import-results.sh`)
- GitHub Secrets for secure credential management
- Automated import of all scan results

## How to Use

1. **Setup**:
   - Fork or clone this repository
   - Set up DefectDojo (locally or using cloud hosting)
   - Configure GitHub Secrets as described in `docs/setup-secrets.md`

2. **Run the Pipeline**:
   - Push to the main branch or create a pull request
   - Alternatively, manually trigger the workflow from the GitHub Actions tab

3. **View Results**:
   - Access DefectDojo to view aggregated scan results
   - Check GitHub Actions logs for individual scan outputs
   - Review SARIF files for detailed vulnerability information

## Security Controls Implemented

1. **Prevention Controls**:
   - Early detection of secrets before they reach production
   - Identification of vulnerable dependencies before deployment
   - Source code analysis to catch security issues during development

2. **Detection Controls**:
   - Comprehensive vulnerability scanning across multiple dimensions
   - Generation of SBOMs for complete visibility into components

3. **Response Controls**:
   - Centralized vulnerability management in DefectDojo
   - Ability to track remediation status
   - Historical security posture monitoring

## Future Enhancements

Potential improvements to the pipeline include:

1. **Container Security** - Scan Docker images for vulnerabilities
2. **Infrastructure as Code Scanning** - Secure configuration analysis
3. **Automated Remediation** - Generate pull requests for dependency updates
4. **Security Metrics Dashboard** - Visual representation of security posture
5. **Interactive Application Security Testing (IAST)** - Combine DAST and SAST approaches for more comprehensive testing
