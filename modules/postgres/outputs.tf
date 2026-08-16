output "db_endpoint" {
  value = aws_db_instance.postgres.address
}

output "db_port" {
  value = aws_db_instance.postgres.port
}

output "secret_arn" {
  value = aws_secretsmanager_secret.database.arn
}