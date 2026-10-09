resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = var.retention_in_days

  tags = {
    Name        = "/ecs/${var.project_name}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "alb" {
  name              = "/aws/applicationelb/${var.project_name}-${var.environment}"
  retention_in_days = var.retention_in_days

  tags = {
    Name        = "/aws/applicationelb/${var.project_name}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
