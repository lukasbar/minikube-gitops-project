#!/bin/bash
# official argocd manifest deployment
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Argo deployed in namespace 'argocd'."

