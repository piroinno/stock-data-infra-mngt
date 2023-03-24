provider "azuread" {}

provider "azurerm" {
  features {}
  subscription_id            = var.subscription_id
  storage_use_azuread        = true
  skip_provider_registration = false
}

provider "azurecaf" {}

provider "azapi" {}