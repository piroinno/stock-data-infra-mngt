locals {
  remote_vnets = {
    for lz, lz_config in data.terraform_remote_state.remote_networks : lz => {
      for vnet, vnet_config in lz_config.outputs.vnets : vnet => vnet_config if try(lookup(var.remote_networks, lz, null).name == vnet, null) != null
    }
  }
}

