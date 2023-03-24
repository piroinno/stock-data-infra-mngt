storage_accounts = {
  stock_data_storage = {
    name                      = "comsddev"
    resource_group_key        = "stock_data_ingestor"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    allow_blob_public_access  = false
    enable_https_traffic_only = true
    is_hns_enabled            = true
    private_endpoints = {
      dfs_private_endpoint = {
        name               = "com-sd-api-dfs-pe"
        resource_group_key = "stock_data_ingestor"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-api-dfs-psc"
          is_manual_connection = false
          subresource_names    = ["dfs"]
        }
      }
      blob_private_endpoint = {
        name               = "com-sd-api-blob-pe"
        resource_group_key = "stock_data_ingestor"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-api-blob-psc"
          is_manual_connection = false
          subresource_names    = ["blob"]
        }
      }
      queue_private_endpoint = {
        name               = "com-sd-api-queue-pe"
        resource_group_key = "stock_data_ingestor"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-api-queue-psc"
          is_manual_connection = false
          subresource_names    = ["queue"]
        }
      }
    }
    data_lake_filesystems = {
      stock_data_dfs = {
        name = "eod"
      }
    }
    queues = {
      job_queue = {
        name = "ingestor-job-queue"
      }
    }
  }
}
