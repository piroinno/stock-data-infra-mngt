postgresql_servers = {
  pg_com_sd_dev = {
    name                          = "pg-com-sd-dev"
    region                        = "primary"
    resource_group_key            = "postgresql_com_stock_data_dev"
    version                       = "9.6"
    sku_name                      = "GP_Gen5_2"
    administrator_login           = "postgresqlsalesadmin"
    keyvault_key                  = "sd-postgres"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = true
    auto_grow_enabled             = true
    vnet_key                      = "cs_stock_data_dev"
    subnet_key                    = "private_endpoints"
    lz_key                        = "cloudservices"

    postgresql_configurations = {
      postgresql_configuration1 = {
        name                = "backslash_quote"
        resource_group_name = "postgresql_com_stock_data_dev"
        server_name         = "pg_com_sd_dev"
        value               = "on"
      }
    }

    postgresql_databases = {
      postgresql_database = {
        name                = "stockdata"
        resource_group_name = "postgresql_com_stock_data_dev"
        server_name         = "pg_com_sd_dev"
        charset             = "UTF8"
        collation           = "English_United States.1252"
      }
    }

    private_endpoints = {
      private-link = {
        name               = "pg-com-sd-dev-pe"
        vnet_key           = "cs_stock_data_dev"
        subnet_key         = "private_endpoints"
        lz_key             = "cloudservices"
        resource_group_key = "postgresql_com_stock_data_dev"

        private_service_connection = {
          name                 = "pg-com-sd-dev-psc"
          is_manual_connection = false
          subresource_names    = ["postgresqlServer"]
        }
      }
    }
  }
}
