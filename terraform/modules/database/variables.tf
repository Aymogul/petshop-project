variable "project_name" {
  description = "Project name used for database resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment such as prod or staging."
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the database subnets and security group."
  type        = string
}

variable "db_subnet_group_name" {
  description = "Subnet group name from the VPC module for the database."
  type        = string
}

variable "allowed_security_group_id" {
  description = "Security group ID that should be allowed to reach the database."
  type        = string
}

variable "database_name" {
  description = "Initial database name."
  type        = string
  default     = "petshop"
}

variable "username" {
  description = "Master username for the database."
  type        = string
  default     = "petshopadmin"
}

variable "engine" {
  description = "Database engine type."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version."
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance size for the database."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage allocated to the database in GB."
  type        = number
  default     = 20
}

variable "database_port" {
  description = "Port used by the database engine."
  type        = number
  default     = 3306
}

variable "multi_az" {
  description = "Enable multi-AZ for the database."
  type        = bool
  default     = false
}
