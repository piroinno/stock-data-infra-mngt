module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  global_settings = var.global_settings
  resource_groups = var.resource_groups

  compute = {
    azure_container_registries = var.azure_container_registries
  }

  providers = {
    azurerm.vhub = azurerm
  }
}
