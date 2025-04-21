# Configure Terraform
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.25.0"
    }
  }
  backend "azurerm" {
  }
}
# Azure Provider -- Start
# Configure the Microsoft Azure Provider 
provider "azurerm" {
  # subscription_id = var.azure_subscription
  # client_id       = var.azure_client_id
  # client_secret   = var.azure_client_secret
  # tenant_id       = var.azure_tenant
  features {}
}

provider "azuread"{  
 # tenant_id       = var.azure_tenant
}

# Azure Provider -- End
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

resource "azurerm_resource_group" "setup" {
  name     = local.az_resource_group_name
  location = var.az_location
}
