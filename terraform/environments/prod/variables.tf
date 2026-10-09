variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
  default     = "petshop"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "prod"
}
