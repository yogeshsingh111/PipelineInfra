terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.56.0"
    }
  }
  # backend "azurerm" {

  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      # recover_soft_deleted_key_vaults = true
      recover_soft_deleted_key_vaults = false
    }
  }
  subscription_id = var.subscription_id
}
