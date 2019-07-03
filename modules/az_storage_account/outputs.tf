output "account_access_key" {
  description = "The storage account primary access key"
  value = "${azurerm_storage_account.storage_account.primary_access_key}"
}

output "container_name" {
  value = "${azurerm_storage_container.storage_container.name}"
}
