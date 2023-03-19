global_settings = {
  default_region = "primary"
  regions = {
    primary = "westeurope"
  }
}

resource_groups = {
  acr_mgnt = {
    name   = "acr-mgnt"
    region = "primary"
  }
  vnet_hub_mgnt = {
    name   = "vnet-hub-mgnt"
    region = "primary"
  }
}

remote_networks = {
  management = {
    vnet          = "hub-mgnt"
    configuration = "network"
  }
}
