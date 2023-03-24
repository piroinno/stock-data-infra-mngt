global_settings = {
  default_region = "primary"
  regions = {
    primary = "westeurope"
  }
}

resource_groups = {
  vnet_cs_stock_data_dev = {
    name   = "vnet-cs-stock-data-dev"
    region = "primary"
  }
}

remote_networks = {
  management = {
    name          = "hub-mgnt"
    configuration = "network"
  }
}

subscription_id = "6016324a-afd1-4da5-b026-378af25f609b"
tenant_id       = "859e9d09-9fe3-4451-9029-35d7fb1f2e59"
environment     = "dev"
