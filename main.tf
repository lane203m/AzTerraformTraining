terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "${var.str_name}${random_integer.suffix.result}"  # This will need to match your actual storage account name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features{}
  storage_use_azuread = true
}

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "first_rg1" {
  location = var.location
  name = var.first_rg_name
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name = var.app_rg_name
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.str_name}${random_integer.suffix.result}"
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
