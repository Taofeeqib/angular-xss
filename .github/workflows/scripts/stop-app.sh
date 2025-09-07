#!/bin/bash

cd ./xss
# Try both docker compose (v2) and docker-compose (v1) commands
docker compose down || docker-compose down || true

# Verify containers are stopped
echo "Checking for running containers:"
docker ps
