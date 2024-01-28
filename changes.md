#Documentation of changes

I created a new feature branch to modify the code to incorporate the delivery_date column. To do this you will need to update both the app.py and order.html files in the repository. However, these changes weren't necessary so I 'git reverted' back to the previous commit.

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
