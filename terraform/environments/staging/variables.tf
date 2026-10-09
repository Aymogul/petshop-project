variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
  default     = "petshop"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "staging"
}

variable "enable_https" {
  description = "Whether to provision a public HTTPS endpoint and certificate for the application."
  type        = bool
  default     = false
}

variable "dns_zone_name" {
  description = "Existing Route53 hosted zone name, for example example.com. Leave empty to skip DNS/TLS automation."
  type        = string
  default     = ""
}

variable "app_domain_name" {
  description = "Public hostname for the application, for example app.example.com. Leave empty to skip DNS/TLS automation."
  type        = string
  default     = ""
}
