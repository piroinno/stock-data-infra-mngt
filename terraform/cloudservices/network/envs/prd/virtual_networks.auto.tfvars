
vnets = {
  cs_stock_data_prd = {
    resource_group_key = "vnet_cs_stock_data_prd"
    region             = "primary"
    vnet = {
      name          = "cs-stock-data-prd"
      address_space = ["100.68.100.0/22"]
    }
    subnets = {
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.68.100.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
      aks_com_stock_data_nodepool_system = {
        name = "aks-com-sd-prd-nodepool-system"
        cidr = ["100.68.101.192/26"]
      }
      aks_com_stock_data_nodepool_user = {
        name = "aks-com-sd-prd-nodepool-user"
        cidr = ["100.68.101.128/26"]
      }
    }
  }
}