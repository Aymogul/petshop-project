variable "project_name" {
  description = "Project name prefix for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment such as prod or staging."
  type        = string
}

# GitHub OIDC is the standard pattern for repo-to-AWS authentication in GitHub Actions.
variable "enable_github_oidc" {
  description = "Whether to create a GitHub OIDC provider and deployment role for GitHub Actions."
  type        = bool
  default     = false
}

variable "github_repository" {
  description = "GitHub repository in the format org/repo that is allowed to assume the deployment role."
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Branch name allowed to use the OIDC role. Use a protected branch like main or release."
  type        = string
  default     = "main"
}

variable "github_environment" {
  description = "Optional GitHub environment name to scope the OIDC trust policy."
  type        = string
  default     = ""
}

# Keep policy attachment flexible so the app can add least-privilege permissions without changing the core module contract.
variable "additional_policy_arns" {
  description = "Additional IAM policy ARNs to attach to the ECS task role."
  type        = list(string)
  default     = []
}

variable "oidc_role_policy_arns" {
  description = "Managed policies attached to the GitHub Actions deployment role."
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  ]
}
