#!/bin/bash

set -e

# Configuration variables
MASTER_IP="172.16.1.14"
POD_NETWORK_CIDR="10.244.0.0/16"
CRI_SOCKET="unix:///var/run/cri-dockerd.sock"

# Initialize Kubernetes cluster
sudo kubeadm init \
  --apiserver-advertise-address=${MASTER_IP} \
  --cri-socket=${CRI_SOCKET} \
  --pod-network-cidr=${POD_NETWORK_CIDR}

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Kubernetes cluster initialized successfully."
echo "Run 'kubectl get nodes' to verify the cluster status."
