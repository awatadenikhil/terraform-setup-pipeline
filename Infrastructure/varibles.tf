variable "workspace_to_environment_map" {
  type = map(string)
  default = {
    development     = "dev"
    testing      = "qa"
    staging = "sit"
    production    = "prod"
  }
}
variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "tp1"
}
variable "resourcetype" {
  type        = string
  description = "Naming suffix for resources"
  default     = "rt"
}

variable "az_location" {
  type    = string
  default = "eastus"
}
locals {
  environment =  "${lookup(var.workspace_to_environment_map, terraform.workspace, "dev")}"
  resourcename = "${var.prefix}-${local.environment}-${var.resourcetype}"
  az_resource_group_name = "${local.resourcename}-terraformworkspace"
}
