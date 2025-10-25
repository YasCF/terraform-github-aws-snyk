variable "ec2_instance_id" {
  description = "ID de la instancia EC2"
  type        = string
}

variable "ec2_instance_name" {
  description = "Nombre de la instancia EC2"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN del tema SNS para notificaciones de alarmas"
  type        = string
}

variable "cpu_threshold" {
  description = "Umbral de uso de CPU para la instancia EC2"
  type        = number
  default     = 80
}

variable "network_out_threshold" {
  description = "Umbral de salida de red (bytes) para la instancia EC2"
  type        = number
  default     = 1000000
}

variable "network_in_threshold" {
  description = "Umbral de datos entrantes para la alarma (en bytes)"
  type        = number
  default     = 500000  # 500 KB
}