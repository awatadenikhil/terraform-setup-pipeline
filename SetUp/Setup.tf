# Configure Terraform
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.25.0"
    }
  }
}
# Azure Provider -- Start
# Configure the Microsoft Azure Provider 
provider "azurerm" {
  subscription_id = var.azure_subscription
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant
  features {}
}

provider "azuread"{
  tenant_id       = var.azure_tenant
}

# Azure Provider -- End
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Storage Account --Start

resource "azurerm_resource_group" "setup" {
  name     = local.az_resource_group_name
  location = var.az_location
}

resource "azurerm_storage_account" "sa" {
  name                     = local.az_storage_account_name
  resource_group_name      = azurerm_resource_group.setup.name
  location                 = var.az_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "common"
  }
}

resource "azurerm_storage_container" "ct" {
  name                 = var.az_container_name
  storage_account_name = azurerm_storage_account.sa.name

}

data "azurerm_storage_account_sas" "state" {  
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "17520h")

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}

# Storage Account --End

data "azuread_service_principal" "service_connection" {
  display_name = var.app_name
}
# Create a Key Vault
resource "azurerm_key_vault" "setup" {
  name = local.az_key_vault_name
  location = azurerm_resource_group.setup.location
  resource_group_name = azurerm_resource_group.setup.name
  tenant_id = var.azure_tenant

  sku_name = "standard"

   # ⚡ Important settings for clean deletion
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
}

# Set access policies
# Grant yourself full access (probably could be restricted to just secret_permissions)
resource "azurerm_key_vault_access_policy" "you" {
  key_vault_id = azurerm_key_vault.setup.id

  tenant_id = var.azure_tenant
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover","Restore","Sign","UnwrapKey","Update","Verify","WrapKey",
  ]

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Import", "Delete", "Update",
  ]
}

# Populate with secrets to be used by the pipeline
resource "azurerm_key_vault_secret" "pipeline" {
  depends_on = [
    azurerm_key_vault_access_policy.you
  ]
  for_each = local.pipeline_variables
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.setup.id
}
