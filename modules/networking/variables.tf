variable "project_name" {
  description = "Prefijo usado para nombrar todos los recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDRs para las subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDRs para las subnets privadas"
  type        = list(string)
}