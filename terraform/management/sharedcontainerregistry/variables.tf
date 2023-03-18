variable "azure_container_registries" {
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

variable "environment" {
  type    = string
  default = null
}