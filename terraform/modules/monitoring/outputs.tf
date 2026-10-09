output "ecs_log_group_name" {
  description = "CloudWatch log group name used by the ECS service."
  value       = aws_cloudwatch_log_group.ecs.name
}

output "alb_log_group_name" {
  description = "CloudWatch log group name used by the ALB."
  value       = aws_cloudwatch_log_group.alb.name
}
