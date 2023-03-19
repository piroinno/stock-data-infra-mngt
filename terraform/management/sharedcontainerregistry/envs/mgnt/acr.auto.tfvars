azure_container_registries = {
  shared_acr_stock_data_mgnt = {
    name               = "shared-acr-stock-data-mgnt"
    resource_group_key = "acr_mgnt"
    sku                = "Premium"
    # diagnostic_profiles = {
    #   operations = {
    #     name             = "acr_logs"
    #     definition_key   = "azure_container_registry"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

    private_endpoints = {
      shared_acr_stock_data_mgnt_private_endpoint = {
        name               = "shared-acr-stock-data-mgnt-pe"
        resource_group_key = "acr_mgnt"

        vnet_key   = "hub_mgnt"
        subnet_key = "private_endpoints"
        lz_key     = "management"
        
        private_service_connection = {
          name                 = "shared-acr-stock-data-mgnt-psc"
          is_manual_connection = false
          subresource_names    = ["registry"]
        }
      }
    }
  }
}
