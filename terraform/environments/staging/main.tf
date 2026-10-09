provider "aws" {
  region = "us-east-1"
}

# Staging reuses the same composition as prod so behavior stays aligned while keeping isolated networking.
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = "10.20.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b",
  ]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24",
  ]

  database_subnet_cidrs = [
    "10.20.21.0/24",
    "10.20.22.0/24",
  ]
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
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

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
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
}
