# Production deployment defaults.
# This uses the default ALB AWS hostname and GitHub OIDC on the main branch.
project_name         = "petshop"
environment          = "prod"
enable_github_oidc   = true
github_repository    = "Aymogul/petshop-project"
github_branch        = "main"
github_environment   = "prod"
create_oidc_provider = false
enable_https         = false
dns_zone_name        = ""
app_domain_name      = ""
