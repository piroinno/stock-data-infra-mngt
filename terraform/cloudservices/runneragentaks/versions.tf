terraform {
  required_version = ">=1.3.1"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
    }
    azapi = {
      source = "azure/azapi"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}
