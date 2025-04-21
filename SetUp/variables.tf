variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "tp1"
}

variable "az_location" {
  type    = string
  default = "eastus"
}

variable "az_container_name" {
  type        = string
  description = "Name of container on storage account for Terraform state"
  default     = "infrastructure-component"
}

variable "az_state_key" {
  type        = string
  description = "Name of key in storage account for Terraform state"
  default     = "infrastructure_terraform.tfstate"
}

variable "suffix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "v5"
}

variable "app_name" {
  type        = string
  description = "Name of Application"
  default     = "Terraform_Practice_1_App"
}

resource "random_string" "storage" {
  length  = 6
  upper   = false
  special = false
}

locals {
  az_resource_group_name  = "${var.prefix}-rg-${var.suffix}"
  az_storage_account_name = "${lower(var.prefix)}sa${random_string.storage.result}${var.suffix}"
  az_key_vault_name = "${var.prefix}-kv-${var.suffix}"

  pipeline_variables = {
    storageaccount = azurerm_storage_account.sa.name
    container-name = var.az_container_name
    key = var.az_state_key
    sas-token = data.azurerm_storage_account_sas.state.sas
    az-client-id = var.azure_client_id
    az-client-secret = var.azure_client_secret
    az-subscription = var.azure_subscription
    az-tenant = var.azure_tenant
    resourcegroup = azurerm_resource_group.setup.name
  }

  //azad_service_connection_sp_name = "${var.prefix}-service-connection-${var.suffix}"
}

variable "azure_client_id" {
  type        = string
  default = "a0fd380b-7aa1-42d6-a5d7-58374f2dddd9"
}

variable "azure_client_secret" {
  type        = string
  default = "Y.Z8Q~-b7fl7xRFRv2Pi-vsD4pdrvaZ1-dddkcKh"
}

variable "azure_subscription" {
  type        = string
  default = "580b65d7-d259-4b66-9c3c-52eecddddb12"
}

variable "azure_tenant" {
  type        = string
  default = "5cb5468e-73ed-461d-a20e-cb4e3dddd0f5"
}