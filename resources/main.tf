# backend storageaccount declaration to store the terraform state file. This should exist already.
terraform {
  backend "azurerm" {
    #   subscription_id       = "da74xxxx-9c9a-xxxx-8fae-xxxxxxxxxxxx"
    subscription_id      = "xxxx-xxxx-xxxx-xxxx-xxxx"
    resource_group_name  = "terraform_state_rg"
    storage_account_name = "tfstatebackendtech" # Storage account used for backend
    container_name       = "terraformstate"
    key                  = "terraform.tfstate" # Terraform State file
  }
}
# Azurerm providers declaration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.42.0"
    }
  }
  #required_version = ">= 0.13"
}
provider "azurerm" {
  alias                      = "coeauto"
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

## To get object & tenant ID , declaring the data source. 
data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet" {
  name                 = "default"
  virtual_network_name = "aks_vn"
  resource_group_name  = "DP-203"
}

output "subnet_id" {
  value = "${data.azurerm_subnet.subnet.id}"
}

#############################################################################

module "aks_cluster" {
  source                    = "../modules"
  location                  = var.location
  rg_Name                   = var.rg_Name
  AKS_ClusterName           = "aks_test" #var.AKS_ClusterName
  AKS_DNSPrefix             = var.AKS_DNSPrefix
  AKS_Version               = var.AKS_Version
  AKS_PrivateClusterEnabled = var.AKS_PrivateClusterEnabled ## changing the vlaue to true or false will destroy the existing cluster and create the new one.
  AKS_EnableKubeDashboard   = var.AKS_EnableKubeDashboard   ## please enble if required
  AKS_NodePoolName          = var.AKS_NodePoolName
  AKS_MaxPodsPerNode        = var.AKS_MaxPodsPerNode
  AKS_NodeVmSize            = var.AKS_NodeVmSize
  AKS_NodeVmOSDiskSize      = var.AKS_NodeVmOSDiskSize
  AKS_LoadBalancerSKU       = var.AKS_LoadBalancerSKU
  AKS_NetworkPlugin         = var.AKS_NetworkPlugin
  cluster_auto_scaling      = var.cluster_auto_scaling
  min_count                 = var.min_count
  max_count                 = var.max_count
  aks_subnet_id             = data.azurerm_subnet.subnet.id #"/subscriptions/aa01771c-5ab3-4809-b7e6-30c8080fc4ee/resourceGroups/DP-203/providers/Microsoft.Network/virtualNetworks/aks_vn/subnets/default"
  user_node_pool            = var.user_node_pools
}
