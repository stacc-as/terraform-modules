variable "resource_group" {
  description = "The resource group postgres will be created in"
}

variable "name" {
  description = "The prefix of the resources"
  default     = "stacc"
}

variable "environment" {
  description = "The environment of the resources"
  default     = "test-1"
}

variable "vnet" {
  description = "The virtual network postgres will be created in"
}

variable "kubernetes_cluster" {}

variable "database_version" {
  description = "The version of postgres"
  default     = "9.6"
}

variable "database_type" {
  description = "The type of database server"
  default     = "GP_Gen5_2"
}

variable "database_tier" {
  description = "The SKU of database server"
  default     = "GeneralPurpose"
}

variable "database_family" {
  default = "Gen5"
}

variable "database_storage" {
  description = "The size of the database server in MB"
  default     = 5120
}

variable "database_capacity" {
  description = "Number of CPU's for the database server"
  default     = 2
}

variable "backup_retention_days" {
  description = "Number of backup retention days"
  default     = 7
}
