#!/bin/bash

set -e

# Download cri-dockerd package
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.22/cri-dockerd_0.3.22.3-0.debian-bookworm_amd64.deb

# Install the package
sudo dpkg -i cri-dockerd_0.3.22.3-0.debian-bookworm_amd64.deb

# Fix any dependency issues
sudo apt-get install -f -y

# Enable services
sudo systemctl enable cri-docker.service
sudo systemctl enable cri-docker.socket

# Start services
sudo systemctl start cri-docker.service
sudo systemctl start cri-docker.socket

# Verify socket file exists
sudo ls -la /var/run/cri-dockerd.sock

# Check version
cri-dockerd --version

# Verify service status
sudo systemctl is-active cri-docker.service
sudo systemctl is-enabled cri-docker.service

echo "cri-dockerd installation complete."