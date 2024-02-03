# aks-cluster/variables.tf

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