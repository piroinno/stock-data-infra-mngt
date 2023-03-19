module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults

  compute = {
    virtual_machines = var.virtual_machines
  }

  remote_objects = {
    vnets                      = local.remote_vnets
    azure_container_registries = local.remote_azure_container_registries
  }

  networking = {
    network_security_group_definition = var.network_security_group_definition
    vnets                             = var.vnets
    vnet_peerings                     = var.vnet_peerings
    public_ip_addresses               = var.public_ip_addresses
    azurerm_firewalls                 = var.azurerm_firewalls
  }
  providers = {
    azurerm.vhub = azurerm
  }
}
