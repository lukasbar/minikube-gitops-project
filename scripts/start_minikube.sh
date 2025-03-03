#!/bin/bash
# Run minikube based on docker
minikube start --driver=docker --nodes=2

# default namespaces creation
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "Minikube started & namespaces created"

