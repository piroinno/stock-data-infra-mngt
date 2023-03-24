variable "remote_states" {
  default = {}
}
variable "remote_networks" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}
variable "azurerm_firewalls" {
  default = {}
}
variable "virtual_machines" {
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "vnet_peerings" {
  default = {}
}
variable "network_security_group_definition" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "global_settings" {
  default = {}
}
variable "subscription_id" {
  type    = string
  default = null
}
variable "tenant_id" {
  type    = string
  default = null
}

variable "environment" {
  type    = string
  default = null
}
