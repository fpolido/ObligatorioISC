output "s3_logs_bucket_name" {
  description = "Nombre del bucket S3 donde se almacenan los logs"
  value       = aws_s3_bucket.logs.bucket
}

output "s3_logs_bucket_arn" {
  description = "ARN del bucket S3 de logs"
  value       = aws_s3_bucket.logs.arn
}

output "cloudwatch_log_group_eks" {
  description = "Nombre del Log Group de CloudWatch para el clúster EKS"
  value       = aws_cloudwatch_log_group.eks.name
}

output "cloudwatch_log_group_app" {
  description = "Nombre del Log Group de CloudWatch para la aplicación"
  value       = aws_cloudwatch_log_group.app.name
}

output "cloudtrail_name" {
  description = "Nombre del trail de CloudTrail"
  value       = aws_cloudtrail.main.name
}