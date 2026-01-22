#!/bin/bash

set -e

# Update package index
sudo apt update

# Install prerequisites
sudo apt install -y ca-certificates curl

# Create keyrings directory
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Update package index with Docker repository
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Verify installation
docker --version

# Add current user to docker group (optional - requires logout/login to take effect)
sudo usermod -aG docker $USER

echo "Docker installation complete. Log out and back in to use Docker without sudo."