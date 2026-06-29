output "eks_sg_id" {
  description = "ID del Security Group de los nodos EKS"
  value       = aws_security_group.eks.id
}

output "rds_sg_id" {
  description = "ID del Security Group de RDS"
  value       = aws_security_group.rds.id
}