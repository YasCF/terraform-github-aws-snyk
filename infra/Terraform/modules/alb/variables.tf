variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Nombre del grupo objetivo"
  type        = string
}

variable "target_port" {
  description = "Puerto del grupo objetivo"
  type        = number
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subredes para el ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los grupos de seguridad para el ALB"
  type        = list(string)
}

# variable "certificate_arn" {
#   description = "ARN del certificado ACM para HTTPS"
#   type        = string
#   default     = ""
# }
