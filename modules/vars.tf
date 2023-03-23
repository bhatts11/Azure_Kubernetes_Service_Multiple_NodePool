
variable "AKS_ClusterName" {
  type        = string
  default     = ""
  description = "Name of the AKS cluster to create"
}
variable "AKS_DNSPrefix" {
  type        = string
  default     = ""
  description = "DNS Prefix to use for AKS cluster"
}
variable "AKS_NodePoolName" {
  type        = string
  default     = "default"
  description = "AKS Node Pool Name - max length 12 chars only"
}
variable "AKS_NodeCount" {
  type        = number
  default     = 2
  description = "Node count in AKS Node pool"
}
variable "AKS_MaxPodsPerNode" {
  type        = number
  default     = 50
  description = "Max Pods allowed in AKS Node pool"
}
variable "AKS_NodeVmSize" {
  type        = string
  default     = "Standard_B2ms"
  description = "AKS Node pool VM size to deploy"
}
variable "AKS_NodeVmOSDiskSize" {
  type        = number
  default     = 30
  description = "AKS Node pool VM OS disk size"
}
variable "AKS_LoadBalancerSKU" {
  type        = string
  default     = "Standard"
  description = "AKS Load balancer SKU to use"
}
variable "AKS_NetworkPlugin" {
  type        = string
  default     = "azure"
  description = "ALS Network plugin to use azure defined or kubenet"
}
variable "AKS_SPClientID" {
  type        = string
  default     = ""
  description = "Service Priniciple ID to use in AKS deployment, this value should be fetch from key-vault"
}
variable "AKS_ClientSecret" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Service Priniciple secret to use in AKS deployment, fetched from key-vault"
}
variable "AKS_Version" {
  type        = string
  default     = "1.19.11"
  description = "AKS version to use while deploying"
}
variable "AKS_PrivateClusterEnabled" {
  type        = bool
  default     = false
  description = "Is AKS private cluster enabled"
}
variable "AKS_EnableKubeDashboard" {
  type        = bool
  default     = false
  description = "Enable the kube dashboard"
}
variable "location" {
  type        = string
  default     = "eastus2"
  description = "location for aks cluster deployment"
}
variable "rg_Name" {
  type        = string
  default     = ""
  description = "Resource group name to deploy the resources"
}
variable "aks_subnet_id" {
  type        = string
  default     = ""
  description = "Subnet to use for AKS cluster, fetched from module."
}

variable "cluster_auto_scaling" {
  type        = bool
  default     = true
  description = "Autoscaling enabled or not"
}
variable "min_count" {
  type        = number
  default     = 1
  description = "Minimum number of nodes to be created as part of autoscaling"
}

variable "max_count" {
  type        = number
  default     = 1
  description = "Minimum number of nodes to be created as part of autoscaling"
}


# variable "user_node_pools" {
#   type = map(object({
#     node_count                     = number
#     vm_size                        = string
#     max_pods                       = number 
#     os_disk_size_gb                = number
#     zones                          = list(string)
#     node_os                        = string
#     mode                           = string
#   }))

#   default = {
#     node_count                     = 1
#     vm_size                        = "Standard_B2ms"
#     max_pods                       = 110
#     os_disk_size_gb                = 128
#     node_os                        = "Windows"
#     mode                           = "User"
#   }

# }

variable "user_node_pool" {
  type = map(object({
    mode              = string
    vm_size           = string
    user_max_pods     = number
    user_os_size      = number
    node_os           = string
    user_auto_scaling = bool
    user_min_count    = number
    user_max_count    = number

  }))

}
