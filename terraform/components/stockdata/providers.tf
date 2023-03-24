provider "azuread" {}

provider "azurerm" {
  features {}
  subscription_id            = var.subscription_id
  storage_use_azuread        = false
  skip_provider_registration = false
}

provider "azurecaf" {}

provider "azapi" {}