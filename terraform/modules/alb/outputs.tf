output "alb_dns_name" {
  description = "DNS name of the ALB."
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the ALB."
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "Target group ARN used by the ECS service."
  value       = aws_lb_target_group.this.arn
}

output "security_group_id" {
  description = "Security group attached to the ALB."
  value       = aws_security_group.alb.id
}
