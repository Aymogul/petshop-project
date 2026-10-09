# Secrets Manager keeps the database credentials out of the task definition and out of Git history.
resource "aws_secretsmanager_secret" "database" {
  name        = "${var.project_name}-${var.environment}-db-credentials"
  description = "Database credentials for the application runtime"

  recovery_window_in_days = 0

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-credentials"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id
  secret_string = jsonencode({
    DB_HOST     = var.db_host
    DB_PORT     = tostring(var.db_port)
    DB_NAME     = var.db_name
    DB_USERNAME = var.db_username
    DB_PASSWORD = var.db_password
  })
}
