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
variable tf_state_resource_group_name {
  type = "string"
  default = "QA-DIOR-TF-STATE"
}