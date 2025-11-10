terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend will be configured after storage account is created
  # backend "azurerm" {
  #   storage_account_name = "mystorageaccountdev"  # Will be set manually
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  #   resource_group_name  = "app1-cc-cop-rg-dev"
  # }
}

provider "azurerm" {
  features{}
  storage_use_azuread = true
  subscription_id     = var.subscription_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "first_rg1" {
  location = var.location
  name = var.first_rg_name
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name = var.app_rg_name
}

resource "azurerm_storage_account" "storage" {
  name                     = var.str_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Backup",
      "Restore"
    ]
  }

  tags = {
    environment = var.environment
  }
}
