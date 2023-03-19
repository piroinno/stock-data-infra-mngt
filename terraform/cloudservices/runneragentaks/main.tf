module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults

  compute = {
    aks_clusters = var.aks_clusters
  }

  azuread = {
    azuread_groups = var.azuread_groups
    azuread_roles  = var.role_mapping
  }

  remote_objects = {
    vnets = local.remote_vnets
    vnets = local.remote_vnets
  }

  providers = {
    azurerm.vhub = azurerm
  }
}
