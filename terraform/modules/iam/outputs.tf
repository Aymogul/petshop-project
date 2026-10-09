output "execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = aws_iam_role.ecs_task_execution.arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role."
  value       = aws_iam_role.ecs_task.arn
}

output "execution_role_name" {
  description = "Name of the ECS task execution role."
  value       = aws_iam_role.ecs_task_execution.name
}

output "task_role_name" {
  description = "Name of the ECS task role."
  value       = aws_iam_role.ecs_task.name
}

output "github_actions_role_arn" {
  description = "ARN of the GitHub OIDC deployment role, when GitHub OIDC is enabled."
  value       = var.enable_github_oidc && var.github_repository != "" ? aws_iam_role.github_actions_deploy[0].arn : null
}
