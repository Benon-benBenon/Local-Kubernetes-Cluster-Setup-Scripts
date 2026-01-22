#!/bin/bash

set -e

K8S_VERSION="v1.34.3"
COREDNS_VERSION="v1.12.1"
PAUSE_VERSION="3.10.1"
ETCD_VERSION="3.6.5-0"

# Pull Kubernetes control plane images
sudo docker pull registry.k8s.io/kube-apiserver:${K8S_VERSION}
sudo docker pull registry.k8s.io/kube-controller-manager:${K8S_VERSION}
sudo docker pull registry.k8s.io/kube-scheduler:${K8S_VERSION}
sudo docker pull registry.k8s.io/kube-proxy:${K8S_VERSION}

# Pull CoreDNS image
sudo docker pull registry.k8s.io/coredns/coredns:${COREDNS_VERSION}

# Pull pause container image
sudo docker pull registry.k8s.io/pause:${PAUSE_VERSION}

# Pull etcd image
sudo docker pull registry.k8s.io/etcd:${ETCD_VERSION}

# Restart cri-docker service
sudo systemctl restart cri-docker

# Verify images
sudo docker images | grep registry.k8s.io

echo "Kubernetes images pulled successfully."