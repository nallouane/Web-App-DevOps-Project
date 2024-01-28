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
