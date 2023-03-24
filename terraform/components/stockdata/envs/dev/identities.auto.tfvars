stock_data = {
  identities = {
    stock_data_api = {
      resource_group_name_key = "stock_data_api"
      aks_cluster_key         = "aks_com_stock_data_dev"
      namespace               = "sd-api"
      serviceaccount          = "sd-api-service"
    }
    stock_data_ingestor = {
      resource_group_name_key = "stock_data_ingestor"
      aks_cluster_key         = "aks_com_stock_data_dev"
      namespace               = "sd-ingestor"
      serviceaccount          = "sd-ingestor-service"
    }
  }
}
