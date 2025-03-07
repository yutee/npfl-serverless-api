# variables.tf - Terraform variables for Azure resources

variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "npfl-api-rg"
}

variable "cosmosdb_name" {
  default = "npfl-cosmosdb"
}

variable "storage_account_name" {
  default = "npflstorage"
}

variable "function_app_name" {
  default = "npflfunctions"
}