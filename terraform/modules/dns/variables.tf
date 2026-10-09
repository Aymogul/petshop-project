variable "project_name" {
  description = "Project name prefix used in resource names."
  type        = string
}

variable "environment" {
  description = "Environment name such as prod or staging."
  type        = string
}

variable "zone_name" {
  description = "Route53 hosted zone name, for example example.com."
  type        = string
}

variable "domain_name" {
  description = "Public hostname for the application, for example app.example.com."
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the application load balancer."
  type        = string
}

variable "alb_zone_id" {
  description = "Hosted zone ID of the application load balancer."
  type        = string
}
