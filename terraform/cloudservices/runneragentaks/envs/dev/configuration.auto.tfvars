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
  aks_mngt_rg = {
    name   = "aks-mngt-rg"
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
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
  }
}