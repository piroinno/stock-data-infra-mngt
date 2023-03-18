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

networking = {
  vnets = {
    hub_mgnt = {
      name = "hub-mgnt"
      subnets = {
        private_endpoints = {
          name = "private_endpoints"
        }
      }
    }
  }
}
