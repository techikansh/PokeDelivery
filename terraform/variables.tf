variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "project" {
  description = "Project name prefix for all resources"
  type        = string
  default     = "pokedelivery"
}
