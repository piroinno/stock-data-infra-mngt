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
}

remote_networks = {
  management = {
    name          = "hub-mgnt"
    configuration = "network"
  }
}
