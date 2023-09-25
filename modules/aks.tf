
## AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.AKS_ClusterName
  location                = var.location
  resource_group_name     = var.rg_Name
  dns_prefix              = var.AKS_DNSPrefix
  kubernetes_version      = var.AKS_Version
  private_cluster_enabled = var.AKS_PrivateClusterEnabled

  default_node_pool {
    name                = var.AKS_NodePoolName
    vm_size             = var.AKS_NodeVmSize
    os_disk_size_gb     = var.AKS_NodeVmOSDiskSize
    max_pods            = var.AKS_MaxPodsPerNode
    vnet_subnet_id      = var.aks_subnet_id #data.azurerm_subnet.example.id
    enable_auto_scaling = var.cluster_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = var.AKS_EnableKubeDashboard
    }
  }
  network_profile {
    load_balancer_sku = var.AKS_LoadBalancerSKU
    network_plugin    = var.AKS_NetworkPlugin
    #docker_bridge_cidr = "170.10.1.0/24"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user_node_pools" {
  for_each              = var.user_node_pool

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.key
  mode                  = each.value.mode
  vm_size               = each.value.vm_size
  max_pods              = each.value.user_max_pods
  os_disk_size_gb       = each.value.user_os_size
  os_type               = each.value.node_os
  vnet_subnet_id        = var.aks_subnet_id #data.azurerm_subnet.example.id
  enable_auto_scaling   = each.value.user_auto_scaling
  min_count             = each.value.user_min_count
  max_count             = each.value.user_max_count
}
