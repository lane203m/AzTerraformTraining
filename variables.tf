variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "Canadacentral"
}

variable "first_rg_name" {
  description = "Name for the first resource group"
  type        = string
  default     = "my-first-rg"
}

variable "app_rg_name" {
  description = "Name for the application resource group"
  type        = string
  default     = "app1-cc-cop-rg"
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}

variable "str_name" {
  description = "Storage account name prefix"
  type        = string
  default     = "mystorageaccount"
}