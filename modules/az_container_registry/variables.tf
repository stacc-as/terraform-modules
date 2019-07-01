variable "name" {
  description = "The prefix of the resources"
  default     = "stacc"
}

variable "location" {
  description = "The location of the resources"
  default     = "West Europe"
}

variable "environment" {
  default = "global"
}

variable "cr_name" {
  description = "The name of the container registry"
  default     = "stacc"
}
