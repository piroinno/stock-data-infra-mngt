
vnet_peerings = {
  hub_mgnt_TO_cs_stock_data_dev = {
    name = "hub_mgnt_TO_cs_stock_data_dev"
    from = {
      vnet_key = "hub_mgnt"
    }
    to = {
      vnet_key = "cs_stock_data_dev"
      lz_key   = "cloudservices"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # hub_mgnt_TO_hub_stock_data_dev = {
  #   name = "hub_mgnt_TO_hub_stock_data"
  #   from = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   to = {
  #     vnet_key = "hub_stock_data_dev"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }

  # hub_stock_data_dev_TO_hub_mgnt = {
  #   name = "hub_stock_data_TO_hub_mgnt"
  #   from = {
  #     vnet_key = "hub_stock_data_dev"
  #   }
  #   to = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }

  # hub_mgnt_TO_hub_stock_data_uat = {
  #   name = "hub_mgnt_TO_hub_stock_data_uat"
  #   from = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   to = {
  #     vnet_key = "hub_stock_data_uat"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }

  # hub_stock_data_uat_TO_hub_mgnt = {
  #   name = "hub_stock_data_uat_TO_hub_mgnt"
  #   from = {
  #     vnet_key = "hub_stock_data_uat"
  #   }
  #   to = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }

  # hub_mgnt_TO_hub_stock_data_prd = {
  #   name = "hub_mgnt_TO_hub_stock_data_prd"
  #   from = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   to = {
  #     vnet_key = "hub_stock_data_prd"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }

  # hub_stock_data_prd_TO_hub_mgnt = {
  #   name = "hub_stock_data_prd_TO_hub_mgnt"
  #   from = {
  #     vnet_key = "hub_stock_data_prd"
  #   }
  #   to = {
  #     vnet_key = "hub_mgnt"
  #   }
  #   allow_virtual_network_access = true
  #   allow_forwarded_traffic      = false
  #   allow_gateway_transit        = false
  #   use_remote_gateways          = false
  # }
}
