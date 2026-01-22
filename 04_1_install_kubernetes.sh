#!/bin/bash

set -e

K8S_VERSION="v1.34"

# Create keyrings directory
sudo mkdir -p /etc/apt/keyrings

# Add Kubernetes GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package index
sudo apt update -y

# Install Kubernetes components
sudo apt install -y kubelet kubeadm kubectl

# Hold packages at current version
sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet
sudo systemctl enable --now kubelet

# Verify installation
kubectl version --client
kubeadm version

echo "Kubernetes installation complete."