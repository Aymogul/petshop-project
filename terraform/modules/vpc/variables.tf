variable "project_name" {
  description = "Name of the project prefix to use in tagging and naming resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment name such as prod or staging."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones to deploy the VPC subnets into."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets used by ALB and NAT gateway."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of public subnet CIDRs must match the number of availability zones."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private app subnets used by ECS tasks and internal services."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of private subnet CIDRs must match the number of availability zones."
  }
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for isolated database subnets."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.database_subnet_cidrs) == 0 || length(var.database_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of database subnet CIDRs must be zero or equal to the number of availability zones."
  }
}
