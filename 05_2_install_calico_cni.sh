#!/bin/bash

set -e

CALICO_VERSION="v3.30.3"
POD_CIDR="10.244.0.0/16"

echo "Installing Calico CNI ${CALICO_VERSION} with Pod CIDR ${POD_CIDR}..."
echo ""
echo "TIP: Open another terminal and run the following command to watch pod creation:"
echo "  kubectl get pods -n kube-system -w"
echo ""
sleep 3

# Download Calico manifest
curl -LO https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/calico.yaml

# Update pod network CIDR
sed -i "s?192.168.0.0/16?${POD_CIDR}?g" calico.yaml

# Apply Calico manifest
kubectl apply -f calico.yaml --validate=false

echo ""
echo "Calico CNI installation initiated."
echo "Run 'kubectl get pods -n kube-system' to check pod status."
