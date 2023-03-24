module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.6.6"

  global_settings  = var.global_settings
  resource_groups  = var.resource_groups
  keyvaults        = var.keyvaults
  storage_accounts = var.storage_accounts
  database = {
    postgresql_servers = var.postgresql_servers
  }
  compute = {
    aks_clusters = var.aks_clusters
  }

  azuread = {
    azuread_groups = var.azuread_groups
    azuread_roles  = var.role_mapping
  }

  remote_objects = {
    vnets                      = local.remote_vnets
    azure_container_registries = local.remote_container_registries
  }

  providers = {
    azurerm.vhub = azurerm
  }
}



# Enable OIDC on AKS
resource "azapi_update_resource" "aks_for_oidc" {
  for_each    = module.caf.aks_clusters
  type        = "Microsoft.ContainerService/managedClusters@2022-11-01"
  resource_id = each.value.id

  body = jsonencode({
    properties = {
      oidcIssuerProfile = {
        enabled = true
      }
      securityProfile = {
        workloadIdentity = {
          enabled = true
        }
      }
    }
  })
  response_export_values = ["*"]
}

resource "azurerm_user_assigned_identity" "stock_data_identities" {
  for_each            = var.stock_data.identities
  location            = var.global_settings.regions.primary
  name                = each.value.namespace
  resource_group_name = module.caf.resource_groups[each.value.resource_group_name_key].name
  depends_on = [
    module.caf.resource_groups
  ]
}

resource "azapi_resource" "federated_identity_credential" {
  for_each  = var.stock_data.identities
  type      = "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2022-01-31-preview"
  name      = each.value.namespace
  parent_id = azurerm_user_assigned_identity.stock_data_identities[each.key].id
  body = jsonencode({
    properties = {
      audiences = [
        "api://AzureADTokenExchange"
      ]
      issuer  = jsondecode(azapi_update_resource.aks_for_oidc[each.value.aks_cluster_key].output).properties.oidcIssuerProfile.issuerURL
      subject = "system:serviceaccount:${var.stock_data.identities[each.key].namespace}:${var.stock_data.identities[each.key].serviceaccount}"
    }
  })
  depends_on = [
    azurerm_user_assigned_identity.stock_data_identities,
    azapi_update_resource.aks_for_oidc
  ]
}

resource "azurerm_user_assigned_identity" "stock_data_identities_keda" {
  for_each            = var.stock_data.identities
  location            = var.global_settings.regions.primary
  name                = "${each.value.namespace}-keda"
  resource_group_name = module.caf.resource_groups[each.value.resource_group_name_key].name
  depends_on = [
    module.caf.resource_groups
  ]
}

resource "azapi_resource" "federated_identity_credential_keda" {
  for_each  = var.stock_data.identities
  type      = "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2022-01-31-preview"
  name      = "${each.value.namespace}-keda"
  parent_id = azurerm_user_assigned_identity.stock_data_identities_keda[each.key].id
  body = jsonencode({
    properties = {
      audiences = [
        "api://AzureADTokenExchange"
      ]
      issuer  = jsondecode(azapi_update_resource.aks_for_oidc[each.value.aks_cluster_key].output).properties.oidcIssuerProfile.issuerURL
      subject = "system:serviceaccount:${var.stock_data.identities[each.key].namespace}:keda-operator"
    }
  })
  depends_on = [
    azurerm_user_assigned_identity.stock_data_identities,
    azapi_update_resource.aks_for_oidc
  ]
}
