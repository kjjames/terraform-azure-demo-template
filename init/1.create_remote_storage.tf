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

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}

#
# Create custom role for service principcal to access storage account and container
#
resource "azurerm_role_definition" "tfstate_pipeline_role" {
  name        = "tfstate-pipeline-role"
  scope       = azurerm_resource_group.tfstate.id
  description = "This is a custom role to allow a service principal to read/write to our Terraform state storage account and container."

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write"
    ]
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
    not_actions = [
      "Microsoft.Storage/storageAccounts/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete"
    ]
  }

  assignable_scopes = [
    azurerm_resource_group.tfstate.id
  ]
}

resource "azurerm_role_assignment" "tfstate_role_assignment" {
  scope              = azurerm_resource_group.tfstate.id
  role_definition_id = azurerm_role_definition.tfstate_pipeline_role.role_definition_resource_id
  principal_id       = azuread_service_principal.tfstate_sp.id
}
