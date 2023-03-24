
vnets = {
  cs_stock_data_dev = {
    resource_group_key = "vnet_cs_stock_data_dev"
    region             = "primary"
    vnet = {
      name          = "cs-stock-data-dev"
      address_space = ["100.64.100.0/22"]
    }
    subnets = {
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.100.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
      aks_mgnt_nodepool_system = {
        name = "aks-dev-nodepool-system"
        cidr = ["100.64.100.128/26"]
      }
      aks_mgnt_nodepool_user = {
        name = "aks-dev-nodepool-user"
        cidr = ["100.64.100.192/26"]
      }
      aks_com_stock_data_nodepool_system = {
        name = "aks-com-sd-dev-nodepool-system"
        cidr = ["100.64.101.192/26"]
      }
      aks_com_stock_data_nodepool_user = {
        name = "aks-com-sd-dev-nodepool-user"
        cidr = ["100.64.101.128/26"]
      }
    }
  }
}