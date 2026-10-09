variable "project_name" {
  description = "Project name prefix for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment such as prod or staging."
  type        = string
}

# Keep policy attachment flexible so the app can add least-privilege permissions without changing the core module contract.
variable "additional_policy_arns" {
  description = "Additional IAM policy ARNs to attach to the ECS task role."
  type        = list(string)
  default     = []
}
