variable "app_version" {
  description = "Versión de las imágenes de Online Boutique"
  type        = string
}

variable "db_host" {
  description = "Endpoint de RDS (para referencia futura)"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}