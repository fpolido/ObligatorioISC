output "rds_endpoint" {
  description = "Endpoint de conexión a RDS"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "rds_id" {
  value = aws_db_instance.main.id
}