variable "project_name" {
  description = "Project name prefix for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name such as prod or staging."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ECS task security group and networking."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs where ECS tasks will run."
  type        = list(string)
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role."
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task IAM role."
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN attached to the ECS service."
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB security group ID allowed to reach the service."
  type        = string
}

variable "container_name" {
  description = "Name of the application container."
  type        = string
  default     = "app"
}

variable "container_image" {
  description = "Container image to deploy."
  type        = string
  default     = "public.ecr.aws/docker/library/nginx:latest"
}

variable "container_port" {
  description = "Port exposed by the container."
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "CPU units for the ECS task."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the ECS task in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of tasks."
  type        = number
  default     = 2
}

variable "aws_region" {
  description = "AWS region used for the log configuration."
  type        = string
  default     = "us-east-1"
}

variable "log_group_name" {
  description = "CloudWatch log group name used for the container."
  type        = string
  default     = "/ecs/petshop"
}
