output "resource_group_name" {
  value = azurerm_resource_group.tfstate.name
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "client_id" {
  value = azuread_application.tfstate_app.application_id
}

output "client_secret" {
  value     = azuread_application_password.tfstate_client_secret.value
  sensitive = true
}
