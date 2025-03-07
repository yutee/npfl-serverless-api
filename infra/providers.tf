#

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "terraformstatesRG"
    storage_account_name  = "terraformstate737"
    container_name        = "tfstateblob"
    key                   = "apiinfra/terraform.tfstate"
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}