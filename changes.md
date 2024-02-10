# Changes Documentation

## Introduction

In this commit, I implemented a feature branch to introduce the `delivery_date` column into the codebase. The modifications involved updating both the `app.py` and `order.html` files within the repository.

## Feature Implementation

### Code Modifications

1. **app.py**
   - Added handling for the `delivery_date` column in the relevant parts of the code.
   - Incorporated necessary logic to interact with the new data.

2. **order.html**
   - Updated the HTML template to display and capture the `delivery_date` in the order form.

### Reversion

Upon further consideration and feedback, it was determined that the introduction of the `delivery_date` column was not necessary for the current scope of the project. To revert the changes and restore the codebase to its previous state, the following actions were taken:

```bash
git revert <commit_hash_of_feature_branch>
```


# Networking Module Documentation

This repository contains Terraform code for defining networking services as part of an Infrastructure as Code (IaC) approach.

## Overview

The networking module is designed to create essential networking resources needed for an Azure Kubernetes Service (AKS) cluster. These resources include:

- Azure Resource Group
- Virtual Network (VNet)
- Control Plane Subnet
- Worker Node Subnet
- Network Security Group (NSG)

## Usage

### Initialization

Before using the networking module, ensure that Terraform is installed. Navigate to the `networking-module` directory and run the following command to initialize the Terraform configuration:

```bash
terraform init
```

# AKS Cluster Module Documentation

This commit also includes updates to the AKS cluster module. The following changes were made:

## Introduction

In the cluster module, I implemented the provisioning of an AKS cluster using Infrastructure as Code (IaC). The necessary Azure resources, including the AKS cluster, node pool, and service principal, were defined in the main.tf file.

## Input and Output Variables

Input variables for customizing the AKS cluster and output variables capturing essential information, such as the cluster name, ID, and Kubernetes configuration, were defined in the variables.tf and outputs.tf files, respectively.

initialize the Terraform configuration:

```bash
terraform init
```

## Issues encountered

I was having problems with my terraform files and i couldn't make sense of it so I choose to redo it.

After some time of trying to get it to work (I forgot to do terreform init in one of the directories). I finally applied the terraform configuration, adding the terraform and state files to my local .gitignore and pushing to github.

# Kubernetes Deployment Documentation

## Overview

This documentation outlines the steps taken to deploy a containerized Flask application onto a Terraform-provisioned AKS (Azure Kubernetes Service) cluster. The deployment includes creating a Kubernetes Deployment and Service using manifests.

## Deployment Manifests

The Kubernetes manifests (`application-manifest.yaml`) define the following resources:

### Deployment

- **Name:** flask-app-deployment
- **Replicas:** 2
- **Selector Label:** app: flask-app
- **Pod Template Label:** app: flask-app
- **Container:** nallouane/myimage:v1
- **Port:** 5000
- **Deployment Strategy:** Rolling Update with maxUnavailable=1 and maxSurge=1

### Service

- **Name:** flask-app-service
- **Selector Label:** app: flask-app
- **Port Configuration:** TCP protocol, port 80, targetPort 5000
- **Service Type:** ClusterIP

## Deployment Process

1. **Set Kubernetes Context:**
   - Setting the correct Kubernetes context is set using `kubectl config use-context <your-aks-context-name>`.

2. **Apply Manifests:**
   - Deploy the manifests using `kubectl apply -f application-manifest.yaml`.

3. **Monitor Deployment:**
   - Use `kubectl get pods -w` to monitor the deployment process. Ensure that pods transition to the `Running` state.

4. **Verification:**
   - After deployment, use `kubectl get pods` and `kubectl get services` to verify the status and details of deployed resources.

### Issues Encountered:

I used these steps to troubleshoot:

- Check the correctness of image name and tag.
- Verify image visibility and repository permissions.
- Review network connectivity to the container registry.
- Ensure authentication and pull secrets are correctly configured.

but all went smoothly.

## Cleanup

To remove the deployed resources, use `kubectl delete -f application-manifest.yaml` and verify deletion using `kubectl get pods` and `kubectl get services`.

---
## CI/CD Pipeline Documentation

This document provides comprehensive information about the Continuous Integration/Continuous Deployment (CI/CD) pipeline in Azure DevOps for this project.

### Azure DevOps Pipeline Configuration:

#### Build Pipeline:

- **Build Trigger:** The build pipeline is triggered automatically on every push to the main branch.
- **Build Steps:**
  - Retrieve source code from GitHub.
  - Build and compile the application.
  - Run tests to ensure code quality.
  - Publish artifacts.

#### Release Pipeline:

- **Release Trigger:** The release pipeline is triggered automatically upon successful completion of the build pipeline.
- **Release Stages:**
  - **Dev Stage:** Deploy to a staging environment for validation.
  - **Prod Stage:** Deploy to the production environment.

#### Docker Hub Integration:

- **Docker Image Build:** The CI/CD pipeline builds a Docker image during the build stage.
- **Docker Image Push:** The pipeline pushes the Docker image to Docker Hub during the release stage.

#### AKS (Azure Kubernetes Service) Integration:

- **Deployment:** The application is deployed to an AKS cluster during the release stage.
- **Validation:** Port forwarding is used for local testing to ensure the application runs correctly on the AKS cluster.

### Validation Steps:

1. **Monitor Pod Status:**
   - Use `kubectl get pods` to check the status of pods within the AKS cluster.

2. **Initiate Port Forwarding:**
   - Use `kubectl port-forward` to forward traffic to the local machine for testing.

3. **Access Locally Exposed Address:**
   - Open a web browser and navigate to `http://localhost:8080` to test the application functionality.

### Issues Encountered:

Forgot to set up your pipeline to have the agents that will be used to run the jobs. Oversight was pointed out to me when trying to build the pipeline.

Instead of usidng 'dockerfile' I used 'Dockerfile' when builiding the CI pipeline. Silly error but was frustrating at the time.

---
