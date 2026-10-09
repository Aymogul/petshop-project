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

variable "enable_github_oidc" {
  description = "Whether to create the GitHub OIDC provider and deployment role for GitHub Actions."
  type        = bool
  default     = false
}

variable "github_repository" {
  description = "GitHub repository in the format org/repo that is allowed to assume the deployment role."
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Branch allowed to use the OIDC role."
  type        = string
  default     = "main"
}

variable "github_environment" {
  description = "Optional GitHub environment name to scope the OIDC role."
  type        = string
  default     = ""
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
