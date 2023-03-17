global_settings = {
  default_region = "primary"
  regions = {
    primary = "westeurope"
  }
}

resource_groups = {
  vnet_hub_mgnt = {
    name   = "vnet-hub-mgnt"
    region = "primary"
  }
  vnet_hub_stock_data_dev = {
    name   = "vnet-hub-stock-data-dev"
    region = "primary"
  }
  vnet_hub_stock_data_uat = {
    name   = "vnet-hub-stock-data-uat"
    region = "primary"
  }
  vnet_hub_stock_data_prd = {
    name   = "vnet-hub-stock-data-prd"
    region = "primary"
  }
}

subscription_id = "5ae65a7a-19c4-4bf6-b409-3f5e2e490cdb"
tenant_id       = "859e9d09-9fe3-4451-9029-35d7fb1f2e59"
environment     = "mgnt"
