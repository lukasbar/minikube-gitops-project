#!/bin/bash
set -e

# Main script with options for starting or stopping the cluster

echo "Select an option:"
echo "1. Start the cluster"
echo "2. Stop the cluster"
read -p "Enter your choice [1 or 2]: " choice

if [ "$choice" == "1" ]; then
	echo "Starting the DevOps environment setup..."

	# Start minikube
	echo "Starting minikube..."
	./start_minikube.sh

	# Wait until minikube is fully running
	echo "Checking minikube status..."
	while true; do
		status=$(minikube status --format "{{.Host}}" 2>/dev/null || echo "NotRunning")
		if [ "$status" == "Running" ]; then
			echo "Minikube is running."
			break
		fi
		echo "Minikube is not ready yet, waiting for 5 seconds..."
		sleep 5
	done

	# Deploy Argo CD
	echo "Deploying Argo CD..."
	./deploy_argocd.sh

	echo "Waiting for Argo CD pods to appear in the 'argocd' namespace..."
	while [ $(kubectl get pods -n argocd --no-headers 2>/dev/null | wc -l) -eq 0 ]; do
		echo "No Argo CD pods found, waiting for 5 seconds..."
		sleep 5
	done

	#Wait until all Argo CD pods are ready
	echo "Waiting for all Argo CD pods to be ready..."
	kubectl wait --for=condition=ready pod --all -n argocd --timeout=300s
	echo "All Argo CD pods are running."

	# Display Argo CD access information
	echo "Fetching Argo CD admin password..."
	ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
	echo "Argo CD is deployed."
	echo "Access the Argo CD GUI by running the following command:"
	echo "kubectl port-forward svc/argocd-server -n argocd 8080:443"
	echo "Then open http://localhost:8080 in your browser."
	echo "Default username: admin"
	echo "Default password: $ARGOCD_PASSWORD"
	echo ""
	echo "Listing available cluster nodes:"
	kubectl get nodes -o wide

	echo "DevOps environment setup completed successfully."

elif [ "$choice" == "2" ]; then
	echo "Stopping the cluster..."
	read -p "Do you want to completely remove the cluster? (y/n): " delete_choice
	if [[ "$delete_choice" =~ ^[Yy]$ ]]; then
		echo "Deleting the cluster..."
		minikube delete
	else
		echo "Stopping the cluster without deletion..."
		minikube stop
	fi
	echo "Cluster stopped."

else
	echo "Invalid option selected. Exiting."
	exit 1
fi
