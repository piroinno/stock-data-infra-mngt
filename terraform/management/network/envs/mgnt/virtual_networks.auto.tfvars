
vnets = {
  hub_mgnt = {
    resource_group_key = "vnet_hub_mgnt"
    region             = "primary"
    vnet = {
      name          = "hub-mgnt"
      address_space = ["100.63.100.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.63.100.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.63.100.64/26"]
      }
    }
    subnets = {
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.63.100.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }

  # hub_stock_data_dev = {
  #   resource_group_key = "vnet_hub_stock_data_dev"
  #   region             = "primary"
  #   vnet = {
  #     name          = "hub-stock-data-dev"
  #     address_space = ["100.65.100.0/22"]
  #   }
  #   subnets = {
  #     private_endpoints = {
  #       name                                           = "private_endpoints"
  #       cidr                                           = ["100.65.100.0/25"]
  #       enforce_private_link_endpoint_network_policies = true
  #     }
  #   }
  # }

  # hub_stock_data_uat = {
  #   resource_group_key = "vnet_hub_stock_data_uat"
  #   region             = "primary"
  #   vnet = {
  #     name          = "hub-stock-data-uat"
  #     address_space = ["100.65.100.0/22"]
  #   }
  #   subnets = {
  #     private_endpoints = {
  #       name                                           = "private_endpoints"
  #       cidr                                           = ["100.65.100.0/25"]
  #       enforce_private_link_endpoint_network_policies = true
  #     }
  #   }
  # }

  # hub_stock_data_prd = {
  #   resource_group_key = "vnet_hub_stock_data_prd"
  #   region             = "primary"
  #   vnet = {
  #     name          = "hub-stock-data-prd"
  #     address_space = ["100.66.100.0/22"]
  #   }
  #   subnets = {
  #     private_endpoints = {
  #       name                                           = "private_endpoints"
  #       cidr                                           = ["100.66.100.0/25"]
  #       enforce_private_link_endpoint_network_policies = true
  #     }
  #   }
  # }
}
