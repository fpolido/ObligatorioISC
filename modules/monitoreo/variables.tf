variable "project_name" {
  description = "Nombre del proyecto, usado para nombrar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (ej: dev, prod)"
  type        = string
  default     = "dev"
}

variable "eks_node_group_asg_name" {
  description = "Nombre del Auto Scaling Group del node group de EKS (para la alarma de CPU)"
  type        = string
}