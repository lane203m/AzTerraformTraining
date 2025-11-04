terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features{}
}

resource "azurerm_resource_group" "first_rg1" {
  location = "Canadacentral"
  name = "my-first-rg"
}

resource "azurerm_resource_group" "rg" {
  location = "Canadacentral"
  name = "app1-cc-cop-rg"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mystorageaccount${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    environment = "dev"
  }
}

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}
