# Minikube GitOps Project

This project sets up a local Kubernetes development environment using Minikube with GitOps practices implemented through Argo CD. It provides a simple way to start and manage a local Kubernetes cluster with GitOps capabilities.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Project Structure

```
.
├── scripts/
│   ├── main.sh           # Main script for cluster management
│   ├── start_minikube.sh # Script to start Minikube cluster
│   └── deploy_argocd.sh  # Script to deploy Argo CD
```

## Features

- Multi-node Minikube cluster (2 nodes)
- Argo CD deployment for GitOps
- Pre-configured namespaces:
  - `argocd`: For Argo CD components
  - `monitoring`: For monitoring tools

## Getting Started

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd minikube-gitops-project
   ```

2. Make the scripts executable:
   ```bash
   chmod +x scripts/*.sh
   ```

3. Run the main script:
   ```bash
   ./scripts/main.sh
   ```

4. Choose option 1 to start the cluster. The script will:
   - Start Minikube with 2 nodes
   - Create necessary namespaces
   - Deploy Argo CD
   - Display access information for Argo CD

## Accessing Argo CD

After the cluster is running, you can access the Argo CD UI:

1. Start port forwarding:
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

2. Open your browser and navigate to:
   ```
   http://localhost:8080
   ```

3. Login with:
   - Username: `admin`
   - Password: (displayed in the terminal after deployment)

## Managing the Cluster

The main script (`main.sh`) provides two options:

1. Start the cluster
2. Stop the cluster (with option to completely remove it)

To stop the cluster, run:
```bash
./scripts/main.sh
```
And select option 2.

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the MIT License. 
