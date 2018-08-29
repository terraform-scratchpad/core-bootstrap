#
# bootstrap Terraform template creates the following essential shared resources
# main resource group
# storage account and container serving as backend (stores tfstate files for the upcoming infrastructure states)
#
provider "azurerm" {
  version = "~> 1.12.0"
}

resource "azurerm_resource_group" "tf-state-rg" {
  location                  = "${var.location}"
  name                      = "${var.resource_group_name}"
  tags                      = "${var.tags}"
}


resource "azurerm_storage_account" "tf-state-storage-account" {
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  location                  = "${var.location}"
  name                      = "${var.tfstate_storage_account_name}"
  resource_group_name       = "${azurerm_resource_group.tf-state-rg.name}"
  tags                      = "${var.tags}"
}


resource "azurerm_storage_container" "tf-state-container" {
  name                      = "${var.tfstate_storage_container_name}"
  resource_group_name       = "${azurerm_resource_group.tf-state-rg.name}"
  storage_account_name      = "${azurerm_storage_account.tf-state-storage-account.name}"
}

#
# puts generated storage account access_key into a file on the host running this template
#
resource "null_resource" "storage-container-access-key" {
  provisioner "local-exec" {
    command = <<EOT
echo "access_key=${azurerm_storage_account.tf-state-storage-account.primary_access_key}" > ~/.secrets/backend-access_key.cf
echo "terraform backend container ${azurerm_storage_container.tf-state-container.name} with new access_key stored at ~/.secrets/backend-access_key.cf"
    EOT
  }
}