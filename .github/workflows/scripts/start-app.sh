#!/bin/bash

cd ./xss
# Try using docker compose command (v2) first, if it fails try docker-compose (v1)
echo "Starting containers with docker compose..."
docker compose build || docker-compose build || (echo "Docker Compose build failed" && exit 1)
docker compose up -d || docker-compose up -d || (echo "Docker Compose up failed" && exit 1)

# Wait for application to be ready
echo "Waiting for application to become available..."
sleep 60

# Use curl to verify application is accessible
echo "Checking if application is running..."
curl -v http://localhost:4200 || echo "Warning: Application may not be accessible via localhost"

# Check docker containers and network information
echo "Docker container status:"
docker ps
echo "Docker network information:"
docker network ls
docker network inspect bridge
