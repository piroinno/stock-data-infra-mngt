data "terraform_remote_state" "remote_networks" {
  for_each = var.remote_networks
  backend  = "azurerm"

  config = {
    container_name       = var.remote_states[each.key][each.value.configuration].container_name
    resource_group_name  = var.remote_states[each.key][each.value.configuration].resource_group_name
    storage_account_name = var.remote_states[each.key][each.value.configuration].storage_account_name
    subscription_id      = var.remote_states[each.key][each.value.configuration].subscription_id
    key                  = var.remote_states[each.key][each.value.configuration].key
  }
}

data "terraform_remote_state" "remote_sharedcontainerregistries" {
  for_each = var.remote_sharedcontainerregistries
  backend  = "azurerm"

  config = {
    container_name       = var.remote_states[each.key][each.value.configuration].container_name
    resource_group_name  = var.remote_states[each.key][each.value.configuration].resource_group_name
    storage_account_name = var.remote_states[each.key][each.value.configuration].storage_account_name
    subscription_id      = var.remote_states[each.key][each.value.configuration].subscription_id
    key                  = var.remote_states[each.key][each.value.configuration].key
  }
}