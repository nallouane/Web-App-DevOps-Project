# Project Documentation

Documentation project history.

## Feature Implementation

## Introduction

In this commit, I implemented a feature branch to introduce the `delivery_date` column into the codebase. The modifications involved updating both the `app.py` and `order.html` files within the repository.

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

# Docker Containerization Process

## Introduction

By using docker, I containerized the application, allowing for distribution to different teams across the company to work on the project, irrespective of their working environment. The process involved creating a 'dockerfile', which will gave instructions on containerising the application. Using ```docker build``` and ```docker push```, an image is created, and pushed to dockerhub.

## Dockerfile

1. **Base Image:**
   - The Dockerfile starts with specifying a base image using the `FROM` instruction. This is the starting point for your image and provides the basic operating system and environment:
     ```dockerfile
     FROM --platform=linux/amd64 public.ecr.aws/docker/library/python:3.9.10-slim-buster
     ```

2. **Working Directory:**
   - You can set a working directory using the `WORKDIR` instruction, which defines the directory where subsequent instructions will be executed:
     ```dockerfile
     WORKDIR /app
     ```

3. **Copying Files:**
   - The `COPY` instruction copies files from the host machine to the container's file system. This is used to add application code, configuration files, or other necessary resources:
     ```dockerfile
     COPY . /app
     ```

4. **Running Commands:**
   - The `RUN` instruction executes commands inside the container during the image build process. This is used to install dependencies, set up the environment, or perform other tasks. This was used to install system dependencies and and ODBC driver:
     ```dockerfile
     RUN apt-get update && apt-get install -y \
         unixodbc unixodbc-dev odbcinst odbcinst1debian2 libpq-dev gcc && \
         apt-get install -y gnupg && \
         apt-get install -y wget && \
         wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
         wget -qO- https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
         apt-get update && \
         ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
         apt-get purge -y --auto-remove wget && \  
         apt-get clean
     ```

5. **Dependancies**
   - Installing dependacies.

   ```dockerfile
      # Install pip and setuptools
      RUN pip install --upgrade pip setuptools

      # Install Python packages specified in requirements.txt

      RUN pip install --trusted-host pypi.python.org -r requirements.txt
     
     ```

5. **Exposing Ports:**
   - The `EXPOSE` instruction informs Docker that the container will listen on specified network ports at runtime. However, it does not actually publish the ports:
     ```dockerfile
     EXPOSE 5000
     ```

6. **Defining Entrypoint or CMD:**
   - The `CMD` instruction sets the default command to run when a container is started. It can also be overridden at runtime. The `ENTRYPOINT` instruction allows you to configure a container that will run as an executable:
     ```dockerfile
     CMD ["python", "app.py"]
     ```

# Docker Build Instructions

## Docker Build

The following steps outline how to build a Docker image for your application:

1. **Navigate to the Project Directory:**
   - Open a terminal and change your working directory to the root of your project where the Dockerfile is located.

   ```bash
   cd /path/to/your/project
   ```

2. **Build the Docker Image**
   -Use the docker build command to build the Docker image. Specify the path to the directory containing the Dockerfile using the dot (.) if the Dockerfile is in the current directory.

   ```bash
   docker build -t myapp:latest .   
   ```

   The -t flag is used to tag the image, and myapp:latest is an example tag for your image. Adjust the tag according to your project naming conventions.

   As Docker builds the image, it executes each instruction in the Dockerfile. You'll see output indicating the progress of each step. Pay attention to any error messages or warnings.

   Once the build is complete, you can verify that the image has been created by listing all Docker images on your system.

   ```bash
   docker images
   ```
3. **Run the image locally**

   Run a Docker container locally to ensure the application functions correctly within the containerized environment.


   Execute the following command to initiate the Docker container: docker run -p 5000:5000 <name of the image>. This maps port 500 from your local machine to the container, enabling access to the containerized application from your local development environment.


   Open a web browser and go to http://127.0.0.1:5000 to interact with the application within the Docker container. Confirm the application works as expected by testing its functionality within the containerized environment.


4. **Push to Docker Hub**

   Finally pushed the image to dockerhub:

   ```bash   
   docker login
   docker tag <name of the image> <docker-hub-username>/<image-name>:<tag>.
   ```

   Log in to your Docker Hub account if you're not already logged in. Confirm that your Docker image is listed within your repository. You should be able to see the image's name, version (tag), and other relevant information.


