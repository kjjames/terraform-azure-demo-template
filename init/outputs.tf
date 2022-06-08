output "RESOURCE_GROUP_NAME" {
  value = azurerm_resource_group.tfstate.name
}

output "STORAGE_ACCOUNT_NAME" {
  value = azurerm_storage_account.tfstate.name
}

output "STORAGE_CONTAINER_NAME" {
  value = azurerm_storage_container.tfstate.name
}
