public_ip_addresses = {
  mgnt_pip = {
    name                    = "mgnt-pip"
    resource_group_key      = "vnet_hub_mgnt"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

azurerm_firewalls = {
  mgnt_firewall = {
    name               = "mgnt-firewall"
    resource_group_key = "vnet_hub_mgnt"
    vnet_key           = "hub_mgnt"
    sku_tier           = "Standard"
    zones              = ["1", "2", "3"]
    public_ips = {
      mgnt_pip_01 = {
        name          = "mgnt-pip"
        public_ip_key = "mgnt_pip"
        vnet_key      = "hub_mgnt"
        subnet_key    = "AzureFirewallSubnet"
      }
    }
  }
}

# azurerm_firewall_policies = {
#   egress_firewall_policy = {
#     name               = "gress-firewall-policy"
#     resource_group_key = "vnet_hub_mgnt"
#     region             = "primary"
#     sku                = "standard"
#     dns = {
#       proxy_enabled = true
#     }
#   }
#}