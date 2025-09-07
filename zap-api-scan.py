#!/usr/bin/env python3

"""
Custom OWASP ZAP API script for scanning the Angular XSS application.
This script demonstrates how to use the ZAP API to perform custom scanning operations.
It can be used as an alternative to the GitHub Actions ZAP integration.

Dependencies:
- python-owasp-zap-v2.4 (pip install python-owasp-zap-v2.4)

Usage:
1. Start ZAP daemon: zap.sh -daemon -host 0.0.0.0 -port 8080 -config api.disablekey=true
2. Run this script: python zap-api-scan.py http://localhost:4200

Note: This script is provided as a reference for custom ZAP integration.
"""

import sys
import time
import requests
from zapv2 import ZAPv2

# Configuration
ZAP_API_URL = 'http://localhost:8080'
ZAP_API_KEY = ''  # Not needed if api.disablekey=true
TARGET_URL = sys.argv[1] if len(sys.argv) > 1 else 'http://localhost:4200'
AUTH_CONFIG = {
    'login_url': f'{TARGET_URL}/home/signin',
    'username': 'admin@example.com',
    'password': 'admin123',
    'username_field': 'email',
    'password_field': 'password'
}


def wait_for_passive_scan(zap):
    """Wait for passive scan to complete"""
    print('Waiting for passive scan to complete')
    while int(zap.pscan.records_to_scan) > 0:
        print(f'Records to passive scan: {zap.pscan.records_to_scan}')
        time.sleep(2)
    print('Passive scan completed')


def perform_active_scan(zap, target):
    """Perform active scan on the target"""
    print(f'Starting active scan on {target}')
    scan_id = zap.ascan.scan(target)
    
    # Wait for active scan to complete
    while int(zap.ascan.status(scan_id)) < 100:
        print(f'Active scan progress: {zap.ascan.status(scan_id)}%')
        time.sleep(5)
    
    print('Active scan completed')


def perform_authentication(zap, auth_config):
    """Set up authentication in ZAP"""
    print('Setting up authentication')
    
    # Create a new context
    context_id = 1
    context_name = 'Angular XSS Context'
    zap.context.new_context(context_name)
    zap.context.include_in_context(context_name, f"\\Q{TARGET_URL}\\E.*")
    
    # Set up authentication
    zap.authentication.set_authentication_method(
        context_id,
        'formBasedAuthentication',
        f'loginUrl={auth_config["login_url"]}&loginRequestData={auth_config["username_field"]}%3D%7B%25username%25%7D%26{auth_config["password_field"]}%3D%7B%25password%25%7D'
    )
    
    # Create a user
    user_id = zap.users.new_user(context_id, 'admin')
    zap.users.set_authentication_credentials(
        context_id,
        user_id,
        f'username={auth_config["username"]}&password={auth_config["password"]}'
    )
    zap.users.set_user_enabled(context_id, user_id, True)
    
    # Enable forced user mode
    zap.forcedUser.set_forced_user(context_id, user_id)
    zap.forcedUser.set_forced_user_mode_enabled(True)
    
    print('Authentication setup completed')


def main():
    """Main function to run the ZAP scan"""
    try:
        # Connect to ZAP
        print(f'Connecting to ZAP at {ZAP_API_URL}')
        zap = ZAPv2(apikey=ZAP_API_KEY, proxies={'http': ZAP_API_URL, 'https': ZAP_API_URL})
        
        # Access the target to ensure it's in the site tree
        print(f'Accessing target {TARGET_URL}')
        zap.urlopen(TARGET_URL)
        
        # Wait for passive scan to complete
        wait_for_passive_scan(zap)
        
        # Set up authentication
        perform_authentication(zap, AUTH_CONFIG)
        
        # Spider the site
        print(f'Spidering target {TARGET_URL}')
        scan_id = zap.spider.scan(TARGET_URL)
        
        # Wait for spider to complete
        while int(zap.spider.status(scan_id)) < 100:
            print(f'Spider progress: {zap.spider.status(scan_id)}%')
            time.sleep(2)
        
        print('Spider completed')
        
        # Run active scan
        perform_active_scan(zap, TARGET_URL)
        
        # Get alerts
        alerts = zap.core.alerts(TARGET_URL)
        print(f'Total alerts found: {len(alerts)}')
        
        # Print alerts
        for alert in alerts:
            print(f'Alert: {alert["name"]}')
            print(f'Risk: {alert["risk"]} ({alert["confidence"]})')
            print(f'URL: {alert["url"]}')
            print(f'Description: {alert["description"]}')
            print(f'Solution: {alert["solution"]}')
            print('-' * 80)
        
        # Generate HTML report
        print('Generating report')
        report = zap.core.htmlreport()
        with open('zap-report.html', 'w') as f:
            f.write(report)
        
        print('Scan completed successfully')
        
    except Exception as e:
        print(f'Error: {e}')
        return 1
    
    return 0


if __name__ == '__main__':
    sys.exit(main())
