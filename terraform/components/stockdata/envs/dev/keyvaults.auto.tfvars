keyvaults = {
  sd-api = {
    name                      = "sd-api"
    resource_group_key        = "stock_data_api"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
    private_endpoints = {
      kv_git_private_endpoint = {
        name               = "sd-api-pe"
        resource_group_key = "stock_data_api"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-api-psc"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
      }
    }
  }
  sd-ingestor = {
    name                      = "sd-ingestor"
    resource_group_key        = "stock_data_ingestor"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
    private_endpoints = {
      kv_git_private_endpoint = {
        name               = "sd-ingestor-pe"
        resource_group_key = "stock_data_ingestor"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-ingestor-psc"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
      }
    }
  }
  sd-postgres = {
    name                      = "sd-postgres-kv"
    resource_group_key        = "postgresql_com_stock_data_dev"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
    private_endpoints = {
      kv_git_private_endpoint = {
        name               = "sd-postgres-kv-pe"
        resource_group_key = "postgresql_com_stock_data_dev"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "com-sd-postgres-kv-psc"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
      }
    }
  }
}

# resource "azurerm_role_assignment" "ra_git_pe_role_assignment" {
#   for_each             = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["sd-api"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.identities[0].kubelet_identity[0].object_id
# }

# resource azurerm_role_assignment "ra_git_pe_role_assignment" {
#   for_each = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["sd-api"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.node_pools["nodepool_user"].identity[0].object_id
# }

# resource azurerm_role_assignment "ra_git_pe_role_assignment" {
#   for_each = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["sd-api"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.node_pools["default"].identity[0].object_id
# }
