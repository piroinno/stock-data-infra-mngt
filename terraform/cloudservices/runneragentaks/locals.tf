locals {
  remote_vnets = {
    for lz, lz_config in data.terraform_remote_state.remote_networks : lz => {
      for vnet, vnet_config in lz_config.outputs.vnets : vnet => vnet_config if try(lookup(var.remote_networks, lz, null).name == vnet, null) != null
    }
  }

  remote_container_registries = {
    for lz, lz_config in data.terraform_remote_state.remote_sharedcontainerregistries : lz => {
      for registry, registry_config in lz_config.outputs.azure_container_registries : registry => registry_config if try(lookup(var.remote_sharedcontainerregistries, lz, null).name == registry, null) != null
    }
  }
}


locals {
  resource_group_id_map = {
    for k, v in module.caf.resource_groups : v.name => v.id
  }
}
