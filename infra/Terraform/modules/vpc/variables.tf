variable "cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para las subredes públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "public_subnet_azs" {
  description = "Lista de zonas de disponibilidad para las subredes públicas"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidr" {
  description = "CIDR block para la subred privada"
  type        = string
}

variable "public_subnet_name" {
  description = "Nombre de la subred pública"
  type        = string
}

variable "private_subnet_name" {
  description = "Nombre de la subred privada"
  type        = string
}

variable "gateway_name" {
  description = "Nombre del Internet Gateway"
  type        = string
}

variable "route_table_name" {
  description = "Nombre de la tabla de rutas"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidad"
  type        = string
}
