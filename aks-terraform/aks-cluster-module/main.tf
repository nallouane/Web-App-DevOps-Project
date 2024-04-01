# aks-cluster/main.tf

# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  # The following are from the first part of aks-cluster/variables.tf to configure correctly:
  name                = var.aks_cluster_name
  location            = var.cluster_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  # The follwing configuration provides flexibility for scaling the default node pool based on 
  # the demands of the applications running in the AKS cluster, ensuring efficient resource utilization 
  # and responsiveness to varying workloads. Adjustments to parameters such as node count, VM size,
  # and auto-scaling settings can be made according to specific deployment requirements: 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count = 1
    max_count = 3
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }
}