variable "location" {}
variable "tags" {
  type = "map"
  default = {
    scope         = "qa"
    source        = "terraform"
    env           = "staging"
    costEntity    = "dior"
  }
}
variable resource_group_name {
  type = "string"
}
variable tfstate_storage_account_name {
  type = "string"
  default = "qatfstate"
}
variable tfstate_storage_container_name {
  type = "string"
  default = "qatfstatecnt"
}