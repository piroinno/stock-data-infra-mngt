remote_states = {
  management = {
    network = {
        subscription_id      = "5ae65a7a-19c4-4bf6-b409-3f5e2e490cdb"
        resource_group_name  = "mngt-iac-back-rg"
        storage_account_name = "mngtiacbacksa"
        container_name       = "iac"
        key                  = "Networks/mgnt.tfstate"
    }
  }
}
