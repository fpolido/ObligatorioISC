output "cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "app_url" {
  description = "URL pública de la aplicación (DNS del Load Balancer)"
  value       = module.kubernetes.frontend_url
}

output "rds_endpoint" {
  description = "Endpoint de RDS (solo accesible dentro de la VPC)"
  value       = module.database.rds_endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.networking.vpc_id
}

output "configure_kubectl" {
  description = "Comando para configurar kubectl con el cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}