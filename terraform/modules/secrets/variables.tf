variable "project_name" {
  description = "Project name prefix for secret naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment such as prod or staging."
  type        = string
}

variable "db_host" {
  description = "Database host used by the application."
  type        = string
}

variable "db_port" {
  description = "Database port used by the application."
  type        = number
}

variable "db_name" {
  description = "Database name used by the application."
  type        = string
}

variable "db_username" {
  description = "Database username used by the application."
  type        = string
}

variable "db_password" {
  description = "Database password used by the application."
  type        = string
  sensitive   = true
}
