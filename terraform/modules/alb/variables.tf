variable "project_name" {
  description = "Project name prefix for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name such as prod or staging."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created."
  type        = string
}

variable "subnet_ids" {
  description = "Public subnet IDs for the load balancer."
  type        = list(string)
}

variable "app_port" {
  description = "Port used by the application behind the ALB."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Health check path for the target group."
  type        = string
  default     = "/"
}

variable "enable_https" {
  description = "Whether to enable the HTTPS listener."
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "Certificate ARN for HTTPS listener when enabled."
  type        = string
  default     = null
}
