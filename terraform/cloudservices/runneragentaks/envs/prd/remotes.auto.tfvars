remote_states = {
  cloudservices = {
    network = {
        subscription_id      = "6016324a-afd1-4da5-b026-378af25f609b"
        resource_group_name  = "cs-dev-iac-back-rg"
        storage_account_name = "csdeviacbacksa"
        container_name       = "iac"
        key                  = "Networks/prd.tfstate"
    }

    sharedcontainerregistry = {
        subscription_id      = "6016324a-afd1-4da5-b026-378af25f609b"
        resource_group_name  = "cs-dev-iac-back-rg"
        storage_account_name = "csdeviacbacksa"
        container_name       = "iac"
        key                  = "sharedcontainerregistry/dev.tfstate"
    }
  }
}