## Clean Up

**Remove Containers**: Use the ```docker ps -a command``` to list all containers, including stopped ones. Remove any unnecessary containers with ```docker rm <container-id>``` to free up resources.

**Remove Images**: List all images using ```docker images -a``` and remove any unneeded images with ```docker rmi <image-id>``` to reclaim disk space

---
---
## Networking Module Documentation

This section contains Terraform code for defining networking services as part of an Infrastructure as Code (IaC) approach.

Started by creating a new directory, 'aks-terraform', and inside that creating a 'networking-module'.

## Overview

The networking module is designed to create essential networking resources needed for an Azure Kubernetes Service (AKS) cluster. These resources include:

- Azure Resource Group
- Virtual Network (VNet)
- Control Plane Subnet
- Worker Node Subnet
- Network Security Group (NSG)

## Files

The terraform configuration has 3 files:

 - variables.tf
 - main.tf
 - outputs.tf

## networking-module/variables.tf

### `resource_group_name`

- **Purpose:** This variable defines the name of the Azure Resource Group where the networking resources will be deployed.
- **Type:** `string`
- **Default:** `"aks-rg"`

### `location`

- **Purpose:** Specifies the Azure region where the networking resources will be provisioned.
- **Type:** `string`
- **Default:** `"UK South"`

### `vnet_address_space`

- **Purpose:** Defines the address space for the Virtual Network (VNet), specifying the range of IP addresses.
- **Type:** `list(string)`
- **Default:** `["10.1.0.0/16"]`

## networking-module/main.tf

### Overview

This Terraform configuration defines networking resources for an Azure Kubernetes Service (AKS) cluster. It creates an Azure Resource Group, a Virtual Network (VNet), and associated subnets. Additionally, it sets up a Network Security Group (NSG) with rules to control inbound traffic to the AKS cluster.

## Resources Created

1. **Azure Resource Group**

Creates an Azure Resource Group for networking resources.

**Purpose:** Grouping networking resources for easier management.

```hcl
resource "azurerm_resource_group" "networking" {
  name     = var.resource_group_name
  location = var.location
}
```

2. **Virtual Network (VNet)**

**Purpose**: Providing a dedicated network for the AKS cluster.

```hcl
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "my_vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}
```
3. **Subnets**

**Purpose**: Organizing resources and controlling network traffic.

```hcl
resource "azurerm_subnet" "control_plane_subnet" {
  name                 = "my_control_plane_subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "worker_node_subnet" {
  name                 = "my_worker_node_subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
```
4. **Network Security Group (NSG)**

**Purpose**: Controlling inbound network traffic to the AKS cluster.

```hcl
resource "azurerm_network_security_group" "aks_nsg" {
  name                = "aks_nsg"
  location            = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}
```
5. **NSG Rules**

**Purpose**: Controlling inbound network traffic to the AKS cluster.

```hcl
resource "azurerm_network_security_rule" "kube_apiserver" {
  name                        = "my_nsg_rule1"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "82.31.251.163"  # Replace with your public IP or IP range
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "my_nsg_rule2"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "82.31.251.163"  # Replace with your public IP or IP range
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}
```

# networking-module/outputs.tf

## Purpose
This file defines Terraform outputs for retrieving information about the networking resources created by the networking module.

### vnet_id
- **Purpose:** Virtual Network (VNet) ID output.
- **Description:** Outputs the ID of the Virtual Network (VNet) created by the networking module.

### control_plane_subnet_id
- **Purpose:** Control plane subnet ID output.
- **Description:** Outputs the ID of the subnet reserved for the AKS control plane.

### worker_node_subnet_id
- **Purpose:** Worker node subnet ID output.
- **Description:** Outputs the ID of the subnet reserved for AKS worker nodes.

### resource_group_name
- **Purpose:** Resource Group name output.
- **Description:** Outputs the name of the Azure Resource Group for networking resources. This value is obtained from a variable.

### aks_nsg_id
- **Purpose:** Network Security Group (NSG) ID output.
- **Description:** Outputs the ID of the Network Security Group (NSG) created for AKS.

### Initialization

Before using the networking module, ensure that Terraform is installed. 

Navigate to the `networking-module` directory and run the following command to initialize the Terraform configuration:

