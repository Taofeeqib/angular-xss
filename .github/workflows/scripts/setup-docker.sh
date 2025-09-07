#!/bin/bash

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
  echo "Installing Docker Compose plugin"
  # Install Docker Compose V2
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p $DOCKER_CONFIG/cli-plugins
  curl -SL https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
  chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
fi

# Verify Docker and Docker Compose are installed
echo "Docker version:"
docker --version
echo "Docker Compose version:"
docker compose version || docker-compose --version || echo "Docker Compose not installed properly"
