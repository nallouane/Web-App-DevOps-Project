#Documentation of changes

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

# AKS Cluster Module Documentation

This commit also includes updates to the AKS cluster module. The following changes were made:

## Introduction

In the cluster module, I implemented the provisioning of an AKS cluster using Infrastructure as Code (IaC). The necessary Azure resources, including the AKS cluster, node pool, and service principal, were defined in the main.tf file.

## Input and Output Variables

Input variables for customizing the AKS cluster and output variables capturing essential information, such as the cluster name, ID, and Kubernetes configuration, were defined in the variables.tf and outputs.tf files, respectively.

initialize the Terraform configuration:

```bash
terraform init

I was having problems with my terraform files and i couldn't make sense of it so I choose to redo it.