```bash
terraform init
```

## AKS Cluster Module Documentation

This commit also includes updates to the AKS cluster module. The following changes were made:

## Introduction

In the cluster module, I implemented the provisioning of an AKS cluster using Infrastructure as Code (IaC). The necessary Azure resources, including the AKS cluster, node pool, and service principal, were defined in the main.tf file.

Start by creating a new module 'aks-cluster-module' inside the 'aks-terraform' directory.

## Input and Output Variables

Input variables for customizing the AKS cluster and output variables capturing essential information, such as the cluster name, ID, and Kubernetes configuration, were defined in the variables.tf and outputs.tf files, respectively.

## Files

The terraform configuration has 3 files:

 - variables.tf
 - main.tf
 - outputs.tf

## aks-cluster/variables.tf

The variables.tf allows for proper configuration of the cluster.

```bash
   
variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "myakscluster"
}

variable "cluster_location" {
  description = "The Azure region where the AKS cluster will be deployed"
  type        = string
  default     = "UK South"
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "myaksclusterdns"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
  default     = "1.28.3"
}

variable "service_principal_client_id" {
  description = "The client ID of the Azure AD service principal for the AKS cluster"
  type        = string
  default     = "your-service-principal-client-id"
}

variable "service_principal_client_secret" {
  description = "The client secret of the Azure AD service principal for the AKS cluster"
  type        = string
  default     = "your-service-principal-client-secret"
}
```

The next section allows for inputs from the networking-module:

```bash
# Input variables from the networking module

variable "vnet_id" {
  description = "ID of the Virtual Network (VNet)."
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet."
}

variable "worker_node_subnet_id" {
  description = "ID of the worker node subnet."
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group for networking resources."
  default = "aks-rg"
}

# Define more output variables as needed...
variable "aks_nsg_id" {
  description = "ID of the Network Security Group (NSG) for AKS."
}
```

## aks-cluster/main.tf

There was one resource in the main.tf file,

```bash
   resource "azurerm_kubernetes_cluster" "aks_cluster"
   ```

The follwing are just needed to configure correctly:

```bash
  name                = var.aks_cluster_name
  location            = var.cluster_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
```
The follwing configuration provides flexibility for scaling the default node pool based on the demands of the applications running in the AKS cluster, ensuring efficient resource utilization and responsiveness to varying workloads. Adjustments to parameters such as node count, VM size, and auto-scaling settings can be made according to specific deployment requirements:

```bash
default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count = 1
    max_count = 3}
```

Finally, the service principal authenticates the connection to the cluster

```bash
service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret}
```

## aks-cluster/outputs.tf

This file defines Terraform outputs for retrieving information about the created Azure Kubernetes Service (AKS) cluster.

### aks_cluster_name
- **Purpose:** AKS cluster name output.
- **Description:** Outputs the name of the AKS cluster created by Terraform.

### aks_cluster_id
- **Purpose:** AKS cluster ID output.
- **Description:** Outputs the unique identifier (ID) of the AKS cluster created by Terraform.

### aks_kubeconfig
- **Purpose:** AKS cluster kubeconfig output.
- **Description:** Outputs the kubeconfig file for accessing the AKS cluster. The kubeconfig file contains the necessary information to connect to the AKS cluster using tools like `kubectl`.


### Initialization

Before using the networking module, ensure that Terraform is installed. 

Navigate to the `aks-cluster-module` directory and run the following command to initialize the Terraform configuration:

```bash
   terraform init
   ```

## Creation of the AKS Cluster

After setting up the networking module and AKS cluster module, it is time to move on to the creation of the cluster.

This step requires two files:
- main.tf
- variables.tf

# main.tf

**purpose**: This Terraform configuration specifies the required provider (Azure) and its version.

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
```

**purpose**: Configuration for the Azure provider with necessary authentication details.

```hcl
provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = "a79df85c-a45e-42a2-a339-c88a5a4f2849"
  tenant_id       = "47d4542c-f112-47f4-92c7-a838d8a5e8ef"
}
```

**purpose**: Networking module instantiation for creating network resources. 

```hcl
module "networking" {
  source = "./networking-module"

