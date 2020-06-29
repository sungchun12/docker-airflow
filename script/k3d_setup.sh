#!/bin/bash

# Make sure you run below to connect kubectl to k3d
k3d c

echo "***********************"
echo "Wait for the k3s cluster to settle"
echo "***********************"
sleep 15s

export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

# Add KUBECONFIG setting to .bashrc
echo "export KUBECONFIG='$(k3d get-kubeconfig --name='k3s-default')'" >> ~/.bashrc
source ~/.bashrc

kubectl cluster-info
# should look something like below:
# Kubernetes master is running at https://localhost:6443
# CoreDNS is running at https://localhost:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
# Metrics-server is running at https://localhost:6443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy


export SERVICE_ACCOUNT=$(cat account.json)

# Create docker-registry key for k3d
kubectl create secret docker-registry gcr-key --docker-server=gcr.io --docker-username=_json_key --docker-password="$(cat account.json)" --docker-email=example@example.com

echo "***********************"
echo "Wait for the gcr-key to settle"
echo "***********************"
sleep 10s

# Set default k3d serviceaccount to use our created gcr-key for pulling images
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gcr-key"}]}'

