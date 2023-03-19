
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
        cidr = ["100.63.101.0/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.63.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.63.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.63.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
      aks_mgnt_nodepool_system = {
        name = "aks-mgnt-nodepool-system"
        cidr = ["100.63.104.0/26"]
      }
      aks_mgnt_nodepool_user = {
        name = "aks-mgnt-nodepool-user"
        cidr = ["100.63.104.64/26"]
      }
    }
  }

  hub_stock_data_dev = {
    resource_group_key = "vnet_hub_stock_data_dev"
    region             = "primary"
    vnet = {
      name          = "hub-stock-data-dev"
      address_space = ["100.64.100.0/22"]
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }

  hub_stock_data_uat = {
    resource_group_key = "vnet_hub_stock_data_uat"
    region             = "primary"
    vnet = {
      name          = "hub-stock-data-uat"
      address_space = ["100.65.100.0/22"]
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.65.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.65.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.65.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }

  hub_stock_data_prd = {
    resource_group_key = "vnet_hub_stock_data_prd"
    region             = "primary"
    vnet = {
      name          = "hub-stock-data-prd"
      address_space = ["100.66.100.0/22"]
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.66.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.66.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.66.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}
