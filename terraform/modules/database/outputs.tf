output "database_endpoint" {
  description = "Hostname of the database instance."
  value       = aws_db_instance.this.address
}

output "database_port" {
  description = "Port number exposed by the database instance."
  value       = aws_db_instance.this.port
}

output "database_name" {
  description = "Name of the initial database."
  value       = aws_db_instance.this.db_name
}

output "database_username" {
  description = "Database master username."
  value       = aws_db_instance.this.username
}

output "database_password" {
  description = "Database master password."
  value       = random_password.db_password.result
  sensitive   = true
}

output "database_security_group_id" {
  description = "Security group controlling database access."
  value       = aws_security_group.database.id
}
