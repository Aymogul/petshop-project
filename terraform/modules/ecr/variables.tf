variable "project_name" {
  description = "Project name used to namespace the ECR repository."
  type        = string
}

variable "environment" {
  description = "Environment such as prod or staging."
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether repository tags can be overwritten."
  type        = string
  default     = "MUTABLE"
}
