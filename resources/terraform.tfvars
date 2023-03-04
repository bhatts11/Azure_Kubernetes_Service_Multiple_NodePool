subscription_id = "aa01771c-5ab3-4809-b7e6-30c8080fc4ee"

rg_Name  = "Blog_RG" ## We have to change as per env
location = "westeurope"

AKS_ClusterName           = "aks-terraform-modulesdev-eus2"
AKS_DNSPrefix             = "aks-dns-terraform-modulesdev"
AKS_Version               = "1.24.9"
AKS_PrivateClusterEnabled = false     ## changing the vlaue to true or false will destroy the existing cluster and create the new one.
AKS_EnableKubeDashboard   = false     ## please enble if required
AKS_NodePoolName          = "devpool" ## this name should be <= 12 chars
AKS_NodeVmSize            = "Standard_D2s_v3"
AKS_NodeCount             = 4
AKS_MaxPodsPerNode        = 50
AKS_NodeVmOSDiskSize      = 128
AKS_NetworkPlugin         = "azure"
AKS_LoadBalancerSKU       = "Standard"
cluster_auto_scaling      = true
min_count                 = 1
max_count                 = 1


  user_node_pools = {
    pool2 = {
      mode            = "User"
      vm_size         = "Standard_D2_v3"
      zones           = ["1", "2", "3"]
      user_max_pods   = 110
      user_os_size    = 128
      node_os         = "Windows"
      user_auto_scaling = true
      user_min_count  = 1
      user_max_count  = 1
    }
    
    pool3 = {
      mode            = "User"
      vm_size         = "Standard_D4s_v3"
      zones           = ["1", "2"]
      user_max_pods   = 50
      user_os_size    = 256
      node_os         = "Windows"
      user_auto_scaling = true
      user_min_count  = 1
      user_max_count  = 1
    }
  }
  