variable "name" {
  description = "The prefix of the resources"
  default     = "stacc"
}

variable "environment" {
  description = "The environment of the resources"
  default     = "test-1"
}

variable "location" {
  description = "The location of the resources"
  default     = "West Europe"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  default     = "1.14.6"
}

variable "os_disk_size_gb" {
  description = "OS disk size"
  default     = "32"
}

variable "node_type" {
  description = "The type of nodes"
  default     = "Standard_DS3_v2"
}

variable "resource_group" {
  description = "The resource group for the Azure Kubernetes Service to be created in"
}

variable "vnet" {
  description = "The virtual network for the Azure Kubernetes Service to be created in"
}

variable "subnet_address_prefix" {
  # (number of nodes + 1) + ((number of nodes + 1) * maximum pods per node that you configure)
  description = "The address prefix of the subnet"
  default     = "10.1.0.0/17"
}

variable "agent_pool_profile_type" {
  default = "VirtualMachineScaleSets"
}

variable "agent_pool_profile_count" {
  default = 3
}

variable "agent_pool_profile_enable_auto_scaling" {
  default = true
}

variable "agent_pool_profile_min_count" {
  default = 3
}

variable "agent_pool_profile_max_count" {
  default = 7
}

variable "agent_pool_profile_max_pods" {
  default = 100
}

variable "service_endpoints" {
  description = "List of service endpoints"
  type        = list(string)
  default     = ["Microsoft.Sql"]
}

variable "load_balancer_sku" {
  default = "Basic"
}

variable "service_principal" {}

variable "aks_rbac" {}

variable "group_cluster_admins_id" {}
