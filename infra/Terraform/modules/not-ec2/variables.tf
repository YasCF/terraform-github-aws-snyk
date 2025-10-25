variable "ami" {
  description = "AMI ID para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "key_name" {
  description = "Nombre de la clave SSH"
  type        = string
}


variable "security_group_name" {
  description = "Nombre del grupo de seguridad"
  type        = string
}

variable "instance_name" {
  description = "Nombre para la instancia EC2"
  type        = string
}

variable "user_data" {
  description = "Script de configuración para la instancia EC2"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Entorno (e.g., dev, prod)"
  type        = string
}
variable "vpc_id" {
  description = "ID de la VPC para la instancia EC2"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred pública para la instancia EC2"
  type        = string
}