  # Input variables for the networking module
  resource_group_name = "aks-rg"
  location           = "UK South"
  vnet_address_space = ["10.0.0.0/16"]
}
```

**purpose**: AKS Cluster module instantiation for creating Azure Kubernetes Service.

```hcl
module "aks_cluster" {
  source = "./aks-cluster-module"

  # Input variables for the AKS cluster module

  aks_cluster_name           = "terraform-aks-cluster"
  cluster_location           = "UK South"
  dns_prefix                 = "myaks-project"
  kubernetes_version         = "1.26.6"  # Adjust the version as needed
  service_principal_client_id = var.client_id
  service_principal_client_secret = var.client_secret

  # Input variables referencing outputs from the networking module

  resource_group_name         = module.networking.resource_group_name
  vnet_id                     = module.networking.vnet_id
  control_plane_subnet_id     = module.networking.control_plane_subnet_id
  worker_node_subnet_id       = module.networking.worker_node_subnet_id
  aks_nsg_id                  = module.networking.aks_nsg_id
}
```

## variables.tf

was used to add as the clinet secret, 'clinet_id' and 'client_secret'

```bash
   # variables.tf

variable "client_id" {
  description = "Access key for the provider"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secret key for the provider"
  type        = string
  sensitive   = true
}
```

---

After all this, by going into the aks-terraform directory, initialise and apply the terraform configuratio using:

```bash
   terraform init
   terrafom apply 
```

then putting the terraform and state files into my .gitignore to not leak sensitive information:

```bash
   # Ignore Terraform files in aks-terraform directory
   *.terraform/
   *terraform.tfstate
```

## Issues encountered

I was having problems configuring my terraform files and couldn't make sense of it, so I choose to start over. Following the same process I worked.

After some time of trying to get it to work (I forgot to do terreform init in one of the directories). I finally applied the terraform configuration, adding the terraform and state files to my local .gitignore and pushing to github.

---
---

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
- **Container:** nallouane/myimage:latest
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

### Cleanup

To remove the deployed resources, use `kubectl delete -f application-manifest.yaml` and verify deletion using `kubectl get pods` and `kubectl get services`.

### Issues Encountered:

I used these steps to troubleshoot:

- Check the correctness of image name and tag.
- Verify image visibility and repository permissions.
- Review network connectivity to the container registry.
- Ensure authentication and pull secrets are correctly configured.

but all went smoothly.

---
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

Instead of usidng 'dockerfile' I used 'Dockerfile' when builiding the CI pipeline. Silly error, but was frustrating at the time.

---
---
## AKS Cluster Monitoring Documentation

### Overview

This documentation outlines the steps taken to establish effective monitoring and alerting for an Azure Kubernetes Service (AKS) cluster. Proper monitoring is essential for ensuring the optimal performance, resource allocation, and stability of the AKS environment.

### Metrics Explorer Configuration

After enabling container insights, the following charts were created in the Metrics Explorer to provide a comprehensive overview of the AKS cluster's performance:

1. **Average Node CPU Usage:**
   - *Purpose:* Track CPU usage of AKS cluster nodes for efficient resource allocation and performance issue detection.

2. **Average Pod Count:**
   - *Purpose:* Display the average number of pods running in the AKS cluster, aiding in capacity evaluation and workload distribution analysis.

3. **Used Disk Percentage:**
   - *Purpose:* Monitor disk usage to prevent storage-related issues by tracking the utilized disk space.

4. **Bytes Read and Written per Second:**
   - *Purpose:* Monitor data I/O to identify potential performance bottlenecks by providing insights into data transfer rates.

## Log Analytics Configuration

Log Analytics was configured to capture detailed information for more in-depth analysis:

1. **Average Node CPU Usage Percentage per Minute:**
   - *Purpose:* Record granular data on node-level CPU usage, capturing logs per minute for detailed analysis.

2. **Average Node Memory Usage Percentage per Minute:**
   - *Purpose:* Track node-level memory usage to detect memory-related performance concerns and optimize resource allocation.

3. **Pods Counts with Phase:**
   - *Purpose:* Provide information on pod counts with different phases (Pending, Running, Terminating) for workload distribution insights.

4. **Find Warning Value in Container Logs:**
   - *Purpose:* Proactively detect issues or errors within containers by configuring Log Analytics to search for warning values in container logs.

5. **Monitoring Kubernetes Events:**
   - *Purpose:* Monitor Kubernetes events, including pod scheduling, scaling activities, and errors, to ensure overall cluster health and stability.

### Alert Rule Configuration

#### Disk Usage Alert

- **Objective:** Trigger an alarm when the used disk percentage in the AKS cluster exceeds 90%.
- **Frequency:** Check every 5 minutes.
- **Loopback Period:** 15 minutes.
- **Notification:** Configure alerts to be sent to the specified email address for proactive issue detection and resolution planning.

### CPU and Memory Usage Alerts

- **Objective:** Trigger alerts when CPU usage and memory working set percentage exceed 80%.
- **Purpose:** Ensure timely notification when critical resources approach their limits, preventing decreased application performance.
- **Frequency:** Check every 5 minutes.
- **Notification:** Alerts configured to notify the specified email address for prompt response and resource optimization.

By implementing these monitoring and alerting configurations, the AKS cluster is equipped to maintain optimal performance and respond promptly to potential issues.

---
---

## AKS integration with Azure Key Vault

### Introduction

The 'app.py' has hard coded the information needed to connect to the Azure SQL backend surver. This provides security risks, using Azure Key Vault, i can make these into 'secrets' which allows for security when pushing to the cloud.

### Creating an Azure Key Vault

By going onto the Azure portal, I easily created my key 'finalkeyy' (Weird name choice but everything reasonable I put was 'taken in soft delete'). I proceeded to add the four secrets that were hardcoded to 'app.py' onto my key. 

- Server name
- Server username
- Server Password
- Database name

by using the following command i created and assigned the key Vault Administrator roll to a User-assigned Managed Identity.

```bash
   # Create a user-assigned managed identity
   az identity create -g myResourceGroup -n myUserAssignedIdentity
   az aks update --resource-group <resource-group> --name <aks-cluster-name> --enable-managed-identity
   az aks show --resource-group <resource-group> --name <aks-cluster-name> --query identityProfile

   ```

then assigned the Key Vault Secrets Officer role to the managed identity associated with AKS, allowing it to retrieve and manage secrets.

```bash
   # Assign "Key Vault Secrets Officer" role to Managed Identity
