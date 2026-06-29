variable "aws_region" {
  description = "Región de AWS donde se despliega la infraestructura"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto, usado como prefijo en todos los recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad (mínimo 2 para alta disponibilidad)"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDRs de subnets públicas (una por AZ)"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDRs de subnets privadas (una por AZ)"
  type        = list(string)
}

variable "node_instance_type" {
  description = "Tipo de instancia EC2 para los nodos del cluster EKS"
  type        = string
}

variable "node_min_size" {
  description = "Mínimo de nodos en el node group"
  type        = number
}

variable "node_max_size" {
  description = "Máximo de nodos en el node group"
  type        = number
}

variable "node_desired_size" {
  description = "Cantidad deseada de nodos"
  type        = number
}

variable "app_version" {
  description = "Versión de las imágenes de Online Boutique a desplegar"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos RDS"
  type        = string
}

variable "db_username" {
  description = "Usuario administrador de RDS"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña del usuario administrador de RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Clase de instancia RDS"
  type        = string
}

variable "lab_role_arn" {
  description = "ARN del LabRole de AWS Academy"
  type        = string
}