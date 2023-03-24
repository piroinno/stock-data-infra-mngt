
vnet_peerings = {
  cs_stock_data_dev_TO_hub_mgnt = {
    name = "cs_stock_data_dev_TO_hub_mgnt"
    from = {
      vnet_key = "cs_stock_data_dev"
    }
    to = {
      vnet_key = "hub_mgnt"
      lz_key   = "management"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