az role assignment create --role "Key Vault Secrets Officer" \
  --assignee <managed-identity-client-id> \
  --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{key-vault-name}
  ```

### Update the application code

Integrate the Azure Identity and Azure Key Vault libraries into the Python application code to facilitate communication with Azure Key Vault. Modify the code to use managed identity credentials, ensuring secure retrieval of database connection details from the Key Vault.

This was done using the following format:

#### Import necessary libraries
from azure.identity import ManagedIdentityCredential
from azure.keyvault.secrets import SecretClient

#### Replace these values with your Key Vault details
key_vault_url = "https://your-key-vault-name.vault.azure.net/"

#### Set up Azure Key Vault client with Managed Identity
credential = ManagedIdentityCredential()
secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

#### Access the secret values from Key Vault
secret = secret_client.get_secret("secret-name")

#### Retrieve the secret values
secret_value = secret.value

```bash
   # Replace these values with your Key Vault details
key_vault_name = "finalkeyy"
key_vault_url = f"https://{key_vault_name}.vault.azure.net/"

# Set up Azure Key Vault client with Managed Identity
credential = ManagedIdentityCredential()
secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

# Access the secret values from Key Vault
server_name = secret_client.get_secret("server-name").value
server_username = secret_client.get_secret("server-username").value
server_password = secret_client.get_secret("server-password").value
database_name = secret_client.get_secret("database-name").value

# database connection 
server = server_name
database = database_name
username = server_username
password = server_password
driver= '{ODBC Driver 18 for SQL Server}'
```

and adding the correct depndancies to the requiremnts.txt file:

1. **azure-identity==1.15.0**
2. **azure-keyvault-secrets==4.7.0**

# Testing 

by adding a new feature I wanted to see if the pipeline would integrate it seemlessly.

```bash
#test feature to see if the pipeline works properly
@app.route('/health')
def health_check():
    return 'It workssss'
```

by port forwarding on one of my pods, accessing http://localhost:8080/health returned the 'It workssss' message, showing me that there was a seamless integration with Azure Key Vault.

## Issues

Understanding that the azure devops service pipeline didnt pop up with every push to github was hard to get my head around at first. I now understand that it still updates just does not show up only with specific changes.

---
---
---