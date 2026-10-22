provider "aws" {
  region = "us-east-1"
}

# Production wiring is intentionally ordered: network first, then observability, IAM, ingress, then app runtime.
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = "10.30.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b",
  ]

  public_subnet_cidrs = [
    "10.30.1.0/24",
    "10.30.2.0/24",
  ]

  private_subnet_cidrs = [
    "10.30.11.0/24",
    "10.30.12.0/24",
  ]

  database_subnet_cidrs = [
    "10.30.21.0/24",
    "10.30.22.0/24",
  ]
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "../../modules/iam"

  project_name         = var.project_name
  environment          = var.environment
  enable_github_oidc   = var.enable_github_oidc
  github_repository    = var.github_repository
  github_branch        = var.github_branch
  github_environment   = var.github_environment
  create_oidc_provider = var.create_oidc_provider
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

module "database" {
  source = "../../modules/database"

  project_name              = var.project_name
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  db_subnet_group_name      = module.vpc.database_subnet_group_name
  allowed_security_group_id = module.ecs.service_security_group_id
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  multi_az                  = false
}

module "secrets" {
  source = "../../modules/secrets"

  project_name = var.project_name
  environment  = var.environment
  db_host      = module.database.database_endpoint
  db_port      = module.database.database_port
  db_name      = module.database.database_name
  db_username  = module.database.database_username
  db_password  = module.database.database_password
}

module "dns" {
  count = var.enable_https && var.dns_zone_name != "" && var.app_domain_name != "" ? 1 : 0

  source = "../../modules/dns"

  project_name = var.project_name
  environment  = var.environment
  zone_name    = var.dns_zone_name
  domain_name  = var.app_domain_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "alb" {
  source = "../../modules/alb"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  enable_https    = var.enable_https && var.dns_zone_name != "" && var.app_domain_name != ""
  certificate_arn = var.enable_https && var.dns_zone_name != "" && var.app_domain_name != "" ? try(module.dns[0].certificate_arn, null) : null
}

module "ecs" {
  source = "../../modules/ecs"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  log_group_name        = module.monitoring.ecs_log_group_name
  container_image       = "${module.ecr.repository_url}:latest"
  desired_count         = 1
  task_cpu              = 256
  task_memory           = 512
  container_environment = {
    APP_ENV              = "prod"
    DB_HOST              = module.database.database_endpoint
    DB_PORT              = tostring(module.database.database_port)
    DB_NAME              = module.database.database_name
    DB_USERNAME          = module.database.database_username
    DB_DRIVER_CLASS_NAME = "com.mysql.cj.jdbc.Driver"
    DB_URL               = "jdbc:mysql://${module.database.database_endpoint}:${module.database.database_port}/${module.database.database_name}?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
    SPRING_PROFILES      = "prod"
    SERVER_PORT          = "8080"
  }
  container_secrets = {
    DB_PASSWORD = "${module.secrets.database_secret_arn}:DB_PASSWORD::"
  }
}
