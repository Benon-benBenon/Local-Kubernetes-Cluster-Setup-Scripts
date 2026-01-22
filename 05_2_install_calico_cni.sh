#!/bin/bash

set -e

CALICO_VERSION="v3.30.3"

echo "Installing Calico CNI ${CALICO_VERSION}..."
echo ""
echo "TIP: Open another terminal and run the following command to watch pod creation:"
echo "  kubectl get pods -n kube-system -w"
echo ""
sleep 3

# Apply Calico manifest
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/calico.yaml

echo ""
echo "Calico CNI installation initiated."
echo "Run 'kubectl get pods -n kube-system' to check pod status."