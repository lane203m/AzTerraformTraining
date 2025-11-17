variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

# Subscription ID is now handled via Azure CLI context or ARM_SUBSCRIPTION_ID environment variable
# No longer needed as a Terraform variable

variable "first_rg_name" {
  description = "Name for the first resource group"
  type        = string
}

variable "app_rg_name" {
  description = "Name for the application resource group"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
}

variable "storage_replication_type" {
  description = "Storage account replication type"
  type        = string
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
}

variable "str_name" {
  description = "Storage account name prefix"
  type        = string
}

variable "key_vault_name" {
  description = "Azure Key Vault name"
  type        = string
}