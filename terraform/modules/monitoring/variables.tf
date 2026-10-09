variable "project_name" {
  description = "Project name prefix for log group naming."
  type        = string
}

variable "environment" {
  description = "Environment such as prod or staging."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain CloudWatch logs."
  type        = number
  default     = 30
}
