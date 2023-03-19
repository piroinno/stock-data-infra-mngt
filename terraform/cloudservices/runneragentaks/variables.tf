variable "azuread_groups" {
  default = {}
}
variable "role_mapping" {
  default = {}
}
variable "aks_clusters" {
  default = {}
}
variable "remote_sharedcontainerregistries" {
  default = {}
}
variable "remote_networks" {
  default = {}
}
variable "remote_states" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "resource_groups" {
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