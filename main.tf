#
# Terraform template creates storage account and container serving as backend for
# all QAs configurations
#
provider "azurerm" {
  version = "1.8.0"
}

variable "location" {}


variable resource_group_name {
  type = "string"
  default = "QA-DIOR-TF-STATE"
}

resource "azurerm_resource_group" "tf-state-rg" {
  location                  = "${var.location}"
  name                      = "${var.resource_group_name}"
}

resource "azurerm_storage_account" "tf-state-storage-account" {
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  location                  = "${var.location}"
  name                      = "qatfstate"
  resource_group_name       = "${azurerm_resource_group.tf-state-rg.name}"
}

resource "azurerm_storage_container" "tf-state-container" {
  name                      = "qatfstatecnt"
  resource_group_name       = "${azurerm_resource_group.tf-state-rg.name}"
  storage_account_name      = "${azurerm_storage_account.tf-state-storage-account.name}"
}