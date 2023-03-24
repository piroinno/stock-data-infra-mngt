keyvaults = {
  ra-git = {
    name                      = "ra-git"
    resource_group_key        = "runneragent_github"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
    private_endpoints = {
      ra_git_private_endpoint = {
        name               = "ra-git-pe"
        resource_group_key = "runneragent_github"

        vnet_key   = "cs_stock_data_dev"
        subnet_key = "private_endpoints"
        lz_key     = "cloudservices"

        private_service_connection = {
          name                 = "ra-git-psc"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
      }
    }
  }
}

# resource "azurerm_role_assignment" "ra_git_pe_role_assignment" {
#   for_each             = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["ra-git"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.identities[0].kubelet_identity[0].object_id
# }

# resource azurerm_role_assignment "ra_git_pe_role_assignment" {
#   for_each = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["ra-git"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.node_pools["nodepool_user"].identity[0].object_id
# }

# resource azurerm_role_assignment "ra_git_pe_role_assignment" {
#   for_each = module.caf.aks_clusters
#   scope                = module.caf.keyvaults["ra-git"].id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.node_pools["default"].identity[0].object_id
# }
