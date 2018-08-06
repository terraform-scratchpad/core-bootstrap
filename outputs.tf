output "tfstate-access-key" {
  value = "${azurerm_storage_account.tf-state-storage-account.primary_access_key}"
}
output "tfstate-container-name" {
  value = "${azurerm_storage_container.tf-state-container.name}"
}