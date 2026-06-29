variable "project_name" {
  description = "Prefijo usado para nombrar todos los recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se crean los Security Groups"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC"
  type        = string
}