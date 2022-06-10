terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
}


data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = "eastus"
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "tfstate${random_string.resource_code.result}"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}

#
# Create service principal and secret to be used by GitHub actions pipeline
# See: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#configuring-the-service-principal-in-terraform
#
resource "azuread_application" "tfstate_app" {
  display_name = "tfstate-sp"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "tfstate_sp" {
  application_id               = azuread_application.tfstate_app.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "tfstate_client_secret" {
  application_object_id = azuread_application.tfstate_app.object_id
}

resource "azurerm_role_assignment" "tfstate_role_assignment" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.tfstate_sp.id
}
