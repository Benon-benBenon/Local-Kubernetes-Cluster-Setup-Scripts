#!/bin/bash

set -e

# Backup existing daemon.json if it exists
if [ -f /etc/docker/daemon.json ]; then
    sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.backup
fi

# Create Docker daemon configuration
sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Create containerd snapshots directory
sudo mkdir -p /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots

# Reload systemd daemon
sudo systemctl daemon-reload

# Restart Docker service
sudo systemctl restart docker

# Wait for Docker to start
sleep 3

# Verify Docker is working
sudo docker info

# Test with hello-world container
sudo docker run hello-world

echo "Docker configuration complete and verified."