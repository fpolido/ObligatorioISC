output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "node_group_asg_name" {
  description = "Nombre del Auto Scaling Group del node group de EKS"
  value       = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name
}