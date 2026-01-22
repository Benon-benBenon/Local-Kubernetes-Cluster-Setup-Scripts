#!/bin/bash

set -e

# Configuration variables
MASTER_IP="172.16.1.14"
API_PORT="6443"
CRI_SOCKET="unix:///var/run/cri-dockerd.sock"

# Token and CA hash (to be filled after kubeadm init)
TOKEN=""
CA_HASH=""

# Check if token and CA hash are provided
if [ -z "$TOKEN" ] || [ -z "$CA_HASH" ]; then
    echo "ERROR: TOKEN and CA_HASH variables must be set."
    echo ""
    echo "On the master node, run:"
    echo "  kubeadm token create --print-join-command"
    echo ""
    echo "Then update this script with the TOKEN and CA_HASH values."
    exit 1
fi

# Join the cluster
sudo kubeadm join "${MASTER_IP}:${API_PORT}" \
  --token "${TOKEN}" \
  --discovery-token-ca-cert-hash "sha256:${CA_HASH}" \
  --cri-socket "${CRI_SOCKET}"

echo "Node joined to cluster successfully."