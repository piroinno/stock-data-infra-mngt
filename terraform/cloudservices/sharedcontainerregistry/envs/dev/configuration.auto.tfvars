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
  cloudservices = {
    name          = "cs_stock_data_dev"
    configuration = "network"
  }
}

subscription_id = "6016324a-afd1-4da5-b026-378af25f609b"
tenant_id       = "859e9d09-9fe3-4451-9029-35d7fb1f2e59"
environment     = "dev"
