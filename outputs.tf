output "storage-account-name" {
  value = "${azurerm_storage_account.core-state-storage-account.name}"
}

output "storage-container-name" {
  value = "${azurerm_storage_container.core-state-container.name}"
}