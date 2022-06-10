terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatei4hu3"
    container_name       = "tfstate"
    key                  = "azure-powerhour-demo/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "azure-powerhour-rg" {
  source   = "./modules/resource_group"
  name     = "azure-powerhour-demo"
  location = "eastus"
}

