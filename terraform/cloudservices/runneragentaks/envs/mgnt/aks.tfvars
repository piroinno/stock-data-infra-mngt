aks_clusters = {
  aks_cs = {
    name               = "aks-cs-dev"
    resource_group_key = "aks_rg"
    os_type            = "Linux"

    # diagnostic_profiles = {
    #   operations = {
    #     name             = "aksoperations"
    #     definition_key   = "azure_kubernetes_cluster"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }
    identity = {
      type = "SystemAssigned"
    }

    vnet_key = "cs_stock_data_dev"
    lz_key   = "cloudservices"

    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    private_cluster_enabled = true
    enable_rbac             = true
    outbound_type           = "userDefinedRouting"

    admin_groups = {
      # ids = []
      # azuread_group_keys = ["aks_admins"]
    }
    private_cluster_public_fqdn_enabled = true
    load_balancer_profile = {
      managed_outbound_ip_count = 1
    }

    default_cs_dev_nodepool = {
      name                  = "default-cs-dev-nodepool"
      vm_size               = "Standard_DS2_v2"
      subnet_key            = "aks_mgnt_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 1
      os_disk_size_gb       = 128
      tags = {
        "project" = "cloudservices system services"
      }
    }

    node_resource_group_name = "aks-cs-dev-nodes-rg"

    node_pools = {
      nodepool_user = {
        name                = "nodepool-cs-dev"
        mode                = "User"
        subnet_key          = "aks_mgnt_nodepool_user"
        max_pods            = 10
        vm_size             = "Standard_DS2_v2"
        node_count          = 1
        enable_auto_scaling = false
        os_disk_size_gb     = 128
        tags = {
          "project" = "cloudservices user services"
        }
      }
    }
  }
}
