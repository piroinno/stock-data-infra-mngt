global_settings = {
  default_region = "primary"
  regions = {
    primary = "westeurope"
  }
}

remote_networks = {
  cloudservices = {
    name          = "cs_stock_data_dev"
    configuration = "network"
  }
}

remote_sharedcontainerregistries = {
  cloudservices = {
    name          = "shared_acr_stock_data_mgnt"
    configuration = "sharedcontainerregistry"
  }
}

resource_groups = {
  aks_cs_dev_rg = {
    name   = "aks-cs-dev-rg"
    region = "primary"
  }
}

azuread_groups = {
  aks_admins = {
    name        = "aks-admins"
    description = "Provide access to the AKS cluster and the jumpbox Keyvault secret."
    members = {
      user_principal_names = [
      ]
      group_names = []
      object_ids  = []
      group_keys  = []

      service_principal_keys = [
      ]
    }
    prevent_duplicate_name = false
  }
}


#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {
  custom_role_mapping = {}

  built_in_role_mapping = {
    aks_clusters = {
      aks_mgnt = {
        "Azure Kubernetes Service Cluster Admin Role" = {
          azuread_groups = {
            keys = ["aks_admins"]
          }
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
    azure_container_registries = {
      shared_acr_stock_data_mgnt = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["aks_clusters"]
          }
        }
      }
    }
  }
}

subscription_id = "6016324a-afd1-4da5-b026-378af25f609b"
tenant_id       = "859e9d09-9fe3-4451-9029-35d7fb1f2e59"
environment     = "dev"
